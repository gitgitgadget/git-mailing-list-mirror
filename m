From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 2/3] imap-send: eliminate HMAC warnings on OS X 10.8
Date: Sat, 11 May 2013 01:22:27 -0700
Message-ID: <1368260548-52612-2-git-send-email-davvid@gmail.com>
References: <1368260548-52612-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 11 10:23:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub555-0000nt-0j
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 10:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab3EKIWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 04:22:53 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:59028 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab3EKIWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 04:22:51 -0400
Received: by mail-pa0-f52.google.com with SMTP id bg2so3460428pad.39
        for <git@vger.kernel.org>; Sat, 11 May 2013 01:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=LgmaVN6tJvk7FYR7imzm+r+RRVpBInGpca90mAbo+PA=;
        b=waQddcSzW48RJSP0d9Fvb9mxdcTTDD6qGh/Do7X8U75mTsBhfIFXRb2JGnZGmzUELQ
         zq/OGMLCY6i9sdo28gC2RPXDdZQh618r2XlBDynqaX/IGvmRlo1uWWrTwaRk00e6y+JN
         fhxMrveufhaaGX1FhKnNUPJKL8fDNxWzBA6AeQFMNaTAiFNNK5ujZbNxvfb7L3iTO0iD
         HpdNX2412XwZepkakUBk58pjfFWeZqhBQ/lAqKEo+0QfRsgoIEFoLSMIuFt3b7mum5+i
         28LqyTO82g4iXJ0xmtMzHnjS9uJT0uOITkqB20qFf6VE8oJylyItgoND9KBMa964VquM
         DrJw==
X-Received: by 10.66.119.34 with SMTP id kr2mr21239910pab.149.1368260571127;
        Sat, 11 May 2013 01:22:51 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id dr6sm6154774pac.11.2013.05.11.01.22.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 11 May 2013 01:22:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.47.g41936fa
In-Reply-To: <1368260548-52612-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223943>

Mac OS X Mountain Lion warns that HMAC_Init() and friends are
deprecated.  Use CommonCrypto's HMAC to eliminate the warnings.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Rebased to 2/3.

 Makefile    |  5 +++++
 imap-send.c | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Makefile b/Makefile
index f698c1a..25282b4 100644
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
+	BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_HMAC=1
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
1.8.3.rc1.47.g41936fa
