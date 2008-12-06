From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v3 2/2] fetch-pack: log(n)-transmission find_common()
Date: Sun,  7 Dec 2008 00:20:21 +0100
Message-ID: <1228605621-29685-3-git-send-email-trast@student.ethz.ch>
References: <alpine.LFD.2.00.0810281034500.13034@xanadu.home>
 <1228605621-29685-1-git-send-email-trast@student.ethz.ch>
 <1228605621-29685-2-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 07 00:22:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L96TK-0007er-SE
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 00:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbYLFXUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 18:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753318AbYLFXUc
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 18:20:32 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:22011 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233AbYLFXU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 18:20:29 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 7 Dec 2008 00:20:24 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 7 Dec 2008 00:20:24 +0100
X-Mailer: git-send-email 1.6.1.rc1.369.g2b340
In-Reply-To: <1228605621-29685-2-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 06 Dec 2008 23:20:24.0222 (UTC) FILETIME=[37408BE0:01C957F9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102485>

Replaces the existing simple history search with a more sophisticated
algorithm:

1) Walk history with exponentially increasing stride lengths; i.e.,
   send the 1st commit, then the 2nd after that, then the 4th after
   that, and so on.

2) Bisect the resulting intervals.

Combined with tracking the "outstanding haves" so that we can detect
which sha1s were never ACKed by upload-pack (and hence not common),
this gives O(log(n)) required "have" lines.

Unfortunately this cannot work if the server sends fake ACKs, so we
introduce a capability 'no-giveup' which instructs upload-pack to
disable ok_to_give_up().  (Which incidentally saves the server a lot
of work.)

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---
 builtin-fetch-pack.c |  789 +++++++++++++++++++++++++++++++++++++++++++++++++-
 upload-pack.c        |    7 +-
 2 files changed, 787 insertions(+), 9 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index ae0a67a..ea88e28 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -9,6 +9,7 @@
 #include "fetch-pack.h"
 #include "remote.h"
 #include "run-command.h"
+#include <string.h>
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -25,6 +26,14 @@ static const char fetch_pack_usage[] =
 #define COMMON_REF	(1U << 2)
 #define SEEN		(1U << 3)
 #define POPPED		(1U << 4)
+#define BISECTED_FW	(1U << 5)
+#define BISECTED_BW	(1U << 6)
+#define NOTCOMMON       (1U << 7)
+#define HAS_INFO        (1U << 8)
+#define PARSED_WITH_PARENTS (1U << 9)
+#define CLEAN_MARKS     (COMMON | COMMON_REF | SEEN | POPPED | BISECTED_FW \
+			 | BISECTED_BW | NOTCOMMON | HAS_INFO \
+			 | PARSED_WITH_PARENTS)
 
 static int marked;
 
@@ -34,8 +43,61 @@ static int marked;
  */
 #define MAX_IN_VAIN 256
 
+struct work_heap
+{
+	struct work_heap *next;
+	struct work_heap *prev;
+	struct work_item *item;
+};
+
+struct work_item
+{
+	/* Fibonacci heap data */
+	/* we don't need a parent pointer because we don't support changing keys */
+	struct work_item *child;
+	struct work_item *sibling;
+	int rank;
+	int marked;
+
+	/* actual content */
+	struct commit *commit;
+	unsigned int stride;  /* for stride mode */
+	unsigned int steps;
+	unsigned int depth;
+	unsigned int bisect;  /* for bisection mode */
+
+	/*
+	 * Helper array to generate the bisection order.  A size of 32
+	 * is ok as long as the history length is less than 2**32.
+	 */
+	struct commit **ladder;
+};
+
+/*
+ * "Recursion stack" of the exponential-stride algorithm
+ *
+ * This is a priority queue implemented as a Fibonacci heap since we
+ * expect to stuff a lot of commits into it.
+ */
+static struct work_heap *work_heap = NULL;
+static struct work_heap *work_min = NULL;
+
+/* list of commits not ACKed yet */
+static struct commit_list *outstanding = NULL;
+static struct commit_list *outstanding_end = NULL;
+
+struct commit_info
+{
+	struct commit_list *children;
+	struct commit_list *bisect_forward;
+	struct commit_list *bisect_backward;
+	struct commit_list *forward_bound;
+	struct commit_list *backward_bound;
+};
+
 static struct commit_list *rev_list;
 static int non_common_revs, multi_ack, use_sideband;
