From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 3/7] Rename epoch.c entry points as traverse_* methods/stuctures
Date: Tue, 14 Jun 2005 12:04:38 +1000
Message-ID: <20050614020438.23292.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 14 04:02:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Di0kl-0006qq-I7
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 04:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVFNCG5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 22:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVFNCG5
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 22:06:57 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:31872 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261392AbVFNCEl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 22:04:41 -0400
Received: (qmail 23302 invoked by uid 500); 14 Jun 2005 02:04:38 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


The entry points in epoch.c have been renamed to reflect the
fact that they are actually traversal methods rather than
sorting methods.

Also, struct epoch_methods has been renamed as struct traversal.

A future change will rename epoch.[ch] as traversal.[ch]

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 epoch.c    |  107 ++++++++++++++++++++++++++++++------------------------------
 epoch.h    |   32 +++++++++++-------
 rev-list.c |   12 +++----
 3 files changed, 80 insertions(+), 71 deletions(-)

diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -200,14 +200,14 @@ static void free_mass_counter(struct mas
 /*
  * This function calls the supplied commit_visitor method, if there is one.
  */
-static void visit_commit(struct epoch_methods * methods, struct commit * commit, int first_visit)
+static void visit_commit(struct traversal * traversal, struct commit * commit, int first_visit)
 {
 	/*
 	 * pre-condition:
 	 * 	first_visit => object.util == NULL
 	 */
-	if (methods->commit_visitor)
-		(*(methods->commit_visitor))(commit, first_visit);
+	if (traversal->commit_visitor)
+		(*(traversal->commit_visitor))(commit, first_visit);
 }
 
 /*
@@ -216,15 +216,15 @@ static void visit_commit(struct epoch_me
  * are offered about when this call will be made w.r.t. to the call
  * to visit_commit(..., to, 1)
  */
-static void visit_edge(struct epoch_methods * methods, struct commit * from, struct commit * to)
+static void visit_edge(struct traversal * traversal, struct commit * from, struct commit * to)
 {
 	/*
 	 * pre-condition:
 	 * 	from->object.flags & VISITED &&
 	 * 	to->object.util => (to->object.flags & VISITED)
 	 */ 
-	if (methods->edge_visitor)
-		(*(methods->edge_visitor))(from, to);
+	if (traversal->edge_visitor)
+		(*(traversal->edge_visitor))(from, to);
 }
 
 /*
@@ -235,19 +235,19 @@ static void visit_edge(struct epoch_meth
  * It is the implementer's responsibility to perform output limiting if 
  * that is required.
  */
-static int emit_commit(struct epoch_methods * methods, struct commit * commit)
+static int emit_commit(struct traversal * traversal, struct commit * commit)
 {
-	return (*(methods->emitter))(commit);
+	return (*(traversal->emitter))(commit);
 }
 
 /*
  * Invoke a call back method to allow the tactics to release and storage
  * allocated during a previous visit_commit or visit_edge call.
  */
-static void clean_commit(struct epoch_methods * methods, struct commit * commit)
+static void clean_commit(struct traversal * traversal, struct commit * commit)
 {
-	if (methods->clean)
-		(*(methods->clean))(commit);
+	if (traversal->clean)
+		(*(traversal->clean))(commit);
 	commit->object.util = NULL;
 	commit->object.flags &= ~(EPOCH_FLAGS);
 	/*
@@ -256,9 +256,9 @@ static void clean_commit(struct epoch_me
 	 */		
 }
 
-void init_epoch_methods(struct epoch_methods * methods)
+void init_traversal(struct traversal * traversal)
 {
-	memset(methods, 0, sizeof(*methods));
+	memset(traversal, 0, sizeof(*traversal));
 }
 
 /*
@@ -475,14 +475,14 @@ static void mark_ancestors_uninteresting
 static void sort_unvisited(
 	struct commit *head, 
 	struct commit_list **stack, 
-	struct epoch_methods * methods)
+	struct traversal * traversal)
 {
 	struct commit_list *parents = NULL;
         struct commit * top = *stack?(*stack)->item:NULL;
 
 	if (IS_VISITED(head)) {
 		if (!IS_BASE(head)) {
-			visit_commit(methods, head, 0);
+			visit_commit(traversal, head, 0);
 		}
 		return;
 	}
@@ -496,15 +496,15 @@ static void sort_unvisited(
 			parents = (struct commit_list *)head->object.util;
                         head->object.util = NULL;
 		}
-		visit_commit(methods, head, 1);
+		visit_commit(traversal, head, 1);
 		while (parents) {
 			struct commit *parent = pop_commit(&parents);
 
 			if (IS_UNINTERESTING(head)) {
 				mark_ancestors_uninteresting(parent);
 			}
-			visit_edge(methods, head, parent);
-			sort_unvisited(parent, stack, methods);
+			visit_edge(traversal, head, parent);
+			sort_unvisited(parent, stack, traversal);
 		}		
 		top=(*stack)?(*stack)->item:NULL;
 		if (top && !is_parent_of(top, head)) {
@@ -519,15 +519,15 @@ static void sort_unvisited(
  * The stack is freed and replaced by NULL.
  * Sets the return value to STOP if the traversal should stop.
  */
-static int emit_stack(struct commit_list **stack, struct epoch_methods * methods)
+static int emit_stack(struct commit_list **stack, struct traversal * traversal)
 {
 	int stop = 0;
 
 	while (*stack) {
 		struct commit *next = pop_commit(stack);
 		
-		stop = (emit_commit(methods, next)==STOP) || (next->object.flags & UNINTERESTING) || stop ;
-		clean_commit(methods, next);
+		stop = (emit_commit(traversal, next)==STOP) || (next->object.flags & UNINTERESTING) || stop ;
+		clean_commit(traversal, next);
 	}
 	return stop ? STOP : CONTINUE;
 }
@@ -573,13 +573,13 @@ static struct commit_list ** move(struct
  * The return value contains LOCAL if any of the list is local or had a 
  * local ancestor.
  */
-static unsigned int sort_local_branches_first(struct commit_list ** list, struct epoch_methods * methods)
+static unsigned int sort_local_branches_first(struct commit_list ** list, struct traversal * traversal)
 {
 	struct commit_list *local = NULL;
 	struct commit_list **local_tail = &local;
 	struct commit_list **non_local_ptr;
 
-	ASSERT(methods->local_test, "local_test method is defined", NULL);
+	ASSERT(traversal->local_test, "local_test method is defined", NULL);
 	if (!*list) {
 		return 0;
 	}
@@ -593,11 +593,11 @@ static unsigned int sort_local_branches_
 		if (!IS_BASE(item) && !item->object.util) {
 			struct commit_list ** copied;
 			
-			if ((*(methods->local_test)) (item))
+			if ((*(traversal->local_test)) (item))
 				item->object.flags |= LOCAL;
 			copied=copy_and_store_parents(item);
 			item->object.flags 
-			    |= sort_local_branches_first(copied, methods);
+			    |= sort_local_branches_first(copied, traversal);
 		}
 		/**
 		 * Move local items onto their own list.
@@ -622,22 +622,22 @@ static unsigned int sort_local_branches_
  * reach the base and emitting as we go. We don't emit the base
  * now.
  */
-static int sort_maximal_linear_epoch(struct commit *head, struct epoch_methods * methods)
+static int sort_maximal_linear_epoch(struct commit *head, struct traversal * traversal)
 {
 	struct commit * next;
 	struct commit * base;
 	int stop = 0;
 	
 	/* invoke the visitors, if any */
-	if (methods->commit_visitor || methods->edge_visitor) {
+	if (traversal->commit_visitor || traversal->edge_visitor) {
 		for (next = head; !IS_BASE(next); next = next->parents->item) {
-			visit_commit(methods, next, 1);
-			visit_edge(methods, next, next->parents->item);
+			visit_commit(traversal, next, 1);
+			visit_edge(traversal, next, next->parents->item);
 		}
 	}		
 	/* now emit the nodes, and mark the base*/
 	for (next = head; !IS_BASE(next); next = next->parents->item) {
-		stop = (emit_commit(methods, next)==STOP) || stop;
+		stop = (emit_commit(traversal, next)==STOP) || stop;
 		if (IS_UNINTERESTING(next)) {
 			next->parents->item->object.flags |= UNINTERESTING;
 			stop = 1;
@@ -646,7 +646,7 @@ static int sort_maximal_linear_epoch(str
 	base = next;		
 	/* then clean the nodes */
 	for (next = head; next != base; next = next->parents->item) 
-		clean_commit(methods, next);
+		clean_commit(traversal, next);
 		
 	return stop ? STOP : CONTINUE;
 }
@@ -657,20 +657,20 @@ static int sort_maximal_linear_epoch(str
  * parents of each commit in the epoch, if required, then emitting
  * the stack.
  */
-static int sort_minimal_non_linear_epoch(struct commit *head, struct epoch_methods * methods)
+static int sort_minimal_non_linear_epoch(struct commit *head, struct traversal * traversal)
 {
 	struct commit_list *stack = NULL;	
 
-	if (methods->local_test) 
-		sort_local_branches_first(copy_and_store_parents(head),	methods);
-	sort_unvisited(head, &stack, methods);
-	return emit_stack(&stack, methods);
+	if (traversal->local_test) 
+		sort_local_branches_first(copy_and_store_parents(head),	traversal);
+	sort_unvisited(head, &stack, traversal);
+	return emit_stack(&stack, traversal);
 }
+
 /*
- * Sorts an arbitrary epoch into merge order by sorting each epoch
- * of its epoch sequence into order.
+ * see epoch.h
  */
-static int sort_in_merge_order(struct commit *head, struct epoch_methods * methods)
+int traverse_from_head(struct commit *head, struct traversal * traversal)
 {
 	struct commit *next = head;
 	int ret = 0;
@@ -699,9 +699,9 @@ static int sort_in_merge_order(struct co
 		
 		/* sort with the optimal algorithm */
 		if (HAS_EXACTLY_ONE_PARENT(next))
-			next_action = sort_maximal_linear_epoch(next, methods);
+			next_action = sort_maximal_linear_epoch(next, traversal);
 		else
-			next_action = sort_minimal_non_linear_epoch(next, methods);
+			next_action = sort_minimal_non_linear_epoch(next, traversal);
 			
 		/* stop or iterate */			
 		if (next_action == STOP)
@@ -710,26 +710,27 @@ static int sort_in_merge_order(struct co
 			next = base;
 	}
 	if (next)
-		emit_commit(methods, next);
+		emit_commit(traversal, next);
 	return 0;
 }
 
 /*
- * Sorts the nodes reachable from a starting list in merge order, we
+ * see epoch.h
+ * Traverses the nodes reachable from a starting list in merge order, we
  * first find the base for the starting list and then sort all nodes
  * in this subgraph using the sort_unvisited algorithm. Once we have
- * reached the base we can continue sorting using sort_in_merge_order.
+ * reached the base we can continue sorting using traverse_from_head.
  */
-int sort_list_in_merge_order(struct commit_list *list, struct epoch_methods * methods)
+int traverse_from_list(struct commit_list *list, struct traversal * traversal)
 {
 	struct commit_list *stack = NULL;
 	struct commit_list *filtered = NULL;
 	struct commit *base;
 	int ret = 0;
 
-	if (!methods) 
-		die("methods argument must not be null");
-	if (!methods->emitter)
+	if (!traversal) 
+		die("traversal argument must not be null");
+	if (!traversal->emitter)
 		die("an emitter method must be supplied");
 	/**
 	 * Remove duplicates and uninteresting items.
@@ -765,15 +766,15 @@ int sort_list_in_merge_order(struct comm
 			base->object.flags |= (BOUNDARY|BASE);
 
 		/* sort local branches first, so they print last */			
-		if (methods->local_test)
-			sort_local_branches_first(&filtered, methods);			
+		if (traversal->local_test)
+			sort_local_branches_first(&filtered, traversal);			
 
 		/* sort the unvisited part of the epoch in merge order */
 		while (filtered)
-			sort_unvisited(pop_commit(&filtered), &stack, methods);
+			sort_unvisited(pop_commit(&filtered), &stack, traversal);
 		
 		/* output the stack */
-		if (emit_stack(&stack, methods) == STOP) 
+		if (emit_stack(&stack, traversal) == STOP) 
 			return STOP;			
 	} else {
 		/*
@@ -786,6 +787,6 @@ int sort_list_in_merge_order(struct comm
 
         /* sort the rest with the sort_in_merge_order algorithm. */
 	if (base)
-		ret = sort_in_merge_order(base, methods);
+		ret = traverse_from_head(base, traversal);
 	return ret;
 }
diff --git a/epoch.h b/epoch.h
--- a/epoch.h
+++ b/epoch.h
@@ -22,11 +22,12 @@
 #define CONTINUE 1
 #define DO       2
 
-struct epoch_methods {
+struct traversal {
 	/*
 	 * Returns 0 if traversal should stop, non-zero if it should continue.
 	 */
 	int (*emitter)(struct commit *);
+
 	/* 
 	 * Returns non-zero if the commit is regarded "local", 0 otherwise.
 	 */
@@ -60,20 +61,27 @@ struct epoch_methods {
 ;
 
 /**
- * Initializes an epoch_methods structure which
+ * Initializes a traversal structure which
  * may be customized by the caller by overriding any of the method pointers.
  */
-extern void init_epoch_methods(struct epoch_methods *);
+extern void init_traversal(struct traversal *);
+
+/**
+ * Traverses the commit graph from the commits listed. 
+ *
+ * The traversal is performed in (optionally localised) merge order 
+ * which is defined by invariants specified in Documentation/git-rev-list.txt
+ *
+ * The tactics used during the traversal can be customized
+ * by configuring the traversal structure with appropriately
+ * defined method pointers.
+
+ */
+extern int traverse_from_list(struct commit_list *list, struct traversal * traversal);
 
 /**
- * Sorts the list of commits in merge order, using the methods specified
- * to customize the tactics of the search.
- * 
- * The prune points should be marked with the UNINTERESTING flags. 
- * 
- * Note: this algorithm is dirty in the sense that it leaves traces
- * of its execution in the object.flags word of some or all of the commits
- * visited.
+ * Traverses the commit graph from the head commit listed. In other
+ * respects, like traverse_from_list.
  */
-extern int sort_list_in_merge_order(struct commit_list *list, struct epoch_methods * methods);
+extern int traverse_from_head(struct commit *head, struct traversal * traversal);
 #endif	/* EPOCH_H */
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -179,9 +179,9 @@ static void mark_authors_own_uninteresti
 
 static void merge_order_traversal(struct commit_list * list)
 {
-	struct epoch_methods methods;
+	struct traversal traversal;
 
-	init_epoch_methods(&methods);
+	init_traversal(&traversal);
 	if ((prune_at_author|wrt_author) && !local_author) {
 		local_author = gitenv("GIT_AUTHOR_EMAIL") ? : NULL;			    
 		if (!local_author)
@@ -196,12 +196,12 @@ static void merge_order_traversal(struct
 		    free(local_author);
 		    local_author = tmp;
 	}		 
-	methods.emitter = &process_commit;		  
+	traversal.emitter = &process_commit;		  
 	if (wrt_author)
-		methods.local_test = &is_local_author;
+		traversal.local_test = &is_local_author;
 	if (prune_at_author)
-		methods.commit_visitor = &mark_authors_own_uninteresting;
-	if (sort_list_in_merge_order(list, &methods))
+		traversal.commit_visitor = &mark_authors_own_uninteresting;
+	if (traverse_from_list(list, &traversal))
 		die("merge order sort failed\n");
 }
 
------------
