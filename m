From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] Move worktree setup out of setup_git_directory*
Date: Sun, 24 Feb 2008 11:46:51 +0700
Message-ID: <20080224044650.GA25343@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 05:47:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT8ls-0002Vx-EF
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 05:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755918AbYBXEqw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2008 23:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbYBXEqw
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 23:46:52 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:39141 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886AbYBXEqu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 23:46:50 -0500
Received: by rv-out-0910.google.com with SMTP id k20so651375rvb.1
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 20:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=ccRNF9aGkCLKykji2cl/BSd5a6Be5FkCnlnP5X3N3i4=;
        b=YkjwNq1W6QI3lg56qnf3RAxuRVLk3hKUNob8cgE52mrdDEfI+na6PXml2e66GG7XCMc91GrmuOlu//DELN3f124oK4wwIoc6c1kIMZySCMLVHKwobbGrdxTwqpNcBjPRkY0ullW2caH4+1Mg0g+hsPO+3dqOf8jsFy8wCr+Rlwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=M0R4A/kNgJ8UHtoVbWoZ2Y7xEOQ3xEcyPoGqPlbbP+1SwuaJ5N2wHjGQWQ0qRqJSMnpufDydrdYgQl/N1zwVizzztKXwruagaJhHSDezRyBVUaKZcwxuQyarwHqUWCypCWDkoEreMLVqaua/AYmca7wjalOUgKi4EA9EqFKnUtc=
Received: by 10.141.204.16 with SMTP id g16mr843379rvq.275.1203828410243;
        Sat, 23 Feb 2008 20:46:50 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.231])
        by mx.google.com with ESMTPS id g1sm8094262rvb.0.2008.02.23.20.46.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Feb 2008 20:46:48 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Feb 2008 11:46:51 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74901>

setup_git_directory* now work as if there is no worktree.  It may set
some worktree-related variables but its prefix (and current directory)
should not be affected by worktree settings.

Previously only setup_git_directory() takes worktree into account when
calculating prefix (with an exception). This behaviour possibly gives
commands that do only call setup_git_directory_gently() wrong prefix.
The behavior does not expose often as setup_git_directory_gently()
tries to make correct prefix if both GIT_DIR and GIT_WORK_TREE are set
(the mentioned exception). Only if core.worktree is used, the defect
is summoned.

setup_work_tree() will now take the role of recalculating prefix when
worktree is required.

This also effectively reverts dd5c8af (Fix
setup_git_directory_gently() with relative GIT_DIR & GIT_WORK_TREE).
The problem is IMHO that git-diff does not setup worktree when it
needs it, so setting up worktree from setup_git_directory_gently() is
a fix in a wrong place.

While at it, fix builtin-diff-files.c as well with the same problem.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup_git_directory() is now just a thin wrapper around _gently(). Swe=
et.

 builtin-blame.c      |    4 +-
 builtin-diff-files.c |    4 ++-
 builtin-diff.c       |    5 ++-
 builtin-ls-files.c   |   10 +++---
 builtin-rev-parse.c  |    2 +
 builtin-rm.c         |    2 +-
 cache.h              |    2 +-
 git.c                |    2 +-
 setup.c              |   80 ++++++++++++++++--------------------------=
-------
 t/t1501-worktree.sh  |   30 ++++++++++++++++++-
 10 files changed, 74 insertions(+), 67 deletions(-)

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
index 4abe3c2..e3cc5cc 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -26,8 +26,10 @@ int cmd_diff_files(int argc, const char **argv, cons=
t char *prefix)
=20
 	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
 		argc =3D 0;
-	else
+	else {
+		rev.prefix =3D prefix =3D setup_work_tree(prefix);
 		argc =3D setup_revisions(argc, argv, &rev, NULL);
+	}
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format =3D DIFF_FORMAT_RAW;
 	result =3D run_diff_files_cmd(&rev, argc, argv);
diff --git a/builtin-diff.c b/builtin-diff.c
index 444ff2f..93221a0 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -244,8 +244,11 @@ int cmd_diff(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
 		argc =3D 0;
-	else
+	else {
+		rev.prefix =3D prefix =3D setup_work_tree(prefix);
+		rev.diffopt.skip_stat_unmatch =3D !!diff_auto_refresh_index;
 		argc =3D setup_revisions(argc, argv, &rev, NULL);
+	}
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format =3D DIFF_FORMAT_PATCH;
 		if (diff_setup_done(&rev.diffopt) < 0)
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 25dbfb4..4d833e1 100644
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
@@ -568,8 +566,10 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *prefix)
 		break;
 	}
