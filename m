Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 306BC1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeH2Exb (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:53:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37330 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727393AbeH2Exb (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:53:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 316FB6081A
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 00:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535504354;
        bh=yHcTc6r+L33h0Tik0N0nnqJHsky2lbIY3HKzO+7zGeo=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=CHSDq20/JLsZIuxFW56rT+p8RXqpVELvT6LAVWDZ+RmAnVFkwdv9ZHZWptP6bi72z
         lk15jePDuwe2zmx1MPKfYhDUw3GAObFEpR6kyw+ye13ERpbfw49XeuXBLxTZ/qlNRw
         l/85qwe0Z3FvbG/Ly6JuhKI3x0tb/uv5EoxiNBfRZITMC/5OIjs5v9xXrYMxiU9Kpr
         y312hsxNhjmHkHgG3AJGLRf+vBsU45bLpWMi3SowNqlzZdWlIclPfMyaoIbKYPr7Hx
         fJU1N5jL0PX7Zt+mNWrnobHoIx18r4oY1ltb0bJarg4HgMSwSA3QckfEcISOCpHsmX
         QSD6/tmNXsHL5fgDVxkJ55fCLc0UOFHkPtovSGttRJ0TNeh7qWuXN0XeJuQbtI516R
         fmnIUSpL41zUbEFvOPVSdguJGPoUyR58/+RzelcbU4ZuLTOW9tcvkFnvv6IdsBgsAb
         XtOfppRZYtTm+QqPSj6RAJUUg0nWqCLkWr3VTduIQWN7/TpfxG8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 10/12] sha256: add an SHA-256 implementation using libgcrypt
Date:   Wed, 29 Aug 2018 00:58:55 +0000
Message-Id: <20180829005857.980820-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180829005857.980820-1-sandals@crustytoothpaste.net>
References: <20180829005857.980820-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Generally, one gets better performance out of cryptographic routines
written in assembly than C, and this is also true for SHA-256.  In
addition, most Linux distributions cannot distribute Git linked against
OpenSSL for licensing reasons.

Most systems with GnuPG will also have libgcrypt, since it is a
dependency of GnuPG.  libgcrypt is also faster than the SHA1DC
implementation for messages of a few KiB and larger. It is licensed
under the LGPL 2.1, which is compatible with the GPL.

Add an implementation of SHA-256 that uses libgcrypt.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile        | 13 +++++++++++--
 hash.h          |  4 ++++
 sha256/gcrypt.h | 30 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)
 create mode 100644 sha256/gcrypt.h

diff --git a/Makefile b/Makefile
index 624d852e79..86867af083 100644
--- a/Makefile
+++ b/Makefile
@@ -179,6 +179,10 @@ all::
 # in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
 # wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
 #
+# Define BLK_SHA256 to use the built-in SHA-256 routines.
+#
+# Define GCRYPT_SHA256 to use the SHA-256 routines in libgcrypt.
+#
 # Define NEEDS_CRYPTO_WITH_SSL if you need -lcrypto when using -lssl (Darwin).
 #
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
@@ -1624,8 +1628,13 @@ endif
 endif
 endif
 
-LIB_OBJS += sha256/block/sha256.o
-BASIC_CFLAGS += -DSHA256_BLK
+ifdef GCRYPT_SHA256
+	BASIC_CFLAGS += -DSHA256_GCRYPT
+	EXTLIBS += -lgcrypt
+else
+	LIB_OBJS += sha256/block/sha256.o
+	BASIC_CFLAGS += -DSHA256_BLK
+endif
 
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
diff --git a/hash.h b/hash.h
index 88d18896d7..9df562f2f6 100644
--- a/hash.h
+++ b/hash.h
@@ -15,7 +15,11 @@
 #include "block-sha1/sha1.h"
 #endif
 
+#if defined(SHA256_GCRYPT)
+#include "sha256/gcrypt.h"
+#else
 #include "sha256/block/sha256.h"
+#endif
 
 #ifndef platform_SHA_CTX
 /*
diff --git a/sha256/gcrypt.h b/sha256/gcrypt.h
new file mode 100644
index 0000000000..09bd8bb200
--- /dev/null
+++ b/sha256/gcrypt.h
@@ -0,0 +1,30 @@
+#ifndef SHA256_GCRYPT_H
+#define SHA256_GCRYPT_H
+
+#include <gcrypt.h>
+
+#define SHA256_DIGEST_SIZE 32
+
+typedef gcry_md_hd_t gcrypt_SHA256_CTX;
+
+inline void gcrypt_SHA256_Init(gcrypt_SHA256_CTX *ctx)
+{
+	gcry_md_open(ctx, GCRY_MD_SHA256, 0);
+}
+
+inline void gcrypt_SHA256_Update(gcrypt_SHA256_CTX *ctx, const void *data, size_t len)
+{
+	gcry_md_write(*ctx, data, len);
+}
+
+inline void gcrypt_SHA256_Final(unsigned char *digest, gcrypt_SHA256_CTX *ctx)
+{
+	memcpy(digest, gcry_md_read(*ctx, GCRY_MD_SHA256), SHA256_DIGEST_SIZE);
+}
+
+#define platform_SHA256_CTX gcrypt_SHA256_CTX
+#define platform_SHA256_Init gcrypt_SHA256_Init
+#define platform_SHA256_Update gcrypt_SHA256_Update
+#define platform_SHA256_Final gcrypt_SHA256_Final
+
+#endif
