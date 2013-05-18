From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v7 2/3] cache.h: eliminate SHA-1 deprecation warnings on Mac OS X
Date: Fri, 17 May 2013 20:32:37 -0400
Message-ID: <1368837158-13915-3-git-send-email-sunshine@sunshineco.com>
References: <1368837158-13915-1-git-send-email-sunshine@sunshineco.com>
Cc: David Aguilar <davvid@gmail.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 02:33:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdV5Z-0006ac-AN
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 02:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482Ab3ERAd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 20:33:26 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:37806 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457Ab3ERAdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 20:33:25 -0400
Received: by mail-ia0-f177.google.com with SMTP id z13so5572492iaz.36
        for <git@vger.kernel.org>; Fri, 17 May 2013 17:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=eoRwhphT4nf/50KF3VluX5EJf62nVRXp2pbe04EL8go=;
        b=MJmYqqs7jcJmLKXsv7uBPxQfyGGzdfYzMueRStGIs3fEDKeLdJKN1YZuMzKmdCUoHc
         g//Eix5lAto39eAKptO2R7vvFqO3H9iBm+BMPHkgm/RMwUH4rdBnBV0lYuzKuwPE86k2
         YfSUiz824f3uDlW3ODqnGPQTj5sG2GqqU8X5y/rBXymfzCGq0a3AK4hU99cYlUsOTPGY
         BbeYL52oG/3m9xKr9w43DWynN2jpeNQI2ns6Ipoa6KFRJ5AeYjJ1R0CHkb1u+VQOm+NF
         U/CxKNJ9Qj3/U9lgCpQpsBcvdw/JZ9xxTzgjC8RAPJLX72QHjnN17fcv0hqU7XxwVVHn
         cyfQ==
X-Received: by 10.50.20.130 with SMTP id n2mr348340ige.87.1368837204960;
        Fri, 17 May 2013 17:33:24 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ua6sm9203igb.0.2013.05.17.17.33.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 17:33:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368837158-13915-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224745>

From: David Aguilar <davvid@gmail.com>

As of Mac OS X 10.7, Apple deprecated all OpenSSL functions due to
OpenSSL ABI instability, thus leading to build diagnostics such as:

	warning: 'SHA1_Init' is deprecated
	(declared at /usr/include/openssl/sha.h:121)

Silence the warnings by using Apple's CommonCrypto SHA-1 replacement
functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().

COMMON_DIGEST_FOR_OPENSSL is defined to instruct
<CommonCrypto/CommonDigest.h> to provide compatibility macros
associating OpenSSL SHA-1 functions with their CommonCrypto
counterparts.

[es: reworded commit message]

Signed-off-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index 2178c2c..7a03fe9 100644
--- a/Makefile
+++ b/Makefile
@@ -1398,10 +1398,16 @@ ifdef PPC_SHA1
 	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
 	LIB_H += ppc/sha1.h
 else
+ifdef APPLE_COMMON_CRYPTO
+	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
+	SHA1_HEADER = <CommonCrypto/CommonDigest.h>
+else
 	SHA1_HEADER = <openssl/sha.h>
 	EXTLIBS += $(LIB_4_CRYPTO)
 endif
 endif
+endif
+
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
-- 
1.8.2.3
