From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 2/3] imap-send: eliminate HMAC deprecation warnings on OS X 10.8
Date: Mon, 13 May 2013 01:23:38 -0700
Message-ID: <1368433419-24065-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 10:23:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubo2f-00062k-HR
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 10:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab3EMIX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 04:23:29 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:57345 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406Ab3EMIX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 04:23:28 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so4202712pdj.24
        for <git@vger.kernel.org>; Mon, 13 May 2013 01:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=8gLl+vwZbvcSPcBllBz+0hGwpuc/PhcgktZ3/xC7RHc=;
        b=Ounf4ezYOhPDMQ5Z1OkuIZC4XjGZIDs6xyrmFnzzgrCwf4XB+Iir4P0elezWfbSGjD
         yKAOKqlKX2/F5Ce5FC/St9Vvt0QcuFuMHiVzmNbaaP6eCAvT7IIbw7oY08UXCNnFHGZl
         wG+oMdko//jTrlaij4yReX0NHFzKr6YeLZp1Q5yJIUAiXmWEU3nG7GRZqcnTDcfCnU6Y
         rtrbkUtf2XZqBwO2Zqot62zfRQbDUl+pArAvRDCDw2XUwI96opxTAEVU/mv70+qrCGO2
         dU3AKMW8XAD1+ZIiLJ4vVYDbt14tyWpRhDz6+/yuWcsBkWT/u+PX+n3zYPhNK4tuJHFc
         Y8FQ==
X-Received: by 10.66.121.169 with SMTP id ll9mr28544722pab.126.1368433407823;
        Mon, 13 May 2013 01:23:27 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id kv2sm13130142pbc.28.2013.05.13.01.23.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 01:23:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.g872cb7b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224108>

Mac OS X Mountain Lion warns that HMAC_Init() and friends are
deprecated.  Use CommonCrypto's HMAC to eliminate the warnings.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
1/3 not included since it is unchanged.
These are replacement patches for what's currently in "pu".

Changes since last time:

We no longer say "=1" when defining COMMON_DIGEST_FOR_HMAC.
I added the word "deprecated" to the commit message subject
for consistency with the other patches in this series.

 Makefile    |  5 +++++
 imap-send.c | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Makefile b/Makefile
index f698c1a..a0f7afc 100644
--- a/Makefile
+++ b/Makefile
@@ -1054,6 +1054,7 @@ ifeq ($(uname_S),Darwin)
 			BASIC_LDFLAGS += -L/opt/local/lib
 		endif
 	endif
+	COMMON_DIGEST_HMAC = YesPlease
 	NO_REGEX = YesPlease
 	PTHREAD_LIBS =
 endif
@@ -1393,6 +1394,10 @@ else
 	EXTLIBS += $(LIB_4_CRYPTO)
 endif
 endif
+
+ifdef COMMON_DIGEST_HMAC
+	BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_HMAC
+endif
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
diff --git a/imap-send.c b/imap-send.c
index d9bcfb4..1b2e69c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -29,8 +29,18 @@
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #else
+#ifdef COMMON_DIGEST_FOR_HMAC
+#include <CommonCrypto/CommonHMAC.h>
+#define HMAC_CTX CCHmacContext
+#define HMAC_Init(hmac, key, len, algo) CCHmacInit(hmac, algo, key, len)
+#define HMAC_Update CCHmacUpdate
+#define HMAC_Final(hmac, hash, ptr) CCHmacFinal(hmac, hash)
+#define HMAC_CTX_cleanup
+#define EVP_md5() kCCHmacAlgMD5
+#else
 #include <openssl/evp.h>
 #include <openssl/hmac.h>
+#endif
 #include <openssl/x509v3.h>
 #endif
 
-- 
1.8.3.rc1.52.g872cb7b
