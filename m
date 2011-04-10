From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] Allow git mv FILENAME Filename when core.ignorecase = true
Date: Sun, 10 Apr 2011 07:50:29 +0200
Message-ID: <201104100750.29950.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 07:50:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8nXj-00036k-Bd
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 07:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264Ab1DJFue convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 01:50:34 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:58059 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab1DJFud convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2011 01:50:33 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9553018C0DD3F
	for <git@vger.kernel.org>; Sun, 10 Apr 2011 07:50:31 +0200 (CEST)
Received: from [194.22.188.61] (helo=maxi.localnet)
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q8nXb-0003jv-00; Sun, 10 Apr 2011 07:50:31 +0200
X-Sender: tboegi@web.de
X-Provags-ID: V01U2FsdGVkX19+LQCLGA+1P0uQ6+DByIdPJnV306hc63O7a+nY
	5oveGRHFtfm9B2miwFJ1h8Yn9IHsX7quhSXYpXxEd8gRaS3XrL
	TlWxB/3oU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171237>

Motivation:
The typical use case is when a file named "FILENAME" should be
renamed into "Filename" and we are on a case ignoring file system
(core.ignorecase =3D true).

Using "mv FILENAME Filename" outside git succeeds,
(on Windows and MAC OS X, under Linux the mv command rejects
"mv: `Filename' and `FILENAME' are the same file").

"git mv FILENAME Filename" is refused, "fatal: destination exists",
unless "git mv --forced FILENAME Filename" is used.
The underlying file system makes git think that the
destination "Filename" exists.

The following discussion assumes, that we are on a
"case ignoring" file system, and core.ignorecase =3D true.

This change allows "git mv FILENAME Filename".
Using non ASCII works as well, like "git mv M=C3=84RCHEN M=C3=A4rchen".
The ambition is that "git mv FILENAME Filename" changes both
the git index and the filename in the working tree,
in the same way how "git mv Filename NewFile" works.
Note: Under Linux+vfat The rename() function does not the rename
in the working directory.

Implementation details:
A possible approach to allow the "git mv FILENAME Filename"
is to compare both file names using strcasecmp().

This works for filenames where all characters are ASCII,
It will fail for "git mv M=C3=84RCHEN M=C3=A4rchen".

Git has now idea about the encoding of filenames
(like UTF-8, ISO-8859-1 or any other).
Neither has strcasecmp() an idea how to handle non ASCII characters.

With this patch git lets the underlying file system decide
if 2 file names refer to the same file.

Remember that the file system does this already, by returning the
same values for lstat("FILENAME") and lstat("Filename").

By comparing all members in "struct stat" we can be sure that
both filenames point out the same file.
This is done in the function "equivalent_filenames()".

As lstat() on Windows (mingw.c or cygwin.c) sets st_ino to 0,
(and st_dev and other fields in struct stat)
we need other checks when running under Windows.

Therefore a different implementation of equivalent_filenames() is used
under Windows.
It uses GetFileInformationByHandle() to get and compare
dwVolumeSerialNumber, nFileIndexLow and nFileIndexHigh.
It uses even lstat(), since Windows reports the same nFileIndexLow/High=
 for
a file and a softlink (under cygwin) pointing to it.

To summarize:
equivalent_filenames() is OS specific and checks under Windows:
dwVolumeSerialNumber, nFileIndexLow/High, st_mode, st_size,
st_atime and st_mtime.
All other OS check
st_mode, st_dev, st_ino, st_uid, st_gid, st_size, st_atime, st_mtime.

