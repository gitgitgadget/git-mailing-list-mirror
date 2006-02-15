From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Wed, 15 Feb 2006 12:55:56 -0500
Message-ID: <20060215175556.GA5742@spearce.org>
References: <20060210195914.GA1350@spearce.org> <tnxy80fe2zo.fsf@arm.com> <20060214045618.GA12844@spearce.org> <b0943d9e0602150912h55fb87d0r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 18:56:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Qt6-00081r-2E
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 18:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWBOR4O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 12:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWBOR4O
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 12:56:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46722 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751191AbWBOR4A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 12:56:00 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1F9Qsa-0006PC-Qc; Wed, 15 Feb 2006 12:55:53 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id C794220FBA0; Wed, 15 Feb 2006 12:55:56 -0500 (EST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Mail-Followup-To: Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0602150912h55fb87d0r@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16251>

Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > pg resolves this by attempting to automatically fold patches during
> > a pg-rebase (equiv. of stg pull).  If a patch fails to push cleanly
> > and there's another patch immediately behind it which also should
> > be reapplied pg aborts and retries pushing the combination of the
> > patches.  This fixes my A+B case quite nicely during a rebase.  :-)
> 
> But what would happen if there was a third-party patch that's
> modifying the same line? A+B application would fail in this case. Does
> pg go back to only apply A and report a conflict?

When this occurs pg just gives up and leaves both patches A and
B unapplied and gives you the list of patches which it couldn't
apply but wanted to.  The working directory is left clean; its the
new base plus whatever patches before A that did apply cleanly.
I could have pg go back and try pushing A again and leave the
conflict ready for you to resolve but I don't always want that.
Since the user can have that happen with a quick no-arg `pg-push`
I leave it to the user to retry pushing A if they really think
that's worth trying.

However if the last patch fails to push during a pg-rebase then pg
leaves it alone and your working directory is dirty and you are left
with that last patch partially applied.  At which point you can back
it out by popping it off the stack or finish the conflict resolution.
 
> There is another problem with this approach if you have tens of
> patches. Would pg try to fold all of them?

Yea.  Which might not be pretty.  10 patches would cause pg to
attempt applying 11 patches before giving up, but each time the patch
is increased in size to include its predecessors who also didn't
apply cleanly.  As soon as a larger cluster applies pg goes back to
trying single patch application.  Obviously this could take a while
as the patch size is growing on each attempt and we are duplicating
work every time as pg always starts from a clean working directory.

Example: Say I have A, B, C, D, E, F on the stack.  A wasn't provided
by the upstream and pushes down cleanly.  B+C+D was given to me
by the upstream so pg first tries B, fails, then B+C, fails, then
B+C+D, succeeds, so it folds B+C+D into D and finishes pushing D.
Then it tries E, if E succeeds it tries F on its own.  If E fails it
tries E+F.  What's left in the working directory depends on if the
last operation was an auto-fold attempt or not and if it applied
cleanly (or not).

> Some time ago I had a look at Darcs and its patch theory (patch
> commuting). Their approach to conflicts was to include the conflicts
> in patch A and propagate them to the last patch to be merged. It's
> like creating two versions of the conflicting hunk, one of them
> corresponding to the local tree (that in patch A) and the other to the
> upstream tree. Merging patch B is only done in the local hunk in the
> end both conflicting hunks would be identical and one of them removed.
> 
> While the above algrithm seems to work OK in Darcs (but quite resource
> intensive), it's pretty hard to implement and I don't think it's worth
> for a small number of cases this could occur.

Hmm.  I had looked at Darcs over a year ago and found it to be a
rather interesting idea but at the time it couldn't handle my ~7000
file tree (and GIT wasn't even getting started yet).  I was actually
thinking about trying to drag the rejecting hunks forward somehow
when doing the auto-folding but I hadn't quite found a way to do
that easily.  I have a gut feeling that most of the time when this
problem occurs its on a subset of the files involved in any given
patch and that if I can push down a patch cleanly for 90+% of the
files while delaying the conflicts forward that might actually be
somewhat reasonable.  But maybe not.  :-)

-- 
Shawn.
