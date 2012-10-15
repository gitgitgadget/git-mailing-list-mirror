From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH UI experiment] diffstat: annotate/highlight new or removed files
Date: Mon, 15 Oct 2012 21:35:49 +0700
Message-ID: <1350311749-15447-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 16:36:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNlmU-0002MT-0K
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 16:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742Ab2JOOgW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 10:36:22 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51335 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab2JOOgV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 10:36:21 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4909086pad.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Svcia0gYwZsgzkL/nVXnigIaRZ8O0inJyEzbE2x500k=;
        b=hEoBn1aLqoYlkh3u0o9joBfxRlTibPQYABeEk0suZKsQIqtlk5rlLRzirf0kW+qogN
         +OV3L3UgL0YNyLZ6YLcazOHV+u7Po9d132Qx3yKAInK+9v8xlxKqGE++TikEtVBBu+/Z
         MwdMraO4oTAFbgtf5fzChaOSDmZMG74tgTcgspxQdW1RTrtdCfE8ozOuK1FCMyHyq+gl
         OaZUGmS8+0KWbdg4Rlp7vUFl1+U6GyR9lYwxJdKc986LpsS4Gvbch+OqVd3FD48JbUS3
         jE6pt89ojL3yod6GmzHKtZWQ6IDyjQa5Zc0yVCjAr/n5XEsCk9sNZsgVxY5bMRVOFnr4
         3Xzw==
Received: by 10.66.75.168 with SMTP id d8mr33401957paw.63.1350311781099;
        Mon, 15 Oct 2012 07:36:21 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.44.221])
        by mx.google.com with ESMTPS id bv6sm9181938pab.13.2012.10.15.07.36.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Oct 2012 07:36:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 21:36:00 +0700
X-Mailer: git-send-email 1.8.0.rc2.11.g2b79d01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207749>

diffstat does not show whether a file is added or deleted. I know
--summary does. But the problem with --summary is it makes me look for
information of a file in two places: diffstat and summary. And with a
commit that adds/removes a lot, showing both --stat --summary can be
long.

This patch adds "(new)", "(gone)" or "(new mode)" to diffstat, with
highlight, to easily catch file additions/removals. The extra text is
chosen to be short enough so that it won't take up too much space for
path names:

 .gitignore                  |   1 +
 Makefile                    |   3 +
 t/t3070-wildmatch.sh (new)  | 188 ++++++++++++++++++++++++
 t/t3070/wildtest.txt (gone) | 165 ---------------------
 test-wildmatch.c (new)      |  14 ++
 wildmatch.c                 |   5 +-
 6 files changed, 210 insertions(+), 166 deletions(-)

I don't put creation modes in there too because most of the time it
does not matter much to me and I could look down to --summary for mode
verification. But we could put "(new+x)" for 0755 and just "(new)" for
0644. "(new mode)" then could become "(+x)", "(-x)" or something like
that.

Coloring is to me an improvement over --summary. Probably the main
point. Without it, perhaps it's not worth putting extra text to
diffstat.

Single patch for easy testing. Test suite probably breaks.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++---------=
--------
 diff.h |  3 ++-
 utf8.c | 33 +++++++++++++++++++++++++++
 utf8.h |  2 ++
 4 files changed, 97 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index 35d3f07..f9217e6 100644
--- a/diff.c
+++ b/diff.c
@@ -45,6 +45,7 @@ static char diff_colors[][COLOR_MAXLEN] =3D {
 	GIT_COLOR_YELLOW,	/* COMMIT */
 	GIT_COLOR_BG_RED,	/* WHITESPACE */
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
+	GIT_COLOR_YELLOW,	/* STATUSINFO */
 };
=20
 static int parse_diff_color_slot(const char *var, int ofs)
@@ -65,6 +66,8 @@ static int parse_diff_color_slot(const char *var, int=
 ofs)
 		return DIFF_WHITESPACE;
 	if (!strcasecmp(var+ofs, "func"))
 		return DIFF_FUNCINFO;
+	if (!strcasecmp(var+ofs, "status"))
+		return DIFF_STATUSINFO;
 	return -1;
 }
=20
@@ -1223,7 +1226,8 @@ static void fn_out_consume(void *priv, char *line=
, unsigned long len)
 	}
 }