As a bonus (or regression), a file name can be renamed to a file name
which is already hard-linked to the same inode.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 builtin/mv.c      |   10 +++++++-
 compat/cygwin.c   |   44 ++++++++++++++++++++++++++++++++++++++++
 compat/cygwin.h   |    3 ++
 compat/mingw.c    |   33 ++++++++++++++++++++++++++++++
 compat/mingw.h    |    3 ++
 git-compat-util.h |   17 +++++++++++++++
 t/t7001-mv.sh     |   57 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 t/test-lib.sh     |    4 +++
 8 files changed, 169 insertions(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 40f33ca..7be7d8a 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -165,14 +165,20 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
 		} else if (cache_name_pos(src, length) < 0)
 			bad =3D _("not under version control");
 		else if (lstat(dst, &st) =3D=3D 0) {
+			int allow_force =3D force;
 			bad =3D _("destination exists");
-			if (force) {
+			if (!force && ignore_case && equivalent_filenames(src, dst)) {
+				allow_force =3D 1;
+				bad =3D NULL;
+			}
+			if (allow_force) {
 				/*
 				 * only files can overwrite each other:
 				 * check both source and destination
 				 */
 				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
-					warning(_("%s; will overwrite!"), bad);
+					if (bad)
+						warning(_("%s; will overwrite!"), bad);
 					bad =3D NULL;
 				} else
 					bad =3D _("Cannot overwrite");
diff --git a/compat/cygwin.c b/compat/cygwin.c
index b4a51b9..4fdd94a 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -1,6 +1,7 @@
 #define WIN32_LEAN_AND_MEAN
 #include "../git-compat-util.h"
 #include "win32.h"
+#include <io.h>
 #include "../cache.h" /* to read configuration */
=20
 static inline void filetime_to_timespec(const FILETIME *ft, struct tim=
espec *ts)
@@ -85,6 +86,49 @@ static int cygwin_stat(const char *path, struct stat=
 *buf)
 	return do_stat(path, buf, stat);
 }
=20
+int cygwin_equivalent_filenames(const char *a, const char *b)
+{
+	int fd;
+	BY_HANDLE_FILE_INFORMATION hia, hib;
+	HANDLE h;
+	struct stat st_a, st_b;
+
+	if (lstat(a, &st_a) || lstat(b, &st_b))
+		return 0;
+
+	fd =3D open(a, O_RDONLY);
+	if (-1 =3D=3D fd)
+		return 0;
+
+	h =3D (HANDLE)get_osfhandle(fd);
+	if (INVALID_HANDLE_VALUE =3D=3D h)
+		return 0;
+
+	if (!(GetFileInformationByHandle(h,&hia)))
+		return 0;
+	CloseHandle(h);
+	close(fd);
+
+	fd =3D open(b, O_RDONLY);
+	if (-1 =3D=3D fd)
+		return 0;
+
+	h =3D (HANDLE)get_osfhandle(fd);
+	if (INVALID_HANDLE_VALUE =3D=3D h)
+		return 0;
+	if (!(GetFileInformationByHandle(h,&hib)))
+		return 0;
+	CloseHandle(h);
+	close(fd);
+
+	return st_a.st_mode =3D=3D st_b.st_mode &&
+	       st_a.st_size =3D=3D st_b.st_size &&
+	       st_a.st_atime =3D=3D st_b.st_atime &&
+	       st_a.st_mtime =3D=3D st_b.st_mtime &&
+	       hia.dwVolumeSerialNumber =3D=3D hib.dwVolumeSerialNumber &&
+	       hia.nFileIndexLow =3D=3D hib.nFileIndexLow &&
+	       hia.nFileIndexHigh =3D=3D hib.nFileIndexHigh;
+}
=20
 /*
  * At start up, we are trying to determine whether Win32 API or cygwin=
 stat
diff --git a/compat/cygwin.h b/compat/cygwin.h
index a3229f5..04cc17e 100644
--- a/compat/cygwin.h
+++ b/compat/cygwin.h
@@ -7,3 +7,6 @@ extern stat_fn_t cygwin_lstat_fn;
=20
 #define stat(path, buf) (*cygwin_stat_fn)(path, buf)
 #define lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
+
+int cygwin_equivalent_filenames(const char *a, const char *b);
+#define equivalent_filenames cygwin_equivalent_filenames
diff --git a/compat/mingw.c b/compat/mingw.c
index 878b1de..56be81a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -474,6 +474,39 @@ int mingw_fstat(int fd, struct stat *buf)
 	return -1;
 }
=20
+int mingw_equivalent_filenames(const char *a, const char *b)
+{
+	BY_HANDLE_FILE_INFORMATION hia, hib;
+	HANDLE h;
+	struct stat st_a, st_b;
+
+	if (lstat(a, &st_a) || lstat(b, &st_b))
+		return 0;
+
+	h =3D CreateFile(a, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTIN=
G, 0, NULL);
+	if (INVALID_HANDLE_VALUE =3D=3D h)
+		return 0;
+
+	if (!(GetFileInformationByHandle(h,&hia)))
+		return 0;
+	CloseHandle(h);
+
+	h =3D CreateFile(b, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTIN=
G, 0, NULL);
+	if (INVALID_HANDLE_VALUE =3D=3D h)
+		return 0;
+	if (!(GetFileInformationByHandle(h,&hib)))
+		return 0;
+	CloseHandle(h);
+
+	return st_a.st_mode =3D=3D st_b.st_mode &&
+	       st_a.st_size =3D=3D st_b.st_size &&
+	       st_a.st_atime =3D=3D st_b.st_atime &&
+	       st_a.st_mtime =3D=3D st_b.st_mtime &&
+	       hia.dwVolumeSerialNumber =3D=3D hib.dwVolumeSerialNumber &&
+	       hia.nFileIndexLow =3D=3D hib.nFileIndexLow &&
+	       hia.nFileIndexHigh =3D=3D hib.nFileIndexHigh;
+}
+
 static inline void time_t_to_filetime(time_t t, FILETIME *ft)
 {
 	long long winTime =3D t * 10000000LL + 116444736000000000LL;
diff --git a/compat/mingw.h b/compat/mingw.h
index 62eccd3..3445104 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -303,6 +303,9 @@ int winansi_fprintf(FILE *stream, const char *forma=
t, ...) __attribute__((format
 void mingw_open_html(const char *path);
 #define open_html mingw_open_html
=20
+int mingw_equivalent_filenames(const char *a, const char *b);
+#define equivalent_filenames mingw_equivalent_filenames
+
 /*
  * helpers
  */
diff --git a/git-compat-util.h b/git-compat-util.h
index 40498b3..d66cffe 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -567,4 +567,21 @@ int rmdir_or_warn(const char *path);
  */
 int remove_or_warn(unsigned int mode, const char *path);
=20
+#ifndef equivalent_filenames
+static inline int equivalent_filenames(const char *a, const char *b) {
+	struct stat st_a, st_b;
+	if (lstat(a, &st_a) || lstat(b, &st_b))
+		return 0;
+
+	return st_a.st_mode =3D=3D st_b.st_mode &&
+	       st_a.st_dev =3D=3D st_b.st_dev &&
+	       st_a.st_ino =3D=3D st_b.st_ino &&
+	       st_a.st_uid =3D=3D st_b.st_uid &&
+	       st_a.st_gid =3D=3D st_b.st_gid &&
+	       st_a.st_size =3D=3D st_b.st_size &&
+	       st_a.st_atime =3D=3D st_b.st_atime &&
+	       st_a.st_mtime =3D=3D st_b.st_mtime;
+}
+#endif
+
 #endif
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index a845b15..0c4b96a 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -255,4 +255,61 @@ test_expect_success SYMLINKS 'git mv should overwr=
ite file with a symlink' '
=20
 rm -f moved symlink
=20
+unset encoding
+ae_upper_asc=3DAE
+ae_lower_asc=3Dae
+ae_upper_utf8=3D$(printf '\303\206')
+ae_lower_utf8=3D$(printf '\303\246')
+
+for enc in utf8 asc ; do
+	eval ae_lower=3D\$ae_lower_$enc
+	eval ae_upper=3D\$ae_upper_$enc
+	if (>./$ae_lower && echo broken > ./$ae_upper && test x"$(cat $ae_low=
er)" =3D xbroken ) 2>/dev/null ; then
+		if err=3D$(mv $ae_lower $ae_upper 2>&1); then
+			unset err
+			encoding=3D$enc
+			break
+		fi
+	else
+		err=3D"case sensitive file system"
+	fi
+done
+
+if test -n "$encoding"; then
+	test_expect_success "git mv AE ae $encoding" '
+		rm -fr .git * &&
+		git init &&
+		echo $encoding > $ae_upper &&
+		git add $ae_upper &&
+		git commit -m "add AE" &&
+		git mv $ae_upper $ae_lower &&
+		git commit -m "mv AE ae" &&
+		rm -f $ae_upper $ae_lower &&
+		git reset --hard &&
+		test "$(echo *)" =3D $ae_lower
+	'
+else
+	say "Skipping 'git mv AE ae' $err ($enc)"
+fi
+
+test_expect_success HARDLINKS 'git mv FILE File HARDLINKED' '
+	rm -fr .git * &&
+	git init &&
+	git config core.ignorecase true &&
+	echo FILE > FILE &&
+	git add FILE &&
+	git commit -m add FILE &&
+	{
+		if ! test -f File; then
+			ln FILE File
+		fi
+	} &&
+	git mv FILE File &&
+	git commit -m "mv FILE File" &&
+	rm -f FILE File &&
+	git reset --hard &&
+	test "$(echo *)" =3D File
+'
+
+
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index abc47f3..8c71583 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1080,6 +1080,10 @@ fi
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYML=
INKS
 rm -f y
+# test whether the filesystem supports hard links
+>x
+ln x y 2>/dev/null && test -f y 2>/dev/null && test_set_prereq HARDLIN=
KS
+rm -f x y
=20
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
--=20
1.7.4.3
