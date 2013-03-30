From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 1/2] optimize set_shared_perm() in path.c:
Date: Sat, 30 Mar 2013 10:53:32 +0100
Message-ID: <201303301053.34555.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, j6t@kdbg.org, kusmabite@gmail.com,
	mlevedahl@gmail.com, ramsay@ramsay1.demon.co.uk, tboegi@web.de,
	sunshine@sunshineco.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 30 10:54:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULsUN-0002f2-Rk
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 10:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303Ab3C3Jxw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 05:53:52 -0400
Received: from mout.web.de ([212.227.15.3]:62162 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754747Ab3C3Jxv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Mar 2013 05:53:51 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MEEiK-1USQz312sa-00FkKL; Sat, 30 Mar 2013 10:53:46 +0100
X-Provags-ID: V02:K0:es44Y2w58mwy3Pvg5t+3SCZDbCLLkOItTSrAhHkwjlh
 66hVv+Wba9gVNWkcmTweef3rUPwMF7glJ9YoZcBm2TNIy3N9pU
 +3ugPEZHOQDg2nq3RqGEwSaIfgzZkCjqZuKQSy7YetsmK0Nhte
 O4pQVdXywmsahMXFTd8YEksWcrZxh0sQtBDWb+wPFJT6kDMChs
 79+y+MKafbTa1Pwq3603A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219583>

All calls to set_shared_perm() use mode =3D=3D 0, so simplify the funct=
ion.

All callers use the macro adjust_shared_perm(path) from cache.h,
convert adjust_shared_perm() from a macro into a function prototype

Since path.c has much more functions than just mkpath(),
improve a stale comment about path.c

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 cache.h |  3 +--
 path.c  | 27 +++++++--------------------
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/cache.h b/cache.h
index c12957b..e1e8ce8 100644
--- a/cache.h
+++ b/cache.h
@@ -719,8 +719,7 @@ enum sharedrepo {
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
index 2fdccc2..427312e 100644
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
@@ -405,21 +396,17 @@ const char *enter_repo(const char *path, int stri=
ct)
 	return NULL;
 }
=20
-int set_shared_perm(const char *path, int mode)
+int adjust_shared_perm(const char *path)
 {
-	int tweak, shared, orig_mode;
+	int tweak, shared, orig_mode, mode;
=20
 	if (!shared_repository) {
-		if (mode)
-			return chmod(path, mode & ~S_IFMT);
 		return 0;
 	}
-	if (!mode) {
-		if (get_st_mode_bits(path, &mode) < 0)
-			return -1;
-		orig_mode =3D mode;
-	} else
-		orig_mode =3D 0;
+	if (get_st_mode_bits(path, &mode) < 0)
+		return -1;
+
+	orig_mode =3D mode;
 	if (shared_repository < 0)
 		shared =3D -shared_repository;
 	else
--=20
1.8.2.341.g543621f
