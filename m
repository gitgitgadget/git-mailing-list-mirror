Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC01C43461
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C5A611ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhDZBEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 21:04:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41782 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231431AbhDZBEN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Apr 2021 21:04:13 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 65F9E60794;
        Mon, 26 Apr 2021 01:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619399012;
        bh=elQrmU2R3JMB9fT8wqnBnDQIoTTKxh1YfUbjZN4Vo5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=1MBOpEmmgpjoLgWrZmkh1SsyGtf61Wo3cSq9yry+QiQQCtV3aOGjGv/XOMyy76nuy
         O6C99JJfkWupnrLJfPgdiyt+1rl8yEMmQ52ALrHKMqYWDZaIVRe1q7mXgFllR39sZS
         A9mAdrgCXlY+7CPB7YSboVEp1p81+RL81AbewhI4RWtHYIJC2f7rNbhUnn00RatREZ
         W3C9PWf6UGVtlwDJaDLwPX0nNYFoOm/EJWTNhwL4IqI4qA6bgsSdfepZsWfEo3e0kc
         Sxe56qQfAW1APQJPvkkagYaamZ/Z3kN+DQRZzRxY0tq4SOI8rM8Y5E60MC/z2B1KaE
         fk1LC9YRhW0kC2sloG25dBaPAgvThRwGU7oQ8nK8D910uN80aynD16e31CuvmoODB4
         q484R09LrRRgBLB2OIUwVjkLyCeiD67ASh4BAbtxY4hSLaWC2b7gmr/NYpZaYXqq5f
         6yGsTo3cBHG9skbH9Vl91w9VLB/QtQASqWUuO1kxm/0pJLssivT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/13] builtin/pack-redundant: avoid casting buffers to struct object_id
Date:   Mon, 26 Apr 2021 01:02:54 +0000
Message-Id: <20210426010301.1093562-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d
In-Reply-To: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
References: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we need our instances of struct object_id to be zero padded, we
can no longer cast unsigned char buffers to be pointers to struct
object_id.  This file reads data out of the pack objects and then
inserts it directly into a linked list item which is a pointer to struct
object_id.  Instead, let's have the linked list item hold its own struct
object_id and copy the data into it.

In addition, since these are not really pointers to struct object_id,
stop passing them around as such, and call them what they really are:
pointers to unsigned char.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pack-redundant.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 7102996c75..8bf5c0acad 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -20,7 +20,7 @@ static int load_all_packs, verbose, alt_odb;
 
 struct llist_item {
 	struct llist_item *next;
-	const struct object_id *oid;
+	struct object_id oid;
 };
 static struct llist {
 	struct llist_item *front;
@@ -95,10 +95,10 @@ static struct llist * llist_copy(struct llist *list)
 
 static inline struct llist_item *llist_insert(struct llist *list,
 					      struct llist_item *after,
-					      const struct object_id *oid)
+					      const unsigned char *oid)
 {
 	struct llist_item *new_item = llist_item_get();
-	new_item->oid = oid;
+	oidread(&new_item->oid, oid);
 	new_item->next = NULL;
 
 	if (after != NULL) {
@@ -118,7 +118,7 @@ static inline struct llist_item *llist_insert(struct llist *list,
 }
 
 static inline struct llist_item *llist_insert_back(struct llist *list,
-						   const struct object_id *oid)
+						   const unsigned char *oid)
 {
 	return llist_insert(list, list->back, oid);
 }
@@ -130,9 +130,9 @@ static inline struct llist_item *llist_insert_sorted_unique(struct llist *list,
 
 	l = (hint == NULL) ? list->front : hint;
 	while (l) {
-		int cmp = oidcmp(l->oid, oid);
+		int cmp = oidcmp(&l->oid, oid);
 		if (cmp > 0) { /* we insert before this entry */
-			return llist_insert(list, prev, oid);
+			return llist_insert(list, prev, oid->hash);
 		}
 		if (!cmp) { /* already exists */
 			return l;
@@ -141,11 +141,11 @@ static inline struct llist_item *llist_insert_sorted_unique(struct llist *list,
 		l = l->next;
 	}
 	/* insert at the end */
-	return llist_insert_back(list, oid);
+	return llist_insert_back(list, oid->hash);
 }
 
 /* returns a pointer to an item in front of sha1 */
-static inline struct llist_item * llist_sorted_remove(struct llist *list, const struct object_id *oid, struct llist_item *hint)
+static inline struct llist_item * llist_sorted_remove(struct llist *list, const unsigned char *oid, struct llist_item *hint)
 {
 	struct llist_item *prev, *l;
 
@@ -153,7 +153,7 @@ static inline struct llist_item * llist_sorted_remove(struct llist *list, const
 	l = (hint == NULL) ? list->front : hint;
 	prev = NULL;
 	while (l) {
-		const int cmp = oidcmp(l->oid, oid);
+		const int cmp = hashcmp(l->oid.hash, oid);
 		if (cmp > 0) /* not in list, since sorted */
 			return prev;
 		if (!cmp) { /* found */
@@ -188,7 +188,7 @@ static void llist_sorted_difference_inplace(struct llist *A,
 	b = B->front;
 
 	while (b) {
-		hint = llist_sorted_remove(A, b->oid, hint);
+		hint = llist_sorted_remove(A, b->oid.hash, hint);
 		b = b->next;
 	}
 }
@@ -260,10 +260,10 @@ static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 		/* cmp ~ p1 - p2 */
 		if (cmp == 0) {
 			p1_hint = llist_sorted_remove(p1->unique_objects,
-					(const struct object_id *)(p1_base + p1_off),
+					p1_base + p1_off,
 					p1_hint);
 			p2_hint = llist_sorted_remove(p2->unique_objects,
-					(const struct object_id *)(p1_base + p1_off),
+					p1_base + p1_off,
 					p2_hint);
 			p1_off += p1_step;
 			p2_off += p2_step;
@@ -455,7 +455,7 @@ static void load_all_objects(void)
 		l = pl->remaining_objects->front;
 		while (l) {
 			hint = llist_insert_sorted_unique(all_objects,
-							  l->oid, hint);
+							  &l->oid, hint);
 			l = l->next;
 		}
 		pl = pl->next;
@@ -521,7 +521,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 	base += 256 * 4 + ((p->index_version < 2) ? 4 : 8);
 	step = the_hash_algo->rawsz + ((p->index_version < 2) ? 4 : 0);
 	while (off < p->num_objects * step) {
-		llist_insert_back(l.remaining_objects, (const struct object_id *)(base + off));
+		llist_insert_back(l.remaining_objects, base + off);
 		off += step;
 	}
 	l.all_objects_size = l.remaining_objects->size;
