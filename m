Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CECC20964
	for <e@80x24.org>; Tue,  4 Apr 2017 21:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbdDDVJE (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 17:09:04 -0400
Received: from siwi.pair.com ([209.68.5.199]:11411 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753930AbdDDVJD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 17:09:03 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0B6B984621;
        Tue,  4 Apr 2017 17:09:01 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 4/4] read-cache: speed up add_index_entry during checkout
Date:   Tue,  4 Apr 2017 21:08:47 +0000
Message-Id: <20170404210847.50860-5-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170404210847.50860-1-git@jeffhostetler.com>
References: <20170404210847.50860-1-git@jeffhostetler.com>
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
index in sorted order, so this change saves at least 2
lookups per file.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 read-cache.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index b3fc77d..bf9fc53 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -927,6 +927,21 @@ static int has_dir_name(struct index_state *istate,
 	int stage = ce_stage(ce);
 	const char *name = ce->name;
 	const char *slash = name + ce_namelen(ce);
+	int len_eq_last;
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
 		int len;
@@ -939,6 +954,24 @@ static int has_dir_name(struct index_state *istate,
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
@@ -1030,7 +1063,16 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 
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

