From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 19/21] bisect: use a bottom-up traversal to find relevant weights
Date: Sun, 10 Apr 2016 15:19:12 +0200
Message-ID: <1460294354-7031-20-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:21:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFIi-0000Tk-PY
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbcDJNUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:20:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:53713 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935AbcDJNUM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:12 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MVayZ-1bIcwq3CYh-00Z2AX; Sun, 10 Apr 2016 15:20:08
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:okekQoU4tisiB8lDiCGkwB9C7gvUfwPot9v8jynoXZgZcNh2GQI
 635cAfw8uLCUAES5q3K/NyNF7HPDCDbY0pmaH9HLaHIyVZh61GwdSAh6f+3I/4ChVkcLs/R
 2EhIn1HB5nbUcG35FgJNHdoQqZXTLtidp80oh8PPUNjof10OJ8bF41nAgdLNPWrl5lTtKst
 zeL41v2BixPLr7lmKzX4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XzGtK0F1zDE=:gg1G/HIGVW5CIu1fr++57X
 Rd/VREdYOSsBxvMF27QCj7A66w35/oMwkvoaG0ge0ooxcmImlSwcx3tRUtYByRH6roQhdnWG1
 puLDK72IR0GqE+Cr1Lx6eVaEt5O8tCWFvKbGdUJ4li1maTl3KkBFhls3nH+SkBqI6VjnUG5Df
 2KVedcdTT+EbAO7mqiZ/PM8I/w1DQiqKoXJQh49NfnyJlv08lVJ8rEZe8912m+AI43dYufGkR
 htoElK7c0WiN0gA5Qbgq2Jq0k+WWNBxSh2NiYB1Eq6I+ldUddfqVCXXqmoI8VZR5iAbdyBHrK
 8K2P1kEByMtD28R3LX9xrBRTbh8AT4NKgI69sWM3OtYR1W1jwOyo660PVuDXg9jWUhthWNuUy
 N/XUGbxpkFQ30FgPQZTWWaV5CEvwz432vxpz5pvFeFpwycumMPknusydoPkD/rp/gWPMJ03KV
 CNW0HJtenGTfiPMAGjyzKTB1ofoah81TCXpoN7dZ2ZBDah+1e+ueOC18FSzQts1jWC/oncFAS
 tw8aiFxy0/3bj9wN07W24fsR0+HWhq+YADSMDarCCt+ugL3MIgCveofLIcgC3XniG+fkZcFvV
 6swl+uZpcWQ17I3AfT3/HoPJlgFT6GOXbakU9GqXAULG1czNC8bXupCM35XNaadhykgep44Lu
 8FZ1LsYfFR6eUVcjI9iSGaFNaj3yo5PE9wBO7UMjEUvxihA5W6aPujR2M3mQKI7qF1TQ3OnSj
 +ghK4Yqtb89cVpUDawQf31iMwu6IRG9GZwbLFD6TGnz/t6308Q61B9pL4UE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291162>

The idea is to reverse the DAG and perform a traversal
starting on all sources of the reversed DAG.

We walk from the bottom commits, incrementing the weight while
walking on a part of the graph that is single strand of pearls,
or doing the "count the reachable ones the hard way" using
compute_weight() when we hit a merge commit.

A traversal ends when the computed weight is falling or halfway.
This way, commits with too high weight to be relevant are never
visited (and their weights are never computed).

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

Notes:
    I rephrased the commit message.
    
    I renamed the functions such that they don't talk about "BFS"
    because that is irrelevant. Also use a DFS now because it is
    less code (and a little more efficient).
    
    I plugged some leaks.

 bisect.c | 250 +++++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 162 insertions(+), 88 deletions(-)

diff --git a/bisect.c b/bisect.c
index c6bad43..9487ba9 100644
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
@@ -340,90 +333,168 @@ static void compute_all_weights(struct commit_list *list,
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
+static inline void commit_list_insert_unique(struct commit *item,
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
+/* do a traversal on the reversed DAG (starting from commits in queue),
+ * but stop at merge commits */
+static void traversal_up_to_merges(struct commit_list *queue,
+				   struct commit_list **merges)
+{
+	assert(queue);
+	while (queue) {
+		struct commit *top = queue->item;
+		struct commit_list *p;
+
+		pop_commit(&queue);
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
+					commit_list_insert(p->item, &queue);
+				}
+			}
+		}
+	}
+}
+
+static inline int all_parents_are_visited(struct commit *merge)
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
+static inline int find_new_queue_from_merges(struct commit_list **queue,
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
+static inline void compute_merge_weights(struct commit_list *merges)
+{
+	struct commit_list *p;
+	for (p = merges; p; p = p->next)
+		compute_weight(p->item);
+}
+
+static void bottom_up_traversal(struct commit_list *queue)
+{
+	struct commit_list *merges = NULL;
+	traversal_up_to_merges(queue, &merges);
+	while (find_new_queue_from_merges(&queue, &merges)) {
+		compute_merge_weights(queue);
+		traversal_up_to_merges(queue, &merges);
+	}
+
+	/* cleanup */
+	free_commit_list(merges);
+}
+
+/* The idea is to reverse the DAG and perform a modified breadth-first search
+ * on it, starting on all sources of the reversed DAG.
+ * Before each visit of a commit, its weight is induced.
+ * This only works for non-merge commits, so the traversal stops prematurely on
+ * merge commits (that are collected in a list).
+ * Merge commits from that collection are considered for further visits
+ * as soon as all parents have been visited.
+ * Their weights are computed using compute_weight().
+ * Each traversal ends when the computed weight is falling or halfway.
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
+	bottom_up_traversal(sources);
 
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
@@ -470,8 +541,11 @@ struct commit_list *find_bisection(struct commit_list *list,
 		compute_all_weights(list, weights);
 		best = best_bisection_sorted(list);
 	} else {
+		int i;
 		compute_relevant_weights(list, weights);
 		best = best_bisection(list);
+		for (i = 0; i < on_list; i++) /* cleanup */
+			free_commit_list(weights[i].children);
 	}
 	assert(best);
 	*reaches = node_data(best->item)->weight;
-- 
2.8.1.137.g522756c
