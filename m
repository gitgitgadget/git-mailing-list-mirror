From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: [PATCH v2] Add compat/snprintf.c for systems that return bogus
Date: Wed, 5 Mar 2008 16:46:13 +0100
Organization: NextSoft
Message-ID: <200803051646.13343.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 16:49:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWvpe-0003fM-7w
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 16:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbYCEPqW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 10:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753680AbYCEPqW
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 10:46:22 -0500
Received: from holub.nextsoft.cz ([195.122.198.235]:46046 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbYCEPqU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 10:46:20 -0500
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id F4069873; Wed,  5 Mar 2008 16:46:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id BB6C7872
	for <git@vger.kernel.org>; Wed,  5 Mar 2008 16:46:17 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30882-06 for <git@vger.kernel.org>;
	Wed, 5 Mar 2008 16:46:17 +0100 (CET)
Received: from 89-24-238-42.i4g.tmcz.cz (89-24-238-42.i4g.tmcz.cz [89.24.238.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id 013C746B
	for <git@vger.kernel.org>; Wed,  5 Mar 2008 16:46:16 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76231>

Some systems (namely HPUX and Windows) return -1 when maxsize in snprin=
tf()=20
and in vsnprintf() is reached. So replace snprintf() and vsnprintf()=20
functions with our own ones that return correct value upon overflow.

Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>

diff --git a/Makefile b/Makefile
index ca5aad9..6af7132 100644
--- a/Makefile
+++ b/Makefile
@@ -3,6 +3,10 @@ all::
=20
 # Define V=3D1 to have a more verbose compile.
 #
+# Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf=
()
+# or vsnprintf() return -1 instead of number of characters which would
+# have been written to the final string if enough space had been avail=
able.
+#
 # Define FREAD_READS_DIRECTORIES if your are on a system which succeed=
s
 # when attempting to read from an fopen'ed directory.
 #
@@ -629,6 +633,10 @@ endif
 ifdef NO_C99_FORMAT
 	BASIC_CFLAGS +=3D -DNO_C99_FORMAT
 endif
+ifdef SNPRINTF_RETURNS_BOGUS
+	COMPAT_CFLAGS +=3D -DSNPRINTF_RETURNS_BOGUS
+	COMPAT_OBJS +=3D compat/snprintf.o
+endif
 ifdef FREAD_READS_DIRECTORIES
 	COMPAT_CFLAGS +=3D -DFREAD_READS_DIRECTORIES
 	COMPAT_OBJS +=3D compat/fopen.o
diff --git a/config.mak.in b/config.mak.in
index ee6c33d..8e1cd5f 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -46,3 +46,4 @@ NO_MKDTEMP=3D@NO_MKDTEMP@
 NO_ICONV=3D@NO_ICONV@
 OLD_ICONV=3D@OLD_ICONV@
 NO_DEFLATE_BOUND=3D@NO_DEFLATE_BOUND@
+SNPRINTF_RETURNS_BOGUS=3D@SNPRINTF_RETURNS_BOGUS@
diff --git a/configure.ac b/configure.ac
index 85d7ef5..a3bbfa6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -326,6 +326,38 @@ else
 	NO_C99_FORMAT=3D
 fi
 AC_SUBST(NO_C99_FORMAT)
+#
+# Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf=
()
+# or vsnprintf() return -1 instead of number of characters which would
+# have been written to the final string if enough space had been avail=
able.
+AC_CACHE_CHECK([whether snprintf() and/or vsnprintf() return bogus],
+ [ac_cv_snprintf_returns_bogus],
+[
+AC_RUN_IFELSE(
+	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT
+		#include "stdarg.h"
+
+		int test_vsnprintf(char *str, size_t maxsize, const char *format, ..=
=2E)
+		{
+		  int ret;
+		  va_list ap;
+		  va_start(ap, format);
+		  ret =3D vsnprintf(str, maxsize, format, ap);
+		  va_end(ap);
+		  return ret;
+		}],
+		[[char buf[1];
+		  if (test_vsnprintf(buf, 1, "%s", "12345") !=3D 5) return 1;
+		  if (snprintf(buf, 1, "%s", "12345") !=3D 5) return 1]])],
+	[ac_cv_snprintf_returns_bogus=3Dno],
+	[ac_cv_snprintf_returns_bogus=3Dyes])
+])
+if test $ac_cv_snprintf_returns_bogus =3D yes; then
+	SNPRINTF_RETURNS_BOGUS=3DUnfortunatelyYes
+else
+	SNPRINTF_RETURNS_BOGUS=3D
+fi
+AC_SUBST(SNPRINTF_RETURNS_BOGUS)
=20
=20
 ## Checks for library functions.
diff --git a/git-compat-util.h b/git-compat-util.h
index 2a40703..0aa04eb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -209,6 +209,15 @@ void *gitmemmem(const void *haystack, size_t hayst=
acklen,
 extern FILE *git_fopen(const char*, const char*);
 #endif
=20
+#ifdef SNPRINTF_RETURNS_BOGUS
+#define snprintf git_snprintf
+extern int git_snprintf(char *str, size_t maxsize,
+                        const char *format, ...);
+#define vsnprintf git_vsnprintf
+extern int git_vsnprintf(char *str, size_t maxsize,
+                         const char *format, va_list ap);
+#endif
+
 #ifdef __GLIBC_PREREQ
 #if __GLIBC_PREREQ(2, 1)
 #define HAVE_STRCHRNUL
diff --git a/dev/null b/compat/snprintf.c
new file mode 100644
index 0000000..dbfc2d6
--- /dev/null
+++ b/compat/snprintf.c
@@ -0,0 +1,40 @@
+#include "../git-compat-util.h"
+
+#undef vsnprintf
+int git_vsnprintf(char *str, size_t maxsize, const char *format, va_li=
st ap)
+{
+	char *s;
+	int ret;
+
+	ret =3D vsnprintf(str, maxsize, format, ap);
+	if (ret !=3D -1)
+		return ret;
+
+	s =3D NULL;
+	if (maxsize < 128)
+		maxsize =3D 128;
+
+	while (ret =3D=3D -1) {
+		maxsize *=3D 4;
+		str =3D realloc(s, maxsize);
+		if (! str)
+			break;
+		s =3D str;
+		ret =3D vsnprintf(str, maxsize, format, ap);
+	}
+	free(s);
+	return ret;
+}
+
+int git_snprintf(char *str, size_t maxsize, const char *format, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, format);
+	ret =3D git_vsnprintf(str, maxsize, format, ap);
+	va_end(ap);
+
+	return ret;
+}
+

--=20
Michal Rokos

NextSoft s.r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
phone:  +420 267 224 311
fax:    +420 267 224 307
mobile: +420 736 646 591
e-mail: michal.rokos@nextsoft.cz
