From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Bisect: fix calculation of the number of suspicious revisions
Date: Wed, 21 Mar 2007 18:19:29 -0700
Message-ID: <7vlkhqxefy.fsf@assigned-by-dhcp.cox.net>
References: <20070317141209.GA7838@cepheus>
	<Pine.LNX.4.63.0703171845541.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070317195840.GA20735@informatik.uni-freiburg.de>
	<20070321210454.GA2844@lala>
	<Pine.LNX.4.64.0703211521290.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 22 02:19:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUBxn-0001mF-BY
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 02:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933855AbXCVBTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 21:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933886AbXCVBTc
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 21:19:32 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44349 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933855AbXCVBTa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 21:19:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070322011931.BMBG1312.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 21 Mar 2007 21:19:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ddKW1W0011kojtg0000000; Wed, 21 Mar 2007 21:19:30 -0400
In-Reply-To: <Pine.LNX.4.64.0703211521290.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 21 Mar 2007 15:27:29 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42829>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> (In fact, I would also suggest we drop or try to fix BISECT_NAMES support, 
> while at it - it never really worked, and iirc it was partly exactly 
> *because* of the end-condition not being handled right).

I am not opposed to dropping bisect-names.

I was having fun with this patch, which made an experiment to
bisect between v1.0.0 and v1.5.0 in git.git repository by
alternately saying good and bad go from 3.68 seconds to 1.26
seconds.  Bisecting the kernel between v2.6.18 and v2.6.20 with
the same test script takes 21.84 seconds vs 4.22 seconds.

The idea is that count_distance() is expensive and we would want
to avoid it when we can.  When a commit has only one relevant
parent commit, then the number of commits that commit can reach
is exactly one more than the number of commits that the parent
can reach, so we can avoid running count_distance() on commits
that are on straight single strand of pearls.  On the other
hand, for a merge commit, because the commits reachable from one
parent can be reachable from another parent, you cannot just add
the parents' up (plus one for yourself).

So the patch runs count_distance() on merges (and uses util
field to remember them), and then builds the rest by going
backwards, finding each commit whose distance is not yet known
but the distance of its (sole) parent is known, add one to that,
until we count distance for everybody.

Another small optimization is whenever we find a half-way (that
is, a commit whose distance is half of the number of all
commits), we say that is good enough.

---

Here is the test script that I ran /usr/bin/time on to
benchmark.  It takes three params: path to git-rev-list, a good
commit (i.e. older one), and a bad commit.  The script
alternately says "bisect good" and "bisect bad" and finishes
when it narrows down the suspects to one.

Even with the "half is good enough" optimization in place,
somehow I am getting the same bisect sequence to narrow down
between v2.6.18 and v2.6.20 (the kernel) and v1.0.0 and v1.5.0
(git).

-- >8 -- test script -- >8 --
#!/bin/sh
cmd=$1
good=$(git rev-parse --verify "$2")
bad=$(git rev-parse --verify "$3")
flip=good

run_one () {
	bisect=$($cmd --bisect $bad --not $good)
	ifgood=$(git-rev-list $bad --not $good $bisect | wc -l)
	ifbad=$(git-rev-list $bisect --not $good | wc -l)
	echo "bad $bad"
	echo "good $good"
	echo "ifgood $ifgood"
	echo "ifbad $ifbad"
	echo

	if test "$bisect" = "$bad"
	then
		false
	else
		case "$flip" in
		good)
			good="$good $bisect"
			flip=bad
			;;
		bad)
			bad="$bisect"
			flip=good
			;;
		esac
		true
	fi
}


while run_one
do
	:
done
-- >8 -- end of test script -- >8 --

 builtin-rev-list.c |  169 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index c2db5a5..c43d88d 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -203,6 +203,167 @@ static struct commit_list *find_bisection(struct commit_list *list)
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
+static struct commit_list *find_bisection_2(struct commit_list *list)
+{
+	int n, nr, last_counted, counted, distance;
+	struct commit_list *p, *best;
+	int *weights;
+
+	for (nr = 0, p = list; p; p = p->next) {
+		if (commit_interesting(p))
+			nr++;
+	}
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
+		distance = weight(p) * 2;
+		if (nr == distance || (nr+1) == distance) {
+			p->next = NULL;
+			free(weights);
+			return p;
+		}
+		counted++;
+	}
+
+	while (counted < nr) {
+		do {
+			last_counted = counted;
+			for (p = list; p; p = p->next) {
+				struct commit_list *q;
+
+				if (!commit_interesting(p) || 0 < weight(p))
+					continue;
+				if (weight(p) < 0)
+					die("OOPS");
+				for (q = p->item->parents;
+				     q;
+				     q = q->next)
+					if (commit_interesting(q) &&
+					    0 < weight(q))
+						break;
+				if (!q)
+					continue;
+				weight_set(p, weight(q)+1);
+				counted++;
+
+				/*
+				 * Do we happen to have found one that
+				 * has the desired half-weight?
+				 */
+				distance = weight(p) * 2;
+				if (nr == distance || (nr+1) == distance) {
+					p->next = NULL;
+					free(weights);
+					return p;
+				}
+			}
+		} while (counted != last_counted);
+
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
+		}
+	}
+	if (best) {
+		best->next = NULL;
+	}
+	free(weights);
+	return best;
+}
+
+
 static void read_revisions_from_stdin(struct rev_info *revs)
 {
 	char line[1000];
@@ -285,8 +446,12 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (revs.tree_objects)
 		mark_edges_uninteresting(revs.commits, &revs, show_edge);
 
-	if (bisect_list)
-		revs.commits = find_bisection(revs.commits);
+	if (bisect_list) {
+		if (!revs.prune_fn)
+			revs.commits = find_bisection_2(revs.commits);
+		else
+			revs.commits = find_bisection(revs.commits);
+	}
 
 	traverse_commit_list(&revs, show_commit, show_object);
 
