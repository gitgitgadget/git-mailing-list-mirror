From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/7] Introduce new methods into the epoch_methods structure.
Date: Tue, 14 Jun 2005 12:04:36 +1000
Message-ID: <20050614020436.23273.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 14 04:01:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Di0k5-0006or-Af
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 04:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVFNCGL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 22:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVFNCGL
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 22:06:11 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:30849 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261308AbVFNCEj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 22:04:39 -0400
Received: (qmail 23283 invoked by uid 500); 14 Jun 2005 02:04:36 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


The epoch_methods in epoch.h is modified to include several new methods:

visit_commit - This method is called during the sort phase of a merge order traversal.
Implementors may allocate resources and reference them by object.util during this call.

visit_edge - This method is called each time an edge is visited during the sort phase
of a merge order traversal.

clean_commit - This method allows implementors to cleanup and release any resources
allocated during visit_commit.

This change starts to move responsibility for output limiting back into rev-list.c and
starts to generalize epoch.c as a general purpose commit graph traversal algorithm.

sort_list_in_merge_order now clears all flags it uses (masked by EPOCH_FLAGS),
rather than leaving them in an undefined state as it did previously.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 epoch.c    |  145 ++++++++++++++++++++++++++++++++++++++++--------------------
 epoch.h    |   35 ++++++++++++--
 rev-list.c |   66 +++++++++++++++------------
 3 files changed, 163 insertions(+), 83 deletions(-)

diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -197,17 +197,65 @@ static void free_mass_counter(struct mas
 	free(counter);
 }
 
-static void mark_commit(struct epoch_methods * methods, struct commit * commit)
+/*
+ * This function calls the supplied commit_visitor method, if there is one.
+ */
+static void visit_commit(struct epoch_methods * methods, struct commit * commit, int first_visit)
 {
-	if (methods->marker)
-		(*(methods->marker))(commit);
+	/*
+	 * pre-condition:
+	 * 	first_visit => object.util == NULL
+	 */
+	if (methods->commit_visitor)
+		(*(methods->commit_visitor))(commit, first_visit);
 }
 
+/*
+ * This function is called as each edge in the graph is identified. It 
+ * will always be called after visit_commit(...,from, 1). No guarantees
+ * are offered about when this call will be made w.r.t. to the call
+ * to visit_commit(..., to, 1)
+ */
+static void visit_edge(struct epoch_methods * methods, struct commit * from, struct commit * to)
+{
+	/*
+	 * pre-condition:
+	 * 	from->object.flags & VISITED &&
+	 * 	to->object.util => (to->object.flags & VISITED)
+	 */ 
+	if (methods->edge_visitor)
+		(*(methods->edge_visitor))(from, to);
+}
+
+/*
+ * This function is called exactly once for each commit discovered during
+ * the merge order traversal. If it ever returns a non-zero value, the
+ * merge order traversal will not continue past the current epoch boundary.
+ * It may, however, continue to emit nodes up until the epoch boundary.
+ * It is the implementer's responsibility to perform output limiting if 
+ * that is required.
+ */
 static int emit_commit(struct epoch_methods * methods, struct commit * commit)
 {
 	return (*(methods->emitter))(commit);
 }
 
