From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 30/32] count-objects: report unused files in $GIT_DIR/repos/...
Date: Wed,  9 Jul 2014 14:33:15 +0700
Message-ID: <1404891197-18067-31-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:36:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mQJ-0004a8-Az
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141AbaGIHgK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:36:10 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:52377 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132AbaGIHgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:36:09 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so8739653pad.35
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GGoE/C+Vgzm8JR9W4tinvJiMWoTaiE/JuGg5T4s2+bI=;
        b=HH0Ec4/P5B/dkpYaKPuIRGD9zJxXkfpBzWJ3FjJ4a5qNU0LGsb2FxDO75S82+OJBQp
         NZOsRUV3eMx289gJc7dRZmt2Z1bXvZMo/Qu1J5CzcCHDhrYbEdga/Tb1grF/QKZjpcQJ
         1jl7Vf8V/01MFUZugIyxDguoj7xyZdkKAC59IfA/iGjxTJDJKOIo3ZmQqNNUnmg3IRvj
         FMDJLNf5ZJeETyhT7lMxVx3YRP2zI4GslANdTbFUESAmwCUR9eB7ti9hFhnWGXVoDH62
         +jr03kEhAoKJfVCXv1YUBoDKU2sjsHOEcyjG5MPqPGLQSSFj/RsPmUOdoN1AgJ4c8Nx2
         S5WA==
X-Received: by 10.66.131.39 with SMTP id oj7mr39919118pab.20.1404891368758;
        Wed, 09 Jul 2014 00:36:08 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id ak1sm57933975pbc.58.2014.07.09.00.36.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:36:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:36:05 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253105>

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
index b363c00..39cf3f0 100644
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
