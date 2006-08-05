From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH] Branch history
Date: Sat, 05 Aug 2006 03:30:28 -0600
Message-ID: <m1slkbmswb.fsf@ebiederm.dsl.xmission.com>
References: <m1mzakpam8.fsf@ebiederm.dsl.xmission.com>
	<20060805031821.GB18223@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 11:31:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9IVU-00057l-16
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 11:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422780AbWHEJbk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 05:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422784AbWHEJbk
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 05:31:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27801 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422780AbWHEJbj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 05:31:39 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Debian-1) with ESMTP id k759UVlH003964;
	Sat, 5 Aug 2006 03:30:31 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Submit) id k759UUft003963;
	Sat, 5 Aug 2006 03:30:30 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060805031821.GB18223@spearce.org> (Shawn Pearce's message of
	"Fri, 4 Aug 2006 23:18:21 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24895>

Shawn Pearce <spearce@spearce.org> writes:

> "Eric W. Biederman" <ebiederm@xmission.com> wrote:
>> 
>> The problem:
>> git-rebase, stgit and the like destructively edit the commit history
>> on a branch.  Making it a challenge to go back to a known good point.
>> 
>> revlog and the like sort of help this but they don't address the
>> issues that they capture irrelevant points and are not git-prune safe.
>
> How are the points irrelevant?  Each commit/rebase/am/update-ref
> is recorded.  That's each change to the branch head.  It appears
> as though you are mainly interested in tracking across rebases,
> which a reflog would do, assuming you filtered the events down to
> only those caused by rebase and ignored the others.

It tracks each change, it does not track the changes that humans find
interesting.  That can easily be a lot of noise.

I don't want to see every time a head is updated any more than I want
single keystroke level version control.  Way too much uninteresting
detail.

> But yea, a reflog is not prune-safe, but it wouldn't be hard to
> modify git-prune to also consider the reflog associated with
> a ref if its using that ref as a root that must be preserved.
> Assuming anyone really wants that as a feature...

I do.  I also want history I can clone between repositories.
I have times I have had to look 9 months back to see where I accidentally
dropped a patch.

>> After thinking about the problem some more I believe I have found
>> a rather simple solution to the problem of keeping branch history.
>> 
>> For each branch you want to keep the history of keep 2 branches.
>> A normal working branch, and a second archive branch that records
>> the history of the branch you are editing.
>
> It would appear as though you are really only tracking rebase events,
> as everything else done on the branch is preserved since the work
> branch is itself parent #1 for the archive branch commit.  So the
> archive branch shows every commit ever done along the main branch,
> but also shows itself joining back quite frequently.  Further if you
> archive away the work branch without during a rebase since the last
> archive then there's really nothing happening except saving a tag
> (but as a commit!) on the archive branch.

True.  But that is largely the wrong way to think about it.  I am
saving away a branch at times it is interesting to a human being.
There are also other tools and other methods of editing a branch
besides git-rebase.

> This creates for a rather messy history, and is more-or-less what
> pg does when patches get pushed onto a stack and they can't be
> pushed by a simple fast-forward operation.  Reading this history
> in gitk is "interesting" at best.  This is the main reason I've
> been trying to write `tb` (a topic branch manager, fashioned after
> Junio's TO script) but I can't seem to find enough time to get it
> finished.

I just took a quick look at pg, and while the mechanism may be
similar I believe the goals are fundamentally different.  I am
trying to record the history at points human beings care about,
pg seems to do something automatically behind the scenes, with
the existing model.

The points I am recording the history are points at which I want a
human commit message, because these are points in time meaningful to
me.  The ideal companion would be something that could just walk my
branch history and pull it out.  So when generating an overview
message I could easily generate a summary of how I had been editing my
patches.


>> The neat thing is that it gives an immutable history of a branch that
>> is actively being edited.  So if you export your archive branch people
>> will never see time roll backward.
>
> Right.  That's an interesting way of handling it, but that branch
> is also quite messy as its full of merge commits.  Although it may
> be useful to export its going to carry along with it all of the bad
> edits and prior rebases made on that branch.  You probably wouldn't
> want to merge that branch into a mainline, which means that branch
> is likely to be discarded at some point in the future.  When that
> happens then nobody can track it anymore and that immutable history
> just got mutated out of existance.

Yes.  But it is interesting until it gets merged into mainline, and
keeping around in the developers own archives.  Mistakes can be
interesting.  I don't expect that there will be a need for keeping
the mistakes after a branch is perfected and merged into mainline.
Until the branch is perfected though I fully expect there to be bad
branch history edits that need to be fixed.

The point at which the immutable history goes out of existence is
the point where the branch stops being interesting as an entity
in it's own right.  So I think that is exactly the right behavior.

> I think the right way to deal with these types of branches is to
> publicly publish whether or not the branch is going to be expected
> to roll backwards in time (due to a rebase type of event) then
> let clients always update those branches during pulls, rather
> than needing to explicitly mark them with '+' on the client side.

Not if part of the problem is distributing the work of coming up
with a perfect patch set.  If you don't distribute the history
it is hard to see what someone has really changed.  You can't help
me undo a branch editing mistake if you don't have the previous
version of the branch.  It is hard to verify I actually fixed what
you are concerned about if you don't have the old version to compare
against.

> Further good remege tools (git-rerere on steriods) would help
> re-resolve conflicts resulting from continous rebasing.  This would
> make it easier to maintain such a branch and carry the thing forward;
> or to leave it on its original base but to continously remerge
> it and the current mainline into a temporary working branch for
> testing purposes.

Rebase is not the primary operation.  I have one basic branch that
I have 10 copies of against v2.6.18-rc3.  Refactoring, debugging,
and perfecting patches is a much more interesting event than rebasing.
Although rebasing does happen as well.

If you look at the -mm tree it tends to have 2-3 releases before
getting rebased.

> This is largely the policy that Junio uses for the `pu` and
> the `next` branches, as well as for the topic branches that he
> carries for everyone else doing GIT development.  It appears to be
> working rather well, but it certainly could be streamlined better.
> My git-rerere2 and tb tools are an attempt to do this, but sadly
> they aren't in a useful state yet.  Maybe because they are both
> far more complex then what you are doing here.  :-)

To some extent I have a very interesting subset of kernel development.
Most of my changes are to systems that I am not a maintainer of.
Most of my changes are substantial, and scary because they touch
fundamental things.  Most of my change involve many interdependent
patches, so topic branches cannot solve my problems.

For edits stgit git-rebase certainly can help, and I clearly
anticipate better tools in that vein, as well as better tools
for dealing with topic branches.

But that isn't the problem I am trying to solve here.  I am trying
to implement version control for branch edits, (with maximum
capability with the existing git).

> Nonethless it is an interesting contribution.  Thank you for taking
> the time to send it.

Welcome. 

I think by making branch edit history something fundamental, we
achieve some fairly substantial things.
- We don't care about how the operations to edit a branch are
  implemented, making them simpler to write.
- We begin to allow distributed branch editing.
- Branches become primary objects we can work with.

Hopefully I have stirred up the pot enough to allow some interesting
things.

Eric
