From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] rebase -i: avoid checking out $branch when possible
Date: Fri, 18 May 2012 10:27:53 +0200
Message-ID: <87obplhp12.fsf@thomas.inf.ethz.ch>
References: <fee3225e29915e1b61e29a5d2fe37db20fa4b596.1334933837.git.trast@student.ethz.ch>
	<xmqqwr5atn89.fsf@junio.mtv.corp.google.com>
	<87lilqjstf.fsf@thomas.inf.ethz.ch>
	<xmqqmx66mamc.fsf@junio.mtv.corp.google.com>
	<CANMpiOQPefL_FNocLJ=pZyAb1hZ7bEvLk6frU3xme6VQrSDD2A@mail.gmail.com>
	<7vwr4de5j8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Shezan Baig <shezbaig.wk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 18 10:29:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVIYZ-0005Mi-V2
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 10:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762254Ab2ERI2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 04:28:32 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:20960 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761613Ab2ERI16 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 04:27:58 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 18 May
 2012 10:27:56 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (217.235.93.211) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 18 May
 2012 10:27:56 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [217.235.93.211]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197942>

Junio C Hamano <gitster@pobox.com> writes:

> Shezan Baig <shezbaig.wk@gmail.com> writes:
>
>> Just wondering if this patch is going to be available in an upcoming
>> version of git?
>
> As we can see from the exchange you quoted, I do not think we have nailed
> the details of desired behaviour in the updated code down.
>
> Thomas, how would you want to proceed?

Hrm.  You wrote:

> The discrepancy in the "abort" case may come only in the three cases:
> 
>  - EDITOR is pointing at something funny, [let's do the checkout to be
>    safe for scripts]

Agreed.

>  - The user told us not to do the rebase by making insn sheet empty.  In
>    other words, this is "aborting the entire rebase", so ideally it
>    should come back to the state before the user ran "git rebase"
>    command (i.e. where she was before we switched to <branch>).
> 
>    I do not think this ideal behaviour is something neither batch or
>    interactive rebase has traditionally implemented, but I can see how
>    we can sell this as a bugfix to the end users.

That's a convincing argument, so let's make it so.

>  - It turns out that everything is already contained and there is
>    nothing to apply, i.e. after this sequence:
> 
> 	git checkout branch
> 	git checkout $onto_or_merge_base_between_base_and_branch
> 
>    we find out that "git cherry $onto_or_merge_base branch" is empty.

Is there a command missing here?  This alone does not make them the
same, perhaps you meant some resetting.

I'll assume that you meant a case where the user is *not* on branch, but
base/onto is an ancestor of the branch, e.g., in a sequence

  git checkout base
  git reset --hard branch~5
  # now branch..base is empty
  git rebase base branch

the rebase will not do anything unless forced.  Similarly for the case
where base==branch.  And then

>    Because you will be one commit ahead of $onto_or_merge_base if "git
>    cherry" were to give one commit to be replayed, I think it is
>    logically correct if you stayed at the $onto_or_merge_base without
>    checking out <branch>.  In other words, abort-with-checkout is not
>    ideal for this case; we would want to just abort in this case.

This would be hard to sell, because a script that runs

  git rebase base branch

could reasonably assume that after the rebase, the current branch is
'branch', unless some error occurred.  And we'd be breaking that.

Or am I missing the point of your reasoning?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
