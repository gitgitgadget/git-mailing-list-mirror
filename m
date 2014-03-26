From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/17] ls-files: split main ls-files logic into ls_files() function
Date: Wed, 26 Mar 2014 20:48:09 +0700
Message-ID: <1395841697-11742-10-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 14:48:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSoCE-00008H-DT
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 14:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbaCZNsm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 09:48:42 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:63469 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbaCZNsl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 09:48:41 -0400
Received: by mail-pb0-f44.google.com with SMTP id rp16so1950053pbb.31
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 06:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SUCvYg35fjK/VMkHUzs8tQNNeoHlNxqKsMJOD2/Jt3Y=;
        b=SVbVvhm6Z3SRRxUxX3p57xyHybe/I28RbLiyNXRsP5ad8h9KBLpGs4WFFGJyRvmKlK
         LUfGgeQhRUVj8KHcoenVaC1UZHVS+/gVSzp6tumA4EoL8qLoSAjjN3rn+HLeJkF8qDMl
         fpSCqFphWXuKe3d+wAqNdlfTdJNAWUNw1OKXYKQx3ubK7sQPR23hJmetHhFogFZHUP3N
         X1hNj5ISWE9mie+BGAfi8O21+C8wYtmIf4gg6lZWMUxDTnvWlLVbHOxvc0z8dNc+h+5/
         AKd96cyeFJ6ZYWNPeaz4RLaw1seyY8E3QR+7FG689gxqyMEiouOZy1M8w3mASn0FSh+Q
         QsEA==
X-Received: by 10.68.136.2 with SMTP id pw2mr17310891pbb.167.1395841721018;
        Wed, 26 Mar 2014 06:48:41 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id pq3sm58536282pbb.57.2014.03.26.06.48.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 06:48:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 26 Mar 2014 20:49:34 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245188>

This is a preparation step for the introduction of git-ls. "git ls"
has a different set of command line options, but it will eventually
call ls_files().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 164 +++++++++++++++++++++++++++------------------=
--------
 1 file changed, 85 insertions(+), 79 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 8eef423..20ca3f2 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -31,6 +31,8 @@ static int line_terminator =3D '\n';
 static int debug_mode;
 static int use_color;
 static unsigned int colopts;
+static int max_depth =3D -1;
+static int show_tag;
=20
 static const char *prefix;
 static int max_prefix_len;
@@ -42,6 +44,8 @@ static const char *with_tree;
 static int exc_given;
 static int exclude_args;
 static struct string_list output =3D STRING_LIST_INIT_NODUP;
+static struct dir_struct dir;
+static struct string_list exclude_list =3D STRING_LIST_INIT_NODUP;
=20
 static const char *tag_cached =3D "";
 static const char *tag_unmerged =3D "";
@@ -500,89 +504,12 @@ static int option_parse_exclude_standard(const st=
ruct option *opt,
 	return 0;
 }
=20
-int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
+static int ls_files(const char **argv, const char *prefix)
 {
-	int require_work_tree =3D 0, show_tag =3D 0, i;
-	int max_depth =3D -1;
+	int require_work_tree =3D 0, i;
 	const char *max_prefix;
-	struct dir_struct dir;
 	struct exclude_list *el;
-	struct string_list exclude_list =3D STRING_LIST_INIT_NODUP;
-	struct option builtin_ls_files_options[] =3D {
-		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
-			N_("paths are separated with NUL character"),
-			PARSE_OPT_NOARG, option_parse_z },
-		OPT_BOOL('t', NULL, &show_tag,
-			N_("identify the file status with tags")),
-		OPT_BOOL('v', NULL, &show_valid_bit,
-			N_("use lowercase letters for 'assume unchanged' files")),
-		OPT_BOOL('c', "cached", &show_cached,
-			N_("show cached files in the output (default)")),
-		OPT_BOOL('d', "deleted", &show_deleted,
-			N_("show deleted files in the output")),
-		OPT_BOOL('m', "modified", &show_modified,
-			N_("show modified files in the output")),
-		OPT_BOOL('o', "others", &show_others,
-			N_("show other files in the output")),
-		OPT_BIT('i', "ignored", &dir.flags,
-			N_("show ignored files in the output"),
-			DIR_SHOW_IGNORED),
-		OPT_BOOL('s', "stage", &show_stage,
-			N_("show staged contents' object name in the output")),
-		OPT_BOOL('k', "killed", &show_killed,
-			N_("show files on the filesystem that need to be removed")),
-		OPT_BIT(0, "directory", &dir.flags,
-			N_("show 'other' directories' name only"),
-			DIR_SHOW_OTHER_DIRECTORIES),
-		OPT_NEGBIT(0, "empty-directory", &dir.flags,
-			N_("don't show empty directories"),
-			DIR_HIDE_EMPTY_DIRECTORIES),
-		OPT_BOOL('u', "unmerged", &show_unmerged,
-			N_("show unmerged files in the output")),
-		OPT_BOOL(0, "resolve-undo", &show_resolve_undo,
-			    N_("show resolve-undo information")),
-		{ OPTION_CALLBACK, 'x', "exclude", &exclude_list, N_("pattern"),
-			N_("skip files matching pattern"),
-			0, option_parse_exclude },
-		{ OPTION_CALLBACK, 'X', "exclude-from", &dir, N_("file"),
-			N_("exclude patterns are read from <file>"),
-			0, option_parse_exclude_from },
-		OPT_STRING(0, "exclude-per-directory", &dir.exclude_per_dir, N_("fil=
e"),
-			N_("read additional per-directory exclude patterns in <file>")),
-		{ OPTION_CALLBACK, 0, "exclude-standard", &dir, NULL,
-			N_("add the standard git exclusions"),
-			PARSE_OPT_NOARG, option_parse_exclude_standard },
-		{ OPTION_SET_INT, 0, "full-name", &prefix_len, NULL,
-			N_("make the output relative to the project top directory"),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL },
-		OPT_BOOL(0, "error-unmatch", &error_unmatch,
-			N_("if any <file> is not in the index, treat this as an error")),
-		OPT_STRING(0, "with-tree", &with_tree, N_("tree-ish"),
-			N_("pretend that paths removed since <tree-ish> are still present")=
),
-		OPT__COLOR(&use_color, N_("show color")),
-		OPT_COLUMN(0, "column", &colopts, N_("show files in columns")),
-		{ OPTION_INTEGER, 0, "max-depth", &max_depth, N_("depth"),
-			N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
-			NULL, 1 },
-		OPT__ABBREV(&abbrev),
-		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
-		OPT_END()
-	};
-
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(ls_files_usage, builtin_ls_files_options);
=20
-	memset(&dir, 0, sizeof(dir));
-	prefix =3D cmd_prefix;
-	if (prefix)
-		prefix_len =3D strlen(prefix);
-	git_config(git_default_config, NULL);
-
-	if (read_cache() < 0)
-		die("index file corrupt");
-
-	argc =3D parse_options(argc, argv, prefix, builtin_ls_files_options,
-			ls_files_usage, 0);
 	el =3D add_exclude_list(&dir, EXC_CMDL, "--exclude option");
 	for (i =3D 0; i < exclude_list.nr; i++) {
 		add_exclude(exclude_list.items[i].string, "", 0, el, --exclude_args)=
;
@@ -681,3 +608,82 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *cmd_prefix)
=20
 	return 0;
 }
