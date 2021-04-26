Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F07BC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B791611CD
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhDZBEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 21:04:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41824 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231566AbhDZBEm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Apr 2021 21:04:42 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 638AB6078F;
        Mon, 26 Apr 2021 01:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619399011;
        bh=ryxL8TVkz3SwpwZYerzMP3/FULu0TXbnpOnkVI/nH1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xNpZ7U3jhkTkw4MOtGh6UcL0VtcD1zrRnnC/Ygqmvcm+5zuljhhYIsBbvpBPb6uOi
         JUMov0yXTh1/Obxzp2TV7XpS+7WbK6KLnwuU3ocCSRv4xggIDi4KyTOmhkKE/MJpFU
         Ps57k0kmrI9/yjocbY5gY/kbPLbhs/ysql7pSG+ExQnHcyNIrGJ6/ivhNp9SgftIPX
         XBNZHVgbNxW5uPrGydzQwI1h/YDOaQ9XH6YMYTeAKWPUmz/Hz80IU15c3uYmFPpeko
         9xmTRCnGj/L8C1efm1eW3IBn2jKZhly57B3dgqCy/p4eN8sKBaKgxsXMFUW9/tbh2Y
         7o8ZHp6Zd+8UzoEozI+hVB25bG0rj7ktui37hSq2CTDOYGgruRt9TGwcGdHZPP6V8x
         j5YJtU64lbtx0XGkUX6sSlNqkK7akyB6MBsIT5FvcF0H2xNF5SmQsdZUQbPpooWoX5
         xPwLC57RV1EmRw7H19LIMWaabwokHYiQ/YF0HxaEOmkndaK6ky4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/13] hash: add a function to finalize object IDs
Date:   Mon, 26 Apr 2021 01:02:52 +0000
Message-Id: <20210426010301.1093562-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d
In-Reply-To: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
References: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To avoid the penalty of having to branch in hash comparison functions,
we'll want to always compare the full hash member in a struct object_id,
which will require that SHA-1 object IDs be zero-padded.  To do so, add
a function which finalizes a hash context and writes it into an object
ID that performs this padding.

Move the definition of struct object_id and the constant definitions
higher up so we they are available for us to use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h        | 50 +++++++++++++++++++++++++++-----------------------
 object-file.c | 25 +++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/hash.h b/hash.h
index dafdcb3335..c8f03d8aee 100644
--- a/hash.h
+++ b/hash.h
@@ -95,6 +95,29 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
 /* Number of algorithms supported (including unknown). */
 #define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
 
