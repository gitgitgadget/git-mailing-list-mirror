From: Jozef Babjak <jozef.babjak@gmail.com>
Subject: Picking up multiple cherries at one go.
Date: Wed, 24 Mar 2010 09:47:41 +0100
Message-ID: <ffef8f9a1003240147o777d058jfacd79aa86908925@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 09:47:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuMFi-0001Vq-ER
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 09:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248Ab0CXIro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 04:47:44 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:35115 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab0CXIrn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 04:47:43 -0400
Received: by fxm23 with SMTP id 23so2833204fxm.1
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 01:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=EdPlzV5FevsW0w88KsRMfFoHS4MEk4ec33GnHWigUyo=;
        b=jRoXl1C6b+gpCbVBeiutVrZIp1we+Ij4Jc0IOlQVv4I3qGSaIgn9sMi5kEn4xkMDoC
         eIMDyMQ/l1RVfOJeskcu+xRXRhrnNtQM/WxGIUabXdU8eG/SmceSai1tR17fbcte6tm+
         wz/VLd9o23uE+eTmzpNIQ9pvD2QoMD0aX6cH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=UP1vnpNdGNRy582fuufmZyqXAQfC6tpT53fXdsZ6iwSiCipfz+oBCP2kS9ERIYBv69
         IaRvhqLWVicOtK5soqSWciuOWJc4tNe2tI/DxGRTE08E7T+JA7j+pS8Q3zsrNGbAKHdC
         KfjvpyZ+G9+IVx86fJqadii8FACODFpvheiMk=
Received: by 10.239.158.66 with SMTP id t2mr1013992hbc.184.1269420461602; Wed, 
	24 Mar 2010 01:47:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143075>

Hello all!

I'm a quite new git fellow, but I must to say that the git already
affected my development work significantly. I found out that almost
all imaginable tasks related to VCS are directly supported by git
out-of-the-box and all tools are very pragmatic. Great!

However, last days I needed to split a long multi-purpose branch into
several topic branches. The branch was created as a result of 'general
cleanup and refactoring', but at the end of day I realized that some
well-defined parts can be identified there and so I wanted to extract
them to dedicated branches. Thus, cherry-pick and rebase were my
friend for couple of days. Everything goes well, but there was a
repetitive task - cherry picking multiple commits. Sometimes the
process failed, because cherry picking led to conflicts. To simplify
this task, I wrote the shell script attached at the end of this
email.The script named git_cherries.sh reads commit IDs from stdin and
cherry-picks those commits to current branch. Everything is done on an
auxilliary branch, so the process is transactional - it succeed
completelly or it does not change anything. You can find more detailed
information at the beginning of te script.

Please try the script and feel free to use it, if you consider it to
be useful. It would be nice to have something similar in git suite.
Any feedback is appreciated.

Jozef Babjak


---- git_cherries.sh ---

#! /bin/sh

##
## This script cherry-picks more commits at one go. Commit IDs are read
## from standard input and applied to the current branch. Everything is
## done on auxilliary branch under the hood, so the change is done
## completely or it is not done at all. This is useful when refactoring
## a long multi-purpose branch into several separated branches.
##
## Usage [just an example, but you got the idea]:
##
##      git checkout master
##      git checkout -b new_topic
##      git log --pretty=oneline master..multi_topic_branch | \
##              tail -n 5 | cut -f 1 -d " " | tac | git_cherries.sh
##
## The commands above gets the last 5 commits from 'multi_topic_branch'
## and applies them to newly created 'new_topic' branch. Please note
## that tac(1) is used to reverse order of commits to applying them in
## proper order.
##
## Any additional command line arguments are without change passed to
## git-cherry-pick(1) command. This makes sense for -x, -r, -s and -n
## options.
##
## Program needs to be invoked only from root of a GIT repository.
##

if [ ! -d "./.git" ] ; then
        echo "This is not a root directory of any GIT repository: '`pwd`'"
        exit 1
fi

current_branch=`git branch | grep '*' | cut -f 2 -d " "`

tmp_branch="${current_branch}_cherrypicking_${$}"

##
## Auxilliary branch creation.
##
git checkout --quiet -b "${tmp_branch}"

##
## Applying cherry picks.
##
while read commit ; do
        git show --pretty=oneline "${commit}" | head -n 1
        git cherry-pick "${@}" "${commit}" > /dev/null 2>&1 ||
cherry_pick_failed="true"
        if [ ! -z "${cherry_pick_failed}" ] ; then
                break
        fi
done

##
## We are done with cherry picking now. If 'cherry_pick_failed' is
## set something went wrong and we cannot merge auxilliary branch.
##
if [ ! -z "${cherry_pick_failed}" ] ; then
        git reset --hard -q
fi

git checkout --quiet "${current_branch}"

if [ -z "${cherry_pick_failed}" ] ; then
        git merge "${tmp_branch}"
fi

##
## Success or not, delete auxilliary branch.
##
git branch -D "${tmp_branch}" > /dev/null

if [ -z "${cherry_pick_failed}" ] ; then
        echo "Done." 1>&2
        exit 0
else
        echo "Failed: ${commit}" 1>&2
        exit 1
fi
