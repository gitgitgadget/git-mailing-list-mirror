Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60B691F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 04:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbeKNOL4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 09:11:56 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54436 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730939AbeKNOLy (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 09:11:54 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2B90C60FE5;
        Wed, 14 Nov 2018 04:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1542168627;
        bh=7MSFl+kk8449M2Bqkup3NUBlYeEBvK/jBScZ71VNoB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=wtWRiL0tVvh7ri1u1AbWJwk1ovxxAQzu7un6FDL6Dl/PtrXV0ZjAC4x7tT5XKZrIe
         8S7T5FJtIk1Mjfp3PErfBDbAO0RuQgYuKYVtbpBxHxTpjCcuZtW7xFVUys24dCYiuP
         p8FMA93/dheS/D8bUULphXtr4Qrej+QzcIG1TJHXdD790H6sqOGpw+2gSOG75i45A9
         VxGYjLrkN9p39FftiVkaJr2esb28+uFHaEY4ixlaJC6Ut1tHn+NwKzyDfb9g3TlXmt
         o9DFNCPsK6PdIcylqK401GD9WKH02WbxPkKKcnAPkgVmc3uURDc+Bmx/LbF4L/wgdB
         Y0X6RwkIjfMdD9jt4z44rKs6SHnMDl/8TBTatfj7Hh3Rfyx8/a0YdZCEfE+dJOAYyw
         02d8dwVurVQMOHMt+GP7aS7J+AoSUmYsty4DEO1G0YgFm1ODbGdJSoaWba9v6ytkVw
         Ja2r39dvBQ6imUwLphvLDyE7gFJn3b/846OO+2sDtuye2WNmIdj
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 12/12] hash: add an SHA-256 implementation using OpenSSL
Date:   Wed, 14 Nov 2018 04:09:38 +0000
Message-Id: <20181114040938.517289-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245
In-Reply-To: <20181114040938.517289-1-sandals@crustytoothpaste.net>
References: <20181104234458.139223-1-sandals@crustytoothpaste.net>
 <20181114040938.517289-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have OpenSSL routines available for SHA-1, so add routines
for SHA-256 as well.

On a Core i7-6600U, this SHA-256 implementation compares favorably to
the SHA1DC SHA-1 implementation:

SHA-1: 157 MiB/s (64 byte chunks); 337 MiB/s (16 KiB chunks)
SHA-256: 165 MiB/s (64 byte chunks); 408 MiB/s (16 KiB chunks)

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile | 7 +++++++
 hash.h   | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index 6c99844aa8..6844deb92d 100644
--- a/Makefile
+++ b/Makefile
@@ -183,6 +183,8 @@ all::
 #
 # Define GCRYPT_SHA256 to use the SHA-256 routines in libgcrypt.
 #
+# Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
+#
 # Define NEEDS_CRYPTO_WITH_SSL if you need -lcrypto when using -lssl (Darwin).
 #
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
@@ -1651,6 +1653,10 @@ endif
 endif
 endif
 
+ifdef OPENSSL_SHA256
+	EXTLIBS += $(LIB_4_CRYPTO)
+	BASIC_CFLAGS += -DSHA256_OPENSSL
+else
 ifdef GCRYPT_SHA256
 	BASIC_CFLAGS += -DSHA256_GCRYPT
 	EXTLIBS += -lgcrypt
@@ -1658,6 +1664,7 @@ else
 	LIB_OBJS += sha256/block/sha256.o
 	BASIC_CFLAGS += -DSHA256_BLK
 endif
+endif
 
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
diff --git a/hash.h b/hash.h
index 2ef098052d..adde708cf2 100644
--- a/hash.h
+++ b/hash.h
@@ -17,6 +17,8 @@
 
 #if defined(SHA256_GCRYPT)
 #include "sha256/gcrypt.h"
+#elif defined(SHA256_OPENSSL)
+#include <openssl/sha.h>
 #else
 #include "sha256/block/sha256.h"
 #endif
