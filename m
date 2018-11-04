Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60DF01F453
	for <e@80x24.org>; Sun,  4 Nov 2018 23:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbeKEJCF (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 04:02:05 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53246 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730304AbeKEJCF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Nov 2018 04:02:05 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0927E61B76;
        Sun,  4 Nov 2018 23:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541375119;
        bh=7kaxebxFxEvBZ0ZZePXzaLFy2e/lCIQuxdjHX/F4zqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=fYMcecef7g5gl2NPmQpZ7T664RymyUTWOMMzKQFQjRdm7N5t11kw6mTxeZn0ork1k
         S8fD55xxcSWLkr9Q9izOkglGM7TuhNBFicvWdMyTHip1we0Me4KcfqDyj252kvbI32
         9ebQ8e9ThxbFq5OvxvmKBGkLTGOGuIWqORqwLpoz0JtsGHxV7OiFVDdTAO5PWeIku0
         17+D/+PTQ8ZmgvG/aixfiGk8xnNSjWBxZG6TOW1YVHNP/wuMHvYd97Ua6x0LuQWDNQ
         llks2e+hb75n7+j0ylJfOkgtlo7E76r+AyTOuHqgNlW2c8QbPJQRt9Z4tXkA5l94Bs
         8PctMBo6y3eQHU9ici6+Y7m1zUqqrTr/DuEtm4JWiSC/T96lfcQbS7Uk2TunIERJ21
         h2Uc5eTwZxldhbWWh8nVuElBsZHPacQ9xZsFei0B5BUv99E9D0bmZXoZ7QrI2KehML
         3oo3LV0QpfGXjaPU72sXdRx9m3N5pePHjawJCoxpbi5wJfeN+W3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 11/12] sha256: add an SHA-256 implementation using libgcrypt
Date:   Sun,  4 Nov 2018 23:44:57 +0000
Message-Id: <20181104234458.139223-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0
In-Reply-To: <20181104234458.139223-1-sandals@crustytoothpaste.net>
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-1-sandals@crustytoothpaste.net>
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
implementation for messages of a few KiB and larger.

For comparison, on a Core i7-6600U, this implementation processes 16 KiB
chunks at 355 MiB/s while SHA1DC processes equivalent chunks at 337
MiB/s.

In addition, libgcrypt is licensed under the LGPL 2.1, which is
compatible with the GPL.  Add an implementation of SHA-256 that uses
libgcrypt.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile        | 13 +++++++++++--
 hash.h          |  4 ++++
 sha256/gcrypt.h | 30 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)
 create mode 100644 sha256/gcrypt.h

diff --git a/Makefile b/Makefile
index e99b7712f6..5a07e03100 100644
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
@@ -1634,8 +1638,13 @@ endif
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
index a9bc624020..2ef098052d 100644
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
