Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9800208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 12:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbdHOME2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 08:04:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:51107 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752154AbdHOME1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 08:04:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5AB9AEA9;
        Tue, 15 Aug 2017 12:04:25 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Andreas Stieger <astieger@suse.com>
Subject: [PATCH v2 2/2] sha1dc: Allow building with the external sha1dc library
Date:   Tue, 15 Aug 2017 14:04:17 +0200
Message-Id: <20170815120417.31616-3-tiwai@suse.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170815120417.31616-1-tiwai@suse.de>
References: <20170815120417.31616-1-tiwai@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some distros provide SHA1 collision-detect code as a shared library.
It's the same code as we have in git tree (but may be with a different
init default for hash), and git can link with it as well; at least, it
may make maintenance easier, according to our security guys.

This patch allows user to build git linking with the external sha1dc
library instead of the built-in code.  User needs to define
DC_SHA1_EXTERNAL explicitly.  As default without it, the built-in
sha1dc code is used like before.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Makefile     | 13 +++++++++++++
 sha1dc_git.c | 11 +++++++++++
 sha1dc_git.h | 10 +++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5e7e9022bdd8..9f492b5d1d37 100644
--- a/Makefile
+++ b/Makefile
@@ -162,6 +162,11 @@ all::
 # algorithm. This is slower, but may detect attempted collision attacks.
 # Takes priority over other *_SHA1 knobs.
 #
+# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
+# git with the external SHA1 collision-detect library.
+# Without this option, i.e. the default behavior is to build git with its
+# own built-in code (or submodule).
+#
 # Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
 # sha1collisiondetection shipped as a submodule instead of the
 # non-submodule copy in sha1dc/. This is an experimental option used
@@ -1474,6 +1479,13 @@ else
 	DC_SHA1 := YesPlease
 	BASIC_CFLAGS += -DSHA1_DC
 	LIB_OBJS += sha1dc_git.o
+ifdef DC_SHA1_EXTERNAL
+	ifdef DC_SHA1_SUBMODULE
+$(error Only set DC_SHA1_EXTERNAL or DC_SHA1_SUBMODULE, not both)
+	endif
+	BASIC_CFLAGS += -DDC_SHA1_EXTERNAL
+	EXTLIBS += -lsha1detectcoll
+else
 ifdef DC_SHA1_SUBMODULE
 	LIB_OBJS += sha1collisiondetection/lib/sha1.o
 	LIB_OBJS += sha1collisiondetection/lib/ubc_check.o
@@ -1491,6 +1503,7 @@ endif
 endif
 endif
 endif
+endif
 
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
diff --git a/sha1dc_git.c b/sha1dc_git.c
index 79466414f841..e0cc9d988c70 100644
--- a/sha1dc_git.c
+++ b/sha1dc_git.c
@@ -1,5 +1,16 @@
 #include "cache.h"
 
+#ifdef DC_SHA1_EXTERNAL
+/*
+ * Same as SHA1DCInit, but with default save_hash=0
+ */
+void git_SHA1DCInit(SHA1_CTX *ctx)
+{
+	SHA1DCInit(ctx);
+	SHA1DCSetSafeHash(ctx, 0);
+}
+#endif
+
 /*
  * Same as SHA1DCFinal, but convert collision attack case into a verbose die().
  */
diff --git a/sha1dc_git.h b/sha1dc_git.h
index af3e9514bc8e..a8c272927842 100644
--- a/sha1dc_git.h
+++ b/sha1dc_git.h
@@ -2,14 +2,22 @@
 
 #ifdef DC_SHA1_SUBMODULE
 #include "sha1collisiondetection/lib/sha1.h"
+#elif defined(DC_SHA1_EXTERNAL)
+#include <sha1dc/sha1.h>
 #else
 #include "sha1dc/sha1.h"
 #endif
 
+#ifdef DC_SHA1_EXTERNAL
+void git_SHA1DCInit(SHA1_CTX *);
+#else
+#define git_SHA1DCInit	SHA1DCInit
+#endif
+
 void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
 void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
 
 #define platform_SHA_CTX SHA1_CTX
-#define platform_SHA1_Init SHA1DCInit
+#define platform_SHA1_Init git_SHA1DCInit
 #define platform_SHA1_Update git_SHA1DCUpdate
 #define platform_SHA1_Final git_SHA1DCFinal
-- 
2.14.1

