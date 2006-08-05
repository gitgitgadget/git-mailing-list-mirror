From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC][PATCH] Branch history
Date: Fri, 4 Aug 2006 23:18:21 -0400
Message-ID: <20060805031821.GB18223@spearce.org>
References: <m1mzakpam8.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 05:18:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9CgG-0006NY-QP
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 05:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422723AbWHEDS0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 23:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422724AbWHEDS0
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 23:18:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:61117 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1422723AbWHEDSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 23:18:25 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G9Cfz-00064a-FE; Fri, 04 Aug 2006 23:18:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C163E20FB77; Fri,  4 Aug 2006 23:18:21 -0400 (EDT)
To: "Eric W. Biederman" <ebiederm@xmission.com>
Content-Disposition: inline
In-Reply-To: <m1mzakpam8.fsf@ebiederm.dsl.xmission.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24876>

"Eric W. Biederman" <ebiederm@xmission.com> wrote:
> 
> The problem:
> git-rebase, stgit and the like destructively edit the commit history
> on a branch.  Making it a challenge to go back to a known good point.
> 
> revlog and the like sort of help this but they don't address the
> issues that they capture irrelevant points and are not git-prune safe.

How are the points irrelevant?  Each commit/rebase/am/update-ref
is recorded.  That's each change to the branch head.  It appears
as though you are mainly interested in tracking across rebases,
which a reflog would do, assuming you filtered the events down to
only those caused by rebase and ignored the others.

But yea, a reflog is not prune-safe, but it wouldn't be hard to
modify git-prune to also consider the reflog associated with
a ref if its using that ref as a root that must be preserved.
Assuming anyone really wants that as a feature...
 
> After thinking about the problem some more I believe I have found
> a rather simple solution to the problem of keeping branch history.
> 
> For each branch you want to keep the history of keep 2 branches.
> A normal working branch, and a second archive branch that records
> the history of the branch you are editing.

It would appear as though you are really only tracking rebase events,
as everything else done on the branch is preserved since the work
branch is itself parent #1 for the archive branch commit.  So the
archive branch shows every commit ever done along the main branch,
but also shows itself joining back quite frequently.  Further if you
archive away the work branch without during a rebase since the last
archive then there's really nothing happening except saving a tag
(but as a commit!) on the archive branch.

This creates for a rather messy history, and is more-or-less what
pg does when patches get pushed onto a stack and they can't be
pushed by a simple fast-forward operation.  Reading this history
in gitk is "interesting" at best.  This is the main reason I've
been trying to write `tb` (a topic branch manager, fashioned after
Junio's TO script) but I can't seem to find enough time to get it
finished.

> The neat thing is that it gives an immutable history of a branch that
> is actively being edited.  So if you export your archive branch people
> will never see time roll backward.

Right.  That's an interesting way of handling it, but that branch
is also quite messy as its full of merge commits.  Although it may
be useful to export its going to carry along with it all of the bad
edits and prior rebases made on that branch.  You probably wouldn't
want to merge that branch into a mainline, which means that branch
is likely to be discarded at some point in the future.  When that
happens then nobody can track it anymore and that immutable history
just got mutated out of existance.

I think the right way to deal with these types of branches is to
publicly publish whether or not the branch is going to be expected
to roll backwards in time (due to a rebase type of event) then
let clients always update those branches during pulls, rather
than needing to explicitly mark them with '+' on the client side.

Further good remege tools (git-rerere on steriods) would help
re-resolve conflicts resulting from continous rebasing.  This would
make it easier to maintain such a branch and carry the thing forward;
or to leave it on its original base but to continously remerge
it and the current mainline into a temporary working branch for
testing purposes.

This is largely the policy that Junio uses for the `pu` and
the `next` branches, as well as for the topic branches that he
carries for everyone else doing GIT development.  It appears to be
working rather well, but it certainly could be streamlined better.
My git-rerere2 and tb tools are an attempt to do this, but sadly
they aren't in a useful state yet.  Maybe because they are both
far more complex then what you are doing here.  :-)


Nonethless it is an interesting contribution.  Thank you for taking
the time to send it.

-- 
Shawn.
