From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v5 2/2] imap-send: eliminate HMAC deprecation warnings on Mac OS X
Date: Wed, 15 May 2013 00:11:08 -0700
Message-ID: <1368601868-42410-2-git-send-email-davvid@gmail.com>
References: <1368601868-42410-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 09:11:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcVrp-0006JL-Fk
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 09:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724Ab3EOHLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 03:11:04 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:46665 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab3EOHLC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 03:11:02 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so1105726pdj.38
        for <git@vger.kernel.org>; Wed, 15 May 2013 00:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=3pbM2MtUScvuCkXMdrtAc4m0n7LNdsgQlLdhJIjGOJM=;
        b=OtzhIryRpvolW6HR3b4Psbfv2KFZzx38iMoRx0IwO8I4loQnPLTpYNlbEoxj0yzcD/
         F04UAdIUbRx4ataM0lcRLYUaKq4ovy5mJghZNcl95ME+oElt6Td+cw1Ym82uG/SsMUVN
         KKYVahSHytoEdlB909UOmlKQqTB4g+zVOemlxsH3wDHUes1W4D+R2KxI2CJo9OXXRqMy
         0FaRGf8OqGTltYdsbDR7Uty9y8I0MzwYqywyWUGUjSBmpbfwvf2XY0Izx6EAVDhTfduK
         srLrR4qrI+GHJdszFVeSvBfJjcCCdNuvdKPXsKqLHz+JWk4Zwo9obd+XoK4BaHisLnbL
         Bg1Q==
X-Received: by 10.66.4.106 with SMTP id j10mr38339287paj.218.1368601861554;
        Wed, 15 May 2013 00:11:01 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id w8sm1732608pbo.9.2013.05.15.00.10.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 May 2013 00:11:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.2.gbc955d1.dirty
In-Reply-To: <1368601868-42410-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224387>

Mac OS X 10.8 Mountain Lion warns that HMAC_Init() and friends
are deprecated.  Detect the COMMON_CRYPTO_FOR_OPENSSL definition
and use CommonCrypto's HMAC functions to eliminate the warnings.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since last time:

This version re-uses the existing COMMON_CRYPTO_FOR_OPENSSL define
instead of tweaking the Makefile to add a new one, so it's simpler.

My previous patch had Jonathan's reviewed-by tag, but he hasn't
reviewed this exact patch, so I removed it.  The C macros are unchanged.

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
1.8.3.rc2.2.gbc955d1
