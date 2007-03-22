From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] git-rev-list --bisect: optimization
Date: Wed, 21 Mar 2007 23:42:40 -0700
Message-ID: <7vvegtwzhb.fsf_-_@assigned-by-dhcp.cox.net>
References: <20070317141209.GA7838@cepheus>
	<Pine.LNX.4.63.0703171845541.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070317195840.GA20735@informatik.uni-freiburg.de>
	<20070321210454.GA2844@lala>
	<Pine.LNX.4.64.0703211521290.6730@woody.linux-foundation.org>
	<Pine.LNX.4.63.0703220240590.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Uwe =?utf-8?Q?Kleine-?= =?utf-8?Q?K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 22 07:42:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUH0X-0003Un-Sw
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 07:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbXCVGmn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 02:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbXCVGmn
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 02:42:43 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61041 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbXCVGmm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 02:42:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070322064241.GRCF748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 22 Mar 2007 02:42:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id diig1W00z1kojtg0000000; Thu, 22 Mar 2007 02:42:41 -0400
In-Reply-To: <Pine.LNX.4.63.0703220240590.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 22 Mar 2007 02:43:18 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42842>

This improves the performance of revision bisection.

The idea is to avoid rather expensive count_distance() function,
which counts the number of commits that are reachable from any
given commit (including itself) in the set.  When a commit has
only one relevant parent commit, the number of commits the
commit can reach is exactly the number of commits that the
parent can reach plus one; instead of running count_distance()
on commits that are on straight single strand of pearls, we can
just add one to the parents' count.

On the other hand, for a merge commit, because the commits
reachable from one parent can be reachable from another parent,
you cannot just add the parents' counts up plus one for the
commit itself; that would overcount ancestors that are reachable
from more than one parents.

The algorithm used in the patch runs count_distance() on merge
commits, and uses the util field of commit objects to remember
them.  After that, the number of commits reachable from each of
the remaining commits is counted by finding a commit whose count
is not yet known but the count for its (sole) parent is known,
and adding one to the parent's count, until we assign numbers to
everybody.

Another small optimization is whenever we find a half-way (that
is, a commit that can reach exactly half of the commits in the
set), we stop giving counts to remaining commits.

The performance to bisect between v1.0.0 and v1.5.0 in git.git
repository was improved by saying good and bad in turns from
3.68 seconds down to 1.26 seconds.  Bisecting the kernel between
v2.6.18 and v2.6.20 was sped up from 21.84 seconds down to 4.22
seconds.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This is a rebase on top of updated Johannes's patch, which is
   [1/2] of this series.

   I am not enabling this for path limited case, so it is still
   in a WIP state.  I am not sure if parent rewriting is doing
   the right thing (if so, then we should be able to assume that
   "interesting" commits are already made contiguous and we can
   keep giving the number one higher than the parent to commits
   on a single-strand-of-pearls like this patch does).

 builtin-rev-list.c |  162 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 160 insertions(+), 2 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 723e4d4..111ba60 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -207,6 +207,160 @@ static struct commit_list *find_bisection(struct commit_list *list,
 	return best;
 }
 
