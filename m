From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v8 3/3] imap-send: eliminate HMAC deprecation warnings on Mac OS X
Date: Sun, 19 May 2013 06:23:36 -0400
Message-ID: <1368959016-23146-4-git-send-email-sunshine@sunshineco.com>
References: <1368959016-23146-1-git-send-email-sunshine@sunshineco.com>
Cc: David Aguilar <davvid@gmail.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 19 12:24:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue0n7-0004wU-In
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 12:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917Ab3ESKY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 06:24:28 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:41164 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843Ab3ESKYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 06:24:24 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so12117511iea.4
        for <git@vger.kernel.org>; Sun, 19 May 2013 03:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=dZEXIIREYfCsIe2Ml4s9d9K4ofZ9BHZpyIKUdjLUIgc=;
        b=rClUwlE7Cc6BxukyzWZyj+OaFHNYSuq67Wu6ySme20g4/bQinJ9MVOSEn2K+mx87mm
         gMe4F+dOL6RxQQUreMwwM6PH+lp4I5LLYuMzvdtenjFMvo4eHcOXbodIXfW8zpyRdOXT
         uJ6EGibrZNoFZQimk0hotx9pi4/et8wUM5bNpceHx98uGvg31nDbxXfiOQ/xLvmmw+HB
         EqQNJ6dn8ljfeEGiHJHBZRY0RZmv9butopRyBfzMXOjO5QirOYnWHoqk09xZf/27KYCD
         +BD8BV1p8NeLwE0PZjOhWIm4ZzEd7ECiXTdCnjoMidqj+bfAf/3OSGTKeqLn29cd8t0y
         zYGQ==
X-Received: by 10.50.115.42 with SMTP id jl10mr2694717igb.71.1368959064282;
        Sun, 19 May 2013 03:24:24 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id qn10sm6338918igc.6.2013.05.19.03.24.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 19 May 2013 03:24:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368959016-23146-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224836>

From: David Aguilar <davvid@gmail.com>

As of Mac OS X 10.7, Apple deprecated all OpenSSL functions due to
OpenSSL ABI instability.  Silence the warnings by using Apple's
CommonCrypto HMAC replacement functions.

[es: reworded commit message; check APPLE_COMMON_CRYPTO instead of
abusing COMMON_DIGEST_FOR_OPENSSL]

Signed-off-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
Junio Hamano writes:
> Doesn't this mean people on platforms that do not care what Apple
> does have to define NO_APPLE_COMMON_CRYPTO?

It certainly does break other platforms. Thanks for catching.

> How about stopping this double-negation and do it more like this?

Double-negation begone.

 imap-send.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/imap-send.c b/imap-send.c
index d9bcfb4..8ea180f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -29,8 +29,18 @@
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #else
+#ifdef APPLE_COMMON_CRYPTO
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
