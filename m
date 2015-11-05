From: atousa.p@gmail.com
Subject: [PATCH v4 2/3] Limit the size of the data block passed to SHA1_Update()
Date: Wed,  4 Nov 2015 22:38:42 -0800
Message-ID: <1446705523-30701-2-git-send-email-apahlevan@ieee.org>
References: <1446705523-30701-1-git-send-email-apahlevan@ieee.org>
Cc: Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 08:09:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuEff-0005wo-NV
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 08:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1033373AbbKEHGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 02:06:14 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35646 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032418AbbKEGlV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 01:41:21 -0500
Received: by pasz6 with SMTP id z6so80853754pas.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 22:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=KVr9cuPVhXJm+tJFe/y5bZtz0rT8JVTi/9HcQr4DZks=;
        b=MLwLPZ9eMaA9IMC1AvcV/rv4EjLoiyuGkz+QbuMEHqCxpAyBbSrFgIFg87McoxbPMh
         +pB6U90WG3c+1kJhzwFuYk+//sQ/2T1XozqDkPQmzy7+lzupB+hy5Av5zncfIZuxoZFi
         c7RK+VlwFEZtMfDB7OBAd/dsZ0P+S8I9yKuyFKZN2y2cHBp+FdevbxVFRufMoh0KDDsl
         JHDXoOcBiaEAIFdCXiKdQ7m2gte2hCMg+w1JQU5nydTjexvNnouO76LqgQ82G6rSvsYN
         1c+/rXKaw0Wpzr/i1QC94NQJ1nNxlQk055wkCXBZq251kVy8WaP2FYVF+w3+lXAPq/Xg
         TTUQ==
X-Received: by 10.68.173.165 with SMTP id bl5mr7295689pbc.75.1446705681230;
        Wed, 04 Nov 2015 22:41:21 -0800 (PST)
Received: from Atousas-Air.jduprat.net ([50.240.193.13])
        by smtp.gmail.com with ESMTPSA id nu5sm5710601pbb.65.2015.11.04.22.41.20
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Nov 2015 22:41:20 -0800 (PST)
X-Google-Original-From: apahlevan@ieee.org
X-Mailer: git-send-email 2.4.9 (Apple Git-60)
In-Reply-To: <1446705523-30701-1-git-send-email-apahlevan@ieee.org>
In-Reply-To: <CAPig+cS7NktyhveQUiBFkRtJH1D-Aif861e9qshL2R=ZNg2+Lw@mail.gmail.com>
References: <CAPig+cS7NktyhveQUiBFkRtJH1D-Aif861e9qshL2R=ZNg2+Lw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280910>

From: Atousa Pahlevan Duprat <apahlevan@ieee.org>

Use the previous commit's abstraction mechanism for SHA1 to
support a chunked implementation of SHA1_Update() which limits
the amount of data in the chunk passed to SHA1_Update().

This is enabled by using the SHA1_MAX_BLOCK_SIZE envvar to
specify chunk size.  When using Apple's CommonCrypto library
this is enable and set to 1GiB.

Signed-off-by: Atousa Pahlevan Duprat <apahlevan@ieee.org>
---
 Makefile                     | 13 +++++++++++++
 cache.h                      | 17 +++++++++++++++--
 compat/apple-common-crypto.h |  4 ++++
 compat/sha1-chunked.c        | 19 +++++++++++++++++++
 compat/sha1-chunked.h        |  2 ++
 5 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 compat/sha1-chunked.c
 create mode 100644 compat/sha1-chunked.h

diff --git a/Makefile b/Makefile
index 04c2231..6a4ca59 100644
--- a/Makefile
+++ b/Makefile
@@ -141,6 +141,10 @@ all::
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
+# Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
+# in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
+# wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
+#
 # Define NEEDS_CRYPTO_WITH_SSL if you need -lcrypto when using -lssl (Darwin).
 #
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
@@ -1335,6 +1339,11 @@ ifdef NO_POSIX_GOODIES
 	BASIC_CFLAGS += -DNO_POSIX_GOODIES
 endif
 
+ifdef APPLE_COMMON_CRYPTO
+	# Apple CommonCrypto requires chunking
+	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
+endif
+
 ifdef BLK_SHA1
 	SHA1_HEADER = "block-sha1/sha1.h"
 	LIB_OBJS += block-sha1/sha1.o
@@ -1353,6 +1362,10 @@ endif
 endif
 endif
 
+ifdef SHA1_MAX_BLOCK_SIZE
+	LIB_OBJS += compat/sha1-chunked.o
+	BASIC_CFLAGS += -DSHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
+endif
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
diff --git a/cache.h b/cache.h
index a934a2e..182ac62 100644
--- a/cache.h
+++ b/cache.h
@@ -11,7 +11,7 @@
 #include "string-list.h"
 
 #include SHA1_HEADER
-#ifndef git_SHA_CTX
+#ifndef platform_SHA_CTX
 
 /* platform's underlying implementation of SHA1, could be OpenSSL,
    blk_SHA, Apple CommonCrypto, etc...  */
@@ -20,15 +20,28 @@
 #define platform_SHA1_Update	SHA1_Update
 #define platform_SHA1_Final    	SHA1_Final
 
+#endif
+
 /* git may call platform's underlying implementation of SHA1 directly,
    or may call it through a wrapper */
+
+#ifndef git_SHA_CTX
+
+#ifdef SHA1_MAX_BLOCK_SIZE
+#include "compat/sha1-chunked.h"
+#define git_SHA_CTX		platform_SHA_CTX
+#define git_SHA1_Init		platform_SHA1_Init
+#define git_SHA1_Update		git_SHA1_Update_Chunked
+#define git_SHA1_Final		platform_SHA1_Final
+#else
 #define git_SHA_CTX		platform_SHA_CTX
 #define git_SHA1_Init		platform_SHA1_Init
 #define git_SHA1_Update		platform_SHA1_Update
 #define git_SHA1_Final		platform_SHA1_Final
-
 #endif
 
+#endif 
+
 #include <zlib.h>
 typedef struct git_zstream {
 	z_stream z;
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
diff --git a/compat/sha1-chunked.c b/compat/sha1-chunked.c
new file mode 100644
index 0000000..6adfcfd
--- /dev/null
+++ b/compat/sha1-chunked.c
@@ -0,0 +1,19 @@
+#include "cache.h"
+
+int git_SHA1_Update_Chunked(platform_SHA_CTX *c, const void *data, size_t len)
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
diff --git a/compat/sha1-chunked.h b/compat/sha1-chunked.h
new file mode 100644
index 0000000..7b2df28
--- /dev/null
+++ b/compat/sha1-chunked.h
@@ -0,0 +1,2 @@
+
+int git_SHA1_Update_Chunked(platform_SHA_CTX *c, const void *data, size_t len);
-- 
2.4.9 (Apple Git-60)
