Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E613C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379AB611CA
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhDJPWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 11:22:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58502 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234831AbhDJPWu (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Apr 2021 11:22:50 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2A28A60426;
        Sat, 10 Apr 2021 15:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618068155;
        bh=vqJAyLafbmuRDs1W7QKTqullE5g8jQTJvfc3E4rx0GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=KUVq8vtIoYp72Z8UCAbZrDeRmv4HOk24W38TJjXX938YfMMYhT+cU1I3a/hAGxdfv
         /E/hKgXee8jeFGd6pyayjo8Dg9M9YcCOE4L6mPK6zW9GyLBJAzunq+52ewmneE+98/
         3glzuw6kibhSUncIqpiDWE4BSMkLcJXoHFAz+zA1c+hYB+z0iHS2yTO8ScSrztjMLr
         R8aYDkqmVlmQ5adY//RLU8jzdlel/64oaZ333kRT9/88aMlmWO6oKPtohULvGWQoXo
         C+na+Hglrk7LksHmRH7t8zZkqkW9Ro86FwQacrD3hakH+imJg0vPlaQafHjFC4MtPk
         nlhnP23mLPhACTFm9mlwfe7Dh3xnAr18ScPyN1iV98KRXvejQ4jlAglh3oI22RxTP/
         l8BYdkXKO7GFVrv7p4aD3MZG28UR49SyfqPppqaf6wJa4mQKgZ9he+hogInBigI3uS
         IKDyF3W25mIUK6oKkSEYGbeka6QlcVBdjoXm+W2tBCr9YEhP9Va
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 09/15] hash: set and copy algo field in struct object_id
Date:   Sat, 10 Apr 2021 15:21:34 +0000
Message-Id: <20210410152140.3525040-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf
In-Reply-To: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that struct object_id has an algorithm field, we should populate it.
This will allow us to handle object IDs in any supported algorithm and
distinguish between them.  Ensure that the field is written whenever we
write an object ID by storing it explicitly every time we write an
object.  Set values for the empty blob and tree values as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h        |  4 ++++
 object-file.c | 14 ++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/hash.h b/hash.h
index 04eba5c56b..3b114f053e 100644
--- a/hash.h
+++ b/hash.h
@@ -237,6 +237,7 @@ static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
 static inline void oidcpy(struct object_id *dst, const struct object_id *src)
 {
 	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
+	dst->algo = src->algo;
 }
 
 static inline struct object_id *oiddup(const struct object_id *src)
@@ -254,6 +255,7 @@ static inline void hashclr(unsigned char *hash)
 static inline void oidclr(struct object_id *oid)
 {
 	memset(oid->hash, 0, GIT_MAX_RAWSZ);
+	oid->algo = hash_algo_by_ptr(the_hash_algo);
 }
 
 static inline void oidread(struct object_id *oid, const unsigned char *hash)
@@ -261,6 +263,7 @@ static inline void oidread(struct object_id *oid, const unsigned char *hash)
 	size_t rawsz = the_hash_algo->rawsz;
 	memcpy(oid->hash, hash, rawsz);
 	memset(oid->hash + rawsz, 0, GIT_MAX_RAWSZ - rawsz);
+	oid->algo = hash_algo_by_ptr(the_hash_algo);
 }
 
 static inline int is_empty_blob_sha1(const unsigned char *sha1)
@@ -286,6 +289,7 @@ static inline int is_empty_tree_oid(const struct object_id *oid)
 static inline void oid_pad_buffer(struct object_id *oid, const struct git_hash_algo *algop)
 {
 	memset(oid->hash + algop->rawsz, 0, GIT_MAX_RAWSZ - algop->rawsz);
+	oid->algo = hash_algo_by_ptr(algop);
 }
 
 const char *empty_tree_oid_hex(void);
diff --git a/object-file.c b/object-file.c
index 8e338247cc..5f1fa05c4e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -57,16 +57,20 @@
 
 const struct object_id null_oid;
 static const struct object_id empty_tree_oid = {
-	EMPTY_TREE_SHA1_BIN_LITERAL
+	EMPTY_TREE_SHA1_BIN_LITERAL,
+	GIT_HASH_SHA1,
 };
 static const struct object_id empty_blob_oid = {
-	EMPTY_BLOB_SHA1_BIN_LITERAL
+	EMPTY_BLOB_SHA1_BIN_LITERAL,
+	GIT_HASH_SHA1,
 };
 static const struct object_id empty_tree_oid_sha256 = {
-	EMPTY_TREE_SHA256_BIN_LITERAL
+	EMPTY_TREE_SHA256_BIN_LITERAL,
+	GIT_HASH_SHA256,
 };
 static const struct object_id empty_blob_oid_sha256 = {
-	EMPTY_BLOB_SHA256_BIN_LITERAL
+	EMPTY_BLOB_SHA256_BIN_LITERAL,
+	GIT_HASH_SHA256,
 };
 
 static void git_hash_sha1_init(git_hash_ctx *ctx)
@@ -93,6 +97,7 @@ static void git_hash_sha1_final_oid(struct object_id *oid, git_hash_ctx *ctx)
 {
 	git_SHA1_Final(oid->hash, &ctx->sha1);
 	memset(oid->hash + GIT_SHA1_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA1_RAWSZ);
+	oid->algo = GIT_HASH_SHA1;
 }
 
 
@@ -124,6 +129,7 @@ static void git_hash_sha256_final_oid(struct object_id *oid, git_hash_ctx *ctx)
 	 * but keep it in case we extend the hash size again.
 	 */
 	memset(oid->hash + GIT_SHA256_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA256_RAWSZ);
+	oid->algo = GIT_HASH_SHA256;
 }
 
 static void git_hash_unknown_init(git_hash_ctx *ctx)
