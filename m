From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v6 2/2] imap-send: eliminate HMAC deprecation warnings on Mac OS X
Date: Wed, 15 May 2013 17:12:00 -0700
Message-ID: <1368663120-47102-2-git-send-email-davvid@gmail.com>
References: <1368663120-47102-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 02:11:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UclnS-0008Dm-0q
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 02:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149Ab3EPALk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 20:11:40 -0400
Received: from mail-ia0-f178.google.com ([209.85.210.178]:46837 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab3EPALj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 20:11:39 -0400
Received: by mail-ia0-f178.google.com with SMTP id i9so2790367iad.37
        for <git@vger.kernel.org>; Wed, 15 May 2013 17:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=U5UoYzZQgF+94lqTbzZuNOACDYb0Hoi/z/oN4ZomfkQ=;
        b=HzNbmH5A85mrAEI92kTTtUbfIFTiMi9ld12P5BRqyliUGUezqjXiY0IiyGQty4tDmi
         9frPgHiTwkVSN3/KTTXgJU5ltHw2xysZX8knuKt9js9aLqWBbFBJb1+dZynYLjj0FNdS
         SRsgwZr3C01XAp56EDTtuORr7Pr+uIb0WywB+hh4tkWqKuVwG3P62jxcP3X3kp4jPyAC
         /iA+W6c4y3QSo3XSF9nMLLmjij5qtIIEHCfvmXHPDhTwuLr86Y6LL3t0yaG/WURySmzk
         0Oprm3WSsgxKQb6bkImsSleHEbE+P+7mGCR5SZf2BqCIFoT6B2gnfcS6sMiBn/B1s0hM
         p3Gg==
X-Received: by 10.50.85.12 with SMTP id d12mr7145667igz.91.1368663098650;
        Wed, 15 May 2013 17:11:38 -0700 (PDT)
Received: from lustrous.local.fas.fa.disney.com (w.disneyanimation.com. [198.187.190.241])
        by mx.google.com with ESMTPSA id xf4sm361136igb.8.2013.05.15.17.11.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 May 2013 17:11:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.3.g81576a6
In-Reply-To: <1368663120-47102-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224460>

Mac OS X 10.8 Mountain Lion warns that HMAC_Init() and friends
are deprecated.  Detect the COMMON_CRYPTO_FOR_OPENSSL definition
and use CommonCrypto's HMAC functions to eliminate the warnings.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since last time: None.

 imap-send.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/imap-send.c b/imap-send.c
index d9bcfb4..96012b1 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -29,8 +29,18 @@
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #else
+#ifdef COMMON_DIGEST_FOR_OPENSSL
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
1.8.3.rc2.3.g81576a6
