From: jon@blackcubes.dyndns.org
Subject: [PATCH] Modify git-rev-list ... in merge order [ repost with bug fixes ]
Date: 5 Jun 2005 13:47:33 -0000
Message-ID: <20050605134733.3123.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun Jun 05 15:48:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DevS5-0001vS-UV
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 15:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVFENtg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 09:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVFENtg
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 09:49:36 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:36481 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261565AbVFENrg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 09:47:36 -0400
Received: (qmail 3124 invoked by uid 500); 5 Jun 2005 13:47:33 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Modify git-rev-list to linearise the commit history in merge order.

This patch linearises the GIT commit history graph into merge order 
which is defined by invariants specified in Documentation/git-rev-list.txt.

The linearisation produced by this patch is superior in an objective sense 
to that produced by the existing git-rev-list implementation in that 
the linearisation produced is guaranteed to have the minimum number of 
discontinuities, where a discontinuity is defined as an adjacent pair of 
commits in the output list which are not related in a direct child-parent 
relationship.

With this patch a graph like this:

a4 ---
| \   \
|  b4 |
|/ |  |
a3 |  |
|  |  |
a2 |  |
|  |  c3
|  |  |
|  |  c2
|  b3 |
|  | /|
|  b2 |
|  |  c1
|  | /
|  b1
a1 |
|  |
a0 |
| /
root

Sorts like this:

= a4
| c3
| c2
| c1
^ b4
| b3
| b2
| b1
^ a3
| a2
| a1
| a0
= root

Instead of this:

= a4
| c3
^ b4
| a3
^ c2
^ b3
^ a2
^ b2
^ c1
^ a1
^ b1
^ a0
= root

A test script, t/t6000-rev-list.sh, includes a test which demonstrates
that the linearisation produced by --merge-order has less discontinuities
than the linearisation produced by git-rev-list without the --merge-order
flag specified. To see this, do the following:

	cd t
	./t6000-rev-list.sh
	cd trash
	cat actual-default-order
	cat actual-merge-order
	
The existing behaviour of git-rev-list is preserved, by default. To obtain 
the modified behaviour, specify --merge-order or --merge-order --show-breaks 
on the command line.

This version of the patch has been tested on the git repository and also on the linux-2.6
repository and has reasonable performance on both - ~50-100% slower than the original algorithm.

This version of the patch has incorporated a functional equivalent of the Linus' output limiting
algorithm into the merge-order algorithm itself. This operates per the notes associated 
with Linus' commit 337cb3fb8da45f10fe9a0c3cf571600f55ead2ce [ note: some bugs in my patch's 
support of this functionality have now been fixed ]

For more details about this change, refer to Documentation/git-rev-list.txt 
and http://blackcubes.dyndns.org/epoch/.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>

Diverged from 337cb3fb8da45f10fe9a0c3cf571600f55ead2ce by Linus Torvalds <torvalds@ppc970.osdl.org>
---
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -9,7 +9,7 @@ git-rev-list - Lists commit objects in r
 
 SYNOPSIS
 --------
-'git-rev-list' <commit>
+'git-rev-list' [ *--max-count*=number ] [ *--max-age*=timestamp ] [ *--min-age*=timestamp ] [ *--merge-order* [ *--show-breaks* ] ] <commit>
 
 DESCRIPTION
 -----------
@@ -17,11 +17,39 @@ Lists commit objects in reverse chronolo
 given commit, taking ancestry relationship into account.  This is
 useful to produce human-readable log output.
 
+If *--merge-order* is specified, the commit history is decomposed into a unique sequence of minimal, non-linear
+epochs and maximal, linear epochs. Non-linear epochs are then linearised by sorting them into merge order, which 
+is described below.
+
+Maximal, linear epochs correspond to periods of sequential development. Minimal, non-linear epochs 
+correspond to periods of divergent development followed by a converging merge. The theory of epochs is described
+in more detail at link:http://blackcubes.dyndns.org/epoch/[http://blackcubes.dyndns.org/epoch/].
+
+The merge order for a non-linear epoch is defined as a linearisation for which the following invariants are true:
+
+    1. if a commit P is reachable from commit N, commit P sorts after commit N in the linearised list.
+    2. if Pi and Pj are any two parents of a merge M (with i < j), then any commit N, such that N is reachable from Pj
+       but not reachable from Pi, sorts before all commits reachable from Pi.
+   
+Invariant 1 states that later commits appear before earlier commits they are derived from.
+
+Invariant 2 states that commits unique to "later" parents in a merge, appear before all commits from "earlier" parents of
+a merge.
+
+If *--show-breaks* is specified, each item of the list is output with a 2-character prefix consisting of one of: 
+ (|), (^), (=) followed by a space. 
+Commits marked with (=) represent the boundaries of minimal, non-linear epochs and correspond either to the start of a period of divergent development or to the end of such a period. 
+Commits marked with (|) are direct parents of commits immediately preceding the marked commit in the list.
+Commits marked with (^) are not parents of the immediately preceding commit. These "breaks" represent necessary discontinuities implied by trying to represent an arbtirary DAG in a linear form.
+
+*--show-breaks* is only valid if *--merge-order* is also specified.
 
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
 
