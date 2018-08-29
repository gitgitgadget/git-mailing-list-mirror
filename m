Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D74F81F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeH2Exc (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:53:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37330 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727204AbeH2Exc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:53:32 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 390966075B
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 00:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535504355;
        bh=PrIxuhwdINn4hcyaJy0SzZwdpa84+PWX98fDzOW6aa0=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=hzHs/IV7xhbaBmbQhNG9/nOxLZDwLsDEfuRrzVFYF/cKDt74ztFnzkIoEpcQ+M2th
         r1h/0TIOH7MIeJzIewLlt9dpkyeTJ/3i2/lAb2V4qolEQ8uTJ8K0j44ewZSAlnk7VJ
         6eSXWwv41Fo/IbDCtVqP9yULhUojT/radIDqbUiuVR/0PTeXezmbqUO6Bk9fxUdIRY
         tA4WTnxNvHQpoYTmJtlBcwatssd/ygItNyKibesEYqkoZDpoc8FdYrLezWc8VYN290
         DogiyB6Zxb5fVlFQuKg3zGgrLGV1lEJXsnvvdAn9XHL9F9s9IOnPEwUlR09JPy4NR1
         J+nOLCU+wHvvaaS5A0UCDXn9EDjZ1vDUNPNFmcf0kPR8FWOLGBEiDl11XPtU+kFo0w
         Uvzwoggsbsi1Vzf/GM3GR32A6o0pJe8x89OZSrcNHur3rd5Un0fq/d/Em51bhxS+aL
         iutcVNW657kzN50uwMlJcAq0u9lSFJwPG5SipZPivspFz7tlCvb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 11/12] hash: add an SHA-256 implementation using OpenSSL
Date:   Wed, 29 Aug 2018 00:58:56 +0000
Message-Id: <20180829005857.980820-12-sandals@crustytoothpaste.net>
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

We already have OpenSSL routines available for SHA-1, so add routines
for SHA-256 as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile | 7 +++++++
 hash.h   | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index 86867af083..8b7df4dfc5 100644
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
@@ -1628,6 +1630,10 @@ endif
 endif
 endif
 
+ifdef OPENSSL_SHA256
+	EXTLIBS += $(LIB_4_CRYPTO)
+	BASIC_CFLAGS += -DSHA256_OPENSSL
+else
 ifdef GCRYPT_SHA256
 	BASIC_CFLAGS += -DSHA256_GCRYPT
 	EXTLIBS += -lgcrypt
@@ -1635,6 +1641,7 @@ else
 	LIB_OBJS += sha256/block/sha256.o
 	BASIC_CFLAGS += -DSHA256_BLK
 endif
+endif
 
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
diff --git a/hash.h b/hash.h
index 9df562f2f6..9df06d56b4 100644
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
