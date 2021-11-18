Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74564C433FE
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C89461B2B
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhKRQxJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:09 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57656 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbhKRQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9085C1FD4A
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mVVdUrxRugPiJiyu7oHu4NRyFbiOJg4sEexX4E3yPws=;
        b=ZsJJ0VeiSuvaIUer0M7TPVa/7BRRrMd1RLaAH5s/ItRXmvzxq2dc9uOuAF/8aMIPIZD0Yh
        W5Vnlv5vKAy3gEyaEy2+Eod/IPI/e0ahAYH4eZYrONaEOmUnj6jlnBDrGA2RbVPDP2Bdo+
        ORcNrH6ffmMhLPQIl78ip4FEiKDOF6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mVVdUrxRugPiJiyu7oHu4NRyFbiOJg4sEexX4E3yPws=;
        b=6ZjuSNA+g91WLSnprN0ugndbpAFVuRaSQBQYpt1ScFoFCOzvPg7TQ8vEH8ajem3Vqlk6i0
        7ov/q+FPptxgF0Cg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 80C7FA3B9C;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B2CBE1F2CB6; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 19/27] bisect: Compute reachability of tested revs
Date:   Thu, 18 Nov 2021 17:49:32 +0100
Message-Id: <20211118164940.8818-20-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compute for each rev a bitmap of revs that can reach it and that were
tested during stochastic bisection run.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c     | 199 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 fixedpoint.h |  18 +++++
 2 files changed, 215 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 3a26255e8650..cf11926d6f4e 100644
--- a/bisect.c
+++ b/bisect.c
@@ -17,6 +17,7 @@
 #include "object-store.h"
 #include "dir.h"
 #include "fixedpoint.h"
+#include "hashmap.h"
 
 static struct oid_array good_revs;
 static struct oid_array ptest_revs;
@@ -24,6 +25,16 @@ static struct oid_array skipped_revs;
 
 static fpnum_t result_confidence;
 
+struct tested_rev {
+	struct hashmap_entry entry;
+	struct object_id *oid;
+	int index;		/* Index in ptest_revs array */
+	fpnum_t confidence;	/* Total confidence the rev is good computed
+				 * from of all tests on this rev */
+};
+
+static struct hashmap tested_revs_map;
+
 static struct object_id *current_bad_oid;
 
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
@@ -80,8 +91,26 @@ static void clear_counted_flag(struct commit_list *list)
 define_commit_slab(commit_weight, void *);
 static struct commit_weight commit_weight;
 
+/*
+ * Information associated with each commit when computing stochastic bisection
+ * weights.
+ */
+struct st_weight {
+	fpnum_t weight;		/* Total weight of all reachable commits */
+	fpnum_t node_weight;	/* Weight of this particular commit */
+	unsigned long rev_bitmap[];	/* Bitmap of tested commits reaching
+					 * this commit */
+};
+int sw_rev_bmp_longs;
+
 #define DEBUG_BISECT 0
 
+#if DEBUG_BISECT > 0
+#define debug_bisect(fmt...) fprintf(stderr, fmt)
+#else
+#define debug_bisect(fmt...) do { } while (0)
+#endif
+
 static inline int has_weight(struct commit_list *elem)
 {
 	return commit_weight.slab_size > 0 &&
@@ -98,6 +127,37 @@ static inline void weight_set(struct commit_list *elem, int weight)
 	*(int *)*commit_weight_at(&commit_weight, elem->item) = weight;
 }
 
