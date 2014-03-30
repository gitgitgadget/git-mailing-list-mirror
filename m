From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 16/18] list-files: show directories as well as files
Date: Sun, 30 Mar 2014 20:56:07 +0700
Message-ID: <1396187769-30863-17-git-send-email-pclouds@gmail.com>
References: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
 <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 15:57:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUGEi-0003Zk-1h
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 15:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbaC3N5N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2014 09:57:13 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33602 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbaC3N5M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 09:57:12 -0400
Received: by mail-pd0-f173.google.com with SMTP id z10so6818887pdj.18
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zzhKSqKD9MKxwWmHMhV4W0yJjdNmIvsEaw8HzYyjcPM=;
        b=Qud2ltA0DXkkPdxqCGI+3KWTDZ9/as2h2FWa63UB/GNYlRqRNlgBUm0V6ZxfR4owBX
         EdDamJ2Bb4KBQG2bH+mTeW5ep1MRSgYRxDR9JlDUhmIdYt6GNElEoN1sygjpMKaTo/K0
         tUXyFb5kjZzCR/xzWxxlxUteZvV2RRGIZU/Qba4GMH9Or/JPcNzk8L88kGB1AfMcOY4C
         IJ/AsebaW9y7RAUAMNoK13SY4GsnAvF5dMywQp7mtaurj4N0UFhivac/SXFb1FifqWod
         aHrHEdi1nzme80cbo/BcM22BCJEiiSQwN1XfOGDkjMVouTS/5fdUPXDePhWKvtRLUqHq
         3RtQ==
X-Received: by 10.66.243.131 with SMTP id wy3mr19603421pac.32.1396187832016;
        Sun, 30 Mar 2014 06:57:12 -0700 (PDT)
Received: from lanh ([115.73.202.240])
        by mx.google.com with ESMTPSA id yk4sm37355233pbc.16.2014.03.30.06.57.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Mar 2014 06:57:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Mar 2014 20:58:09 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245480>

The index does not store directories explicitly (except submodules) so
we have to figure them out from file list. The function
show_directories() deliberately generates duplicate directories and
expects the previous patch to remove duplicates.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 9a8f687..9dc1c39 100644
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
@@ -333,6 +335,43 @@ static void show_files(struct dir_struct *dir)
 	}
 }
=20
+static void show_directories(const struct cache_entry *ce)
+{
+	static const char *last_directory;
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *p =3D ce->name + prefix_len;
+	const char *sep;
+
+	if (last_directory) {
+		int len =3D strlen(last_directory);
+		if (!strncmp(ce->name, last_directory, len) &&
+		    ce->name[len] =3D=3D '/')
+			p +=3D len + 1;
+	}
+
+	while (*p && (sep =3D strchr(p, '/'))) {
+		struct strbuf sb2 =3D STRBUF_INIT;
+		strbuf_reset(&sb);
+		strbuf_add(&sb, ce->name, sep - ce->name);
+		p =3D sep + 1;
+		if (!match_pathspec(&pathspec, sb.buf, sb.len,
+				    prefix_len, NULL, 1))
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
+		last_directory =3D strbuf_detach(&sb, NULL);
+		strbuf_fputs(&sb2, last_directory, NULL);
+		strbuf_release(&sb2);
+	}
+}
+
 static void show_files_compact(struct dir_struct *dir)
 {
 	int i;
@@ -353,6 +392,8 @@ static void show_files_compact(struct dir_struct *d=
ir)
 		const struct cache_entry *ce =3D active_cache[i];
 		struct stat st;
 		int err, shown =3D 0;
+		if (show_dirs)
+			show_directories(ce);
 		if ((dir->flags & DIR_SHOW_IGNORED) &&
 		    !ce_excluded(dir, ce))
 			continue;
@@ -575,7 +616,7 @@ static int git_ls_config(const char *var, const cha=
r *value, void *cb)
=20
 int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 {
-	int require_work_tree =3D 0, show_tag =3D 0, i;
+	int require_work_tree =3D 0, i;
 	int max_depth =3D -1;
 	const char *max_prefix;
 	struct dir_struct dir;
@@ -696,6 +737,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		use_color =3D -1;
 		max_depth =3D 0;
 		show_tag =3D -1;
+		show_dirs =3D 1;
 		git_config(git_ls_config, NULL);
 	} else
 		git_config(git_default_config, NULL);
--=20
1.9.1.345.ga1a145c
