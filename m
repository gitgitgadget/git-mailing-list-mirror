From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: resolve (merge) problems
Date: Thu, 1 Dec 2005 17:44:23 -0800 (PST)
Message-ID: <20051202014423.56174.qmail@web31801.mail.mud.yahoo.com>
References: <Pine.LNX.4.64.0512011556480.3099@g5.osdl.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 02:45:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhzyN-0003U3-PJ
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 02:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbVLBBoZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 20:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbVLBBoY
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 20:44:24 -0500
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:28337 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932702AbVLBBoY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 20:44:24 -0500
Received: (qmail 56176 invoked by uid 60001); 2 Dec 2005 01:44:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=e/7kt3ht52p2EazrOsl4Lods1hLAajXxUqECKOCQTpL5TZ6hxj+Vh3KSY3UvAWZczSAHrRtvSk1/asnd8z/si1mVFMotCXGjsR/Qr1wuRhIuS8y3Szh8byqn6Jmev94bM8AvrGalgU32KBMf2BbE7OeUx3A2K/yF+ulkwECtjgY=  ;
Received: from [68.221.13.176] by web31801.mail.mud.yahoo.com via HTTP; Thu, 01 Dec 2005 17:44:23 PST
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512011556480.3099@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13096>

--- Linus Torvalds <torvalds@osdl.org> wrote:
> Well, first off, you would probably have been better off with the smarter 
> recursive merge instead of the old "git resolve":
> 
> 	git merge -s recursive "merge linus' tree" HEAD master
> 
> (the "-s recursive" isn't really needed, it _should_ be the default).
> 
> You can re-try that by doing a "git reset --hard" (to get rid of the 
> partial merge) and just starting over.

Ok, what I've been doing is:
git-read-tree --reset -u <last committish>
git-checkout-index -u -f -a

to "roll-back" the index to the last "good" state.
(but I guess that has the same effect)

Then I re-tried the new git merge, and got this:

$git merge -s recursive "merge linus' tree" HEAD master 
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Traceback (most recent call last):
  File "/home/luben/bin/git-merge-recursive", line 10, in ?
    from heapq import heappush, heappop
ImportError: No module named heapq
Automatic merge failed/prevented; fix up by hand

The git I have is latest: b34403aa97047f90c0cdd5177e63a8e7530e3388

> > The output from git-diff-index is:
> 
> Don't. You'll see all the changes relative to HEAD, which _includes_ all 
> the stuff that got cleanly merged.
> 
> Instead, do just a
> 
> 	git diff
> 
> or perhaps
> 
> 	git-diff-files --name-status
> 
> which will show much better what is going on. In this case, I suspect that 
> the problem is that my branch removed "poodle_defconfig", and you had 
> changes in it, no? Or maybe there were conflicts in atmdev_init.c, so they 
> got left in an unmerged state..

The former.  Simple deletion.  I've noticed that
I've those problems only when the file has been completely
deleted in the tree I'm trying to merge (from).

The index is left in a state where the file doesn't
exist in the working tree but is in the index.

Not sure if this is a general problem.  I'd like to
note though that the branches are in _different_ directories, (different index and HEAD of
course),
but everything else is shared (symlinks).

> 
> Regardless, the git-diff-files interface should show you which files are 
> unmerged and need to be fixed up.
> 
> Just fix them up: either remove them, or edit them to taste, and then do 
> "git-update-index <filename>" (add the "--remove" option if you deleted 
> the file), and then finish it off when you're happy with a "git commit".
> 
> That _should_ fix it all up.

Ok, that worked.  The sequence I did is:

$git reset --hard
$git resolve HEAD master "merge linus' tree"
Trying to merge deda498710e190c7922c2634ed630ee64ce86c05 into
6fea38404a5ce270d73df9cde561135defe9ab39 using 5666c0947ede0432ba5148570aa66ffb9febff5b.
Simple merge failed, trying Automatic merge
Auto-merging MAINTAINERS.
Removing drivers/net/sk98lin/skcsum.c
fatal: merge program failed
Automatic merge failed, fix up by hand
$git-diff-files --name-status
U       drivers/net/sk98lin/skcsum.c
D       drivers/net/sk98lin/skcsum.c
$git-update-index --remove drivers/net/sk98lin/skcsum.c
$git commit -s "merge linus' tree"

And that worked.  But at some point it did the right
thing only with "git resolve ..."  What has changed?

Thanks,
   Luben