+/*
+ * Invoke a call back method to allow the tactics to release and storage
+ * allocated during a previous visit_commit or visit_edge call.
+ */
+static void clean_commit(struct epoch_methods * methods, struct commit * commit)
+{
+	if (methods->clean)
+		(*(methods->clean))(commit);
+	commit->object.util = NULL;
+	commit->object.flags &= ~(EPOCH_FLAGS);
+	/*
+	 * post-condition:
+	 * 	commit->object.util == NULL && !(commit->object.flag & EPOCH_FLAGS)
+	 */		
+}
+
 void init_epoch_methods(struct epoch_methods * methods)
 {
 	memset(methods, 0, sizeof(*methods));
@@ -410,7 +458,7 @@ static void mark_ancestors_uninteresting
 	 * all uninteresting, unvisited parents as they are visited
 	 * so there is no need to duplicate that traversal here.
 	 *
-	 * Similarly, if we are already marked uninteresting
+	 * Similarly, if the commit is already marked uninteresting
 	 * then either all ancestors have already been marked
 	 * uninteresting or will be once the sort_unvisited
 	 * traverse reaches them.
@@ -432,10 +480,13 @@ static void sort_unvisited(
 	struct commit_list *parents = NULL;
         struct commit * top = *stack?(*stack)->item:NULL;
 
-	if (IS_VISITED(head)) 
+	if (IS_VISITED(head)) {
+		if (!IS_BASE(head)) {
+			visit_commit(methods, head, 0);
+		}
 		return;
+	}
 	head->object.flags |= VISITED;
-	mark_commit(methods, head);
         if (IS_BASE(head)) {
 		ASSERT(!top, "stack empty on visit to base", head);
 	} else {
@@ -445,57 +496,40 @@ static void sort_unvisited(
 			parents = (struct commit_list *)head->object.util;
                         head->object.util = NULL;
 		}
+		visit_commit(methods, head, 1);
 		while (parents) {
 			struct commit *parent = pop_commit(&parents);
 
 			if (IS_UNINTERESTING(head)) {
 				mark_ancestors_uninteresting(parent);
 			}
+			visit_edge(methods, head, parent);
 			sort_unvisited(parent, stack, methods);
 		}		
+		top=(*stack)?(*stack)->item:NULL;
+		if (top && !is_parent_of(top, head)) {
+			top->object.flags |= DISCONTINUITY;
+		}			
+		commit_list_insert(head, stack);	
         }
-	top=(*stack)?(*stack)->item:NULL;
-	if (top && !is_parent_of(top, head)) {
-		top->object.flags |= DISCONTINUITY;
-	}			
-	commit_list_insert(head, stack);	
 }
 
 /*
  * Emit the contents of the stack.
  * The stack is freed and replaced by NULL.
- * Sets the return value to STOP if no further output should be generated.
+ * Sets the return value to STOP if the traversal should stop.
  */
 static int emit_stack(struct commit_list **stack, struct epoch_methods * methods)
 {
-	unsigned int seen = 0;
-	int action = CONTINUE;
+	int stop = 0;
 
-	while (*stack && (action != STOP)) {
+	while (*stack) {
 		struct commit *next = pop_commit(stack);
-		seen |= next->object.flags;
-		if (*stack)
-			action = emit_commit(methods, next);
-	}
-	if (*stack) {
-		free_commit_list(*stack);
-		*stack = NULL;
-	}	
-	if (seen & UNINTERESTING) {
-		/**
-		 * We stop at the base of the stack, rather than
-		 * when we encounter the first UNINTERESTING flag.
-		 * 
-		 * The reason is that there may still be interesting stuff 
-		 * on the stack but once we reach the base there can be no 
-		 * more interesting stuff by definition of what the base 
-		 * of an epoch is - everything reachable from the base is 
-		 * also reachable from the UNINTERESTING node and hence 
-		 * is uninteresting.
-		 */		 
-		action = STOP;
+		
+		stop = (emit_commit(methods, next)==STOP) || (next->object.flags & UNINTERESTING) || stop ;
+		clean_commit(methods, next);
 	}
-	return action;
+	return stop ? STOP : CONTINUE;
 }
 
 /*
@@ -558,6 +592,7 @@ static unsigned int sort_local_branches_
                  */
 		if (!IS_BASE(item) && !item->object.util) {
 			struct commit_list ** copied;
+			
 			if ((*(methods->local_test)) (item))
 				item->object.flags |= LOCAL;
 			copied=copy_and_store_parents(item);
@@ -587,16 +622,33 @@ static unsigned int sort_local_branches_
  * reach the base and emitting as we go. We don't emit the base
  * now.
  */
-static int sort_maximal_linear_epoch(struct commit *next, struct epoch_methods * methods)
+static int sort_maximal_linear_epoch(struct commit *head, struct epoch_methods * methods)
 {
-	while (!IS_BASE(next)) {
-		mark_commit(methods, next);		
-		if (!IS_UNINTERESTING(next) && (emit_commit(methods, next) != STOP))
-			next = next->parents->item;
-		else			
-			return STOP;
+	struct commit * next;
+	struct commit * base;
+	int stop = 0;
+	
+	/* invoke the visitors, if any */
+	if (methods->commit_visitor || methods->edge_visitor) {
+		for (next = head; !IS_BASE(next); next = next->parents->item) {
+			visit_commit(methods, next, 1);
+			visit_edge(methods, next, next->parents->item);
+		}
+	}		
+	/* now emit the nodes, and mark the base*/
+	for (next = head; !IS_BASE(next); next = next->parents->item) {
+		stop = (emit_commit(methods, next)==STOP) || stop;
+		if (IS_UNINTERESTING(next)) {
+			next->parents->item->object.flags |= UNINTERESTING;
+			stop = 1;
+		}
 	}
-	return CONTINUE;
+	base = next;		
+	/* then clean the nodes */
+	for (next = head; next != base; next = next->parents->item) 
+		clean_commit(methods, next);
+		
+	return stop ? STOP : CONTINUE;
 }
 
 /*
@@ -617,9 +669,6 @@ static int sort_minimal_non_linear_epoch
 /*
  * Sorts an arbitrary epoch into merge order by sorting each epoch
  * of its epoch sequence into order.
- *
- * Note: this algorithm currently leaves traces of its execution in the
- * object flags of nodes it discovers. This should probably be fixed.
  */
 static int sort_in_merge_order(struct commit *head, struct epoch_methods * methods)
 {
diff --git a/epoch.h b/epoch.h
--- a/epoch.h
+++ b/epoch.h
@@ -11,6 +11,9 @@
 #define DUPCHECK       (1u<<6)
 #define LOCAL          (1u<<7)
 #define BASE           (1u<<8)
+#define FORK           (1u<<9)
+
+#define EPOCH_FLAGS (UNINTERESTING|BOUNDARY|VISITED|DISCONTINUITY|DUPCHECK|LOCAL|BASE)
 
 /**
  * Return codes for emitter method. Also used by rev-list.c
@@ -28,13 +31,33 @@ struct epoch_methods {
 	 * Returns non-zero if the commit is regarded "local", 0 otherwise.
 	 */
 	int (*local_test)(struct commit *);
-	/* 
-	 * Implementers may use this method to mark commits uninteresting
-	 * according to some locally determined criteria. The tree
-	 * will be pruned at any commit so marked.
+
+	/*
+	 * If defined, called on each visit to a vertex during the 
+         * sort phase of the traversal. first_visit will be
+         * non-zero on the first visit, zero otherwise.
+         *
+         * object.util is available for use by the visitor.
+	 */
+	void (*commit_visitor)(struct commit *, int first_visit);
+
+	/*
+         * Called at some point prior to visiting 'to' from 'from'.
+         * commit_visitor will already have been called at least once for 
+         * from node. It may or may not have already been called for the
+         * to node.
+	 */
+	void (*edge_visitor)(struct commit * from, struct commit * to);
+
+	/*
+         * Called sometime after the emitter function has been called.
+         * Once this call completes the object.util pointer will be set to NULL.
+         * Implementers should use this call to free any data structure
+         * allocated by the commit_visitor method.
 	 */
-	void (*marker)(struct commit *);
-};
+	void (*clean)(struct commit *);
+}
+;
 
 /**
  * Initializes an epoch_methods structure which
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -18,7 +18,7 @@ static const char rev_list_usage[] =
 			"  --wrt-author\n"
 			"  --prune-at-author\n"
 			"  --author=author@domain\n"
-			"  --show-breaks ]";
+			"  --show-breaks";
 
 static int verbose_header = 0;
 static int show_parents = 0;
@@ -167,9 +167,9 @@ static int is_local_author(struct commit
 	return 0;
 }
 
-static void mark_authors_own_uninteresting(struct commit * commit)
+static void mark_authors_own_uninteresting(struct commit * commit, int first_visit)
 {
-        if (is_local_author(commit)) {
+        if (first_visit && is_local_author(commit)) {
 		struct commit_list * parents = commit->parents;
 		for (;parents;parents=parents->next) {
 			parents->item->object.flags |= UNINTERESTING;
@@ -177,6 +177,34 @@ static void mark_authors_own_uninteresti
         }
 }
 
+static void merge_order_traversal(struct commit_list * list)
+{
+	struct epoch_methods methods;
+
+	init_epoch_methods(&methods);
+	if ((prune_at_author|wrt_author) && !local_author) {
+		local_author = gitenv("GIT_AUTHOR_EMAIL") ? : NULL;			    
+		if (!local_author)
+			get_real_identity(&local_author, NULL);
+		else
+			local_author = strdup(local_author);
+	}
+	if (local_author) {
+		    /* add delimiters to improve accuracy of match */
+		    char * tmp=xmalloc(strlen(local_author)+3);
+		    sprintf(tmp, "<%s>", local_author);
+		    free(local_author);
+		    local_author = tmp;
+	}		 
+	methods.emitter = &process_commit;		  
+	if (wrt_author)
+		methods.local_test = &is_local_author;
+	if (prune_at_author)
+		methods.commit_visitor = &mark_authors_own_uninteresting;
+	if (sort_list_in_merge_order(list, &methods))
+		die("merge order sort failed\n");
+}
+
 int main(int argc, char **argv)
 {
 	struct commit_list *list = NULL;
@@ -254,38 +282,18 @@ int main(int argc, char **argv)
 	if (!list)
 		usage(rev_list_usage);
 
-        if (!merge_order) 
-        	merge_order = wrt_author || prune_at_author || show_breaks;        	
+       	merge_order = 
+		merge_order
+		|| wrt_author 
+		|| prune_at_author 
+		|| show_breaks;
 
 	if (!merge_order) {		
 	        if (limited)
 			list = limit_list(list);
 		show_commit_list(list);
 	} else {		
-		struct epoch_methods methods;
-	
-		init_epoch_methods(&methods);
-		if ((prune_at_author|wrt_author) && !local_author) {
-			local_author = gitenv("GIT_AUTHOR_EMAIL") ? : NULL;			    
-			if (!local_author)
-				 get_real_identity(&local_author, NULL);
-			else
-				 local_author = strdup(local_author);
-		}		
-		if (local_author) {
-			/* add delimiters to improve accuracy of match */
-			char * tmp=xmalloc(strlen(local_author)+3);
-			sprintf(tmp, "<%s>", local_author);
-			free(local_author);
-			local_author = tmp;
-		}		 
-		methods.emitter = &process_commit;		  
-		if (wrt_author)
-			methods.local_test = &is_local_author;
-		if (prune_at_author)
-			methods.marker = &mark_authors_own_uninteresting;
-		if (sort_list_in_merge_order(list, &methods))
-			die("merge order sort failed\n");
+		merge_order_traversal(list);
 	}
 
 	return 0;
------------
