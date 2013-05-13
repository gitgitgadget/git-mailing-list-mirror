From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 3/3] cache.h: eliminate SHA-1 deprecation warnings on OS X 10.8
Date: Mon, 13 May 2013 00:20:35 -0700
Message-ID: <1368429635-5512-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 09:20:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubn3c-0006eC-7c
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 09:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449Ab3EMHUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 03:20:24 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:57023 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab3EMHUX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 03:20:23 -0400
Received: by mail-pd0-f182.google.com with SMTP id 3so4204215pdj.13
        for <git@vger.kernel.org>; Mon, 13 May 2013 00:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=k4kJPE5JWEfkqKwpue/pbJhEzilXK9THp9LrZfT8vgs=;
        b=D2Z+jeZDMLVHVvsehcBMvoFt4MklL2aQnvpBmKQQWqBTjy76dT4MkanVLlyC/9eHQu
         FnqMT5hIEqrz01eYGrWWVFwtWtAjE/11Mt7LpxyI8hWlaS3ghIvBqmsU9MrzlAzZFK9P
         BW0bnziCixm8uX77om0oS94ng7IKHQXGBDQdQHUUgTFZtBnk2aLMEY5AWQC55di1Lmse
         Z6AhkyR86L3c+lsIPH6koEyJe6sa7/E0Wdl+q7ektvY5OHJtB6iOXGCmbMfkOTZ1jojs
         t3JwiW/KUYvms4mIBUi5Q7cy5u+rFhnOrca3p/+DilPgTtb/Q2SKOZurb4qoaEHdMzPP
         hQwQ==
X-Received: by 10.66.216.198 with SMTP id os6mr28087336pac.145.1368429622948;
        Mon, 13 May 2013 00:20:22 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id zo4sm12938751pbc.21.2013.05.13.00.20.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 00:20:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.47.g1b7707e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224100>

Mac OS X Mountain Lion prints warnings when building git:

	warning: 'SHA1_Init' is deprecated
	(declared at /usr/include/openssl/sha.h:121)

Silence the warnings by using the Common Digest SHA-1
functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().

Add a COMMON_DIGEST_SHA1 option to the Makefile to allow
choosing this implementation and define it by default on Darwin.

Define COMMON_DIGEST_FOR_SHA1 to enable the OpenSSL compatibility
macros in CommonDigest.h.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Here's a replacement patch for what's in pu.
This version uses the built-in #defines and can thus avoid
touching cache.h.

 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index 25282b4..9d174b9 100644
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
@@ -1390,10 +1391,15 @@ ifdef PPC_SHA1
 	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
 	LIB_H += ppc/sha1.h
 else
+ifdef COMMON_DIGEST_SHA1
+	BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_SHA1=1
+	SHA1_HEADER = <CommonCrypto/CommonDigest.h>
+else
 	SHA1_HEADER = <openssl/sha.h>
 	EXTLIBS += $(LIB_4_CRYPTO)
 endif
 endif
+endif
 
 ifdef COMMON_DIGEST_HMAC
 	BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_HMAC=1
-- 
1.8.3.rc1.47.g1b7707e
