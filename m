Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F80F20970
	for <e@80x24.org>; Fri, 14 Apr 2017 19:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755537AbdDNTNJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 15:13:09 -0400
Received: from siwi.pair.com ([209.68.5.199]:30428 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754785AbdDNTNG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 15:13:06 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 25E9C845CD;
        Fri, 14 Apr 2017 15:12:41 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v10 3/3] read-cache: speed up add_index_entry during checkout
Date:   Fri, 14 Apr 2017 19:12:30 +0000
Message-Id: <20170414191230.52825-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170414191230.52825-1-git@jeffhostetler.com>
References: <20170414191230.52825-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach add_index_entry_with_check() and has_dir_name()
to see if the path of the new item is greater than the
last path in the index array before attempting to search
for it.

During checkout, merge_working_tree() populates the new
index in sorted order, so this change will save at least 2
binary lookups per file.  This preserves the original
behavior but simply checks the last element before starting
the search.

This helps performance on very large repositories.

This can be seen using p0006-read-tree-checkout.sh and the
artificial repository created by t/perf/repos/many-files.sh
with parameters (5, 10, 9).   (1M files in index.)

Test                                                            HEAD^              HEAD
----------------------------------------------------------------------------------------------------------
0006.2: read-tree br_base br_ballast (1000001)                  4.15(2.72+1.41)    3.21(1.97+1.22) -22.7%
0006.3: switch between br_base br_ballast (1000001)             8.11(5.57+2.28)    6.77(4.36+2.14) -16.5%
0006.4: switch between br_ballast br_ballast_plus_1 (1000001)   13.52(8.68+4.35)   11.80(7.38+3.96) -12.7%
0006.5: switch between aliases (1000001)                        13.59(8.75+4.43)   11.85(7.49+3.87) -12.8%

On linux.git, results are:
Test                                                          HEAD^             HEAD
------------------------------------------------------------------------------------------------------
0006.2: read-tree br_base br_ballast (57994)                  0.24(0.22+0.01)   0.20(0.17+0.02) -16.7%
0006.3: switch between br_base br_ballast (57994)             9.91(5.82+2.79)   10.26(5.92+2.77) +3.5%
0006.4: switch between br_ballast br_ballast_plus_1 (57994)   0.59(0.44+0.16)   0.50(0.34+0.18) -15.3%
0006.5: switch between aliases (57994)                        0.62(0.48+0.16)   0.50(0.35+0.16) -19.4%

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 read-cache.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 97f13a1..ba95fbb 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -910,6 +910,9 @@ int strcmp_offset(const char *s1, const char *s2, size_t *first_change)
 /*
  * Do we have another file with a pathname that is a proper
  * subset of the name we're trying to add?
+ *
+ * That is, is there another file in the index with a path
+ * that matches a sub-directory in the given entry?
  */
 static int has_dir_name(struct index_state *istate,
 			const struct cache_entry *ce, int pos, int ok_to_replace)
@@ -918,9 +921,51 @@ static int has_dir_name(struct index_state *istate,
 	int stage = ce_stage(ce);
 	const char *name = ce->name;
 	const char *slash = name + ce_namelen(ce);
+	size_t len_eq_last;
+	int cmp_last = 0;
+
+	/*
+	 * We are frequently called during an iteration on a sorted
+	 * list of pathnames and while building a new index.  Therefore,
+	 * there is a high probability that this entry will eventually
+	 * be appended to the index, rather than inserted in the middle.
+	 * If we can confirm that, we can avoid binary searches on the
+	 * components of the pathname.
+	 *
+	 * Compare the entry's full path with the last path in the index.
+	 */
+	if (istate->cache_nr > 0) {
+		cmp_last = strcmp_offset(name,
+			istate->cache[istate->cache_nr - 1]->name,
+			&len_eq_last);
+		if (cmp_last > 0) {
+			if (len_eq_last == 0) {
+				/*
+				 * The entry sorts AFTER the last one in the
+				 * index and their paths have no common prefix,
+				 * so there cannot be a F/D conflict.
+				 */
+				return retval;
+			} else {
+				/*
+				 * The entry sorts AFTER the last one in the
+				 * index, but has a common prefix.  Fall through
+				 * to the loop below to disect the entry's path
+				 * and see where the difference is.
+				 */
+			}
+		} else if (cmp_last == 0) {
+			/*
+			 * The entry exactly matches the last one in the
+			 * index, but because of multiple stage and CE_REMOVE
+			 * items, we fall through and let the regular search
+			 * code handle it.
+			 */
+		}
+	}
 
 	for (;;) {
-		int len;
+		size_t len;
 
 		for (;;) {
 			if (*--slash == '/')
@@ -930,6 +975,66 @@ static int has_dir_name(struct index_state *istate,
 		}
 		len = slash - name;
 
+		if (cmp_last > 0) {
+			/*
+			 * (len + 1) is a directory boundary (including
+			 * the trailing slash).  And since the loop is
+			 * decrementing "slash", the first iteration is
+			 * the longest directory prefix; subsequent
+			 * iterations consider parent directories.
+			 */
+
+			if (len + 1 <= len_eq_last) {
+				/*
+				 * The directory prefix (including the trailing
+				 * slash) also appears as a prefix in the last
+				 * entry, so the remainder cannot collide (because
+				 * strcmp said the whole path was greater).
+				 *
+				 * EQ: last: xxx/A
+				 *     this: xxx/B
+				 *
+				 * LT: last: xxx/file_A
+				 *     this: xxx/file_B
+				 */
+				return retval;
+			}
+
+			if (len > len_eq_last) {
+				/*
+				 * This part of the directory prefix (excluding
+				 * the trailing slash) is longer than the known
+				 * equal portions, so this sub-directory cannot
+				 * collide with a file.
+				 *
+				 * GT: last: xxxA
+				 *     this: xxxB/file
+				 */
+				return retval;
+			}
+
+			if (ce_namelen(istate->cache[istate->cache_nr - 1]) > len) {
+				/*
+				 * The directory prefix lines up with part of
+				 * a longer file or directory name, but sorts
+				 * after it, so this sub-directory cannot
+				 * collide with a file.
+				 *
+				 * last: xxx/yy-file (because '-' sorts before '/')
+				 * this: xxx/yy/abc
+				 */
+				return retval;
+			}
+
+			/*
+			 * This is a possible collision. Fall through and
+			 * let the regular search code handle it.
+			 *
+			 * last: xxx
+			 * this: xxx/file
+			 */
+		}
+
 		pos = index_name_stage_pos(istate, name, len, stage);
 		if (pos >= 0) {
 			/*
@@ -1021,7 +1126,16 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 
 	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
 		cache_tree_invalidate_path(istate, ce->name);
-	pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
+
+	/*
+	 * If this entry's path sorts after the last entry in the index,
+	 * we can avoid searching for it.
+	 */
+	if (istate->cache_nr > 0 &&
+		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
+		pos = -istate->cache_nr - 1;
+	else
+		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
 
 	/* existing match? Just replace it. */
 	if (pos >= 0) {
-- 
2.9.3

