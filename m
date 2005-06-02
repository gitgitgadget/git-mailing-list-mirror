From: jon@blackcubes.dyndns.org
Subject: [PATCH] Modify git-rev-list ... [ resend to fix whitespace mangle ]
Date: 2 Jun 2005 15:49:57 -0000
Message-ID: <20050602154957.29316.qmail@blackcubes.dyndns.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 17:53:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdryK-0002yA-SX
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 17:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVFBPyA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 11:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVFBPyA
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 11:54:00 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:1408 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261173AbVFBPuB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 11:50:01 -0400
Received: (qmail 29317 invoked by uid 500); 2 Jun 2005 15:49:57 -0000
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

A test script, t/t5000-rev-list.sh, includes a test which demonstrates
that the linearisation produced by --merge-order has less discontinuities
than the linearisation produced by git-rev-list without the --merge-order
flag specified. To see this, do the following:

	cd t
	./t5000-rev-list.sh
	cd trash
	cat actual-default-order
	cat actual-merge-order
	
The existing behaviour of git-rev-list is preserved, by default. To obtain 
the modified behaviour, specify --merge-order or --merge-order --show-breaks 
on the command line.

This version of the patch has been tested on the git repository and also on the linux-2.6
repository and has reasonable performance on both.

For more details about this change, refer to Documentation/git-rev-list.txt 
and http://blackcubes.dyndns.org/epoch/.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
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
@@ -0,0 +1,454 @@
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
+// Finds the base node of an epoch.
+//
+// This algorithm uses a conservation of mass approach.
+//
+// The head starts with a weight of 1 and distributes equal portions
+// along each edge to each of its parents. The process continues until 
+// one node discovers that it has acquired a total mass of 1 from its
+// descendents. This node is the base node.
+//
+// Importantly the queue of nodes to be processed is sorted in
+// reverse date order and each node occupies at most one 
+// position in the queue simultaneously. These two properties
+// do not effect the algorithm's correctness. However assuming most, but
+// not all, timestamps are sane they do prevent the algorithm becoming
+// exponential by ensuring that most nodes are only visited once.
+// This is true because mass is only propagated through the network
+// when we are pretty sure we are not going to see any more coming
+// our way. The occasional bad timestamp will mean that we are
+// wrong, occasionally, but this does not matter too much.
+//
+static int find_base(struct commit *head, struct commit **boundary)
+{
+	int ret = 0;
+
+	struct commit_list *cleaner = NULL;
+	struct commit_list *pending = NULL;
+
+	*boundary = NULL;
+
+	// we inject a mass of 1 unit here
+
+	new_mass_counter(head, get_one());
+
+	commit_list_insert(head, &pending);
+	commit_list_insert(head, &cleaner);
+
+	while (!*boundary && pending && !ret) {
+
+		struct commit *latest = pop_commit(&pending);
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
+
+			divide(init_fraction(&distribution), &latest_node->pending, num_parents);
+
+			struct commit_list *parents;
+
+			for (parents = latest->parents; parents; parents = parents->next) {
+				struct commit *parent = parents->item;
+				struct mass_counter *parent_node = (struct mass_counter *) parent->object.util;
+				if (!parent_node) {
+					parent_node = new_mass_counter(parent, &distribution);
+					commit_list_insert(parent, &cleaner);
+					insert_by_date(&pending, parent);
+				} else {
+					if (!compare(&parent_node->pending, get_zero())) {
+						copy(&parent_node->pending, &distribution);
+						insert_by_date(&pending, parent);
+					} else {
+						add(&parent_node->pending, &parent_node->pending, &distribution);
+					}
+				}
+			}
+		}
+
+		if (!compare(&latest_node->seen, get_one()) && (latest != head)) {
+			// if this node has seen one unit of mass, it must be the base, so mark
+			// the boundary which will cause the loop to stop.
+			*boundary = latest;
+		}
+
+		copy(&latest_node->pending, get_zero());
+
+	}
+
+	for (; cleaner;) {
+		struct commit *next = pop_commit(&cleaner);
+		free_mass_counter((struct mass_counter *) next->object.util);
+		next->object.util = NULL;
+	}
+
+	if (pending)
+		free_commit_list(pending);
+
+	return ret;
+
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
+static void push_onto_merge_order_stack(struct commit_list **stack, struct commit *item)
+{
+	struct commit_list *top = *stack;
+	if (top && (top->item->object.flags & MERGE_ORDER_BREAK_FLAG)) {
+		if (is_parent_of(top->item, item)) {
+			top->item->object.flags &= ~MERGE_ORDER_BREAK_FLAG;
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
+	parse_commit(head);
+
+	head->object.flags |= MERGE_ORDER_VISIT_FLAG;
+
+	struct commit_list *parents;
+
+	struct commit_list *reversed_parents = NULL;
+
+	//
+	// parse_commit builds the parent list in reverse order with respect to the order of
+	// the git-commit-tree arguments.
+	//
+	// so we need to reverse this list to output the oldest (or most "local") commits last.
+	//
+
+	for (parents = head->parents; parents; parents = parents->next) {
+		commit_list_insert(parents->item, &reversed_parents);
+	}
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
+	for (; reversed_parents;) {
+		struct commit *parent = pop_commit(&reversed_parents);
+		parse_commit(parent);
+		if (!(parent->object.flags & MERGE_ORDER_VISIT_FLAG)) {
+			if (parent->object.flags & MERGE_ORDER_EPOCH_FLAG) {
+				if (*stack) {
+					die("something else is on the stack - %s\n", sha1_to_hex((*stack)->item->object.sha1));
+				}
+				push_onto_merge_order_stack(stack, parent);
+				parent->object.flags |= MERGE_ORDER_VISIT_FLAG;
+			} else {
+				sort_first_epoch(parent, stack);
+				if (reversed_parents) {
+					//
+					// this indicates a possible discontinuity
+					// it may not be be actual discontinuity if
+					// the head of parent N happens to be the tail
+					// of parent N+1
+					//
+					// the next push onto the stack will resolve the question
+					//
+					(*stack)->item->object.flags |= MERGE_ORDER_BREAK_FLAG;
+				}
+			}
+		}
+	}
+
+	push_onto_merge_order_stack(stack, head);
+}
+
+//
+// Sorts an arbitrary epoch into merge order by sorting each epoch
+// of its epoch sequence into order.
+//
+// Note: this algorithm currently leaves traces of its execution in the
+// object flags of nodes it discovers. This should probably be fixed.
+//
+int sort_in_merge_order(struct commit *head_of_epoch, emitter_func emitter)
+{
+	struct commit *next;
+	int ret = 0;
+	int stop = 0;
+
+	parse_commit(head_of_epoch);
+
+	for (next = head_of_epoch; next && next->parents && !ret && !stop;) {
+
+		struct commit *base = NULL;
+
+		ret = find_next_epoch_boundary(next, &base);
+		if (ret)
+			return ret;
+
+		next->object.flags |= MERGE_ORDER_EPOCH_FLAG;
+		if (base) {
+			base->object.flags |= MERGE_ORDER_EPOCH_FLAG;
+		}
+
+		if (HAS_EXACTLY_ONE_PARENT(next)) {
+
+			while (HAS_EXACTLY_ONE_PARENT(next) && !stop && !ret) {
+				stop = (*emitter) (next);
+				next = next->parents->item;
+				ret = parse_commit(next);
+			}
+
+		} else {
+
+			struct commit_list *stack = NULL;
+			sort_first_epoch(next, &stack);
+			for (; stack && !stop;) {
+				next = pop_commit(&stack);
+				if (stack) {
+					stop = (*emitter) (next);
+				}
+			}
+			if (stack) {
+				free_commit_list(stack);
+			}
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
diff --git a/epoch.h b/epoch.h
new file mode 100644
--- /dev/null
+++ b/epoch.h
@@ -0,0 +1,12 @@
+#ifndef EPOCH_H
+#define EPOCH_H
+
+typedef int (*emitter_func) (struct commit *);
+
+int sort_in_merge_order(struct commit *head_of_epoch, emitter_func emitter);
+
+#define MERGE_ORDER_EPOCH_FLAG (1u<<3)
+#define MERGE_ORDER_VISIT_FLAG (1u<<4)
+#define MERGE_ORDER_BREAK_FLAG (1u<<5)
+
+#endif				/* EPOCH_H */
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
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "epoch.h"
 
 #define SEEN		(1u << 0)
 #define INTERESTING	(1u << 1)
@@ -11,7 +12,8 @@ static const char rev_list_usage[] =
 		      "  --max-age=epoch\n"
 		      "  --min-age=epoch\n"
 		      "  --header\n"
-		      "  --pretty";
+		      "  --pretty\n"
+		      "  --merge-order [ --show-breaks ]";
 
 static void mark_parents_uninteresting(struct commit *commit)
 {
@@ -36,18 +38,63 @@ static int everybody_uninteresting(struc
 	return 1;
 }
 
+static unsigned long max_age = -1;
+static unsigned long min_age = -1;
+static int max_count = -1;
+static int verbose_header = 0, show_parents = 0, pretty_print = 0, merge_order = 0, show_breaks = 0;
+static const char *prefix = "";
+static int hdr_termination = 0;
+
+static int process_commit(struct commit * commit)
+{
+	if (commit->object.flags & UNINTERESTING)
+		return 0;
+	if (min_age != -1 && (commit->date > min_age))
+		return 0;
+	if (max_age != -1 && (commit->date < max_age))
+		return 1;
+	if (max_count != -1 && !max_count--)
+		return 1;
+		
+        if (!show_breaks) {
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
+        } else {
+                char c='|';
+                if (commit->object.flags & MERGE_ORDER_BREAK_FLAG) {
+                  c = '^';     
+                } else if (commit->object.flags & MERGE_ORDER_EPOCH_FLAG) {
+                  c = '=';
+                } 
+                printf("%c %s\n", c, sha1_to_hex(commit->object.sha1));
+        }
+		
+        return 0;
+}
+
 int main(int argc, char **argv)
 {
 	int nr_sha;
 	unsigned char sha1[2][20];
 	struct commit_list *list = NULL;
 	struct commit *commit, *end;
-	int i, verbose_header = 0, show_parents = 0, pretty_print = 0;
-	int hdr_termination = 0;
-	const char *prefix = "";
-	unsigned long max_age = -1;
-	unsigned long min_age = -1;
-	int max_count = -1;
+	int i;
 
 	nr_sha = 0;
 	for (i = 1 ; i < argc; i++) {
@@ -80,8 +127,16 @@ int main(int argc, char **argv)
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
 
-		if (nr_sha > 2 || get_sha1(arg, sha1[nr_sha]))
+		if (nr_sha > 2 || get_sha1(arg, sha1[nr_sha])|| (show_breaks && !merge_order))
 			usage(rev_list_usage);
 		nr_sha++;
 	}
@@ -118,36 +173,19 @@ int main(int argc, char **argv)
 		} while (list);
 		list = newlist;
 	}
+	
+	if (!merge_order) {
+		while (list) {
+			struct commit *commit = pop_most_recent_commit(&list, SEEN);		
+			if (process_commit(commit)) {
+			       break;
+                        }
+		}
+        } else {
+                if (sort_in_merge_order(commit, &process_commit)) {
+                        die("merge order sort failed\n");
+                }
+        }
 
-	while (list) {
-		struct commit *commit = pop_most_recent_commit(&list, SEEN);
-
-		if (commit->object.flags & UNINTERESTING)
-			continue;
-		if (min_age != -1 && (commit->date > min_age))
-			continue;
-		if (max_age != -1 && (commit->date < max_age))
-			break;
-		if (max_count != -1 && !max_count--)
-			break;
-		printf("%s%s", prefix, sha1_to_hex(commit->object.sha1));
-		if (show_parents) {
-			struct commit_list *parents = commit->parents;
-			while (parents) {
-				printf(" %s", sha1_to_hex(parents->item->object.sha1));
-				parents = parents->next;
-			}
-		}
-		putchar('\n');
-		if (verbose_header) {
-			const char *buf = commit->buffer;
-			if (pretty_print) {
-				static char pretty_header[16384];
-				pretty_print_commit(commit->buffer, ~0, pretty_header, sizeof(pretty_header));
-				buf = pretty_header;
-			}
-			printf("%s%c", buf, hdr_termination);
-		}
-	}
 	return 0;
 }
diff --git a/t/t5000-rev-list.sh b/t/t5000-rev-list.sh
new file mode 100755
--- /dev/null
+++ b/t/t5000-rev-list.sh
@@ -0,0 +1,85 @@
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
+   for c in root a0 a1 a2 a3 a4 b1 b2 b3 b4 c1 c2 c3
+   do
+       echo -n "s/${!c}/$c/;"
+   done
+}
+
+date >path0
+git-update-cache --add path0
+tree=$(git-write-tree)
+root=$(do_commit $tree)
+export GIT_COMMITTER_NAME=foobar  # to guarantee that the commit is different
+a0=$(do_commit $tree -p $root)
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
+echo $a4 > .git/HEAD
+
+git-rev-list --merge-order --show-breaks HEAD | sed "$(sed_script)" > actual-merge-order
+cat > expected-merge-order <<EOF
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
+= root
+EOF
+
+git-rev-list HEAD | check_adjacency | sed "$(sed_script)" > actual-default-order
+normal_adjacency_count=$(git-rev-list HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
+merge_order_adjacency_count=$(git-rev-list --merge-order HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
+
+test_expect_success 'Testing that the rev-list has correct number of entries' '[ $(git-rev-list HEAD | wc -l) -eq 13 ]'
+test_expect_success 'Testing that --merge-order produces the correct result' 'diff expected-merge-order actual-merge-order'
+test_expect_success 'Testing that --merge-order produces as many or fewer discontinuities' '[ $merge_order_adjacency_count -le $normal_adjacency_count ]'
+
+test_done
