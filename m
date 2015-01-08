From: Reuben Hawkins <reubenhwk@gmail.com>
Subject: [PATCH 3/3] configure.ac: check for HMAC_CTX_cleanup
Date: Thu,  8 Jan 2015 12:00:57 -0800
Message-ID: <1420747257-16132-3-git-send-email-reubenhwk@gmail.com>
References: <1420747257-16132-1-git-send-email-reubenhwk@gmail.com>
Cc: Reuben Hawkins <reubenhwk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 21:02:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9JHN-0001oe-AK
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 21:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbbAHUBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 15:01:42 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:42936 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355AbbAHUBb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 15:01:31 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so13707221pac.8
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 12:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/C1hH32By9J/rxZcfWvJTUUwHSCxYJKg3WnnOkml5CA=;
        b=HNpw9ejzj64Jv8cvUTFEJGdq6zbvyHlvaPDeFt5qyn204BW8ZmUrsOVErsh9oZ2RlB
         UDwgvuinafn+mvXIupdlXf+XxONS9akBQ58DEQ7PS7yKjCLr2mCoHkZjQIqrhggd/sDO
         0MtF3QKcoMpUzl87RUzKEgCjchb5Tw7G8kIChLnfVkOryo0/OAShTetBkEdoynsOJhHY
         XYu/K1twxzQd+JKhYXOKJPaEkN9a/wDviJ1OJv/t3Z+EDZRzawZWtYc/TI07SCFX34h9
         QV4UvyYgWP+/PlFy1p439Ko1lq8oju/5S+S2buCg4di0SJvg3A4Ic9D6c8R+U5bGRTHB
         Jl6g==
X-Received: by 10.66.65.165 with SMTP id y5mr17713723pas.146.1420747290403;
        Thu, 08 Jan 2015 12:01:30 -0800 (PST)
Received: from zoidberg.san.rr.com (cpe-76-88-40-245.san.res.rr.com. [76.88.40.245])
        by mx.google.com with ESMTPSA id do3sm5248879pac.48.2015.01.08.12.01.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jan 2015 12:01:29 -0800 (PST)
X-Mailer: git-send-email 2.2.0.68.g8f72f0c.dirty
In-Reply-To: <1420747257-16132-1-git-send-email-reubenhwk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262216>

OpenSSL version 0.9.6b and before defined the function HMAC_cleanup.
Newer versions define HMAC_CTX_cleanup.  Check for HMAC_CTX_cleanup and
fall back to HMAC_cleanup when the newer function is missing.

Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>
---
 Makefile          | 6 ++++++
 configure.ac      | 4 ++++
 git-compat-util.h | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index 57e33f2..2ce1f1f 100644
--- a/Makefile
+++ b/Makefile
@@ -341,6 +341,9 @@ all::
 # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime in librt.
 #
 # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC in librt.
+#
+# Define NO_HMAC_CTX_CLEANUP if your OpenSSL is version 0.9.6b or earlier to
+# cleanup the HMAC context with the older HMAC_cleanup function.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1061,6 +1064,9 @@ ifndef NO_OPENSSL
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
index c3293b9..9c66c3e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -924,6 +924,10 @@ AC_CHECK_LIB([iconv], [locale_charset],
                      [CHARSET_LIB=-lcharset])])
 GIT_CONF_SUBST([CHARSET_LIB])
 #
+# Define NO_HMAC_CTX_CLEANUP=YesPlease if HMAC_CTX_cleanup is missing.
+AC_CHECK_LIB([crypto], [HMAC_CTX_cleanup],
+	[], [GIT_CONF_SUBST([NO_HMAC_CTX_CLEANUP], [YesPlease])])
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
