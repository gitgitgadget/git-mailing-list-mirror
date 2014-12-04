From: David Michael <fedora.dm0@gmail.com>
Subject: [PATCH v2] compat: convert modes to use portable file type values
Date: Wed, 03 Dec 2014 21:24:17 -0500
Message-ID: <87wq68w3se.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 04 03:23:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwM5F-0007HI-B1
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 03:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbaLDCXx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Dec 2014 21:23:53 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:56160 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbaLDCXw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2014 21:23:52 -0500
Received: by mail-qa0-f48.google.com with SMTP id v10so11428872qac.35
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 18:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=sle7UNfR6SaKQtVtUCusU8eTa0AdOXkoA0BcnS1pXAI=;
        b=fSMn1bCmpCVbn4PRt/7Im9ga58ywPAje1AhSlZul+HoCGdyXjiLIuwB7ySRt3t5J8t
         f7o1pQCuNWDB+6KnK9kxJXxN63DKfmZaR2NiS09c1ofqo+USmRThQSGm48SRNR+9UEks
         pFX0Nnq22C8FUC0iBHaznTD4677X5KzZiv7avXPblGCKmD3ct4tEyKUo5xqjPYEE/EVL
         TiQfTwjrgLPeqgO6HcvbnGRcYrGXI86HxZXRdEiDcJoQ037EvTfsoZY8Aw0+u/gX+l3P
         NPkwgbA0jzJ+ePbPtrhjBAYBGPYoFI2pCsZT8CkXElGDuhcERHVPZoOwoLkQpJ/wmT5X
         9K8w==
X-Received: by 10.224.96.194 with SMTP id i2mr12844015qan.87.1417659831968;
        Wed, 03 Dec 2014 18:23:51 -0800 (PST)
Received: from callisto (c-68-81-204-146.hsd1.pa.comcast.net. [68.81.204.146])
        by mx.google.com with ESMTPSA id k9sm13921160qaj.7.2014.12.03.18.23.50
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2014 18:23:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260721>

This adds simple wrapper functions around calls to stat(), fstat(),
and lstat() that translate the operating system's native file type
bits to those used by most operating systems.  It also rewrites the
S_IF* macros to the common values, so all file type processing is
performed using the translated modes.  This makes projects portable
across operating systems that use different file type definitions.

Only the file type bits may be affected by these compatibility
functions; the file permission bits are assumed to be 07777 and are
passed through unchanged.

Signed-off-by: David Michael <fedora.dm0@gmail.com>
---

Changes in v2:

Remove "else"s and use a perm_bits variable as suggested by Torsten
B=C3=B6gershausen.

Only translate the mode on stat() success as suggested by Duy Nguyen.

Add S_IFSOCK translation to support a git.c test.  (I left the device
types defined just to support all the POSIX file types.)

Replace _POSIX_SOURCE=3D1 with _POSIX_C_SOURCE=3D200112L to properly ge=
t
IEEE 1003.1a definitions for lstat(), as suggested for glibc.

 Makefile          |  8 ++++++++
 cache.h           |  7 -------
 compat/stat.c     | 49 +++++++++++++++++++++++++++++++++++++++++++++++=
++
 configure.ac      | 23 +++++++++++++++++++++++
 git-compat-util.h | 34 ++++++++++++++++++++++++++++++++++
 5 files changed, 114 insertions(+), 7 deletions(-)
 create mode 100644 compat/stat.c

diff --git a/Makefile b/Makefile
index 827006b..cba3be1 100644
--- a/Makefile
+++ b/Makefile
@@ -191,6 +191,10 @@ all::
 # Define NO_TRUSTABLE_FILEMODE if your filesystem may claim to support
 # the executable mode bit, but doesn't really do so.
 #
+# Define NEEDS_MODE_TRANSLATION if your OS strays from the typical fil=
e type
+# bits in mode values (e.g. z/OS defines I_SFMT to 0xFF000000 as oppos=
ed to the
+# usual 0xF000).
+#
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
 #
 # Define NO_UNIX_SOCKETS if your system does not offer unix sockets.
@@ -1230,6 +1234,10 @@ endif
 ifdef NO_TRUSTABLE_FILEMODE
 	BASIC_CFLAGS +=3D -DNO_TRUSTABLE_FILEMODE
 endif
+ifdef NEEDS_MODE_TRANSLATION
+	COMPAT_CFLAGS +=3D -DNEEDS_MODE_TRANSLATION
+	COMPAT_OBJS +=3D compat/stat.o
+endif
 ifdef NO_IPV6
 	BASIC_CFLAGS +=3D -DNO_IPV6
 endif
diff --git a/cache.h b/cache.h
index 99ed096..f8174fe 100644
--- a/cache.h
+++ b/cache.h
@@ -65,13 +65,6 @@ unsigned long git_deflate_bound(git_zstream *, unsig=
ned long);
  *
  * The value 0160000 is not normally a valid mode, and
  * also just happens to be S_IFDIR + S_IFLNK
- *
- * NOTE! We *really* shouldn't depend on the S_IFxxx macros
- * always having the same values everywhere. We should use
- * our internal git values for these things, and then we can
- * translate that to the OS-specific value. It just so
- * happens that everybody shares the same bit representation
- * in the UNIX world (and apparently wider too..)
  */
 #define S_IFGITLINK	0160000
 #define S_ISGITLINK(m)	(((m) & S_IFMT) =3D=3D S_IFGITLINK)