+#define BITS_PER_LONG (sizeof(long) * 8)
+
+/*
+ * Add bits in 'from' reachability bitmap to 'to'. Returns 1 if any bit in 'to'
+ * was set.
+ */
+static int sw_rev_bmp_or(struct st_weight *to, struct st_weight *from)
+{
+	int i;
+	int set = 0;
+
+	for (i = 0; i < sw_rev_bmp_longs; i++) {
+		unsigned long prev = to->rev_bitmap[i];
+
+		to->rev_bitmap[i] |= from->rev_bitmap[i];
+		set |= (to->rev_bitmap[i] != prev);
+	}
+	return set;
+}
+
+static void sw_rev_bmp_set(struct st_weight *to, int idx)
+{
+	to->rev_bitmap[idx / BITS_PER_LONG] |= 1UL << (idx % BITS_PER_LONG);
+}
+
+static unsigned long sw_rev_bmp_test(struct st_weight *to, int idx)
+{
+	return to->rev_bitmap[idx / BITS_PER_LONG] &
+					(1UL << (idx % BITS_PER_LONG));
+}
+
 static int count_interesting_parents(struct commit *commit, unsigned bisect_flags)
 {
 	struct commit_list *p;
@@ -403,6 +463,14 @@ static void *setup_commit_weight_array(struct commit_list *list, int nodes)
 	struct commit_list *p;
 	int n;
 
+	/* Stochastic bisection? */
+	if (result_confidence) {
+		int revs = ptest_revs.nr + 1;
+
+		sw_rev_bmp_longs = (revs + BITS_PER_LONG - 1) / BITS_PER_LONG;
+		entry_size = sizeof(struct st_weight) +
+					sw_rev_bmp_longs * sizeof(long);
+	}
 	array = xcalloc(nodes, entry_size);
 	for (n = 0, p = list; p; p = p->next, n++) {
 		*commit_weight_at(&commit_weight, p->item) =
@@ -411,6 +479,91 @@ static void *setup_commit_weight_array(struct commit_list *list, int nodes)
 	return array;
 }
 
+static struct tested_rev *lookup_tested_oid(struct object_id *oid)
+{
+	struct tested_rev key;
+
+	hashmap_entry_init(&key.entry, oidhash(oid));
+	key.oid = oid;
+	return hashmap_get_entry(&tested_revs_map, &key, entry, NULL);
+}
+
+static int sw_rev_test_idx(struct commit *commit)
+{
+	struct tested_rev *tr;
+
+	tr = lookup_tested_oid(&commit->object.oid);
+	if (!tr)
+		return -1;
+	return tr->index;
+}
+
+static int propagate_to_ancestors(struct commit *commit)
+{
+	struct commit_list *q;
+	int out_of_order = 0, set;
+	struct st_weight *cw;
+
+	cw = *commit_weight_at(&commit_weight, commit);
+	for (q = commit->parents; q; q = q->next) {
+		if (q->item->object.flags & UNINTERESTING)
+			continue;
+		set = sw_rev_bmp_or(*commit_weight_at(&commit_weight, q->item),
+				    cw);
+		if (set && q->item->object.flags & COUNTED) {
+			debug_bisect("descendants_bitmap: Recursion for %s\n",
+				     oid_to_hex(&q->item->object.oid));
+			/*
+			 * If the commit is already processed, we need to
+			 * propagate bitmap update to all already processed
+			 * ancestors. The 'list' should be close to inverse
+			 * topological order so this should be rare.
+			 */
+			out_of_order = 1;
+		}
+	}
+	return out_of_order;
+}
+
+/*
+ * For each commit in the 'list' compute bitmap of tested revisions that can
+ * reach it. Note for our purposes each commit can reach itself.
+ */
+static void compute_tested_descendants(struct commit_list *list)
+{
+	struct commit_list *p;
+	int retry = 0, tried = 1;
+
+	for (p = list; p; p = p->next) {
+		struct commit *commit = p->item;
+		struct st_weight *cw;
+		int idx;
+
+		cw = *commit_weight_at(&commit_weight, commit);
+		idx = sw_rev_test_idx(commit);
+		if (idx >= 0)
+			sw_rev_bmp_set(cw, idx);
+		retry = propagate_to_ancestors(commit);
+		commit->object.flags |= COUNTED;
+	}
+	clear_counted_flag(list);
+	/*
+	 * We expect the 'list' to be close to reverse topological order. If
+	 * it is not exactly in reverse topological order, we need to repeat
+	 * descendant bit propagation until bitmaps are stable.
+	 */
+	while (retry) {
+		tried++;
+		retry = 0;
+		for (p = list; p; p = p->next) {
+			retry = propagate_to_ancestors(p->item);
+			p->item->object.flags |= COUNTED;
+		}
+		clear_counted_flag(list);
+	}
+	debug_bisect("%s: Took %d iterations to stabilize.\n", __func__, tried);
+}
+
 static struct commit_list *reverse_list(struct commit_list *list)
 {
 	struct commit_list *p, *next, *last = NULL;
@@ -459,6 +612,8 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 		goto out_weights;
 	}
 	weights = setup_commit_weight_array(list, on_list);
+	if (result_confidence)
+		compute_tested_descendants(list);
 	list = reverse_list(list);
 	show_list("bisection 2 sorted", 0, nr, list);
 
@@ -522,11 +677,39 @@ static GIT_PATH_FUNC(git_path_bisect_confidences, "BISECT_CONFIDENCES")
 static GIT_PATH_FUNC(git_path_bisect_result_confidence, "BISECT_RESULT_CONFIDENCE")
 static GIT_PATH_FUNC(git_path_head_name, "head-name")
 
+static int tested_rev_cmp(const void *data, const struct hashmap_entry *ap,
+			  const struct hashmap_entry *bp, const void *keydata)
+{
+	const struct tested_rev *a, *b;
+
+	a = container_of(ap, const struct tested_rev, entry);
+	b = container_of(bp, const struct tested_rev, entry);
+
+	return oidcmp(a->oid, b->oid);
+}
+
+static void setup_tested_revs_map(void)
+{
+	int i;
+	struct tested_rev *tr;
+
+	hashmap_init(&tested_revs_map, tested_rev_cmp, NULL, ptest_revs.nr + 1);
+	for (i = 0; i < ptest_revs.nr; i++) {
+		tr = xmalloc(sizeof(struct tested_rev));
+		hashmap_entry_init(&tr->entry, oidhash(ptest_revs.oid + i));
+		tr->oid = ptest_revs.oid + i;
+		tr->index = i;
+		tr->confidence = FP_HALF;
+		hashmap_add(&tested_revs_map, &tr->entry);
+	}
+}
+
 static void read_bisect_confidences(void)
 {
 	struct strbuf str = STRBUF_INIT;
 	const char *filename = git_path_bisect_result_confidence();
 	FILE *fp = fopen(filename, "r");
+	struct tested_rev *trev;
 
 	/* Just a regular bisection? */
 	if (!fp)
@@ -535,6 +718,8 @@ static void read_bisect_confidences(void)
 		die(_("Cannot parse result confidence in file '%s'"), filename);
 	fclose(fp);
 
+	setup_tested_revs_map();
+
 	/* No uncertain bisection steps yet? */
 	filename = git_path_bisect_confidences();
 	fp = fopen(filename, "r");
@@ -542,7 +727,7 @@ static void read_bisect_confidences(void)
 		return;
 
 	while (strbuf_getline_lf(&str, fp) != EOF) {
-		fpnum_t prob;
+		fpnum_t prob, pos_prob, neg_prob;
 		char *spc;
 		char state;
 		struct object_id oid;
@@ -562,7 +747,17 @@ static void read_bisect_confidences(void)
 		if (get_oid(str.buf, &oid))
 			die(_("Cannot get oid of rev '%s' from file '%s'"),
 			    str.buf, filename);
-		/* We'll use parsed data later */
+		trev = lookup_tested_oid(&oid);
+		if (!trev)
+			die(_("Rev '%s' not tracked as ptest rev."), str.buf);
+		if (state == 'b')
+			prob = FP_ONE - prob;
+		pos_prob = fp_mul(trev->confidence, prob);
+		neg_prob = fp_mul(FP_ONE - trev->confidence, FP_ONE - prob);
+		trev->confidence = fp_div(pos_prob, pos_prob + neg_prob);
+		debug_bisect("read confidence %s: %"FPNUM_FMT
+			" (total %"FPNUM_FMT")\n",
+			str.buf, prob, trev->confidence);
 	}
 	strbuf_release(&str);
 	fclose(fp);
diff --git a/fixedpoint.h b/fixedpoint.h
index 3f6234c6530a..159bb6ef4358 100644
--- a/fixedpoint.h
+++ b/fixedpoint.h
@@ -27,4 +27,22 @@ static inline const double fp_to_double(fpnum_t n)
 #define FP_ONE frac_to_fp(1, 1)
 #define FP_HALF frac_to_fp(1, 2)
 
+/* Multiplication for numbers <= 1 */
+static inline const fpnum_t fp_mul(fpnum_t n, fpnum_t m)
+{
+	if (m == FP_ONE)
+		return n;
+	if (n == FP_ONE)
+		return m;
+	assert(m < FP_ONE && n < FP_ONE);
+	return (m * n) >> FIXEDPOINT_SHIFT;
+}
+
+/* Division for number <= 1 */
+static inline const fpnum_t fp_div(fpnum_t n, fpnum_t d)
+{
+	assert(n <= FP_ONE);
+	return (n << (FIXEDPOINT_SHIFT - 1)) / (d >> 1);
+}
+
 #endif
-- 
2.26.2

