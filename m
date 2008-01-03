From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git weird pulling issue
Date: Thu, 03 Jan 2008 09:51:25 -0800
Message-ID: <7v4pdusspu.fsf@gitster.siamese.dyndns.org>
References: <20080103121114.GE8046@cvg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Cyrill Gorcunov <gorcunov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 18:52:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAUEc-0007Jm-PV
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 18:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbYACRvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 12:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbYACRvg
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 12:51:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbYACRvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 12:51:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6210746F5;
	Thu,  3 Jan 2008 12:51:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DFB746F2;
	Thu,  3 Jan 2008 12:51:29 -0500 (EST)
In-Reply-To: <20080103121114.GE8046@cvg> (Cyrill Gorcunov's message of "Thu, 3
	Jan 2008 15:11:14 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69529>

Cyrill Gorcunov <gorcunov@gmail.com> writes:

> Hi git-list,
>
> i've a weird problem with pulling remote tree. look i've linus's tree
> as a base repo. then i've created x86 branch to which i pulled
> ingo's x86 tree. So all further pulling is made over this branch.
> And even having '--force' option at moment of pulling changes from
> Ingo's tree i've got something like that:
>
> ---
> cyrill@cvg linux-2.6-x86.git $ ./git-update.sh 
> Updating "x86"
> remote: Generating pack...
> remote: Done counting 15 objects.
> Result has 9 objects.
> remote: Deltifying 9 objects...
> remote: /9) done/9) done
> remote: Total 9 (delta 7), reused 3 (delta 1)
> Unpacking 9 objects...
>  100% (9/9) done
> Auto-merged include/asm-x86/msr.h
> CONFLICT (content): Merge conflict in include/asm-x86/msr.h
> Auto-merged include/linux/ptrace.h
> Auto-merged kernel/ptrace.c
> Automatic merge failed; fix conflicts and then commit the result.

To your readers, "./git-update.sh" is a mystery script; nobody
knows what you are doing in there.

A handful points that might help anybody who wants to be
helpful.

 * The state your repository is in is a bit vague.  Let me try
   to rephrase your introductory part and see if I understood
   your history.

    * It started as a clone from Linus's
      git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

    * You say you created x86 branch (local) to which you pull
      Ingo's (I do not see any tree other than scheduler ones
      under git/mingo/), but it is unclear what this branch's
      history looks like.

      Was it done by

      	git checkout -b x86
	git pull git://.../mingo/x86/ master

      If so, (1) was the initial x86 before the first pull
      pristine Linus tree? (2) was the initial x86 pull
      fast-forward?

 * I am suspecting that git-update.sh is a wrapper around
   git-pull that does something like:

    git checkout x86 &&
    git pull git://.../mingo/x86/ master

   Do you have remote tracking information for Ingo's
   repository?  If so how does it look like?

   Do you have your own changes in your x86 branch?  Do they
   conflict with Ingo's change, IOW, is the conflict above just
   a normal thing to expect?  What makes you think there should
   not be any conflict?

There are a few reasons I can think of that can cause conflicts.

 - (obvious) you have your own changes that the tree you are
   pulling from have colliding changes;

 * the tree you are pulling from has rebased;

The --force is about allowing git-fetch to update the remote
tracking branches (if you use them) even when the tracking
information is not fast-forward.  Without --force, the fetch
would refuse to operate (and because git-pull is git-fetch
followed by git-merge, the entire operation would fail and the
merge won't even happen --- hence you would not even see
conflicts).  But the option does not change the fact that what
you are going to merge has conflicting changes with the changes
in your current branch.  It merely allows git-fetch to forcibly
update the remote tracking information and git-pull to proceed
with the merges.

I am suspecting that (1) you have remote tracking information
(perhaps set up with "git remote add"); and (2) Ingo's tree
rebased between the time your last pull and this time.  If you
do not have any local commits on the branch, resetting to the
remote tracking branch you use to track Ingo's progress is an
option.  If you do, then fetching and rebasing instead of
pulling may make further development easier.  But I cannot
really tell.
