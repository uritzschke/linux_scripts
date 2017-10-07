#!/bin/bash
#
# Small script to check if Owncloud is currently running or in maintanence mode.
# To be used with Monit (https://mmonit.com/)
#
# Requires jq JSON processor
#
#
# Monit-Entry:
#
# check program owncloud with path /etc/monit/check_owncloud.sh
#  if status != 0 then alert
#
#


STATUS=`curl -s 'SERVER-URL/owncloud/status.php' | jq -r '.maintenance'`

if [ "$STATUS" == "false" ]
then
  echo "Owncloud running"
  exit 0
elif [ "$STATUS" == "true" ]
then
  echo "Owncloud in MAINTENANCE MODE"
  exit 1
else
  echo "Owncloud NOT RUNNING"
  exit 2
fi
