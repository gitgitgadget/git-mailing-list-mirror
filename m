Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F3DC001DE
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 02:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjHACzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 22:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjHACzB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 22:55:01 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300BD1981
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 19:55:00 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3B4A61F547
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 02:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1690858495;
        bh=h5Gpk7YVyRtUCx+YmnOMTz/FZGh7z4yRr/glfa9nnKc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=072UmKQC3MN9g7LYIAYtK+OIa95FO9epz+58q5ky7ZnaDyt3ZvBsDO5U96rbnn66N
         7jOvE/5T7WxfwTKdBogoSAEtgnRUWhXnzjht8rRGjjt8VvOQJidlbkpv/E39jMeXqS
         /Kq/QXB47r1CLGYA+0NfaxbHUw6dG+b+DVyylE1I=
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] sha256: avoid functions deprecated in OpenSSL 3+
Date:   Tue,  1 Aug 2023 02:54:53 +0000
Message-Id: <20230801025454.1137802-2-e@80x24.org>
In-Reply-To: <20230801025454.1137802-1-e@80x24.org>
References: <20230801025454.1137802-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OpenSSL 3+ deprecates the SHA256_Init, SHA256_Update, and SHA256_Final
functions, leading to errors when building with `DEVELOPER=1'.

Use the newer EVP_* API with OpenSSL 3+ despite being more
error-prone and less efficient due to heap allocations.

Signed-off-by: Eric Wong <e@80x24.org>
---
 Makefile         |  3 +++
 hash-ll.h        |  6 +++++-
 sha256/openssl.h | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 sha256/openssl.h

diff --git a/Makefile b/Makefile
index fb541dedc9..a499c5d7f2 100644
--- a/Makefile
+++ b/Makefile
@@ -3216,6 +3216,9 @@ $(SP_OBJ): %.sp: %.c %.o
 sparse: $(SP_OBJ)
 
 EXCEPT_HDRS := $(GENERATED_H) unicode-width.h compat/% xdiff/%
+ifndef OPENSSL_SHA256
+	EXCEPT_HDRS += sha256/openssl.h
+endif
 ifndef NETTLE_SHA256
 	EXCEPT_HDRS += sha256/nettle.h
 endif
diff --git a/hash-ll.h b/hash-ll.h
index 8d7973769f..087b421bd5 100644
--- a/hash-ll.h
+++ b/hash-ll.h
@@ -17,7 +17,11 @@
 #define SHA256_NEEDS_CLONE_HELPER
 #include "sha256/gcrypt.h"
 #elif defined(SHA256_OPENSSL)
-#include <openssl/sha.h>
+#  include <openssl/sha.h>
+#  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >= 3
+#    define SHA256_NEEDS_CLONE_HELPER
+#    include "sha256/openssl.h"
+#  endif
 #else
 #include "sha256/block/sha256.h"
 #endif
diff --git a/sha256/openssl.h b/sha256/openssl.h
new file mode 100644
index 0000000000..c1083d9491
--- /dev/null
+++ b/sha256/openssl.h
@@ -0,0 +1,49 @@
+/* wrappers for the EVP API of OpenSSL 3+ */
+#ifndef SHA256_OPENSSL_H
+#define SHA256_OPENSSL_H
+#include <openssl/evp.h>
+
+struct openssl_SHA256_CTX {
+	EVP_MD_CTX *ectx;
+};
+
+typedef struct openssl_SHA256_CTX openssl_SHA256_CTX;
+
+static inline void openssl_SHA256_Init(struct openssl_SHA256_CTX *ctx)
+{
+	const EVP_MD *type = EVP_sha256();
+
+	ctx->ectx = EVP_MD_CTX_new();
+	if (!ctx->ectx)
+		die("EVP_MD_CTX_new: out of memory");
+
+	EVP_DigestInit_ex(ctx->ectx, type, NULL);
+}
+
+static inline void openssl_SHA256_Update(struct openssl_SHA256_CTX *ctx,
+					const void *data,
+					size_t len)
+{
+	EVP_DigestUpdate(ctx->ectx, data, len);
+}
+
+static inline void openssl_SHA256_Final(unsigned char *digest,
+				       struct openssl_SHA256_CTX *ctx)
+{
+	EVP_DigestFinal_ex(ctx->ectx, digest, NULL);
+	EVP_MD_CTX_free(ctx->ectx);
+}
+
+static inline void openssl_SHA256_Clone(struct openssl_SHA256_CTX *dst,
+					const struct openssl_SHA256_CTX *src)
+{
+	EVP_MD_CTX_copy_ex(dst->ectx, src->ectx);
+}
+
+#define platform_SHA256_CTX openssl_SHA256_CTX
+#define platform_SHA256_Init openssl_SHA256_Init
+#define platform_SHA256_Clone openssl_SHA256_Clone
+#define platform_SHA256_Update openssl_SHA256_Update
+#define platform_SHA256_Final openssl_SHA256_Final
+
+#endif /* SHA256_OPENSSL_H */
