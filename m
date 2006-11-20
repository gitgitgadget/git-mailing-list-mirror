X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: tracking many cvs/svn/git remote archives
Date: 20 Nov 2006 09:18:05 -0800
Message-ID: <86y7q6m3zm.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 17:18:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.14.17; tzolkin = 4 Caban; haab = 10 Ceh
Original-Lines: 77
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31924>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmCn1-0002QI-Su for gcvg-git@gmane.org; Mon, 20 Nov
 2006 18:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966225AbWKTRSJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 12:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966231AbWKTRSJ
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 12:18:09 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:35357 "EHLO
 blue.stonehenge.com") by vger.kernel.org with ESMTP id S966225AbWKTRSI (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 12:18:08 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 7927C8FF16 for <git@vger.kernel.org>; Mon, 20 Nov
 2006 09:18:06 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 04932-01-38 for <git@vger.kernel.org>; Mon, 20 Nov 2006 09:18:05 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id EE7698FF1B;
 Mon, 20 Nov 2006 09:18:05 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Now that git-cvsimport and git-svn are mature, I'll share my script which I
call "get.cvs" to track a number of remote archives.  It's not extremely
general, but maybe it'll inspire someone else to generalize it.

I have ~/MIRROR/foo-GITSVN tracking a remote archive using git-svn, so
the name of the directory reflects the tracking mechanism.  There's also
*-CVS, *-SVN, *-GIT, and *-GITCVS.

For *-GITCVS, I have to keep the args for git-cvsimport around, so I
store that in the respository under getcvs.gitcvsargs.

For *-GITSVN, I have to force the head/origin to softlink to the proper remote
svn reference.

The *-GIT* merges are safe, because they won't pull over any uncommited
entries, but they *will* merge into whatever the current branch is.  This
keeps any checked out tree trivially up to date, which is mostly what I'm
watching anyway.

Setting up *-GIT* generally requires checking out a master branch to really
track the files... I think I did this with "git-checkout -b master origin".

#!/bin/sh

cd && cd MIRROR || exit 1

case $# in
    0) set -- '*';;
esac

eval set -- "$@"

trap ':' 2
for i in "$@"
do (
        trap - 2
        cd $i || exit
        echo == $i ==
        case $i in
            *-CVS) cvs -q update;;
            *-SVN) svn update;;
            *-GIT*)
                ## first, update "origin":
                case $i in
                    *-GIT)
                        git-fetch
                        ;;
                    *-GITCVS)
                        git-cvsimport -k -i $(git-repo-config getcvs.gitcvsargs)
                        ;;
                    *-GITSVN)
                        ## be sure to have origin "ref: refs/remotes/git-svn"
                        git-svn multi-fetch
                        ;;
                esac
                if git-status | grep -v 'nothing to commit'
                then echo UPDATE SKIPPED
                else
                    if git-pull . origin | egrep -v 'up-to-date'
                    then
                        git log --no-merges ORIG_HEAD.. | git shortlog
                    fi
                fi
                ;;
            *)
                echo "[ignoring]";;
        esac
        )
done


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
