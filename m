From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v7 3/3] imap-send: eliminate HMAC deprecation warnings on Mac OS X
Date: Fri, 17 May 2013 20:32:38 -0400
Message-ID: <1368837158-13915-4-git-send-email-sunshine@sunshineco.com>
References: <1368837158-13915-1-git-send-email-sunshine@sunshineco.com>
Cc: David Aguilar <davvid@gmail.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 02:33:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdV5Z-0006ac-S5
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 02:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756708Ab3ERAd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 20:33:29 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:65062 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457Ab3ERAd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 20:33:27 -0400
Received: by mail-ie0-f179.google.com with SMTP id c13so10341632ieb.24
        for <git@vger.kernel.org>; Fri, 17 May 2013 17:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=WVqHDxOY+k0kz9KNG3Ap7GJXEG4cpLoFR3LO29reQR0=;
        b=xcr66ruy+sjrfc8K/LZV93vEGU1WPfdSNAbsGi69XJ7SLlVQmewXNcQqGSrfaAMz/q
         oXRzZrw7AYPFj1DkLcTD5SWCap+Wf4qtkl/vv43uSCvC6zZfFborgxQ2DPZUwrtmPc/F
         Qsq/CRh+qTLbqshuabN51egkSi6CGB+C7T5RFbR6hojFmGABchFRCtYsjwVq+ujDicue
         1flRPmHe/ykzHRO8vcmJWuezLzMo2Vf4Dr2M573mnGt+G7O4y3r01nJ03W2PkUyZlgX6
         LPNGpsLog65wcw59+9twCWoTBH0H0+CL0dENCKzmzWqWYg06sK2CG3SqurHAYuOVuvsc
         Sghg==
X-Received: by 10.50.80.101 with SMTP id q5mr3850igx.2.1368837207209;
        Fri, 17 May 2013 17:33:27 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ua6sm9203igb.0.2013.05.17.17.33.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 17:33:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368837158-13915-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224746>

From: David Aguilar <davvid@gmail.com>

As of Mac OS X 10.7, Apple deprecated all OpenSSL functions due to
OpenSSL ABI instability.  Silence the warnings by using Apple's
CommonCrypto HMAC replacement functions.

[es: reworded commit message; eliminated abuse of
COMMON_DIGEST_FOR_OPENSSL by checking NO_APPLE_COMMON_CRYPTO instead]

Signed-off-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 imap-send.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/imap-send.c b/imap-send.c
index d9bcfb4..642448c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -29,8 +29,18 @@
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #else
+#ifndef NO_APPLE_COMMON_CRYPTO
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
1.8.2.3
