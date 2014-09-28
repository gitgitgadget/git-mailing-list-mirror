From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 29/32] count-objects: report unused files in $GIT_DIR/worktrees/...
Date: Sun, 28 Sep 2014 08:22:43 +0700
Message-ID: <1411867366-3821-30-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:25:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3F3-0002pR-Vk
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbaI1BZa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:25:30 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:41292 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:25:29 -0400
Received: by mail-pa0-f54.google.com with SMTP id ey11so3771460pad.27
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ggrEiLQ1FDbAnl78Pl8eWq8i52A+e3CMxIApc9351So=;
        b=iFVzRJptf3QJJ7z8DRyP8/CUb5RUhZJ7cTHDG9fikNwRZPSzzpWifr7D1P+nR2mArC
         4uu205nWvohNn7Itimfkk3jWKPxtgw7uI59qSDoV21TLuUKaN82bSPbQJFTXoBbyUaJT
         BpiEGM+uCaOYrbyAQbp53b1JGFMrWiPgDYl+hiOgps+POA0EHYprWCw/tofRMvHQxcDg
         yWqWFMbt9jWpxFEmMJvymb4aeU+reaZVjkWNOs4Fhvjfnk1l9Btw5zdbxmUj2hD/qsak
         zydAKFfn97idgtRTjOi66ihT3SpRJuLegp5G/Z3Iw7ksgipIYhTengaVO/jYVFlwPVF2
         FRdg==
X-Received: by 10.66.145.167 with SMTP id sv7mr45355379pab.5.1411867529051;
        Sat, 27 Sep 2014 18:25:29 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id tu10sm8617008pab.14.2014.09.27.18.25.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:25:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:25:32 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257589>

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
index aedfd05..ab3adb6 100644
--- a/cache.h
+++ b/cache.h
@@ -713,6 +713,7 @@ extern const char *mkpath(const char *fmt, ...) __a=
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
index 72eca6d..cd8e2d6 100644
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
 	"/objects", "/refs", "/remotes", "/worktrees", "/rr-cache", "/svn",
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
2.1.0.rc0.78.gc0d8480
