From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [RFC] optimize set_shared_perm()
Date: Thu, 28 Feb 2013 18:17:39 +0100
Message-ID: <201302281817.40692.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 18:18:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UB77b-0008O9-E2
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 18:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759545Ab3B1RRx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Feb 2013 12:17:53 -0500
Received: from mout.web.de ([212.227.15.3]:61924 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755524Ab3B1RRx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Feb 2013 12:17:53 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MZDga-1UPUjT0pQq-00LDEJ; Thu, 28 Feb 2013 18:17:51 +0100
X-Provags-ID: V02:K0:O4Z5oELq24l5DoKXMPp4CZfXRvmuAWuMI31v8Z1LjHH
 a9h+xiUS4aJsVLYxczHZ/5eD4O0B5mHPYoiXIAvTYJ323QBKI/
 C3FtndDunlKI6J2xNvQ/UiWIFs0qbLEno7XfXagDhwd/iEXHr0
 nAsdMyiASVqF2uD8At+HzqFiI1FiVl8o72+TncNCpxuBa3B0z8
 4riqscwu3JdjiQnamCiLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217243>

optimize set_shared_perm() in path.c:

- sometimes the chown() function is called even when not needed.
  (This can be provoced by running t1301, and adding some debug code)

  Save a chmod from 400 to 400, or from 600->600 on these files:
  .git/info/refs+
  .git/objects/info/packs+

  Save chmod on directories from 2770 to 2770:
  .git/refs
  .git/refs/heads
  .git/refs/tags

- as all callers use mode =3D=3D 0 when caling set_shared_perm(),
  the function can be simplified.
- all callers use the macro adjust_shared_perm(path) from cache.h
  Convert adjust_shared_perm() from a macro into a function prototype

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 cache.h |  3 +--
 path.c  | 75 +++++++++++++++++++++++++++++++++++----------------------=
--------
 2 files changed, 41 insertions(+), 37 deletions(-)

While investigating why cygwin 1.7 failes in t1301, and cygwin 1.5 pass=
es,
I came across a small refactoring.

My apologizes if the refactoring in line 431 is wrong:
	if (((shared_repository < 0
	      ? (orig_mode & (FORCE_DIR_SET_GID | 0777))
	      : (orig_mode & mode)) !=3D mode) &&
	    chmod(path, (mode & ~S_IFMT)) < 0)


diff --git a/cache.h b/cache.h
index 2b192d2..9ea9c70 100644
--- a/cache.h
+++ b/cache.h
@@ -700,8 +700,7 @@ enum sharedrepo {
 	PERM_EVERYBODY      =3D 0664
 };
 int git_config_perm(const char *var, const char *value);
-int set_shared_perm(const char *path, int mode);
-#define adjust_shared_perm(path) set_shared_perm((path), 0)
+int adjust_shared_perm(const char *path);
 int safe_create_leading_directories(char *path);
 int safe_create_leading_directories_const(const char *path);
 int mkdir_in_gitdir(const char *path);
diff --git a/path.c b/path.c
index d3d3f8b..8b7922b 100644
--- a/path.c
+++ b/path.c
@@ -1,14 +1,5 @@
 /*
- * I'm tired of doing "vsnprintf()" etc just to open a
- * file, so here's a "return static buffer with printf"
- * interface for paths.
- *
- * It's obviously not thread-safe. Sue me. But it's quite
- * useful for doing things like
- *
- *   f =3D open(mkpath("%s/%s.git", base, name), O_RDONLY);
- *
- * which is what it's designed for.
+ * Different utilitiy functions for path and path names
  */
 #include "cache.h"
 #include "strbuf.h"
@@ -89,6 +80,13 @@ char *git_pathdup(const char *fmt, ...)
 	return xstrdup(ret);
 }
=20
+/*
+ * I'm tired of doing "vsnprintf()" etc just to open a
+ * file, so here's an interface for paths.
+ *
+ * f =3D open(mkpath("%s/%s.git", base, name), O_RDONLY);
+ *
+ */
 char *mkpathdup(const char *fmt, ...)
 {
 	char *path;
@@ -389,24 +387,13 @@ const char *enter_repo(const char *path, int stri=
ct)
 	return NULL;
 }
=20
-int set_shared_perm(const char *path, int mode)
+static int calc_shared_perm(int mode)
 {
-	struct stat st;
-	int tweak, shared, orig_mode;
+	int tweak, shared;
=20
-	if (!shared_repository) {
-		if (mode)
-			return chmod(path, mode & ~S_IFMT);
-		return 0;
-	}
-	if (!mode) {
-		if (lstat(path, &st) < 0)
-			return -1;
-		mode =3D st.st_mode;
-		orig_mode =3D mode;
-	} else
-		orig_mode =3D 0;
-	if (shared_repository < 0)
+	if (!shared_repository)
+		return mode;
+	else if (shared_repository < 0)
 		shared =3D -shared_repository;
 	else
 		shared =3D shared_repository;
@@ -422,16 +409,34 @@ int set_shared_perm(const char *path, int mode)
 	else
 		mode |=3D tweak;
=20
-	if (S_ISDIR(mode)) {
-		/* Copy read bits to execute bits */
-		mode |=3D (shared & 0444) >> 2;
-		mode |=3D FORCE_DIR_SET_GID;
-	}
+	return mode;
+}
+
+static int calc_shared_perm_dir(int mode)
+{
+	mode =3D calc_shared_perm(mode);
+
+	/* Copy read bits to execute bits */
+	mode |=3D (mode & 0444) >> 2;
+	mode |=3D FORCE_DIR_SET_GID;
+	return mode;
+}
+
+int adjust_shared_perm(const char *path)
+{
+	struct stat st;
+	int old_mode, new_mode;
+	if (lstat(path, &st) < 0)
+		return -1;
+	old_mode =3D st.st_mode;
+
+	if (S_ISDIR(old_mode))
+		new_mode =3D calc_shared_perm_dir(old_mode);
+	else
+		new_mode =3D calc_shared_perm(old_mode);
=20
-	if (((shared_repository < 0
-	      ? (orig_mode & (FORCE_DIR_SET_GID | 0777))
-	      : (orig_mode & mode)) !=3D mode) &&
-	    chmod(path, (mode & ~S_IFMT)) < 0)
+	if (((old_mode ^ new_mode) & ~S_IFMT) &&
+			chmod(path, (new_mode & ~S_IFMT)) < 0)
 		return -2;
 	return 0;
 }
--=20
1.8.1.1
