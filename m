From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 1/2] Make core.sharedRepository work under cygwin 1.7
Date: Mon, 25 Mar 2013 16:53:17 +0100
Message-ID: <201303251653.18517.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: j6t@kdbg.org, kusmabite@gmail.com, mlevedahl@gmail.com,
	ramsay@ramsay1.demon.co.uk, tboegi@web.de, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 16:53:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK9ig-00069Q-QO
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 16:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758608Ab3CYPxa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Mar 2013 11:53:30 -0400
Received: from mout.web.de ([212.227.17.12]:54826 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758602Ab3CYPxa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Mar 2013 11:53:30 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0M0hfO-1UfgPF2BRe-00v7Ld; Mon, 25 Mar 2013 16:53:24 +0100
X-Provags-ID: V02:K0:PqrCsY2U83YmithpXMXW6V8VC8aFMlPF342Aew1f3zS
 m6tYwsNkPXHz5eqAQ1kUK6aHJiTWs6gFc3ViXD2ix4d4v8ee+N
 ZlazdHUREQvimkWqVUUWhPOMDuuTTpQE1qPsNWMiUSLfke5DFg
 1flaCgXodpVVE80UvgYFIckDH2NtsWNxZYwEe/xBOY0raDY0rJ
 nWBtqzr9de8bITU3vOZgg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219037>

When core.sharedRepository is used, set_shared_perm() in path.c
needs lstat() to return the correct POSIX permissions.

The default for cygwin is core.ignoreCygwinFSTricks =3D false, which
means that the fast implementation in do_stat() is used instead of lsta=
t().

lstat() under cygwin uses the Windows security model to implement
POSIX-like permissions.
The user, group or everyone bits can be set individually.

do_stat() simplifes the file permission bits, and may return a wrong va=
lue:
The read-only attribute of a file is used to calculate
the permissions, resulting in either rw-r--r-- or r--r--r--

One effect of the simplified do_stat() is that t1301 fails.

Add a function cygwin_get_st_mode_bits() which returns the POSIX permis=
sions.
When not compiling for cygwin, true_mode_bits() in path.c is used.

Side note:
t1301 passes under cygwin 1.5.
The "user write" bit is synchronized with the "read only" attribute of =
a file:

$ chmod 444 x
$ attrib x
A    R     C:\temp\pt\x

cygwin 1.7 would show
A          C:\temp\pt\x

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 compat/cygwin.c   | 13 +++++++++++++
 compat/cygwin.h   |  5 +++++
 git-compat-util.h |  1 +
 path.c            | 20 +++++++++++++++++---
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/compat/cygwin.c b/compat/cygwin.c
index 5428858..871b41d 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -1,3 +1,4 @@
+#define CYGWIN_C
 #define WIN32_LEAN_AND_MEAN
 #ifdef CYGWIN_V15_WIN32API
 #include "../git-compat-util.h"
@@ -10,6 +11,18 @@
 #endif
 #include "../cache.h" /* to read configuration */
=20
+/*
+ * Return POSIX permission bits, regardless of core.ignorecygwinfstric=
ks
+ */
+int cygwin_get_st_mode_bits(const char *path, int *mode)
+{
+	struct stat st;
+	if (lstat(path, &st) < 0)
+		return -1;
+	*mode =3D st.st_mode;
+	return 0;
+}
+
 static inline void filetime_to_timespec(const FILETIME *ft, struct tim=
espec *ts)
 {
 	long long winTime =3D ((long long)ft->dwHighDateTime << 32) +
diff --git a/compat/cygwin.h b/compat/cygwin.h
index a3229f5..c04965a 100644
--- a/compat/cygwin.h
+++ b/compat/cygwin.h
@@ -4,6 +4,11 @@
 typedef int (*stat_fn_t)(const char*, struct stat*);
 extern stat_fn_t cygwin_stat_fn;
 extern stat_fn_t cygwin_lstat_fn;
+int cygwin_get_st_mode_bits(const char *path, int *mode);
=20
+#define get_st_mode_bits(p,m) cygwin_get_st_mode_bits((p),(m))
+#ifndef CYGWIN_C
+/* cygwin.c needs the original lstat() */
 #define stat(path, buf) (*cygwin_stat_fn)(path, buf)
 #define lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
+#endif
diff --git a/git-compat-util.h b/git-compat-util.h
index 90e0372..cde442f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -163,6 +163,7 @@
 typedef long intptr_t;
 typedef unsigned long uintptr_t;
 #endif
+int get_st_mode_bits(const char *path, int *mode);
 #if defined(__CYGWIN__)
 #undef _XOPEN_SOURCE
 #include <grp.h>
diff --git a/path.c b/path.c
index d3d3f8b..2fdccc2 100644
--- a/path.c
+++ b/path.c
@@ -14,6 +14,22 @@
 #include "strbuf.h"
 #include "string-list.h"
=20
+#ifndef get_st_mode_bits
+/*
+ * The replacement lstat(2) we use on Cygwin is incomplete and
+ * may return wrong permission bits. Most of the time we do not care,
+ * but the callsites of this wrapper do care.
+ */
+int get_st_mode_bits(const char *path, int *mode)
+{
+	struct stat st;
+	if (lstat(path, &st) < 0)
+		return -1;
+	*mode =3D st.st_mode;
+	return 0;
+}
+#endif
+
 static char bad_path[] =3D "/bad-path/";
=20
 static char *get_pathname(void)
@@ -391,7 +407,6 @@ const char *enter_repo(const char *path, int strict=
)
=20
 int set_shared_perm(const char *path, int mode)
 {
-	struct stat st;
 	int tweak, shared, orig_mode;
=20
 	if (!shared_repository) {
@@ -400,9 +415,8 @@ int set_shared_perm(const char *path, int mode)
 		return 0;
 	}
 	if (!mode) {
-		if (lstat(path, &st) < 0)
+		if (get_st_mode_bits(path, &mode) < 0)
 			return -1;
-		mode =3D st.st_mode;
 		orig_mode =3D mode;
 	} else
 		orig_mode =3D 0;
--=20
1.8.2.341.g543621f
