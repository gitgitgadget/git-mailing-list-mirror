From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Mon, 13 Feb 2006 23:56:18 -0500
Message-ID: <20060214045618.GA12844@spearce.org>
References: <20060210195914.GA1350@spearce.org> <tnxy80fe2zo.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Feb 14 05:56:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8sEk-0005VQ-7y
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 05:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWBNE4X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 23:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWBNE4X
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 23:56:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:64723 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1030353AbWBNE4W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 23:56:22 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1F8sES-00069P-MX; Mon, 13 Feb 2006 23:56:08 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id AC3ED20FBA0; Mon, 13 Feb 2006 23:56:18 -0500 (EST)
To: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
Mail-Followup-To: Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <tnxy80fe2zo.fsf@arm.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16110>

Catalin Marinas <catalin.marinas@arm.com> wrote:
> Without much testing, I think pg is a good tool but it is different
> from StGIT in many ways. It mainly resembles the topic branches way of
> working with the advantage of having them stacked on each-other. Each
> patch seems to be equivalent to a topic branch where you can commit
> changes. Rebasing a patch is equivalent to a merge in a branch with
> the merge commit having a general description like "Refreshed patch
> ..." and two parents - the new base and the old top.

Yes, exactly.
 
> While I don't say the above is a bad thing, it is pretty different
> from StGIT. With StGIT, the history of the tree only shows one commit
> per patch with the patch description chosen by the user. If you edit
> the description or modify the patch, the old patch or description is
> dropped from the main branch (visible via HEAD) and you only get the
> latest one. This clean history has many advantages when sending
> patches upstream either via e-mail or by asking for a pull.

Yes.  I didn't intend on exporting the entire patch history for
delivery upstream; I only intended on exporting the batch between
its base and last markers, which amounts to giving a single diff
such as what StGIT would generate.  But I had planned on pulling
the commit comments from all history into the header of the patch
during export, I just haven't gotten there yet.
 
> > - Preserves change history of patches.
> >
> >     The complete change history associated with each patch is
> >     maintained directly within GIT.  By storing the evolution of a
> >     patch as a sequence of GIT commits standard GIT history tools
> >     such as gitk can be used.
> 
> There have been discussions to adding this to StGIT as well (and there
> is a patch already from Chuck). It is a good thing to have but I'm
> opposed to the idea of having the history accessible from the top of
> the patch. Since the patch can be refreshed indefinitely, it would
> make the main history (visible from HEAD) really ugly and also cause
> problems with people pulling from a tree. I prefer to have a separate
> command (like 'stg id patch/log') that gives access to the history.

I definately agree.  I have been rather unhappy with the log
structure that pg is giving me when I flip patches around on the
stack.  So I'm certainly considering keeping the history of the
patch in a parallel tree stored within the same object and refs
database but I haven't really figured out how this could work.
 
> > - Its prune proof.
> >
> >     The metadata structure is stored entirely within the refs
> >     directory and the object database, which means you can safely use
> >     git-prune without damaging your work, even for unapplied
> >     patches.
> 
> That's missing indeed in StGIT but it will be available in the next
> release. I didn't push this yet because I wasn't sure what to do with
> the refresh history of a patch.

I see you actually already pushed out a change for this for StGIT.
That's good news.  :-) I noticed the solution StGIT used is close to
pg's, except that StGIT has the simplified single-commit-per-patch
model so its less refs than pg.

> > - Automatic detection (and cancellation) of returning patches.
> >
> >     pg automatically detects when a patch is received from
> >     the upstream GIT repository during a pg-rebase and deletes
> >     (cancels) the local version of the patch from the patch series.
> >     The automatic cancelling makes it easy to use pg to track and
> >     develop changes on top of a GIT project.
> 
> StGIT has been doing this from the beginning. You would need to run a
> 'stg clean' after a rebase (or push). I prefer to run this command
> manually so that 'stg series -e' would show the empty patches and let
> me decided what to do with them.

Actually StGIT didn't do this correctly for one of my use cases
and that's one of the things that drove me to trying to write pg
(because I wondered if there was a way to resolve it automatically).
Try building a patch series such as:

	... start with an empty stack ...

	... create patch A ...
	... edit file hello.c ...
	... refresh patch A ...

	... create patch B ...
	... edit file hello.c (same line region as patch A) ...
	... refresh patch B ...

	... generate patch A+B (as one patch!) ...
	... send A+B upstream ...

	... pull upstream down ...

StGIT seemed to not handle this when it tried to reapply the two
already applied patches.  A won't apply because the file coming
down is actually A+B, not A's predecessor and not A.  B won't apply
because the file also isn't A (B's predecessor).

pg resolves this by attempting to automatically fold patches during
a pg-rebase (equiv. of stg pull).  If a patch fails to push cleanly
and there's another patch immediately behind it which also should
be reapplied pg aborts and retries pushing the combination of the
patches.  This fixes my A+B case quite nicely during a rebase.  :-)

Of course it doesn't deal with the upstream giving me A+B+C and I
have only A+B locally in my patches.  But I can't have everything
now can I.  :-)
 
> > - Fast
> >
> >     pg operations generally perform faster than StGIT operations,
> >     at least on my large (~7000 file) repositories.
> 
> Might be possible but I haven't done any tests. There are some
> optimisations in StGIT that make it pretty fast: (1) if the base of
> the patch has not changed, it can fast-forward the pushed patches
> which is O(1) and (2) StGIT first tries to use git-apply when pushing
> a patch and use a three-way merge only if this fails (the operation
> usually succeeds for most of the patches). There are some speed
> problems with three-way merging if there are many file
> removals/additions because the external merge tool is called for each
> of them but the same problem exists for any other tool.

pg uses the same optimization for pushing and popping patches. It
also has a special case for the trivially empty patch which StGIT
doesn't seem to have (as StGIT must have a commit for every patch,
pg doesn't require a commit in an empty patch).

However one thing I'm playing around with is using git-read-tree -u
-m to rebase a patch rather than git-diff-tree piped to git-apply
(at least when its not a trivial forward or rewind).  I found that
most of the time to push a patch was spent in git-diff-tree and
hardly anytime was in git-apply.  Using git-read-tree to merge in the
change works nicely in the common case of different patches changing
different files with it falling back to the external merge strategy
when there's unmerged stages in the index.  The open question is
what percentage is this one way or the other?

So I think StGIT is causing a bit more CPU and disk IO than pg is,
but some of these `optimizations' were only put into pg today (and
pushed to my website around 5 pm EST).  I'm actually considering
benchmarking StGIT and pg against the same set of changes to see
how pg compares to StGIT - because I'm now rather curious if pg is
better or worse.


Another difference is the fast-forward when the base of the patch
isn't changed.  In pg this is just:

	git-update-ref HEAD $last $head &&
	git-read-tree -u -m $head $last

which should be slightly faster than StGIT as pg is skipping the
update-index step:

	git-update-index -q --unmerged --refresh
	git-read-tree -u -m head patch
	git-update-ref HEAD patch head

because like StGIT I check for a clean tree before starting the
push; a tree is only clean if the index doesn't need to be refreshed
(plus all the other normal considerations like no unmerged files).
This drops a working directory scan before the read-tree.  :-)

-- 
Shawn.
