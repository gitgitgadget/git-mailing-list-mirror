From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 29/32] count-objects: report unused files in $GIT_DIR/repos/...
Date: Sat, 30 Aug 2014 15:33:59 +0700
Message-ID: <1409387642-24492-30-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:36:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe9G-0003Pu-Oz
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbaH3Igb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:36:31 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:47499 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbaH3Ig2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:36:28 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so2064080pdb.27
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YxhpkyP1N7yN2OnUufh4qCq8RlnsAlU1OdhiY7pPJmE=;
        b=g8b4Oja54+sgau6F03jaNegnsLuKeaorfgN28m/HixjAdPIoNKomRT4d+tDTLYuN9I
         Zco3bYax6WY7Omf5WjswCw/C+CxBX3RCyVbV7bu2Ch23iOsGDWKrDo5ij9S/axSTQPc1
         JOdGbFhralOFKwRxtfzSj0EWOjpEYbaXcVtooyOpTov3btTqdS8gNYTwPwoPHZs0ZQ+o
         dFi0NC5O4rp/7sCH56m9eL9OGnaY5g5kP9W25Wxn32Ld7/PHb4JTHVm41HvBc7Q7dYdv
         tDsv/yfHcsChPd1m8uThTttF4lTDA3oqhPA4WXY1A9DiE9OJUp6LVWHtaVb2rP5l7ftJ
         2Lcw==
X-Received: by 10.67.21.131 with SMTP id hk3mr21590122pad.25.1409387788421;
        Sat, 30 Aug 2014 01:36:28 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id iu10sm2086637pbd.57.2014.08.30.01.36.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:36:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:36:37 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256239>

In linked checkouts, borrowed parts like config is taken from
$GIT_COMMON_DIR. $GIT_DIR/config is never used. Report them as
garbage.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.1.0.rc0.78.gc0d8480
