From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 3/3] cache.h: eliminate SHA-1 deprecation warnings on OS X 10.8
Date: Sat, 11 May 2013 01:22:28 -0700
Message-ID: <1368260548-52612-3-git-send-email-davvid@gmail.com>
References: <1368260548-52612-1-git-send-email-davvid@gmail.com>
 <1368260548-52612-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 11 10:23:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub555-0000nt-Go
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 10:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab3EKIW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 04:22:57 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:57613 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab3EKIWx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 04:22:53 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so3463010pab.13
        for <git@vger.kernel.org>; Sat, 11 May 2013 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=/dvOOiNI+YDqcz8tqQGYNoPkxR5IKa883tzggpKnvm8=;
        b=V0s1xye/RNHcZ9HvpR+3cOFlHQJ+NVIpe4pIGf+HLEhOyR8NtdjaYhBXTqy2wmb9RO
         kwNFPUadGca2ZCTZgjXdTA2zAv1y5atcZwsprZd+pwXYJZU3SKMQfXxRZkLlBr9wtnI7
         N4DcfpwxCtyH/7ae9/Z4i0nCpOTGX3QsxBVzKkGNcLCtQzBp/ByOJUunNwvjagz3aBx3
         D0L+zJkoxTW8WwKH/MV2OA8V0RNbeK9UnLbdc37rzmh/gd+8RgasUa8m06TkJQobrxsO
         b4WLm8NkFT18wYYjZUSBKRvMDGu/SZS0vRZgkWn0EXLKhiUwuoiXmrAGMT4tK8ArIZ+B
         ICHQ==
X-Received: by 10.68.253.230 with SMTP id ad6mr20044233pbd.182.1368260573026;
        Sat, 11 May 2013 01:22:53 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id dr6sm6154774pac.11.2013.05.11.01.22.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 11 May 2013 01:22:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.47.g41936fa
In-Reply-To: <1368260548-52612-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223942>

Mac OS X Mountain Lion prints warnings when building git:

	warning: 'SHA1_Init' is deprecated
	(declared at /usr/include/openssl/sha.h:121)

Silence the warnings by using the Common Digest SHA-1
functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().

Add a COMMON_DIGEST_SHA1 knob to the Makefile to allow
choosing this implementation and define it by default on Darwin.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Unchanged since last time; rebased to 3/3.

 Makefile | 7 +++++++
 cache.h  | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/Makefile b/Makefile
index 25282b4..8b2f9cc 100644
--- a/Makefile
+++ b/Makefile
@@ -1055,6 +1055,7 @@ ifeq ($(uname_S),Darwin)
 		endif
 	endif
 	COMMON_DIGEST_HMAC = YesPlease
+	COMMON_DIGEST_SHA1 = YesPlease
 	NO_REGEX = YesPlease
 	PTHREAD_LIBS =
 endif
@@ -1390,10 +1391,16 @@ ifdef PPC_SHA1
 	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
 	LIB_H += ppc/sha1.h
 else
+ifdef COMMON_DIGEST_SHA1
+	BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_SHA1=1
+	SHA1_HEADER = <CommonCrypto/CommonDigest.h>
+	EXTLIBS += $(LIB_4_CRYPTO)
+else
 	SHA1_HEADER = <openssl/sha.h>
 	EXTLIBS += $(LIB_4_CRYPTO)
 endif
 endif
+endif
 
 ifdef COMMON_DIGEST_HMAC
 	BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_HMAC=1
diff --git a/cache.h b/cache.h
index 94ca1ac..e2b24c6 100644
--- a/cache.h
+++ b/cache.h
@@ -10,11 +10,18 @@
 
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
+#ifdef COMMON_DIGEST_FOR_SHA1
+#define git_SHA_CTX	CC_SHA1_CTX
+#define git_SHA1_Init	CC_SHA1_Init
+#define git_SHA1_Update	CC_SHA1_Update
+#define git_SHA1_Final	CC_SHA1_Final
+#else
 #define git_SHA_CTX	SHA_CTX
 #define git_SHA1_Init	SHA1_Init
 #define git_SHA1_Update	SHA1_Update
 #define git_SHA1_Final	SHA1_Final
 #endif
+#endif
 
 #include <zlib.h>
 typedef struct git_zstream {
-- 
1.8.3.rc1.47.g41936fa
