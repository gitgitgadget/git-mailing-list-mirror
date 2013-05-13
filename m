From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 3/3] cache.h: eliminate SHA-1 deprecation warnings on OS X 10.8
Date: Mon, 13 May 2013 01:23:39 -0700
Message-ID: <1368433419-24065-2-git-send-email-davvid@gmail.com>
References: <1368433419-24065-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 10:23:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubo2g-00062k-1b
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 10:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab3EMIXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 04:23:31 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:50330 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab3EMIXa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 04:23:30 -0400
Received: by mail-pb0-f51.google.com with SMTP id wy7so4244444pbc.38
        for <git@vger.kernel.org>; Mon, 13 May 2013 01:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=fmgH9nXz6Kr45qOA6qHpBu2ipMyVjg4i6YoBHMtPNlg=;
        b=OWdF7TPTFnE4iehtwGfWlbdD8OwpC43K/srA/SvCUm2qQty2Bmj+8ZD1RAT4QG7/ZN
         2vgp+dM70bgpGh1p3AJHEjU6M6Rqac+/x81e/sULwlA5V4j6bsBgyYV0Ee37qZQx4Y+n
         CPIuNnuvfyNOfT8d+uOvTt/SHd3cTUtC8+ui6fLwS5jGkgfysWFJllon+VeeEUSHvVNC
         7wFREOX1rXzfmonw1Cr6/Ighv+7lFlA+5ykmytGXn9HdPyfhb9x42t1OYs4SxYlaa7+m
         LFDpbb3z7KAZ24JJWu+lYdc4kHRJ3DOPI9GGyQywMydLEqcv7lzd9oLmwW12O+SACd3a
         ShZA==
X-Received: by 10.67.5.8 with SMTP id ci8mr28434333pad.48.1368433409803;
        Mon, 13 May 2013 01:23:29 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id kv2sm13130142pbc.28.2013.05.13.01.23.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 01:23:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.g872cb7b
In-Reply-To: <1368433419-24065-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224109>

Mac OS X Mountain Lion prints warnings when building git:

	warning: 'SHA1_Init' is deprecated
	(declared at /usr/include/openssl/sha.h:121)

Silence the warnings by using the CommonCrytpo SHA-1
functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().

Add a COMMON_DIGEST_SHA1 option to the Makefile to allow
choosing this implementation and define it by default on Darwin.

Define COMMON_DIGEST_FOR_OPENSSL to enable the OpenSSL
compatibility macros in CommonDigest.h.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since last round:
COMMON_DIGEST_FOR_OPENSSL is used to enable the compatibility macros.

 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index a0f7afc..29c02ed 100644
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
+	BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
+	SHA1_HEADER = <CommonCrypto/CommonDigest.h>
+else
 	SHA1_HEADER = <openssl/sha.h>
 	EXTLIBS += $(LIB_4_CRYPTO)
 endif
 endif
+endif
 
 ifdef COMMON_DIGEST_HMAC
 	BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_HMAC
-- 
1.8.3.rc1.52.g872cb7b
