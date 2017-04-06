Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F1D01FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 20:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbdDFUho (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 16:37:44 -0400
Received: from siwi.pair.com ([209.68.5.199]:25744 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752173AbdDFUhn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 16:37:43 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BC3FF84626;
        Thu,  6 Apr 2017 16:37:41 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1] unpack-trees: avoid duplicate ODB lookups during checkout
Date:   Thu,  6 Apr 2017 20:37:32 +0000
Message-Id: <20170406203732.47714-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170406203732.47714-1-git@jeffhostetler.com>
References: <20170406203732.47714-1-git@jeffhostetler.com>
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

TODO This change is a first attempt to test that by comparing
TODO the hashes of name[i] and name[i-i] and simply copying
TODO the tree-descriptor data.  I was thinking of the n=2
TODO case here.  We may want to extend this to the n=3 case.

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
0004.5: switch work1 work2 (1003037)       11.17(7.84+2.76)
0004.6: switch commit aliases (1003037)    11.13(7.82+2.72)
================

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 tree-walk.c    |  8 ++++++++
 tree-walk.h    |  1 +
 unpack-trees.c | 13 +++++++++----
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index ff77605..3b82f0e 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -92,6 +92,14 @@ void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1)
 	return buf;
 }
 
+void *copy_tree_descriptor(struct tree_desc *dest, const struct tree_desc *src)
+{
+	void *buf = xmalloc(src->size);
+	memcpy(buf, src->buffer, src->size);
+	init_tree_desc(dest, buf, src->size);
+	return buf;
+}
+
 static void entry_clear(struct name_entry *a)
 {
 	memset(a, 0, sizeof(*a));
diff --git a/tree-walk.h b/tree-walk.h
index 68bb78b..ca4032b 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -43,6 +43,7 @@ int tree_entry(struct tree_desc *, struct name_entry *);
 int tree_entry_gently(struct tree_desc *, struct name_entry *);
 
 void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1);
+void *copy_tree_descriptor(struct tree_desc *dest, const struct tree_desc *src);
 
 struct traverse_info;
 typedef int (*traverse_callback_t)(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *);
diff --git a/unpack-trees.c b/unpack-trees.c
index 3a8ee19..50aacad 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -554,10 +554,15 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	newinfo.df_conflicts |= df_conflicts;
 
 	for (i = 0; i < n; i++, dirmask >>= 1) {
-		const unsigned char *sha1 = NULL;
-		if (dirmask & 1)
-			sha1 = names[i].oid->hash;
-		buf[i] = fill_tree_descriptor(t+i, sha1);
+		if (i > 0 && (dirmask & 1) && names[i].oid && names[i-1].oid &&
+			!hashcmp(names[i].oid->hash, names[i-1].oid->hash)) {
+			buf[i] = copy_tree_descriptor(&t[i], &t[i-1]);
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

