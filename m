Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CA6C001DE
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 02:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjHACzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 22:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHACzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 22:55:09 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301561BC3
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 19:55:06 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 64C6C1F548
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 02:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1690858495;
        bh=gcIxX9iKkLS0pcBc45bZ9ejdhXheRjGoMLs2oYvM1IA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LithagKfpjF6tiPDTnvHDasFcS/XQSbTnqnVJukLROtW7zvrrLaWpr0KvrniSGmi6
         FKHHzhaWAH+tkVJ7TbT8HlQ46XaMozMjKTi/yNWqxAFB/DQ9Qu91Phih4Fbj58Ir73
         xXPAsMnfUzBH+lqlssgOprsK/BVbrhMgQSJn/kHk=
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] avoid SHA-1 functions deprecated in OpenSSL 3+
Date:   Tue,  1 Aug 2023 02:54:54 +0000
Message-Id: <20230801025454.1137802-3-e@80x24.org>
In-Reply-To: <20230801025454.1137802-1-e@80x24.org>
References: <20230801025454.1137802-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OpenSSL 3+ deprecates the SHA1_Init, SHA1_Update, and SHA1_Final
functions, leading to errors when building with `DEVELOPER=1'.

Use the newer EVP_* API with OpenSSL 3+ (only) despite being more
error-prone and less efficient due to heap allocations.

Signed-off-by: Eric Wong <e@80x24.org>
---
 Makefile       |  3 +++
 hash-ll.h      | 12 +++++++++++-
 sha1/openssl.h | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 sha1/openssl.h

diff --git a/Makefile b/Makefile
index a499c5d7f2..ace3e5a506 100644
--- a/Makefile
+++ b/Makefile
@@ -3216,6 +3216,9 @@ $(SP_OBJ): %.sp: %.c %.o
 sparse: $(SP_OBJ)
 
 EXCEPT_HDRS := $(GENERATED_H) unicode-width.h compat/% xdiff/%
+ifndef OPENSSL_SHA1
+	EXCEPT_HDRS += sha1/openssl.h
+endif
 ifndef OPENSSL_SHA256
 	EXCEPT_HDRS += sha256/openssl.h
 endif
diff --git a/hash-ll.h b/hash-ll.h
index 087b421bd5..10d84cc208 100644
--- a/hash-ll.h
+++ b/hash-ll.h
@@ -4,7 +4,11 @@
 #if defined(SHA1_APPLE)
 #include <CommonCrypto/CommonDigest.h>
 #elif defined(SHA1_OPENSSL)
-#include <openssl/sha.h>
+#  include <openssl/sha.h>
+#  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >= 3
+#    define SHA1_NEEDS_CLONE_HELPER
+#    include "sha1/openssl.h"
+#  endif
 #elif defined(SHA1_DC)
 #include "sha1dc_git.h"
 #else /* SHA1_BLK */
@@ -45,6 +49,10 @@
 #define git_SHA1_Update		platform_SHA1_Update
 #define git_SHA1_Final		platform_SHA1_Final
 
+#ifdef platform_SHA1_Clone
+#define git_SHA1_Clone	platform_SHA1_Clone
+#endif
+
 #ifndef platform_SHA256_CTX
 #define platform_SHA256_CTX	SHA256_CTX
 #define platform_SHA256_Init	SHA256_Init
@@ -67,10 +75,12 @@
 #define git_SHA1_Update		git_SHA1_Update_Chunked
 #endif
 
+#ifndef SHA1_NEEDS_CLONE_HELPER
 static inline void git_SHA1_Clone(git_SHA_CTX *dst, const git_SHA_CTX *src)
 {
 	memcpy(dst, src, sizeof(*dst));
 }
+#endif
 
 #ifndef SHA256_NEEDS_CLONE_HELPER
 static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *src)
diff --git a/sha1/openssl.h b/sha1/openssl.h
new file mode 100644
index 0000000000..006c1f4ba5
--- /dev/null
+++ b/sha1/openssl.h
@@ -0,0 +1,49 @@
+/* wrappers for the EVP API of OpenSSL 3+ */
+#ifndef SHA1_OPENSSL_H
+#define SHA1_OPENSSL_H
+#include <openssl/evp.h>
+
+struct openssl_SHA1_CTX {
+	EVP_MD_CTX *ectx;
+};
+
+typedef struct openssl_SHA1_CTX openssl_SHA1_CTX;
+
+static inline void openssl_SHA1_Init(struct openssl_SHA1_CTX *ctx)
+{
+	const EVP_MD *type = EVP_sha1();
+
+	ctx->ectx = EVP_MD_CTX_new();
+	if (!ctx->ectx)
+		die("EVP_MD_CTX_new: out of memory");
+
+	EVP_DigestInit_ex(ctx->ectx, type, NULL);
+}
+
+static inline void openssl_SHA1_Update(struct openssl_SHA1_CTX *ctx,
+					const void *data,
+					size_t len)
+{
+	EVP_DigestUpdate(ctx->ectx, data, len);
+}
+
+static inline void openssl_SHA1_Final(unsigned char *digest,
+				       struct openssl_SHA1_CTX *ctx)
+{
+	EVP_DigestFinal_ex(ctx->ectx, digest, NULL);
+	EVP_MD_CTX_free(ctx->ectx);
+}
+
+static inline void openssl_SHA1_Clone(struct openssl_SHA1_CTX *dst,
+					const struct openssl_SHA1_CTX *src)
+{
+	EVP_MD_CTX_copy_ex(dst->ectx, src->ectx);
+}
+
+#define platform_SHA_CTX openssl_SHA1_CTX
+#define platform_SHA1_Init openssl_SHA1_Init
+#define platform_SHA1_Clone openssl_SHA1_Clone
+#define platform_SHA1_Update openssl_SHA1_Update
+#define platform_SHA1_Final openssl_SHA1_Final
+
+#endif /* SHA1_OPENSSL_H */
