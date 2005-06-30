From: Jon Seymour <jon.seymour@gmail.com>
Subject: [EXPERIMENTAL PATCH] O(n) bisection algorithm
Date: Thu, 30 Jun 2005 18:11:35 +1000
Message-ID: <20050630081135.27577.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 30 10:05:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dnu2a-0003RT-2R
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 10:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVF3IMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 04:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbVF3IMQ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 04:12:16 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:4482 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262698AbVF3ILj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 04:11:39 -0400
Received: (qmail 27587 invoked by uid 500); 30 Jun 2005 08:11:35 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This is a rollup of an experimental patch to Linus' HEAD that adds
a O(n) bisection algorithm to git.

For the purposes of comparison, this version:
   * enables debugging (-DDEBUG)
   * adds a --debug switch to git-rev-list
   * adds a --bisect-by-cut switch to git-rev-list

This allows the same git-rev-list binary to be used to compare the existing
O(n^2) behaviour (--bisect) with the O(n) behaviour (--bisect-by-cut).

A measure of complexity of each algorithm can be obtained on stderr,
by using the --debug switch.

My measurements suggest that on a 2000 commit kernel history, this
algorithm is ~ 5 times faster than the O(n^2) algorithm. If this
is true, it should be ~25 times faster on a 10,000 commit kernel history.
This is the difference between a 16 second bisection and a 0.6 second
bisection on that size repository.

This patch also includes my latest topological sort implementation
so there is no need to apply that separately.

Linus: if you are happy to adopt this as the default bisection
algorithm, I'll rework it as a formal patch submission, meaning that I'll:
   * remove the Makefile change
   * remove --debug switch
   * remove the #ifdef'd DEBUG code
   * replace --bisect implementation with --bisect-by-cut implementation
     and remove --bisect-by-cut switch

Cleanly applies to Linus HEAD e4b5c7fff47d3a794249ea2da6b9ec4e33e157f3.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
Linus: this isn't fit for inclusion in the mainline yet. I have
posted it to the list for review purposes only.
---

 Makefile   |    2 
 commit.c   |  117 ++++++++++++++++++++++++++++
 commit.h   |    5 +
 rev-list.c |  248 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 361 insertions(+), 11 deletions(-)

83df29ec101718325fbb0c6c8e5dcb891a224edf
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -10,7 +10,7 @@
 # break unless your underlying filesystem supports those sub-second times
 # (my ext3 doesn't).
 COPTS=-O2
-CFLAGS=-g $(COPTS) -Wall
+CFLAGS=-DDEBUG -g $(COPTS) -Wall
 
 prefix=$(HOME)
 bin=$(prefix)/bin
diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -3,6 +3,27 @@
 #include "commit.h"
 #include "cache.h"
 
+struct sort_node
+{
+	/*
+         * the number of children of the associated commit
+         * that also occur in the list being sorted.
+         */
+	unsigned int indegree;
+
+	/*
+         * reference to original list item that we will re-use
+         * on output.
+         */
+	struct commit_list * list_item;
+
+	/*
+         * copy of original object.util pointer that is saved
+         * during the topological sort.
+         */
+	void * save_util;
+};
+
 const char *commit_type = "commit";
 
 enum cmit_fmt get_commit_format(const char *arg)
@@ -346,3 +367,99 @@ int count_parents(struct commit * commit
         return count;
 }
 