+Original *--merge-order* logic by Jon Seymour <jon.seymour@gmail.com>
+
 Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -40,9 +40,9 @@ install: $(PROG) $(SCRIPTS)
 	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bin)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
-	 tag.o delta.o date.o index.o diff-delta.o patch-delta.o
+	 tag.o delta.o date.o index.o diff-delta.o patch-delta.o epoch.o
 LIB_FILE=libgit.a
-LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h
+LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h epoch.h
 
 LIB_H += strbuf.h
 LIB_OBJS += strbuf.o
@@ -134,6 +134,7 @@ diffcore-pathspec.o : $(LIB_H) diffcore.
 diffcore-pickaxe.o : $(LIB_H) diffcore.h
 diffcore-break.o : $(LIB_H) diffcore.h
 diffcore-order.o : $(LIB_H) diffcore.h
+epoch.o: $(LIB_H)
 
 test: all
 	$(MAKE) -C t/ all
diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -129,7 +129,7 @@ void free_commit_list(struct commit_list
 	}
 }
 
-static void insert_by_date(struct commit_list **list, struct commit *item)
+void insert_by_date(struct commit_list **list, struct commit *item)
 {
 	struct commit_list **pp = list;
 	struct commit_list *p;
@@ -254,3 +254,25 @@ unsigned long pretty_print_commit(const 
 	buf[offset] = '\0';
 	return offset;
 }
+
+struct commit *pop_commit(struct commit_list **stack)
+{
+	struct commit_list *top = *stack;
+	struct commit *item = top ? top->item : NULL;
+
+	if (top) {
+		*stack = top->next;
+		free(top);
+	}
+	return item;
+}
+
+int count_parents(struct commit * commit)
+{
+        int count = 0;
+        struct commit_list * parents = commit->parents;
+        for (count=0;parents; parents=parents->next,count++)
+          ;
+        return count;
+}
+
diff --git a/commit.h b/commit.h
--- a/commit.h
+++ b/commit.h
@@ -32,6 +32,8 @@ void free_commit_list(struct commit_list
 
 void sort_by_date(struct commit_list **list);
 
+void insert_by_date(struct commit_list **list, struct commit *item);
+
 extern unsigned long pretty_print_commit(const char *msg, unsigned long len, char *buf, unsigned long space);
 
 
@@ -41,4 +43,7 @@ extern unsigned long pretty_print_commit
 struct commit *pop_most_recent_commit(struct commit_list **list, 
 				      unsigned int mark);
 
+struct commit *pop_commit(struct commit_list **stack);
+
+int count_parents(struct commit * commit);
 #endif /* COMMIT_H */
diff --git a/epoch.c b/epoch.c
new file mode 100644
--- /dev/null
+++ b/epoch.c
@@ -0,0 +1,640 @@
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
+#include <openssl/bn.h>		// provides arbitrary precision integers required to accurately represent fractional mass
+#include "cache.h"
+#include "commit.h"
+#include "epoch.h"
+
+struct fraction {
+	BIGNUM numerator;
+	BIGNUM denominator;
+};
+
+#define HAS_EXACTLY_ONE_PARENT(n) ((n)->parents && !(n)->parents->next)
+
+static BN_CTX *context = NULL;
+static struct fraction *one = NULL;
+static struct fraction *zero = NULL;
+
+static BN_CTX *get_BN_CTX()
+{
+	if (!context) {
+		context = BN_CTX_new();
+	}
+	return context;
+}
+
+static struct fraction *new_zero()
+{
+	struct fraction *result = xmalloc(sizeof(*result));
+	BN_init(&result->numerator);
+	BN_init(&result->denominator);
+	BN_zero(&result->numerator);
+	BN_one(&result->denominator);
+	return result;
+}
+
+static void clear_fraction(struct fraction *fraction)
+{
+	BN_clear(&fraction->numerator);
+	BN_clear(&fraction->denominator);
+}
+
+static struct fraction *divide(struct fraction *result, struct fraction *fraction, int divisor)
+{
+	BIGNUM bn_divisor;
+
+	BN_init(&bn_divisor);
+	BN_set_word(&bn_divisor, divisor);
+
+	BN_copy(&result->numerator, &fraction->numerator);
+	BN_mul(&result->denominator, &fraction->denominator, &bn_divisor, get_BN_CTX());
+
+	BN_clear(&bn_divisor);
+	return result;
+}
+
+static struct fraction *init_fraction(struct fraction *fraction)
+{
+	BN_init(&fraction->numerator);
+	BN_init(&fraction->denominator);
+	BN_zero(&fraction->numerator);
+	BN_one(&fraction->denominator);
+	return fraction;
+}
+
+static struct fraction *get_one()
+{
+	if (!one) {
+		one = new_zero();
+		BN_one(&one->numerator);
+	}
+	return one;
+}
+
+static struct fraction *get_zero()
+{
+	if (!zero) {
+		zero = new_zero();
+	}
+	return zero;
+}
+
+static struct fraction *copy(struct fraction *to, struct fraction *from)
+{
+	BN_copy(&to->numerator, &from->numerator);
+	BN_copy(&to->denominator, &from->denominator);
+	return to;
+}
+
+static struct fraction *add(struct fraction *result, struct fraction *left, struct fraction *right)
+{
+	BIGNUM a, b, gcd;
+
+	BN_init(&a);
+	BN_init(&b);
+	BN_init(&gcd);
+
+	BN_mul(&a, &left->numerator, &right->denominator, get_BN_CTX());
+	BN_mul(&b, &left->denominator, &right->numerator, get_BN_CTX());
+	BN_mul(&result->denominator, &left->denominator, &right->denominator, get_BN_CTX());
+	BN_add(&result->numerator, &a, &b);
+
+	BN_gcd(&gcd, &result->denominator, &result->numerator, get_BN_CTX());
+	BN_div(&result->denominator, NULL, &result->denominator, &gcd, get_BN_CTX());
+	BN_div(&result->numerator, NULL, &result->numerator, &gcd, get_BN_CTX());
+
+	BN_clear(&a);
+	BN_clear(&b);
+	BN_clear(&gcd);
+
+	return result;
+}
+
+static int compare(struct fraction *left, struct fraction *right)
+{
+	BIGNUM a, b;
+
+	int result;
+
+	BN_init(&a);
+	BN_init(&b);
+
+	BN_mul(&a, &left->numerator, &right->denominator, get_BN_CTX());
+	BN_mul(&b, &left->denominator, &right->numerator, get_BN_CTX());
+
+	result = BN_cmp(&a, &b);
+
+	BN_clear(&a);
+	BN_clear(&b);
+
+	return result;
+}
+
+struct mass_counter {
+	struct fraction seen;
+	struct fraction pending;
+};
+
+static struct mass_counter *new_mass_counter(struct commit *commit, struct fraction *pending)
+{
+	struct mass_counter *mass_counter = xmalloc(sizeof(*mass_counter));
+	memset(mass_counter, 0, sizeof(*mass_counter));
+
+	init_fraction(&mass_counter->seen);
+	init_fraction(&mass_counter->pending);
+
+	copy(&mass_counter->pending, pending);
+	copy(&mass_counter->seen, get_zero());
+
+	if (commit->object.util) {
+		die("multiple attempts to initialize mass counter for %s\n", sha1_to_hex(commit->object.sha1));
+	}
+
+	commit->object.util = mass_counter;
+
+	return mass_counter;
+}
+
+static void free_mass_counter(struct mass_counter *counter)
+{
+	clear_fraction(&counter->seen);
+	clear_fraction(&counter->pending);
+	free(counter);
+}
+
+//
+// Finds the base commit of a list of commits.
+//
+// One property of the commit being searched for is that every commit reachable from the base commit is reachable
+// from the commits in the starting list only via paths that include the base commit.
+//
+// This algorithm uses a conservation of mass approach to find the base commit.
+//
+// We start by injecting one unit of mass into the graph at each
+// of the commits in the starting list. Injecting mass into a commit
+// is achieved by adding to its pending mass counter and, if it is not already
+// enqueued, enqueuing the commit in a list of pending commits, in latest commit date
+// first order.
+//
+// The algorithm then preceeds to visit each commit in the pending queue.
+// Upon each visit, the pending mass is added to the mass already seen for that commit and
+// then divided into N equal portions, where N is the number of parents
+// of the commit being visited. The divided portions are then injected into each of
+// the parents.
+//
+// The algorithm continues until we discover a commit which has seen all the
+// mass originally injected or until we run out of things to do. 
+//
+// If we find a commit that has seen all the original mass, we have found
+// the common base of all the commits in the starting list. 
+//
+// The algorithm does _not_ depend on accurate timestamps for correct operation.
+// However, reasonably sane (e.g. non-random) timestamps are required in order to prevent an exponential
+// performance characteristic. The occasional timestamp inaccuracy will not dramatically
+// affect performance but may result in more nodes being processed than strictly necessary.
+//
+// This procedure sets *boundary to the address of the base commit. It returns non-zero if, and only if,
+// there was a problem parsing one of the commits discovered during the traversal.
+//
+static int find_base_for_list(struct commit_list *list, struct commit **boundary)
+{
+
+	int ret = 0;
+
+	struct commit_list *cleaner = NULL;
+	struct commit_list *pending = NULL;
+
+	*boundary = NULL;
+
+	struct fraction injected;
+
+	init_fraction(&injected);
+
+	for (; list; list = list->next) {
+	
+		if (list->item->object.util) {
+			fprintf(stderr, 
+				"%s:%d:duplicate commit %s discarded.\n", 
+				__FILE__, 
+				__LINE__, 
+				sha1_to_hex(list->item->object.sha1));
+			continue;
+		}
+	
+		if (!(list->item->object.flags & UNINTERESTING)) {
+		
+			new_mass_counter(list->item, get_one());			
+			add(&injected, &injected, get_one());
+			
+			commit_list_insert(list->item, &cleaner);
+			commit_list_insert(list->item, &pending);
+		}
+		
+	}
+
+	while (!*boundary && pending && !ret) {
+
+		struct commit *latest = pop_commit(&pending);
+		
+		struct mass_counter *latest_node = (struct mass_counter *) latest->object.util;
+
+		if ((ret = parse_commit(latest)))
+			continue;
+
+		add(&latest_node->seen, &latest_node->seen, &latest_node->pending);
+
+		int num_parents = count_parents(latest);
+
+		if (num_parents) {
+
+			struct fraction distribution;
+			struct commit_list *parents;
+
+			divide(init_fraction(&distribution), &latest_node->pending, num_parents);
+
+			for (parents = latest->parents; parents; parents = parents->next) {
+			
+				struct commit *parent = parents->item;
+				struct mass_counter *parent_node = (struct mass_counter *) parent->object.util;
+				
+				if (!parent_node) {
+				
+					parent_node = new_mass_counter(parent, &distribution);
+					
+					insert_by_date(&pending, parent);
+					commit_list_insert(parent, &cleaner);
+					
+				} else {
+				
+					if (!compare(&parent_node->pending, get_zero())) {
+						insert_by_date(&pending, parent);
+					}
+					add(&parent_node->pending, &parent_node->pending, &distribution);
+					
+				}
+			}
+			
+			clear_fraction(&distribution);
+			
+		}
+
+		if (!compare(&latest_node->seen, &injected)) {
+			*boundary = latest;
+		}
+
+		copy(&latest_node->pending, get_zero());
+
+	}
+
+	while (cleaner) {
+	
+		struct commit *next = pop_commit(&cleaner);
+		free_mass_counter((struct mass_counter *) next->object.util);
+		next->object.util = NULL;
+		
+	}
+
+	if (pending)
+		free_commit_list(pending);
+		
+	clear_fraction(&injected);
+
+	return ret;
+
+}
+
+
+//
+// Finds the base of an minimal, non-linear epoch, headed at head, by
+// applying the find_base_for_list to a list consisting of the head.
+//
+static int find_base(struct commit *head, struct commit **boundary)
+{
+	int ret = 0;
+	struct commit_list *pending = NULL;
+        struct commit_list *next;
+
+	commit_list_insert(head, &pending);
+	for (next = head->parents; next; next = next->next) {
+	          commit_list_insert(next->item, &pending);
+        }
+	ret = find_base_for_list(pending, boundary);
+	free_commit_list(pending);
+
+	return ret;
+}
+
+//
+// This procedure traverses to the boundary of the first epoch in the epoch
+// sequence of the epoch headed at head_of_epoch. This is either the end of
+// the maximal linear epoch or the base of a minimal non-linear epoch.
+//
+// The queue of pending nodes is sorted in reverse date order and each node
+// is currently in the queue at most once.
+//
+static int find_next_epoch_boundary(struct commit *head_of_epoch, struct commit **boundary)
+{
+	int ret;
+	struct commit *item = head_of_epoch;
+
+	ret = parse_commit(item);
+	if (ret)
+		return ret;
+
+	if (HAS_EXACTLY_ONE_PARENT(item)) {
+
+		// we are at the start of a maximimal linear epoch .. traverse to the end
+
+		// traverse to the end of a maximal linear epoch
+		while (HAS_EXACTLY_ONE_PARENT(item) && !ret) {
+			item = item->parents->item;
+			ret = parse_commit(item);
+		}
+		*boundary = item;
+
+	} else {
+
+		// otherwise, we are at the start of a minimal, non-linear
+		// epoch - find the common base of all parents.
+
+		ret = find_base(item, boundary);
+
+	}
+
+	return ret;
+}
+
+//
+// Returns non-zero if parent is known to be a parent of child.
+//
+static int is_parent_of(struct commit *parent, struct commit *child)
+{
+	struct commit_list *parents;
+	for (parents = child->parents; parents; parents = parents->next) {
+		if (!memcmp(parent->object.sha1, parents->item->object.sha1, sizeof(parents->item->object.sha1)))
+			return 1;
+	}
+	return 0;
+}
+
+//
+// Pushes an item onto the merge order stack. If the top of the stack is
+// marked as being a possible "break", we check to see whether it actually
+// is a break.
+//
+static void push_onto_merge_order_stack(struct commit_list **stack, struct commit *item)
+{
+	struct commit_list *top = *stack;
+	if (top && (top->item->object.flags & DISCONTINUITY)) {
+		if (is_parent_of(top->item, item)) {
+			top->item->object.flags &= ~DISCONTINUITY;
+		}
+	}
+	commit_list_insert(item, stack);
+}
+
+//
+// Sorts the nodes of the first epoch of the epoch sequence of the epoch headed at head
+// into merge order.
+//
+static void sort_first_epoch(struct commit *head, struct commit_list **stack)
+{
+	struct commit_list *parents;
+	struct commit_list *reversed_parents = NULL;
+
+	head->object.flags |= VISITED;
+
+	//
+	// parse_commit builds the parent list in reverse order with respect to the order of
+	// the git-commit-tree arguments.
+	//
+	// so we need to reverse this list to output the oldest (or most "local") commits last.
+	//
+
+	for (parents = head->parents; parents; parents = parents->next)
+		commit_list_insert(parents->item, &reversed_parents);
+
+	//
+	// todo: by sorting the parents in a different order, we can alter the 
+	// merge order to show contemporaneous changes in parallel branches
+	// occurring after "local" changes. This is useful for a developer
+	// when a developer wants to see all changes that were incorporated
+	// into the same merge as her own changes occur after her own
+	// changes.
+	//
+
+	while (reversed_parents) {
+
+		struct commit *parent = pop_commit(&reversed_parents);
+
+		if (head->object.flags & UNINTERESTING) {
+			parent->object.flags |= UNINTERESTING;
+		}
+
+		if (!(parent->object.flags & VISITED)) {
+			if (parent->object.flags & BOUNDARY) {
+			
+				if (*stack) {
+					die("something else is on the stack - %s\n", sha1_to_hex((*stack)->item->object.sha1));
+				}
+				
+				push_onto_merge_order_stack(stack, parent);
+				parent->object.flags |= VISITED;
+				
+			} else {
+
+				sort_first_epoch(parent, stack);
+
+				if (reversed_parents) {
+					//
+					// this indicates a possible discontinuity
+					// it may not be be actual discontinuity if
+					// the head of parent N happens to be the tail
+					// of parent N+1
+					//
+					// the next push onto the stack will resolve the question
+					//
+					(*stack)->item->object.flags |= DISCONTINUITY;
+				}
+			}
+		}
+	}
+
+	push_onto_merge_order_stack(stack, head);
+}
+
+//
+// Emit the contents of the stack. 
+//
+// Set a non-zero value if we have seen an uninteresting element while
+// writing out the stack.
+//
+static int emit_stack(struct commit_list ** stack, emitter_func emitter)
+{
+	unsigned int uninteresting = 0;
+	unsigned int seen = 0;
+	int stop = 0;
+
+	while (*stack && !stop) {
+
+ 	        struct commit * next = pop_commit(stack);
+
+		if (next->object.flags & DISCONTINUITY) {
+			// reset the uninteresting flag
+			uninteresting = (next->object.flags & UNINTERESTING);
+		} else {
+			// inherit the uninteresting flag from parent that was on the stack
+			uninteresting |= (next->object.flags & UNINTERESTING);
+		}
+		
+		next->object.flags |= uninteresting;		
+		seen |= next->object.flags;
+
+		if (*stack) {
+			stop = (*emitter) (next);
+		}
+	}
+	
+	if (*stack) {
+		free_commit_list(*stack);
+		*stack = NULL;
+	}
+	
+	return stop || (seen & UNINTERESTING);
+}	
+
+//
+// Sorts an arbitrary epoch into merge order by sorting each epoch
+// of its epoch sequence into order.
+//
+// Note: this algorithm currently leaves traces of its execution in the
+// object flags of nodes it discovers. This should probably be fixed.
+//
+static int sort_in_merge_order(struct commit *head_of_epoch, emitter_func emitter)
+{
+	struct commit *next = head_of_epoch;
+	int ret = 0;
+	int stop = 0;
+
+	ret = parse_commit(head_of_epoch);
+
+	while (next && next->parents && !ret && !stop) {
+
+		struct commit *base = NULL;
+
+		if ((ret = find_next_epoch_boundary(next, &base)))
+			return ret;
+
+		next->object.flags |= BOUNDARY;
+		if (base) {
+		        base->object.flags |= BOUNDARY;
+		}
+
+		if (HAS_EXACTLY_ONE_PARENT(next)) {
+
+			while (HAS_EXACTLY_ONE_PARENT(next) && !stop && !ret) {
+			
+				stop = (next->object.flags & UNINTERESTING) || (*emitter) (next);
+				next = next->parents->item;
+				ret = parse_commit(next);				
+				
+			}
+			
+		} else {
+
+			struct commit_list *stack = NULL;						
+			sort_first_epoch(next, &stack);						
+			stop = emit_stack(&stack, emitter);
+                        next = base;
+		}
+
+	}
+
+	if (next && !stop) {
+		stop = (*emitter) (next);
+	}
+
+	return ret;
+}
+
+//
+// Sorts the nodes reachable from a starting list in merge order, we 
+// first find the base for the starting list and then sort all nodes in this subgraph
+// using the sort_first_epoch algorithm. Once we have reached the base
+// we can continue sorting using sort_in_merge_order.
+//
+int sort_list_in_merge_order(struct commit_list *list, emitter_func emitter)
+{
+	struct commit_list *stack = NULL;
+	struct commit *base;
+
+	int ret = 0;
+	int stop = 0;
+
+	struct commit_list *reversed = NULL;
+
+	for (; list; list = list->next) {
+	        struct commit * next = list->item;
+ 	        if (!(next->object.flags & UNINTERESTING)) {
+		        if (next->object.flags & DUPCHECK) { 
+			        fprintf(stderr, "%s: duplicate commit %s ignored\n", __FUNCTION__, sha1_to_hex(next->object.sha1));
+                        } else {
+			        next->object.flags |= DUPCHECK;
+		                commit_list_insert(list->item, &reversed);
+                        }
+                }
+        }
+
+	if (!reversed->next) {
+	
+		// if there is only one element in the list, we can sort it using 
+		// sort_in_merge_order.
+
+		base = reversed->item;
+
+	} else {
+	
+		// otherwise, we search for the base of the list
+
+		if ((ret = find_base_for_list(reversed, &base)))
+			return ret;
+
+		if (base) {
+		        base->object.flags |= BOUNDARY;
+		}
+
+		while (reversed) {
+			sort_first_epoch(pop_commit(&reversed), &stack);
+			if (reversed) {
+				//
+				// if we have more parents to push, then the
+				// first push for the next parent may (or may not)
+				// represent a discontinuity with respect to the
+				// parent currently on the top of the stack.
+				//
+				// mark it for checking here, and check it
+				// with the next push...see sort_first_epoch for
+				// more details.
+				//
+ 			        stack->item->object.flags |= DISCONTINUITY;
+			}
+		}
+		
+		stop = emit_stack(&stack, emitter);
+	}
+
+	if (!stop && base) {
+		ret = sort_in_merge_order(base, emitter);
+	}
+
+	return ret;
+}
diff --git a/epoch.h b/epoch.h
new file mode 100644
--- /dev/null
+++ b/epoch.h
@@ -0,0 +1,14 @@
+#ifndef EPOCH_H
+#define EPOCH_H
+
+
+typedef int (*emitter_func) (struct commit *); 
+int sort_list_in_merge_order(struct commit_list *list, emitter_func emitter);
+
+#define UNINTERESTING  (1u<<2)
+#define BOUNDARY       (1u<<3)
+#define VISITED        (1u<<4)
+#define DISCONTINUITY  (1u<<5)
+#define DUPCHECK       (1u<<6)
+
+#endif				/* EPOCH_H */
diff --git a/git-resolve-script b/git-resolve-script
old mode 100644
new mode 100755
diff --git a/object.h b/object.h
--- a/object.h
+++ b/object.h
@@ -15,6 +15,7 @@ struct object {
 	const char *type;
 	struct object_list *refs;
 	struct object_list *attached_deltas;
+	void *util;
 };
 
 extern int nr_objs;
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -1,9 +1,9 @@
 #include "cache.h"
 #include "commit.h"
+#include "epoch.h"
 
 #define SEEN		(1u << 0)
 #define INTERESTING	(1u << 1)
-#define UNINTERESTING	(1u << 2)
 
 static const char rev_list_usage[] =
 	"usage: git-rev-list [OPTION] commit-id <commit-id>\n"
@@ -11,7 +11,8 @@ static const char rev_list_usage[] =
 		      "  --max-age=epoch\n"
 		      "  --min-age=epoch\n"
 		      "  --header\n"
-		      "  --pretty";
+		      "  --pretty\n"
+		      "  --merge-order [ --show-breaks ]";
 
 static int verbose_header = 0;
 static int show_parents = 0;
@@ -21,27 +22,49 @@ static const char *prefix = "";
 static unsigned long max_age = -1;
 static unsigned long min_age = -1;
 static int max_count = -1;
+static int merge_order = 0;
+static int show_breaks = 0;
 
-static void show_commit(struct commit *commit)
+static int show_commit(struct commit *commit)
 {
-	printf("%s%s", prefix, sha1_to_hex(commit->object.sha1));
-	if (show_parents) {
-		struct commit_list *parents = commit->parents;
-		while (parents) {
-			printf(" %s", sha1_to_hex(parents->item->object.sha1));
-			parents = parents->next;
-		}
-	}
-	putchar('\n');
-	if (verbose_header) {
-		const char *buf = commit->buffer;
-		if (pretty_print) {
-			static char pretty_header[16384];
-			pretty_print_commit(commit->buffer, ~0, pretty_header, sizeof(pretty_header));
-			buf = pretty_header;
-		}
-		printf("%s%c", buf, hdr_termination);
+	if (commit->object.flags & UNINTERESTING)
+		return 0;
+	if (min_age != -1 && (commit->date > min_age))
+		return 0;
+	if (max_age != -1 && (commit->date < max_age))
+		return 1;
+	if (max_count != -1 && !max_count--)
+		return 1;
+
+	if (!show_breaks) {
+		printf("%s%s", prefix, sha1_to_hex(commit->object.sha1));	
+		if (show_parents) {
+			struct commit_list *parents = commit->parents;
+			while (parents) {
+				printf(" %s", sha1_to_hex(parents->item->object.sha1));
+				parents = parents->next;
+			}
+		}
+		putchar('\n');
+		if (verbose_header) {
+			const char *buf = commit->buffer;
+			if (pretty_print) {
+				static char pretty_header[16384];
+				pretty_print_commit(commit->buffer, ~0, pretty_header, sizeof(pretty_header));
+				buf = pretty_header;
+			}
+			printf("%s%c", buf, hdr_termination);
+		}
+	} else {
+		char c='|';
+		if (commit->object.flags &DISCONTINUITY) {
+			c = '^';     
+		} else if (commit->object.flags & BOUNDARY) {
+			c = '=';
+		} 
+		printf("%c %s\n", c, sha1_to_hex(commit->object.sha1));
 	}
+        return 0;
 }
 
 static void show_commit_list(struct commit_list *list)
@@ -49,15 +72,8 @@ static void show_commit_list(struct comm
 	while (list) {
 		struct commit *commit = pop_most_recent_commit(&list, SEEN);
 
-		if (commit->object.flags & UNINTERESTING)
-			continue;
-		if (min_age != -1 && (commit->date > min_age))
-			continue;
-		if (max_age != -1 && (commit->date < max_age))
-			break;
-		if (max_count != -1 && !max_count--)
-			break;
-		show_commit(commit);
+		if (show_commit(commit)) 
+			break;         
 	}
 }
 
@@ -141,6 +157,14 @@ int main(int argc, char **argv)
 			show_parents = 1;
 			continue;
 		}
+		if (!strncmp(arg, "--merge-order", 13)) {
+		        merge_order = 1;
+			continue;
+		}
+		if (!strncmp(arg, "--show-breaks", 13)) {
+			show_breaks = 1;
+			continue;
+		}
 
 		flags = 0;
 		if (*arg == '^') {
@@ -148,7 +172,7 @@ int main(int argc, char **argv)
 			arg++;
 			limited = 1;
 		}
-		if (get_sha1(arg, sha1))
+		if (get_sha1(arg, sha1) || (show_breaks && !merge_order))
 			usage(rev_list_usage);
 		commit = lookup_commit_reference(sha1);
 		if (!commit || parse_commit(commit) < 0)
@@ -160,9 +184,18 @@ int main(int argc, char **argv)
 	if (!list)
 		usage(rev_list_usage);
 
-	if (limited)
-		list = limit_list(list);
 
-	show_commit_list(list);
+	
+	if (!merge_order) {
+	        if (limited)
+		          list = limit_list(list);
+
+		show_commit_list(list);
+        } else {
+                if (sort_list_in_merge_order(list, &show_commit)) {
+                        die("merge order sort failed\n");
+                }
+        }
+
 	return 0;
 }
diff --git a/t/t6000-rev-list.sh b/t/t6000-rev-list.sh
new file mode 100755
--- /dev/null
+++ b/t/t6000-rev-list.sh
@@ -0,0 +1,173 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Jon Seymour
+#
+
+test_description='Test rev-list --merge-order
+'
+. ./test-lib.sh
+
+function do_commit
+{
+    git-commit-tree "$@" </dev/null
+}
+
+function check_adjacency
+{
+    read previous
+    echo "= $previous"
+    while read next
+    do
+        if ! (git-cat-file commit $previous | grep "^parent $next" >/dev/null)
+        then
+            echo "^ $next"
+        else
+            echo "| $next"
+        fi
+        previous=$next
+    done
+}
+
+function sed_script
+{
+   for c in root a0 a1 a2 a3 a4 b1 b2 b3 b4 c1 c2 c3 l0 l1 l2 l3 l4 l5
+   do
+       echo -n "s/${!c}/$c/;"
+   done
+}
+
+date >path0
+git-update-cache --add path0
+tree=$(git-write-tree)
+root=$(do_commit $tree 2>/dev/null)
+export GIT_COMMITTER_NAME=foobar  # to guarantee that the commit is different
+l0=$(do_commit $tree -p $root)
+l1=$(do_commit $tree -p $l0)
+l2=$(do_commit $tree -p $l1)
+a0=$(do_commit $tree -p $l2)
+a1=$(do_commit $tree -p $a0)
+export GIT_COMMITTER_NAME=foobar2 # to guarantee that the commit is different
+b1=$(do_commit $tree -p $root)
+c1=$(do_commit $tree -p $b1)
+export GIT_COMMITTER_NAME=foobar3 # to guarantee that the commit is different
+b2=$(do_commit $tree -p $b1)
+b3=$(do_commit $tree -p $b2)
+c2=$(do_commit $tree -p $c1 -p $b2)
+c3=$(do_commit $tree -p $c2)
+a2=$(do_commit $tree -p $a1)
+a3=$(do_commit $tree -p $a2)
+b4=$(do_commit $tree -p $b3 -p $a3)
+a4=$(do_commit $tree -p $a3 -p $b4 -p $c3)
+l3=$(do_commit $tree -p $a4)
+l4=$(do_commit $tree -p $l3)
+l5=$(do_commit $tree -p $l4)
+echo $l5 > .git/HEAD
+
+git-rev-list --merge-order --show-breaks HEAD | sed "$(sed_script)" > actual-merge-order
+cat > expected-merge-order <<EOF
+= l5
+| l4
+| l3
+= a4
+| c3
+| c2
+| c1
+^ b4
+| b3
+| b2
+| b1
+^ a3
+| a2
+| a1
+| a0
+| l2
+| l1
+| l0
+= root
+EOF
+
+git-rev-list HEAD | check_adjacency | sed "$(sed_script)" > actual-default-order
+normal_adjacency_count=$(git-rev-list HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
+merge_order_adjacency_count=$(git-rev-list --merge-order HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
+
+test_expect_success 'Testing that the rev-list has correct number of entries' '[ $(git-rev-list HEAD | wc -l) -eq 19 ]'
+test_expect_success 'Testing that --merge-order produces the correct result' 'diff expected-merge-order actual-merge-order'
+test_expect_success 'Testing that --merge-order produces as many or fewer discontinuities' '[ $merge_order_adjacency_count -le $normal_adjacency_count ]'
+
+cat > expected-merge-order-1 <<EOF
+c3
+c2
+c1
+b3
+b2
+b1
+a3
+a2
+a1
+a0
+l2
+l1
+l0
+root
+EOF
+
+git-rev-list --merge-order $a3 $b3 $c3 | sed "$(sed_script)" > actual-merge-order-1
+test_expect_success 'Testing multiple heads' 'diff expected-merge-order-1 actual-merge-order-1'
+
+cat > expected-merge-order-2 <<EOF
+c3
+c2
+c1
+b3
+b2
+b1
+a3
+a2
+EOF
+
+git-rev-list --merge-order $a3 $b3 $c3 ^$a1 | sed "$(sed_script)" > actual-merge-order-2
+test_expect_success 'Testing stop' 'diff expected-merge-order-2 actual-merge-order-2'
+
+cat > expected-merge-order-3 <<EOF
+c3
+c2
+c1
+b3
+b2
+b1
+a3
+a2
+a1
+a0
+l2
+EOF
+
+git-rev-list --merge-order $a3 $b3 $c3 ^$l1 | sed "$(sed_script)" > actual-merge-order-3
+test_expect_success 'Testing stop in linear epoch' 'diff expected-merge-order-3 actual-merge-order-3'
+
+cat > expected-merge-order-4 <<EOF
+l5
+l4
+l3
+a4
+c3
+c2
+c1
+b4
+b3
+b2
+b1
+a3
+a2
+a1
+a0
+l2
+EOF
+
+git-rev-list --merge-order $l5 ^$l1 | sed "$(sed_script)" > actual-merge-order-4
+test_expect_success 'Testing start in linear epoch, stop after non-linear epoch' 'diff expected-merge-order-4 actual-merge-order-4'
+
+git-rev-list --merge-order $l5 $l5 ^$l1 2>/dev/null | sed "$(sed_script)" > actual-merge-order-5
+test_expect_success 'Testing duplicated start arguments' 'diff expected-merge-order-4 actual-merge-order-5'
+
+test_done
