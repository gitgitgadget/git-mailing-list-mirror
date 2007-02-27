From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] commit-tree: bump MAX_PARENTS to 128
Date: Tue, 27 Feb 2007 02:23:02 -0800
Message-ID: <7virdnhpbt.fsf@assigned-by-dhcp.cox.net>
References: <20070226121557.GA18114@coredump.intra.peff.net>
	<20070226143142.GA1390@spearce.org>
	<Pine.LNX.4.63.0702261736570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vr6scj9qt.fsf@assigned-by-dhcp.cox.net>
	<20070227081933.GA13021@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 11:23:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLzUZ-0002cT-Pc
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 11:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbXB0KXG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 05:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932948AbXB0KXG
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 05:23:06 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:42503 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932994AbXB0KXE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 05:23:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227102304.MITL3767.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 05:23:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UaP21W00N1kojtg0000000; Tue, 27 Feb 2007 05:23:03 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40705>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 27, 2007 at 12:16:42AM -0800, Junio C Hamano wrote:
>
>> But as Shawn pointed out, Octopus makes bisect less (much less)
>> efficient for the end users, I tend to think the current 16 is
>> already insanely large.
>
> Did you look at my "why I need a huge octopus" description? Is there a
> better way to do it? Should I simply do a bunch of pair-wise merges?
> I'll almost certainly never bisect it,...

I hate having to compose this message because I know I will end
up saying negative things without offering anything constructive.

I do not think bundling commits from unrelated multiple projects
in one commit (some people seem to have called this Hydra in the
past) is a good practice, regardless of size.

For the sake of simplicity, suppose you are bundling two
projects A and B.  The first such commit would have two parent
commits (the current tips of A and B).  Next time you create
another Hydra, what will be its parents?

 * You do not care about the ancestry of Hydra itself, so it has
   two parents, then-current tips of A and B?

 * You do care about the ancestry of Hydra, so the first parent
   is the previous Hydra commit, the second parent is the
   then-current tip of A and the third parent is B?

If you do the former, then I do not think people can follow your
progress unless they have access to your reflog, so I am
guessing that you are doing the latter.

Now, do you have some files that are maintained by Hydra itself?
Duct tape to hold these projects together, perhaps a Makefile to
build the whole thing that does not belong to either A or B?  I
am also guessing the answer is yes, but you said you won't
bisect it, so maybe this is not an issue.  But let's pretend you
have something that you care about their evolution history in
the Hydra itself.

Then, perhaps you would need to merge the ancestry of Hydras
from time to time, if you have multiple concurrent development
tracks of the bundled project.  That means we cannot say the
first parent is from Hydra itself and the rest are component
projects anymore (well, we cannot say that for the initial Hydra
commit itself already, but we could always special case the
"root" commit).  Perhaps we could say "the last N are
components", but then it is not clear what happens when you add
a new component.

What bothers me is that in the usual commit all parents are
equal, but in this case, you have different kinds of "parent"
commits and from the structure of the ancestry chain, you cannot
tell which is what kind.  Ancestry chain of some "parent"
commits represent how the bundling of components have evolved,
while other "parent" commits are just pointers into different
history.

Although pointers to component project commits are represented
as "parent" field in commit objects, I suspect that you wish
they were treated as if they were tree objects contained in the
toplevel commits more often than not for the purposes of many
git operations.

If we think about how bisect and merge _should_ work on such
ancestry chain of Hydras, my gut feeling is that the only way
that makes sense is to take only the first kind of ancestry (the
evolution of the bundling of components) into account.  Use them
to determine the merge base to perform 3-way merge, count them
to find the bisection point, etc.

I am not saying that the problem you are trying to solve is a
wrong problem.  Rather, it is showing a gap between the
structure you are trying to express and the semantics of
ancestry chain git offers.

Currently there is nothing but commit objects that can have more
than one pointers to other commit objects, so if you wanted to,
making an Octopus to fake it may be the only way to do so, but
the current ancestry chain semantics git offers is not set up to
distinguish the two different meanings of "parent" you are
trying to assign to commits, so it is very likely that many
things git naturally does do not match what you expect.  I think
git-log (without any diff options nor paths limiter) to view the
linearlized sequence of commit messages is about the only thing
that makes some sense, and the size limit of Octopus would
probably end up to be the least of your problems.

So in that sense, I would very much more prefer the solution
based on "the (single) tree object contained in the top-level
commit has pointers that point at commits of subprojects"
approach somebody (sorry I forgot who did this) proposed in the
past (well, the very original idea was Linus's "gitlink" which
is probably more than a year old).

Before concluding...

Yes, I am aware that you do not even intend to build on top of
the history of your imported-from-CVS, so in that sense, you do
not care about the ancestry of Hydra itself (it does not even
have a history -- just a single state).  It's such a one-shot
thing that we probably should not even care about (and your
commit-tree patch is fine -- I think the only thing in the core
git that cares about the maximum number of parents a commit can
have is git-blame), but I thought I should mention that it would
be an ideal application for a proper subproject support.
