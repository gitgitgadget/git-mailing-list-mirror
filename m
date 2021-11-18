Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE885C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF5D6138D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhKRQxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:02 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52812 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbhKRQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A344B218F6
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9+2KidoEbEnpkSJZ+evZwd27d2QrbOsZwz5F+6w0G0=;
        b=TKmxJHf/tYgA1OpNWqoFfKnrmLT88lx3B2wnFq+x0g80cZ9AARqZxk3bfgEUt8iheyC2MS
        rLfP3p1I5hlg02XgMf1BSOrJoadvl/PPFsa/j0ioR2FFlFqrOXVCaiXLXWh2MoTeO9MFKR
        vacLzhWlRPwp41TV5v8HRvwExk5ERvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9+2KidoEbEnpkSJZ+evZwd27d2QrbOsZwz5F+6w0G0=;
        b=MBKrzXMwDKsQ3Kk+nlmfMR/BLBsn4qMQt15yM1dvgjQoPYRLeefZugMg7p3tCGagipTzDz
        oCaq5XH/A/DTCVAg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 9795EA3B8A;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B6C821F2CB8; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 20/27] bisect: Compute probability a particular commit is bad
Date:   Thu, 18 Nov 2021 17:49:33 +0100
Message-Id: <20211118164940.8818-21-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compute conditional probability a commit is bad given results of tests
performed so far, for each commit in commit list.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/bisect.c b/bisect.c
index cf11926d6f4e..680b96654fd4 100644
--- a/bisect.c
+++ b/bisect.c
@@ -576,6 +576,128 @@ static struct commit_list *reverse_list(struct commit_list *list)
 	return last;
 }
 
+struct sw_rev_bmp_hash_entry {
+	struct hashmap_entry entry;
+	struct st_weight *commit_weight;
+	fpnum_t cluster_p_bad;
+	unsigned int count;
+};
+
+static int sw_rev_bmp_cmp(const void *data, const struct hashmap_entry *ap,
+			  const struct hashmap_entry *bp, const void *keydata)
+{
+	int i;
+	const struct sw_rev_bmp_hash_entry *a, *b;
+
+	a = container_of(ap, const struct sw_rev_bmp_hash_entry, entry);
+	b = container_of(bp, const struct sw_rev_bmp_hash_entry, entry);
+
+	for (i = 0; i < sw_rev_bmp_longs; i++)
+		if (a->commit_weight->rev_bitmap[i] !=
+		    b->commit_weight->rev_bitmap[i])
+			return 1;
+	return 0;
+}
+
+/*
+ * Compute for each commit a probability it is the bad one given tests
+ * performed so far.
+ */
+static void compute_commit_weights(struct commit_list *list)
+{
+	struct commit_list *p;
+	struct hashmap reach_map;
+	struct sw_rev_bmp_hash_entry *found_entry, entry;
+	struct hashmap_iter reach_iter, trev_iter;
+	fpnum_t cluster_prob_sum = 0;
+
+	/*
+	 * We call a "cluster" a set of commits which have identical set of
+	 * tested revisions that can reach to it. We compute the size of each
+	 * cluster here - we count only tree-changing nodes as only those can
+	 * be the bad ones.
+	 */
+	hashmap_init(&reach_map, sw_rev_bmp_cmp, NULL, ptest_revs.nr + 1);
+	for (p = list; p; p = p->next) {
+		struct st_weight *pweight;
+		unsigned int hashval;
+
+		if (p->item->object.flags & TREESAME)
+			continue;
+
+		pweight = *commit_weight_at(&commit_weight, p->item);
+		hashval = memhash(pweight->rev_bitmap,
+				sw_rev_bmp_longs * sizeof(unsigned long));
+		hashmap_entry_init(&entry.entry, hashval);
+		entry.commit_weight = pweight;
+		found_entry = hashmap_get_entry(&reach_map, &entry, entry, NULL);
+		if (!found_entry) {
+			found_entry = xmalloc(
+					sizeof(struct sw_rev_bmp_hash_entry));
+			hashmap_entry_init(&found_entry->entry, hashval);
+			found_entry->commit_weight = pweight;
+			found_entry->count = 0;
+			hashmap_add(&reach_map, &found_entry->entry);
+		}
+		found_entry->count++;
+	}
+
+	/*
+	 * Compute probability bad commit is in a particular cluster. The
+	 * probability is:
+	 * P(error in cluster C) =
+	 *   \Pi_{i\in 'tested rev not reaching C'} P(test at i good) *
+	 *   \Pi_{i\in 'tested rev reaching C'} P(test at i bad)
+	 */
+	hashmap_for_each_entry(&reach_map, &reach_iter, found_entry, entry) {
+		fpnum_t cluster_prob = FP_ONE;
+		struct tested_rev *trev;
+
+		hashmap_for_each_entry(&tested_revs_map, &trev_iter, trev,
+				       entry) {
+			if (sw_rev_bmp_test(found_entry->commit_weight,
+					    trev->index)) {
+				cluster_prob = fp_mul(cluster_prob,
+						FP_ONE - trev->confidence);
+			} else {
+				cluster_prob = fp_mul(cluster_prob,
+						trev->confidence);
+			}
+		}
+		found_entry->cluster_p_bad = cluster_prob;
+		cluster_prob_sum += cluster_prob;
+	}
+	/*
+	 * Normalize the probabilities to sum to 1 - we need this normalization
+	 * because in fact we compute conditional probability of bad commit
+	 * being in a particular cluster given test results we already
+	 * obtained.
+	 */
+	hashmap_for_each_entry(&reach_map, &reach_iter, found_entry, entry) {
+		found_entry->cluster_p_bad = fp_div(found_entry->cluster_p_bad,
+						    cluster_prob_sum);
+	}
+
+	/* Uniformly distribute the probability among all nodes of a cluster */
+	for (p = list; p; p = p->next) {
+		struct st_weight *pweight;
+
+		if (p->item->object.flags & TREESAME)
+			continue;
+
+		pweight = *commit_weight_at(&commit_weight, p->item);
+		hashmap_entry_init(&entry.entry,
+			memhash(pweight->rev_bitmap,
+				sw_rev_bmp_longs * sizeof(unsigned long)));
+		entry.commit_weight = pweight;
+		found_entry = hashmap_get_entry(&reach_map, &entry, entry, NULL);
+		pweight->node_weight =
+			found_entry->cluster_p_bad / found_entry->count;
+	}
+
+	hashmap_clear_and_free(&reach_map, struct sw_rev_bmp_hash_entry, entry);
+}
+
 void find_bisection(struct commit_list **commit_list, int *reaches,
 		    int *all, unsigned bisect_flags)
 {
@@ -615,6 +737,8 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	if (result_confidence)
 		compute_tested_descendants(list);
 	list = reverse_list(list);
+	if (result_confidence)
+		compute_commit_weights(list);
 	show_list("bisection 2 sorted", 0, nr, list);
 
 	/* Do the real work of finding bisection commit. */
-- 
2.26.2