+/*
+ * Performs an in-place topological sort on the list supplied
+ * 
+ * Invariant of resulting list is:
+ *        a reachable from b => ord(b) < ord(a)
+ */
+void sort_in_topological_order(struct commit_list ** list)
+{
+	struct commit_list * next = *list;
+	struct commit_list * work = NULL;
+	struct commit_list ** pptr = list;
+	struct sort_node * nodes;
+	struct sort_node * next_nodes;
+	int count = 0;
+
+	/* determine the size of the list */
+	while (next) {
+		next = next->next;
+		count++;
+	}
+	/* allocate an array to help sort the list */
+	nodes = xcalloc(count, sizeof(*nodes));
+	/* link the list to the array */
+	next_nodes = nodes;
+	next=*list;
+	while (next) {
+		next_nodes->list_item = next;
+		next_nodes->save_util = next->item->object.util;
+		next->item->object.util = next_nodes;
+		next_nodes++;
+		next = next->next;
+	}
+	/* update the indegree */
+	next=*list;
+	while (next) {
+		struct commit_list * parents = next->item->parents;
+		while (parents) {
+			struct commit * parent=parents->item;
+			struct sort_node * pn = (struct sort_node *)parent->object.util;
+			
+			if (pn)
+				pn->indegree++;
+			parents=parents->next;
+		}
+		next=next->next;
+	}
+	/* 
+         * find the tips
+         *
+         * tips are nodes not reachable from any other node in the list 
+         * 
+         * the tips serve as a starting set for the work queue.
+         */
+	next=*list;
+	while (next) {
+		struct sort_node * node = (struct sort_node *)next->item->object.util;
+
+		if (node->indegree == 0) {
+			commit_list_insert(next->item, &work);
+		}
+		next=next->next;
+	}
+	/* process the list in topological order */
+	while (work) {
+		struct commit * work_item = pop_commit(&work);
+		struct sort_node * work_node = (struct sort_node *)work_item->object.util;
+		struct commit_list * parents = work_item->parents;
+
+		while (parents) {
+			struct commit * parent=parents->item;
+			struct sort_node * pn = (struct sort_node *)parent->object.util;
+			
+			if (pn) {
+				/* 
+				 * parents are only enqueed for emission 
+                                 * when all their children have been emitted thereby
+                                 * guaranteeing topological order.
+                                 */
+				pn->indegree--;
+				if (!pn->indegree) 
+					commit_list_insert(parent, &work);
+			}
+			parents=parents->next;
+		}
+		/*
+                 * work_item is a commit all of whose children
+                 * have already been emitted. we can emit it now
+                 * and restore its util pointer.
+                 */
+		*pptr = work_node->list_item;
+		pptr = &(*pptr)->next;
+		*pptr = NULL;
+		work_item->object.util = work_node->save_util;
+	}
+	free(nodes);
+}
diff --git a/commit.h b/commit.h
--- a/commit.h
+++ b/commit.h
@@ -55,4 +55,9 @@ struct commit *pop_most_recent_commit(st
 struct commit *pop_commit(struct commit_list **stack);
 
 int count_parents(struct commit * commit);
+
+/*
+ * Performs an in-place topological sort of list supplied.
+ */
+void sort_in_topological_order(struct commit_list ** list);
 #endif /* COMMIT_H */
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -5,10 +5,19 @@
 #include "blob.h"
 #include "epoch.h"
 
-#define SEEN		(1u << 0)
-#define INTERESTING	(1u << 1)
-#define COUNTED		(1u << 2)
-#define SHOWN		(LAST_EPOCH_FLAG << 2)
+#define ABOVE        (1u<<1)
+struct bisect_by_cut_node 
+{
+	unsigned int flags;
+	unsigned int count;
+	struct commit_list * children;
+	struct commit_list * visible_parents;
+};
+
+#define SEEN        (LAST_EPOCH_FLAG << 1)
+#define INTERESTING (LAST_EPOCH_FLAG << 2)
+#define COUNTED     (LAST_EPOCH_FLAG << 3)
+#define SHOWN       (LAST_EPOCH_FLAG << 4)
 
 static const char rev_list_usage[] =
 	"usage: git-rev-list [OPTION] commit-id <commit-id>\n"
@@ -34,6 +43,13 @@ static enum cmit_fmt commit_format = CMI
 static int merge_order = 0;
 static int show_breaks = 0;
 static int stop_traversal = 0;
+static int bisect_by_cut_option = 0;
+static struct commit_list * topological_order = NULL;
+static struct commit_list ** t_o_tail = &topological_order;
+#ifdef DEBUG
+static int debug = 0;
+static unsigned int complexity = 0;
+#endif
 
 static void show_commit(struct commit *commit)
 {
@@ -95,8 +111,10 @@ static int process_commit(struct commit 
 		return CONTINUE;
 	}
 
-	show_commit(commit);
-
+	if (!bisect_by_cut_option) {
+		show_commit(commit);
+	} else
+		t_o_tail = &commit_list_insert(commit, t_o_tail)->next;
 	return CONTINUE;
 }
 
@@ -264,7 +282,7 @@ static int count_distance(struct commit_
 			while (p) {
 				nr += count_distance(p);
 				p = p->next;
-			}
+			}			
 		}
 	}
 	return nr;
@@ -272,6 +290,9 @@ static int count_distance(struct commit_
 
 static void clear_distance(struct commit_list *list)
 {
+#ifdef DEBUG
+	complexity++;
+#endif
 	while (list) {
 		struct commit *commit = list->item;
 		commit->object.flags &= ~COUNTED;
@@ -403,6 +424,196 @@ static struct commit *get_commit_referen
 	die("%s is unknown object", name);
 }
 
+static inline struct bisect_by_cut_node * get_bisect_by_cut_node(struct commit * commit)
+{
+	return (struct bisect_by_cut_node *)commit->object.util;
+}
+
+#ifdef DEBUG
+static void print_bisect_by_cut_node(struct commit * commit, const char * prefix)
+{
+	struct bisect_by_cut_node * node = get_bisect_by_cut_node(commit);
+	fprintf(stderr, "%s%s %u %d\n", prefix, sha1_to_hex(commit->object.sha1), node->flags, node->count);
+}
+#endif
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
+	 * and with <= the desired reachability.
+	 * 
+	 * We know these commits have less than or equal to the desired 
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
+#ifdef DEBUG
+		if (debug) {
+			print_bisect_by_cut_node(work_item, "work ");
+		}
+#endif
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
+
 int main(int argc, char **argv)
 {
 	struct commit_list *list = NULL;
@@ -440,6 +651,10 @@ int main(int argc, char **argv)
 			show_parents = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--bisect-by-cut")) {
+			bisect_by_cut_option = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--bisect")) {
 			bisect_list = 1;
 			continue;
@@ -458,7 +673,12 @@ int main(int argc, char **argv)
 			show_breaks = 1;
 			continue;
 		}
-
+#ifdef DEBUG
+		if (!strcmp(arg, "--debug")) {
+			debug = 1;
+			continue;
+		}
+#endif
 		flags = 0;
 		if (*arg == '^') {
 			flags = UNINTERESTING;
@@ -476,12 +696,20 @@ int main(int argc, char **argv)
 	if (!merge_order) {		
 	        if (limited)
 			list = limit_list(list);
-		show_commit_list(list);
+		if (!bisect_by_cut_option) 
+			show_commit_list(list);
+		else {
+			sort_in_topological_order(&list);
+			show_commit(bisect_by_cut(list));
+		}
 	} else {
 		if (sort_list_in_merge_order(list, &process_commit)) {
 			  die("merge order sort failed\n");
 		}
 	}
-
+#ifdef DEBUG
+	if (debug) 
+		fprintf(stderr, "complexity=%d\n", complexity);
+#endif
 	return 0;
 }
------------
