From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on maxsize reached
Date: Wed, 5 Mar 2008 14:55:57 +0100
Organization: NextSoft
Message-ID: <200803051455.57148.michal.rokos@nextsoft.cz>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <200803050937.40345.michal.rokos@nextsoft.cz> <47CE6552.60308@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 14:57:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWu7N-0000fV-8a
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 14:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbYCEN4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 08:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbYCEN4L
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 08:56:11 -0500
Received: from holub.nextsoft.cz ([195.122.198.235]:45189 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbYCEN4J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 08:56:09 -0500
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id DE862873; Wed,  5 Mar 2008 14:56:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 53033872;
	Wed,  5 Mar 2008 14:56:02 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28635-06; Wed, 5 Mar 2008 14:56:02 +0100 (CET)
Received: from 89-24-238-42.i4g.tmcz.cz (89-24-238-42.i4g.tmcz.cz [89.24.238.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id A8BF6756;
	Wed,  5 Mar 2008 14:56:01 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <47CE6552.60308@viscovery.net>
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76215>

Hello,

On Wednesday 05 March 2008 10:18:10 Johannes Sixt wrote:
> It's not the same on Windows, which returns:
> case1: -1
> case2: 5
> case3: 5
> case4: 5
>
> BTW, this is not only an issue of vsnprintf, but also of snprintf!

Hmm, HPUX has the same issue for snprint() as is for vsnprintf().

Do you think that following patch suffices your needs. Please note that=
 it=20
actually copies data to str.

Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>

diff --git a/Makefile b/Makefile
index ca5aad9..49d5ab6 100644
--- a/Makefile
+++ b/Makefile
@@ -3,6 +3,14 @@ all::
=20
 # Define V=3D1 to have a more verbose compile.
 #
+# Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf=
()
+# returns -1 instead of number of characters which would have been wri=
tten
+# to the final string if enough space had been available.
+#
+# Define VSNPRINTF_RETURNS_BOGUS if your are on a system which vsnprin=
tf()
+# returns -1 instead of number of characters which would have been wri=
tten
+# to the final string if enough space had been available.
+#
 # Define FREAD_READS_DIRECTORIES if your are on a system which succeed=
s
 # when attempting to read from an fopen'ed directory.
 #
@@ -629,6 +637,14 @@ endif
 ifdef NO_C99_FORMAT
 	BASIC_CFLAGS +=3D -DNO_C99_FORMAT
 endif
+ifdef SNPRINTF_RETURNS_BOGUS
+	COMPAT_CFLAGS +=3D -DSNPRINTF_RETURNS_BOGUS
+	COMPAT_OBJS +=3D compat/snprintf.o
+endif
+ifdef VSNPRINTF_RETURNS_BOGUS
+	COMPAT_CFLAGS +=3D -DVSNPRINTF_RETURNS_BOGUS
+	COMPAT_OBJS +=3D compat/snprintf.o
+endif
 ifdef FREAD_READS_DIRECTORIES
 	COMPAT_CFLAGS +=3D -DFREAD_READS_DIRECTORIES
 	COMPAT_OBJS +=3D compat/fopen.o
diff --git a/config.mak.in b/config.mak.in
index ee6c33d..a10a4af 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -46,3 +46,5 @@ NO_MKDTEMP=3D@NO_MKDTEMP@
 NO_ICONV=3D@NO_ICONV@
 OLD_ICONV=3D@OLD_ICONV@
 NO_DEFLATE_BOUND=3D@NO_DEFLATE_BOUND@
+SNPRINTF_RETURNS_BOGUS=3D@SNPRINTF_RETURNS_BOGUS@
+VSNPRINTF_RETURNS_BOGUS=3D@VSNPRINTF_RETURNS_BOGUS@
diff --git a/configure.ac b/configure.ac
index 85d7ef5..b902888 100644
--- a/configure.ac
+++ b/configure.ac
@@ -326,6 +326,57 @@ else
 	NO_C99_FORMAT=3D
 fi
 AC_SUBST(NO_C99_FORMAT)
+#
+# Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf=
()
+# returns -1 instead of number of characters which would have been wri=
tten
+# to the final string if enough space had been available.
+AC_CACHE_CHECK([whether snprintf() returns bogus],
+ [ac_cv_snprintf_returns_bogus],
+[
+AC_RUN_IFELSE(
+	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
+		[[char buf[1];
+		  if (snprintf(bug, 1, "%s", "12345") !=3D 5) return 1]])],
+	[ac_cv_snprintf_returns_bogus=3Dno],
+	[ac_cv_snprintf_returns_bogus=3Dyes])
+])
+if test $ac_cv_snprintf_returns_bogus =3D yes; then
+	SNPRINTF_RETURNS_BOGUS=3DUnfortunatelyYes
+else
+	SNPRINTF_RETURNS_BOGUS=3D
+fi
+AC_SUBST(SNPRINTF_RETURNS_BOGUS)
+#
+# Define VSNPRINTF_RETURNS_BOGUS if your are on a system which vsnprin=
tf()
+# returns -1 instead of number of characters which would have been wri=
tten
+# to the final string if enough space had been available.
+AC_CACHE_CHECK([whether vsnprintf() returns bogus],
+ [ac_cv_vsnprintf_returns_bogus],
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
+		  if (test_vsnprintf(buf, 1, "%s", "12345") !=3D 5) return 1]])],
+	[ac_cv_vsnprintf_returns_bogus=3Dno],
+	[ac_cv_vsnprintf_returns_bogus=3Dyes])
+])
+if test $ac_cv_vsnprintf_returns_bogus =3D yes; then
+	VSNPRINTF_RETURNS_BOGUS=3DUnfortunatelyYes
+else
+	VSNPRINTF_RETURNS_BOGUS=3D
+fi
+AC_SUBST(VSNPRINTF_RETURNS_BOGUS)
=20
=20
 ## Checks for library functions.
diff --git a/git-compat-util.h b/git-compat-util.h
index 2a40703..6618c08 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -209,6 +209,18 @@ void *gitmemmem(const void *haystack, size_t hayst=
acklen,
 extern FILE *git_fopen(const char*, const char*);
 #endif
=20
+#ifdef SNPRINTF_RETURNS_BOGUS
+#define snprintf git_snprintf
+extern int git_snprintf(char *str, size_t maxsize,
+                        const char *format, ...);
+#endif
+
+#ifdef VSNPRINTF_RETURNS_BOGUS
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
index 0000000..bc0d37c
--- /dev/null
+++ b/compat/snprintf.c
@@ -0,0 +1,37 @@
+#include "../git-compat-util.h"
+
+#undef vsnprintf
+int git_vsnprintf(char *str, size_t maxsize, const char *format, va_li=
st ap)
+{
+   char *s;
+   int size;
+
+   int ret =3D vsnprintf(str, maxsize, format, ap);
+   if (ret !=3D -1 ) return ret;
+
+   s =3D NULL;
+   size =3D maxsize;
+   while ( ret =3D=3D -1 )
+   {
+      size *=3D 4;
+      s =3D realloc(s, size);
+      if (! s) return -1;
+      ret =3D vsnprintf(s, size, format, ap);
+   }
+   if (str && maxsize > 0) memcpy(str, s, maxsize);
+   free(s);
+   return ret;
+}
+
+int git_snprintf(char *str, size_t maxsize, const char *format, ...)
+{
+   va_list ap;
+   int ret;
+
+   va_start(ap, format);
+   ret =3D git_vsnprintf(str, maxsize, format, ap);
+   va_end(ap);
+
+   return ret;
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
