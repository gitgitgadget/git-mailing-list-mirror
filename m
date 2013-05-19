From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v8 2/3] cache.h: eliminate SHA-1 deprecation warnings on Mac OS X
Date: Sun, 19 May 2013 06:23:35 -0400
Message-ID: <1368959016-23146-3-git-send-email-sunshine@sunshineco.com>
References: <1368959016-23146-1-git-send-email-sunshine@sunshineco.com>
Cc: David Aguilar <davvid@gmail.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 19 12:24:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue0n7-0004wU-0D
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 12:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab3ESKY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 06:24:27 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:48642 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab3ESKYW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 06:24:22 -0400
Received: by mail-ia0-f177.google.com with SMTP id z13so6193887iaz.8
        for <git@vger.kernel.org>; Sun, 19 May 2013 03:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=P5bsNhjAdZ8Lkyisa9lEnnEb25siVZXiSJTgTc/cUQk=;
        b=c5Rm9rJr9USz1Dnii3l4rVcYAC+8cAtJZko4Y/qGzp2/p4xQMF+scjeCv/sYalVHJ4
         oJSSf4+JZQMNqftem5PndQ8Zj2ivkQ7j9YWJc4CW6Ke2nKwkya0Glhf9VGk6YaEY/HAt
         r+yfItVZXCOiWdGFPsmT8FBpa615pxksERmxMDfnZPa4g+nAWCwSHhGjbwLr63VSfVyK
         9uk/tBWog6IP/gAoR1JBBE6fM7jcuydl0cPtwFau8s+/vxdr/wqsX/SDyhjB4d49eZQg
         ee1ZjHbMm5jYCiZIOXreKNgzySRdaEs4xMvphCvUxsWZOsLMNjDB4b3sBuJuSslFVuC/
         LbNw==
X-Received: by 10.50.51.167 with SMTP id l7mr2737065igo.11.1368959062269;
        Sun, 19 May 2013 03:24:22 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id qn10sm6338918igc.6.2013.05.19.03.24.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 19 May 2013 03:24:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368959016-23146-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224834>

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
index cd24c94..5e7cadf 100644
--- a/Makefile
+++ b/Makefile
@@ -1397,10 +1397,16 @@ ifdef PPC_SHA1
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