+static int exp_stride_algorithm;
 
 static void rev_list_push(struct commit *commit, int mark)
 {
@@ -68,8 +130,7 @@ static int clear_marks(const char *path, const unsigned char *sha1, int flag, vo
 	struct object *o = deref_tag(parse_object(sha1), path, 0);
 
 	if (o && o->type == OBJ_COMMIT)
-		clear_commit_marks((struct commit *)o,
-				   COMMON | COMMON_REF | SEEN | POPPED);
+		clear_commit_marks((struct commit *)o, CLEAN_MARKS);
 	return 0;
 }
 
@@ -107,6 +168,354 @@ static void mark_common(struct commit *commit,
 	}
 }
 
+static struct commit_info *get_commit_info(struct commit *commit)
+{
+	if (commit->object.flags & HAS_INFO)
+		return commit->util;
+
+	struct commit_info *info = xmalloc(sizeof(struct commit_info));
+	info->children = NULL;
+	info->bisect_forward = NULL;
+	info->bisect_backward = NULL;
+	info->forward_bound = NULL;
+	info->backward_bound = NULL;
+	commit->util = info;
+	commit->object.flags |= HAS_INFO;
+	return info;
+}
+
+static void add_child(struct commit *parent, struct commit *child)
+{
+	struct commit_info *info = get_commit_info(parent);
+	struct commit_list *item;
+	for (item = info->children; item; item = item->next)
+		if (item->item == child)
+			break;
+	if (!item)
+		commit_list_insert(child, &(info->children));
+}
+
+/* implemented further below */
+static void mark_not_common(struct commit *commit);
+
+static void check_parsed_and_mark(struct commit *commit)
+{
+	struct commit_list *parent;
+
+	if (!commit || commit->object.flags & PARSED_WITH_PARENTS)
+		return;
+
+	parse_commit(commit);
+
+	commit->object.flags |= PARSED_WITH_PARENTS;
+
+	for (parent = commit->parents; parent; parent = parent->next) {
+		add_child(parent->item, commit);
+		if (parent->item->object.flags & NOTCOMMON)
+			mark_not_common(commit);
+	}
+}
+
+static void work_item_free(struct work_item *item)
+{
+	if (!item->bisect)
+		free(item->ladder);
+	free(item);
+}
+
+/*
+ * Ordering imposed on the "recursion" that generates the commits.
+ * The smallest item is processed first.  To maintain the O(log n)
+ * transmissions bound we want to achieve, bisections must come after
+ * (compare >0) strides.
+ */
+
+static int work_item_cmp(struct work_item *a, struct work_item *b)
+{
+	if (a->bisect || b->bisect) {
+		/* bisections last */
+		if (a->bisect > b->bisect)
+			return 1;
+		else if (a->bisect < b->bisect)
+			return -1;
+
+		/* older commits later */
+		if (a->commit->date < b->commit->date)
+			return 1;
+		else if (a->commit->date == b->commit->date)
+			return 0;
+		else
+			return -1;
+	} else {
+		/* deeper sidelines of history later */
+		if (a->depth > b->depth)
+			return 1;
+		else if (a->depth < b->depth)
+			return -1;
+
+		/* older commits later */
+		if (a->commit->date < b->commit->date)
+			return 1;
+		else if (a->commit->date == b->commit->date)
+			return 0;
+		else
+			return -1;
+	}
+}
+
+/*
+ * Insert/remove items from the work_heap.  _pop() always returns the
+ * smallest one.
+ */
+
+static void work_heap_insert_internal(struct work_item *item)
+{
+	struct work_heap *entry = xmalloc(sizeof(struct work_heap));
+	entry->item = item;
+
+	if (!work_heap) {
+		entry->prev = entry;
+		entry->next = entry;
+		work_heap = entry;
+		work_min = work_heap;
+		return;
+	}
+
+	entry->next = work_heap;
+	entry->prev = work_heap->prev;
+	work_heap->prev = entry;
+	entry->prev->next = entry;
+	if (!work_min || work_item_cmp(item, work_min->item) < 0)
+		work_min = entry;
+	work_heap = entry;
+}
+
+static void work_heap_insert(struct work_item *item)
+{
+	item->marked = 0;
+	item->child = NULL;
+	item->sibling = NULL;
+	item->rank = 0;
+
+	work_heap_insert_internal(item);
+}
+
+static struct work_item *work_heap_pop(void)
+{
+	struct work_heap *entry = work_min;
+	struct work_item *x, *y, *t;
+	struct work_item *child, *item;
+	/* The rank of any child in a Fib heap of size n can be at
+	 * most log_{3/2}(n), and we only support 2**32 items
+	 * anyway */
+	struct work_item *ranks[55] = {0,};
+	int i;
+
+	if (!entry)
+		return NULL;
+
+	if (entry == entry->prev) {
+		work_heap = NULL;
+		work_min = NULL;
+		item = entry->item;
+		free(entry);
+		for (child = item->child; child; child = child->sibling) {
+			child->marked = 0;
+			work_heap_insert_internal(child);
+		}
+		return item;
+	}
+
+	work_heap = entry->next;
+	entry->next->prev = entry->prev;
+	entry->prev->next = entry->next;
+	item = entry->item;
+	free(entry);
+	work_min = NULL;
+
+	for (child = item->child; child; child = child->sibling) {
+		child->marked = 0;
+		work_heap_insert_internal(child);
+	}
+
+	while (work_heap) {
+		entry = work_heap;
+		if (entry == entry->prev) {
+			work_heap = NULL;
+		} else {
+			work_heap = entry->next;
+			entry->next->prev = entry->prev;
+			entry->prev->next = entry->next;
+		}
+		x = entry->item;
+		free(entry);
+		while ((y = ranks[x->rank])) {
+			ranks[x->rank] = NULL;
+			if (work_item_cmp(x, y) > 0) {
+				t = x;
+				x = y;
+				y = t;
+			}
+			y->sibling = x->child;
+			x->child = y;
+			x->rank++;
+		}
+		ranks[x->rank] = x;
+	}
+
+	for (i = 0; i < 55; i++)
+		if (ranks[i])
+			work_heap_insert_internal(ranks[i]);
+
+	return item;
+}
+
+static void work_insert_stride(struct commit *commit, int stride,
+			       int steps, int depth, struct commit **ladder)
+{
+	struct work_item *item = xmalloc(sizeof(struct work_item));
+	check_parsed_and_mark(commit);
+	item->commit = commit;
+	item->stride = stride;
+	item->steps = steps;
+	item->depth = depth;
+	item->bisect = 0;
+	item->ladder = xmalloc(32*sizeof(struct commit *));
+	if (ladder)
+		memcpy(item->ladder, ladder, 32*sizeof(struct commit *));
+	work_heap_insert(item);
+}
+
+static void work_insert_bisect(struct commit *commit, int bisect)
+{
+	struct work_item *item = xmalloc(sizeof(struct work_item));
+	item->commit = commit;
+	item->stride = 0;
+	item->steps = 0;
+	item->depth = 0;
+	item->bisect = bisect;
+	item->ladder = NULL;
+	work_heap_insert(item);
+}
+
+static void work_insert_strides(struct commit_list *commits,
+				int stride, int steps, int depth, int depth2,
+				struct commit **ladder,
+				struct work_item *reusable_item)
+{
+	struct work_item *item = reusable_item;
+
+	while (commits) {
+		if (!(commits->item->object.flags &= SEEN)) {
+			if (!item)
+				item = xmalloc(sizeof(struct work_item));
+
+			item->commit = commits->item;
+			item->stride = stride;
+			item->steps = steps;
+			item->depth = depth;
+			item->bisect = 0;
+			item->ladder = xmalloc(32*sizeof(struct commit *));
+			if (ladder)
+				memcpy(item->ladder, ladder, 32*sizeof(struct commit *));
+			work_heap_insert(item);
+		}
+		commits = commits->next;
+		item = NULL;
+		depth = depth2;
+	}
+
+	if (item)
+		work_item_free(item);
+}
+
+static void work_insert_bisects(struct commit_list *commits,
+				int bisect,
+				struct work_item *reusable_item)
+{
+	struct work_item *item = reusable_item;
+
+	while (commits) {
+		if (!item)
+			item = xmalloc(sizeof(struct work_item));
+
+		item->commit = commits->item;
+		item->stride = 0;
+		item->steps = 0;
+		item->depth = 0;
+		item->bisect = bisect;
+		work_heap_insert(item);
+
+		commits = commits->next;
+		item = NULL;
+	}
+
+	if (item)
+		work_item_free(item);
+}
+
+static int work_heap_insert_ref(const char *path, const unsigned char *sha1,
+			       int flag, void *cb_data)
+{
+	struct object *o = deref_tag(parse_object(sha1), path, 0);
+
+	if (o && o->type == OBJ_COMMIT && !(o->flags & SEEN))
+		work_insert_stride((struct commit *)o, 0, 0, 0, NULL);
+
+	return 0;
+}
+
+
+/*
+ * Marks all (known) children of this commit NOTCOMMON.  We call this
+ * for all sha1s the server did not ACK.
+ */
+
+static void mark_not_common(struct commit *commit)
+{
+	struct commit_info *info = get_commit_info(commit);
+	struct commit_list *child;
+
+	assert(!(commit->object.flags & COMMON));
+
+	if (commit->object.flags & NOTCOMMON)
+		return;
+
+	commit->object.flags |= NOTCOMMON;
+
+	for (child = info->children; child; child = child->next)
+		mark_not_common(child->item);
+}
+
+/*
+ * Similar for the ACKed ones.  We have a _new() version because the
+ * old one interacts with the work queue.
+ */
+
+static void mark_common_new(struct commit *commit, int ancestors_only, int dont_parse)
+{
+	struct commit_list *parents;
+	struct object *o;
+
+	if (commit == NULL || commit->object.flags & (COMMON_REF|COMMON))
+		return;
+
+	if (!dont_parse && !(commit->object.parsed))
+		check_parsed_and_mark(commit);
+
+	o = (struct object *)commit;
+
+	if (!ancestors_only)
+		o->flags |= COMMON;
+
+	for (parents = commit->parents; parents; parents = parents->next) {
+		add_child(parents->item, commit);
+		mark_common_new(parents->item, 0, dont_parse);
+	}
+}
+
+
+
 /*
   Get the next rev to send, ignoring the common.
 */
