From: Reuben Hawkins <reubenhwk@gmail.com>
Subject: [PATCH 3/3] configure.ac: check for HMAC_CTX_cleanup
Date: Wed,  7 Jan 2015 12:23:56 -0800
Message-ID: <1420662236-27593-4-git-send-email-reubenhwk@gmail.com>
References: <CAPig+cSFAzsUj2sOaCyPTu_U8_c5qkF1qQo4nzecVzY0TqmJpg@mail.gmail.com>
 <1420662236-27593-1-git-send-email-reubenhwk@gmail.com>
Cc: Reuben Hawkins <reubenhwk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 21:25:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8x9o-0003y8-0z
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 21:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121AbbAGUYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 15:24:34 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36984 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbbAGUYc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 15:24:32 -0500
Received: by mail-pa0-f46.google.com with SMTP id lf10so7044192pab.5
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 12:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B8kD+ncT912xC4mLBnKdCn6jaMHdFvltQhEfwju4haw=;
        b=zqjtT79yz+eEMGZpWxqF0vneKnpcPjeWXn4j/JSLfYuj6KXJY3cTdZwlzGpdkeF6JX
         c9/kmnNRE5LjrIAjvWvvRWcG+fPH1WU+SuhWAs7j4euBOQf3EHS52i1fVLhocPGW7uKT
         hp/x2vkd8uqvXfeae4k36B81fBpJkYYqRNUmtzSW5rLimgfcf2Pp9yhShOlwf+DfPYd7
         RUqqBJQ2mhOm6e/oxI8THIgCx4KhB5GFER1b9Xf+2GA4yuUsAcIw0QXY1b1KT4u8vxm8
         J7PQsaHkJViHfhLOgL5LCuZeDjQEdFStdljFq3MALvIanUrgrZ2DPf2myKo00vS31frE
         RIIw==
X-Received: by 10.68.57.144 with SMTP id i16mr8702318pbq.86.1420662271544;
        Wed, 07 Jan 2015 12:24:31 -0800 (PST)
Received: from zoidberg.san.rr.com (cpe-76-88-40-245.san.res.rr.com. [76.88.40.245])
        by mx.google.com with ESMTPSA id j15sm2585869pdk.49.2015.01.07.12.24.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Jan 2015 12:24:30 -0800 (PST)
X-Mailer: git-send-email 2.2.0.68.g8f72f0c.dirty
In-Reply-To: <1420662236-27593-1-git-send-email-reubenhwk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262154>

OpenSSL version 0.9.6b and before defined the function HMAC_cleanup.
Newer versions define HMAC_CTX_cleanup.  Check for HMAC_CTX_cleanup and
fall back to HMAC_cleanup when the newer function is missing.
---
 Makefile          | 3 +++
 configure.ac      | 7 +++++++
 git-compat-util.h | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index af551a0..d3c2b58 100644
--- a/Makefile
+++ b/Makefile
@@ -1059,6 +1059,9 @@ ifndef NO_OPENSSL
 	ifdef NEEDS_CRYPTO_WITH_SSL
 		OPENSSL_LIBSSL += -lcrypto
 	endif
+	ifdef NO_HMAC_CTX_CLEANUP
+		BASIC_CFLAGS += -DNO_HMAC_CTX_CLEANUP
+	endif
 else
 	BASIC_CFLAGS += -DNO_OPENSSL
 	BLK_SHA1 = 1
diff --git a/configure.ac b/configure.ac
index 424dec5..c282663 100644
--- a/configure.ac
+++ b/configure.ac
@@ -923,6 +923,13 @@ AC_CHECK_LIB([iconv], [locale_charset],
                      [CHARSET_LIB=-lcharset])])
 GIT_CONF_SUBST([CHARSET_LIB])
 #
+# Define NO_HMAC_CTX_CLEANUP=YesPlease if HMAC_CTX_cleanup is missing.
+AC_CHECK_LIB([crypto], [HMAC_CTX_cleanup],
+	[NO_HMAC_CTX_CLEANUP=],
+	[NO_HMAC_CTX_CLEANUP=YesPlease],
+	[])
+GIT_CONF_SUBST([NO_HMAC_CTX_CLEANUP])
+#
 # Define HAVE_CLOCK_GETTIME=YesPlease if clock_gettime is available.
 GIT_CHECK_FUNC(clock_gettime,
 [HAVE_CLOCK_GETTIME=YesPlease],
diff --git a/git-compat-util.h b/git-compat-util.h
index 400e921..2fdca2d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -213,6 +213,9 @@ extern char *gitbasename(char *);
 #ifndef NO_OPENSSL
 #include <openssl/ssl.h>
 #include <openssl/err.h>
+#ifdef NO_HMAC_CTX_CLEANUP
+#define HMAC_CTX_cleanup HMAC_cleanup
+#endif
 #endif
 
 /* On most systems <netdb.h> would have given us this, but
-- 
2.2.0.68.g8f72f0c.dirty
