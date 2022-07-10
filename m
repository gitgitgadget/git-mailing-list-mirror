Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59236C43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 13:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiGJNaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 09:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJN37 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 09:29:59 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC1812D38
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 06:29:58 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9E0BB5A1C0;
        Sun, 10 Jul 2022 13:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1657459797;
        bh=HVuB/rGIawcujb57rbHykad32iHhY0gFbjomYJNUD9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=BbSaAagpzayp2UlKcUJfS3F5RNlexT1CjjYA1Vn6W3mSUVnRUu8vDTzJ3jwwre0WD
         1v4ysr/IvlUpwvIUxZr9Spo0CPiPQ1dXWK/CCGlhO8acXgGGkkWkL8iqX0kifI3gLN
         uqbEmUnx2kEgSoPY4KKukm3IOqCPZcDA5KD+GMCjnDQtl488RP75FNVg+7gZxBsROG
         Y875YBRaPnpuiWFnL6zOxQlQ02dYlbio9T+BFdvANP/yev18R+FETKAwRIaHAfelUF
         4eXxFrXw3xDmxZ2yh+DniaNlAVMM31yFRQxqGFBRGxRyvVeYhjH/LLotlaZMsh319e
         p2MLbHbrI+7yLMcQAK7wPw/c0tgU8i9nTqUIeR1F78NDTOle1l2fdgirpq6Xb3N4Rs
         3fYhODXDnOP4+mZWD0JvM5VsH5BppGjHHyx4Z+xjZ62t6nZVYAGPxo/ukm10JwJ7u6
         JDNupa/qqktpniN+DbkObrvi9aIOg9SySGfIXGh45ezlQWCzD39
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2] sha256: add support for Nettle
Date:   Sun, 10 Jul 2022 13:29:07 +0000
Message-Id: <20220710132907.1499365-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.36.1.507.g7c58a9bb42
In-Reply-To: <20220705230518.713218-1-sandals@crustytoothpaste.net>
References: <20220705230518.713218-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For SHA-256, we currently have support for OpenSSL and libgcrypt because
these two libraries contain optimized implementations that can take
advantage of native processor instructions.  However, OpenSSL is not
suitable for linking against for Linux distros due to licensing
incompatibilities with the GPLv2, and libgcrypt has been less favored by
cryptographers due to some security-related implementation issues,
which, while not affecting our use of hash algorithms, has affected its
reputation.

Let's add another option that's compatible with the GPLv2, which is
Nettle.  This is an option which is generally better than libgcrypt
because on many distros GnuTLS (which uses Nettle) is used for HTTPS and
therefore as a practical matter it will be available on most systems.
As a result, prefer it over libgcrypt and our built-in implementation.

Nettle also has recently gained support for Intel's SHA-NI instructions,
which compare very favorably to other implementations, as well as
assembly implementations for when SHA-NI is not available.

A git gc on git.git sees a 12% performance improvement with Nettle over
our block SHA-256 implementation due to general assembly improvements.
With SHA-NI, the performance of raw SHA-256 on a 2 GiB file goes from
7.296 seconds with block SHA-256 to 1.523 seconds with Nettle.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---

Changes from v1:

* Improve commit message to provide better statistics and rationale.
* Fix include guard typo.
* Exclude header in Makefile unless we're building it.

 Makefile        | 10 ++++++++++
 hash.h          |  4 +++-
 sha256/nettle.h | 31 +++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 sha256/nettle.h

diff --git a/Makefile b/Makefile
index 04d0fd1fe6..52a9f97997 100644
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
@@ -3091,6 +3098,9 @@ $(SP_OBJ): %.sp: %.c %.o
 sparse: $(SP_OBJ)
 
 EXCEPT_HDRS := $(GENERATED_H) unicode-width.h compat/% xdiff/%
+ifndef NETTLE_SHA256
+	EXCEPT_HDRS += sha256/nettle.h
+endif
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS += sha256/gcrypt.h
 endif
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
index 0000000000..b63e1c8190
--- /dev/null
+++ b/sha256/nettle.h
@@ -0,0 +1,31 @@
+#ifndef SHA256_NETTLE_H
+#define SHA256_NETTLE_H
+
+#include <nettle/sha2.h>
+
+typedef struct sha256_ctx nettle_SHA256_CTX;
+
+static inline void nettle_SHA256_Init(nettle_SHA256_CTX *ctx)
+{
+	sha256_init(ctx);
+}
+
+static inline void nettle_SHA256_Update(nettle_SHA256_CTX *ctx,
+					const void *data,
+					size_t len)
+{
+	sha256_update(ctx, len, data);
+}
+
+static inline void nettle_SHA256_Final(unsigned char *digest,
+				       nettle_SHA256_CTX *ctx)
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
