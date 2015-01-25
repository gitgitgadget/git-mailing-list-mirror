From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/21] list-files: show directories as well as files
Date: Sun, 25 Jan 2015 19:37:52 +0700
Message-ID: <1422189476-7518-18-git-send-email-pclouds@gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 13:29:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFMJH-0003l6-6j
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 13:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbbAYM24 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 07:28:56 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:38036 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538AbbAYM2y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 07:28:54 -0500
Received: by mail-pd0-f175.google.com with SMTP id fl12so6846013pdb.6
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 04:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=l0tiCvaNcH7SEDfLvfi15497RIxlQAopLuuvkpYrKX0=;
        b=a+aJkLTcX/vfn3M36vKdEMvtoHPDZzCcgEGTzZTB8HZdTt45sYuJUY02c7Pk+6ikEQ
         RwSFhYge0Aq0OKRzZfU+8lvWTTFuBIjEicHB+tR8xjb+IoBGfPDs0mN7+xH5yZlxXTuW
         EgnT7k8ozQ8vgQu54Fw0QYckz8FvIUwo1qr13jO49/aP0YXBywSiUVezJ04bAk4aH7vB
         Gl8bqiD0BPLYwuF1W364BDsQ/fxgqlAl4jqbpvtt4FwSMW7BRqFTHldBgVw7g0ru2YpC
         0agiQZus+0scrnRR+JtNsMixRa7GUB0Tu1bswYnZcY3m6XCsSN/ByVu7HTQ/6+Wrg3ER
         lvgA==
X-Received: by 10.70.137.42 with SMTP id qf10mr26347884pdb.11.1422188934324;
        Sun, 25 Jan 2015 04:28:54 -0800 (PST)
Received: from lanh ([115.73.204.104])
        by mx.google.com with ESMTPSA id l4sm7126562pdj.47.2015.01.25.04.28.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 04:28:53 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 Jan 2015 19:40:18 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263014>

The index does not store directories explicitly (except submodules) so
we have to figure them out from file list when output lis depth-limited=
=2E

The function show_as_directory() deliberately generates duplicate
directories and expects the previous patch to remove duplicates.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++=
++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 1a1c9c8..29b5c2e 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -27,6 +27,8 @@ static int show_resolve_undo;
 static int show_modified;
 static int show_killed;
 static int show_valid_bit;
+static int show_tag;
+static int show_dirs;
 static int line_terminator =3D '\n';
 static int debug_mode;
 static int use_color;
@@ -179,6 +181,35 @@ static void show_killed_files(struct dir_struct *d=
ir)
 	}
 }
=20
+static int show_as_directory(const struct cache_entry *ce)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *p;
+
+	strbuf_add(&sb, ce->name, ce_namelen(ce));
+	while (sb.len && (p =3D strrchr(sb.buf, '/')) !=3D NULL) {
+		struct strbuf sb2 =3D STRBUF_INIT;
+		strbuf_setlen(&sb, p - sb.buf);
+		if (!match_pathspec(&pathspec, sb.buf, sb.len,
+				    max_prefix_len, NULL, 1))
+			continue;
+		write_name(&sb2, sb.buf);
+		if (want_color(use_color)) {
+			struct strbuf sb3 =3D STRBUF_INIT;
+			color_filename(&sb3, ce->name, sb2.buf, S_IFDIR, 1);
+			strbuf_release(&sb2);
+			sb2 =3D sb3;
+		}
+		if (show_tag)
+			strbuf_insert(&sb2, 0, tag_cached, strlen(tag_cached));
+		strbuf_fputs(&sb2, strbuf_detach(&sb, NULL), NULL);
+		strbuf_release(&sb2);
+		return 1;
+	}
+	strbuf_release(&sb);
+	return 0;
+}
+
 static void write_ce_name(struct strbuf *sb, const struct cache_entry =
*ce)
 {
 	struct strbuf quoted =3D STRBUF_INIT;
@@ -194,16 +225,31 @@ static void write_ce_name(struct strbuf *sb, cons=
t struct cache_entry *ce)
 static void show_ce_entry(const char *tag, const struct cache_entry *c=
e)
 {
 	static struct strbuf sb =3D STRBUF_INIT;
-	int len =3D max_prefix_len;
+	int len =3D max_prefix_len, saved_max_depth;
=20
 	if (len >=3D ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of pref=
ix");
=20
+	if (show_dirs) {
+		/* ignore depth to catch dirs that contain matched entries */
+		saved_max_depth =3D pathspec.max_depth;
+		pathspec.max_depth =3D -1;
+	}
+
 	if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
 			    len, ps_matched,
 			    S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode)))
 		return;
=20
+	if (show_dirs) {
+		pathspec.max_depth =3D saved_max_depth;
+		if (strchr(ce->name, '/') &&
+		    !match_pathspec(&pathspec, ce->name, ce_namelen(ce),
+				    prefix_len, NULL, 1) &&
+		    show_as_directory(ce))
+			return;
+	}
+
 	if (tag && *tag && show_valid_bit &&
 	    (ce->ce_flags & CE_VALID)) {
 		static char alttag[4];
@@ -575,7 +621,7 @@ static int git_ls_config(const char *var, const cha=
r *value, void *cb)
=20
 int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 {
-	int require_work_tree =3D 0, show_tag =3D 0, i;
+	int require_work_tree =3D 0, i;
 	int max_depth =3D -1;
 	const char *max_prefix;
 	struct dir_struct dir;
@@ -744,6 +790,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		       prefix, argv);
 	pathspec.max_depth =3D max_depth;
 	pathspec.recursive =3D 1;
+	show_dirs =3D porcelain && max_depth !=3D -1;
+
=20
 	/* Find common prefix for all pathspec's */
 	max_prefix =3D common_prefix(&pathspec);
--=20
2.2.0.84.ge9c7a8a
