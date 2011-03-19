From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2] Allow git mv FileA fILEa on case ignore file systems
Date: Sat, 19 Mar 2011 15:28:33 +0100
Message-ID: <201103191528.34646.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: kusmabite@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 19 15:28:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0x93-00033F-Av
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 15:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885Ab1CSO2k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 10:28:40 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:43164 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab1CSO2j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 10:28:39 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id B618E18A25200;
	Sat, 19 Mar 2011 15:28:37 +0100 (CET)
Received: from [213.64.3.195] (helo=maxi.localnet)
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q0x8v-0001gv-00; Sat, 19 Mar 2011 15:28:37 +0100
X-Sender: tboegi@web.de
X-Provags-ID: V01U2FsdGVkX1/hU3kFuVD+cl7lvoYUDIHCT2kb7QyvWoIi9ly6
	0lhp7g2xsDfC1x6+gPRT2vYe9MGYq5ANWMAXkQ9FsIbU0l6UBY
	+oTtRWraw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169433>

The typical use case is when a file "FileA" should be renamed into fILE=
a
and we are on a case insenstive file system (system core.ignorecase =3D=
 true).
Source and destination are the same file, it can be accessed under both=
 names.
This makes git think that the destination file exists.
Unless used with --forced, git will refuse the "git mv FileA fILEa".
This change will allow "git mv FileA fILEa" under the following conditi=
on:
On Linux/Unix/Mac OS X the move is allowed when the inode of the source=
 and
destination are equal (and they are on the same device).
This allows renames of M=C3=84RCHEN into M=C3=A4rchen on Mac OS X.
(As a side effect, a file can be renamed to a name which is already
hard-linked to the same inode).
On Windows, the function win_is_same_file() from compat/win32/same-file=
=2Ec
is used.
It calls GetFileInformationByHandle() to check if both files are
"the same".

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 Makefile                 |    8 +++++---
 builtin/mv.c             |    2 +-
 compat/win32/same-file.c |   26 ++++++++++++++++++++++++++
 git-compat-util.h        |   15 +++++++++++++++
 t/t7001-mv.sh            |   29 +++++++++++++++++++++++++++++
 5 files changed, 76 insertions(+), 4 deletions(-)
 create mode 100644 compat/win32/same-file.c

diff --git a/Makefile b/Makefile
index 5c2b797..55b9a05 100644
--- a/Makefile
+++ b/Makefile
@@ -924,7 +924,7 @@ ifeq ($(uname_O),Cygwin)
 	# Try commenting this out if you suspect MMAP is more efficient
 	NO_MMAP =3D YesPlease
 	X =3D .exe
-	COMPAT_OBJS +=3D compat/cygwin.o
+	COMPAT_OBJS +=3D compat/cygwin.o compat/win32/same-file.o
 	UNRELIABLE_FSTAT =3D UnfortunatelyYes
 endif
 ifeq ($(uname_S),FreeBSD)
@@ -1104,7 +1104,8 @@ ifeq ($(uname_S),Windows)
 	BASIC_CFLAGS =3D -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbu=
ild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNING=
S -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS =3D compat/msvc.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
-		compat/win32/sys/poll.o compat/win32/dirent.o
+		compat/win32/sys/poll.o compat/win32/dirent.o \
+		compat/win32/same-file.o
 	COMPAT_CFLAGS =3D -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE=
_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=3D\"=
=2Eexe\"
 	BASIC_LDFLAGS =3D -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOL=
E -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS =3D user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.li=
b
@@ -1177,7 +1178,8 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS +=3D -DSTRIP_EXTENSION=3D\".exe\"
 	COMPAT_OBJS +=3D compat/mingw.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
-		compat/win32/sys/poll.o compat/win32/dirent.o
+		compat/win32/sys/poll.o compat/win32/dirent.o \
+		compat/win32/same-file.o
 	EXTLIBS +=3D -lws2_32
 	PTHREAD_LIBS =3D
 	X =3D .exe
diff --git a/builtin/mv.c b/builtin/mv.c
index 93e8995..96792bd 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -166,7 +166,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 			bad =3D "not under version control";
 		else if (lstat(dst, &st) =3D=3D 0) {
 			bad =3D "destination exists";
-			if (force) {
+			if (force || is_same_file(src, dst)) {
 				/*
 				 * only files can overwrite each other:
 				 * check both source and destination
diff --git a/compat/win32/same-file.c b/compat/win32/same-file.c
new file mode 100644
index 0000000..bb1a791
--- /dev/null
+++ b/compat/win32/same-file.c
@@ -0,0 +1,26 @@
+#include "../../git-compat-util.h"
+#include "../win32.h"
+
+int win_is_same_file(const char *a, const char *b)
+{
+	BY_HANDLE_FILE_INFORMATION hia, hib;
+	HANDLE h;
+
+	h =3D CreateFile(a, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTIN=
G, 0, NULL);
+	if (INVALID_HANDLE_VALUE =3D=3D h)
+		return 0;
+	if (!(GetFileInformationByHandle(h,&hia)))
+		return 0;
+  CloseHandle(h);
+
+	h =3D CreateFile(b, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTIN=
G, 0, NULL);
+	if (INVALID_HANDLE_VALUE =3D=3D h)
+		return 0;
+	if (!(GetFileInformationByHandle(h,&hib)))
+		return 0;
+  CloseHandle(h);
+
+	return hia.dwVolumeSerialNumber =3D=3D hib.dwVolumeSerialNumber &&
+	       hia.nFileSizeLow =3D=3D hib.nFileSizeLow &&
+	       hia.nFileSizeHigh =3D=3D hib.nFileSizeHigh;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 49b50ee..df95458 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -152,6 +152,21 @@
 #include "compat/msvc.h"
 #endif
=20
+#if defined (WIN32) || defined(__CYGWIN__)
+/* MinGW or MSVC or cygwin */
+int win_is_same_file(const char *a, const char *b);
+#define is_same_file(a,b) win_is_same_file((a),(b))
+#else
+static inline int is_same_file(const char *a, const char *b)
+{
+	struct stat sta, stb;
+	if (lstat(a, &sta) ||
+	    lstat(b, &stb))
+		return 0;
+	return sta.st_ino && sta.st_dev =3D=3D stb.st_dev && sta.st_ino =3D=3D=
 stb.st_ino;
+}
+#endif
+
 #ifndef NO_LIBGEN_H
 #include <libgen.h>
 #else
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index a845b15..d0e73ee 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -255,4 +255,33 @@ test_expect_success SYMLINKS 'git mv should overwr=
ite file with a symlink' '
=20
 rm -f moved symlink
=20
+touch x
+if ln x y 2>/dev/null; then
+	hardlinks=3D1
+fi
+rm -f x y
+
+if test "$(git config --bool core.ignorecase)" =3D true -o "$hardlinks=
"; then
+	test_expect_success 'git mv FileA fILEa' '
+
+		rm -fr .git * &&
+		git init &&
+		echo FileA > FileA &&
+		git add FileA &&
+		git commit -m add FileA &&
+		{
+			if ! test -f fILEa; then
+				ln FileA fILEa
+			fi
+		} &&
+		git mv FileA fILEa &&
+		git commit -m "mv FileA fILEa" &&
+		rm -f FileA fILEa &&
+		git reset --hard &&
+		test "$(echo *)" =3D fILEa
+	'
+else
+	say "Neither ignorecase nor hardlinks, skipping git mv FileA fILEa"
+fi
+
 test_done
--=20
1.7.4
