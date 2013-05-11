From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] cache.h: eliminate SHA-1 deprecation warnings on OS X 10.8
Date: Fri, 10 May 2013 19:44:42 -0700
Message-ID: <1368240282-89581-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 11 04:44:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaznr-0001IU-H0
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 04:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757211Ab3EKCov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 22:44:51 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:64167 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757178Ab3EKCou (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 22:44:50 -0400
Received: by mail-pb0-f48.google.com with SMTP id md4so123841pbc.21
        for <git@vger.kernel.org>; Fri, 10 May 2013 19:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Wyl9yqKYeougZ9Km7r+NH3iMVLBpUi9zceOZXgk3Uy8=;
        b=JEJxLSHcUp1y6LY2/DTZrAWW5t2+TdPzsHoVJadiPr8mSe8gQOtqL/Tsn5ylL+RVwv
         Cp7Huy0Sk83SaRcjjmVqA/V5qZ+lkDJi2hknTuHBii3jbvbgOUCogTmB7nJAk1ayxPnu
         MN/NothoWynzlModUheVBkwLIXLzcFw+7Nc00niIFEluanlqoikuqvb/P7wpMczh9VFx
         HhtKrKtpd7jRSSXrDkV1+N23GQ4lZkUiRxzxy/tWs2br7KC97Lp0mvdrWnDsr7LTbCvO
         1VAU5F4+JUwgRVbzxtKrUCUyboIbgjrHSq9kNeLs2pTQvGQZorVI/Me0T/Ay4gTnu7HL
         CpBw==
X-Received: by 10.67.5.8 with SMTP id ci8mr20152435pad.48.1368240289405;
        Fri, 10 May 2013 19:44:49 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id to7sm5098499pab.0.2013.05.10.19.44.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 19:44:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.45.g88f80b8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223925>

Mac OS X Mountain Lion prints warnings when building git:

	warning: 'SHA1_Init' is deprecated
	(declared at /usr/include/openssl/sha.h:121)

Silence the warnings by using the Common Digest SHA-1
functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().

Add a COMMON_DIGEST_SHA1 knob to the Makefile to allow
choosing this implementation and define it by default on Darwin.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
The previous version of this patch (somehow?) eliminated the SHA1
warnings, but it was not redefining SHA1_HEADER to CommonDigest.h.
This version goes all the way.

Some warnings still exist around the HMAC functions (and others)
used by e.g. imap.c, which should be dealt with separately.

 Makefile | 7 +++++++
 cache.h  | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/Makefile b/Makefile
index 0f931a2..d8a45b4 100644
--- a/Makefile
+++ b/Makefile
@@ -1054,6 +1054,7 @@ ifeq ($(uname_S),Darwin)
 			BASIC_LDFLAGS += -L/opt/local/lib
 		endif
 	endif
+	COMMON_DIGEST_SHA1 = YesPlease
 	PTHREAD_LIBS =
 endif
 
@@ -1388,10 +1389,16 @@ ifdef PPC_SHA1
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
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
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
1.8.3.rc1.45.g88f80b8.dirty
