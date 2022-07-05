Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B86C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 23:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiGEXFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 19:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGEXFX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 19:05:23 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05261BEA3
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 16:05:21 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id BD6DA5A1AB;
        Tue,  5 Jul 2022 23:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1657062320;
        bh=A4JGihGyL7ELuMmDcsZ/4L8JKGfM5Wfjc3jJ4H0ROmM=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0ZZZYjHPWy/xOSFcT2W8Wx8XCjZH4ecKgRMVqjKfpOgVcnrHT5NryC4BJ74Y/ps2v
         iRE0RK9tdtwpTmRMrcqFIgtqSFPw0CCA2lbUdnPXNCRVjEu9UoFEIf96s4902NnD6W
         z7G7kCnx1LJtyYRpn+Y8E4vAB1p6D1iCGwPVvBwBHbJO8Jap1AxeGPAN77Jr8FGbwk
         HnjwK6+35DaDWMERz0qtQlx+2ApxkxLANmyBRr4DTvP49uSGK9t9g5TtoYTUKSEtQG
         RRL+kSEioV80pxgPV80inGwNFjtlmjPauwoBed+CXAsXTk4zZ8mHQWrFu0XUXJ0c11
         ltahoWgFeBAOYZRt2jXe2vqDt8wKBC8B+SGOVY+WLpij7Kd0eZdeFLh8RPZQlDBKtR
         HodE7cB0EOwSejciAEJ70/oJsVKzFIS42lwplQsD6+PHBeAowEVfp3YQdDw+iD3HKI
         GQ+4ALCtNmmm7B3bGyJkiwx5iuqFDpaACURRna2AtGsEYRpvrvK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] sha256: add support for Nettle
Date:   Tue,  5 Jul 2022 23:05:18 +0000
Message-Id: <20220705230518.713218-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.36.1.507.g7c58a9bb42
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For SHA-256, we currently have support for OpenSSL and libgcrypt because
these two libraries contain optimized implementations that can take
advantage of native processor instructions.  However, OpenSSL is not
suitable for linking against for Linux distros due to licensing
incompatibilities with the GPLv2, and libgcrypt has been less favored
by cryptographers due to some security-related implementation issues.

Let's add another option that's compatible with the GPLv2, which is
Nettle.  It also has recently gained support for Intel's SHA-NI
instructions, which compare very favorably to other implementations.
For example, using this implementation and SHA-1 DC on a machine with
SHA-NI, hashing a 2 GiB file with SHA-1 takes 7.582 seconds, while
hashing the same file with SHA-256 takes 2.278 seconds.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile        |  7 +++++++
 hash.h          |  4 +++-
 sha256/nettle.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 sha256/nettle.h

diff --git a/Makefile b/Makefile
index 04d0fd1fe6..ce99aecc31 100644
--- a/Makefile
+++ b/Makefile
@@ -182,6 +182,8 @@ include shared.mak
 #
 # Define BLK_SHA256 to use the built-in SHA-256 routines.
 #
+# Define NETTLE_SHA256 to use the SHA-256 routines in libnettle.
+#
 # Define GCRYPT_SHA256 to use the SHA-256 routines in libgcrypt.
 #
 # Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
@@ -1842,6 +1844,10 @@ ifdef OPENSSL_SHA256
 	EXTLIBS += $(LIB_4_CRYPTO)
 	BASIC_CFLAGS += -DSHA256_OPENSSL
 else
+ifdef NETTLE_SHA256
+	BASIC_CFLAGS += -DSHA256_NETTLE
+	EXTLIBS += -lnettle
+else
 ifdef GCRYPT_SHA256
 	BASIC_CFLAGS += -DSHA256_GCRYPT
 	EXTLIBS += -lgcrypt
@@ -1850,6 +1856,7 @@ else
 	BASIC_CFLAGS += -DSHA256_BLK
 endif
 endif
+endif
 
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
diff --git a/hash.h b/hash.h
index 5d40368f18..ea87ae9d92 100644
--- a/hash.h
+++ b/hash.h
@@ -16,7 +16,9 @@
 #include "block-sha1/sha1.h"
 #endif
 
-#if defined(SHA256_GCRYPT)
+#if defined(SHA256_NETTLE)
+#include "sha256/nettle.h"
+#elif defined(SHA256_GCRYPT)
 #define SHA256_NEEDS_CLONE_HELPER
 #include "sha256/gcrypt.h"
 #elif defined(SHA256_OPENSSL)
diff --git a/sha256/nettle.h b/sha256/nettle.h
new file mode 100644
index 0000000000..9b2845babc
--- /dev/null
+++ b/sha256/nettle.h
@@ -0,0 +1,28 @@
+#ifndef SHA256_GCRYPT_H
+#define SHA256_GCRYPT_H
+
+#include <nettle/sha2.h>
+
+typedef struct sha256_ctx nettle_SHA256_CTX;
+
+inline void nettle_SHA256_Init(nettle_SHA256_CTX *ctx)
+{
+	sha256_init(ctx);
+}
+
+inline void nettle_SHA256_Update(nettle_SHA256_CTX *ctx, const void *data, size_t len)
+{
+	sha256_update(ctx, len, data);
+}
+
+inline void nettle_SHA256_Final(unsigned char *digest, nettle_SHA256_CTX *ctx)
+{
+	sha256_digest(ctx, SHA256_DIGEST_SIZE, digest);
+}
+
+#define platform_SHA256_CTX nettle_SHA256_CTX
+#define platform_SHA256_Init nettle_SHA256_Init
+#define platform_SHA256_Update nettle_SHA256_Update
+#define platform_SHA256_Final nettle_SHA256_Final
+
+#endif
