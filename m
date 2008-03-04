From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on maxsize reached
Date: Tue, 4 Mar 2008 14:59:28 +0100
Organization: NextSoft
Message-ID: <200803041459.29000.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 15:00:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWXgm-0000dQ-SY
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 15:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbYCDN7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 08:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbYCDN7i
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 08:59:38 -0500
Received: from holub.nextsoft.cz ([195.122.198.235]:50939 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbYCDN7i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 08:59:38 -0500
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id 7205A8E4; Tue,  4 Mar 2008 14:59:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 1C40C8E2
	for <git@vger.kernel.org>; Tue,  4 Mar 2008 14:59:33 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10826-03 for <git@vger.kernel.org>;
	Tue, 4 Mar 2008 14:59:33 +0100 (CET)
Received: from 89-24-113-79.i4g.tmcz.cz (89-24-113-79.i4g.tmcz.cz [89.24.113.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id B981261C
	for <git@vger.kernel.org>; Tue,  4 Mar 2008 14:59:32 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76085>

This PATCH is NOT intended to be merged (yet).

Some systems (namely HPUX) return -1 when maxsize in vsnprintf() is reached. 
So replace that broken vsnprintf() with our own that returns correct value 
upon overflow.

Could anybody give it some testing since I don't know how many broken systems 
are out there?

If anybody could think of some better define than BROKEN_VSNPRINTF, I'm all 
ears.

Linux is OK, HPUX is detected to be broken. On HPUX (11.23) test suite with 
defined BROKEN_VSNPRINTF fails in 8 *.sh testsuites, without it it fails in 
140 *.sh testsuites (out of 241).

Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>

diff --git a/Makefile b/Makefile
index ca5aad9..a1dbf1d 100644
--- a/Makefile
+++ b/Makefile
@@ -3,6 +3,10 @@ all::
 
 # Define V=1 to have a more verbose compile.
 #
+# Define BROKEN_VSNPRINTF if your are on a system which vsnprintf() return
+# something else (typically -1) instead of number of characters which would
+# have been written to the final string if enough space had been available.
+#
 # Define FREAD_READS_DIRECTORIES if your are on a system which succeeds
 # when attempting to read from an fopen'ed directory.
 #
@@ -526,6 +530,7 @@ ifeq ($(uname_S),HP-UX)
 	NO_UNSETENV = YesPlease
 	NO_HSTRERROR = YesPlease
 	NO_SYS_SELECT_H = YesPlease
+	BROKEN_VSNPRINTF = UnfortunatelyYes
 endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
@@ -629,6 +634,10 @@ endif
 ifdef NO_C99_FORMAT
 	BASIC_CFLAGS += -DNO_C99_FORMAT
 endif
+ifdef BROKEN_VSNPRINTF
+	COMPAT_CFLAGS += -DBROKEN_VSNPRINTF
+	COMPAT_OBJS += compat/vsnprintf.o
+endif
 ifdef FREAD_READS_DIRECTORIES
 	COMPAT_CFLAGS += -DFREAD_READS_DIRECTORIES
 	COMPAT_OBJS += compat/fopen.o
diff --git a/config.mak.in b/config.mak.in
index ee6c33d..aaa98c6 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -46,3 +46,4 @@ NO_MKDTEMP=@NO_MKDTEMP@
 NO_ICONV=@NO_ICONV@
 OLD_ICONV=@OLD_ICONV@
 NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
+BROKEN_VSNPRINTF=@BROKEN_VSNPRINTF@
diff --git a/configure.ac b/configure.ac
index 85d7ef5..d4bb2b3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -326,6 +326,37 @@ else
 	NO_C99_FORMAT=
 fi
 AC_SUBST(NO_C99_FORMAT)
+#
+# Define BROKEN_VSNPRINTF if your are on a system which vsnprintf() return
+# something else (typically -1) instead of number of characters which would
+# have been written to the final string if enough space had been available.
+AC_CACHE_CHECK([whether vsnprintf() is broken],
+ [ac_cv_broken_vsnprintf],
+[
+AC_RUN_IFELSE(
+	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT
+		#include "stdarg.h"
+
+		int test_vsnprintf(char *str, size_t maxsize, const char *format, ...)
+		{
+		  int ret;
+		  va_list ap;
+		  va_start(ap, format);
+		  ret = vsnprintf(str, maxsize, format, ap);
+		  va_end(ap);
+                  return ret;
+		}],
+		[[char buf[1];
+		  if (test_vsnprintf(buf, 1, "%s", "12345") != 5) return 1]])],
+	[ac_cv_broken_vsnprintf=no],
+	[ac_cv_broken_vsnprintf=yes])
+])
+if test $ac_cv_broken_vsnprintf = yes; then
+	BROKEN_VSNPRINTF=UnfortunatelyYes
+else
+	BROKEN_VSNPRINTF=
+fi
+AC_SUBST(BROKEN_VSNPRINTF)
 
 
 ## Checks for library functions.
diff --git a/git-compat-util.h b/git-compat-util.h
index 2a40703..5c392f8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -209,6 +209,12 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
 extern FILE *git_fopen(const char*, const char*);
 #endif
 
+#ifdef BROKEN_VSNPRINTF
+#define vsnprintf git_vsnprintf
+extern int git_vsnprintf(char *str, size_t maxsize,
+                         const char *format, va_list ap);
+#endif
+
 #ifdef __GLIBC_PREREQ
 #if __GLIBC_PREREQ(2, 1)
 #define HAVE_STRCHRNUL
diff --git a/dev/null b/compat/vsnprintf.c
new file mode 100644
index 0000000..263e00e
--- /dev/null
+++ b/compat/vsnprintf.c
@@ -0,0 +1,20 @@
+#include "../git-compat-util.h"
+
+#undef vsnprintf
+int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap);
+{
+	int ret = vsnprintf(s, maxsize, format, ap);
+	if (ret != -1 ) return ret;
+
+	s = NULL;
+	while ( ret == -1 )
+	{
+		maxsize = (maxsize*3)/2;
+		s = realloc(s, maxsize);
+		if (! s) return -1;
+		ret = vsnprintf(s, maxsize, format, ap);
+	}
+	free(s);
+	return ret;
+}
+
