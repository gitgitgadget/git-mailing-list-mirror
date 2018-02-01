Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 992B91F404
	for <e@80x24.org>; Thu,  1 Feb 2018 02:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932199AbeBACTD (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 21:19:03 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58544 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932188AbeBACTA (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Jan 2018 21:19:00 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5F72A609D7;
        Thu,  1 Feb 2018 02:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517451539;
        bh=3JdhUwtLSbcjJDxhrW0l7m+8RJAYkSJ7s3eBKGmMsi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=hLEpxBz56poW8FwPlb6h09tlZ2IiKxdqanP91jX64ElpJHzDYnx469upjTME37Nry
         pduqJCrlupfMoCU4CG0kOZhKcsY6kC4XpL3xRsqh0DXk4B+IAiGJc3tCrLUjChVdoV
         1D8jdsbsk9Ys2cHynf99QiKt9PdKp+C5KlKtnN3qEQEHqX4xxI7MyGX4Eo03t+Pczl
         1ugH5PmeB2UKZ6PvoVIuSWKzRpeIrOw20qXjr6mDfYeDFISuUGIlh5TgrcyBzT3Kki
         RSH4PHvVDUoU5aJz8FhZdfGMWgjZX5Ulgb3uJxXTUxk8o/DZ6WzVmYsCm7C/VF4Net
         6jowOKmeoomLXE/T3FzLxQi8Zvhe+mcUQTxPMf4QuDBU+rpEPFNEcbailq4cBT3vDZ
         8Jv+8x49zFM0EiyrPicKPDBLubj5HpapmfLpshTvyycY8CVOkQ5mZ5/rmqYqSx5CXD
         cGqU8Py+3rSB0tNznQUx+Ea3aKeXGNVsFhZbG3j2lCt23mOSB3y
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 01/12] hash: move SHA-1 macros to hash.h
Date:   Thu,  1 Feb 2018 02:18:37 +0000
Message-Id: <20180201021848.533188-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180201021848.533188-1-sandals@crustytoothpaste.net>
References: <20180201021848.533188-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of the other code dealing with SHA-1 and other hashes is located in
hash.h, which is in turn loaded by cache.h.  Move the SHA-1 macros to
hash.h as well, so we can use them in additional hash-related items in
the future.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h | 25 -------------------------
 hash.h  | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/cache.h b/cache.h
index d8b975a571..bfde6f757a 100644
--- a/cache.h
+++ b/cache.h
@@ -16,31 +16,6 @@
 #include "sha1-array.h"
 #include "repository.h"
 
-#ifndef platform_SHA_CTX
-/*
- * platform's underlying implementation of SHA-1; could be OpenSSL,
- * blk_SHA, Apple CommonCrypto, etc...  Note that including
- * SHA1_HEADER may have already defined platform_SHA_CTX for our
- * own implementations like block-sha1 and ppc-sha1, so we list
- * the default for OpenSSL compatible SHA-1 implementations here.
- */
-#define platform_SHA_CTX	SHA_CTX
-#define platform_SHA1_Init	SHA1_Init
-#define platform_SHA1_Update	SHA1_Update
-#define platform_SHA1_Final    	SHA1_Final
-#endif
-
-#define git_SHA_CTX		platform_SHA_CTX
-#define git_SHA1_Init		platform_SHA1_Init
-#define git_SHA1_Update		platform_SHA1_Update
-#define git_SHA1_Final		platform_SHA1_Final
-
-#ifdef SHA1_MAX_BLOCK_SIZE
-#include "compat/sha1-chunked.h"
-#undef git_SHA1_Update
-#define git_SHA1_Update		git_SHA1_Update_Chunked
-#endif
-
 #include <zlib.h>
 typedef struct git_zstream {
 	z_stream z;
diff --git a/hash.h b/hash.h
index 7d7a864f5d..7122dea7b3 100644
--- a/hash.h
+++ b/hash.h
@@ -15,6 +15,31 @@
 #include "block-sha1/sha1.h"
 #endif
 
+#ifndef platform_SHA_CTX
+/*
+ * platform's underlying implementation of SHA-1; could be OpenSSL,
+ * blk_SHA, Apple CommonCrypto, etc...  Note that including
+ * SHA1_HEADER may have already defined platform_SHA_CTX for our
+ * own implementations like block-sha1 and ppc-sha1, so we list
+ * the default for OpenSSL compatible SHA-1 implementations here.
+ */
+#define platform_SHA_CTX	SHA_CTX
+#define platform_SHA1_Init	SHA1_Init
+#define platform_SHA1_Update	SHA1_Update
+#define platform_SHA1_Final    	SHA1_Final
+#endif
+
+#define git_SHA_CTX		platform_SHA_CTX
+#define git_SHA1_Init		platform_SHA1_Init
+#define git_SHA1_Update		platform_SHA1_Update
+#define git_SHA1_Final		platform_SHA1_Final
+
+#ifdef SHA1_MAX_BLOCK_SIZE
+#include "compat/sha1-chunked.h"
+#undef git_SHA1_Update
+#define git_SHA1_Update		git_SHA1_Update_Chunked
+#endif
+
 /*
  * Note that these constants are suitable for indexing the hash_algos array and
  * comparing against each other, but are otherwise arbitrary, so they should not
