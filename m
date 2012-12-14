From: David Michael <fedora.dm0@gmail.com>
Subject: [PATCH 3/4] Generalize the inclusion of strings.h
Date: Fri, 14 Dec 2012 14:57:01 -0500
Message-ID: <CAEvUa7mnxWL0SHyEq0jefkxSZWYB-VWG6XoTYrdqP62bOWfamQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 20:57:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjbNu-0006fe-A7
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 20:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268Ab2LNT5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 14:57:07 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60483 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146Ab2LNT5C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 14:57:02 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so4499202vby.19
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 11:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=Y639E2H4lfhquQ5z0Oo7pQ0UXSxAhr/oKQQt+8VJR+U=;
        b=JXctuaOkmpEfUrpwpcQe2A3eWDrYNxsXlXM44uNdgecihwx+8bQcDiiuh/NN0QCbIQ
         Qvr3wv46fZp/eAlfmnTs0M/KHFOg01xL3b7Z27CQW9Irx0plfjxomYBEdwWrz4bMhntQ
         Nggf7EJm8sXf5mxnh5hDSj4h4+EyH/5yMxV3mOtppBLJFt23KOrFDBZPm3LQJr3A5eS7
         LVVwWkHtEVcNrxeQVlwEPkgpqgyff5fb2nsNzL1Wv8HV5b90pYH8DOrpqIwgLfEQmdlo
         ayHM/Lye+bWM4+cclRflDQm7WzOdtoyzJv80QMR8wG9kOrP89t8gL7LNWpGcSPJXPqT+
         KZow==
Received: by 10.220.153.212 with SMTP id l20mr11034510vcw.1.1355515021945;
 Fri, 14 Dec 2012 11:57:01 -0800 (PST)
Received: by 10.58.85.138 with HTTP; Fri, 14 Dec 2012 11:57:01 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211502>

The header strings.h was formerly only included for a particular platform to
define strcasecmp, but another platform requiring this inclusion has been
found.  The build system will now include the file based on its presence
determined by configure.

Signed-off-by: David Michael <fedora.dm0@gmail.com>
---
 Makefile          | 6 ++++++
 configure.ac      | 6 ++++++
 git-compat-util.h | 2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 735a834..fb78f7f 100644
--- a/Makefile
+++ b/Makefile
@@ -74,6 +74,8 @@ all::
 # Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
 # d_type in struct dirent (Cygwin 1.5, fixed in Cygwin 1.7).
 #
+# Define HAVE_STRINGS_H if you have strings.h and need it for strcasecmp.
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 #
 # Define NO_MEMMEM if you don't have memmem.
@@ -1892,6 +1894,10 @@ ifdef HAVE_LIBCHARSET_H
     EXTLIBS += $(CHARSET_LIB)
 endif

+ifdef HAVE_STRINGS_H
+    BASIC_CFLAGS += -DHAVE_STRINGS_H
+endif
+
 ifdef HAVE_DEV_TTY
     BASIC_CFLAGS += -DHAVE_DEV_TTY
 endif
diff --git a/configure.ac b/configure.ac
index 3347c17..4176db8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -886,6 +886,12 @@ AC_CHECK_HEADER([libcharset.h],
 [HAVE_LIBCHARSET_H=YesPlease],
 [HAVE_LIBCHARSET_H=])
 GIT_CONF_SUBST([HAVE_LIBCHARSET_H])
+#
+# Define HAVE_STRINGS_H if you have strings.h
+AC_CHECK_HEADER([strings.h],
+[HAVE_STRINGS_H=YesPlease],
+[HAVE_STRINGS_H=])
+GIT_CONF_SUBST([HAVE_STRINGS_H])
 # Define CHARSET_LIB if libiconv does not export the locale_charset symbol
 # and libcharset does
 CHARSET_LIB=
diff --git a/git-compat-util.h b/git-compat-util.h
index ace1549..d7359ef 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -99,7 +99,7 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
-#ifdef __TANDEM /* or HAVE_STRINGS_H or !NO_STRINGS_H? */
+#ifdef HAVE_STRINGS_H
 #include <strings.h> /* for strcasecmp() */
 #endif
 #include <errno.h>
--
1.7.11.7
