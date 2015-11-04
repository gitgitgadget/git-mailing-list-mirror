From: atousa.p@gmail.com
Subject: [PATCH] Limit the size of the data block passed to SHA1_Update()
Date: Tue,  3 Nov 2015 20:24:46 -0800
Message-ID: <1446611086-6102-1-git-send-email-apahlevan@ieee.org>
References: <56389FBC.7050909@web.de>
Cc: Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 04 05:25:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztpdo-000776-Eb
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 05:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbbKDEZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 23:25:01 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34415 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbbKDEZA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 23:25:00 -0500
Received: by padhx2 with SMTP id hx2so31897091pad.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 20:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gS9M3zlp79gO3o+lkzjRdHr8TKhtC/EQhz+F9oQj4OQ=;
        b=ay/fcRXn/cM4D+v0SPoycPHVRW9wwWxJ0foXf7V9jcV/QYCZ8vlPzZH65zfX5L6JlF
         2nBzFr3O9njjNEFqCIKpmWpyqOYns0R0uakOI+IxMpb5SjTkEPr2GG5EGCG51BPq+Sjc
         5NuDnQXKUI++Qj47nM8Fd5Oai0KICrU9BVd5QnoEn0c85rKDkYhTR5aFx59a7wktMu7K
         oEJFGSWAqDNotanh2JI9PCAdLX7u7+QVcaWPF8khySak863C1kwX4KLlsTTpATPYK4vN
         I3Wug62RWaTM4bpIIKQFv5Jv+DLlLcqbQmVmk5DtRzQohHBEGoz3cgGP1EqkWo7Xv/05
         AcaA==
X-Received: by 10.68.213.1 with SMTP id no1mr38546219pbc.77.1446611099964;
        Tue, 03 Nov 2015 20:24:59 -0800 (PST)
Received: from Atousas-Air.jduprat.net ([50.240.193.13])
        by smtp.gmail.com with ESMTPSA id pn8sm32401113pbb.16.2015.11.03.20.24.59
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Nov 2015 20:24:59 -0800 (PST)
X-Google-Original-From: apahlevan@ieee.org
X-Mailer: git-send-email 2.4.9 (Apple Git-60)
In-Reply-To: <56389FBC.7050909@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280848>

From: Atousa Pahlevan Duprat <apahlevan@ieee.org>

Some implementations of SHA_Updates have inherent limits
on the max chunk size. SHA1_MAX_BLOCK_SIZE can be defined
to set the max chunk size supported, if required.  This is
enabled for OSX CommonCrypto library and set to 1GiB.

Signed-off-by: Atousa Pahlevan Duprat <apahlevan@ieee.org>
---
 Makefile                     | 16 +++++++++++++++-
 block-sha1/sha1.h            |  2 +-
 cache.h                      | 17 +++++++++++++----
 compat/apple-common-crypto.h |  4 ++++
 compat/sha1_chunked.c        | 19 +++++++++++++++++++
 5 files changed, 52 insertions(+), 6 deletions(-)
 create mode 100644 compat/sha1_chunked.c

diff --git a/Makefile b/Makefile
index 04c2231..1b098cc 100644
--- a/Makefile
+++ b/Makefile
@@ -136,11 +136,15 @@ all::
 # to provide your own OpenSSL library, for example from MacPorts.
 #
 # Define BLK_SHA1 environment variable to make use of the bundled
-# optimized C SHA1 routine.
+# optimized C SHA1 routine.  This implies NO_APPLE_COMMON_CRYPTO.
 #
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
+# Define SHA1_MAX_BLOCK_SIZE if your SSH1_Update() implementation can
+# hash only a limited amount of data in one call (e.g. APPLE_COMMON_CRYPTO
+# may want 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined).
+#
 # Define NEEDS_CRYPTO_WITH_SSL if you need -lcrypto when using -lssl (Darwin).
 #
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
@@ -986,6 +990,10 @@ ifeq (no,$(USE_PARENS_AROUND_GETTEXT_N))
 endif
 endif
 
