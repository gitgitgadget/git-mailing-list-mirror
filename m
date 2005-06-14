From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 7/7] Move traversal parts of epoch.[ch] into traversal.[ch]
Date: Tue, 14 Jun 2005 12:04:48 +1000
Message-ID: <20050614020448.23369.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 14 04:07:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Di0pB-0007KW-Qi
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 04:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVFNCL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 22:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVFNCL2
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 22:11:28 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:9857 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261407AbVFNCEv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 22:04:51 -0400
Received: (qmail 23379 invoked by uid 500); 14 Jun 2005 02:04:48 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This change splits the non-epoch related parts of
the traversal algorithm into traversal.[ch] which
become the public interfaces for the traversal
algorithms. The strictly epoch-related code using
fractions, bignums etc., which are implementation
details of the traversal algorithms are left
in epoch.[ch]

This reduces the size of the epoch module thereby
enhancing the maintainability of both it and the
new traversal modules.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 Makefile    |    7 +
 epoch.c     |  411 ++---------------------------------------------------------
 epoch.h     |  107 ++++-----------
 rev-list.c  |    2 
 traversal.c |  395 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 traversal.h |   92 +++++++++++++
 6 files changed, 533 insertions(+), 481 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -42,9 +42,9 @@ install: $(PROG) $(SCRIPTS)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o delta.o date.o index.o diff-delta.o patch-delta.o entry.o \
-	 epoch.o refs.o user.o
+	 traversal.o refs.o user.o epoch.o
 LIB_FILE=libgit.a
-LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h epoch.h user.h
+LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h traversal.h user.h
 
 LIB_H += strbuf.h
 LIB_OBJS += strbuf.o
@@ -140,8 +140,9 @@ diffcore-pathspec.o : $(LIB_H) diffcore.
 diffcore-pickaxe.o : $(LIB_H) diffcore.h
 diffcore-break.o : $(LIB_H) diffcore.h
 diffcore-order.o : $(LIB_H) diffcore.h
-epoch.o: $(LIB_H)
+traversal.o: $(LIB_H)
 user.o: $(LIB_H)
+epoch.o: $(LIB_H)
 
 test: all
 	$(MAKE) -C t/ all
diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -7,43 +7,29 @@
  * for some of the algorithms used here.
  *
  */
-#include <stdlib.h>
+#include "commit.h"
+#include "epoch.h"
 /* Provides arbitrary precision integers required to accurately represent
  * fractional mass: */
 #include <openssl/bn.h>
 
-#include "cache.h"
-#include "commit.h"
-#include "epoch.h"
+
+#define ASSERT(x,m,c) /* not currently used - documentation only */
 
 struct fraction {
 	BIGNUM numerator;
 	BIGNUM denominator;
 };
 
+struct mass_counter {
+	struct fraction seen;
+	struct fraction pending;
+};
+
 static BN_CTX *context = NULL;
 static struct fraction *one = NULL;
 static struct fraction *zero = NULL;
 
