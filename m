Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A64CC35673
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE20206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Oj5nPANg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgBVUSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:06 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39074 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726730AbgBVUSF (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:05 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8D67D6079B
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402684;
        bh=CSCNT6QoBLzMZbyUY104Pn1dZh0iHk6EVXTM8gjCi+c=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=Oj5nPANgc90ulWjc1CW3qQKUH4uozjgD41teS+Sfvrp3bbYHLOz0HO+oWyNaAjJ4i
         P+CIOf36qHljgOKybzdfXp9hghNWx/KgBScFQuHjsCaLKhEFy01cJZ06sZq/i9PAef
         0mMXCuOlEu3abF1wAytRlnx+eR6fxTKuWZibDpfo476vZKFMowIdtBvilcfUFIJ1mM
         1bwqc97Y1R2kjFY8YtJg1R4AyuJi+jwYKqILMeCfpKxIiDnSNq1OZ6TtwT+HH9Eaxs
         4JiCxn5c4P3/Gf9TuaGDAFpbr2qr2XZTch1KGkkks/SYrYip8GdRhCm4/Jqf1IRCU4
         wjwbuJCygNCpjLBaIIH41PKD7GUjHwkVky4Ka/I+Hxo/8J7pnnawlIhmL/oZDeXkzr
         dwqMlDGqtg8dyMm9wib6Gb39vGXm8gRg9Ri4fjy+9tzhQX+tXJY67NR7u4vJQ7A1IM
         ehOa6olYftrZbLD82WHBnmtX8U5dZR+tdRyGsERrMyAoCoRph5n
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 02/24] hash: implement and use a context cloning function
Date:   Sat, 22 Feb 2020 20:17:27 +0000
Message-Id: <20200222201749.937983-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For all of our SHA-1 implementations and most of our SHA-256
implementations, the hash context we use is a real struct.  For these
implementations, it's possible to copy a hash context by making a copy
of the struct.

However, for our libgcrypt implementation, our hash context is a
pointer.  Consequently, copying it does not lead to an independent hash
context like we intended.

Fortunately, however, libgcrypt provides us with a handy function to
copy hash contexts.  Let's add a cloning function to the hash algorithm
API, and use it in the one place we need to make a hash context copy.
With this change, our libgcrypt SHA-256 implementation is fully
functional with all of our other hash implementations.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 csum-file.c     |  2 +-
 hash.h          | 21 +++++++++++++++++++++
 sha1-file.c     | 18 ++++++++++++++++++
 sha256/gcrypt.h |  6 ++++++
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/csum-file.c b/csum-file.c
index 53ce37f7ca..0f35fa5ee4 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -157,7 +157,7 @@ void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpo
 {
 	hashflush(f);
 	checkpoint->offset = f->total;
-	checkpoint->ctx = f->ctx;
+	the_hash_algo->clone_fn(&checkpoint->ctx, &f->ctx);
 }
 
 int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
diff --git a/hash.h b/hash.h
index 52a4f1a3f4..e0f3f16b06 100644
--- a/hash.h
+++ b/hash.h
@@ -16,6 +16,7 @@
 #endif
 
 #if defined(SHA256_GCRYPT)
+#define SHA256_NEEDS_CLONE_HELPER
 #include "sha256/gcrypt.h"
 #elif defined(SHA256_OPENSSL)
 #include <openssl/sha.h>
@@ -54,12 +55,28 @@
 #define git_SHA256_Update	platform_SHA256_Update
 #define git_SHA256_Final	platform_SHA256_Final
 
+#ifdef platform_SHA256_Clone
+#define git_SHA256_Clone	platform_SHA256_Clone
+#endif
+
 #ifdef SHA1_MAX_BLOCK_SIZE
 #include "compat/sha1-chunked.h"
 #undef git_SHA1_Update
 #define git_SHA1_Update		git_SHA1_Update_Chunked
 #endif
 
