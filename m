From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 2/2] optimize set_shared_perm()
Date: Mon, 25 Mar 2013 16:57:56 +0100
Message-ID: <201303251657.57222.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: j6t@kdbg.org, kusmabite@gmail.com, mlevedahl@gmail.com,
	ramsay@ramsay1.demon.co.uk, tboegi@web.de, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 16:58:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK9n6-0003Y9-5a
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 16:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758591Ab3CYP6F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Mar 2013 11:58:05 -0400
Received: from mout.web.de ([212.227.15.3]:56521 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758551Ab3CYP6D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Mar 2013 11:58:03 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0LfAsW-1V037Z1pnM-00ozif; Mon, 25 Mar 2013 16:58:02 +0100
X-Provags-ID: V02:K0:ywYL99zBUx1y1bFSlN/9ByuoV+Nzg6HyQJhyZqEFGO6
 kyNnpbvZZ1tx1eX+MER/YOGgoyBkpjrhExpLgsfiHOQnloELg8
 NK4fUbI3+zDJY123pJFTZijlJLLS6WaNd1qchH3IU8rfJ00bep
 KVCHqqOl16zEiLKg25QhlpbN3wy6J/PsC2RGAauUaieBFd9CP+
 +IVFvOkPztwKSl17+7ldw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219040>

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
 path.c  | 71 +++++++++++++++++++++++++++++++++++----------------------=
--------
 2 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/cache.h b/cache.h
index 59e5b53..65a9db7 100644
--- a/cache.h
+++ b/cache.h
@@ -727,8 +727,7 @@ enum sharedrepo {
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
index 2fdccc2..4bc918a 100644
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
@@ -105,6 +96,13 @@ char *git_pathdup(const char *fmt, ...)
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
@@ -405,22 +403,13 @@ const char *enter_repo(const char *path, int stri=
ct)
 	return NULL;
 }
=20
-int set_shared_perm(const char *path, int mode)
+static int calc_shared_perm(int mode)
 {
-	int tweak, shared, orig_mode;
+	int tweak, shared;
=20
-	if (!shared_repository) {
-		if (mode)
-			return chmod(path, mode & ~S_IFMT);
-		return 0;
-	}
-	if (!mode) {
-		if (get_st_mode_bits(path, &mode) < 0)
-			return -1;
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
@@ -436,16 +425,32 @@ int set_shared_perm(const char *path, int mode)
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
+	int old_mode, new_mode;
+	if (get_st_mode_bits(path, &old_mode) < 0)
+		return -1;
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
1.8.2.341.g543621f
