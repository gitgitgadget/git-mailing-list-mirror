Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D97120960
	for <e@80x24.org>; Thu, 13 Apr 2017 15:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbdDMP7H (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 11:59:07 -0400
Received: from siwi.pair.com ([209.68.5.199]:63962 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751670AbdDMP7F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 11:59:05 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2B710845B8;
        Thu, 13 Apr 2017 11:59:04 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3] unpack-trees: avoid duplicate ODB lookups during checkout
Date:   Thu, 13 Apr 2017 15:58:52 +0000
Message-Id: <20170413155852.4281-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170413155852.4281-1-git@jeffhostetler.com>
References: <20170413155852.4281-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach traverse_trees_recursive() to not do redundant ODB
lookups when both directories refer to the same OID.

In operations such as read-tree and checkout, there will
likely be many peer directories that have the same OID when
the differences between the commits are relatively small.
In these cases we can avoid hitting the ODB multiple times
for the same OID.

This patch handles n=2 and n=3 cases and simply copies the
data rather than repeating the fill_tree_descriptor().

================
On the Windows repo (500K trees, 3.1M files, 450MB index),
this reduced the overall time by 0.75 seconds when cycling
between 2 commits with a single file difference.

(avg) before: 22.699
(avg) after:  21.955
===============

================
On Linux using p0006-read-tree-checkout.sh with linux.git:

Test                                                          HEAD^              HEAD
-------------------------------------------------------------------------------------------------------
0006.2: read-tree br_base br_ballast (57994)                  0.24(0.20+0.03)    0.24(0.22+0.01) +0.0%
0006.3: switch between br_base br_ballast (57994)             10.58(6.23+2.86)   10.67(5.94+2.87) +0.9%
0006.4: switch between br_ballast br_ballast_plus_1 (57994)   0.60(0.44+0.17)    0.57(0.44+0.14) -5.0%
0006.5: switch between aliases (57994)                        0.59(0.48+0.13)    0.57(0.44+0.15) -3.4%
================

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unpack-trees.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3a8ee19..a674423 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -531,6 +531,11 @@ static int switch_cache_bottom(struct traverse_info *info)
 	return ret;
 }
 
+static inline int are_same_oid(struct name_entry *name_j, struct name_entry *name_k)
+{
+	return name_j->oid && name_k->oid && !oidcmp(name_j->oid, name_k->oid);
+}
+
 static int traverse_trees_recursive(int n, unsigned long dirmask,
 				    unsigned long df_conflicts,
 				    struct name_entry *names,
@@ -553,11 +558,35 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	newinfo.pathlen += tree_entry_len(p) + 1;
 	newinfo.df_conflicts |= df_conflicts;
 
+	/*
+	 * Fetch the tree from the ODB for each peer directory in the
+	 * n commits.
+	 *
+	 * For 2- and 3-way traversals, we try to avoid hitting the
+	 * ODB twice for the same OID.  This should yield a nice speed
+	 * up in checkouts and merges when the commits are similar.
+	 *
+	 * We don't bother doing the full O(n^2) search for larger n,
+	 * because wider traversals don't happen that often and we
+	 * avoid the search setup.
+	 *
+	 * When 2 peer OIDs are the same, we just copy the tree
+	 * descriptor data.  This implicitly borrows the buffer
+	 * data from the earlier cell.
+	 */
 	for (i = 0; i < n; i++, dirmask >>= 1) {
-		const unsigned char *sha1 = NULL;
-		if (dirmask & 1)
-			sha1 = names[i].oid->hash;
-		buf[i] = fill_tree_descriptor(t+i, sha1);
+		if (i > 0 && are_same_oid(&names[i], &names[i - 1])) {
+			t[i] = t[i - 1];
+			buf[i] = NULL;
+		} else if (i > 1 && are_same_oid(&names[i], &names[i - 2])) {
+			t[i] = t[i - 2];
+			buf[i] = NULL;
+		} else {
+			const unsigned char *sha1 = NULL;
+			if (dirmask & 1)
+				sha1 = names[i].oid->hash;
+			buf[i] = fill_tree_descriptor(t+i, sha1);
+		}
 	}
 
 	bottom = switch_cache_bottom(&newinfo);
-- 
2.9.3

