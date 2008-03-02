From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 04/10] Make setup_work_tree() return new prefix
Date: Sun, 2 Mar 2008 17:34:05 +0700
Message-ID: <20080302103405.GA8942@laptop>
References: <cover.1204453703.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 11:35:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVlWw-0003Hg-AC
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 11:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbYCBKeN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2008 05:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbYCBKeN
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 05:34:13 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:43439 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbYCBKeM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 05:34:12 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6063958wah.23
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 02:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=6FWsNyPi7bGGTAavElACo7UTaNsUiK89RhGPshrJVQM=;
        b=ZezhcPK3v6lKjiBUtvxJfnwg/MQeG2M8wprqSrgIEFPboPW5yXb8oti/Ju1G+0l6PoVrQTKIOMNEQmVi2m71joeWxNw9U4YugaGoytR1G0c+z8+o5TyKnJArCOtq1HohpHfmNbizDdYIhJj7jEA7rt5qDS/wilpGbW4Vym3o468=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=NY/U26ciacMc0lvuxqKFkM1vOayHr3xquvUv4mD40396oDHOwmu+pSSMuIsA2umgcbi627suoP5Ae8kzK1Bv7RZN2XNdBF3p7JpxUF4VfYrHwigAFiHNq9CLqO831qPPokV/lqdyVVVFC7mvRplRQOL9jUo6xAU8EVteMOs3vWg=
Received: by 10.114.14.1 with SMTP id 1mr913828wan.9.1204454051761;
        Sun, 02 Mar 2008 02:34:11 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.2.84])
        by mx.google.com with ESMTPS id l37sm18478435waf.25.2008.03.02.02.34.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 02:34:10 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  2 Mar 2008 17:34:05 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204453703.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75764>

worktree setup inside setup_git_directory*() is not perfect. It does
not take core.worktree into account. So when you do setup_work_tree(),
the real work tree may be not the one setup_git_directory*() gives you.
You need a new prefix in that case.

This also effectively reverts dd5c8af (Fix
setup_git_directory_gently() with relative GIT_DIR & GIT_WORK_TREE).
The problem is IMHO that git-diff does not setup worktree when it
needs it, so setting up worktree from setup_git_directory_gently() is
a fix in a wrong place.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-blame.c      |    4 +-
 builtin-diff-files.c |    4 ++-
 builtin-diff.c       |    4 ++-
 builtin-ls-files.c   |    8 ++--
 builtin-read-tree.c  |    2 +-
 builtin-rev-parse.c  |    2 +
 builtin-rm.c         |    2 +-
 cache.h              |    2 +-
 git.c                |    2 +-
 setup.c              |   84 ++++++++++++++++--------------------------=
--------
 10 files changed, 45 insertions(+), 69 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index bfd562d..f5a878b 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2291,6 +2291,7 @@ int cmd_blame(int argc, const char **argv, const =
char *prefix)
 			/* (3) */
 			if (argc <=3D i)
 				usage(blame_usage);
+			prefix =3D setup_work_tree(prefix);
 			path =3D add_prefix(prefix, argv[i]);
 			if (i + 1 =3D=3D argc - 1) {
 				final_commit_name =3D argv[i + 1];
@@ -2306,7 +2307,6 @@ int cmd_blame(int argc, const char **argv, const =
char *prefix)
 			else if (i !=3D argc - 1)
 				usage(blame_usage); /* garbage at end */
=20
-			setup_work_tree();
 			if (!has_path_in_work_tree(path))
 				die("cannot stat path %s: %s",
 				    path, strerror(errno));
@@ -2354,7 +2354,7 @@ int cmd_blame(int argc, const char **argv, const =
char *prefix)
 		 * do not default to HEAD, but use the working tree
 		 * or "--contents".
 		 */
-		setup_work_tree();
+		setup_work_tree(prefix);
 		sb.final =3D fake_working_tree_commit(path, contents_from);
 		add_pending_object(&revs, &(sb.final->object), ":");
 	}
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 4abe3c2..11671a8 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -26,8 +26,10 @@ int cmd_diff_files(int argc, const char **argv, cons=
t char *prefix)
=20
 	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
 		argc =3D 0;