diff --git a/compat/stat.c b/compat/stat.c
new file mode 100644
index 0000000..c2d4711
--- /dev/null
+++ b/compat/stat.c
@@ -0,0 +1,49 @@
+#define _POSIX_C_SOURCE 200112L
+#include <stddef.h>    /* NULL         */
+#include <sys/stat.h>  /* *stat, S_IS* */
+#include <sys/types.h> /* mode_t       */
+
+static inline mode_t mode_native_to_git(mode_t native_mode)
+{
+	mode_t perm_bits =3D native_mode & 07777;
+	if (S_ISREG(native_mode))
+		return 0100000 | perm_bits;
+	if (S_ISDIR(native_mode))
+		return 0040000 | perm_bits;
+	if (S_ISLNK(native_mode))
+		return 0120000 | perm_bits;
+	if (S_ISBLK(native_mode))
+		return 0060000 | perm_bits;
+	if (S_ISCHR(native_mode))
+		return 0020000 | perm_bits;
+	if (S_ISFIFO(native_mode))
+		return 0010000 | perm_bits;
+	if (S_ISSOCK(native_mode))
+		return 0140000 | perm_bits;
+	/* Non-standard type bits were given. */
+	return perm_bits;
+}
+
+int git_stat(const char *path, struct stat *buf)
+{
+	int rc =3D stat(path, buf);
+	if (rc =3D=3D 0)
+		buf->st_mode =3D mode_native_to_git(buf->st_mode);
+	return rc;
+}
+
+int git_fstat(int fd, struct stat *buf)
+{
+	int rc =3D fstat(fd, buf);
+	if (rc =3D=3D 0)
+		buf->st_mode =3D mode_native_to_git(buf->st_mode);
+	return rc;
+}
+
+int git_lstat(const char *path, struct stat *buf)
+{
+	int rc =3D lstat(path, buf);
+	if (rc =3D=3D 0)
+		buf->st_mode =3D mode_native_to_git(buf->st_mode);
+	return rc;
+}
diff --git a/configure.ac b/configure.ac
index 6af9647..5c1312f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -873,6 +873,29 @@ else
 	SNPRINTF_RETURNS_BOGUS=3D
 fi
 GIT_CONF_SUBST([SNPRINTF_RETURNS_BOGUS])
+#
+# Define NEEDS_MODE_TRANSLATION if your OS strays from the typical fil=
e type
+# bits in mode values.
+AC_CACHE_CHECK([whether the platform uses typical file type bits],
+ [ac_cv_sane_mode_bits], [
+AC_EGREP_CPP(yippeeyeswehaveit,
+	AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
+[#if S_IFMT =3D=3D 0170000 && \
+	S_IFREG =3D=3D 0100000 && S_IFDIR =3D=3D 0040000 && S_IFLNK =3D=3D 01=
20000 && \
+	S_IFBLK =3D=3D 0060000 && S_IFCHR =3D=3D 0020000 && \
+	S_IFIFO =3D=3D 0010000 && S_IFSOCK =3D=3D 0140000
+yippeeyeswehaveit
+#endif
+]),
+	[ac_cv_sane_mode_bits=3Dyes],
+	[ac_cv_sane_mode_bits=3Dno])
+])
+if test $ac_cv_sane_mode_bits =3D yes; then
+	NEEDS_MODE_TRANSLATION=3D
+else
+	NEEDS_MODE_TRANSLATION=3DUnfortunatelyYes
+fi
+GIT_CONF_SUBST([NEEDS_MODE_TRANSLATION])
=20
=20
 ## Checks for library functions.
diff --git a/git-compat-util.h b/git-compat-util.h
index 400e921..265afc8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -474,6 +474,40 @@ extern int git_munmap(void *start, size_t length);
 #define on_disk_bytes(st) ((st).st_blocks * 512)
 #endif
=20
+#ifdef NEEDS_MODE_TRANSLATION
+#undef S_IFMT
+#undef S_IFREG
+#undef S_IFDIR
+#undef S_IFLNK
+#undef S_IFBLK
+#undef S_IFCHR
+#undef S_IFIFO
+#undef S_IFSOCK
+#define S_IFMT   0170000
+#define S_IFREG  0100000
+#define S_IFDIR  0040000
+#define S_IFLNK  0120000
+#define S_IFBLK  0060000
+#define S_IFCHR  0020000
+#define S_IFIFO  0010000
+#define S_IFSOCK 0140000
+#ifdef stat
+#undef stat
+#endif
+#define stat(path, buf) git_stat(path, buf)
+extern int git_stat(const char *, struct stat *);
+#ifdef fstat
+#undef fstat
+#endif
+#define fstat(fd, buf) git_fstat(fd, buf)
+extern int git_fstat(int, struct stat *);
+#ifdef lstat
+#undef lstat
+#endif
+#define lstat(path, buf) git_lstat(path, buf)
+extern int git_lstat(const char *, struct stat *);
+#endif
+
 #define DEFAULT_PACKED_GIT_LIMIT \
 	((1024L * 1024L) * (sizeof(void*) >=3D 8 ? 8192 : 256))
=20
--=20
1.9.3
