Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA3820966
	for <e@80x24.org>; Fri,  7 Apr 2017 15:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933841AbdDGPx2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 11:53:28 -0400
Received: from siwi.pair.com ([209.68.5.199]:19902 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933753AbdDGPxU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 11:53:20 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CDEDD84677;
        Fri,  7 Apr 2017 11:53:18 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2] unpack-trees: avoid duplicate ODB lookups during checkout
Date:   Fri,  7 Apr 2017 15:53:06 +0000
Message-Id: <20170407155306.42375-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170407155306.42375-1-git@jeffhostetler.com>
References: <20170407155306.42375-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach traverse_trees_recursive() to not do redundant ODB
lookups when both directories refer to the same OID.

In operations such as read-tree, checkout, and merge when
the differences between the commits are relatively small,
there will likely be many directories that have the same
SHA-1.  In these cases we can avoid hitting the ODB multiple
times for the same SHA-1.

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
Using the p0004-read-tree test (posted earlier this week)
with 1M files on Linux:

before:
$ ./p0004-read-tree.sh
0004.5: switch work1 work2 (1003037)       11.99(8.12+3.32)
0004.6: switch commit aliases (1003037)    11.95(8.20+3.14)

after:
$ ./p0004-read-tree.sh
0004.5: switch work1 work2 (1003037)       11.02(7.71+2.78)
0004.6: switch commit aliases (1003037)    10.95(7.57+2.82)
================

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unpack-trees.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3a8ee19..143c5d9 100644
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
@@ -554,10 +559,20 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	newinfo.df_conflicts |= df_conflicts;
 
 	for (i = 0; i < n; i++, dirmask >>= 1) {
-		const unsigned char *sha1 = NULL;
-		if (dirmask & 1)
-			sha1 = names[i].oid->hash;
-		buf[i] = fill_tree_descriptor(t+i, sha1);
+		if (i > 0 && are_same_oid(&names[i], &names[i-1])) {
+			/* implicitly borrow buf[i-1] inside tree_desc[i] */
+			memcpy(&t[i], &t[i-1], sizeof(struct tree_desc));
+			buf[i] = NULL;
+		} else if (i > 1 && are_same_oid(&names[i], &names[i-2])) {
+			/* implicitly borrow buf[i-2] inside tree_desc[i] */
+			memcpy(&t[i], &t[i-2], sizeof(struct tree_desc));
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

