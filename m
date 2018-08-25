Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A411F404
	for <e@80x24.org>; Sat, 25 Aug 2018 08:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeHYLq1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 07:46:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:55722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726412AbeHYLq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 07:46:26 -0400
Received: (qmail 5136 invoked by uid 109); 25 Aug 2018 08:08:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Aug 2018 08:08:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2374 invoked by uid 111); 25 Aug 2018 08:08:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 25 Aug 2018 04:08:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Aug 2018 04:08:15 -0400
Date:   Sat, 25 Aug 2018 04:08:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 4/9] convert "hashcmp() == 0" to hasheq()
Message-ID: <20180825080814.GD737@sigill.intra.peff.net>
References: <20180825080031.GA32139@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180825080031.GA32139@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the partner patch to the previous one, but covering
the "hash" variants instead of "oid".  Note that our
coccinelle rule is slightly more complex to avoid triggering
the call in hasheq().

I didn't bother to add a new rule to convert:

  - hasheq(E1->hash, E2->hash)
  + oideq(E1, E2)

Since these are new functions, there won't be any such
existing callers. And since most of the code is already
using oideq, we're not likely to introduce new ones.

We might still see "!hashcmp(E1->hash, E2->hash)" from topics
in flight. But because our new rule comes after the existing
ones, that should first get converted to "!oidcmp(E1, E2)"
and then to "oideq(E1, E2)".

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c                    |  2 +-
 cache.h                            |  8 ++++----
 contrib/coccinelle/object_id.cocci |  9 +++++++++
 http-walker.c                      |  2 +-
 notes.c                            |  2 +-
 object.c                           |  2 +-
 pack-objects.c                     |  2 +-
 packfile.c                         | 10 +++++-----
 8 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 32b1d5d383..84e0e8080f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -238,7 +238,7 @@ static int will_fetch(struct ref **head, const unsigned char *sha1)
 {
 	struct ref *rm = *head;
 	while (rm) {
-		if (!hashcmp(rm->old_oid.hash, sha1))
+		if (hasheq(rm->old_oid.hash, sha1))
 			return 1;
 		rm = rm->next;
 	}
diff --git a/cache.h b/cache.h
index d090f71706..d97db26bb6 100644
--- a/cache.h
+++ b/cache.h
@@ -1053,12 +1053,12 @@ static inline int oideq(const struct object_id *oid1, const struct object_id *oi
 
 static inline int is_null_sha1(const unsigned char *sha1)
 {
-	return !hashcmp(sha1, null_sha1);
+	return hasheq(sha1, null_sha1);
 }
 
 static inline int is_null_oid(const struct object_id *oid)
 {
-	return !hashcmp(oid->hash, null_sha1);
+	return hasheq(oid->hash, null_sha1);
 }
 
 static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
@@ -1095,7 +1095,7 @@ static inline void oidread(struct object_id *oid, const unsigned char *hash)
 
 static inline int is_empty_blob_sha1(const unsigned char *sha1)
 {
-	return !hashcmp(sha1, the_hash_algo->empty_blob->hash);
+	return hasheq(sha1, the_hash_algo->empty_blob->hash);
 }
 
 static inline int is_empty_blob_oid(const struct object_id *oid)
@@ -1105,7 +1105,7 @@ static inline int is_empty_blob_oid(const struct object_id *oid)
 
 static inline int is_empty_tree_sha1(const unsigned char *sha1)
 {
-	return !hashcmp(sha1, the_hash_algo->empty_tree->hash);
+	return hasheq(sha1, the_hash_algo->empty_tree->hash);
 }
 
 static inline int is_empty_tree_oid(const struct object_id *oid)
diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
index 548c02336d..d90ba8a040 100644
--- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -114,3 +114,12 @@ expression E1, E2;
 @@
 - oidcmp(E1, E2) == 0
 + oideq(E1, E2)
+
+@@
+identifier f != hasheq;
+expression E1, E2;
+@@
+  f(...) {<...
+- hashcmp(E1, E2) == 0
++ hasheq(E1, E2)
+  ...>}
diff --git a/http-walker.c b/http-walker.c
index 7cdfb2f24c..3a8edc7f2f 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -483,7 +483,7 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 
 	list_for_each(pos, head) {
 		obj_req = list_entry(pos, struct object_request, node);
-		if (!hashcmp(obj_req->oid.hash, sha1))
+		if (hasheq(obj_req->oid.hash, sha1))
 			break;
 	}
 	if (obj_req == NULL)
diff --git a/notes.c b/notes.c
index b3386d6c36..33d16c1ec3 100644
--- a/notes.c
+++ b/notes.c
@@ -147,7 +147,7 @@ static struct leaf_node *note_tree_find(struct notes_tree *t,
 	void **p = note_tree_search(t, &tree, &n, key_sha1);
 	if (GET_PTR_TYPE(*p) == PTR_TYPE_NOTE) {
 		struct leaf_node *l = (struct leaf_node *) CLR_PTR_TYPE(*p);
-		if (!hashcmp(key_sha1, l->key_oid.hash))
+		if (hasheq(key_sha1, l->key_oid.hash))
 			return l;
 	}
 	return NULL;
diff --git a/object.c b/object.c
index 51c4594515..e54160550c 100644
--- a/object.c
+++ b/object.c
@@ -95,7 +95,7 @@ struct object *lookup_object(struct repository *r, const unsigned char *sha1)
 
 	first = i = hash_obj(sha1, r->parsed_objects->obj_hash_size);
 	while ((obj = r->parsed_objects->obj_hash[i]) != NULL) {
-		if (!hashcmp(sha1, obj->oid.hash))
+		if (hasheq(sha1, obj->oid.hash))
 			break;
 		i++;
 		if (i == r->parsed_objects->obj_hash_size)
diff --git a/pack-objects.c b/pack-objects.c
index 6ef87e5683..2bc7626997 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -16,7 +16,7 @@ static uint32_t locate_object_entry_hash(struct packing_data *pdata,
 	while (pdata->index[i] > 0) {
 		uint32_t pos = pdata->index[i] - 1;
 
-		if (!hashcmp(sha1, pdata->objects[pos].idx.oid.hash)) {
+		if (hasheq(sha1, pdata->objects[pos].idx.oid.hash)) {
 			*found = 1;
 			return i;
 		}
diff --git a/packfile.c b/packfile.c
index ebcb5742ec..c2e96293ad 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1015,7 +1015,7 @@ void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1)
 {
 	unsigned i;
 	for (i = 0; i < p->num_bad_objects; i++)
-		if (!hashcmp(sha1, p->bad_object_sha1 + GIT_SHA1_RAWSZ * i))
+		if (hasheq(sha1, p->bad_object_sha1 + GIT_SHA1_RAWSZ * i))
 			return;
 	p->bad_object_sha1 = xrealloc(p->bad_object_sha1,
 				      st_mult(GIT_MAX_RAWSZ,
@@ -1031,8 +1031,8 @@ const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
 
 	for (p = the_repository->objects->packed_git; p; p = p->next)
 		for (i = 0; i < p->num_bad_objects; i++)
-			if (!hashcmp(sha1,
-				     p->bad_object_sha1 + the_hash_algo->rawsz * i))
+			if (hasheq(sha1,
+				   p->bad_object_sha1 + the_hash_algo->rawsz * i))
 				return p;
 	return NULL;
 }
@@ -1830,8 +1830,8 @@ static int fill_pack_entry(const struct object_id *oid,
 	if (p->num_bad_objects) {
 		unsigned i;
 		for (i = 0; i < p->num_bad_objects; i++)
-			if (!hashcmp(oid->hash,
-				     p->bad_object_sha1 + the_hash_algo->rawsz * i))
+			if (hasheq(oid->hash,
+				   p->bad_object_sha1 + the_hash_algo->rawsz * i))
 				return 0;
 	}
 
-- 
2.19.0.rc0.412.g7005db4e88

