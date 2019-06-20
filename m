Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 355E21F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbfFTHlw (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:41:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:45510 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726732AbfFTHlw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:41:52 -0400
Received: (qmail 16796 invoked by uid 109); 20 Jun 2019 07:41:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:41:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13056 invoked by uid 111); 20 Jun 2019 07:42:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:42:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:41:49 -0400
Date:   Thu, 20 Jun 2019 03:41:49 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 17/17] hashmap: convert sha1hash() to oidhash()
Message-ID: <20190620074149.GQ3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are no callers left of sha1hash() that do not simply pass the
"hash" member of a "struct object_id". Let's get rid of the outdated
sha1-specific function and provide one that operates on the whole struct
(even though the technique, taking the first few bytes of the hash, will
remain the same).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/describe.c | 4 ++--
 decorate.c         | 2 +-
 diffcore-rename.c  | 2 +-
 hashmap.h          | 8 +++++---
 khash.h            | 2 +-
 object.c           | 2 +-
 pack-objects.c     | 2 +-
 patch-ids.c        | 2 +-
 8 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 0a5cde00a2..200154297d 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -76,7 +76,7 @@ static int commit_name_neq(const void *unused_cmp_data,
 
 static inline struct commit_name *find_commit_name(const struct object_id *peeled)
 {
-	return hashmap_get_from_hash(&names, sha1hash(peeled->hash), peeled);
+	return hashmap_get_from_hash(&names, oidhash(peeled), peeled);
 }
 
 static int replace_name(struct commit_name *e,
@@ -123,7 +123,7 @@ static void add_to_known_names(const char *path,
 		if (!e) {
 			e = xmalloc(sizeof(struct commit_name));
 			oidcpy(&e->peeled, peeled);
-			hashmap_entry_init(e, sha1hash(peeled->hash));
+			hashmap_entry_init(e, oidhash(peeled));
 			hashmap_add(&names, e);
 			e->path = NULL;
 		}
diff --git a/decorate.c b/decorate.c
index de31331fa4..a605b1b5f4 100644
--- a/decorate.c
+++ b/decorate.c
@@ -8,7 +8,7 @@
 
 static unsigned int hash_obj(const struct object *obj, unsigned int n)
 {
-	return sha1hash(obj->oid.hash) % n;
+	return oidhash(&obj->oid) % n;
 }
 
 static void *insert_decoration(struct decoration *n, const struct object *base, void *decoration)
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 07bd34b631..1e50d491c1 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -266,7 +266,7 @@ static unsigned int hash_filespec(struct repository *r,
 		hash_object_file(filespec->data, filespec->size, "blob",
 				 &filespec->oid);
 	}
-	return sha1hash(filespec->oid.hash);
+	return oidhash(&filespec->oid);
 }
 
 static int find_identical_files(struct hashmap *srcs,
diff --git a/hashmap.h b/hashmap.h
index f95593b6cf..8424911566 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -1,6 +1,8 @@
 #ifndef HASHMAP_H
 #define HASHMAP_H
 
+#include "hash.h"
+
 /*
  * Generic implementation of hash-based key-value mappings.
  *
@@ -118,14 +120,14 @@ unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len);
  * the results will be different on big-endian and little-endian
  * platforms, so they should not be stored or transferred over the net.
  */
-static inline unsigned int sha1hash(const unsigned char *sha1)
+static inline unsigned int oidhash(const struct object_id *oid)
 {
 	/*
-	 * Equivalent to 'return *(unsigned int *)sha1;', but safe on
+	 * Equivalent to 'return *(unsigned int *)oid->hash;', but safe on
 	 * platforms that don't support unaligned reads.
 	 */
 	unsigned int hash;
-	memcpy(&hash, sha1, sizeof(hash));
+	memcpy(&hash, oid->hash, sizeof(hash));
 	return hash;
 }
 
diff --git a/khash.h b/khash.h
index f911d2b005..21c2095216 100644
--- a/khash.h
+++ b/khash.h
@@ -326,7 +326,7 @@ static const double __ac_HASH_UPPER = 0.77;
 
 static inline unsigned int oidhash_by_value(struct object_id oid)
 {
-	return sha1hash(oid.hash);
+	return oidhash(&oid);
 }
 
 static inline int oideq_by_value(struct object_id a, struct object_id b)
diff --git a/object.c b/object.c
index 317647da3e..94db02214a 100644
--- a/object.c
+++ b/object.c
@@ -61,7 +61,7 @@ int type_from_string_gently(const char *str, ssize_t len, int gentle)
  */
 static unsigned int hash_obj(const struct object_id *oid, unsigned int n)
 {
-	return sha1hash(oid->hash) & (n - 1);
+	return oidhash(oid) & (n - 1);
 }
 
 /*
diff --git a/pack-objects.c b/pack-objects.c
index 00a5f6e0ec..52560293b6 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -11,7 +11,7 @@ static uint32_t locate_object_entry_hash(struct packing_data *pdata,
 {
 	uint32_t i, mask = (pdata->index_size - 1);
 
-	i = sha1hash(oid->hash) & mask;
+	i = oidhash(oid) & mask;
 
 	while (pdata->index[i] > 0) {
 		uint32_t pos = pdata->index[i] - 1;
diff --git a/patch-ids.c b/patch-ids.c
index f70d396654..e8c150d0c9 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -83,7 +83,7 @@ static int init_patch_id_entry(struct patch_id *patch,
 	if (commit_patch_id(commit, &ids->diffopts, &header_only_patch_id, 1, 0))
 		return -1;
 
-	hashmap_entry_init(patch, sha1hash(header_only_patch_id.hash));
+	hashmap_entry_init(patch, oidhash(&header_only_patch_id));
 	return 0;
 }
 
-- 
2.22.0.732.g5402924b4b
