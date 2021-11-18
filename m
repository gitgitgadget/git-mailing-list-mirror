Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44D1C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B3061A8A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhKRQxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52816 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbhKRQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B2DEA21910
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=In/LXxyrRhidOT26/GDN+I3ayXT0ctYPZUiGPy8Qls8=;
        b=WRgvULrK395g4Agi+NeOx8iZXyGlNXZH+eoJ3F9uxnJG08+5PfpVwL+vssXH47ZXlRr86U
        1cKiJEu1Mz0mEYdNSkrsYFZUfZRIxmPuL2yHbHZGyxgPRh4LYoEJSqwskyhMpGL4sa9QPa
        2w8u4Fltp47qa1sezyOatzToaHI6u5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=In/LXxyrRhidOT26/GDN+I3ayXT0ctYPZUiGPy8Qls8=;
        b=zqpvn3fB1uWgfkujGxXd4gj1jSKrfMKogTqjR1pnPLz9brRATBJKijyqWHWTsbT2jgU90E
        hsAspj5AYF1KEoAQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id A3F78A3BA1;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C2BBE1F2CC1; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 23/27] bisect: Find bisection point for stochastic weights
Date:   Thu, 18 Nov 2021 17:49:36 +0100
Message-Id: <20211118164940.8818-24-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The algorithm for finding the next bisection point for stochastic
bisection is the same as for normal bisection. Just instead of uniform
node weight 1 we use the weights derived from computed fault
probabilities. To allow reusing as much code as possible we change
normal bisection to use fixedpoint number type (uint64_t) for
computations instead of int. It wastes 4 bytes per commit but is
probably worth the avoided duplication. We change the functions deciding
about bisection point to work on weights in [0,1] range and scale normal
bisection weights to be in this range.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c     | 138 ++++++++++++++++++++++++++++++++++-----------------
 fixedpoint.h |  10 ++++
 2 files changed, 102 insertions(+), 46 deletions(-)

diff --git a/bisect.c b/bisect.c
index 8e47c3fb4b9e..12b027b86e75 100644
--- a/bisect.c
+++ b/bisect.c
@@ -42,6 +42,12 @@ static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *term_bad;
 static const char *term_good;
 
+/*
+ * Slab for keeping weight information associated with each commit. For normal
+ * bisection we keep just weight of each commit (fpnum_t - fraction of
+ * reachable commits), for stochastic bisection we keep struct st_weight which
+ * contains more information.
+ */
 define_commit_slab(commit_weight, void *);
 static struct commit_weight commit_weight;
 
@@ -50,7 +56,9 @@ static struct commit_weight commit_weight;
  * weights.
  */
 struct st_weight {
-	fpnum_t weight;		/* Total weight of all reachable commits */
+	fpnum_t weight;		/* Total weight of all reachable commits. This
+				 * has to be first in this struct for weight()
+				 * and weight_set() to work correctly. */
 	fpnum_t node_weight;	/* Weight of this particular commit */
 	unsigned long rev_bitmap[];	/* Bitmap of tested commits reaching
 					 * this commit */
@@ -71,14 +79,26 @@ static inline int has_weight(struct commit_list *elem)
 	       *commit_weight_at(&commit_weight, elem->item) != NULL;
 }
 
-static inline int weight(struct commit_list *elem)
+static inline fpnum_t weight(struct commit_list *elem)
+{
+	return *(fpnum_t *)*commit_weight_at(&commit_weight, elem->item);
+}
+
+static inline void weight_set(struct commit_list *elem, fpnum_t weight)
 {
-	return *(int *)*commit_weight_at(&commit_weight, elem->item);
+	*(fpnum_t *)*commit_weight_at(&commit_weight, elem->item) = weight;
 }
 
-static inline void weight_set(struct commit_list *elem, int weight)
+static inline fpnum_t node_weight(struct commit_list *elem)
 {
-	*(int *)*commit_weight_at(&commit_weight, elem->item) = weight;
+	/*
+	 * For normal bisection weight of each node is 1. For stochastic
+	 * bisection we use the weight computed based on test results.
+	 */
+	if (result_confidence)
+		return ((struct st_weight *)*commit_weight_at(&commit_weight,
+					elem->item))->node_weight;
+	return FP_ONE;
 }
 
 #define BITS_PER_LONG (sizeof(long) * 8)
@@ -133,9 +153,9 @@ static int count_interesting_parents(struct commit *commit)
  * We care just barely enough to avoid recursing for
  * non-merge entries.
  */
