#!/usr/bin/env sh

for row in $(cat ./json/remote-repos.json | jq -r '.[] | @base64'); do
    _jq() {
      echo ${row} | base64 --decode | jq -r ${1}
    }
    #echo $(_jq '.key')
    jf rt repo-create ./json/template-remote-rescue.json --vars "repo-name=$(_jq '.key');package-type=$(_jq '.packageType');repo-type=$(_jq '.rclass');url=$(_jq '.url');repo-layout=$(_jq '.repoLayoutRef');xray-enable=$(_jq '.xrayIndex')"
done