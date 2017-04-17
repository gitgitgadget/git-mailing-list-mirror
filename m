Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4A951FA26
	for <e@80x24.org>; Mon, 17 Apr 2017 21:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754819AbdDQVhz (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 17:37:55 -0400
Received: from siwi.pair.com ([209.68.5.199]:58178 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754217AbdDQVht (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 17:37:49 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1D85984691;
        Mon, 17 Apr 2017 17:37:48 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v11 4/5] read-cache: speed up has_dir_name (part 1)
Date:   Mon, 17 Apr 2017 21:37:33 +0000
Message-Id: <20170417213734.55373-5-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170417213734.55373-1-git@jeffhostetler.com>
References: <20170417213734.55373-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach has_dir_name() to see if the path of the new item
is greater than the last path in the index array before
attempting to search for it.

has_dir_name() is looking for file/directory collisions
in the index and has to consider each sub-directory
prefix in turn.  This can cause multiple binary searches
for each path.

During operations like checkout, merge_working_tree()
populates the new index in sorted order, so we expect
to be able to append in many cases.

This commit is part 1 of 2.  This commit handles the top
of has_dir_name() and the trivial optimization.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 read-cache.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 6a27688..9af0bd4 100644
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
@@ -918,6 +921,48 @@ static int has_dir_name(struct index_state *istate,
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
 		int len;
-- 
2.9.3

