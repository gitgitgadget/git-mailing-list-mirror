Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,SUBJECT_DRUG_GAP_L,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F71C2D0D5
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 06:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBAB206CB
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 06:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="C+GS7CUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfLVGsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 01:48:33 -0500
Received: from mr85p00im-hyfv06011401.me.com ([17.58.23.191]:36629 "EHLO
        mr85p00im-hyfv06011401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbfLVGsd (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Dec 2019 01:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
        t=1576997311; bh=YCZIOHzWWKAFzgYyaPks0miGiP8uqmAWhTCD4auSchE=;
        h=From:To:Subject:Date:Message-Id;
        b=C+GS7CUpmcGHHSmYK/ZeUY9ViJiDnFQ9QKrWcXIe+mFD3wm0XLVeXwqXpASz8Rf3v
         lqNXl8VKJX44baLAcIWhML3sprWJZGsZgYLkM4Q9+IPkTDKN3ctfbyVNOuP8TLbWe4
         bwMgLB2ihfVm8JtNxBeoQbsPNWvjdhs16NJmG+IbVO85w3CjxWAe5yZDGTa/KbS/0z
         bluISWjksIUsfmK2Sg1PZVrlEJagBFBKsxS31yzyWu/4iFs5qU37+G45omh9Oa7ZmT
         z3K5iCoFXa8q/dl1TM9JzWJbb16v7DN3QOwCwCcuLyVwslwIYYz13inpJNtLZE8K7d
         URwni+V5HaXvw==
Received: from localhost.localdomain (125-237-36-9-fibre.sparkbb.co.nz [125.237.36.9])
        by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id 39CD9D20A38;
        Sun, 22 Dec 2019 06:48:31 +0000 (UTC)
From:   Michael Clark <michaeljclark@mac.com>
To:     git@vger.kernel.org
Cc:     Michael Clark <michaeljclark@mac.com>
Subject: [PATCH 5/6] Add OpenSSL EVP interface for SHA-3 and SHA-512 algorithms
Date:   Sun, 22 Dec 2019 19:48:08 +1300
Message-Id: <20191222064809.35667-6-michaeljclark@mac.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191222064809.35667-1-michaeljclark@mac.com>
References: <20191222064809.35667-1-michaeljclark@mac.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=539 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912220061
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

- Add OpenSSL EVP context wrapper and interface.
- Add configuration machinery to select SHA-3 and SHA-512 impls
  from OpenSSL using the EVP interface.
- Use `make OPENSSL_EVP=1` to build using the OpenSSL EVP impls
  for all SHA-3 and SHA-512 algos.
---
 Makefile              |  9 +++-
 hash.h                |  6 +++
 sha/sha_evp/sha_evp.c | 99 +++++++++++++++++++++++++++++++++++++++++++
 sha/sha_evp/sha_evp.h | 51 ++++++++++++++++++++++
 4 files changed, 164 insertions(+), 1 deletion(-)
 create mode 100644 sha/sha_evp/sha_evp.c
 create mode 100644 sha/sha_evp/sha_evp.h

diff --git a/Makefile b/Makefile
index 6bf9900291cb..e065630e24fa 100644
--- a/Makefile
+++ b/Makefile
@@ -189,6 +189,8 @@ all::
 #
 # Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
 #
+# Define OPENSSL_EVP to use the SHA-3 and SHA-512 routines in OpenSSL.
+#
 # Define NEEDS_CRYPTO_WITH_SSL if you need -lcrypto when using -lssl (Darwin).
 #
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
@@ -1716,6 +1718,11 @@ else
 endif
 endif
 
+ifdef OPENSSL_EVP
+	EXTLIBS += $(LIB_4_CRYPTO)
+	BASIC_CFLAGS += -DSHA_EVP_OPENSSL
+	LIB_OBJS += sha/sha_evp/sha_evp.o
+else
 ifdef GCRYPT_SHA512
 	BASIC_CFLAGS += -DSHA512_GCRYPT
 	EXTLIBS += -lgcrypt
@@ -1723,7 +1730,6 @@ else
 	LIB_OBJS += sha/sha512/sha512.o
 	BASIC_CFLAGS += -DSHA512_BLK
 endif
-
 ifdef GCRYPT_SHA3
 	BASIC_CFLAGS += -DSHA3_GCRYPT
 	EXTLIBS += -lgcrypt
@@ -1731,6 +1737,7 @@ else
 	LIB_OBJS += sha/sha3/sha3.o
 	BASIC_CFLAGS += -DSHA3_BLK
 endif
+endif
 
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
diff --git a/hash.h b/hash.h
index 16924203d035..38e691fe8961 100644
--- a/hash.h
+++ b/hash.h
@@ -25,12 +25,18 @@
 
 #if defined(SHA512_GCRYPT)
 #include "sha/sha512/gcrypt.h"
+#elif defined(SHA_EVP_OPENSSL)
+#include <openssl/evp.h>
+#include "sha/sha_evp/sha_evp.h"
 #else
 #include "sha/sha512/sha512.h"
 #endif
 
 #if defined(SHA3_GCRYPT)
 #include "sha/sha3/gcrypt.h"
+#elif defined(SHA_EVP_OPENSSL)
+#include <openssl/evp.h>
+#include "sha/sha_evp/sha_evp.h"
 #else
 #include "sha/sha3/sha3.h"
 #endif
diff --git a/sha/sha_evp/sha_evp.c b/sha/sha_evp/sha_evp.c
new file mode 100644
index 000000000000..6871f9744a71
--- /dev/null
+++ b/sha/sha_evp/sha_evp.c
@@ -0,0 +1,99 @@
+#include "git-compat-util.h"
+#include "sha_evp.h"
+
+void evp_SHA2_224_Init(SHA_EVP_CTX *ctx)
+{
+	ctx->digest_ctx = NULL;
+	ctx->digest_md = EVP_sha224();
+}
+
+void evp_SHA2_256_Init(SHA_EVP_CTX *ctx)
+{
+	ctx->digest_ctx = NULL;
+	ctx->digest_md = EVP_sha256();
+}
+
+void evp_SHA2_512_Init(SHA_EVP_CTX *ctx)
+{
+	ctx->digest_ctx = NULL;
+	ctx->digest_md = EVP_sha512();
+}
+
+void evp_SHA2_512_224_Init(SHA_EVP_CTX *ctx)
+{
+	ctx->digest_ctx = NULL;
+	ctx->digest_md = EVP_sha512_224();
+}
+
+void evp_SHA2_512_256_Init(SHA_EVP_CTX *ctx)
+{
+	ctx->digest_ctx = NULL;
+	ctx->digest_md = EVP_sha512_256();
+}
+
+void evp_SHA3_224_Init(SHA_EVP_CTX *ctx)
+{
+	ctx->digest_ctx = NULL;
+	ctx->digest_md = EVP_sha3_224();
+}
+
+void evp_SHA3_256_Init(SHA_EVP_CTX *ctx)
+{
+	ctx->digest_ctx = NULL;
+	ctx->digest_md = EVP_sha3_256();
+}
+
+void evp_SHA3_384_Init(SHA_EVP_CTX *ctx)
+{
+	ctx->digest_ctx = NULL;
+	ctx->digest_md = EVP_sha3_384();
+}
+
+void evp_SHA3_512_Init(SHA_EVP_CTX *ctx)
+{
+	ctx->digest_ctx = NULL;
+	ctx->digest_md = EVP_sha3_512();
+}
+
+static void evp_SHA_Lazy_Init(SHA_EVP_CTX *ctx)
+{
+	/*
+	 * The OpenSSL EVP digest API requires a dynamically sized context to be
+	 * allocated and destroyed, however, the digest API we are emulating uses
+	 * static structures and thus has no allocation or deallocation API.
+	 *
+	 * Due to this, we must call EVP_MD_CTX_destroy in Final to free up
+	 * dynamically allocated memory. Context creation is thus done lazily in
+	 * either Update or Final to handle cases where the context is reused
+	 * after Final has been called.
+ 	 */
+	if (ctx->digest_ctx) return;
+	if ((ctx->digest_ctx = EVP_MD_CTX_create()) == NULL)
+		abort();
+	if (EVP_DigestInit_ex(ctx->digest_ctx, ctx->digest_md, NULL) != 1)
+		abort();
+}
+
+void evp_SHA_Update(SHA_EVP_CTX *ctx, const void *data, size_t len)
+{
+	/* handle late Init as well as being called again after Final */
+	evp_SHA_Lazy_Init(ctx);
+
+	if (EVP_DigestUpdate(ctx->digest_ctx, data, len) != 1)
+		abort();
+}
+
+void evp_SHA_Final(unsigned char *result, SHA_EVP_CTX *ctx)
+{
+	unsigned int len;
+
+	/* handle case where Final is called without Update (empty hash) */
+	evp_SHA_Lazy_Init(ctx);
+
+	if (EVP_DigestFinal_ex(ctx->digest_ctx, result, &len) != 1)
+		abort();
+	assert(EVP_MD_size(ctx->digest_md) == len);
+
+	EVP_MD_CTX_destroy(ctx->digest_ctx);
+	ctx->digest_ctx = NULL;
+}
diff --git a/sha/sha_evp/sha_evp.h b/sha/sha_evp/sha_evp.h
new file mode 100644
index 000000000000..8757f77f4c13
--- /dev/null
+++ b/sha/sha_evp/sha_evp.h
@@ -0,0 +1,51 @@
+#ifndef SHAEVP_BLOCK_H
+#define SHAEVP_BLOCK_H
+
+#include <openssl/evp.h>
+
+#define evp_SHA2_256_hash_size      32
+#define evp_SHA2_512_224_hash_size  28
+#define evp_SHA2_512_256_hash_size  32
+#define evp_SHA2_512_hash_size      64
+#define evp_SHA3_224_hash_size      28
+#define evp_SHA3_256_hash_size      32
+#define evp_SHA3_384_hash_size      48
+#define evp_SHA3_512_hash_size      64
+
+struct SHA_EVP_CTX {
+	EVP_MD_CTX *digest_ctx;
+	const EVP_MD* digest_md;
+};
+
+typedef struct SHA_EVP_CTX SHA_EVP_CTX;
+
+void evp_SHA2_224_Init(SHA_EVP_CTX *ctx);
+void evp_SHA2_256_Init(SHA_EVP_CTX *ctx);
+void evp_SHA2_512_Init(SHA_EVP_CTX *ctx);
+void evp_SHA2_512_224_Init(SHA_EVP_CTX *ctx);
+void evp_SHA2_512_256_Init(SHA_EVP_CTX *ctx);
+void evp_SHA3_224_Init(SHA_EVP_CTX *ctx);
+void evp_SHA3_256_Init(SHA_EVP_CTX *ctx);
+void evp_SHA3_384_Init(SHA_EVP_CTX *ctx);
+void evp_SHA3_512_Init(SHA_EVP_CTX *ctx);
+
+void evp_SHA_Update(SHA_EVP_CTX *ctx, const void *data, size_t len);
+void evp_SHA_Final(unsigned char *result, SHA_EVP_CTX *ctx);
+
+#define platform_SHA512_CTX SHA_EVP_CTX
+#define platform_SHA512_Init evp_SHA2_512_Init
+#define platform_SHA512_224_Init evp_SHA2_512_224_Init
+#define platform_SHA512_256_Init evp_SHA2_512_256_Init
+#define platform_SHA512_Update evp_SHA_Update
+#define platform_SHA512_Final evp_SHA_Final
+
+#define platform_SHA3_CTX SHA_EVP_CTX
+#define platform_SHA3_Init evp_SHA3_256_Init
+#define platform_SHA3_224_Init evp_SHA3_224_Init
+#define platform_SHA3_256_Init evp_SHA3_256_Init
+#define platform_SHA3_384_Init evp_SHA3_384_Init
+#define platform_SHA3_512_Init evp_SHA3_512_Init
+#define platform_SHA3_Update evp_SHA_Update
+#define platform_SHA3_Final evp_SHA_Final
+
+#endif
\ No newline at end of file
-- 
2.20.1

