From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] cache.h: avoid deprecation warnings on OS X 10.8
Date: Fri, 10 May 2013 19:23:30 -0700
Message-ID: <1368239010-60894-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 11 04:23:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UazTL-0006E0-Vo
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 04:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345Ab3EKCXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 22:23:38 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:52480 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018Ab3EKCXi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 22:23:38 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so3123294pde.23
        for <git@vger.kernel.org>; Fri, 10 May 2013 19:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=7spt0rS3FBHkFwgzI/PdJhYMqxaxHlkkLhqt0pURLew=;
        b=Lc2rbWrnnHY3Un6hMiPSu5OgUNNsFKt85yvbGVEC0kmKvLcKjqTpbrBVWM+BgHbTNB
         f0a3bKSW22UvCmhO2Wn7a1Y6CQ4NXLCT4BcWRIiXc15wi/qu0L9/t1bish3Oe9sHQvsj
         JnPsslrmuQyX+UabssHoYouLsW87UCg7FGBX82JhQaWKwAv4Du+d+przTj05/CVnB7nL
         m305f4Txb/ueBu7Qb2aT1KomV/QYpbxxE9SW47J6ACz0TTaSI0HULLTdlXTPwJmC3kyD
         zDpkwjX/6ugl/uMip47i626EJRVOasGctGT3Z2ES576m+CQr9uY384V6OnvRlFXjtb3X
         FKYQ==
X-Received: by 10.66.144.170 with SMTP id sn10mr20175384pab.42.1368239017491;
        Fri, 10 May 2013 19:23:37 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id fn2sm4669882pbc.15.2013.05.10.19.23.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 19:23:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.44.gb387c77.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223924>

Mac OS X Mountain Lion prints warnings when building git:

	warning: 'SHA1_Init' is deprecated
	(declared at /usr/include/openssl/sha.h:121)

Silence the warnings by using the Common Digest SHA-1
functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().

Add a COMMON_DIGEST_SHA1 knob to the Makefile to allow
choosing this implementation and define it by default on Darwin.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This implements the suggestion from John Keeping instead
of blindly setting NO_OPENSSL on Darwin.

 Makefile | 4 ++++
 cache.h  | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index 0f931a2..ce62002 100644
--- a/Makefile
+++ b/Makefile
@@ -1054,6 +1054,7 @@ ifeq ($(uname_S),Darwin)
 			BASIC_LDFLAGS += -L/opt/local/lib
 		endif
 	endif
+	COMMON_DIGEST_SHA1 = YesPlease
 	PTHREAD_LIBS =
 endif
 
@@ -1390,6 +1391,9 @@ ifdef PPC_SHA1
 else
 	SHA1_HEADER = <openssl/sha.h>
 	EXTLIBS += $(LIB_4_CRYPTO)
+ifdef COMMON_DIGEST_SHA1
+	BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_SHA1=1
+endif
 endif
 endif
 ifdef NO_PERL_MAKEMAKER
diff --git a/cache.h b/cache.h
index 94ca1ac..f137fd4 100644
--- a/cache.h
+++ b/cache.h
@@ -11,10 +11,16 @@
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
 #define git_SHA_CTX	SHA_CTX
+#ifdef COMMON_DIGEST_FOR_SHA1
+#define git_SHA1_Init	CC_SHA1_Init
+#define git_SHA1_Update	CC_SHA1_Update
+#define git_SHA1_Final	CC_SHA1_Final
+#else
 #define git_SHA1_Init	SHA1_Init
 #define git_SHA1_Update	SHA1_Update
 #define git_SHA1_Final	SHA1_Final
 #endif
+#endif
 
 #include <zlib.h>
 typedef struct git_zstream {
-- 
1.8.3.rc1.44.gb387c77.dirty
