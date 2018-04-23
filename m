Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B0401F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932737AbeDWXk3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60562 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932723AbeDWXkY (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 17D2160B36;
        Mon, 23 Apr 2018 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526823;
        bh=NvxzTlRT5yJ6DBdS6gnNCpgCyBqZHAo1KmYh77nuPV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=tJhVHhwLyKeKwit6DfG7EHjSYE5lMzvEFS9+xxQ65o4YU6OleCOB3vO1v5bfWq/b6
         1MfC2OQWY6AAzPsSp9GYJSLr2mrnvg8t15Z1W4KSASbfnKyaLZB2iANZ2EkKpCBLeN
         JuQHz/8A/rwuvIPFxruTfGRVB0McWtKZaJ9SJXcDERxvXybOyRhIlgumB7p7ci9bz7
         2DRg8CI7eX7BuRWY4L92/SI4nM7uPB3fbbOd5wh0+GJ5ianJQ2SMx8aRwV78QthPBa
         IIBI5xbqO0ji+DK5OeNv0EUWyAnByCC7b1hQTnOq5h8bukz5XzkNKqRBLgluGbK4O0
         FCm/VSiJE7BbI6ly1XJ4r2IheCQdB/oqtae/HVHcrIH+Ozx5ka3vj0BIvbGdx1s61q
         /RB3BbMNu441Gbgt+j5khx3GSUemDN8BQvE6mzSWlaqOgLqchOIjVcWWRFKYyJVjIF
         hr/upOxy593jCDgfUYdVqdkRAfzxhhScOpis7PLZEu4CC3o5a1u
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 17/41] pack-redundant: convert linked lists to use struct object_id
Date:   Mon, 23 Apr 2018 23:39:27 +0000
Message-Id: <20180423233951.276447-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert struct llist_item and the rest of the linked list code to use
struct object_id.  Add a use of GIT_MAX_HEXSZ to avoid a dependency on a
hard-coded constant.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pack-redundant.c | 50 +++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 0fe1ff3cb7..0494dceff7 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -20,7 +20,7 @@ static int load_all_packs, verbose, alt_odb;
 
 struct llist_item {
 	struct llist_item *next;
-	const unsigned char *sha1;
+	const struct object_id *oid;
 };
 static struct llist {
 	struct llist_item *front;
@@ -90,14 +90,14 @@ static struct llist * llist_copy(struct llist *list)
 		return ret;
 
 	new_item = ret->front = llist_item_get();
-	new_item->sha1 = list->front->sha1;
+	new_item->oid = list->front->oid;
 
 	old_item = list->front->next;
 	while (old_item) {
 		prev = new_item;
 		new_item = llist_item_get();
 		prev->next = new_item;
-		new_item->sha1 = old_item->sha1;
+		new_item->oid = old_item->oid;
 		old_item = old_item->next;
 	}
 	new_item->next = NULL;
@@ -108,10 +108,10 @@ static struct llist * llist_copy(struct llist *list)
 
 static inline struct llist_item *llist_insert(struct llist *list,
 					      struct llist_item *after,
-					       const unsigned char *sha1)
+					      const struct object_id *oid)
 {
 	struct llist_item *new_item = llist_item_get();
-	new_item->sha1 = sha1;
+	new_item->oid = oid;
 	new_item->next = NULL;
 
 	if (after != NULL) {
@@ -131,21 +131,21 @@ static inline struct llist_item *llist_insert(struct llist *list,
 }
 
 static inline struct llist_item *llist_insert_back(struct llist *list,
-						   const unsigned char *sha1)
+						   const struct object_id *oid)
 {
-	return llist_insert(list, list->back, sha1);
+	return llist_insert(list, list->back, oid);
 }
 
 static inline struct llist_item *llist_insert_sorted_unique(struct llist *list,
-			const unsigned char *sha1, struct llist_item *hint)
+			const struct object_id *oid, struct llist_item *hint)
 {
 	struct llist_item *prev = NULL, *l;
 
 	l = (hint == NULL) ? list->front : hint;
 	while (l) {
-		int cmp = hashcmp(l->sha1, sha1);
+		int cmp = oidcmp(l->oid, oid);
 		if (cmp > 0) { /* we insert before this entry */
-			return llist_insert(list, prev, sha1);
+			return llist_insert(list, prev, oid);
 		}
 		if (!cmp) { /* already exists */
 			return l;
@@ -154,11 +154,11 @@ static inline struct llist_item *llist_insert_sorted_unique(struct llist *list,
 		l = l->next;
 	}
 	/* insert at the end */
-	return llist_insert_back(list, sha1);
+	return llist_insert_back(list, oid);
 }
 
 /* returns a pointer to an item in front of sha1 */
-static inline struct llist_item * llist_sorted_remove(struct llist *list, const unsigned char *sha1, struct llist_item *hint)
+static inline struct llist_item * llist_sorted_remove(struct llist *list, const struct object_id *oid, struct llist_item *hint)
 {
 	struct llist_item *prev, *l;
 
@@ -166,7 +166,7 @@ static inline struct llist_item * llist_sorted_remove(struct llist *list, const
 	l = (hint == NULL) ? list->front : hint;
 	prev = NULL;
 	while (l) {
-		int cmp = hashcmp(l->sha1, sha1);
+		int cmp = oidcmp(l->oid, oid);
 		if (cmp > 0) /* not in list, since sorted */
 			return prev;
 		if (!cmp) { /* found */
@@ -201,7 +201,7 @@ static void llist_sorted_difference_inplace(struct llist *A,
 	b = B->front;
 
 	while (b) {
-		hint = llist_sorted_remove(A, b->sha1, hint);
+		hint = llist_sorted_remove(A, b->oid, hint);
 		b = b->next;
 	}
 }
@@ -268,9 +268,11 @@ static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 		/* cmp ~ p1 - p2 */
 		if (cmp == 0) {
 			p1_hint = llist_sorted_remove(p1->unique_objects,
-					p1_base + p1_off, p1_hint);
+					(const struct object_id *)(p1_base + p1_off),
+					p1_hint);
 			p2_hint = llist_sorted_remove(p2->unique_objects,
-					p1_base + p1_off, p2_hint);
+					(const struct object_id *)(p1_base + p1_off),
+					p2_hint);
 			p1_off += p1_step;
 			p2_off += p2_step;
 			continue;
@@ -501,7 +503,7 @@ static void load_all_objects(void)
 		l = pl->all_objects->front;
 		while (l) {
 			hint = llist_insert_sorted_unique(all_objects,
-							  l->sha1, hint);
+							  l->oid, hint);
 			l = l->next;
 		}
 		pl = pl->next;
@@ -562,7 +564,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 	base += 256 * 4 + ((p->index_version < 2) ? 4 : 8);
 	step = the_hash_algo->rawsz + ((p->index_version < 2) ? 4 : 0);
 	while (off < p->num_objects * step) {
-		llist_insert_back(l.all_objects, base + off);
+		llist_insert_back(l.all_objects, (const struct object_id *)(base + off));
 		off += step;
 	}
 	/* this list will be pruned in cmp_two_packs later */
@@ -603,8 +605,8 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 	int i;
 	struct pack_list *min, *red, *pl;
 	struct llist *ignore;
-	unsigned char *sha1;
-	char buf[42]; /* 40 byte sha1 + \n + \0 */
+	struct object_id *oid;
+	char buf[GIT_MAX_HEXSZ + 2]; /* hex hash + \n + \0 */
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(pack_redundant_usage);
@@ -652,10 +654,10 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 	llist_init(&ignore);
 	if (!isatty(0)) {
 		while (fgets(buf, sizeof(buf), stdin)) {
-			sha1 = xmalloc(20);
-			if (get_sha1_hex(buf, sha1))
-				die("Bad sha1 on stdin: %s", buf);
-			llist_insert_sorted_unique(ignore, sha1, NULL);
+			oid = xmalloc(sizeof(*oid));
+			if (get_oid_hex(buf, oid))
+				die("Bad object ID on stdin: %s", buf);
+			llist_insert_sorted_unique(ignore, oid, NULL);
 		}
 	}
 	llist_sorted_difference_inplace(all_objects, ignore);
