From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 5/7] Move knowledge of UNINTERESTING flag into rev-list.c
Date: Tue, 14 Jun 2005 12:04:43 +1000
Message-ID: <20050614020443.23330.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 14 04:04:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Di0mN-00073r-Up
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 04:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVFNCIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 22:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVFNCIe
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 22:08:34 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:57472 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261399AbVFNCEq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 22:04:46 -0400
Received: (qmail 23340 invoked by uid 500); 14 Jun 2005 02:04:43 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch moves all knowledge of output limiting into rev-list.c
even for merge order traversals.

A new method, continue_traversal, is added to the traversal
structure to permit tools to control how far into the graph
the traversal proceeds.

A future modification will do the same for the DISCONTINUITY
and DUPCHECK flags and then remove all these flags from the
epoch.h header.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 epoch.c    |  112 ++++++++++++++++++------------------------------------------
 epoch.h    |   14 +++++---
 rev-list.c |   91 +++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 131 insertions(+), 86 deletions(-)

diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -256,6 +256,17 @@ static void clean_commit(struct traversa
 	 */		
 }
 
+/**
+ * Ask the tactics if we should traverse into the epoch headed at head.
+ */
+static int continue_traversal(struct traversal * traversal, struct commit * head)
+{
+	if (traversal->continue_traversal)
+		return (*(traversal->continue_traversal))(head);
+	else
+		return 1;
+}
+
 void init_traversal(struct traversal * traversal)
 {
 	memset(traversal, 0, sizeof(*traversal));
@@ -417,46 +428,6 @@ static int find_next_epoch_boundary(stru
 }
 
 /*
- * Marks all interesting, visited commits reachable from this commit
- * as uninteresting. We stop recursing when we reach the epoch boundary,
- * an unvisited node or a node that has already been marked uninteresting.
- *
- * This doesn't actually mark all ancestors between the start node and the
- * epoch boundary uninteresting, but does ensure that they will eventually
- * be marked uninteresting when the main sort_unvisited() traversal
- * eventually reaches them.
- */
-static void mark_ancestors_uninteresting(struct commit *commit)
-{
-	unsigned int flags = commit->object.flags;
-	int visited = flags & VISITED;
-	int boundary = flags & BOUNDARY;
-	int uninteresting = flags & UNINTERESTING;
-	struct commit_list *next;
-
-	commit->object.flags |= UNINTERESTING;
-	/*
-	 * We only need to recurse if
-	 *      we are not on the boundary and
-	 *      we have not already been marked uninteresting and
-	 *      we have already been visited.
-	 *
-	 * The main sort_unvisited traverse will mark unreachable
-	 * all uninteresting, unvisited parents as they are visited
-	 * so there is no need to duplicate that traversal here.
-	 *
-	 * Similarly, if the commit is already marked uninteresting
-	 * then either all ancestors have already been marked
-	 * uninteresting or will be once the sort_unvisited
-	 * traverse reaches them.
-	 */
-	if (uninteresting || boundary || !visited)
-		return;
-	for (next = commit->parents; next; next = next->next)
-		mark_ancestors_uninteresting(next->item);
-}
-
-/*
  * Sort the epoch in (adjusted) merge order.
  */
 static void sort_unvisited(
@@ -487,9 +458,6 @@ static void sort_unvisited(
 		while (parents) {
 			struct commit *parent = pop_commit(&parents);
 
-			if (IS_UNINTERESTING(head)) {
-				mark_ancestors_uninteresting(parent);
-			}
 			visit_edge(traversal, head, parent);
 			sort_unvisited(parent, stack, traversal);
 		}		
@@ -513,7 +481,7 @@ static int emit_stack(struct commit_list
 	while (*stack) {
 		struct commit *next = pop_commit(stack);
 		
-		stop = (emit_commit(traversal, next)==STOP) || (next->object.flags & UNINTERESTING) || stop ;
+		stop = stop || (emit_commit(traversal, next)==STOP);
 		clean_commit(traversal, next);
 	}
 	return stop ? STOP : CONTINUE;
@@ -597,7 +565,6 @@ static unsigned int sort_local_branches_
 static int sort_maximal_linear_epoch(struct commit *head, struct traversal * traversal)
 {
 	struct commit * next;
-	struct commit * base;
 	int stop = 0;
 	
 	/* invoke the visitors, if any */
@@ -609,17 +576,9 @@ static int sort_maximal_linear_epoch(str
 	}		
 	/* now emit the nodes, and mark the base*/
 	for (next = head; !IS_BASE(next); next = next->parents->item) {
-		stop = (emit_commit(traversal, next)==STOP) || stop;
-		if (IS_UNINTERESTING(next)) {
-			next->parents->item->object.flags |= UNINTERESTING;
-			stop = 1;
-		}
-	}
-	base = next;		
-	/* then clean the nodes */
-	for (next = head; next != base; next = next->parents->item) 
+		stop = stop || (emit_commit(traversal, next)==STOP);
 		clean_commit(traversal, next);
-		
+	}
 	return stop ? STOP : CONTINUE;
 }
 
@@ -651,7 +610,7 @@ int traverse_from_head(struct commit *he
 	if (ret) 
 		return ret; 
         next->object.flags |= BOUNDARY;
-	while (next && next->parents) {
+	while (next && next->parents && continue_traversal(traversal, next)) { 
 		struct commit *base = NULL;
 		int next_action = CONTINUE;
 
@@ -681,8 +640,10 @@ int traverse_from_head(struct commit *he
 		else					
 			next = base;
 	}
-	if (next)
+	if (next) {
 		emit_commit(traversal, next);
+		clean_commit(traversal, next);
+	}
 	return 0;
 }
 
@@ -696,7 +657,6 @@ int traverse_from_head(struct commit *he
 int traverse_from_list(struct commit_list *list, struct traversal * traversal)
 {
 	struct commit_list *stack = NULL;
-	struct commit_list *filtered = NULL;
 	struct commit *base;
 	int ret = 0;
 
@@ -704,32 +664,26 @@ int traverse_from_list(struct commit_lis
 		die("traversal argument must not be null");
 	if (!traversal->emitter)
 		die("an emitter method must be supplied");
-	/**
-	 * Remove duplicates and uninteresting items.
-	 * Duplicates are not allowed by find_base_for_list and 
-	 * uninteresting items may prevent us identifying the
-	 * right type of traversal to do. 
-	 */
-	for (; list; list = list->next) {
-		struct commit *next = list->item;
+	if (list->next) {
+		struct commit_list * copy=NULL;
 
-		if (!(next->object.flags & (UNINTERESTING|DUPCHECK))) {
-			next->object.flags |= DUPCHECK;
-			commit_list_insert(list->item, &filtered);
+		/* 
+		 * Make a copy of the list we can sort.
+		 */
+		for(;list;list=list->next) {
+			commit_list_insert(list->item, &copy);
 		}
-	}	
-	if (!filtered)
-		die("no uninteresting heads were specified\n");
-	if (filtered->next) {
+		list=copy;
+
 		/*
 		 * With multiple items to start the search with,
 		 * we first sort the list into local order (if required)
 		 * 
 		 * This behaves as if a commit was performed which
-		 * referenced the filtered list as parents. This
+		 * referenced the list as parents. This
 		 * would create a minimal, non-linear epoch.
 		 */		 
-		ret = find_base_for_list(filtered, &base);
+		ret = find_base_for_list(list, &base);
 		if (ret)
 			return ret; /* parsing failure */
 
@@ -739,11 +693,11 @@ int traverse_from_list(struct commit_lis
 
 		/* sort local branches first, so they print last */			
 		if (traversal->local_test)
-			sort_local_branches_first(&filtered, traversal);			
+			sort_local_branches_first(&list, traversal);			
 
 		/* sort the unvisited part of the epoch in merge order */
-		while (filtered)
-			sort_unvisited(pop_commit(&filtered), &stack, traversal);
+		while (list)
+			sort_unvisited(pop_commit(&list), &stack, traversal);
 		
 		/* output the stack */
 		if (emit_stack(&stack, traversal) == STOP) 
@@ -754,7 +708,7 @@ int traverse_from_list(struct commit_lis
 		 * sort in merge order which handles maximal
 		 * linear epochs as well as minimal, non-linear epochs.
 		 */
-		base = filtered->item;
+		base = list->item;
 	} 
 
         /* sort the rest with the sort_in_merge_order algorithm. */
diff --git a/epoch.h b/epoch.h
--- a/epoch.h
+++ b/epoch.h
@@ -11,16 +11,15 @@
 #define DUPCHECK       (1u<<6)
 #define LOCAL          (1u<<7)
 #define BASE           (1u<<8)
-#define FORK           (1u<<9)
 
 #define EPOCH_FLAGS (UNINTERESTING|BOUNDARY|VISITED|DISCONTINUITY|DUPCHECK|LOCAL|BASE)
 
 /**
  * Return codes for emitter method. Also used by rev-list.c
  */
-#define STOP     0
-#define CONTINUE 1
-#define DO       2
+#define STOP           0
+#define CONTINUE       1
+#define DO             2
 
 struct traversal {
 	/*
@@ -57,6 +56,13 @@ struct traversal {
          * allocated by the commit_visitor method.
 	 */
 	void (*clean)(struct commit *);
+
+	/*
+	 * Called at each epoch boundary. Implementers may return
+	 * non-zero if the traversal into the next epoch should
+	 * be stopped.
+	 */
+	int (*continue_traversal)(struct commit *);
 }
 ;
 
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -33,6 +33,7 @@ static int show_breaks = 0;
 static char * local_author = NULL;
 static int prune_at_author = 0;
 static int wrt_author = 0;
+static int stop_traversal = 0;
 
 static void show_commit(struct commit *commit)
 {
@@ -74,11 +75,19 @@ static int filter_commit(struct commit *
 	return DO;
 }
 
+static int continue_traversal(struct commit * commit)
+{
+	return !stop_traversal;
+}
+
 static int process_commit(struct commit * commit)
 {
 	int action=filter_commit(commit);
 
-	if (action == STOP) {
+	if (commit->object.flags & UNINTERESTING)
+		stop_traversal = 1;
+
+	if (action & STOP) {
 		return STOP;
 	}
 
@@ -177,10 +186,79 @@ static void mark_authors_own_uninteresti
         }
 }
 
-static void merge_order_traversal(struct commit_list * list)
+/*
+ * Marks all interesting, visited commits reachable from this commit
+ * as uninteresting. We stop recursing when we reach the epoch boundary,
+ * an unvisited node or a node that has already been marked uninteresting.
+ *
+ * This doesn't actually mark all ancestors between the start node and the
+ * epoch boundary uninteresting, but does ensure that they will eventually
+ * be marked uninteresting when the main sort_unvisited() traversal
+ * eventually reaches them.
+ */
+static void mark_ancestors_uninteresting(struct commit * head, struct commit *parent)
+{
+	unsigned int flags, visited, boundary, uninteresting;
+	struct commit_list *next;
+
+	if (!(head->object.flags & UNINTERESTING)) {
+		return;
+	}
+
+	flags = parent->object.flags;
+	visited = flags & VISITED;
+	boundary = flags & BOUNDARY;
+	uninteresting = flags & UNINTERESTING;
+
+	parent->object.flags |= UNINTERESTING;
+	/*
+	 * We only need to recurse if
+	 *      we are not on the boundary and
+	 *      we have not already been marked uninteresting and
+	 *      we have already been visited.
+	 *
+	 * The main sort_unvisited traverse will mark unreachable
+	 * all uninteresting, unvisited parents as they are visited
+	 * so there is no need to duplicate that traversal here.
+	 *
+	 * Similarly, if the parent is already marked uninteresting
+	 * then either all ancestors have already been marked
+	 * uninteresting or will be once the sort_unvisited
+	 * traverse reaches them.
+	 */
+	if (uninteresting || boundary || !visited)
+		return;
+	for (next = parent->parents; next; next = next->next)
+		mark_ancestors_uninteresting(parent, next->item);
+}
+
+static void merge_order_traversal(struct commit_list * list, int limited)
 {
 	struct traversal traversal;
+	struct commit_list * elided = NULL;
+	struct commit_list ** elided_tail = &elided;
+        struct commit_list ** ptr=&list;
+
+	/**
+	 * Remove duplicates and uninteresting items.
+	 */
+	for (; *ptr; ) {
+		if ((*ptr)->item->object.flags & (UNINTERESTING|DUPCHECK))
+			elided_tail = move_commit(elided_tail, ptr);
+		else {
+			(*ptr)->item->object.flags |= DUPCHECK;
+			ptr = &(*ptr)->next;
+		}
+	}	
+	if (elided) 
+		free_commit_list(elided);
+	if (!list) {
+		die("all of the specified heads are interesting - nothing to do");
+	}
 
+	/*
+         * Setup the traversal
+	 */
 	init_traversal(&traversal);
 	if ((prune_at_author|wrt_author) && !local_author) {
 		local_author = gitenv("GIT_AUTHOR_EMAIL") ? : NULL;			    
@@ -197,10 +275,17 @@ static void merge_order_traversal(struct
 		    local_author = tmp;
 	}		 
 	traversal.emitter = &process_commit;		  
+	traversal.continue_traversal = &continue_traversal;
+	if (limited || prune_at_author)
+		traversal.edge_visitor = &mark_ancestors_uninteresting;
 	if (wrt_author)
 		traversal.local_test = &is_local_author;
 	if (prune_at_author)
 		traversal.commit_visitor = &mark_authors_own_uninteresting;
+
+	/*
+         * Do it.
+         */
 	if (traverse_from_list(list, &traversal))
 		die("merge order sort failed\n");
 }
@@ -293,7 +378,7 @@ int main(int argc, char **argv)
 			list = limit_list(list);
 		show_commit_list(list);
 	} else {		
-		merge_order_traversal(list);
+		merge_order_traversal(list, limited);
 	}
 
 	return 0;
------------
