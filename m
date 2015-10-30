From: Atousa Pahlevan Duprat <atousa.p@gmail.com>
Subject: [PATCH] Limit the size of the data block passed to SHA1_Update()
Date: Fri, 30 Oct 2015 15:12:02 -0700
Message-ID: <1446243122-21464-1-git-send-email-apahlevan@ieee.org>
References: <CA+izobsBmYHHepYka795K2VnVLYBmN2tFqEyzSweMoS9gvuRVw@mail.gmail.com>
Cc: Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 30 23:12:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsHug-0005qX-Ro
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 23:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031214AbbJ3WMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 18:12:43 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33923 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759373AbbJ3WMm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 18:12:42 -0400
Received: by padhk11 with SMTP id hk11so85777229pad.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/eoD5+BXE3hAlzfyo2QsZwWg7/xlyHCluiBys9mMQac=;
        b=BCzZALBMkNc2t/un0ppk4F2ZeYBJJlRQjHZdaZeRwEJXi72fWPtaxM5gBCy1nUahtP
         qp5LE/qlaKIyhda12+NJs36L8QF6DU/4iSZta9GW4bIzk/+rQ7FiwQbOHA2ps+mr+gzz
         A+SHq98AqwCoBRjuqsoHKGuRWjiB8/hXgf4SFG+igGHcohhZQd5nIESRPaHpdmbaxcoy
         qVtrsUFesnkJxpF/Eu2VwzdfMzDhREyuP6kMGGjuYcP+fu7P47K61UnrZ+I/B/ccZrJZ
         G+Ws1IQPKVtHikMBOmrvdYQfImZhRpcZaCxY2MLydAfdkZJCiFymMmC/w4sj+rgGXNyZ
         WC8g==
X-Received: by 10.67.30.74 with SMTP id kc10mr10953288pad.147.1446243161799;
        Fri, 30 Oct 2015 15:12:41 -0700 (PDT)
Received: from Atousas-Air.jduprat.net ([50.240.193.13])
        by smtp.gmail.com with ESMTPSA id g12sm10041775pat.36.2015.10.30.15.12.40
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Oct 2015 15:12:41 -0700 (PDT)
X-Google-Original-From: Atousa Pahlevan Duprat <apahlevan@ieee.org>
X-Mailer: git-send-email 2.4.9 (Apple Git-60)
In-Reply-To: <CA+izobsBmYHHepYka795K2VnVLYBmN2tFqEyzSweMoS9gvuRVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280550>

Some implementations of SHA_Updates have inherent limits
on the max chunk size. SHA1_MAX_BLOCK_SIZE can be defined
to set the max chunk size supported, if required.  This is
enabled for OSX CommonCrypto library and set to 1GiB.
---
 Makefile                     |  9 +++++++++
 cache.h                      |  7 ++++++-
 compat/apple-common-crypto.h |  4 ++++
 compat/sha1_chunked.c        | 20 ++++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 compat/sha1_chunked.c

diff --git a/Makefile b/Makefile
index 04c2231..5955542 100644
--- a/Makefile
+++ b/Makefile
@@ -141,6 +141,10 @@ all::
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
@@ -1346,6 +1350,7 @@ else
 ifdef APPLE_COMMON_CRYPTO
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
 	SHA1_HEADER = <CommonCrypto/CommonDigest.h>
+	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
 else
 	SHA1_HEADER = <openssl/sha.h>
 	EXTLIBS += $(LIB_4_CRYPTO)
@@ -1353,6 +1358,10 @@ endif
 endif
 endif
 
+ifdef SHA1_MAX_BLOCK_SIZE
+	LIB_OBJS += compat/sha1_chunked.o
+	BASIC_CFLAGS += -DSHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
+endif
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
diff --git a/cache.h b/cache.h
index 79066e5..ec84b16 100644
--- a/cache.h
+++ b/cache.h
@@ -14,7 +14,12 @@
 #ifndef git_SHA_CTX
 #define git_SHA_CTX	SHA_CTX
 #define git_SHA1_Init	SHA1_Init
-#define git_SHA1_Update	SHA1_Update
+#ifdef SHA1_MAX_BLOCK_SIZE
+extern int SHA1_Update_Chunked(SHA_CTX *, const void *, size_t);
+#define git_SHA1_Update SHA1_Update_Chunked
+#else
+#define git_SHA1_Update SHA1_Update
+#endif
 #define git_SHA1_Final	SHA1_Final
 #endif
 
diff --git a/compat/apple-common-crypto.h b/compat/apple-common-crypto.h
index c8b9b0e..83668fd 100644
--- a/compat/apple-common-crypto.h
+++ b/compat/apple-common-crypto.h
@@ -16,6 +16,10 @@
 #undef TYPE_BOOL
 #endif
 
+#ifndef SHA1_MAX_BLOCK_SIZE
+#error "Using Apple Common Crypto library requires setting SHA1_MAX_BLOCK_SIZE"
+#endif
+
 #ifdef APPLE_LION_OR_NEWER
 #define git_CC_error_check(pattern, err) \
 	do { \
diff --git a/compat/sha1_chunked.c b/compat/sha1_chunked.c
new file mode 100644
index 0000000..4a8e4f7
--- /dev/null
+++ b/compat/sha1_chunked.c
@@ -0,0 +1,20 @@
+#include "cache.h"
+
+#ifdef SHA1_MAX_BLOCK_SIZE
+int git_SHA1_Update(SHA_CTX *c, const void *data, size_t len)
+{
+	size_t nr;
+	size_t total = 0;
+	char *cdata = (char*)data;
+	while(len > 0) {
+		nr = len;
+		if(nr > SHA1_MAX_BLOCK_SIZE)
+			nr = SHA1_MAX_BLOCK_SIZE;
+		SHA1_Update(c, cdata, nr);
+		total += nr;
+		cdata += nr;
+		len -= nr;
+	}
+	return total;
+}
+#endif
-- 
2.4.9 (Apple Git-60)
