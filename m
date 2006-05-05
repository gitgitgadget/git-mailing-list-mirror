From: linux@horizon.com
Subject: Re: [ANNOUNCE] Git wiki
Date: 4 May 2006 20:56:59 -0400
Message-ID: <20060505005659.9092.qmail@science.horizon.com>
Cc: linux@horizon.com
X-From: git-owner@vger.kernel.org Fri May 05 02:57:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fbod1-0005s1-Jo
	for gcvg-git@gmane.org; Fri, 05 May 2006 02:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWEEA5B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 20:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWEEA5B
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 20:57:01 -0400
Received: from science.horizon.com ([192.35.100.1]:22848 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751505AbWEEA5B
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 4 May 2006 20:57:01 -0400
Received: (qmail 9094 invoked by uid 1000); 4 May 2006 20:56:59 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19591>

Actually, AFAICT from looking at the mailing list history, it's not dirty
politics: the tie-breaker was the support and enthusiasm of the mercurial
developers.  It passed with only minor comment on the git mailing list,
but it was a Big Thing to the hg folks.

There are ups and downs.  OpenSolaris is definitely the big fish in
the mercurial pond (that wasn't *meant* to sound like a recipe for
heavy metal toxicity), and will get lots of attention, but git has more
real-world experience.  The big fish in the git pond is Linus and Linux.

In any case, mercurial and git are really very similar, far closer
to each other than any third system, so it's not like the decision is
a descent into heresy.  Hopefully some useful cross-pollination
can occur, and converting history from one to the other would be
simple if anyone ever wanted to.


As for explicit renames, people are confused on the subject.
IMHO, the two most revolutionary things about git are:

- Finally, a complete break from file-oriented history.  History is made
  of trees, and trees are made of files.  There is no direct connection
  between files in different commits.
- An explicit representation of an in-progress merge.
  This is what makes multiple merge strategies easily implementable.

Third, I suppose, is the raw diff format and the diffcore pipeline.

But finally getting away from the SCCS & RCS idea that the file is the
unit of history is one of git's Great Features, and it shouldn't be
thrown away.


What people who are asking for explicit rename tracking actually want
is automatic rename merging.  If branch A renames a file, and branch B
corrects a typo on a comment somewhere, they'd like the merge to
both patch and rename the file.  If you can do that, you have met the
need, even if your solution isn't the one the feature requester
imagined.

(This is the general consulting problem: a client calls when they've
been trying a solution and can't get past some problem.  Usually, this
is because they've wandered into a blind alley, and what they're asking
for is either far more difficult than necessary, or will just lead them
into greater problems.  The first thing you have to determine is what
they actually want to do, as distinct from how they've decided to do it.)


But, as Linus has pointed out, this is a very partial solution which
introduces a lot of difficulties elsewhere.  File renaming is a subset of
the general class of code reorganizations.  Source files will be split,
merged, and have functions moved back and forth.  You want the patch to
find the code it applies to even if that code was moved.

And that can be done by taking a more global view of the patch.
Identical file names is only a heuristic.  If the hunk on branch A
can't find a place to apply on the same file in branch B, then
you have to look a little harder, either at changes from branch B
that introduce matching code elsewhere, or perhaps looking
through history for a change that removed the match from the
obvious place to see if it added a match elsewhere.

The one thing that makes this difficult is git-read-tree's automatic
collapse of "trivial" merges.  If branch B moves foo() unchanged from
x.c to y.c, while branch A doesn't touch y.c, but edits foo() in x.c,
git-read-tree will collapse the changes to y.c before even invoking
the advanced resolve script.

(The solution might be to keep *four* versions of the file in the index:
the three pre-merge, *and* the post-merge.  Then git-write-tree makes
sure everything has a stage 0 entry and strips out the stage 1, 2 and
3 entries.  This way, one merge algorithm can use another as a
subroutine but decide not to accept something it did.)


But anyway, it's the merging that's the desired feature.  Explicitly
recording renames is only the means to that end, and is superfluous
if there's another way of getting there.  (And the place to look for
interesting new ideas in that area Darcs.)
