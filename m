From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 29/31] count-objects: report unused files in $GIT_DIR/repos/...
Date: Sun, 13 Jul 2014 11:51:06 +0700
Message-ID: <1405227068-25506-30-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:55:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6BpJ-0001rt-LO
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbaGMEzt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:55:49 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:47244 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbaGMEzr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:55:47 -0400
Received: by mail-pa0-f41.google.com with SMTP id fb1so3628175pad.0
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2tTXqHd3Ka9QhPvTD64AtPbpalokXJ/SSzM/Ei3IrAk=;
        b=liUj6Wku7al8+tBl+xC+6tXMcflRHloCYSVaSDF0YH9wZ+9a/AZQVli9eQWXlWVqPH
         IgQovx50pkgj3DalvQ6a5mlKV3av4707DvjRhVD4uM+k7qG1T9FoZpHYGitVCSjN5qd+
         5S5ruyBt81JrcRXKs9AO0Wp2NoV/t2z66xjivmeE6Iwst0EvowpGHcAijCQnVpWqx2xA
         jJBj5wKmphjSANDi1Rf7xEkctGDBJ3hxUBENhkw+9KTmeqI+1DdgU5B57t34aEqz3lRJ
         xFKqXGtgkSvp2sniS2BTw2S1f/Odl5kFwt0bLj2JVSZkwzMOJ0F0ycmy7CNFxgVKfRXy
         g5wg==
X-Received: by 10.66.142.42 with SMTP id rt10mr8908917pab.1.1405227347626;
        Sat, 12 Jul 2014 21:55:47 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id nm14sm9086644pdb.54.2014.07.12.21.55.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:55:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:55:47 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253432>

In linked checkouts, borrowed parts like config is taken from
$GIT_COMMON_DIR. $GIT_DIR/config is never used. Report them as
garbage.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/count-objects.c |  4 +++-
 cache.h                 |  1 +
 path.c                  | 29 +++++++++++++++++++++++++++--
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index a7f70cb..d3a1620 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -102,8 +102,10 @@ int cmd_count_objects(int argc, const char **argv,=
 const char *prefix)
 	/* we do not take arguments other than flags for now */
 	if (argc)
 		usage_with_options(count_objects_usage, opts);
-	if (verbose)
+	if (verbose) {
 		report_garbage =3D real_report_garbage;
+		report_linked_checkout_garbage();
+	}
 	memcpy(path, objdir, len);
 	if (len && objdir[len-1] !=3D '/')
 		path[len++] =3D '/';
diff --git a/cache.h b/cache.h
index bf4d15e..12f0fc0 100644
--- a/cache.h
+++ b/cache.h
@@ -690,6 +690,7 @@ extern const char *mkpath(const char *fmt, ...) __a=
ttribute__((format (printf, 1
 extern const char *git_path(const char *fmt, ...) __attribute__((forma=
t (printf, 1, 2)));
 extern const char *git_path_submodule(const char *path, const char *fm=
t, ...)
 	__attribute__((format (printf, 2, 3)));
+extern void report_linked_checkout_garbage(void);
=20
 /*
  * Return the name of the file in the local object database that would
diff --git a/path.c b/path.c
index e41d6b3..b5af137 100644
--- a/path.c
+++ b/path.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "strbuf.h"
 #include "string-list.h"
+#include "dir.h"
=20
 static int get_st_mode_bits(const char *path, int *mode)
 {
@@ -91,9 +92,9 @@ static void replace_dir(struct strbuf *buf, int len, =
const char *newdir)
 }
=20
 static const char *common_list[] =3D {
-	"/branches", "/hooks", "/info", "/logs", "/lost-found", "/modules",
+	"/branches", "/hooks", "/info", "!/logs", "/lost-found", "/modules",
 	"/objects", "/refs", "/remotes", "/repos", "/rr-cache", "/svn",
-	"config", "gc.pid", "packed-refs", "shallow",
+	"config", "!gc.pid", "packed-refs", "shallow",
 	NULL
 };
=20
@@ -107,6 +108,8 @@ static void update_common_dir(struct strbuf *buf, i=
nt git_dir_len)
 	for (p =3D common_list; *p; p++) {
 		const char *path =3D *p;
 		int is_dir =3D 0;
+		if (*path =3D=3D '!')
+			path++;
 		if (*path =3D=3D '/') {
 			path++;
 			is_dir =3D 1;
@@ -122,6 +125,28 @@ static void update_common_dir(struct strbuf *buf, =
int git_dir_len)
 	}
 }
=20
+void report_linked_checkout_garbage(void)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	const char **p;
+	int len;
+
+	if (!git_common_dir_env)
+		return;
+	strbuf_addf(&sb, "%s/", get_git_dir());
+	len =3D sb.len;
+	for (p =3D common_list; *p; p++) {
+		const char *path =3D *p;
+		if (*path =3D=3D '!')
+			continue;
+		strbuf_setlen(&sb, len);
+		strbuf_addstr(&sb, path);
+		if (file_exists(sb.buf))
+			report_garbage("unused in linked checkout", sb.buf);
+	}
+	strbuf_release(&sb);
+}
+
 static void adjust_git_path(struct strbuf *buf, int git_dir_len)
 {
 	const char *base =3D buf->buf + git_dir_len;
--=20
1.9.1.346.ga2b5940
