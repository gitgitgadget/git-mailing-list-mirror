From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 14/16] bisect: use a modified breadth-first search to find relevant weights
Date: Fri, 26 Feb 2016 03:04:40 +0100
Message-ID: <1456452282-10325-15-git-send-email-s-beyer@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 03:06:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7nC-0007WA-SH
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbcBZCGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:06:01 -0500
Received: from mout.gmx.net ([212.227.15.15]:64489 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330AbcBZCFs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:05:48 -0500
Received: from fermat.fritz.box ([188.108.247.176]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0M9aX9-1admD83h6d-00Cz1f; Fri, 26 Feb 2016 03:05:46
 +0100
X-Mailer: git-send-email 2.7.2.383.g3fb0654
In-Reply-To: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:Jsx+ASK8NV8o1HRLta2zHWVSPAMtD/OTaYopdk0nQ1wp8wZMiFO
 OZMOSEpD5rYSQNY09U6+hZXwNNoUkxEDWQUSDXCuz27zirRiknSCrObfCzvBSplLnxB0wlK
 LzAnLkvZhNQQruGa0Z7ATUZoWp+xc+95sVH2FALAsVjQtzNVZAqQLZZGOZTa6V85L5Vzk8G
 +eU1W5ObeyBykN5xkKQ6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DDLeYbXXJ+I=:ZI86lCxGgiYxNIXoIpWbHo
 UWs8aSDhud3bxx50n9PQvsrdNjvWcz8xWgoHWkbNrnNVSho++aodamaQ7vXKRJryi271tigdV
 KPFZQVCUctj8MYa9VHBHXlL4cbUyLv3li9zkzxEUGU/IwE4h5qVfEEuRH2Ai6WwwufbFvsCsy
 ZHn2Um03MEKzexk3p8/YI5woOj4c/5zrJURO4tZVlwNpCFv09lHBQOuai+7U1AZroz91iVhdr
 6nNIVE7rMvpXQlHT1vHXkYDfN3Pp0DB7gdfucmqi7LtWUcEUBuUV6N0X8/Ra5okvYmfsx5c1o
 E+PRQWGNrTFGYjKcSuKYrkjUhjTwgaXmc9SQPuxkiYM1l8gCr3VuXwFAdHzRsGzUrzdkNnc4S
 C+/ppfzqdmYKn7gBJvZKpFXGLXA2L3HUgK7ZnxBYwfcZov34et4uvLbD+G8q3HLrz/Nos6RNe
 qzY8lCOQfXTngipOypWUnXcrIggZO0Azme2wuYEFoTVs6K0k37dLCpnlvwzRPbGmk2E3kyuBo
 PEsjwrN0U9oRz6pA21KH5hR9xyRfc6P73fiK6BXO/6IgfZ/658y3GXg42tyMNfQhI4Q7Q+XzA
 BbNNgUi45CqRGkf1J3cjkujkP+HblB4XRaQZ07Rol1iBats6d75IjRx8VPcBNWAmtWBDy3jI6
 WeAZU+KSaqMg/+/Jxg3dGhtOG20/HB1s5OO4StgrvNFiyRKMm/pg8rXYIJL5oiffVfVor9pOY
 6rtmu5aaiW6zTtdY3Q4FMytPRUCrjgU5ryh4HY3+dcx94SlrnxxzxP+inAg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287520>

The idea is to reverse the DAG and perform a modified breadth-first search
on it, starting on all sources of the reversed DAG.
Before each visit of a commit, its weight is induced.
This only works for non-merge commits, so the BFS stops prematurely on
merge commits (that are collected in a list).
Merge commits from that collection are considered for further visits
as soon as all their parents have been visited.
Their weights are computed using compute_weight().
Each BFS walk ends when the computed weight is falling or halfway.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

In other words: walk the history up, compute the weight of each
commit and stop when you know a better commit cannot follow.

This way, the expensive "compute_weight()" function is not called
on merge commits that will not help to find the maximum distance.

I have to mention that I also had a more complex idea, involving
a binary search on specifically ordered merge commits, and then
inducing the weights of the commits between those merge commits.
However, this is pretty nontrivial, error-prone by definition,
and the compute_weight() calls during the binary search can be more
expensive than during the "bottom-up" BFS walk.
So this is clearly the better idea. (And also follows the KISS rule.)

For the ads: ~3-4 seconds

 bisect.c | 246 ++++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 158 insertions(+), 88 deletions(-)

diff --git a/bisect.c b/bisect.c
index 1d1f61c..827a82a 100644
--- a/bisect.c
+++ b/bisect.c
@@ -30,6 +30,9 @@ static unsigned marker;
 struct node_data {
 	int weight;
 	unsigned marked;
+	unsigned parents;
+	unsigned visited : 1;
+	struct commit_list *children;
 };
 
 #define DEBUG_BISECT 0
@@ -110,16 +113,6 @@ static int count_interesting_parents(struct commit *commit)
 	return count;
 }
 
-static inline int halfway(struct commit *commit)
-{
-	/*
-	 * Don't short-cut something we are not going to return!
-	 */
-	if (commit->object.flags & TREESAME)
-		return 0;
-	return !distance_direction(commit);
-}
-
 #if !DEBUG_BISECT
 #define show_list(a,b,c) do { ; } while (0)
 #else
@@ -340,90 +333,167 @@ static void compute_all_weights(struct commit_list *list,
 	show_list("bisection 2 counted all", counted, list);
 }
 
-/* At the moment this is basically the same as compute_all_weights()
- * but with a halfway shortcut */
+static struct commit_list *build_reversed_dag(struct commit_list *list,
+					      struct node_data *nodes)
+{
+	struct commit_list *sources = NULL;
+	struct commit_list *p;
+	int n = 0;
+	for (p = list; p; p = p->next)
+		p->item->util = &nodes[n++];
+	for (p = list; p; p = p->next) {
+		struct commit_list *parent;
+		struct commit *commit = p->item;
+		for (parent = commit->parents; parent; parent = parent->next) {
+			if (!(parent->item->object.flags & UNINTERESTING)) {
+				struct commit_list **next = &node_data(parent->item)->children;
+				commit_list_insert(commit, next);
+				node_data(commit)->parents++;
+			}
+		}
+	}
+
+	/* find all sources */
+	for (p = list; p; p = p->next) {
+		if (node_data(p->item)->parents == 0)
+			commit_list_insert(p->item, &sources);
+	}
+
+	return sources;
+}
+
+static void commit_list_insert_unique(struct commit *item,
+				      struct commit_list **list)
+{
+	if (!*list || item < (*list)->item) /* empty list or item will be first */
+		commit_list_insert(item, list);
+	else if (item != (*list)->item) { /* item will not be first or not inserted */
+		struct commit_list *p = *list;
+		for (; p->next && p->next->item < item; p = p->next);
+		if (!p->next || item != p->next->item) /* not already inserted */
+			commit_list_insert(item, &p->next);
+	}
+}
+
+/* do a BFS on the reversed DAG (starting from commits in queue), stop at merge commits */
+static void bfs_up_to_merges(struct commit_list *queue,
+			     struct commit_list **merges)
+{
+	assert(queue);
+	struct commit_list **last;
+	for (last = &queue->next; *last; last = &(*last)->next);
+
+	while (queue) {
+		struct commit *top = queue->item;
+		struct commit_list *p;
+
+		if (distance_direction(top) > 0) {
+			node_data(top)->visited = 1;
+
+			/* queue children */
+			for (p = node_data(top)->children; p; p = p->next) {
+				if (node_data(p->item)->parents > 1) /* child is a merge */
+					commit_list_insert_unique(p->item, merges);
+				else {
+					node_data(p->item)->weight = node_data(top)->weight;
+					if (!(p->item->object.flags & TREESAME))
+						node_data(p->item)->weight++;
+					last = commit_list_append(p->item, last);
+				}
+			}
+		}
+
+		pop_commit(&queue);
+	}
+}
+
+static int all_parents_are_visited(struct commit *merge)
+{
+	struct commit_list *p;
+	for (p = merge->parents; p; p = p->next) {
+		if (p->item->util && !node_data(p->item)->visited)
+			return 0;
+	}
+	return 1;
+}
+
+static struct commit *extract_merge_to_queue(struct commit_list **merges)
+{
+	assert(merges);
+
+	struct commit_list *p, *q;
+	struct commit *found;
+
+	/* find a merge that is ready, i.e. all parents have been computed */
+	for (q = NULL, p = *merges; p && !all_parents_are_visited(p->item);
+	     q = p, p = p->next);
+	if (!p)
+		return NULL;
+
+	/* remove that commit from the list and return it */
+	if (q) {
+		assert(q->next == p);
+		q->next = p->next;
+	} else /* found first element of list */
+		*merges = p->next;
+	found = p->item;
+	free(p);
+
+	return found;
+}
+
+static int find_new_queue_from_merges(struct commit_list **queue,
+				      struct commit_list **merges)
+{
+	if (*merges) {
+		struct commit *merge = extract_merge_to_queue(merges);
+		*queue = NULL;
+		if (merge) {
+			commit_list_insert(merge, queue);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static void compute_merge_weights(struct commit_list *merges)
+{
+	struct commit_list *p;
+	for (p = merges; p; p = p->next)
+		compute_weight(p->item);
+}
+
+static void modified_bfs(struct commit_list *queue)
+{
+	struct commit_list *merges = NULL;
+	bfs_up_to_merges(queue, &merges);
+	while (find_new_queue_from_merges(&queue, &merges)) {
+		compute_merge_weights(queue);
+		bfs_up_to_merges(queue, &merges);
+	}
+}
+
+/* The idea is to reverse the DAG and perform a modified breadth-first search
+ * on it, starting on all sources of the reversed DAG.
+ * Before each visit of a commit, its weight is induced.
+ * This only works for non-merge commits, so the BFS stops prematurely on
+ * merge commits (that are collected in a list).
+ * Merge commits from that collection are considered for further visits
+ * as soon as all parents have been visited.
+ * Their weights are computed using compute_weight().
+ * Each BFS branch ends when the computed weight is falling or halfway.
+ */
 static void compute_relevant_weights(struct commit_list *list,
 				     struct node_data *weights)
 {
-	int n, counted;
 	struct commit_list *p;
+	struct commit_list *sources = build_reversed_dag(list, weights);
 
-	counted = 0;
+	for (p = sources; p; p = p->next)
+		node_data(p->item)->weight = 1;
+	modified_bfs(sources);
 
-	for (n = 0, p = list; p; p = p->next) {
-		struct commit *commit = p->item;
-		unsigned flags = commit->object.flags;
-
-		commit->util = &weights[n++];
-		switch (count_interesting_parents(commit)) {
-		case 0:
-			if (!(flags & TREESAME)) {
-				node_data(commit)->weight = 1;
-				counted++;
-				show_list("bisection 2 count one",
-					  counted, list);
-			}
-			break;
-		case 1:
-			node_data(commit)->weight = -1;
-			break;
-		default:
-			node_data(commit)->weight = -2;
-			break;
-		}
-	}
-
-	show_list("bisection 2 initialize", counted, list);
-
-	for (p = list; p; p = p->next) {
-		if (!(p->item->object.flags & UNINTERESTING)
-		 && (node_data(p->item)->weight == -2)) {
-			compute_weight(p->item);
-
-			/* Does it happen to be at exactly half-way? */
-			if (halfway(p->item))
-				return;
-			counted++;
-		}
-	}
-
-	show_list("bisection 2 compute_weight", counted, list);
-
-	while (counted < total) {
-		for (p = list; p; p = p->next) {
-			struct commit_list *q;
-			unsigned flags = p->item->object.flags;
-
-			if (0 <= node_data(p->item)->weight)
-				continue;
-			for (q = p->item->parents; q; q = q->next) {
-				if (q->item->object.flags & UNINTERESTING)
-					continue;
-				if (0 <= node_data(q->item)->weight)
-					break;
-			}
-			if (!q)
-				continue;
-
-			/*
-			 * weight for p is unknown but q is known.
-			 * add one for p itself if p is to be counted,
-			 * otherwise inherit it from q directly.
-			 */
-			node_data(p->item)->weight = node_data(q->item)->weight;
-			if (!(flags & TREESAME)) {
-				node_data(p->item)->weight++;
-				counted++;
-				show_list("bisection 2 count one",
-					  counted, list);
-			}
-
-			/* Does it happen to be at exactly half-way? */
-			if (halfway(p->item))
-				return;
-		}
-	}
-	show_list("bisection 2 counted all", counted, list);
+	show_list("bisection 3 result", total, list);
 }
 
 struct commit_list *find_bisection(struct commit_list *list,
-- 
2.7.1.354.gd492730.dirty
