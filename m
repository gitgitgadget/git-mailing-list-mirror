Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 398D220958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935061AbdCWNri (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:47:38 -0400
Received: from siwi.pair.com ([209.68.5.199]:28998 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755339AbdCWNrU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:47:20 -0400
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4059B84674;
        Thu, 23 Mar 2017 09:47:19 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 3/7] hashmap: Add disallow_rehash setting
Date:   Thu, 23 Mar 2017 13:47:01 +0000
Message-Id: <1490276825-41544-4-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
References: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach hashmap to allow rehashes to be suppressed.
This is useful when hashmaps are accessed by multiple
threads.  It still requires the caller to properly
manage their locking.  This just prevents unexpected
rehashing during inserts and deletes.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 hashmap.c | 12 +++++++++++-
 hashmap.h | 24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/hashmap.c b/hashmap.c
index 93793cb..7d1044e 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -104,11 +104,19 @@ static inline unsigned int bucket(const struct hashmap *map,
 	return key->hash & (map->tablesize - 1);
 }
 
+int hashmap_bucket(const struct hashmap *map, unsigned int hash)
+{
+	return hash & (map->tablesize - 1);
+}
+
 static void rehash(struct hashmap *map, unsigned int newsize)
 {
 	unsigned int i, oldsize = map->tablesize;
 	struct hashmap_entry **oldtable = map->table;
 
+	if (map->disallow_rehash)
+		return;
+
 	alloc_table(map, newsize);
 	for (i = 0; i < oldsize; i++) {
 		struct hashmap_entry *e = oldtable[i];
@@ -141,7 +149,9 @@ void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
 		size_t initial_size)
 {
 	unsigned int size = HASHMAP_INITIAL_SIZE;
-	map->size = 0;
+
+	memset(map, 0, sizeof(*map));
+
 	map->cmpfn = equals_function ? equals_function : always_equal;
 
 	/* calculate initial table size and allocate the table */
diff --git a/hashmap.h b/hashmap.h
index 45eda69..de6022a 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -39,6 +39,7 @@ struct hashmap {
 	struct hashmap_entry **table;
 	hashmap_cmp_fn cmpfn;
 	unsigned int size, tablesize, grow_at, shrink_at;
+	unsigned disallow_rehash : 1;
 };
 
 struct hashmap_iter {
@@ -77,6 +78,29 @@ static inline void *hashmap_get_from_hash(const struct hashmap *map,
 	return hashmap_get(map, &key, keydata);
 }
 
+int hashmap_bucket(const struct hashmap *map, unsigned int hash);
+
+/*
+ * Disallow/allow rehashing of the hashmap.
+ * This is useful if the caller knows that the hashmap
+ * needs multi-threaded access.  The caller is still
+ * required to guard/lock searches and inserts in a
+ * manner appropriate to their usage.  This simply
+ * prevents the table from being unexpectedly re-mapped.
+ *
+ * If is up to the caller to ensure that the hashmap is
+ * initialized to a reasonable size to prevent poor
+ * performance.
+ *
+ * When value=1, prevent future rehashes on adds and deleted.
+ * When value=0, allow future rehahses.  This DOES NOT force
+ * a rehash now.
+ */
+static inline void hashmap_disallow_rehash(struct hashmap *map, unsigned value)
+{
+	map->disallow_rehash = value;
+}
+
 /* hashmap_iter functions */
 
 extern void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter);
-- 
2.7.4