-static int count_distance(struct commit_list *entry)
+static fpnum_t count_distance(struct commit_list *entry)
 {
-	int nr = 0;
+	fpnum_t weight = 0;
 
 	while (entry) {
 		struct commit *commit = entry->item;
@@ -144,20 +164,20 @@ static int count_distance(struct commit_list *entry)
 		if (commit->object.flags & (UNINTERESTING | COUNTED))
 			break;
 		if (!(commit->object.flags & TREESAME))
-			nr++;
+			weight += node_weight(entry);
 		commit->object.flags |= COUNTED;
 		p = commit->parents;
 		entry = p;
 		if (p) {
 			p = p->next;
 			while (p) {
-				nr += count_distance(p);
+				weight += count_distance(p);
 				p = p->next;
 			}
 		}
 	}
 
-	return nr;
+	return weight;
 }
 
 static void clear_counted_flag(struct commit_list *list)
@@ -169,9 +189,18 @@ static void clear_counted_flag(struct commit_list *list)
 	}
 }
 
+/* Return scale of weights in commit_weight() array */
+static int weight_scale(int nr)
+{
+	if (result_confidence)
+		return 1;
+	return nr;
+}
+
 static inline int approx_halfway(struct commit_list *p, int nr)
 {
-	int diff;
+	fpnum_t diff;
+	int scale = weight_scale(nr);
 
 	/*
 	 * Don't short-cut something we are not going to return!
@@ -180,25 +209,30 @@ static inline int approx_halfway(struct commit_list *p, int nr)
 		return 0;
 	if (DEBUG_BISECT)
 		return 0;
-	/*
-	 * For small number of commits 2 and 3 are halfway of 5, and
-	 * 3 is halfway of 6 but 2 and 4 are not.
-	 */
-	diff = 2 * weight(p) - nr;
-	switch (diff) {
-	case -1: case 0: case 1:
-		return 1;
-	default:
+
+	if (!result_confidence) {
+		scale = nr;
 		/*
-		 * For large number of commits we are not so strict, it's
-		 * good enough if it's within ~0.1% of the halfway point,
-		 * e.g. 5000 is exactly halfway of 10000, but we consider
-		 * the values [4996, 5004] as halfway as well.
+		 * For small number of commits 2 and 3 are halfway of 5, and 3
+		 * is halfway of 6 but 2 and 4 are not.  For large number of
+		 * commits we are not so strict, it's good enough if it's
+		 * within ~0.1% of the halfway point, e.g. 5000 is exactly
+		 * halfway of 10000, but we consider the values [4996, 5004] as
+		 * halfway as well.
 		 */
-		if (abs(diff) < nr / 1024)
-			return 1;
-		return 0;
+		diff = frac_to_fp((nr + 1023) / 1024, nr);
+	} else {
+		/*
+		 * For stochastic we accept any node whose weight is within
+		 * 1/16 from the middle. In the worst case this may result in
+		 * ~20% more tests which is not too bad.
+		 */
+		diff = frac_to_fp(1, 16);
 	}
+	if (weight(p) > (FP_HALF - diff) * scale &&
+	    weight(p) < (FP_HALF + diff) * scale)
+		return 1;
+	return 0;
 }
 
 static void show_list(const char *debug, int counted, int nr,
@@ -227,7 +261,7 @@ static void show_list(const char *debug, int counted, int nr,
 			(commit_flags & UNINTERESTING) ? 'U' : ' ',
 			(commit_flags & COUNTED) ? 'C' : ' ');
 		if (has_weight(p))
-			fprintf(stderr, "%3d", weight(p));
+			fprintf(stderr, "%lf", fp_to_double(weight(p)));
 		else
 			fprintf(stderr, "---");
 		fprintf(stderr, " %.*s", 8, oid_to_hex(&commit->object.oid));
@@ -245,19 +279,20 @@ static void show_list(const char *debug, int counted, int nr,
 static struct commit_list *best_bisection(struct commit_list *list, int nr)
 {
 	struct commit_list *p, *best;
-	int best_distance = -1;
+	fpnum_t best_distance = -1;
+	int scale = weight_scale(nr);
 
 	best = list;
 	for (p = list; p; p = p->next) {
-		int distance;
+		fpnum_t distance;
 		unsigned commit_flags = p->item->object.flags;
 
 		if (commit_flags & TREESAME)
 			continue;
 		distance = weight(p);
-		if (nr - distance < distance)
-			distance = nr - distance;
-		if (distance > best_distance) {
+		if (distance > FP_HALF * scale)
+			distance = FP_ONE * scale - distance;
+		if (best_distance == -1 || distance > best_distance) {
 			best = p;
 			best_distance = distance;
 		}
@@ -268,7 +303,7 @@ static struct commit_list *best_bisection(struct commit_list *list, int nr)
 
 struct commit_dist {
 	struct commit *commit;
-	int distance;
+	fpnum_t distance;
 };
 
 static int compare_commit_dist(const void *a_, const void *b_)
@@ -277,27 +312,32 @@ static int compare_commit_dist(const void *a_, const void *b_)
 
 	a = (struct commit_dist *)a_;
 	b = (struct commit_dist *)b_;
-	if (a->distance != b->distance)
-		return b->distance - a->distance; /* desc sort */
+	if (a->distance != b->distance) {
+		if (a->distance > b->distance)
+			return -1;
+		return 1;
+	}
 	return oidcmp(&a->commit->object.oid, &b->commit->object.oid);
 }
 
-static struct commit_list *best_bisection_sorted(struct commit_list *list, int nr)
+static struct commit_list *best_bisection_sorted(struct commit_list *list,
+						 int nr)
 {
 	struct commit_list *p;
 	struct commit_dist *array = xcalloc(nr, sizeof(*array));
 	struct strbuf buf = STRBUF_INIT;
 	int cnt, i;
+	int scale = weight_scale(nr);
 
 	for (p = list, cnt = 0; p; p = p->next) {
-		int distance;
+		fpnum_t distance;
 		unsigned commit_flags = p->item->object.flags;
 
 		if (commit_flags & TREESAME)
 			continue;
 		distance = weight(p);
-		if (nr - distance < distance)
-			distance = nr - distance;
+		if (distance > FP_HALF * scale)
+			distance = FP_ONE * scale - distance;
 		array[cnt].commit = p->item;
 		array[cnt].distance = distance;
 		cnt++;
@@ -307,7 +347,13 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 		struct object *obj = &(array[i].commit->object);
 
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "dist=%d", array[i].distance);
+		if (!result_confidence) {
+			strbuf_addf(&buf, "dist=%u",
+				    fp_to_int(array[i].distance));
+		} else {
+			strbuf_addf(&buf, "dist=%lf",
+				    fp_to_double(array[i].distance));
+		}
 		add_name_decoration(DECORATION_NONE, buf.buf, obj);
 
 		p->item = array[i].commit;
@@ -323,7 +369,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 	return list;
 }
 
-#define WEIGHT_UNSET -1
+#define WEIGHT_UNSET ((fpnum_t)-1)
 
 /*
  * Zero or positive weight is the number of interesting commits it can
@@ -381,7 +427,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		for (p = list; p; p = p->next) {
 			struct commit_list *q;
 			unsigned commit_flags = p->item->object.flags;
-			int parent_weight = 0;
+			fpnum_t parent_weight = 0;
 
 			if (weight(p) != WEIGHT_UNSET)
 				continue;
@@ -408,7 +454,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			 * otherwise inherit it from q directly.
 			 */
 			if (!(commit_flags & TREESAME)) {
-				weight_set(p, parent_weight + 1);
+				weight_set(p, parent_weight + node_weight(p));
 				counted++;
 				show_list("bisection 2 count one",
 					  counted, nr, list);
@@ -433,7 +479,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 
 static void *setup_commit_weight_array(struct commit_list *list, int nodes)
 {
-	int entry_size = sizeof(int);
+	int entry_size = sizeof(fpnum_t);
 	void *array;
 	struct commit_list *p;
 	int n;
@@ -725,7 +771,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 			best = list;
 			best->next = NULL;
 		}
-		*reaches = weight(best);
+		*reaches = fp_to_int(weight(best) * (nr / weight_scale(nr)));
 	}
 	free(weights);
 	*commit_list = best;
diff --git a/fixedpoint.h b/fixedpoint.h
index 159bb6ef4358..6d03a5e010ee 100644
--- a/fixedpoint.h
+++ b/fixedpoint.h
@@ -14,6 +14,16 @@ static inline const fpnum_t frac_to_fp(unsigned int n, unsigned int d)
 	return (((fpnum_t)n) << FIXEDPOINT_SHIFT) / d;
 }
 
+static inline const fpnum_t int_to_fp(unsigned int n)
+{
+	return ((fpnum_t)n) << FIXEDPOINT_SHIFT;
+}
+
+static inline unsigned int fp_to_int(fpnum_t n)
+{
+	return (n + (1ULL << (FIXEDPOINT_SHIFT - 1))) >> FIXEDPOINT_SHIFT;
+}
+
 static inline const fpnum_t double_to_fp(double n)
 {
 	return (n * (1ULL << FIXEDPOINT_SHIFT));
-- 
2.26.2

