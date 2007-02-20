From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Add a compat/strtoumax.c for Solaris 8.
Date: Mon, 19 Feb 2007 16:22:56 -0800
Message-ID: <17777.1171930976@lotus.CS.Berkeley.EDU>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:26:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJIpv-0006Cb-D3
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965678AbXBTAXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965677AbXBTAXJ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:23:09 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:33710 "EHLO
	lotus.CS.Berkeley.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbXBTAW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:22:58 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id l1K0Muc6017783
	for <git@vger.kernel.org>; Mon, 19 Feb 2007 16:22:56 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id l1K0Mub4017780
	for <git@vger.kernel.org>; Mon, 19 Feb 2007 16:22:56 -0800 (PST)
X-Mailer: MH-E 8.0.3; nmh 1.1; GNU Emacs 22.0.92
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40172>

Solaris 8 was pre-c99, and they weren't willing to commit to
the strtoumax definition according to /usr/include/inttypes.h.

This adds NO_STRTOUMAX and NO_STRTOULL for ancient systems.
If NO_STRTOUMAX is defined, the routine in compat/strtoumax.c
will be used instead.  That routine passes its arguments to
strtoull unless NO_STRTOULL is defined.  If NO_STRTOULL, then
the routine uses strtoul (unsigned long).

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>
---
  I suppose the Sun libc folks were so burnt on the math additions
  that they decided not to support *any* potential C99 bits on
  Solaris 8.  sigh.  (Solaris 8 is slated to reach EOL on 2012, so
  it'll be around a while.)

  This alone won't pass tests on Solaris 8.  The next patch fixes
  fast-import.c to avoid C99 formats when necessary.

 Makefile           |   12 ++++++++++++
 compat/strtoumax.c |   10 ++++++++++
 git-compat-util.h  |    5 +++++
 3 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 compat/strtoumax.c

diff --git a/Makefile b/Makefile
index ebecbbd..5ae509f 100644
--- a/Makefile
+++ b/Makefile
@@ -28,6 +28,10 @@ all::
 #
 # Define NO_STRLCPY if you don't have strlcpy.
 #
+# Define NO_STRTOUMAX if you don't have strtoumax in the C library.
+# If your compiler also does not support long long or does not have
+# strtoull, define NO_STRTOULL.
+#
 # Define NO_SETENV if you don't have setenv in the C library.
 #
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
@@ -353,6 +357,7 @@ ifeq ($(uname_S),SunOS)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
 		NO_C99_FORMAT = YesPlease
+		NO_STRTOUMAX = YesPlease
 	endif
 	ifeq ($(uname_R),5.9)
 		NO_UNSETENV = YesPlease
@@ -517,6 +522,13 @@ ifdef NO_STRLCPY
 	COMPAT_CFLAGS += -DNO_STRLCPY
 	COMPAT_OBJS += compat/strlcpy.o
 endif
+ifdef NO_STRTOUMAX
+	COMPAT_CFLAGS += -DNO_STRTOUMAX
+	COMPAT_OBJS += compat/strtoumax.o
+endif
+ifdef NO_STRTOULL
+	COMPAT_CFLAGS += -DNO_STRTOULL
+endif
 ifdef NO_SETENV
 	COMPAT_CFLAGS += -DNO_SETENV
 	COMPAT_OBJS += compat/setenv.o
diff --git a/compat/strtoumax.c b/compat/strtoumax.c
new file mode 100644
index 0000000..f97bd08
--- /dev/null
+++ b/compat/strtoumax.c
@@ -0,0 +1,10 @@
+#include "../git-compat-util.h"
+
+uintmax_t gitstrtoumax (const char *nptr, char **endptr, int base)
+{
+#if defined(NO_STRTOULL)
+	return strtoul(nptr, endptr, base);
+#else
+	return strtoull(nptr, endptr, base);
+#endif
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 105ac28..9863cf6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -139,6 +139,11 @@ extern char *gitstrcasestr(const char *haystack, const char *needle);
 extern size_t gitstrlcpy(char *, const char *, size_t);
 #endif
 
+#ifdef NO_STRTOUMAX
+#define strtoumax gitstrtoumax
+extern uintmax_t gitstrtoumax(const char *, char **, int);
+#endif
+
 extern void release_pack_memory(size_t);
 
 static inline char* xstrdup(const char *str)
-- 
1.5.0.1.28.g7b18f