+ifdef BLK_SHA1
+	NO_APPLE_COMMON_CRYPTO=1
+endif
+
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
@@ -1346,6 +1354,8 @@ else
 ifdef APPLE_COMMON_CRYPTO
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
 	SHA1_HEADER = <CommonCrypto/CommonDigest.h>
+	# Apple CommonCrypto requires chunking
+	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
 else
 	SHA1_HEADER = <openssl/sha.h>
 	EXTLIBS += $(LIB_4_CRYPTO)
@@ -1353,6 +1363,10 @@ endif
 endif
 endif
 
+ifdef SHA1_MAX_BLOCK_SIZE
+	LIB_OBJS += compat/sha1_chunked.o
+	BASIC_CFLAGS += -DSHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
+endif
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
index b864df6..d085412 100644
--- a/block-sha1/sha1.h
+++ b/block-sha1/sha1.h
@@ -18,5 +18,5 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx);
 
 #define git_SHA_CTX	blk_SHA_CTX
 #define git_SHA1_Init	blk_SHA1_Init
-#define git_SHA1_Update	blk_SHA1_Update
+#define platform_SHA1_Update	blk_SHA1_Update
 #define git_SHA1_Final	blk_SHA1_Final
diff --git a/cache.h b/cache.h
index 79066e5..e345e38 100644
--- a/cache.h
+++ b/cache.h
@@ -10,12 +10,21 @@
 #include "trace.h"
 #include "string-list.h"
 
+/* platform's underlying implementation of SHA1 */
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
-#define git_SHA_CTX	SHA_CTX
-#define git_SHA1_Init	SHA1_Init
-#define git_SHA1_Update	SHA1_Update
-#define git_SHA1_Final	SHA1_Final
+#define git_SHA_CTX		SHA_CTX
+#define git_SHA1_Init		SHA1_Init
+#define platform_SHA1_Update	SHA1_Update
+#define git_SHA1_Final		SHA1_Final
+#endif
+
+/* choose chunked implementation or not */
+#ifdef SHA1_MAX_BLOCK_SIZE
+int git_SHA1_Update_Chunked(SHA_CTX *c, const void *data, size_t len);
+#define git_SHA1_Update       git_SHA1_Update_Chunked
+#else
+#define git_SHA1_Update       platform_SHA1_Update
 #endif
 
 #include <zlib.h>
diff --git a/compat/apple-common-crypto.h b/compat/apple-common-crypto.h
index c8b9b0e..d3fb264 100644
--- a/compat/apple-common-crypto.h
+++ b/compat/apple-common-crypto.h
@@ -16,6 +16,10 @@
 #undef TYPE_BOOL
 #endif
 
+#ifndef SHA1_MAX_BLOCK_SIZE
+#error Using Apple Common Crypto library requires setting SHA1_MAX_BLOCK_SIZE
+#endif
+
 #ifdef APPLE_LION_OR_NEWER
 #define git_CC_error_check(pattern, err) \
 	do { \
diff --git a/compat/sha1_chunked.c b/compat/sha1_chunked.c
new file mode 100644
index 0000000..6d0062b
--- /dev/null
+++ b/compat/sha1_chunked.c
@@ -0,0 +1,19 @@
+#include "cache.h"
+
+int git_SHA1_Update_Chunked(SHA_CTX *c, const void *data, size_t len)
+{
+	size_t nr;
+	size_t total = 0;
+	const char *cdata = (const char*)data;
+
+	while (len) {
+		nr = len;
+		if (nr > SHA1_MAX_BLOCK_SIZE)
+			nr = SHA1_MAX_BLOCK_SIZE;
+		platform_SHA1_Update(c, cdata, nr);
+		total += nr;
+		cdata += nr;
+		len -= nr;
+	}
+	return total;
+}
-- 
2.4.9 (Apple Git-60)
