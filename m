From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v7 1/3] Makefile: add support for Apple CommonCrypto facility
Date: Fri, 17 May 2013 20:32:36 -0400
Message-ID: <1368837158-13915-2-git-send-email-sunshine@sunshineco.com>
References: <1368837158-13915-1-git-send-email-sunshine@sunshineco.com>
Cc: David Aguilar <davvid@gmail.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 02:33:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdV5Y-0006ac-QF
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 02:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125Ab3ERAdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 20:33:24 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:55390 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457Ab3ERAdX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 20:33:23 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so10633502iej.2
        for <git@vger.kernel.org>; Fri, 17 May 2013 17:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=j+LZyKANvXx2kWC4PW1YuWNq2b0be+I7pgQBFdET3TY=;
        b=iFgjzXMrVtSECufMRmZwOjNyBapJOZWd4SrhlPqeI4p7WVx0socD/+POS94xXJ9b5A
         si7dPe+0Lw4KrpW5gSmTIgLQQtv7GCYRGZWaPkv7WQmKmK0R0DgDNZVdAvGz+dFTPwW8
         /qf2UjZf/SeSaLfc5QXj+/btvpMqf558XXaPJP0njC1tSPTVX35KroNi/62kaUaTFYWp
         zF20pZCpleRIB87I60pPBhgFIKQ8YwWc4FpPzJmF1OcJaCc4/VnYzigHMQmWZ9fnYsc0
         2O8wqv1fBdRMYAGkNDrZmgzXJXkT+fU2nUfDyJjog9oPa8xiOy8g5zI944HPCYVfZSvH
         ip7A==
X-Received: by 10.50.97.69 with SMTP id dy5mr2842igb.3.1368837202999;
        Fri, 17 May 2013 17:33:22 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ua6sm9203igb.0.2013.05.17.17.33.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 17:33:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368837158-13915-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224743>

From: David Aguilar <davvid@gmail.com>

As of Mac OS X 10.7, Apple deprecated all OpenSSL functions due to
OpenSSL ABI instability, thus leading to build warnings.  As a
replacement, Apple encourages developers to migrate to its own (stable)
CommonCrypto facility.

Introduce boilerplate which controls whether Apple's CommonCrypto
facility is employed (enabled by default).  Also add a
NO_APPLE_COMMON_CRYPTO flag which the user can tweak to override the
default if OpenSSL is instead preferred.

[es: extracted CommonCrypto-related Makefile boilerplate into separate
introductory patch]

Signed-off-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index f698c1a..2178c2c 100644
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
@@ -1054,6 +1058,11 @@ ifeq ($(uname_S),Darwin)
 			BASIC_LDFLAGS += -L/opt/local/lib
 		endif
 	endif
+	ifndef NO_APPLE_COMMON_CRYPTO
+		APPLE_COMMON_CRYPTO = YesPlease
+	else
+		COMPAT_CFLAGS += -DNO_APPLE_COMMON_CRYPTO
+	endif
 	NO_REGEX = YesPlease
 	PTHREAD_LIBS =
 endif
-- 
1.8.2.3