+static inline void git_SHA1_Clone(git_SHA_CTX *dst, const git_SHA_CTX *src)
+{
+	memcpy(dst, src, sizeof(*dst));
+}
+
+#ifndef SHA256_NEEDS_CLONE_HELPER
+static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *src)
+{
+	memcpy(dst, src, sizeof(*dst));
+}
+#endif
+
 /*
  * Note that these constants are suitable for indexing the hash_algos array and
  * comparing against each other, but are otherwise arbitrary, so they should not
@@ -85,6 +102,7 @@ union git_hash_ctx {
 typedef union git_hash_ctx git_hash_ctx;
 
 typedef void (*git_hash_init_fn)(git_hash_ctx *ctx);
+typedef void (*git_hash_clone_fn)(git_hash_ctx *dst, const git_hash_ctx *src);
 typedef void (*git_hash_update_fn)(git_hash_ctx *ctx, const void *in, size_t len);
 typedef void (*git_hash_final_fn)(unsigned char *hash, git_hash_ctx *ctx);
 
@@ -110,6 +128,9 @@ struct git_hash_algo {
 	/* The hash initialization function. */
 	git_hash_init_fn init_fn;
 
+	/* The hash context cloning function. */
+	git_hash_clone_fn clone_fn;
+
 	/* The hash update function. */
 	git_hash_update_fn update_fn;
 
diff --git a/sha1-file.c b/sha1-file.c
index d785de8a85..c36ca5a545 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -74,6 +74,11 @@ static void git_hash_sha1_init(git_hash_ctx *ctx)
 	git_SHA1_Init(&ctx->sha1);
 }
 
+static void git_hash_sha1_clone(git_hash_ctx *dst, const git_hash_ctx *src)
+{
+	git_SHA1_Clone(&dst->sha1, &src->sha1);
+}
+
 static void git_hash_sha1_update(git_hash_ctx *ctx, const void *data, size_t len)
 {
 	git_SHA1_Update(&ctx->sha1, data, len);
@@ -90,6 +95,11 @@ static void git_hash_sha256_init(git_hash_ctx *ctx)
 	git_SHA256_Init(&ctx->sha256);
 }
 
+static void git_hash_sha256_clone(git_hash_ctx *dst, const git_hash_ctx *src)
+{
+	git_SHA256_Clone(&dst->sha256, &src->sha256);
+}
+
 static void git_hash_sha256_update(git_hash_ctx *ctx, const void *data, size_t len)
 {
 	git_SHA256_Update(&ctx->sha256, data, len);
@@ -105,6 +115,11 @@ static void git_hash_unknown_init(git_hash_ctx *ctx)
 	BUG("trying to init unknown hash");
 }
 
+static void git_hash_unknown_clone(git_hash_ctx *dst, const git_hash_ctx *src)
+{
+	BUG("trying to clone unknown hash");
+}
+
 static void git_hash_unknown_update(git_hash_ctx *ctx, const void *data, size_t len)
 {
 	BUG("trying to update unknown hash");
@@ -123,6 +138,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		0,
 		0,
 		git_hash_unknown_init,
+		git_hash_unknown_clone,
 		git_hash_unknown_update,
 		git_hash_unknown_final,
 		NULL,
@@ -136,6 +152,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		GIT_SHA1_HEXSZ,
 		GIT_SHA1_BLKSZ,
 		git_hash_sha1_init,
+		git_hash_sha1_clone,
 		git_hash_sha1_update,
 		git_hash_sha1_final,
 		&empty_tree_oid,
@@ -149,6 +166,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		GIT_SHA256_HEXSZ,
 		GIT_SHA256_BLKSZ,
 		git_hash_sha256_init,
+		git_hash_sha256_clone,
 		git_hash_sha256_update,
 		git_hash_sha256_final,
 		&empty_tree_oid_sha256,
diff --git a/sha256/gcrypt.h b/sha256/gcrypt.h
index 09bd8bb200..501da5ed91 100644
--- a/sha256/gcrypt.h
+++ b/sha256/gcrypt.h
@@ -22,8 +22,14 @@ inline void gcrypt_SHA256_Final(unsigned char *digest, gcrypt_SHA256_CTX *ctx)
 	memcpy(digest, gcry_md_read(*ctx, GCRY_MD_SHA256), SHA256_DIGEST_SIZE);
 }
 
+inline void gcrypt_SHA256_Clone(gcrypt_SHA256_CTX *dst, const gcrypt_SHA256_CTX *src)
+{
+	gcry_md_copy(dst, *src);
+}
+
 #define platform_SHA256_CTX gcrypt_SHA256_CTX
 #define platform_SHA256_Init gcrypt_SHA256_Init
+#define platform_SHA256_Clone gcrypt_SHA256_Clone
 #define platform_SHA256_Update gcrypt_SHA256_Update
 #define platform_SHA256_Final gcrypt_SHA256_Final
 
