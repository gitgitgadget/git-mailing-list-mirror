Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00AB21F404
	for <e@80x24.org>; Sun, 28 Jan 2018 15:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeA1P5g (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 10:57:36 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58374 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751843AbeA1P5d (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 10:57:33 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5D474609D7;
        Sun, 28 Jan 2018 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517155052;
        bh=3JdhUwtLSbcjJDxhrW0l7m+8RJAYkSJ7s3eBKGmMsi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qrrI7e8v0246PLzOsCKGNa6j8nchSwwzw6B1IxpsljYjAc1qniGO3A4uK3W/Pi0pR
         x3kHX50tp9iTSiwpepmUxQ5Me0EqnozK73DZyWxvrn1A4dpRB4C8E3MZ9RpqaeJo7Y
         iD1GErHwm3hjGhBaYY/AfrK2JTENDkjCruc0SULM4PdBWa4AVO8/mrawqbhJ05qLAe
         /XWEV9CNLayqdR/pZAhtUcqZLneFiOfUbCRBr1S+V6RQiN+okZDslCQ8M+cxoz9HbQ
         4WfC++EbXWokcC34rX1Zlx8FIG9z4HP1k/FsC575H2SPmHdUcVZ4ozBVA3kDeyY2PX
         YTskKRd4yMn6wG/uDJH3tYYmh3HsBNRJOMwlCwFMS7t9TBTLKRAb4HY33c3VGIDyl0
         19UB45HAaVIct/Q7UIS7t7X7WDaOQhP9LbmDMtFC3wrmi2JSU6UeoKf3ZwFKL+Y1tZ
         QLJ8ecuAuOEB2h7ju2wClDGOXxuEj6wSq8htz+RaAL8jSOPNDrO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 01/12] hash: move SHA-1 macros to hash.h
Date:   Sun, 28 Jan 2018 15:57:11 +0000
Message-Id: <20180128155722.880805-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180128155722.880805-1-sandals@crustytoothpaste.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net>
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