+
+int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
+{
+	struct option builtin_ls_files_options[] =3D {
+		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
+			N_("paths are separated with NUL character"),
+			PARSE_OPT_NOARG, option_parse_z },
+		OPT_BOOL('t', NULL, &show_tag,
+			N_("identify the file status with tags")),
+		OPT_BOOL('v', NULL, &show_valid_bit,
+			N_("use lowercase letters for 'assume unchanged' files")),
+		OPT_BOOL('c', "cached", &show_cached,
+			N_("show cached files in the output (default)")),
+		OPT_BOOL('d', "deleted", &show_deleted,
+			N_("show deleted files in the output")),
+		OPT_BOOL('m', "modified", &show_modified,
+			N_("show modified files in the output")),
+		OPT_BOOL('o', "others", &show_others,
+			N_("show other files in the output")),
+		OPT_BIT('i', "ignored", &dir.flags,
+			N_("show ignored files in the output"),
+			DIR_SHOW_IGNORED),
+		OPT_BOOL('s', "stage", &show_stage,
+			N_("show staged contents' object name in the output")),
+		OPT_BOOL('k', "killed", &show_killed,
+			N_("show files on the filesystem that need to be removed")),
+		OPT_BIT(0, "directory", &dir.flags,
+			N_("show 'other' directories' name only"),
+			DIR_SHOW_OTHER_DIRECTORIES),
+		OPT_NEGBIT(0, "empty-directory", &dir.flags,
+			N_("don't show empty directories"),
+			DIR_HIDE_EMPTY_DIRECTORIES),
+		OPT_BOOL('u', "unmerged", &show_unmerged,
+			N_("show unmerged files in the output")),
+		OPT_BOOL(0, "resolve-undo", &show_resolve_undo,
+			    N_("show resolve-undo information")),
+		{ OPTION_CALLBACK, 'x', "exclude", &exclude_list, N_("pattern"),
+			N_("skip files matching pattern"),
+			0, option_parse_exclude },
+		{ OPTION_CALLBACK, 'X', "exclude-from", &dir, N_("file"),
+			N_("exclude patterns are read from <file>"),
+			0, option_parse_exclude_from },
+		OPT_STRING(0, "exclude-per-directory", &dir.exclude_per_dir, N_("fil=
e"),
+			N_("read additional per-directory exclude patterns in <file>")),
+		{ OPTION_CALLBACK, 0, "exclude-standard", &dir, NULL,
+			N_("add the standard git exclusions"),
+			PARSE_OPT_NOARG, option_parse_exclude_standard },
+		{ OPTION_SET_INT, 0, "full-name", &prefix_len, NULL,
+			N_("make the output relative to the project top directory"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL },
+		OPT_BOOL(0, "error-unmatch", &error_unmatch,
+			N_("if any <file> is not in the index, treat this as an error")),
+		OPT_STRING(0, "with-tree", &with_tree, N_("tree-ish"),
+			N_("pretend that paths removed since <tree-ish> are still present")=
),
+		OPT__COLOR(&use_color, N_("show color")),
+		OPT_COLUMN(0, "column", &colopts, N_("show files in columns")),
+		{ OPTION_INTEGER, 0, "max-depth", &max_depth, N_("depth"),
+			N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
+			NULL, 1 },
+		OPT__ABBREV(&abbrev),
+		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
+		OPT_END()
+	};
+
+	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(ls_files_usage, builtin_ls_files_options);
+
+	prefix =3D cmd_prefix;
+	if (prefix)
+		prefix_len =3D strlen(prefix);
+	git_config(git_default_config, NULL);
+
+	if (read_cache() < 0)
+		die("index file corrupt");
+
+	argc =3D parse_options(argc, argv, prefix, builtin_ls_files_options,
+			ls_files_usage, 0);
+	return ls_files(argv, prefix);
+}
--=20
1.9.1.345.ga1a145c