@@ -156,6 +565,330 @@ static struct commit* get_rev(void)
 	return commit;
 }
 
+
+int flag_in_list(int flag, struct commit_list *list)
+{
+	while (list) {
+		if (list->item->object.flags & flag)
+			return 1;
+		list = list->next;
+	}
+	return 0;
+}
+
+
+/*
+ * Find the second bit set in x, similar to ffs() from string.h.
+ * Assumes that x>0.
+ */
+
+int fss(int x)
+{
+	return ffs(x - (1<<(ffs(x)-1)));
+}
+
+/*
+ * The exponential-stride algorithm, part 1 and 1.5.
+ *
+ * We take exponential strides through history, that is we emit the
+ * 1st commit, the 2nd, the 4th, etc.  But we also simultaneously
+ * build pointers that help us bisect later: Every commit has a
+ * bisect_forward and bisect_backward list (if history is linear, both
+ * have at most 1 element) that tells us where to continue bisection
+ * after this.
+ *
+ * To achieve this with good running time, we think of the commits in
+ * a line of history as being numbered in binary:
+ *
+ *        o 1000
+ *        o  111
+ *        o  110   <- current   [1]
+ *        o  101                [0]
+ *  t |	  o  100                [2]
+ *  i |	  o   11
+ *  m |	  o   10
+ *  e v	  o    1
+ *
+ * Every commit of the form 10...0 is emitted, since it is an
+ * exponential step.  Between that, we want to have
+ * (100).bisect_backward=[110], (110).bisect_forward=[101],
+ * (110).bisect_backward=[111], etc.  Define the lowest bit set (as
+ * per ffs()-1) in a commit as its "order", then we can achieve this
+ * by keeping track of the last commit of every order (marked with [n]
+ * in the diagram) as we go through history.  Then [n] must be on
+ * [n+1].bisect_backward and [n-1] must be on [n].bisect_forward.
+ *
+ * Similarly, we track the boundaries forward_bound and
+ * backward_bound, which indicate the furthest commit(s) that can be
+ * reached by bisecting this one.  We use them to detect when it
+ * becomes pointless to pursue this branch of the bisection because
+ * the far end is already COMMON (NOTCOMMON) in forward (backward)
+ * mode.  In the scheme chosen, a current commit [n] numbered N is a
+ * backward boundary of [i] for all i=0..n, and [fss(N)-1] is a
+ * forward boundary of the current [n].
+ *
+ * The tough problem is if we stop (because we hit a root, or a part
+ * of history that we've already seen) at a non-exp-stride commit.
+ * Then we must ensure that all history up to the current commit can
+ * be reached by bisecting.  Consider
+ *
+ *        o 1000
+ *        o  111
+ *        o  110
+ *        o  101   <- current   [0]
+ *  t |	  o  100                [2]
+ *  i |	  o   11
+ *  m |	  o   10                [1]
+ *  e v	  o    1
+ *
+ * then stopping at the commit 101 without any corrective measures
+ * would leave it unreachable because the intermediate step 110 has
+ * not been seen yet.
+ *
+ * Observe that any given commit x10z, where x is arbitrary and z only
+ * zeros, has outgoing pointers to x01z (forward) and x11z (backward).
+ * Conversely this means x01z needs an incoming forward pointer from
+ * x10z, even if we haven't seen it yet.  So there are two cases:
+ *
+ * SEEN CASE: We stopped because we hit a SEEN commit.  Assume that
+ * the last commit not SEEN is numbered x1y1z, where x is arbitrary
+ * and y and z are only zeros (z possibly empty).  Then unless y is
+ * empty, x1y'01z needs an incoming forward pointer from x1y'10z
+ * (where y'0=y), which we haven't seen yet.  Repeat until y is empty.
+ * Note that during this repetition, we might hit a root commit.
+ *
+ * ROOT CASE: We cannot fix this with forward pointers since there are
+ * no commits left to put them in.  Assume that the root commit is
+ * numbered x1y1z as in the SEEN case.  Then we fix by pointing a
+ * backwards pointer from x1y'00z to x1y'01z, then iterate with
+ * x1y'00z.  Note that x1y'00z is the last seen commit of order
+ * fss(x1y1z).
+ *
+ * Note that we only need to bisect (first level) exp-stride commits
+ * in one direction.  We choose backward.  This choice needs to be
+ * consistent among get_rev_new_stride() and get_rev_new(), and it
+ * happens to match the faster code path of get_rev_new_bisect().
+ */
+
+static struct commit *get_rev_new_stride(struct work_item *item)
+{
+	struct commit_info *info;
+	struct commit *commit = item->commit;
+	int steps = item->steps;
+	int stride = item->stride;
+	int depth = item->depth;
+	int order = -1;
+	struct commit **ladder = item->ladder;
+	int i;
+	/* The next two are for the pointer-fixing iterations */
+	int order2;
+	struct commit *commit2;
+
+	while (!(commit->object.flags & SEEN)) {
+		steps++;
+		order = ffs(steps)-1;
+
+		commit->object.flags |= SEEN;
+
+		if (order > 0 && stride == order) {
+			info = get_commit_info(ladder[order-1]);
+			commit_list_insert(commit, &info->backward_bound);
+			for (i = order-2; i>=0; i--) {
+				info = get_commit_info(ladder[i]);
+				commit_list_insert(commit, &info->backward_bound);
+			}
+		}
+
+		ladder[order] = commit;
+
+		if (stride == order) {
+			/* this is precisely a 2**k'th commit, emit it */
+			work_insert_strides(commit->parents, stride+1, steps,
+					    depth, depth+1, ladder, item);
+			return commit;
+		}
+
+		/*
+		 * We are the next step in the higher-order commit's
+		 * backward (in time) bisection
+		 */
+		info = get_commit_info(ladder[order+1]);
+		commit_list_insert(commit, &info->bisect_backward);
+		info = get_commit_info(commit);
+		commit_list_insert(ladder[fss(steps)-1], &info->forward_bound);
+
+		if (order > 0) {
+			/*
+			 * The lower-order commit is our next step for
+			 * forward (in time) bisection
+			 */
+			info = get_commit_info(commit);
+			commit_list_insert(ladder[order-1], &info->bisect_forward);
+			for (i = order-1; i >= 0; i--) {
+				info = get_commit_info(ladder[i]);
+				commit_list_insert(commit, &info->backward_bound);
+			}
+		}
+
+		if (commit->parents) {
+			work_insert_strides(commit->parents->next, stride,
+					    steps, depth+1, depth+1, ladder,
+					    NULL);
+			commit = commit->parents->item;
+			check_parsed_and_mark(commit);
+		} else {
+			/* ROOT CASE: fix missing pointers */
+			order2 = fss(steps)-1;
+			commit2 = commit;
+			while (order != order2-1 && order2 > 0) {
+				info = get_commit_info(ladder[order2]);
+				commit_list_insert(commit2, &info->bisect_backward);
+				info = get_commit_info(commit2);
+				commit_list_insert(ladder[order2], &info->forward_bound);
+				commit2 = ladder[order2];
+				steps -= 1 << order;
+				order = order2;
+				order2 = fss(steps)-1;
+			}
+			work_item_free(item);
+			return commit;
+		}
+	}
+
+	if (order == -1) {
+		/* this just means we hit a SEEN commit immediately */
+		work_item_free(item);
+		return  NULL;
+	}
+
+	/* SEEN CASE: fix missing pointers w.r.t. the _last_ commit
+	 * before this */
+
+	/* unless/until we hit a root, 'commit' tracks the steps
+	 * backward through the SEEN commits that we stick the
+	 * pointers in.  'order2' only serves to figure out if the 'y'
+	 * (see comment at function head) of 'commit' is empty. */
+	order2 = fss(steps)-1;
+	assert(order2 > order || order2 == 0);
+	while (order != order2-1 && order2 > 0) {
+		int i;
+		/* skip ahead to the next commit2 of order 'order+1' */
+		for (i = (1<<order); i > 0; i--) {
+			steps++;
+			assert (steps < (1<<stride));
+			if (commit->parents) {
+				commit = commit->parents->item;
+				check_parsed_and_mark(commit);
+				continue;
+			}
+			/* we hit a root commit! use the root strategy
+			 * for the rest */
+			order2 = fss(steps)-1;
+			commit2 = commit;
+			while (order != order2-1 && order2 > 0) {
+				info = get_commit_info(ladder[order2]);
+				commit_list_insert(commit2, &info->bisect_backward);
+				info = get_commit_info(commit2);
+				commit_list_insert(ladder[order2], &info->forward_bound);
+				commit2 = ladder[order2];
+				steps -= 1 << order;
+				order = order2;
+				order2 = fss(steps)-1;
+			}
+			/* short-cut out of the big loop */
+			work_item_free(item);
+			return NULL;
+		}
+		info = get_commit_info(commit);
+		commit_list_insert(ladder[order], &info->bisect_forward);
+		for (i = order; i >= 0; i--) {
+			info = get_commit_info(ladder[i]);
+			commit_list_insert(commit, &info->backward_bound);
+		}
+		order++;
+		/* this has not changed order2.  we still keep track
+		 * of 'steps' carefully in case we hit a root
+		 * commit. */
+	}
+
+	work_item_free(item);
+	return NULL;
+}
+
+/*
+ * The exponential-stride algorithm, part 2.
+ *
+ * Bisecting is now easy: just follow the forward/backward pointers,
+ * stopping when we already know enough to not search any further.
+ */
+
+static struct commit *get_rev_new_bisect(struct work_item *item)
+{
+	struct commit *commit = item->commit;
+	struct commit_info *info = get_commit_info(commit);
+	int flags = commit->object.flags;
+
+	if (!(flags & (BISECTED_FW|NOTCOMMON))
+	    && !flag_in_list(COMMON, info->forward_bound)) {
+		commit->object.flags |= BISECTED_FW;
+		work_insert_bisects(info->bisect_forward, item->bisect+1, NULL);
+		if (!(flags & (POPPED|COMMON))) {
+			/* re-queue for backward bisection */
+			work_heap_insert(item);
+			item = NULL;
+			return commit;
+		}
+	}
+
+	if (!(flags & (BISECTED_BW|COMMON))
+	    && !flag_in_list(NOTCOMMON, info->backward_bound)) {
+		commit->object.flags |= BISECTED_BW;
+		work_insert_bisects(info->bisect_backward, item->bisect+1, item);
+		item = NULL;
+		if (!(flags & (POPPED|NOTCOMMON)))
+			return commit;
+	}
+
+	if (item)
+		free(item);
+	return NULL;
+}
+
+
+static struct commit* get_rev_new(void)
+{
+	struct commit *commit = NULL;
+	struct work_item *item;
+
+	while (commit == NULL) {
+		item = work_heap_pop();
+		if (!item)
+			return NULL;
+		check_parsed_and_mark(item->commit);
+		if (item->bisect) {
+			commit = get_rev_new_bisect(item);
+		} else {
+			commit = get_rev_new_stride(item);
+			if (commit) {
+				/* there's no point in bisecting the
+				 * first level both ways */
+				commit->object.flags |= BISECTED_FW;
+				work_insert_bisect(commit, 1);
+			}
+		}
+	}
+
+	commit->object.flags |= POPPED;
+	return commit;
+}
+
+static void pop_outstanding(void)
+{
+	struct commit_list *item = outstanding;
+	outstanding = item->next;
+	free(item);
+}
+
 /*
  * Send 'have' for the next batch of revisions.  Returns 0 if we ran
  * out of commits to send, 1 otherwise.
@@ -167,7 +900,10 @@ static int send_have_lines(int fd[2], int *flushes, unsigned *in_vain)
 	int i;
 
 	for (i = 0; i < 32; i++) {
-		commit = get_rev();
+		if (exp_stride_algorithm)
+			commit = get_rev_new();
+		else
+			commit = get_rev();
 		if (!commit)
 			return 0;
 		packet_write(fd[1], "have %s\n",
@@ -175,6 +911,14 @@ static int send_have_lines(int fd[2], int *flushes, unsigned *in_vain)
 		if (args.verbose)
 			fprintf(stderr, "have %s\n",
 				sha1_to_hex(commit->object.sha1));
+
+		if (outstanding) {
+			commit_list_insert(commit, &(outstanding_end->next));
+			outstanding_end = outstanding_end->next;
+		} else {
+			commit_list_insert(commit, &outstanding);
+			outstanding_end = outstanding;
+		}
 	}
 	packet_flush(fd[1]);
 	*flushes += 1;
@@ -195,7 +939,10 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 		for_each_ref(clear_marks, NULL);
 	marked = 1;
 
-	for_each_ref(rev_list_insert_ref, NULL);
+	if (exp_stride_algorithm)
+		for_each_ref(work_heap_insert_ref, NULL);
+	else
+		for_each_ref(rev_list_insert_ref, NULL);
 
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
@@ -218,7 +965,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 		}
 
 		if (!fetching)
-			packet_write(fd[1], "want %s%s%s%s%s%s%s%s\n",
+			packet_write(fd[1], "want %s%s%s%s%s%s%s%s%s\n",
 				     sha1_to_hex(remote),
 				     (multi_ack ? " multi_ack" : ""),
 				     (use_sideband == 2 ? " side-band-64k" : ""),
@@ -226,6 +973,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 				     (args.use_thin_pack ? " thin-pack" : ""),
 				     (args.no_progress ? " no-progress" : ""),
 				     (args.include_tag ? " include-tag" : ""),
+				     (exp_stride_algorithm ? " no-giveup" : ""),
 				     " ofs-delta");
 		else
 			packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
@@ -294,12 +1042,31 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 			} else if (ack == 2) {
 				struct commit *commit =
 					lookup_commit(result_sha1);
-				mark_common(commit, 0, 1);
+				if (exp_stride_algorithm) {
+					while (commit != outstanding->item) {
+						if (args.verbose)
+							fprintf(stderr, "unwinding: %s\n", sha1_to_hex(outstanding->item->object.sha1));
+						mark_not_common(outstanding->item);
+						pop_outstanding();
+						unwound++;
+					}
+					pop_outstanding();
+					unwound++;
+					mark_common_new(commit, 0, 1);
+				} else {
+					mark_common(commit, 0, 1);
+				}
 				retval = 0;
 				in_vain = 0;
 				got_continue = 1;
 			}
 		} while (ack);
+		while (exp_stride_algorithm && unwound++ < 32) {
+			if (args.verbose)
+				fprintf(stderr, "unwinding: %s\n", sha1_to_hex(outstanding->item->object.sha1));
+			mark_not_common(outstanding->item);
+			pop_outstanding();
+		}
 		flushes--;
 		if (got_continue && MAX_IN_VAIN < in_vain) {
 			if (args.verbose)
@@ -467,7 +1234,10 @@ static int everything_local(struct ref **refs, int nr_match, char **match)
 		if (!(o->flags & SEEN)) {
 			rev_list_push((struct commit *)o, COMMON_REF | SEEN);
 
-			mark_common((struct commit *)o, 1, 1);
+			if (exp_stride_algorithm)
+				mark_common_new((struct commit *)o, 1, 1);
+			else
+				mark_common((struct commit *)o, 1, 1);
 		}
 	}
 
@@ -617,6 +1387,11 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports side-band\n");
 		use_sideband = 1;
 	}
+	if (server_supports("no-giveup")) {
+		if (args.verbose)
+			fprintf(stderr, "Server supports no-giveup\n");
+		exp_stride_algorithm = 1;
+	}
 	if (everything_local(&ref, nr_match, match)) {
 		packet_flush(fd[1]);
 		goto all_done;
diff --git a/upload-pack.c b/upload-pack.c
index e5adbc0..8f05dbf 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -37,6 +37,7 @@ static unsigned int timeout;
  */
 static int use_sideband;
 static int debug_fd;
+static int disable_give_up;
 
 static void reset_timeout(void)
 {
@@ -414,7 +415,7 @@ static int get_common_commits(void)
 		if (!prefixcmp(line, "have ")) {
 			switch (got_sha1(line+5, sha1)) {
 			case -1: /* they have what we do not */
-				if (multi_ack && ok_to_give_up())
+				if (multi_ack && !disable_give_up && ok_to_give_up())
 					packet_write(1, "ACK %s continue\n",
 						     sha1_to_hex(sha1));
 				break;
@@ -501,6 +502,8 @@ static void receive_needs(void)
 			no_progress = 1;
 		if (strstr(line+45, "include-tag"))
 			use_include_tag = 1;
+		if (strstr(line+45, "no-giveup"))
+			disable_give_up = 1;
 
 		/* We have sent all our refs already, and the other end
 		 * should have chosen out of them; otherwise they are
@@ -573,7 +576,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag";
+		" include-tag no-giveup";
 	struct object *o = parse_object(sha1);
 
 	if (!o)
-- 
tg: (73ef856..) t/fp-speedup (depends on: origin/master t/fp-refactor)