-	else
+	else {
+		rev.prefix =3D setup_work_tree(prefix);
 		argc =3D setup_revisions(argc, argv, &rev, NULL);
+	}
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format =3D DIFF_FORMAT_RAW;
 	result =3D run_diff_files_cmd(&rev, argc, argv);
diff --git a/builtin-diff.c b/builtin-diff.c
index 444ff2f..254e5a0 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -244,8 +244,10 @@ int cmd_diff(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
 		argc =3D 0;
-	else
+	else {
+		rev.prefix =3D setup_work_tree(prefix);
 		argc =3D setup_revisions(argc, argv, &rev, NULL);
+	}
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format =3D DIFF_FORMAT_PATCH;
 		if (diff_setup_done(&rev.diffopt) < 0)
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 25dbfb4..cf4c492 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -23,7 +23,7 @@ static int show_valid_bit;
 static int line_terminator =3D '\n';
=20
 static int prefix_len;
-static int prefix_offset;
+static int prefix_offset =3D -1;
 static const char **pathspec;
 static int error_unmatch;
 static char *ps_matched;
@@ -435,8 +435,6 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 	struct dir_struct dir;
=20
 	memset(&dir, 0, sizeof(dir));
-	if (prefix)
-		prefix_offset =3D strlen(prefix);
 	git_config(git_default_config);
=20
 	for (i =3D 1; i < argc; i++) {
@@ -569,7 +567,9 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 	}
=20
 	if (require_work_tree && !is_inside_work_tree())
-		setup_work_tree();
+		prefix =3D setup_work_tree(prefix);
+	if (prefix_offset =3D=3D -1)
+		prefix_offset =3D prefix ? strlen(prefix) : 0;
=20
 	pathspec =3D get_pathspec(prefix, argv + i);
=20
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index a69bac4..851f24d 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -221,7 +221,7 @@ int cmd_read_tree(int argc, const char **argv, cons=
t char *unused_prefix)
 		die("--exclude-per-directory is meaningless unless -u");
=20
 	if (opts.merge && !opts.index_only)
-		setup_work_tree();
+		setup_work_tree(NULL);
=20
 	if (opts.prefix) {
 		int pfxlen =3D strlen(opts.prefix);
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 13412b4..3d3a309 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -472,6 +472,8 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--show-prefix")) {
+				if (is_inside_work_tree())
+					prefix =3D setup_work_tree(prefix);
 				if (prefix)
 					puts(prefix);
 				continue;
diff --git a/builtin-rm.c b/builtin-rm.c
index c0a8bb6..2c15d66 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -156,7 +156,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 		usage_with_options(builtin_rm_usage, builtin_rm_options);
=20
 	if (!index_only)
-		setup_work_tree();
+		prefix =3D setup_work_tree(prefix);
=20
 	pathspec =3D get_pathspec(prefix, argv);
 	seen =3D NULL;
diff --git a/cache.h b/cache.h
index bdefcc9..b98f7e8 100644
--- a/cache.h
+++ b/cache.h
@@ -315,7 +315,7 @@ extern const char *get_git_work_tree(void);
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
=20
 extern const char **get_pathspec(const char *prefix, const char **path=
spec);
-extern void setup_work_tree(void);
+extern const char *setup_work_tree(const char *prefix);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
 extern const char *prefix_path(const char *prefix, int len, const char=
 *path);
diff --git a/git.c b/git.c
index 1e3eb10..9e53a2e 100644
--- a/git.c
+++ b/git.c
@@ -241,7 +241,7 @@ static int run_command(struct cmd_struct *p, int ar=
gc, const char **argv)
 	if (p->option & USE_PAGER)
 		setup_pager();
 	if (p->option & NEED_WORK_TREE)
-		setup_work_tree();
+		prefix =3D setup_work_tree(prefix);
=20
 	trace_argv_printf(argv, "trace: built-in: git");
=20
diff --git a/setup.c b/setup.c
index 89c81e5..6c908a5 100644
--- a/setup.c
+++ b/setup.c
@@ -262,38 +262,23 @@ int is_inside_work_tree(void)
 	return inside_work_tree;
 }
=20
-/*
- * set_work_tree() is only ever called if you set GIT_DIR explicitely.
- * The old behaviour (which we retain here) is to set the work tree ro=
ot
- * to the cwd, unless overridden by the config, the command line, or
- * GIT_WORK_TREE.
- */
-static const char *set_work_tree(const char *dir)
-{
-	char buffer[PATH_MAX + 1];
-
-	if (!getcwd(buffer, sizeof(buffer)))
-		die ("Could not get the current working directory");
-	git_work_tree_cfg =3D xstrdup(buffer);
-	inside_work_tree =3D 1;
-
-	return NULL;
-}
-
-void setup_work_tree(void)
+const char *setup_work_tree(const char *prefix)
 {
-	const char *work_tree, *git_dir;
-	static int initialized =3D 0;
+	const char *work_tree;
+	static char buffer[PATH_MAX + 1];
+	char *rel;
=20
-	if (initialized)
-		return;
+	get_git_dir(); /* ensure git_dir has been initialized as cwd will cha=
nge */
 	work_tree =3D get_git_work_tree();
-	git_dir =3D get_git_dir();
-	if (!is_absolute_path(git_dir))
-		set_git_dir(make_absolute_path(git_dir));
-	if (!work_tree || chdir(work_tree))
+	if (!work_tree)
 		die("This operation must be run in a work tree");
-	initialized =3D 1;
+	if (prefix && chdir(prefix))
+		die ("Could not jump back into original cwd");
+	rel =3D get_relative_cwd(buffer, PATH_MAX, work_tree);
+	trace_printf("test: worktree =3D %s\n", rel ? rel : "NULL");
+	if (chdir(work_tree))
+		die("This operation must be run in a work tree");
+	return rel && *rel ? strcat(rel, "/") : NULL;
 }
=20
 static int check_repository_format_gently(int *nongit_ok)
@@ -336,24 +321,21 @@ const char *setup_git_directory_gently(int *nongi=
t_ok)
 			static char buffer[1024 + 1];
 			const char *retval;
=20
+			/*
+			 * The old behaviour (which we retain here) is to set
+			 * the work tree root to the cwd, unless overridden by
+			 * the config, the command line, or GIT_WORK_TREE.
+			 */
 			if (!work_tree_env) {
-				retval =3D set_work_tree(gitdirenv);
-				/* config may override worktree */
-				if (check_repository_format_gently(nongit_ok))
-					return NULL;
-				return retval;
+				char buffer[PATH_MAX + 1];
+
+				if (!getcwd(buffer, sizeof(buffer)))
+					die ("Could not get the current working directory");
+				git_work_tree_cfg =3D xstrdup(buffer);
+				inside_work_tree =3D 1;
 			}
-			if (check_repository_format_gently(nongit_ok))
-				return NULL;
-			retval =3D get_relative_cwd(buffer, sizeof(buffer) - 1,
-					get_git_work_tree());
-			if (!retval || !*retval)
-				return NULL;
-			set_git_dir(make_absolute_path(gitdirenv));
-			if (chdir(work_tree_env) < 0)
-				die ("Could not chdir to %s", work_tree_env);
-			strcat(buffer, "/");
-			return retval;
+			check_repository_format_gently(nongit_ok);
+			return NULL;
 		}
 		if (nongit_ok) {
 			*nongit_ok =3D 1;
@@ -462,17 +444,5 @@ int check_repository_format(void)
=20
 const char *setup_git_directory(void)
 {
-	const char *retval =3D setup_git_directory_gently(NULL);
-
-	/* If the work tree is not the default one, recompute prefix */
-	if (inside_work_tree < 0) {
-		static char buffer[PATH_MAX + 1];
-		char *rel;
-		if (retval && chdir(retval))
-			die ("Could not jump back into original cwd");
-		rel =3D get_relative_cwd(buffer, PATH_MAX, get_git_work_tree());
-		return rel && *rel ? strcat(rel, "/") : NULL;
-	}
