Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B747C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D348C23428
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgLGTLh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:11:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:55248 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgLGTLg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:11:36 -0500
Received: (qmail 9022 invoked by uid 109); 7 Dec 2020 19:10:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Dec 2020 19:10:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25669 invoked by uid 111); 7 Dec 2020 19:10:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Dec 2020 14:10:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 7 Dec 2020 14:10:55 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/9] cache.h: move hash/oid functions to hash.h
Message-ID: <X85+P165Fk4DoCHc@coredump.intra.peff.net>
References: <X85+GbvmN4wIjsYY@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X85+GbvmN4wIjsYY@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We define git_hash_algo and object_id in hash.h, but most of the utility
functions are declared in the main cache.h. Let's move them to hash.h
along with their struct definitions. This cleans up cache.h a bit, but
also avoids circular dependencies when other headers need to know about
these functions (e.g., if oid-array.h were to have an inline that used
oideq(), it couldn't include cache.h because it is itself included by
cache.h).

No including C files should be affected, because hash.h is always
included in cache.h already.

We do have to mention repository.h at the top of hash.h, though, since
we depend on the_repository in some of our inline functions.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h | 94 --------------------------------------------------------
 hash.h  | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 94 deletions(-)

diff --git a/cache.h b/cache.h
index e986cf4ea9..ec98f5d32c 100644
--- a/cache.h
+++ b/cache.h
@@ -1123,100 +1123,6 @@ const char *repo_find_unique_abbrev(struct repository *r, const struct object_id
 int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
 #define find_unique_abbrev_r(hex, oid, len) repo_find_unique_abbrev_r(the_repository, hex, oid, len)
 
-extern const struct object_id null_oid;
-
-static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
-{
-	/*
-	 * Teach the compiler that there are only two possibilities of hash size
-	 * here, so that it can optimize for this case as much as possible.
-	 */
-	if (the_hash_algo->rawsz == GIT_MAX_RAWSZ)
-		return memcmp(sha1, sha2, GIT_MAX_RAWSZ);
-	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
-}
-
-static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
-{
-	return hashcmp(oid1->hash, oid2->hash);
-}
-
-static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
-{
-	/*
-	 * We write this here instead of deferring to hashcmp so that the
-	 * compiler can properly inline it and avoid calling memcmp.
-	 */
-	if (the_hash_algo->rawsz == GIT_MAX_RAWSZ)
-		return !memcmp(sha1, sha2, GIT_MAX_RAWSZ);
-	return !memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
-}
-
-static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)
-{
-	return hasheq(oid1->hash, oid2->hash);
-}
-
-static inline int is_null_oid(const struct object_id *oid)
-{
-	return oideq(oid, &null_oid);
-}
-
-static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
-{
-	memcpy(sha_dst, sha_src, the_hash_algo->rawsz);
-}
-
-static inline void oidcpy(struct object_id *dst, const struct object_id *src)
-{
-	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
-}
-
-static inline struct object_id *oiddup(const struct object_id *src)
-{
-	struct object_id *dst = xmalloc(sizeof(struct object_id));
-	oidcpy(dst, src);
-	return dst;
-}
-
-static inline void hashclr(unsigned char *hash)
-{
-	memset(hash, 0, the_hash_algo->rawsz);
-}
-
-static inline void oidclr(struct object_id *oid)
-{
-	memset(oid->hash, 0, GIT_MAX_RAWSZ);
-}
-
-static inline void oidread(struct object_id *oid, const unsigned char *hash)
-{
-	memcpy(oid->hash, hash, the_hash_algo->rawsz);
-}
-
-static inline int is_empty_blob_sha1(const unsigned char *sha1)
-{
-	return hasheq(sha1, the_hash_algo->empty_blob->hash);
-}
-
-static inline int is_empty_blob_oid(const struct object_id *oid)
-{
-	return oideq(oid, the_hash_algo->empty_blob);
-}
-
-static inline int is_empty_tree_sha1(const unsigned char *sha1)
-{
-	return hasheq(sha1, the_hash_algo->empty_tree->hash);
-}
-
-static inline int is_empty_tree_oid(const struct object_id *oid)
-{
-	return oideq(oid, the_hash_algo->empty_tree);
-}
-
-const char *empty_tree_oid_hex(void);
-const char *empty_blob_oid_hex(void);
-
 /* set default permissions by passing mode arguments to open(2) */
 int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
 int git_mkstemp_mode(char *pattern, int mode);
diff --git a/hash.h b/hash.h
index e0f3f16b06..3fb0c3d400 100644
--- a/hash.h
+++ b/hash.h
@@ -2,6 +2,7 @@
 #define HASH_H
 
 #include "git-compat-util.h"
+#include "repository.h"
 
 #if defined(SHA1_PPC)
 #include "ppc/sha1.h"
@@ -184,4 +185,98 @@ struct object_id {
 
 #define the_hash_algo the_repository->hash_algo
 
+extern const struct object_id null_oid;
+
+static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
+{
+	/*
+	 * Teach the compiler that there are only two possibilities of hash size
+	 * here, so that it can optimize for this case as much as possible.
+	 */
+	if (the_hash_algo->rawsz == GIT_MAX_RAWSZ)
+		return memcmp(sha1, sha2, GIT_MAX_RAWSZ);
+	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
+}
+
+static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
+{
+	return hashcmp(oid1->hash, oid2->hash);
+}
+
+static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
+{
+	/*
+	 * We write this here instead of deferring to hashcmp so that the
+	 * compiler can properly inline it and avoid calling memcmp.
+	 */
+	if (the_hash_algo->rawsz == GIT_MAX_RAWSZ)
+		return !memcmp(sha1, sha2, GIT_MAX_RAWSZ);
+	return !memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
+}
+
+static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)
+{
+	return hasheq(oid1->hash, oid2->hash);
+}
+
+static inline int is_null_oid(const struct object_id *oid)
+{
+	return oideq(oid, &null_oid);
+}
+
+static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
+{
+	memcpy(sha_dst, sha_src, the_hash_algo->rawsz);
+}
+
+static inline void oidcpy(struct object_id *dst, const struct object_id *src)
+{
+	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
+}
+
+static inline struct object_id *oiddup(const struct object_id *src)
+{
+	struct object_id *dst = xmalloc(sizeof(struct object_id));
+	oidcpy(dst, src);
+	return dst;
+}
+
+static inline void hashclr(unsigned char *hash)
+{
+	memset(hash, 0, the_hash_algo->rawsz);
+}
+
+static inline void oidclr(struct object_id *oid)
+{
+	memset(oid->hash, 0, GIT_MAX_RAWSZ);
+}
+
+static inline void oidread(struct object_id *oid, const unsigned char *hash)
+{
+	memcpy(oid->hash, hash, the_hash_algo->rawsz);
+}
+
+static inline int is_empty_blob_sha1(const unsigned char *sha1)
+{
+	return hasheq(sha1, the_hash_algo->empty_blob->hash);
+}
+
+static inline int is_empty_blob_oid(const struct object_id *oid)
+{
+	return oideq(oid, the_hash_algo->empty_blob);
+}
+
+static inline int is_empty_tree_sha1(const unsigned char *sha1)
+{
+	return hasheq(sha1, the_hash_algo->empty_tree->hash);
+}
+
+static inline int is_empty_tree_oid(const struct object_id *oid)
+{
+	return oideq(oid, the_hash_algo->empty_tree);
+}
+
+const char *empty_tree_oid_hex(void);
+const char *empty_blob_oid_hex(void);
+
 #endif
-- 
2.29.2.980.g762a4e4ed3

