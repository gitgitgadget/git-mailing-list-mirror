From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 14/18] list-files: sort output and remove duplicates
Date: Sun, 30 Mar 2014 20:56:05 +0700
Message-ID: <1396187769-30863-15-git-send-email-pclouds@gmail.com>
References: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
 <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 15:57:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUGEW-0003RG-4e
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 15:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbaC3N5D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2014 09:57:03 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:49421 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbaC3N5B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 09:57:01 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so7009454pab.22
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cb+etBgktCC/qIyArKdDEhKu7T3AfG9ON+Nden79u3A=;
        b=1Bd4J8qFO9k3nlllvcWAxhvANUvXS9LT8r3i2+jNjoVBN34TYF8c/F1iKBzcstMhbJ
         40JyD4GDnwHBeUlACLeppbMnRhlvJFsuamr8ujjcyPLJNxHXDTFc2MPzOSzAXIPGLCGi
         wlYi9RVQ1kZ9XkyYo9wFyUreElWU1xHMEmUUbQgQ6rN2HxS92XNwfUTXD1H/errJPodo
         bSYZzG3vBt69I+Gd3VlntqVt3xghlnXieFdXs6knQumsa6ecoiLd8l8hJdyXHt/yOU/F
         hqy9j92KPN6BpifAIAmmQFFp9jD5H5Y2jtvuv+8/hbs+mIpTFX6Q9WBfknf5+tZZftnX
         wXHQ==
X-Received: by 10.66.220.198 with SMTP id py6mr19452550pac.21.1396187821152;
        Sun, 30 Mar 2014 06:57:01 -0700 (PDT)
Received: from lanh ([115.73.202.240])
        by mx.google.com with ESMTPSA id ff4sm26234392pad.24.2014.03.30.06.56.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Mar 2014 06:57:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Mar 2014 20:57:58 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245478>

When you mix different file types, with ls-files you may get separate
listing. For example, "ls-files -cm" will show file "abc" twice: one
as part of cached list, one of modified list. With "ls" (and this
patch) they will be in a single sorted list (easier for the eye).

Duplicate entries are also removed. Note that display content is
compared, so if you have "-t" on, or you color file types differently,
you will get duplicate textual entries. This is good imo.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 14dfd2a..ff2377f 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -53,6 +53,13 @@ static const char *tag_modified =3D "";
 static const char *tag_skip_worktree =3D "";
 static const char *tag_resolve_undo =3D "";
=20
+static int compare_output(const void *a_, const void *b_)
+{
+	const struct string_list_item *a =3D a_;
+	const struct string_list_item *b =3D b_;
+	return strcmp(a->util, b->util);
+}
+
 static void write_name(struct strbuf *sb, const char *name)
 {
 	/*
@@ -68,10 +75,12 @@ static void write_name(struct strbuf *sb, const cha=
r *name)
 		quote_path_relative(name, real_prefix, sb);
 }
=20
-static void strbuf_fputs(struct strbuf *sb, FILE *fp)
+static void strbuf_fputs(struct strbuf *sb, const char *full_name, FIL=
E *fp)
 {
-	if (column_active(colopts)) {
-		string_list_append(&output, strbuf_detach(sb, NULL));
+	if (column_active(colopts) || porcelain) {
+		struct string_list_item *it;
+		it =3D string_list_append(&output, strbuf_detach(sb, NULL));
+		it->util =3D (void*)full_name;
 		return;
 	}
 	fwrite(sb->buf, sb->len, 1, fp);
@@ -106,7 +115,7 @@ static void show_dir_entry(const char *tag, struct =
dir_entry *ent)
 	strbuf_reset(&sb);
 	strbuf_addstr(&sb, tag);
 	write_dir_entry(&sb, ent);
-	strbuf_fputs(&sb, stdout);
+	strbuf_fputs(&sb, ent->name, stdout);
 }
=20
 static void show_other_files(struct dir_struct *dir)
@@ -223,7 +232,7 @@ static void show_ce_entry(const char *tag, const st=
ruct cache_entry *ce)
 			    ce_stage(ce));
 	}
 	write_ce_name(&sb, ce);
-	strbuf_fputs(&sb, stdout);
+	strbuf_fputs(&sb, ce->name, stdout);
 	if (debug_mode) {
 		const struct stat_data *sd =3D &ce->ce_stat_data;
=20
@@ -524,6 +533,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 	const char *max_prefix;
 	struct dir_struct dir;
 	struct exclude_list *el;
+	struct column_options copts;
 	struct string_list exclude_list =3D STRING_LIST_INIT_NODUP;
 	struct option builtin_ls_files_options[] =3D {
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
@@ -671,7 +681,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		if (debug_mode)
 			die(_("--column and --debug are incompatible"));
 	}
-	if (column_active(colopts))
+	if (column_active(colopts) || porcelain)
 		line_terminator =3D 0;
=20
 	if (require_work_tree && !is_inside_work_tree())
@@ -737,13 +747,15 @@ int cmd_ls_files(int argc, const char **argv, con=
st char *cmd_prefix)
 	if (show_resolve_undo)
 		show_ru_info();
=20
-	if (column_active(colopts)) {
-		struct column_options copts;
-		memset(&copts, 0, sizeof(copts));
-		copts.padding =3D 2;
-		print_columns(&output, colopts, &copts);
-		string_list_clear(&output, 0);
+	memset(&copts, 0, sizeof(copts));
+	copts.padding =3D 2;
+	if (porcelain) {
+		qsort(output.items, output.nr, sizeof(*output.items),
+		      compare_output);
+		string_list_remove_duplicates(&output, 0);
 	}
+	print_columns(&output, colopts, &copts);
+	string_list_clear(&output, 0);
=20
 	if (ps_matched) {
 		int bad;
--=20
1.9.1.345.ga1a145c
