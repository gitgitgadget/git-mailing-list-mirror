From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix path-limited "rev-list --bisect" termination condition.
Date: Fri, 23 Mar 2007 14:57:28 -0700
Message-ID: <7vtzwboc6v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 22:57:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUrlh-0007e5-5b
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 22:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992584AbXCWV5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 17:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992586AbXCWV5a
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 17:57:30 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:46591 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992584AbXCWV53 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 17:57:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070323215729.KLZT748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 23 Mar 2007 17:57:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id eMxU1W00D1kojtg0000000; Fri, 23 Mar 2007 17:57:28 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42963>

In a path-limited bisection, when the $bad commit is not
changing the limited path, and the number of suspects is 1, the
code miscounted and returned $bad from find_bisection(), which
is not marked with TREECHANGE.  This is of course filtered by
the output routine, resulting in an empty output, in turn
causing git-bisect driver to say "$bad was both good and bad".

Illustration.  Suppose you have these four commits, and only C
changes path P.  You know D is bad and A is good.

	A---B---C*--D

git-bisect driver runs this to find a bisection point:

	$ git rev-list --bisect A..D -- P

which calls find_bisection() with B, C and D.  The set of
commits that is given to this function is the same set of
commits as rev-list without --bisect option and pathspec
returns.  Among them, only C is marked with TREECHANGE.  Let's
call the set of commits given to find_bisection() that are
marked with TREECHANGE (or all of them if no path limiter is in
effect) "the bisect set".  In the above example, the size of the
bisect set is 1 (contains only "C").

For each commit in its input, find_bisection() computes the
number of commits it can reach in the bisect set.  For a commit
in the bisect set, this number includes itself, so the number is
1 or more.  This number is called "depth", and computed by
count_distance() function.

When you have a bisect set of N commits, and a commit has depth
D, how good is your bisection if you returned that commit?  How
good this bisection is can be measured by how many commits are
effectively tested "together" by testing one commit.

Currently you have (N-1) untested commits (the tip of the bisect
set, although it is included in the bisect set, is already known
to be bad).  If the commit with depth D turns out to be bad,
then your next bisect set will have D commits and you will have
(D-1) untested commits left, which means you tested (N-1)-(D-1)
= (N-D) commits with this bisection.  If it turns out to be good, then
your next bisect set will have (N-D) commits, and you will have
(N-D-1) untested commits left, which means you tested
(N-1)-(N-D-1) = D commits with this bisection.

Therefore, the goodness of this bisection is is min(N-D, D), and
find_bisection() function tries to find a commit that maximizes
this, by initializing "closest" variable to 0 and whenever a
commit with the goodness that is larger than the current
"closest" is found, that commit and its goodness are remembered
by updating "closest" variable.  The "the commit with the best
goodness so far" is kept in "best" variable, and is initialized
to a commit that happens to be at the beginning of the list of
commits given to this function (which may or may not be in the
bisect set when path-limit is in use).

However, when N is 1, then the sole tree-changing commit has
depth of 1, and min(N-D, D) computes to 0.  This is not larger
than the initial value of "closest", and the "so far the best
one" commit is never replaced in the loop.

When path-limit is not in use, this is not a problem, as any
commit in the input set is tree-changing.  But when path-limit
is in use, and when the starting "bad" commit does not change
the specified path, it is not correct.  This is the first
bug the patch fixes with a one-liner.

How many lines did I spend to describe this one-liner?

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-rev-list.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index c2db5a5..4f4b1d2 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -180,7 +180,8 @@ static struct commit_list *find_bisection(struct commit_list *list)
 			nr++;
 		p = p->next;
 	}
-	closest = 0;
+
+	closest = -1;
 	best = list;
 
 	for (p = list; p; p = p->next) {
-- 
1.5.1.rc1.651.g2ca06