+/* The length in bytes and in hex digits of an object name (SHA-1 value). */
+#define GIT_SHA1_RAWSZ 20
+#define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
+/* The block size of SHA-1. */
+#define GIT_SHA1_BLKSZ 64
+
+/* The length in bytes and in hex digits of an object name (SHA-256 value). */
+#define GIT_SHA256_RAWSZ 32
+#define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
+/* The block size of SHA-256. */
+#define GIT_SHA256_BLKSZ 64
+
+/* The length in byte and in hex digits of the largest possible hash value. */
+#define GIT_MAX_RAWSZ GIT_SHA256_RAWSZ
+#define GIT_MAX_HEXSZ GIT_SHA256_HEXSZ
+/* The largest possible block size for any supported hash. */
+#define GIT_MAX_BLKSZ GIT_SHA256_BLKSZ
+
+struct object_id {
+	unsigned char hash[GIT_MAX_RAWSZ];
+	int algo;
+};
+
 /* A suitably aligned type for stack allocations of hash contexts. */
 union git_hash_ctx {
 	git_SHA_CTX sha1;
@@ -106,6 +129,7 @@ typedef void (*git_hash_init_fn)(git_hash_ctx *ctx);
 typedef void (*git_hash_clone_fn)(git_hash_ctx *dst, const git_hash_ctx *src);
 typedef void (*git_hash_update_fn)(git_hash_ctx *ctx, const void *in, size_t len);
 typedef void (*git_hash_final_fn)(unsigned char *hash, git_hash_ctx *ctx);
+typedef void (*git_hash_final_oid_fn)(struct object_id *oid, git_hash_ctx *ctx);
 
 struct git_hash_algo {
 	/*
@@ -138,6 +162,9 @@ struct git_hash_algo {
 	/* The hash finalization function. */
 	git_hash_final_fn final_fn;
 
+	/* The hash finalization function for object IDs. */
+	git_hash_final_oid_fn final_oid_fn;
+
 	/* The OID of the empty tree. */
 	const struct object_id *empty_tree;
 
@@ -161,29 +188,6 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 	return p - hash_algos;
 }
 
-/* The length in bytes and in hex digits of an object name (SHA-1 value). */
-#define GIT_SHA1_RAWSZ 20
-#define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
-/* The block size of SHA-1. */
-#define GIT_SHA1_BLKSZ 64
-
-/* The length in bytes and in hex digits of an object name (SHA-256 value). */
-#define GIT_SHA256_RAWSZ 32
-#define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
-/* The block size of SHA-256. */
-#define GIT_SHA256_BLKSZ 64
-
-/* The length in byte and in hex digits of the largest possible hash value. */
-#define GIT_MAX_RAWSZ GIT_SHA256_RAWSZ
-#define GIT_MAX_HEXSZ GIT_SHA256_HEXSZ
-/* The largest possible block size for any supported hash. */
-#define GIT_MAX_BLKSZ GIT_SHA256_BLKSZ
-
-struct object_id {
-	unsigned char hash[GIT_MAX_RAWSZ];
-	int algo;
-};
-
 #define the_hash_algo the_repository->hash_algo
 
 extern const struct object_id null_oid;
diff --git a/object-file.c b/object-file.c
index 624af408cd..ef1eb984c8 100644
--- a/object-file.c
+++ b/object-file.c
@@ -89,6 +89,12 @@ static void git_hash_sha1_final(unsigned char *hash, git_hash_ctx *ctx)
 	git_SHA1_Final(hash, &ctx->sha1);
 }
 
+static void git_hash_sha1_final_oid(struct object_id *oid, git_hash_ctx *ctx)
+{
+	git_SHA1_Final(oid->hash, &ctx->sha1);
+	memset(oid->hash + GIT_SHA1_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA1_RAWSZ);
+}
+
 
 static void git_hash_sha256_init(git_hash_ctx *ctx)
 {
@@ -110,6 +116,16 @@ static void git_hash_sha256_final(unsigned char *hash, git_hash_ctx *ctx)
 	git_SHA256_Final(hash, &ctx->sha256);
 }
 
+static void git_hash_sha256_final_oid(struct object_id *oid, git_hash_ctx *ctx)
+{
+	git_SHA256_Final(oid->hash, &ctx->sha256);
+	/*
+	 * This currently does nothing, so the compiler should optimize it out,
+	 * but keep it in case we extend the hash size again.
+	 */
+	memset(oid->hash + GIT_SHA256_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA256_RAWSZ);
+}
+
 static void git_hash_unknown_init(git_hash_ctx *ctx)
 {
 	BUG("trying to init unknown hash");
@@ -130,6 +146,12 @@ static void git_hash_unknown_final(unsigned char *hash, git_hash_ctx *ctx)
 	BUG("trying to finalize unknown hash");
 }
 
+static void git_hash_unknown_final_oid(struct object_id *oid, git_hash_ctx *ctx)
+{
+	BUG("trying to finalize unknown hash");
+}
+
+
 const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	{
 		NULL,
@@ -141,6 +163,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		git_hash_unknown_clone,
 		git_hash_unknown_update,
 		git_hash_unknown_final,
+		git_hash_unknown_final_oid,
 		NULL,
 		NULL,
 	},
@@ -155,6 +178,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		git_hash_sha1_clone,
 		git_hash_sha1_update,
 		git_hash_sha1_final,
+		git_hash_sha1_final_oid,
 		&empty_tree_oid,
 		&empty_blob_oid,
 	},
@@ -169,6 +193,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		git_hash_sha256_clone,
 		git_hash_sha256_update,
 		git_hash_sha256_final,
+		git_hash_sha256_final_oid,
 		&empty_tree_oid_sha256,
 		&empty_blob_oid_sha256,
 	}
