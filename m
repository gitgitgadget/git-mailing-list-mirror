From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v7 2/3] compat: add a basename() compatibility function
Date: Sun, 31 May 2009 01:35:51 -0700
Message-ID: <1243758952-28972-2-git-send-email-davvid@gmail.com>
References: <1243758952-28972-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net, markus.heidelberg@web.de,
	jnareb@gmail.com, j.sixt@viscovery.net,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun May 31 10:37:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAgYF-0001sf-0n
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 10:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756790AbZEaIf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 04:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756745AbZEaIf5
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 04:35:57 -0400
Received: from mail-px0-f191.google.com ([209.85.216.191]:37579 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbZEaIfy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 04:35:54 -0400
Received: by pxi29 with SMTP id 29so2235058pxi.33
        for <git@vger.kernel.org>; Sun, 31 May 2009 01:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oQ2Oabs35fNrB9l6bQ4OC4lRIEFKb5Hi7nABuUOG1Ng=;
        b=FguITRercs5Tr/dkOS6FXvTJq+0rSPr4F7quoilXiwXjwwFusRI8WLYICr/xenxEgm
         3vEE9wHRdmaSxt4L+8ebFWAjoqvvsNFrEbALrLjxkSzgs0Ys/dAsLZDIrsTVrp7sb+Ew
         wupCSBlR+a/XK5X6qGC0lqYVtx9ZLwSNywixo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WI0xx6O80WkkoRNVE73QPcWZKpqoqN+z5EL9c0K76ACA1l/AhUpBBC5UkyF/KgmNnp
         Cgny49GOSdbeEJdyERfEf1J2QamI/e1x7zJM/czwkbVapxm/AuQh+DtNYCp4z9fY05CR
         rjQRsaCfYBu4wow2AVd5cGM8mgWJKkN9TOX4c=
Received: by 10.141.201.1 with SMTP id d1mr4282965rvq.230.1243758955788;
        Sun, 31 May 2009 01:35:55 -0700 (PDT)
Received: from localhost (cpe-76-87-90-126.socal.res.rr.com [76.87.90.126])
        by mx.google.com with ESMTPS id m6sm4294954wag.49.2009.05.31.01.35.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 01:35:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1243758952-28972-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120389>

Some systems such as Windows lack libgen.h so provide a
basename() implementation for cross-platform use.

This introduces the NO_LIBGEN_H construct to the Makefile
and autoconf scripts.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Makefile          |    8 ++++++++
 compat/basename.c |   15 +++++++++++++++
 config.mak.in     |    1 +
 configure.ac      |    6 ++++++
 git-compat-util.h |    7 +++++++
 5 files changed, 37 insertions(+), 0 deletions(-)
 create mode 100644 compat/basename.c

diff --git a/Makefile b/Makefile
index a70b5f0..a59f106 100644
--- a/Makefile
+++ b/Makefile
@@ -54,6 +54,8 @@ all::
 #
 # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
 #
+# Define NO_LIBGEN_H if you don't have libgen.h.
+#
 # Define NO_SYS_SELECT_H if you don't have sys/select.h.
 #
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
@@ -834,6 +836,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_PREAD = YesPlease
 	NO_OPENSSL = YesPlease
 	NO_CURL = YesPlease
+	NO_LIBGEN_H = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
 	NO_SETENV = YesPlease
@@ -899,6 +902,11 @@ ifndef CC_LD_DYNPATH
 	endif
 endif
 
+ifdef NO_LIBGEN_H
+	COMPAT_CFLAGS += -DNO_LIBGEN_H
+	COMPAT_OBJS += compat/basename.o
+endif
+
 ifdef NO_CURL
 	BASIC_CFLAGS += -DNO_CURL
 else
diff --git a/compat/basename.c b/compat/basename.c
new file mode 100644
index 0000000..d8f8a3c
--- /dev/null
+++ b/compat/basename.c
@@ -0,0 +1,15 @@
+#include "../git-compat-util.h"
+
+/* Adapted from libiberty's basename.c.  */
+char *gitbasename (char *path)
+{
+	const char *base;
+	/* Skip over the disk name in MSDOS pathnames. */
+	if (has_dos_drive_prefix(path))
+		path += 2;
+	for (base = path; *path; path++) {
+		if (is_dir_sep(*path))
+			base = path + 1;
+	}
+	return (char *)base;
+}
diff --git a/config.mak.in b/config.mak.in
index b6619af..e8d96e8 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -30,6 +30,7 @@ NEEDS_SSL_WITH_CRYPTO=@NEEDS_SSL_WITH_CRYPTO@
 NO_OPENSSL=@NO_OPENSSL@
 NO_CURL=@NO_CURL@
 NO_EXPAT=@NO_EXPAT@
+NO_LIBGEN_H=@NO_LIBGEN_H@
 NEEDS_LIBICONV=@NEEDS_LIBICONV@
 NEEDS_SOCKET=@NEEDS_SOCKET@
 NO_SYS_SELECT_H=@NO_SYS_SELECT_H@
diff --git a/configure.ac b/configure.ac
index 953da07..108a97f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -627,6 +627,12 @@ AC_SUBST(SNPRINTF_RETURNS_BOGUS)
 ## (in default C library and libraries checked by AC_CHECK_LIB)
 AC_MSG_NOTICE([CHECKS for library functions])
 #
+# Define NO_LIBGEN_H if you don't have libgen.h.
+AC_CHECK_HEADER([libgen.h],
+[NO_LIBGEN_H=],
+[NO_LIBGEN_H=YesPlease])
+AC_SUBST(NO_LIBGEN_H)
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=],
diff --git a/git-compat-util.h b/git-compat-util.h
index 5a2d4e7..d248047 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -97,6 +97,13 @@
 #include "compat/mingw.h"
 #endif	/* __MINGW32__ */
 
+#ifndef NO_LIBGEN_H
+#include <libgen.h>
+#else
+#define basename gitbasename
+extern char *gitbasename(char *);
+#endif
+
 #ifndef NO_ICONV
 #include <iconv.h>
 #endif
-- 
1.6.1.3
