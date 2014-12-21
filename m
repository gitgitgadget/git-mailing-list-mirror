From: Reuben Hawkins <reubenhwk@gmail.com>
Subject: [PATCH 3/3] configure.ac,imap-send.c: check HMAC_CTX_cleanup
Date: Sun, 21 Dec 2014 10:53:36 -0800
Message-ID: <1419188016-26134-3-git-send-email-reubenhwk@gmail.com>
References: <1419188016-26134-1-git-send-email-reubenhwk@gmail.com>
Cc: Reuben Hawkins <reubenhwk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 21 19:54:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2ldz-0001mW-01
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 19:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbaLUSyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 13:54:16 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:42501 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbaLUSyP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 13:54:15 -0500
Received: by mail-pa0-f51.google.com with SMTP id ey11so4508632pad.38
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 10:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FGPHr5ry4P92A6Zgi7d5wGuXWdYj7GTpY+tpPNg8Cws=;
        b=UwfIu3rOCwfIEohWzMWGp/3Mz16VkcpR8pNlPeqoWnxnpXrwpMzd66xaKH0kR4Ihc+
         pti53sMeUCriOLnlq5AEjE+MpzaAE5pOjNlxptwQ29RObk9DwfWLuStYkgZ8R6tXstiA
         U44+m9igzt3gEXIihxoJZipPoWGw+z0sxIJesONNNYAU+eZHqbPIOJT55qr23pLZcndY
         i7wNdN97b+VhO6aGAUj/NjqGO4iBRMj5P175YY1V5LIZMMVZunqYwPsem3ZF+7V9sv4b
         z+OXxPg3yWmlfcAdqoZiFajwtJGnb+f4O6K2UEl/5P4yP3HPRc3mEIXhEw1SMdCkuHiQ
         ctuw==
X-Received: by 10.67.3.100 with SMTP id bv4mr9838223pad.15.1419188054325;
        Sun, 21 Dec 2014 10:54:14 -0800 (PST)
Received: from zoidberg.san.rr.com (cpe-76-88-40-245.san.res.rr.com. [76.88.40.245])
        by mx.google.com with ESMTPSA id cm10sm15263211pad.46.2014.12.21.10.54.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Dec 2014 10:54:13 -0800 (PST)
X-Mailer: git-send-email 2.2.0.GIT
In-Reply-To: <1419188016-26134-1-git-send-email-reubenhwk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261620>

Older versions of OpenSSL have HMAC_cleanup, but not HMAC_CTX_cleanup.
This change checks for both, uses HMAC_CTX_cleanup on platforms which
have it, otherwise falls back to HMAC_cleanup.

This changes makes building GIT on older platforms less tedious.
---
 Makefile     |  6 ++++++
 configure.ac | 13 +++++++++++++
 imap-send.c  |  6 ++++++
 3 files changed, 25 insertions(+)

diff --git a/Makefile b/Makefile
index 7482a4d..a495d94 100644
--- a/Makefile
+++ b/Makefile
@@ -1059,6 +1059,12 @@ ifndef NO_OPENSSL
 	ifdef NEEDS_CRYPTO_WITH_SSL
 		OPENSSL_LIBSSL += -lcrypto
 	endif
+	ifdef HAVE_HMAC_CTX_CLEANUP
+		BASIC_CFLAGS += -DHAVE_HMAC_CTX_CLEANUP
+	endif
+	ifdef HAVE_HMAC_CLEANUP
+		BASIC_CFLAGS += -DHAVE_HMAC_CLEANUP
+	endif
 else
 	BASIC_CFLAGS += -DNO_OPENSSL
 	BLK_SHA1 = 1
diff --git a/configure.ac b/configure.ac
index 3900044..b22788c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -899,6 +899,7 @@ GIT_CONF_SUBST([SNPRINTF_RETURNS_BOGUS])
 ## Checks for library functions.
 ## (in default C library and libraries checked by AC_CHECK_LIB)
 AC_MSG_NOTICE([CHECKS for library functions])
+
 #
 # Define NO_LIBGEN_H if you don't have libgen.h.
 AC_CHECK_HEADER([libgen.h],
@@ -932,6 +933,18 @@ AC_CHECK_LIB([iconv], [locale_charset],
                      [CHARSET_LIB=-lcharset])])
 GIT_CONF_SUBST([CHARSET_LIB])
 #
+# Define HAVE_HMAC_CTX_CLEANUP=Yes if we have the newer HMAC cleanup function
+AC_CHECK_LIB([crypto], [HMAC_CTX_cleanup],
+	[HAVE_HMAC_CTX_CLEANUP=Yes],
+	[], [])
+GIT_CONF_SUBST([HAVE_HMAC_CTX_CLEANUP])
+#
+# Define HAVE_HMAC_CLEANUP=Yes if we have the older HMAC cleanup function
+AC_CHECK_LIB([crypto], [HMAC_cleanup],
+	[HAVE_HMAC_CLEANUP=Yes],
+	[], [])
+GIT_CONF_SUBST([HAVE_HMAC_CLEANUP])
+#
 # Define NO_CLOCK_GETTIME if you don't have clock_gettime.
 GIT_CHECK_FUNC(clock_gettime,
 [HAVE_CLOCK_GETTIME=Yes],
diff --git a/imap-send.c b/imap-send.c
index 70bcc7a..eec2378 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -861,7 +861,13 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	HMAC_Init(&hmac, (unsigned char *)pass, strlen(pass), EVP_md5());
 	HMAC_Update(&hmac, (unsigned char *)challenge, decoded_len);
 	HMAC_Final(&hmac, hash, NULL);
+#if defined(HAVE_HMAC_CTX_CLEANUP)
 	HMAC_CTX_cleanup(&hmac);
+#elif defined(HAVE_HMAC_CLEANUP)
+	HMAC_cleanup(&hmac);
+#else
+# error "no HMAC_cleanup function"
+#endif
 
 	hex[32] = 0;
 	for (i = 0; i < 16; i++) {
-- 
2.2.0.GIT