+static inline int commit_interesting(struct commit_list *elem)
+{
+	unsigned flags = elem->item->object.flags;
+	if (flags & UNINTERESTING)
+		return 0;
+	return (!revs.prune_fn || (flags & TREECHANGE));
+}
+
+static inline int weight(struct commit_list *elem)
+{
+	return *((int*)(elem->item->util));
+}
+
+static inline void weight_set(struct commit_list *elem, int weight)
+{
+	*((int*)(elem->item->util)) = weight;
+}
+
+static int count_interesting_parents(struct commit_list *elem)
+{
+	int cnt = 0;
+	if (!elem->item->parents)
+		return cnt;
+	for (elem = elem->item->parents; elem; elem = elem->next) {
+		if (commit_interesting(elem))
+			cnt++;
+	}
+	return cnt;
+}
+
+static struct commit_list *find_bisection_2(struct commit_list *list,
+					    int *reaches, int *all)
+{
+	int n, nr, counted, distance;
+	struct commit_list *p, *best;
+	int *weights;
+
+	for (nr = 0, p = list; p; p = p->next) {
+		if (commit_interesting(p))
+			nr++;
+	}
+	*all = nr;
+	weights = xcalloc(nr, sizeof(int*));
+	counted = 0;
+
+	for (n = 0, p = list; p; p = p->next) {
+		if (!commit_interesting(p))
+			continue;
+		if (commit_interesting(p)) {
+			/*
+			 * positive weight is the number of interesting
+			 * commits it can reach, including itself.
+			 * weight = 0 means it has one parent and
+			 * its distance is unknown.
+			 * weight < 0 means it has more than one
+			 * parent and its distance is unknown.
+			 */
+			p->item->util = &weights[n++];
+			switch (count_interesting_parents(p)) {
+			case 0:
+				weight_set(p, 1);
+				counted++;
+				break;
+			case 1:
+				weight_set(p, 0);
+				break;
+			default:
+				weight_set(p, -1);
+				break;
+			}
+		}
+	}
+
+	/*
+	 * If you have only one parent in the resulting set
+	 * then you can reach one commit more than that parent
+	 * can reach.  So we do not have to run the expensive
+	 * count_distance() for single strand of pearls.
+	 *
+	 * However, if you have more than one parents, you cannot
+	 * just add their distance and one for yourself, since
+	 * they usually reach the same ancestor and you would
+	 * end up counting them twice that way.
+	 *
+	 * So we will first count distance of merges the usual
+	 * way, and then fill the blanks using cheaper algorithm.
+	 */
+	for (p = list; p; p = p->next) {
+		if (!commit_interesting(p))
+			continue;
+		n = weight(p);
+		if (0 <= n)
+			continue;
+		distance = count_distance(p);
+		clear_distance(p);
+		weight_set(p, distance);
+
+		/* Is it happen to be at exactly half-way? */
+		distance *= 2;
+		if (nr == distance || (nr+1) == distance) {
+			p->next = NULL;
+			*reaches = weight(p);
+			free(weights);
+			return p;
+		}
+		counted++;
+	}
+
+	while (counted < nr) {
+		for (p = list; p; p = p->next) {
+			struct commit_list *q;
+
+			if (!commit_interesting(p) || 0 < weight(p))
+				continue;
+			for (q = p->item->parents; q; q = q->next)
+				if (commit_interesting(q) && 0 < weight(q))
+					break;
+			if (!q)
+				continue;
+			weight_set(p, weight(q)+1);
+			counted++;
+
+			/* Is it happen to be at exactly half-way? */
+			distance = weight(p) * 2;
+			if (nr == distance || (nr+1) == distance) {
+				p->next = NULL;
+				*reaches = weight(p);
+				free(weights);
+				return p;
+			}
+		}
+	}
+
+	/* Then find the best one */
+	counted = 0;
+	best = list;
+	for (p = list; p; p = p->next) {
+		if (!commit_interesting(p))
+			continue;
+		distance = weight(p);
+		if (nr - distance < distance)
+			distance = nr - distance;
+		if (distance > counted) {
+			best = p;
+			counted = distance;
+			*reaches = weight(p);
+		}
+	}
+	if (best)
+		best->next = NULL;
+	free(weights);
+	return best;
+}
+
 static void read_revisions_from_stdin(struct rev_info *revs)
 {
 	char line[1000];
@@ -298,8 +452,12 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list) {
 		int reaches = reaches, all = all;
 
-		revs.commits = find_bisection(revs.commits,
-					      &reaches, &all);
+		if (!revs.prune_fn)
+			revs.commits = find_bisection_2(revs.commits,
+							&reaches, &all);
+		else
+			revs.commits = find_bisection(revs.commits,
+						      &reaches, &all);
 		if (bisect_show_vars) {
 			int cnt;
 			if (!revs.commits)
-- 
1.5.1.rc1.610.g3ba7
