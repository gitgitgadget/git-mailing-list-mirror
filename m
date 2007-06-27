From: Sam Vilain <samv@utsl.gen.nz>
Subject: post-update script to update wc - version 2
Date: Wed, 27 Jun 2007 14:05:18 +1200
Message-ID: <E1I3MuE-0005eO-00@www.watts.utsl.gen.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 04:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3MuM-00089P-Ss
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 04:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091AbXF0CFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 22:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbXF0CFZ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 22:05:25 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:34945 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbXF0CFY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 22:05:24 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 6619E1574C1; Wed, 27 Jun 2007 14:05:22 +1200 (NZST)
Received: from www.watts.utsl.gen.nz (www.magnus.utsl.gen.nz [192.168.253.11])
	by magnus.utsl.gen.nz (Postfix) with ESMTP id EBDB113A4F6
	for <git@vger.kernel.org>; Wed, 27 Jun 2007 14:05:18 +1200 (NZST)
Received: from samv by www.watts.utsl.gen.nz with local (Exim 3.36 #1 (Debian))
	id 1I3MuE-0005eO-00
	for <git@vger.kernel.org>; Wed, 27 Jun 2007 14:05:18 +1200
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51005>

#!/bin/sh
#
# An example hook script to prepare a packed repository for use over
# dumb transports.
#
# To enable this hook, make this file executable by "chmod +x post-update".

git-update-server-info

export GIT_DIR=`cd $GIT_DIR; pwd`
[ `expr "$GIT_DIR" : '.*/\.git'` = 0 ] && exit 0

tree_in_revlog() {
    ref=$1
    tree=$2
    found=$(
    tail logs/$ref | while read commit rubbish
    do
        this_tree=`git-cat-file commit $commit | awk '/^tree/ { print $2; exit }'`
	if [ "$this_tree" = "$tree" ]
        then
	    echo $commit
        fi
    done
    )
    [ -n "$found" ] && true
}

for ref
do
active=`git-symbolic-ref HEAD`
if [ "$ref" = "$active" ]
then
  echo "Pushing to checked out branch - updating working copy" >&2
  success=
  if ! (cd ..; git-diff-files) | grep -q .
  then
    # save the current index just in case
    current_tree=`git-write-tree`
    if tree_in_revlog $ref $current_tree
    then
      cd ..
      if git-diff-index -R --name-status HEAD >&2 &&
         git-diff-index -z --name-only --diff-filter=A HEAD | xargs -0r rm &&
         git-reset --hard HEAD
      then
         success=1
      else
        echo "E:unexpected error during update" >&2
      fi
    else
      echo "E:uncommitted, staged changes found" >&2
    fi
  else
    echo "E:unstaged changes found" >&2
  fi

  if [ -z "$success" ]
  then
    (
    echo "Non-bare repository checkout is not clean - not updating it"
    echo "However I AM going to update the index.  Any half-staged commit"
    echo "in that checkout will be thrown away, but on the bright side"
    echo "this is probably the least confusing thing for us to do and at"
    echo "least we're not throwing any files somebody has changed away"
    git-reset --mixed HEAD
    echo 
    echo "This is the new status of the upstream working copy:"
    git-status
    ) >&2
  fi
fi
done
