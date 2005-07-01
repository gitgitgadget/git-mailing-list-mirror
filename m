From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 6/8] Move bisection algorithms into commit.c
Date: Fri, 01 Jul 2005 16:46:58 +1000
Message-ID: <20050701064658.5169.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 01 08:43:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoFEn-0004TU-Sa
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 08:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263248AbVGAGuZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 02:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263242AbVGAGuZ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 02:50:25 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:34432 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S263248AbVGAGrC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2005 02:47:02 -0400
Received: (qmail 5179 invoked by uid 500); 1 Jul 2005 06:46:58 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch moves the bisection algorithms into commit.c.

The bisection algorithms are more lib'ish than tool'ish, so they
have been moved into commit.c.

This has required the definition of the UNINTERESTING and COUNTED
flags to be moved into commit.h and the introduction of the
the LAST_COMMIT_FLAG into commit.h.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 commit.c   |  258 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit.h   |   17 ++++
 epoch.h    |   12 +--
 rev-list.c |  261 ------------------------------------------------------------
 4 files changed, 281 insertions(+), 267 deletions(-)

751d906f842fabd42d191fe7df7ab61d44765de7
diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -3,6 +3,15 @@
 #include "commit.h"
 #include "cache.h"
 
+#define ABOVE        (1u<<1)
+struct bisect_by_cut_node 
+{
+	unsigned int flags;
+	unsigned int count;
+	struct commit_list * children;
+	struct commit_list * visible_parents;
+};
+
 struct sort_node
 {
 	/*
@@ -453,3 +462,252 @@ void sort_in_topological_order(struct co
 	}
 	free(nodes);
 }
+
+/*
+ * This is a truly stupid algorithm, but it's only
+ * used for bisection, and we just don't care enough.
+ *
+ * We care just barely enough to avoid recursing for
+ * non-merge entries.
+ */
+static int count_distance(struct commit_list *entry)
+{
+	int nr = 0;
+
+	while (entry) {
+		struct commit *commit = entry->item;
+		struct commit_list *p;
+
+		if (commit->object.flags & (UNINTERESTING | COUNTED))
+			break;
+		nr++;
+		commit->object.flags |= COUNTED;
+		p = commit->parents;
+		entry = p;
+		if (p) {
+			p = p->next;
+			while (p) {
+				nr += count_distance(p);
+				p = p->next;
+			}			
+		}
+	}
+	return nr;
+}
+
+static void clear_distance(struct commit_list *list)
+{
+	while (list) {
+		struct commit *commit = list->item;
+		commit->object.flags &= ~COUNTED;
+		list = list->next;
+	}
+}
+
+struct commit_list *find_bisection(struct commit_list *list)
+{
+	int nr, closest;
+	struct commit_list *p, *best;
+
+	nr = 0;
+	p = list;
+	while (p) {
+		nr++;
+		p = p->next;
+	}
+	closest = 0;
+	best = list;
+
+	p = list;
+	while (p) {
+		int distance = count_distance(p);
+		clear_distance(list);
+		if (nr - distance < distance)
+			distance = nr - distance;
+		if (distance > closest) {
+			best = p;
+			closest = distance;
+		}
+		p = p->next;
+	}
+	if (best)
+		best->next = NULL;
+	return best;
+}
+
+static inline struct bisect_by_cut_node * get_bisect_by_cut_node(struct commit * commit)
+{
+	return (struct bisect_by_cut_node *)commit->object.util;
+}
+
+/*
+ * Find the best bisection point by cutting a topological order in two then
+ * identifying a set of boundary nodes with a reachability known to be 
+ * less than the desired bisection point. The boundary is advanced until all nodes
+ * in the boundary have a reachability greater than or equal to the desired 
+ * reachability.
+ *
+ * This algorithm is roughly O(kn) where k is a factor related to the typical
+ * amount of parallel branching within the graph and is not related to n.
+ *
+ * The algorithm borrows the notion of making an arbitrary cut in the graph
+ * from the Kernighan-Lin (1969) graph bisection algorithm but differs in
+ * other respects. In particular, by using the topological order to make the
+ * cut the width of the advancing boundary is reduced to some kind of minimum.
+ * Full graph scans (e.g. calls to count_distance()) are avoided except where
+ * absolutely necessary (i.e. a merge node is encountered).
+ */
+struct commit * bisect_by_cut(struct commit_list * topological_order)
+{
+	unsigned int count=0;
+	unsigned int i;
+	struct commit_list * next;
+	struct commit_list * work = NULL;
+	struct commit * best = topological_order->item;
+	struct bisect_by_cut_node * nodes;
+	struct bisect_by_cut_node * next_node;
+	struct commit_list counter;
+	unsigned int fittest, goal;
+
+	counter.next=NULL;
+	/* count the size of the topological order */
+	next=topological_order;
+	while (next) {
+		count++;
+		next = next->next;
+	}
+	fittest=count;
+	i=(count+1)/2;
+	goal=count/2;
+	/* allocate and initialize the bisect_by_cut_node structure */
+	next_node=nodes=xmalloc(sizeof(*nodes)*count);
+	memset(nodes, 0, sizeof(*nodes)*count);
+	/* 
+	 * initialize the structures for all nodes of interest
+	 */
+	next=topological_order;
+	next_node=nodes;
+	while (next) {		
+		next->item->object.util=next_node++;
+		next=next->next;
+	}
+	/*
+	 * Mark half the nodes as being above the boundary.
+	 * Mark nodes that aren't in the topological order as uninteresting.
+	 * Initialize lists of visible children and parents.
+	 */
+	next=topological_order;
+	next_node=nodes;
+	while (next) {		
+		struct commit * next_item = next->item;
+		struct commit_list * parents;
+		
+		if (i > 0) {
+			next_node->flags |= ABOVE;
+			i--;
+		}			
+		parents=next_item->parents;
+		while (parents) {
+			struct commit * parent = parents->item;
+			struct bisect_by_cut_node * pn = get_bisect_by_cut_node(parent);
+
+			if (pn) {
+				commit_list_insert(next_item, &pn->children);
+				commit_list_insert(parent, &next_node->visible_parents);
+			} else 
+				parent->object.flags |= UNINTERESTING;
+			parent->object.flags &= ~COUNTED;
+			parents=parents->next;
+		}
+		next=next->next;
+		next_node++;
+	}
+	/*
+	 * Initialize the work queue with commits that are on the boundary
+	 * and with < the desired reachability.
+	 * 
+	 * We know these commits have less than the desired 
+	 * reachability because by the definition of the topological order
+	 * nodes can only reach nodes to the right of them in the topological
+	 * order and by construction, there there are no more than 
+	 * (count-1)/2 nodes to the right of each node in the boundary.
+	 */
+	next=topological_order;
+	next_node=nodes;
+	while (next) {
+		struct commit_list * parents;
+
+		parents=next_node->visible_parents;
+		while (parents) {
+			struct bisect_by_cut_node * pn = get_bisect_by_cut_node(parents->item);
+
+			if ((next_node->flags & ABOVE) 
+			     && !(pn->flags & ABOVE) 
+			     && (pn->count == 0)) {
+				counter.item=parents->item;
+				pn->count = count_distance(&counter);
+				clear_distance(topological_order);
+				commit_list_insert(parents->item, &work);
+			}
+			parents=parents->next;
+		}
+		next=next->next;
+		next_node++;
+	}
+	/*
+	 * Process the work queue until done.
+	 */
+	while (work) {
+		struct commit * work_item = pop_commit(&work);
+		struct bisect_by_cut_node * wn = get_bisect_by_cut_node(work_item);
+		struct commit_list * children = wn->children;
+		unsigned int goal_test = wn->count;
+	        unsigned int fitness = (goal_test>goal)?(goal_test-goal):(goal-goal_test);
+
+		if (fitness < fittest) {
+			best = work_item;
+			fittest = fitness;
+		}
+		if (goal_test < goal) {
+			while (children) {
+				struct bisect_by_cut_node * cn 
+					= get_bisect_by_cut_node(children->item);
+				if (cn->flags & ABOVE) {
+					/* move the boundary up */
+					cn->flags &= ~ABOVE;
+					if (cn->visible_parents && !cn->visible_parents->next)
+						/* 
+						 * If the child only has one visible parent
+						 * the goal_test increases by one
+						 */
+						cn->count = wn->count+1;
+					else {
+						/*
+						 * Otherwise, we need to count it explicitly.
+						 */
+						counter.item=children->item;
+						cn->count = count_distance(&counter);
+						clear_distance(topological_order);
+					}
+					commit_list_insert(children->item, &work);
+				}
+				children=children->next;
+			}
+		} else if (goal_test > goal)
+			continue;
+		else 
+			break; /* can't do better than this */
+	}
+	if (work)
+		free_commit_list(work);
+	/*
+	 * reset the util pointers.
+	 */
+	next=topological_order;
+	while (next) {
+		next->item->object.util=NULL;
+		next = next->next;
+	}
+	free(nodes);
+	return best;
+}
diff --git a/commit.h b/commit.h
--- a/commit.h
+++ b/commit.h
@@ -4,6 +4,10 @@
 #include "object.h"
 #include "tree.h"
 
+#define UNINTERESTING    (1u<<0)
+#define COUNTED          (1u<<1)
+#define LAST_COMMIT_FLAG (COUNTED)
+
 struct commit_list {
 	struct commit *item;
 	struct commit_list *next;
@@ -68,4 +72,17 @@ int count_parents(struct commit * commit
  *      a reachable from b => ord(b) < ord(a)
  */
 void sort_in_topological_order(struct commit_list ** list);
+
+/*
+ * Uses an O(n^2) algorithm to find the commit that bisects 
+ * the subgraph represented by the list of commits. The boundaries
+ * of the subgraph are delimited by adjacent nodes that have
+ */
+struct commit_list *find_bisection(struct commit_list *list);
+
+/*
+ * Uses O(n) to find the bisection of a list of commits
+ * which is already sorted in topological order.
+ */
+struct commit * bisect_by_cut(struct commit_list * topological_order);
 #endif /* COMMIT_H */
diff --git a/epoch.h b/epoch.h
--- a/epoch.h
+++ b/epoch.h
@@ -10,12 +10,10 @@ typedef int (*emitter_func) (struct comm
 
 int sort_list_in_merge_order(struct commit_list *list, emitter_func emitter);
 
-#define UNINTERESTING   (1u<<2)
-#define BOUNDARY        (1u<<3)
-#define VISITED         (1u<<4)
-#define DISCONTINUITY   (1u<<5)
-#define DUPCHECK        (1u<<6)
-#define LAST_EPOCH_FLAG (1u<<6)
-
+#define BOUNDARY        (LAST_COMMIT_FLAG<<1)
+#define VISITED         (LAST_COMMIT_FLAG<<2)
+#define DISCONTINUITY   (LAST_COMMIT_FLAG<<3)
+#define DUPCHECK        (LAST_COMMIT_FLAG<<4)
+#define LAST_EPOCH_FLAG (DUPCHECK)
 
 #endif	/* EPOCH_H */
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -5,19 +5,9 @@
 #include "blob.h"
 #include "epoch.h"
 
-#define ABOVE        (1u<<1)
-struct bisect_by_cut_node 
-{
-	unsigned int flags;
-	unsigned int count;
-	struct commit_list * children;
-	struct commit_list * visible_parents;
-};
-
 #define SEEN        (LAST_EPOCH_FLAG << 1)
 #define INTERESTING (LAST_EPOCH_FLAG << 2)
-#define COUNTED     (LAST_EPOCH_FLAG << 3)
-#define SHOWN       (LAST_EPOCH_FLAG << 4)
+#define SHOWN       (LAST_EPOCH_FLAG << 3)
 
 static const char rev_list_usage[] =
 	"usage: git-rev-list [OPTION] commit-id <commit-id>\n"
@@ -245,78 +235,6 @@ static int everybody_uninteresting(struc
 	return 1;
 }
 
-/*
- * This is a truly stupid algorithm, but it's only
- * used for bisection, and we just don't care enough.
- *
- * We care just barely enough to avoid recursing for
- * non-merge entries.
- */
-static int count_distance(struct commit_list *entry)
-{
-	int nr = 0;
-
-	while (entry) {
-		struct commit *commit = entry->item;
-		struct commit_list *p;
-
-		if (commit->object.flags & (UNINTERESTING | COUNTED))
-			break;
-		nr++;
-		commit->object.flags |= COUNTED;
-		p = commit->parents;
-		entry = p;
-		if (p) {
-			p = p->next;
-			while (p) {
-				nr += count_distance(p);
-				p = p->next;
-			}			
-		}
-	}
-	return nr;
-}
-
-static void clear_distance(struct commit_list *list)
-{
-	while (list) {
-		struct commit *commit = list->item;
-		commit->object.flags &= ~COUNTED;
-		list = list->next;
-	}
-}
-
-static struct commit_list *find_bisection(struct commit_list *list)
-{
-	int nr, closest;
-	struct commit_list *p, *best;
-
-	nr = 0;
-	p = list;
-	while (p) {
-		nr++;
-		p = p->next;
-	}
-	closest = 0;
-	best = list;
-
-	p = list;
-	while (p) {
-		int distance = count_distance(p);
-		clear_distance(list);
-		if (nr - distance < distance)
-			distance = nr - distance;
-		if (distance > closest) {
-			best = p;
-			closest = distance;
-		}
-		p = p->next;
-	}
-	if (best)
-		best->next = NULL;
-	return best;
-}
-
 struct commit_list *limit_list(struct commit_list *list)
 {
 	struct commit_list *newlist = NULL;
@@ -410,183 +328,6 @@ static struct commit *get_commit_referen
 	die("%s is unknown object", name);
 }
 
-static inline struct bisect_by_cut_node * get_bisect_by_cut_node(struct commit * commit)
-{
-	return (struct bisect_by_cut_node *)commit->object.util;
-}
-
-/*
- * Find the best bisection point by cutting a topological order in two then
- * identifying a set of boundary nodes with a reachability known to be 
- * less than the desired bisection point. The boundary is advanced until all nodes
- * in the boundary have a reachability greater than or equal to the desired 
- * reachability.
- *
- * This algorithm is roughly O(kn) where k is a factor related to the typical
- * amount of parallel branching within the graph and is not related to n.
- *
- * The algorithm borrows the notion of making an arbitrary cut in the graph
- * from the Kernighan-Lin (1969) graph bisection algorithm but differs in
- * other respects. In particular, by using the topological order to make the
- * cut the width of the advancing boundary is reduced to some kind of minimum.
- * Full graph scans (e.g. calls to count_distance()) are avoided except where
- * absolutely necessary (i.e. a merge node is encountered).
- */
-struct commit * bisect_by_cut(struct commit_list * topological_order)
-{
-	unsigned int count=0;
-	unsigned int i;
-	struct commit_list * next;
-	struct commit_list * work = NULL;
-	struct commit * best = topological_order->item;
-	struct bisect_by_cut_node * nodes;
-	struct bisect_by_cut_node * next_node;
-	struct commit_list counter;
-	unsigned int fittest, goal;
-
-	counter.next=NULL;
-	/* count the size of the topological order */
-	next=topological_order;
-	while (next) {
-		count++;
-		next = next->next;
-	}
-	fittest=count;
-	i=(count+1)/2;
-	goal=count/2;
-	/* allocate and initialize the bisect_by_cut_node structure */
-	next_node=nodes=xmalloc(sizeof(*nodes)*count);
-	memset(nodes, 0, sizeof(*nodes)*count);
-	/* 
-	 * initialize the structures for all nodes of interest
-	 */
-	next=topological_order;
-	next_node=nodes;
-	while (next) {		
-		next->item->object.util=next_node++;
-		next=next->next;
-	}
-	/*
-	 * Mark half the nodes as being above the boundary.
-	 * Mark nodes that aren't in the topological order as uninteresting.
-	 * Initialize lists of visible children and parents.
-	 */
-	next=topological_order;
-	next_node=nodes;
-	while (next) {		
-		struct commit * next_item = next->item;
-		struct commit_list * parents;
-		
-		if (i > 0) {
-			next_node->flags |= ABOVE;
-			i--;
-		}			
-		parents=next_item->parents;
-		while (parents) {
-			struct commit * parent = parents->item;
-			struct bisect_by_cut_node * pn = get_bisect_by_cut_node(parent);
-
-			if (pn) {
-				commit_list_insert(next_item, &pn->children);
-				commit_list_insert(parent, &next_node->visible_parents);
-			} else 
-				parent->object.flags |= UNINTERESTING;
-			parent->object.flags &= ~COUNTED;
-			parents=parents->next;
-		}
-		next=next->next;
-		next_node++;
-	}
-	/*
-	 * Initialize the work queue with commits that are on the boundary
-	 * and with < the desired reachability.
-	 * 
-	 * We know these commits have less than the desired 
-	 * reachability because by the definition of the topological order
-	 * nodes can only reach nodes to the right of them in the topological
-	 * order and by construction, there there are no more than 
-	 * (count-1)/2 nodes to the right of each node in the boundary.
-	 */
-	next=topological_order;
-	next_node=nodes;
-	while (next) {
-		struct commit_list * parents;
-
-		parents=next_node->visible_parents;
-		while (parents) {
-			struct bisect_by_cut_node * pn = get_bisect_by_cut_node(parents->item);
-
-			if ((next_node->flags & ABOVE) 
-			     && !(pn->flags & ABOVE) 
-			     && (pn->count == 0)) {
-				counter.item=parents->item;
-				pn->count = count_distance(&counter);
-				clear_distance(topological_order);
-				commit_list_insert(parents->item, &work);
-			}
-			parents=parents->next;
-		}
-		next=next->next;
-		next_node++;
-	}
-	/*
-	 * Process the work queue until done.
-	 */
-	while (work) {
-		struct commit * work_item = pop_commit(&work);
-		struct bisect_by_cut_node * wn = get_bisect_by_cut_node(work_item);
-		struct commit_list * children = wn->children;
-		unsigned int goal_test = wn->count;
-	        unsigned int fitness = (goal_test>goal)?(goal_test-goal):(goal-goal_test);
-
-		if (fitness < fittest) {
-			best = work_item;
-			fittest = fitness;
-		}
-		if (goal_test < goal) {
-			while (children) {
-				struct bisect_by_cut_node * cn 
-					= get_bisect_by_cut_node(children->item);
-				if (cn->flags & ABOVE) {
-					/* move the boundary up */
-					cn->flags &= ~ABOVE;
-					if (cn->visible_parents && !cn->visible_parents->next)
-						/* 
-						 * If the child only has one visible parent
-						 * the goal_test increases by one
-						 */
-						cn->count = wn->count+1;
-					else {
-						/*
-						 * Otherwise, we need to count it explicitly.
-						 */
-						counter.item=children->item;
-						cn->count = count_distance(&counter);
-						clear_distance(topological_order);
-					}
-					commit_list_insert(children->item, &work);
-				}
-				children=children->next;
-			}
-		} else if (goal_test > goal)
-			continue;
-		else 
-			break; /* can't do better than this */
-	}
-	if (work)
-		free_commit_list(work);
-	/*
-	 * reset the util pointers.
-	 */
-	next=topological_order;
-	while (next) {
-		next->item->object.util=NULL;
-		next = next->next;
-	}
-	free(nodes);
-	return best;
-}
-
 int main(int argc, char **argv)
 {
 	struct commit_list *list = NULL;
------------
