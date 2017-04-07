Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27329209F1
	for <e@80x24.org>; Fri,  7 Apr 2017 21:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933753AbdDGVVD (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 17:21:03 -0400
Received: from siwi.pair.com ([209.68.5.199]:12735 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751174AbdDGVU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 17:20:59 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C47CF8460D;
        Fri,  7 Apr 2017 17:20:57 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v7 3/3] read-cache: speed up add_index_entry during checkout
Date:   Fri,  7 Apr 2017 21:20:47 +0000
Message-Id: <20170407212047.64950-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170407212047.64950-1-git@jeffhostetler.com>
References: <20170407212047.64950-1-git@jeffhostetler.com>
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

================
Before and after numbers on index with 1M files
./p0004-read-tree.sh
0004.2: read-tree work1 (1003037)          3.21(2.54+0.62)
0004.3: switch base work1 (3038 1003037)   7.49(5.39+1.84)
0004.5: switch work1 work2 (1003037)       11.91(8.38+3.00)
0004.6: switch commit aliases (1003037)    12.22(8.30+3.06)

./p0004-read-tree.sh
0004.2: read-tree work1 (1003040)          2.40(1.65+0.73)
0004.3: switch base work1 (3041 1003040)   6.07(4.12+1.66)
0004.5: switch work1 work2 (1003040)       10.23(6.76+2.92)
0004.6: switch commit aliases (1003040)    10.53(6.97+2.83)
================

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 read-cache.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 97f13a1..a8ef823 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -918,9 +918,24 @@ static int has_dir_name(struct index_state *istate,
 	int stage = ce_stage(ce);
 	const char *name = ce->name;
 	const char *slash = name + ce_namelen(ce);
+	size_t len_eq_last;
+	int cmp_last = 0;
+
+	if (istate->cache_nr > 0) {
+		/*
+		 * Compare the entry's full path with the last path in the index.
+		 * If it sorts AFTER the last entry in the index and they have no
+		 * common prefix, then there cannot be any F/D name conflicts.
+		 */
+		cmp_last = strcmp_offset(name,
+			istate->cache[istate->cache_nr-1]->name,
+			&len_eq_last);
+		if (cmp_last > 0 && len_eq_last == 0)
+			return retval;
+	}
 
 	for (;;) {
-		int len;
+		size_t len;
 
 		for (;;) {
 			if (*--slash == '/')
@@ -930,6 +945,24 @@ static int has_dir_name(struct index_state *istate,
 		}
 		len = slash - name;
 
+		if (cmp_last > 0) {
+			/*
+			 * If this part of the directory prefix (including the trailing
+			 * slash) already appears in the path of the last entry in the
+			 * index, then we cannot also have a file with this prefix (or
+			 * any parent directory prefix).
+			 */
+			if (len+1 <= len_eq_last)
+				return retval;
+			/*
+			 * If this part of the directory prefix (excluding the trailing
+			 * slash) is longer than the known equal portions, then this part
+			 * of the prefix cannot collide with a file.  Go on to the parent.
+			 */
+			if (len > len_eq_last)
+				continue;
+		}
+
 		pos = index_name_stage_pos(istate, name, len, stage);
 		if (pos >= 0) {
 			/*
@@ -1021,7 +1054,16 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 
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