-#define HAS_EXACTLY_ONE_PARENT(n) ((n)->parents && !(n)->parents->next)
-#define IS_SEEN(c) ((c)->object.flags & SEEN)
-#define IS_BASE(c) ((c)->object.flags & BASE)
-#define IS_LOCAL(c) ((c)->object.flags & LOCAL)
-
-/* leave the assertions defined for now, maybe null def them later */
-#define ASSERT(x,m,c) if (!(x)) { assertion_failed(__LINE__, __FUNCTION__, m, c); } else {}
-
-static void assertion_failed(int line, char * function, char * message, struct commit * item)
-{
-	die(	"%s:%d:%s: assertion_failed: %s: commit %s, flags %x",
-		__FILE__, 
-		line, 
-		function,
-		message,
-		item ? sha1_to_hex(item->object.sha1) : "[]",
-		item ? item->object.flags : 0xFFFFFFFF);
-}
-			
 static BN_CTX *get_BN_CTX()
 {
 	if (!context)
@@ -168,11 +154,6 @@ static int compare(struct fraction *left
 	return result;
 }
 
-struct mass_counter {
-	struct fraction seen;
-	struct fraction pending;
-};
-
 static struct mass_counter *new_mass_counter(struct commit *commit, struct fraction *pending)
 {
 	struct mass_counter *mass_counter = xmalloc(sizeof(*mass_counter));
@@ -196,81 +177,6 @@ static void free_mass_counter(struct mas
 }
 
 /*
- * This function calls the supplied commit_visitor method, if there is one.
- */
-static void visit_commit(struct traversal * traversal, struct commit * commit, int first_visit)
-{
-	/*
-	 * pre-condition:
-	 * 	first_visit => object.util == NULL
-	 */
-	if (traversal->commit_visitor)
-		(*(traversal->commit_visitor))(commit, first_visit);
-}
-
-/*
- * This function is called as each edge in the graph is identified. It 
- * will always be called after visit_commit(...,from, 1). No guarantees
- * are offered about when this call will be made w.r.t. to the call
- * to visit_commit(..., to, 1)
- */
-static void visit_edge(struct traversal * traversal, struct commit * from, struct commit * to)
-{
-	/*
-	 * pre-condition:
-	 * 	from->object.flags & SEEN &&
-	 * 	to->object.util => (to->object.flags & SEEN)
-	 */ 
-	if (traversal->edge_visitor)
-		(*(traversal->edge_visitor))(from, to);
-}
-
-/*
- * This function is called exactly once for each commit discovered during
- * the merge order traversal. If it ever returns a non-zero value, the
- * merge order traversal will not continue past the current epoch boundary.
- * It may, however, continue to emit nodes up until the epoch boundary.
- * It is the implementer's responsibility to perform output limiting if 
- * that is required.
- */
-static int emit_commit(struct traversal * traversal, struct commit * commit)
-{
-	return (*(traversal->emitter))(commit);
-}
-
-/*
- * Invoke a call back method to allow the tactics to release and storage
- * allocated during a previous visit_commit or visit_edge call.
- */
-static void clean_commit(struct traversal * traversal, struct commit * commit)
-{
-	if (traversal->clean)
-		(*(traversal->clean))(commit);
-	commit->object.util = NULL;
-	commit->object.flags &= ~(TRAVERSAL_FLAGS);
-	/*
-	 * post-condition:
-	 * 	commit->object.util == NULL && !(commit->object.flag & TRAVERSAL_FLAGS)
-	 */		
-}
-
-/**
- * Ask the tactics if we should traverse into the epoch headed at head.
- */
-static int continue_traversal(struct traversal * traversal, struct commit * head)
-{
-	if (traversal->continue_traversal)
-		return (*(traversal->continue_traversal))(head);
-	else
-		return 1;
-}
-
-void init_traversal(struct traversal * traversal)
-{
-	memset(traversal, 0, sizeof(*traversal));
-}
-
-/*
  * Finds the base commit of a list of commits.
  *
  * One property of the commit being searched for is that every commit reachable
@@ -307,7 +213,7 @@ void init_traversal(struct traversal * t
  * non-zero if, and only if, there was a problem parsing one of the
  * commits discovered during the traversal.
  */
-static int find_base_for_list(struct commit_list *list, struct commit **boundary)
+int find_base_for_list(struct commit_list *list, struct commit **boundary)
 {
 	int ret = 0;
 	struct commit_list *cleaner = NULL;
@@ -320,10 +226,10 @@ static int find_base_for_list(struct com
 		struct commit *item = list->item;
 
 		ASSERT(!item->object.util, "no duplicates in list", item);
-		new_mass_counter(list->item, get_one());
+		new_mass_counter(item, get_one());
 		inc(&injected, get_one());
-		commit_list_insert(list->item, &cleaner);
-		commit_list_insert(list->item, &pending);
+		commit_list_insert(item, &cleaner);
+		commit_list_insert(item, &pending);
 	}
 	while (!*boundary && pending && !ret) {
 		struct commit *latest = pop_commit(&pending);
@@ -378,7 +284,7 @@ static int find_base_for_list(struct com
  * Finds the base of an minimal, non-linear epoch, headed at head, by
  * applying the find_base_for_list to a list consisting of the parents
  */
-static int find_base(struct commit *head, struct commit **boundary)
+int find_base(struct commit *head, struct commit **boundary)
 {
 	int ret = 0;
 	struct commit_list *pending = NULL;
@@ -397,7 +303,7 @@ static int find_base(struct commit *head
  * sequence of the epoch headed at head_of_epoch. This is either the end of
  * the maximal linear epoch or the base of a minimal non-linear epoch.
  */
-static int find_next_epoch_boundary(struct commit *head_of_epoch, struct commit **boundary)
+int find_next_epoch_boundary(struct commit *head_of_epoch, struct commit **boundary)
 {
 	struct commit *item = head_of_epoch;
 	int ret;
@@ -424,290 +330,3 @@ static int find_next_epoch_boundary(stru
 	}
 	return ret;
 }
-
-/*
- * Sort the epoch in (adjusted) merge order.
- */
-static void sort_unvisited(
-	struct commit *head, 
-	struct commit_list **stack, 
-	struct traversal * traversal)
-{
-	struct commit_list *parents = NULL;
-        struct commit * top = *stack?(*stack)->item:NULL;
-
-	if (IS_SEEN(head)) {
-		if (!IS_BASE(head)) {
-			visit_commit(traversal, head, 0);
-		}
-		return;
-	}
-	head->object.flags |= SEEN;
-        if (IS_BASE(head)) {
-		ASSERT(!top, "stack empty on visit to base", head);
-	} else {
-		if (!head->object.util) {
-                        parents = copy_parents_in_header_order(head);
-		} else {
-			parents = (struct commit_list *)head->object.util;
-                        head->object.util = NULL;
-		}
-		visit_commit(traversal, head, 1);
-		while (parents) {
-			struct commit *parent = pop_commit(&parents);
-
-			visit_edge(traversal, head, parent);
-			sort_unvisited(parent, stack, traversal);
-		}		
-		commit_list_insert(head, stack);	
-        }
-}
-
-/*
- * Emit the contents of the stack.
- * The stack is freed and replaced by NULL.
- * Sets the return value to STOP if the traversal should stop.
- */
-static int emit_stack(struct commit_list **stack, struct traversal * traversal)
-{
-	int stop = 0;
-
-	while (*stack) {
-		struct commit *next = pop_commit(stack);
-		
-		stop = stop || (emit_commit(traversal, next)==STOP);
-		clean_commit(traversal, next);
-	}
-	return stop ? STOP : CONTINUE;
-}
-
-/*
- * Copy the parents of the commit and store the head of the list
- * in object.util. Return the address of object.util itself.
- */
-static struct commit_list ** copy_and_store_parents(struct commit * commit)
-{
-	struct commit_list * copied=copy_parents_in_header_order(commit);
-
-        commit->object.util = copied;
-	return (struct commit_list **)&commit->object.util;
-}
-
-/*
- * Sort a list of commits in local first order. A commit is "local" 
- * if any of its ancestors (except the base) causes (*local_test)() to 
- * return a non-zero value.
- *
- * The sorted list is returned in *sorted. A side effect of this function 
- * is to set each object.util pointer in each ancestor up until the base 
- * to a list of parents is sorted in local first order.
- *
- * Does nothing if the list is empty.
- * 
- * The return value contains LOCAL if any of the list is local or had a 
- * local ancestor.
- */
-static unsigned int sort_local_branches_first(struct commit_list ** list, struct traversal * traversal)
-{
-	struct commit_list *local = NULL;
-	struct commit_list **local_tail = &local;
-	struct commit_list **non_local_ptr;
-
-	ASSERT(traversal->local_test, "local_test method is defined", NULL);
-	if (!*list) {
-		return 0;
-	}
-	for (non_local_ptr = list; *non_local_ptr; ) {
-		struct commit *item = (*non_local_ptr)->item;
-		
-		/*
-		 * We don't descend past the base or visit
-		 * a commit we have already visited.
-                 */
-		if (!IS_BASE(item) && !item->object.util) {
-			struct commit_list ** copied;
-			
-			if ((*(traversal->local_test)) (item))
-				item->object.flags |= LOCAL;
-			copied=copy_and_store_parents(item);
-			item->object.flags 
-			    |= sort_local_branches_first(copied, traversal);
-		}
-		/**
-		 * Move local items onto their own list.
-                 */
-		if (IS_LOCAL(item))
-			local_tail = move_commit(local_tail, non_local_ptr);
-		else
-			non_local_ptr = &(*non_local_ptr)->next;
-	}
-	/*
-         * Splice the non-local list onto the end of the local
-         * list, set head of the list to the head of the local list
-         * return if the LOCAL flag set if we have any local branches
-         */
-        *local_tail = *list;
-        *list = local;
-	return ((*list)->item->object.flags & LOCAL);
-}
-
-/*
- * Sorting a maximal linear epoch involves traversing until we
- * reach the base and emitting as we go. We don't emit the base
- * now.
- */
-static int sort_maximal_linear_epoch(struct commit *head, struct traversal * traversal)
-{
-	struct commit * next;
-	int stop = 0;
-	
-	/* invoke the visitors, if any */
-	if (traversal->commit_visitor || traversal->edge_visitor) {
-		for (next = head; !IS_BASE(next); next = next->parents->item) {
-			visit_commit(traversal, next, 1);
-			visit_edge(traversal, next, next->parents->item);
-		}
-	}		
-	/* now emit the nodes, and mark the base*/
-	for (next = head; !IS_BASE(next); next = next->parents->item) {
-		stop = stop || (emit_commit(traversal, next)==STOP);
-		clean_commit(traversal, next);
-	}
-	return stop ? STOP : CONTINUE;
-}
-
-/*
- * Sorting a minimal non-linear epoch involves recursively apply
- * sort_unvisited after doing a local_branches_first sort to the
- * parents of each commit in the epoch, if required, then emitting
- * the stack.
- */
-static int sort_minimal_non_linear_epoch(struct commit *head, struct traversal * traversal)
-{
-	struct commit_list *stack = NULL;	
-
-	if (traversal->local_test) 
-		sort_local_branches_first(copy_and_store_parents(head),	traversal);
-	sort_unvisited(head, &stack, traversal);
-	return emit_stack(&stack, traversal);
-}
-
-/*
- * see epoch.h
- */
-int traverse_from_head(struct commit *head, struct traversal * traversal)
-{
-	struct commit *next = head;
-	int ret = 0;
-
-	ret = parse_commit(next);
-	if (ret) 
-		return ret; 
-        next->object.flags |= BOUNDARY;
-	while (next && next->parents && continue_traversal(traversal, next)) { 
-		struct commit *base = NULL;
-		int next_action = CONTINUE;
-
-		/* scan to the base of the current epoch */
-		ret = find_next_epoch_boundary(next, &base);
-		
-		/* abort if we detected a parsing error */
-		if (ret)
-			return ret; /* parsing failure */
-			
-		/* mark the new base so we know when to stop sorting */
-		if (base)
-			base->object.flags |= (BOUNDARY|BASE);
-			
-		/* reset flags set by last iteration */
-		next->object.flags &= ~(BASE|SEEN);
-		
-		/* sort with the optimal algorithm */
-		if (HAS_EXACTLY_ONE_PARENT(next))
-			next_action = sort_maximal_linear_epoch(next, traversal);
-		else
-			next_action = sort_minimal_non_linear_epoch(next, traversal);
-			
-		/* stop or iterate */			
-		if (next_action == STOP)
-			return 0; 
-		else					
-			next = base;
-	}
-	if (next) {
-		emit_commit(traversal, next);
-		clean_commit(traversal, next);
-	}
-	return 0;
-}
-
-/*
- * see epoch.h
- * Traverses the nodes reachable from a starting list in merge order, we
- * first find the base for the starting list and then sort all nodes
- * in this subgraph using the sort_unvisited algorithm. Once we have
- * reached the base we can continue sorting using traverse_from_head.
- */
-int traverse_from_list(struct commit_list *list, struct traversal * traversal)
-{
-	struct commit_list *stack = NULL;
-	struct commit *base;
-	int ret = 0;
-
-	if (!traversal) 
-		die("traversal argument must not be null");
-	if (!traversal->emitter)
-		die("an emitter method must be supplied");
-	if (list->next) {
-		struct commit_list * copy=NULL;
-
-		/* 
-		 * Make a copy of the list we can sort.
-		 */
-		for(;list;list=list->next) {
-			commit_list_insert(list->item, &copy);
-		}
-		list=copy;
-
-		/*
-		 * With multiple items to start the search with,
-		 * we first sort the list into local order (if required)
-		 * 
-		 * This behaves as if a commit was performed which
-		 * referenced the list as parents. This
-		 * would create a minimal, non-linear epoch.
-		 */		 
-		ret = find_base_for_list(list, &base);
-		if (ret)
-			return ret; /* parsing failure */
-
-		/* mark the termination condition*/
-		if (base)
-			base->object.flags |= (BOUNDARY|BASE);
-
-		/* sort local branches first, so they print last */			
-		if (traversal->local_test)
-			sort_local_branches_first(&list, traversal);			
-
-		/* sort the unvisited part of the epoch in merge order */
-		while (list)
-			sort_unvisited(pop_commit(&list), &stack, traversal);
-		
-		/* output the stack */
-		if (emit_stack(&stack, traversal) == STOP) 
-			return STOP;			
-	} else {
-		/*
-		 * With only one item on the list, we just use
-		 * sort in merge order which handles maximal
-		 * linear epochs as well as minimal, non-linear epochs.
-		 */
-		base = list->item;
-	} 
-
-        /* sort the rest with the sort_in_merge_order algorithm. */
-	if (base)
-		ret = traverse_from_head(base, traversal);
-	return ret;
-}
-
diff --git a/epoch.h b/epoch.h
--- a/epoch.h
+++ b/epoch.h
@@ -1,91 +1,38 @@
+/*
+ * Copyright (c) 2005, Jon Seymour
+ *
+ * For more information about epoch theory on which this module is based,
+ * refer to http://blackcubes.dyndns.org/epoch/. That web page defines
+ * terms such as "epoch" and "minimal, non-linear epoch" and provides rationales
+ * for some of the algorithms used here.
+ *
+ */
 #ifndef EPOCH_H
 #define EPOCH_H
 
-/**
- * Flags used by merge order logic and also by rev-list.c
- */
-#define SEEN                    (1u<<0)
-#define BOUNDARY                (SEEN<<1)
-#define LOCAL                   (BOUNDARY<<1)
-#define BASE                    (LOCAL<<1)
-#define LAST_TRAVERSAL_FLAG     (BASE)
-
-#define TRAVERSAL_FLAGS         (BOUNDARY|SEEN|LOCAL|BASE)
-
-/**
- * Return codes for emitter method. Also used by rev-list.c
- */
-#define STOP           0
-#define CONTINUE       1
-#define DO             2
-
-struct traversal {
-	/*
-	 * Returns 0 if traversal should stop, non-zero if it should continue.
-	 */
-	int (*emitter)(struct commit *);
-
-	/* 
-	 * Returns non-zero if the commit is regarded "local", 0 otherwise.
-	 */
-	int (*local_test)(struct commit *);
-
-	/*
-	 * If defined, called on each visit to a vertex during the 
-         * sort phase of the traversal. first_visit will be
-         * non-zero on the first visit, zero otherwise.
-         *
-         * object.util is available for use by the visitor.
-	 */
-	void (*commit_visitor)(struct commit *, int first_visit);
-
-	/*
-         * Called at some point prior to visiting 'to' from 'from'.
-         * commit_visitor will already have been called at least once for 
-         * from node. It may or may not have already been called for the
-         * to node.
-	 */
-	void (*edge_visitor)(struct commit * from, struct commit * to);
+#include "cache.h"
 
-	/*
-         * Called sometime after the emitter function has been called.
-         * Once this call completes the object.util pointer will be set to NULL.
-         * Implementers should use this call to free any data structure
-         * allocated by the commit_visitor method.
-	 */
-	void (*clean)(struct commit *);
+#define HAS_EXACTLY_ONE_PARENT(n) ((n)->parents && !(n)->parents->next)
 
-	/*
-	 * Called at each epoch boundary. Implementers may return
-	 * non-zero if the traversal into the next epoch should
-	 * be stopped.
-	 */
-	int (*continue_traversal)(struct commit *);
-}
-;
-
-/**
- * Initializes a traversal structure which
- * may be customized by the caller by overriding any of the method pointers.
+/*
+ * Find the next articulation point in the graph
  */
-extern void init_traversal(struct traversal *);
+int find_base_for_list(struct commit_list *list, struct commit **boundary);
 
-/**
- * Traverses the commit graph from the commits listed. 
- *
- * The traversal is performed in (optionally localised) merge order 
- * which is defined by invariants specified in Documentation/git-rev-list.txt
+/*
+ * Find the base of the minimal, non-linear epoch headed at head.
  *
- * The tactics used during the traversal can be customized
- * by configuring the traversal structure with appropriately
- * defined method pointers.
-
+ * The base is the first articulation point of the graph reachable from head
+ * such that the only paths between the head and commits reachable from the 
+ * base are paths that include the base itself.
  */
-extern int traverse_from_list(struct commit_list *list, struct traversal * traversal);
+int find_base(struct commit *head, struct commit **boundary);
 
-/**
- * Traverses the commit graph from the head commit listed. In other
- * respects, like traverse_from_list.
+/*
+ * Find the boundary of the next epoch in the unique epoch sequence
+ * for the graph reachable from head. This is either the
+ * end of the base of a minimal, non-linear epoch (if head has >1 parents)
+ * or the end of a maximal, linear epoch (if head has exactly 1 parent)
  */
-extern int traverse_from_head(struct commit *head, struct traversal * traversal);
-#endif	/* EPOCH_H */
+int find_next_epoch_boundary(struct commit *head, struct commit **boundary);
+#endif /* EPOCH_H */
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 #include "commit.h"
-#include "epoch.h"
+#include "traversal.h"
 #include "user.h"
 
 #define INTERESTING	(LAST_TRAVERSAL_FLAG << 1)
diff --git a/traversal.c b/traversal.c
new file mode 100644
--- /dev/null
+++ b/traversal.c
@@ -0,0 +1,395 @@
+/*
+ * Copyright (c) 2005, Jon Seymour
+ *
+ * For more information about epoch theory on which this module is based,
+ * refer to http://blackcubes.dyndns.org/epoch/. That web page defines
+ * terms such as "epoch" and "minimal, non-linear epoch" and provides rationales
+ * for some of the algorithms used here.
+ *
+ */
+#include <stdlib.h>
+#include "cache.h"
+#include "commit.h"
+#include "traversal.h"
+#include "epoch.h"
+
+#define IS_SEEN(c) ((c)->object.flags & SEEN)
+#define IS_BASE(c) ((c)->object.flags & BASE)
+#define IS_LOCAL(c) ((c)->object.flags & LOCAL)
+
+/* leave the assertions defined for now, maybe null def them later */
+#define ASSERT(x,m,c) if (!(x)) { assertion_failed(__LINE__, __FUNCTION__, m, c); } else {}
+
+static void assertion_failed(int line, char * function, char * message, struct commit * item)
+{
+	die(	"%s:%d:%s: assertion_failed: %s: commit %s, flags %x",
+		__FILE__, 
+		line, 
+		function,
+		message,
+		item ? sha1_to_hex(item->object.sha1) : "[]",
+		item ? item->object.flags : 0xFFFFFFFF);
+}
+			
+/*
+ * This function calls the supplied commit_visitor method, if there is one.
+ */
+static void visit_commit(struct traversal * traversal, struct commit * commit, int first_visit)
+{
+	/*
+	 * pre-condition:
+	 * 	first_visit => object.util == NULL
+	 */
+	if (traversal->commit_visitor)
+		(*(traversal->commit_visitor))(commit, first_visit);
+}
+
+/*
+ * This function is called as each edge in the graph is identified. It 
+ * will always be called after visit_commit(...,from, 1). No guarantees
+ * are offered about when this call will be made w.r.t. to the call
+ * to visit_commit(..., to, 1)
+ */
+static void visit_edge(struct traversal * traversal, struct commit * from, struct commit * to)
+{
+	/*
+	 * pre-condition:
+	 * 	from->object.flags & SEEN &&
+	 * 	to->object.util => (to->object.flags & SEEN)
+	 */ 
+	if (traversal->edge_visitor)
+		(*(traversal->edge_visitor))(from, to);
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
+static int emit_commit(struct traversal * traversal, struct commit * commit)
+{
+	return (*(traversal->emitter))(commit);
+}
+
+/*
+ * Invoke a call back method to allow the tactics to release and storage
+ * allocated during a previous visit_commit or visit_edge call.
+ */
+static void clean_commit(struct traversal * traversal, struct commit * commit)
+{
+	if (traversal->clean)
+		(*(traversal->clean))(commit);
+	commit->object.util = NULL;
+	commit->object.flags &= ~(TRAVERSAL_FLAGS);
+	/*
+	 * post-condition:
+	 * 	commit->object.util == NULL && !(commit->object.flag & TRAVERSAL_FLAGS)
+	 */		
+}
+
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
+void init_traversal(struct traversal * traversal)
+{
+	memset(traversal, 0, sizeof(*traversal));
+}
+
+/*
+ * Sort the epoch in (adjusted) merge order.
+ */
+static void sort_unvisited(
+	struct commit *head, 
+	struct commit_list **stack, 
+	struct traversal * traversal)
+{
+	struct commit_list *parents = NULL;
+        struct commit * top = *stack?(*stack)->item:NULL;
+
+	if (IS_SEEN(head)) {
+		if (!IS_BASE(head)) {
+			visit_commit(traversal, head, 0);
+		}
+		return;
+	}
+	head->object.flags |= SEEN;
+        if (IS_BASE(head)) {
+		ASSERT(!top, "stack empty on visit to base", head);
+	} else {
+		if (!head->object.util) {
+                        parents = copy_parents_in_header_order(head);
+		} else {
+			parents = (struct commit_list *)head->object.util;
+                        head->object.util = NULL;
+		}
+		visit_commit(traversal, head, 1);
+		while (parents) {
+			struct commit *parent = pop_commit(&parents);
+
+			visit_edge(traversal, head, parent);
+			sort_unvisited(parent, stack, traversal);
+		}		
+		commit_list_insert(head, stack);	
+        }
+}
+
+/*
+ * Emit the contents of the stack.
+ * The stack is freed and replaced by NULL.
+ * Sets the return value to STOP if the traversal should stop.
+ */
+static int emit_stack(struct commit_list **stack, struct traversal * traversal)
+{
+	int stop = 0;
+
+	while (*stack) {
+		struct commit *next = pop_commit(stack);
+		
+		stop = stop || (emit_commit(traversal, next)==STOP);
+		clean_commit(traversal, next);
+	}
+	return stop ? STOP : CONTINUE;
+}
+
+/*
+ * Copy the parents of the commit and store the head of the list
+ * in object.util. Return the address of object.util itself.
+ */
+static struct commit_list ** copy_and_store_parents(struct commit * commit)
+{
+	struct commit_list * copied=copy_parents_in_header_order(commit);
+
+        commit->object.util = copied;
+	return (struct commit_list **)&commit->object.util;
+}
+
+/*
+ * Sort a list of commits in local first order. A commit is "local" 
+ * if any of its ancestors (except the base) causes (*local_test)() to 
+ * return a non-zero value.
+ *
+ * The sorted list is returned in *sorted. A side effect of this function 
+ * is to set each object.util pointer in each ancestor up until the base 
+ * to a list of parents is sorted in local first order.
+ *
+ * Does nothing if the list is empty.
+ * 
+ * The return value contains LOCAL if any of the list is local or had a 
+ * local ancestor.
+ */
+static unsigned int sort_local_branches_first(struct commit_list ** list, struct traversal * traversal)
+{
+	struct commit_list *local = NULL;
+	struct commit_list **local_tail = &local;
+	struct commit_list **non_local_ptr;
+
+	ASSERT(traversal->local_test, "local_test method is defined", NULL);
+	if (!*list) {
+		return 0;
+	}
+	for (non_local_ptr = list; *non_local_ptr; ) {
+		struct commit *item = (*non_local_ptr)->item;
+		
+		/*
+		 * We don't descend past the base or visit
+		 * a commit we have already visited.
+                 */
+		if (!IS_BASE(item) && !item->object.util) {
+			struct commit_list ** copied;
+			
+			if ((*(traversal->local_test)) (item))
+				item->object.flags |= LOCAL;
+			copied=copy_and_store_parents(item);
+			item->object.flags 
+			    |= sort_local_branches_first(copied, traversal);
+		}
+		/**
+		 * Move local items onto their own list.
+                 */
+		if (IS_LOCAL(item))
+			local_tail = move_commit(local_tail, non_local_ptr);
+		else
+			non_local_ptr = &(*non_local_ptr)->next;
+	}
+	/*
+         * Splice the non-local list onto the end of the local
+         * list, set head of the list to the head of the local list
+         * return if the LOCAL flag set if we have any local branches
+         */
+        *local_tail = *list;
+        *list = local;
+	return ((*list)->item->object.flags & LOCAL);
+}
+
+/*
+ * Sorting a maximal linear epoch involves traversing until we
+ * reach the base and emitting as we go. We don't emit the base
+ * now.
+ */
+static int sort_maximal_linear_epoch(struct commit *head, struct traversal * traversal)
+{
+	struct commit * next;
+	int stop = 0;
+	
+	/* invoke the visitors, if any */
+	if (traversal->commit_visitor || traversal->edge_visitor) {
+		for (next = head; !IS_BASE(next); next = next->parents->item) {
+			visit_commit(traversal, next, 1);
+			visit_edge(traversal, next, next->parents->item);
+		}
+	}		
+	/* now emit the nodes, and mark the base*/
+	for (next = head; !IS_BASE(next); next = next->parents->item) {
+		stop = stop || (emit_commit(traversal, next)==STOP);
+		clean_commit(traversal, next);
+	}
+	return stop ? STOP : CONTINUE;
+}
+
+/*
+ * Sorting a minimal non-linear epoch involves recursively apply
+ * sort_unvisited after doing a local_branches_first sort to the
+ * parents of each commit in the epoch, if required, then emitting
+ * the stack.
+ */
+static int sort_minimal_non_linear_epoch(struct commit *head, struct traversal * traversal)
+{
+	struct commit_list *stack = NULL;	
+
+	if (traversal->local_test) 
+		sort_local_branches_first(copy_and_store_parents(head),	traversal);
+	sort_unvisited(head, &stack, traversal);
+	return emit_stack(&stack, traversal);
+}
+
+/*
+ * see commit-graph.h
+ */
+int traverse_from_head(struct commit *head, struct traversal * traversal)
+{
+	struct commit *next = head;
+	int ret = 0;
+
+	ret = parse_commit(next);
+	if (ret) 
+		return ret; 
+        next->object.flags |= BOUNDARY;
+	while (next && next->parents && continue_traversal(traversal, next)) { 
+		struct commit *base = NULL;
+		int next_action = CONTINUE;
+
+		/* scan to the base of the current epoch */
+		ret = find_next_epoch_boundary(next, &base);
+		
+		/* abort if we detected a parsing error */
+		if (ret)
+			return ret; /* parsing failure */
+			
+		/* mark the new base so we know when to stop sorting */
+		if (base)
+			base->object.flags |= (BOUNDARY|BASE);
+			
+		/* reset flags set by last iteration */
+		next->object.flags &= ~(BASE|SEEN);
+		
+		/* sort with the optimal algorithm */
+		if (HAS_EXACTLY_ONE_PARENT(next))
+			next_action = sort_maximal_linear_epoch(next, traversal);
+		else
+			next_action = sort_minimal_non_linear_epoch(next, traversal);
+			
+		/* stop or iterate */			
+		if (next_action == STOP)
+			return 0; 
+		else					
+			next = base;
+	}
+	if (next) {
+		emit_commit(traversal, next);
+		clean_commit(traversal, next);
+	}
+	return 0;
+}
+
+/*
+ * see commit-graph.h
+ *
+ * Traverses the nodes reachable from a starting list in merge order, we
+ * first find the base for the starting list and then sort all nodes
+ * in this subgraph using the sort_unvisited algorithm. Once we have
+ * reached the base we can continue sorting using traverse_from_head.
+ */
+int traverse_from_list(struct commit_list *list, struct traversal * traversal)
+{
+	struct commit_list *stack = NULL;
+	struct commit *base;
+	int ret = 0;
+
+	if (!traversal) 
+		die("traversal argument must not be null");
+	if (!traversal->emitter)
+		die("an emitter method must be supplied");
+	if (list->next) {
+		struct commit_list * copy=NULL;
+
+		/* 
+		 * Make a copy of the list we can sort.
+		 */
+		for(;list;list=list->next) {
+			commit_list_insert(list->item, &copy);
+		}
+		list=copy;
+
+		/*
+		 * With multiple items to start the search with,
+		 * we first sort the list into local order (if required)
+		 * 
+		 * This behaves as if a commit was performed which
+		 * referenced the list as parents. This
+		 * would create a minimal, non-linear epoch.
+		 */		 
+		ret = find_base_for_list(list, &base);
+		if (ret)
+			return ret; /* parsing failure */
+
+		/* mark the termination condition*/
+		if (base)
+			base->object.flags |= (BOUNDARY|BASE);
+
+		/* sort local branches first, so they print last */			
+		if (traversal->local_test)
+			sort_local_branches_first(&list, traversal);			
+
+		/* sort the unvisited part of the epoch in merge order */
+		while (list)
+			sort_unvisited(pop_commit(&list), &stack, traversal);
+		
+		/* output the stack */
+		if (emit_stack(&stack, traversal) == STOP) 
+			return STOP;			
+	} else {
+		/*
+		 * With only one item on the list, we just use
+		 * sort in merge order which handles maximal
+		 * linear epochs as well as minimal, non-linear epochs.
+		 */
+		base = list->item;
+	} 
+
+        /* sort the rest with the sort_in_merge_order algorithm. */
+	if (base)
+		ret = traverse_from_head(base, traversal);
+	return ret;
+}
+
diff --git a/traversal.h b/traversal.h
--- a/traversal.h
+++ b/traversal.h
@@ -1 +1,91 @@
-/* workaround for git-apply issue */
+#ifndef TRAVERSAL_H
+#define TRAVERSAL_H
+
+/**
+ * Flags used by merge order logic and also by rev-list.c
+ */
+#define SEEN                    (1u<<0)
+#define BOUNDARY                (SEEN<<1)
+#define LOCAL                   (BOUNDARY<<1)
+#define BASE                    (LOCAL<<1)
+#define LAST_TRAVERSAL_FLAG     (BASE)
+
+#define TRAVERSAL_FLAGS         (BOUNDARY|SEEN|LOCAL|BASE)
+
+/**
+ * Return codes for emitter method. Also used by rev-list.c
+ */
+#define STOP           0
+#define CONTINUE       1
+#define DO             2
+
+struct traversal {
+	/*
+	 * Returns 0 if traversal should stop, non-zero if it should continue.
+	 */
+	int (*emitter)(struct commit *);
+
+	/* 
+	 * Returns non-zero if the commit is regarded "local", 0 otherwise.
+	 */
+	int (*local_test)(struct commit *);
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
+	 */
+	void (*clean)(struct commit *);
+
+	/*
+	 * Called at each epoch boundary. Implementers may return
+	 * non-zero if the traversal into the next epoch should
+	 * be stopped.
+	 */
+	int (*continue_traversal)(struct commit *);
+}
+;
+
+/**
+ * Initializes a traversal structure which
+ * may be customized by the caller by overriding any of the method pointers.
+ */
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
+
+/**
+ * Traverses the commit graph from the head commit listed. In other
+ * respects, like traverse_from_list.
+ */
+extern int traverse_from_head(struct commit *head, struct traversal * traversal);
+#endif	/* TRAVERSAL_H */
------------
