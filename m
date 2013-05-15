From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v5 1/2] cache.h: eliminate SHA-1 deprecation warnings on Mac OS X
Date: Wed, 15 May 2013 00:11:07 -0700
Message-ID: <1368601868-42410-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 09:11:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcVro-0006JL-VP
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 09:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646Ab3EOHLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 03:11:00 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:39895 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab3EOHLA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 03:11:00 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so1230470pab.41
        for <git@vger.kernel.org>; Wed, 15 May 2013 00:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=dEnvB0+ZVRw6/vG7cCuPoCA8jNZyOYhNsCFHt5Srjis=;
        b=Ab94mXswNr5hwfNUfu/gevSV1vnTHInijlnkP8ppO4R6zygDi/Gc7gWCkKpvB+Ysgu
         WzTxlKWK9eBV3fme3QAp8+A7bPPUwNPYt53hQdAMuOBMgtpSV4Yu3RAiJdC/Kt783hPh
         iuz8F/s7dCaaEfTZ/eP9pThLcBL0KZc+t6CxBYWGXnk5vOAsBPYK7nw2nEcbgffG/a/e
         KHUuqz3xxNO0wXCitb9hAYeUnEqdfZaFzMzfzMsjJVugCJJZbz2zwlecK+Lxomi4hAYF
         KhpCp+T+UPXrapj6NP/V30945KCGQHn0i0awy9g0TnrcjI190xFf6OphF4kng3DgaCs4
         3jnQ==
X-Received: by 10.66.232.97 with SMTP id tn1mr37796432pac.20.1368601859558;
        Wed, 15 May 2013 00:10:59 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id w8sm1732608pbo.9.2013.05.15.00.10.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 May 2013 00:10:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.2.gbc955d1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224388>

Mac OS X 10.8 Mountain Lion prints warnings when building git:

	warning: 'SHA1_Init' is deprecated
	(declared at /usr/include/openssl/sha.h:121)

Silence the warnings by using the CommonCrytpo SHA-1
functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().

COMMON_DIGEST_FOR_OPENSSL is defined to enable the OpenSSL
compatibility macros in CommonDigest.h.

Add a NO_APPLE_COMMON_CRYPTO option to the Makefile to allow
users to opt out of using this library.  When defined, Git will
use OpenSSL instead.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Both of these are replacement patches "pu".

Changes from last time:

It now uses a single APPLE_COMMON_CRYPTO definition.
Users can now opt-out by setting NO_APPLE_COMMON_CRYPTO.

 Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index f698c1a..8309c41 100644
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
@@ -1054,6 +1058,9 @@ ifeq ($(uname_S),Darwin)
 			BASIC_LDFLAGS += -L/opt/local/lib
 		endif
 	endif
+	ifndef NO_APPLE_COMMON_CRYPTO
+		APPLE_COMMON_CRYPTO = YesPlease
+	endif
 	NO_REGEX = YesPlease
 	PTHREAD_LIBS =
 endif
@@ -1389,10 +1396,16 @@ ifdef PPC_SHA1
 	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
 	LIB_H += ppc/sha1.h
 else
+ifdef APPLE_COMMON_CRYPTO
+	BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
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
1.8.3.rc2.2.gbc955d1