=20
-	if (require_work_tree && !is_inside_work_tree())
-		setup_work_tree();
+	if (require_work_tree)
+		prefix =3D setup_work_tree(prefix);
+	if (prefix_offset =3D=3D -1)
+		prefix_offset =3D prefix ? strlen(prefix) : 0;
=20
 	pathspec =3D get_pathspec(prefix, argv + i);
=20
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index b9af1a5..9f05cb3 100644
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
index a5b9ffd..dc768db 100644
--- a/cache.h
+++ b/cache.h
@@ -282,7 +282,7 @@ extern const char *get_git_work_tree(void);
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
index 4f804a2..90451ee 100644
--- a/git.c
+++ b/git.c
@@ -252,7 +252,7 @@ static int run_command(struct cmd_struct *p, int ar=
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
index 89c81e5..b181b24 100644
--- a/setup.c
+++ b/setup.c
@@ -262,38 +262,25 @@ int is_inside_work_tree(void)
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
 	const char *work_tree, *git_dir;
-	static int initialized =3D 0;
+	static char buffer[PATH_MAX + 1];
+	char *rel;
=20
-	if (initialized)
-		return;
-	work_tree =3D get_git_work_tree();
 	git_dir =3D get_git_dir();
 	if (!is_absolute_path(git_dir))
 		set_git_dir(make_absolute_path(git_dir));
-	if (!work_tree || chdir(work_tree))
+	work_tree =3D get_git_work_tree();
+	if (!work_tree)
+		die("This operation must be run in a work tree");
+	if (prefix && chdir(prefix))
+		die ("Could not jump back into original cwd");
+	rel =3D get_relative_cwd(buffer, PATH_MAX, work_tree);
+	trace_printf("test: worktree =3D %s\n", rel ? rel : "NULL");
+	if (chdir(work_tree))
 		die("This operation must be run in a work tree");
-	initialized =3D 1;
+	return rel && *rel ? strcat(rel, "/") : NULL;
 }
=20
 static int check_repository_format_gently(int *nongit_ok)
@@ -336,24 +323,21 @@ const char *setup_git_directory_gently(int *nongi=
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
@@ -462,17 +446,5 @@ int check_repository_format(void)
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
-
-	return retval;
+	return setup_git_directory_gently(NULL);
 }
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 7ee3820..2b1629b 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -58,6 +58,34 @@ cd sub/dir || exit 1
 test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
=20
+test_expect_success 'git ls-files -o gets correct prefix' '
+	(cd work/sub && touch untracked &&
+	test "$(git ls-files -o)" =3D untracked)'
+
+rm work/sub/untracked || exit 1
+
+cat <<EOF >expected
+:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 00000000000000=
00000000000000000000000000 M	sub/tracked
+EOF
+
+test_expect_success 'git diff-files gets correct prefix' '
+	(cd work/sub  && touch tracked &&
+	git add tracked && echo modified > tracked &&
+	git diff-files > ../../result &&
+	git rm -f tracked) &&
+	cmp result expected'
+
+cat <<EOF >expected
+:100644 100644 e69de29... 0000000... M	sub/tracked
+EOF
+
+test_expect_success 'git diff gets correct prefix' '
+	(cd work/sub  && touch tracked &&
+	git add tracked && echo modified > tracked &&
+	git diff --raw > ../../result &&
+	git rm -f tracked) &&
+	cmp result expected'
+
 say "GIT_WORK_TREE=3Drelative path (override core.worktree)"
 export GIT_DIR=3D$(pwd)/repo.git
 export GIT_CONFIG=3D$GIT_DIR/config
@@ -103,7 +131,7 @@ test_expect_success 'repo finds its work tree from =
work tree, too' '
 	 test sub/dir/tracked =3D "$(git ls-files)")
 '
=20
-test_expect_success '_gently() groks relative GIT_DIR & GIT_WORK_TREE'=
 '
+test_expect_success '"git diff" setup worktree properly' '
 	cd repo.git/work/sub/dir &&
 	GIT_DIR=3D../../.. GIT_WORK_TREE=3D../.. GIT_PAGER=3D \
 		git diff --exit-code tracked &&
--=20
1.5.4.2.281.g28d0e
