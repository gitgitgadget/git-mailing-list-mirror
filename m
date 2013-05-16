From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v6 1/2] cache.h: eliminate SHA-1 deprecation warnings on Mac OS X
Date: Wed, 15 May 2013 17:11:59 -0700
Message-ID: <1368663120-47102-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 02:11:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UclnJ-00088g-Nh
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 02:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738Ab3EPALh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 May 2013 20:11:37 -0400
Received: from mail-ia0-f175.google.com ([209.85.210.175]:45962 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab3EPALh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 20:11:37 -0400
Received: by mail-ia0-f175.google.com with SMTP id m10so2783250iam.20
        for <git@vger.kernel.org>; Wed, 15 May 2013 17:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=mxtyFNI6LJJvQwCrzqD49wJp68/Qmi2W9q6oSKUEzr8=;
        b=TqjD6ybXvZaKCJyaC52nFZ1nhmTd1ItvGweSs9848VZKdR659odEVkSaWn2E2gFHID
         FM9u0khbnZR+xx+Lgzik39kRrULQaJTULAWfW3L13d3MZKJKLfryO+AlQcGLztQDHkEQ
         b38pMuGAhLWkEC8JzwMHTL8c/a9IbmWilB8M4/WS2ffs6t36A7QAt6rT+j+GeZAaW//U
         lyF0c1q0kY73t0kbgdcUe7jhcsHT2yugtph/kX5cr/uSmx2YVkwWjB7n/Ksn0W97tOwN
         9+uXFA56xDNRqRf6IswuFHGjVjzaIGEq0D1GhEGgihPiKWc4kz2VXUEK16dgVeCS0ZUe
         molg==
X-Received: by 10.50.13.36 with SMTP id e4mr7244979igc.109.1368663096544;
        Wed, 15 May 2013 17:11:36 -0700 (PDT)
Received: from lustrous.local.fas.fa.disney.com (w.disneyanimation.com. [198.187.190.241])
        by mx.google.com with ESMTPSA id xf4sm361136igb.8.2013.05.15.17.11.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 May 2013 17:11:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.3.g81576a6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224459>

Mac OS X 10.8 Mountain Lion prints warnings when building git:

	warning: 'SHA1_Init' is deprecated
	(declared at /usr/include/openssl/sha.h:121)

Silence the warnings by using the CommonCrytpo SHA-1
functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().

Add a NO_COMMON_DIGEST_FOR_OPENSSL option to the Makefile to allow
users to opt out of using this library.  When defined, Git will
use OpenSSL instead.

COMMON_DIGEST_FOR_OPENSSL is defined to enable the OpenSSL
compatibility macros in CommonDigest.h.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since last time:

Name the Makefile variable after the #define for consistency.

 Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index f698c1a..b0eb949 100644
--- a/Makefile
+++ b/Makefile
@@ -137,6 +137,10 @@ all::
 # specify your own (or DarwinPort's) include directories and
 # library directories by defining CFLAGS and LDFLAGS appropriately.
 #
+# Define NO_COMMON_DIGEST_FOR_OPENSSL if you are building on Darwin/Ma=
c OS X
+# and do not want to use Apple's CommonCrypto library.  This allows yo=
u to
+# provide your own OpenSSL library, for example from MacPorts.
+#
 # Define BLK_SHA1 environment variable to make use of the bundled
 # optimized C SHA1 routine.
 #
@@ -1054,6 +1058,9 @@ ifeq ($(uname_S),Darwin)
 			BASIC_LDFLAGS +=3D -L/opt/local/lib
 		endif
 	endif
+	ifndef NO_COMMON_DIGEST_FOR_OPENSSL
+		COMMON_DIGEST_FOR_OPENSSL =3D YesPlease
+	endif
 	NO_REGEX =3D YesPlease
 	PTHREAD_LIBS =3D
 endif
@@ -1389,10 +1396,16 @@ ifdef PPC_SHA1
 	LIB_OBJS +=3D ppc/sha1.o ppc/sha1ppc.o
 	LIB_H +=3D ppc/sha1.h
 else
+ifdef COMMON_DIGEST_FOR_OPENSSL
+	BASIC_CFLAGS +=3D -DCOMMON_DIGEST_FOR_OPENSSL
+	SHA1_HEADER =3D <CommonCrypto/CommonDigest.h>
+else
 	SHA1_HEADER =3D <openssl/sha.h>
 	EXTLIBS +=3D $(LIB_4_CRYPTO)
 endif
 endif
+endif
+
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
--=20
1.8.3.rc2.3.g81576a6
