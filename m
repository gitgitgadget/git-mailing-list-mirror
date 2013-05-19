From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v8 1/3] Makefile: add support for Apple CommonCrypto facility
Date: Sun, 19 May 2013 06:23:34 -0400
Message-ID: <1368959016-23146-2-git-send-email-sunshine@sunshineco.com>
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
	id 1Ue0n6-0004wU-FE
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 12:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885Ab3ESKY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 06:24:26 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:45952 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab3ESKYU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 06:24:20 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so12105520iet.14
        for <git@vger.kernel.org>; Sun, 19 May 2013 03:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=pG/HOlq62LndpiPO6+SL7kocfV7kojZh8/hS42+DQj0=;
        b=0lJ9phIEWrCdq82QltM9KtOOIme33O+n534Be+7tDVmT7yJHS4AFjX9oUcq9cNFuqL
         t8JKeyPAjCrVdb2nXsfJ8vqNPZ7zlnV21FAh96V91lTOy5toeqaUMbHK1282dlkfPjqy
         GM7Cx+yP/JkLnEIc9/rfoGwrZyx5wOU0umy5a4Gt8ae7+THiECai/rNbJD395uPjEgs5
         nGoM5yF/uaIvY/00TsP5A6r5grtnWE0kAOgFKeMjs8hGOGbWa6Lv7AaQyOZKJ6F6Ir2j
         hRyeEaCqUiJIdVscdFMJ66jyjtdEfniDxpeqm+u1FS0AjfGCzCSUfhH6kGnBOMjMbxYv
         Q+MQ==
X-Received: by 10.43.138.196 with SMTP id it4mr20110469icc.3.1368959059863;
        Sun, 19 May 2013 03:24:19 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id qn10sm6338918igc.6.2013.05.19.03.24.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 19 May 2013 03:24:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368959016-23146-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224835>

From: David Aguilar <davvid@gmail.com>

As of Mac OS X 10.7, Apple deprecated all OpenSSL functions due to
OpenSSL ABI instability, thus leading to build warnings.  As a
replacement, Apple encourages developers to migrate to its own (stable)
CommonCrypto facility.

Introduce boilerplate which controls whether Apple's CommonCrypto
facility is employed (enabled by default).  Also add a
NO_APPLE_COMMON_CRYPTO build flag with which the user can opt out to
use OpenSSL instead.

[es: extracted CommonCrypto-related Makefile boilerplate into separate
introductory patch]

Signed-off-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index f698c1a..cd24c94 100644
--- a/Makefile
+++ b/Makefile
@@ -137,6 +137,10 @@ all::
 # specify your own (or DarwinPort's) include directories and
 # library directories by defining CFLAGS and LDFLAGS appropriately.
 #
+# Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac OS X
+# and do not want to use Apple's CommonCrypto library.  This allows you
+# to provide your own OpenSSL library, for example from MacPorts.
+#
 # Define BLK_SHA1 environment variable to make use of the bundled
 # optimized C SHA1 routine.
 #
@@ -1054,6 +1058,10 @@ ifeq ($(uname_S),Darwin)
 			BASIC_LDFLAGS += -L/opt/local/lib
 		endif
 	endif
+	ifndef NO_APPLE_COMMON_CRYPTO
+		APPLE_COMMON_CRYPTO = YesPlease
+		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
+	endif
 	NO_REGEX = YesPlease
 	PTHREAD_LIBS =
 endif
-- 
1.8.2.3
