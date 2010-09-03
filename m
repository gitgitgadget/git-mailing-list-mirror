From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: simple example for git hooks
Date: Fri, 3 Sep 2010 15:37:00 -0500
Message-ID: <i5rmb2$q4n$1@dough.gmane.org>
References: <i5p96s$u7q$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 03 22:38:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ord1e-0001hF-Lr
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 22:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756348Ab0ICUiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 16:38:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:40106 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754039Ab0ICUiF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 16:38:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ord1P-0001Xl-FM
	for git@vger.kernel.org; Fri, 03 Sep 2010 22:38:03 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 22:38:03 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 22:38:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155271>

"Gelonida" <gelonida@gmail.com> wrote in message 
news:<i5p96s$u7q$1@dough.gmane.org>...

> Does anyone have a simple example of a git pre-commit hook

>

> I have difficulties finding understandable tutorals about git hooks.

>

> What I am looking at is basic examples about

>

> precommit hooks

> ================

>

> - how get the commit comment and check it's contents



I think there is a special hook for this besides the pre-commit hook. 
Haven't tried it myself, yet.  Look at githooks manpage in the reference 
manual.



> - how to get list of modified files



I use this script to get modified files:



ABORTMSG="Commit Aborted!"

DIFFFILES=`git diff-index HEAD --cached --name-only SRC/*/* MYSRC/*` if [ 
$? -ne 0 ]; then

  echo "error running git diff-index command"

  echo $ABORTMSG

  exit 4

fi



Where SRC and MYSRC are the paths that contain the files I'm interested in. 
If you really want to list every thing that changed then don't specify 
paths.



>

> The issue I'm currently blocked with is rather simple.

>

> I'd like to get a list aof all

> new or modified file names, such, that I can check, that for  example

> all .h files contain a project specific header.

>



I use this script to check the header:



for FILES in ${DIFFFILES}

  do

  echo "checking header for keywords in working copy of:${FILES}"

  if [ ! -r ${FILES} ]; then

    echo "${FILES} needs read permission"

    echo $ABORTMSG

    exit 6

  fi

  CHKHEADER=$(/usr/bin/head -n 2 ${FILES} | /bin/egrep -c 'somekeyword')

  if [ ${CHKHEADER} -ne 1 ]; then

    echo "line 1 or 2 needs those special keywords in it:${FILES}"

    echo $ABORTMSG

    exit 7

  fi

  done



THIS IS BASED ON THE ASSUMPTION THAT YOUR WORKING COPY AND INDEX ENTRY ARE 
SUPPOSED TO MATCH!  Its based on a workflow in which you commit your current 
work.  I you want to be able to git-add a file to the index and then modify 
the file again and then only commit what's in the index while retaining a 
working copy that differs from the index, THEN THIS SCRIPT WON'T WORK.



> As soon as I have the file names I should be able to proceed.

>

> How could I do this best from a shell script.

>

> Is there any clear documentation about hich git commands I'm allowed

> to use during a trigger script and which ones I can't

>



Keep in mind that git hooks don't allow you to prompt the user in your 
script.  However, the exception may be git commands that prompt the user. 
Haven't tried that combination myself yet...



> Lateron I would be interested to implement a small server script, that

> refuses a git push in case, that the most recent commit in a branch

> would contain .h files without a certain header text

>



Your pre-commit hook will prevent this because you can only push commits. 
Unless you don't have control over what hooks the push-er is using in their 
repo...  In which case there is a hook that checks push-ed content before 
committing it and will reject it if need be.  Can't remember what it is 
offhand.  Look at the githooks refmanual entry 
http://www.kernel.org/pub/software/scm/git/docs/v1.7.1.2/githooks.html for 
whatever git version you're using and you should be able to find it.  These 
scripts would probably work in that remote-side hook.



v/r,

Neal