=20
-static char *pprint_rename(const char *a, const char *b)
+static char *pprint_rename(struct diff_options *options,
+			   const char *a, const char *b)
 {
 	const char *old =3D a;
 	const char *new =3D b;
@@ -1237,7 +1241,9 @@ static char *pprint_rename(const char *a, const c=
har *b)
=20
 	if (qlen_a || qlen_b) {
 		quote_c_style(a, &name, NULL, 0);
-		strbuf_addstr(&name, " =3D> ");
+		strbuf_addf(&name, " %s=3D>%s ",
+			    diff_get_color_opt(options, DIFF_STATUSINFO),
+			    diff_get_color_opt(options, DIFF_RESET));
 		quote_c_style(b, &name, NULL, 0);
 		return strbuf_detach(&name, NULL);
 	}
@@ -1278,13 +1284,19 @@ static char *pprint_rename(const char *a, const=
 char *b)
 	strbuf_grow(&name, pfx_length + a_midlen + b_midlen + sfx_length + 7)=
;
 	if (pfx_length + sfx_length) {
 		strbuf_add(&name, a, pfx_length);
-		strbuf_addch(&name, '{');
+		strbuf_addf(&name, "%s{%s",
+			    diff_get_color_opt(options, DIFF_STATUSINFO),
+			    diff_get_color_opt(options, DIFF_RESET));
 	}
 	strbuf_add(&name, a + pfx_length, a_midlen);
-	strbuf_addstr(&name, " =3D> ");
+	strbuf_addf(&name, " %s=3D>%s ",
+		    diff_get_color_opt(options, DIFF_STATUSINFO),
+		    diff_get_color_opt(options, DIFF_RESET));
 	strbuf_add(&name, b + pfx_length, b_midlen);
 	if (pfx_length + sfx_length) {
-		strbuf_addch(&name, '}');
+		strbuf_addf(&name, "%s}%s",
+			    diff_get_color_opt(options, DIFF_STATUSINFO),
+			    diff_get_color_opt(options, DIFF_RESET));
 		strbuf_add(&name, a + len_a - sfx_length, sfx_length);
 	}
 	return strbuf_detach(&name, NULL);
@@ -1300,6 +1312,7 @@ struct diffstat_t {
 		unsigned is_unmerged:1;
 		unsigned is_binary:1;
 		unsigned is_renamed:1;
+		char status;
 		uintmax_t added, deleted;
 	} **files;
 };
@@ -1357,7 +1370,8 @@ static int scale_linear(int it, int width, int ma=
x_change)
 static void show_name(FILE *file,
 		      const char *prefix, const char *name, int len)
 {
-	fprintf(file, " %s%-*s |", prefix, len, name);
+	fprintf(file, " %s%-*s |", prefix,
+		len + strlen_ansi(name), name);
 }
=20
 static void show_graph(FILE *file, char ch, int cnt, const char *set, =
const char *reset)
@@ -1370,7 +1384,8 @@ static void show_graph(FILE *file, char ch, int c=
nt, const char *set, const char
 	fprintf(file, "%s", reset);
 }
=20
-static void fill_print_name(struct diffstat_file *file)
+static void fill_print_name(struct diff_options *options,
+			    struct diffstat_file *file)
 {
 	char *pname;
=20
@@ -1379,14 +1394,32 @@ static void fill_print_name(struct diffstat_fil=
e *file)
=20
 	if (!file->is_renamed) {
 		struct strbuf buf =3D STRBUF_INIT;
-		if (quote_c_style(file->name, &buf, NULL, 0)) {
+		if (quote_c_style(file->name, &buf, NULL, 0) ||
+		    file->status) {
+			const char *str =3D NULL;
+			switch (file->status) {
+			case DIFF_STATUS_ADDED:
+				str =3D "new";
+				break;
+			case DIFF_STATUS_DELETED:
+				str =3D "gone";
+				break;
+			case DIFF_STATUS_TYPE_CHANGED:
+				str =3D "new mode";
+				break;
+			}
+			if (str)
+				strbuf_addf(&buf, " (%s%s%s)",
+					    diff_get_color_opt(options, DIFF_STATUSINFO),
+					    str,
+					    diff_get_color_opt(options, DIFF_RESET));
 			pname =3D strbuf_detach(&buf, NULL);
 		} else {
 			pname =3D file->name;
 			strbuf_release(&buf);
 		}
 	} else {
-		pname =3D pprint_rename(file->from_name, file->name);
+		pname =3D pprint_rename(options, file->from_name, file->name);
 	}
 	file->print_name =3D pname;
 }
@@ -1474,8 +1507,8 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 			count++; /* not shown =3D=3D room for one more */
 			continue;
 		}
-		fill_print_name(file);
-		len =3D strlen(file->print_name);
+		fill_print_name(options, file);
+		len =3D strlen_no_ansi(file->print_name);
 		if (max_len < len)
 			max_len =3D len;
=20
@@ -1599,7 +1632,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 		 * "scale" the filename
 		 */
 		len =3D name_width;
