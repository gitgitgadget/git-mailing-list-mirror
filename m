Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D272208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 12:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbdHOMEd (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 08:04:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:51106 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751494AbdHOME1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 08:04:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C692CAEAC;
        Tue, 15 Aug 2017 12:04:25 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Andreas Stieger <astieger@suse.com>
Subject: [PATCH v2 1/2] sha1dc: Build git plumbing code more explicitly
Date:   Tue, 15 Aug 2017 14:04:16 +0200
Message-Id: <20170815120417.31616-2-tiwai@suse.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170815120417.31616-1-tiwai@suse.de>
References: <20170815120417.31616-1-tiwai@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The plumbing code between sha1dc and git is defined in
sha1dc_git.[ch], but these aren't compiled / included directly but
only via the indirect inclusion from sha1dc code.  This is slightly
confusing when you try to trace the build flow.

This patch brings the following changes for simplification:
- Make sha1dc_git.c stand-alone and build from Makefile
- sha1dc_git.h is the common header to include further sha1.h
  depending on the build condition
- Move comments for plumbing codes from the header to definitions

This is also meant as a preliminary work for further plumbing with
external sha1dc shlib.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Makefile     |  5 ++---
 hash.h       |  6 +-----
 sha1dc_git.c |  9 ++++++---
 sha1dc_git.h | 18 +++++++-----------
 4 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index 461c845d33cb..5e7e9022bdd8 100644
--- a/Makefile
+++ b/Makefile
@@ -1472,6 +1472,8 @@ ifdef APPLE_COMMON_CRYPTO
 	BASIC_CFLAGS += -DSHA1_APPLE
 else
 	DC_SHA1 := YesPlease
+	BASIC_CFLAGS += -DSHA1_DC
+	LIB_OBJS += sha1dc_git.o
 ifdef DC_SHA1_SUBMODULE
 	LIB_OBJS += sha1collisiondetection/lib/sha1.o
 	LIB_OBJS += sha1collisiondetection/lib/ubc_check.o
@@ -1481,12 +1483,9 @@ else
 	LIB_OBJS += sha1dc/ubc_check.o
 endif
 	BASIC_CFLAGS += \
-		-DSHA1_DC \
 		-DSHA1DC_NO_STANDARD_INCLUDES \
 		-DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 \
 		-DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" \
-		-DSHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_C="\"sha1dc_git.c\"" \
-		-DSHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_H="\"sha1dc_git.h\"" \
 		-DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\""
 endif
 endif
diff --git a/hash.h b/hash.h
index bef3e630a093..024d0d3d50b1 100644
--- a/hash.h
+++ b/hash.h
@@ -8,11 +8,7 @@
 #elif defined(SHA1_OPENSSL)
 #include <openssl/sha.h>
 #elif defined(SHA1_DC)
-#ifdef DC_SHA1_SUBMODULE
-#include "sha1collisiondetection/lib/sha1.h"
-#else
-#include "sha1dc/sha1.h"
-#endif
+#include "sha1dc_git.h"
 #else /* SHA1_BLK */
 #include "block-sha1/sha1.h"
 #endif
diff --git a/sha1dc_git.c b/sha1dc_git.c
index 4d32b4f77e04..79466414f841 100644
--- a/sha1dc_git.c
+++ b/sha1dc_git.c
@@ -1,8 +1,8 @@
+#include "cache.h"
+
 /*
- * This code is included at the end of sha1dc/sha1.c with the
- * SHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_C macro.
+ * Same as SHA1DCFinal, but convert collision attack case into a verbose die().
  */
-
 void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
 {
 	if (!SHA1DCFinal(hash, ctx))
@@ -11,6 +11,9 @@ void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
 	    sha1_to_hex(hash));
 }
 
+/*
+ * Same as SHA1DCUpdate, but adjust types to match git's usual interface.
+ */
 void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, unsigned long len)
 {
 	const char *data = vdata;
diff --git a/sha1dc_git.h b/sha1dc_git.h
index a8a5c1da169e..af3e9514bc8e 100644
--- a/sha1dc_git.h
+++ b/sha1dc_git.h
@@ -1,16 +1,12 @@
-/*
- * This code is included at the end of sha1dc/sha1.h with the
- * SHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_H macro.
- */
+/* Plumbing with collition-detecting SHA1 code */
 
-/*
- * Same as SHA1DCFinal, but convert collision attack case into a verbose die().
- */
-void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
+#ifdef DC_SHA1_SUBMODULE
+#include "sha1collisiondetection/lib/sha1.h"
+#else
+#include "sha1dc/sha1.h"
+#endif
 
-/*
- * Same as SHA1DCUpdate, but adjust types to match git's usual interface.
- */
+void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
 void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
 
 #define platform_SHA_CTX SHA1_CTX
-- 
2.14.1