-		name_len =3D strlen(name);
+		name_len =3D strlen_no_ansi(name);
 		if (name_width < name_len) {
 			char *slash;
 			prefix =3D "...";
@@ -1737,7 +1770,7 @@ static void show_numstat(struct diffstat_t *data,=
 struct diff_options *options)
 				"%"PRIuMAX"\t%"PRIuMAX"\t",
 				file->added, file->deleted);
 		if (options->line_termination) {
-			fill_print_name(file);
+			fill_print_name(options, file);
 			if (!file->is_renamed)
 				write_name_quoted(file->name, options->file,
 						  options->line_termination);
@@ -2397,13 +2430,15 @@ static void builtin_diffstat(const char *name_a=
, const char *name_b,
 			     struct diff_filespec *two,
 			     struct diffstat_t *diffstat,
 			     struct diff_options *o,
-			     int complete_rewrite)
+			     int complete_rewrite,
+			     char status)
 {
 	mmfile_t mf1, mf2;
 	struct diffstat_file *data;
 	int same_contents;
=20
 	data =3D diffstat_add(diffstat, name_a, name_b);
+	data->status =3D status;
=20
 	if (!one || !two) {
 		data->is_unmerged =3D 1;
@@ -3118,7 +3153,8 @@ static void run_diffstat(struct diff_filepair *p,=
 struct diff_options *o,
=20
 	if (DIFF_PAIR_UNMERGED(p)) {
 		/* unmerged */
-		builtin_diffstat(p->one->path, NULL, NULL, NULL, diffstat, o, 0);
+		builtin_diffstat(p->one->path, NULL, NULL, NULL,
+				 diffstat, o, 0, 0);
 		return;
 	}
=20
@@ -3133,7 +3169,8 @@ static void run_diffstat(struct diff_filepair *p,=
 struct diff_options *o,
=20
 	if (p->status =3D=3D DIFF_STATUS_MODIFIED && p->score)
 		complete_rewrite =3D 1;
-	builtin_diffstat(name, other, p->one, p->two, diffstat, o, complete_r=
ewrite);
+	builtin_diffstat(name, other, p->one, p->two, diffstat,
+			 o, complete_rewrite, p->status);
 }
=20
 static void run_checkdiff(struct diff_filepair *p, struct diff_options=
 *o)
@@ -4118,10 +4155,12 @@ static void show_mode_change(FILE *file, struct=
 diff_filepair *p, int show_name,
 	}
 }
=20
-static void show_rename_copy(FILE *file, const char *renamecopy, struc=
t diff_filepair *p,
-			const char *line_prefix)
+static void show_rename_copy(FILE *file, const char *renamecopy,
+			     struct diff_filepair *p,
+			     const char *line_prefix,
+			     struct diff_options *options)
 {
-	char *names =3D pprint_rename(p->one->path, p->two->path);
+	char *names =3D pprint_rename(options, p->one->path, p->two->path);
=20
 	fprintf(file, " %s %s (%d%%)\n", renamecopy, names, similarity_index(=
p));
 	free(names);
@@ -4149,11 +4188,11 @@ static void diff_summary(struct diff_options *o=
pt, struct diff_filepair *p)
 		break;
 	case DIFF_STATUS_COPIED:
 		fputs(line_prefix, file);
-		show_rename_copy(file, "copy", p, line_prefix);
+		show_rename_copy(file, "copy", p, line_prefix, opt);
 		break;
 	case DIFF_STATUS_RENAMED:
 		fputs(line_prefix, file);
-		show_rename_copy(file, "rename", p, line_prefix);
+		show_rename_copy(file, "rename", p, line_prefix, opt);
 		break;
 	default:
 		if (p->score) {
diff --git a/diff.h b/diff.h
index a658f85..c609512 100644
--- a/diff.h
+++ b/diff.h
@@ -167,7 +167,8 @@ enum color_diff {
 	DIFF_FILE_NEW =3D 5,
 	DIFF_COMMIT =3D 6,
 	DIFF_WHITESPACE =3D 7,
-	DIFF_FUNCINFO =3D 8
+	DIFF_FUNCINFO =3D 8,
+	DIFF_STATUSINFO =3D 9
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
diff --git a/utf8.c b/utf8.c
index a544f15..10823fd 100644
--- a/utf8.c
+++ b/utf8.c
@@ -317,6 +317,39 @@ static size_t display_mode_esc_sequence_len(const =
char *s)
 	return p - s;
 }
=20
+size_t strlen_no_ansi(const char *s)
+{
+	size_t len =3D 0;
+	for (;;) {
+		size_t skip;
+
+		while ((skip =3D display_mode_esc_sequence_len(s)))
+			s +=3D skip;
+		if (!*s)
+			break;
+		len++;
+		s++;
+	}
+	return len;
+}
+
+size_t strlen_ansi(const char *s)
+{
+	size_t len =3D 0;
+	for (;;) {
+		size_t skip;
+
+		while ((skip =3D display_mode_esc_sequence_len(s))) {
+			s +=3D skip;
+			len +=3D skip;
+		}
+		if (!*s)
+			break;
+		s++;
+	}
+	return len;
+}
+
 /*
  * Wrap the text, if necessary. The variable indent is the indent for =
the
  * first line, indent2 is the indent for all other lines.
diff --git a/utf8.h b/utf8.h
index 3c0ae76..fd4cfca 100644
--- a/utf8.h
+++ b/utf8.h
@@ -3,6 +3,8 @@
=20
 typedef unsigned int ucs_char_t;  /* assuming 32bit int */
=20
+size_t strlen_no_ansi(const char *s);
+size_t strlen_ansi(const char *s);
 int utf8_width(const char **start, size_t *remainder_p);
 int utf8_strwidth(const char *string);
 int is_utf8(const char *text);
--=20
1.8.0.rc2.11.g2b79d01
