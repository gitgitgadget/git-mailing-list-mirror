From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH WIP] Move worktree setup out of setup_git_directory*
Date: Sun, 9 Dec 2007 17:24:32 +0700
Message-ID: <20071209102432.GA18362@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 09 11:25:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1JLV-0002SG-IU
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 11:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbXLIKYr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Dec 2007 05:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbXLIKYr
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 05:24:47 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:53146 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbXLIKYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 05:24:45 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1254607rvb
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 02:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=U6d0GUOoXe68Wf8jxLlXLLvtSmmZfpSscP9qNOjJURk=;
        b=jrkb9W79zs2lcn/oM4pCWqnTrmsrEFy+7v/nji41Kq89MfWGzD+2KlEdbntlKUBGz6DM8dwceQ4OGpJvHLlruRMTDQ12z7udrFqGtDHVxT30w8+5eH49/xjQu/QKBiBcCeL7FLn1D2yfW1VF+eMnJWTl9cTMA/Nl6h9i5hxOlcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=JoPK0NNoziBDbLoc47IrgG5LohmxYtDo+7TpoBot57VmepiqRF+ArMAn85Jo02ZcZ7ghMjyEMlW/OYuvOZHLCjIDE9cb8AaDkhgKZfhg8it3e2fOLPYhMkXYPEa/cM+qYs9bEw0GvvK3omEwdc5WAEU4nlhU7teTztRj2X5KRgY=
Received: by 10.140.207.2 with SMTP id e2mr3570721rvg.1197195884755;
        Sun, 09 Dec 2007 02:24:44 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.3.72])
        by mx.google.com with ESMTPS id c20sm3824091rvf.2007.12.09.02.24.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Dec 2007 02:24:43 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  9 Dec 2007 17:24:32 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67614>

setup_git_directory* now work as if there is no worktree.
It may set some worktree-related variables but its prefix
(and current directory) should not be affected by worktree
settings.

While at it, put set_work_tree() code into
setup_git_directory_gently() for cleaner code.

Previously only setup_git_directory() takes worktree into
account when calculating prefix (with an exception). This
behaviour possibly gives commands that do only call
setup_git_directory_gently() wrong prefix. The behavior does
not expose often as setup_git_directory_gently() tries to
make correct prefix if both GIT_DIR and GIT_WORK_TREE
are set (the mentioned exception). Only if core.worktree
is used, the defect is summoned. Additional test is added
to catch this.

setup_work_tree() will now take the role of recalculating
prefix when worktree is required.

This also effectively reverts
dd5c8af176bb935a0b01a7dc2d5e022565c3aac3. The problem is IMHO
that git-diff does not setup worktree when it needs it, so
setting up worktree from setup_git_directory_gently() is a fix
in a wrong place.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Now I'm pretty sure I made it wrong in builtin-diff.c. But I
 found no better solution as diff territory is too far from my home.

 One more thing, with this change, "git ls-files -c" would show
 full path as it does not require a worktree, hence no worktree setup,
 NULL prefix or so. Is it bad?

 builtin-blame.c     |    4 +-
 builtin-diff.c      |    7 ++++-
 builtin-ls-files.c  |   10 +++---
 builtin-rev-parse.c |    2 +
 builtin-rm.c        |    2 +-
 cache.h             |    2 +-
 git.c               |    2 +-
 setup.c             |   80 ++++++++++++++++---------------------------=
-------
 t/t1501-worktree.sh |    8 ++++-
 9 files changed, 51 insertions(+), 66 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index c158d31..160a1cd 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2280,6 +2280,7 @@ int cmd_blame(int argc, const char **argv, const =
char *prefix)
 			/* (3) */
 			if (argc <=3D i)
 				usage(blame_usage);
+			prefix =3D setup_work_tree(prefix);
 			path =3D add_prefix(prefix, argv[i]);
 			if (i + 1 =3D=3D argc - 1) {
 				final_commit_name =3D argv[i + 1];
@@ -2295,7 +2296,6 @@ int cmd_blame(int argc, const char **argv, const =
char *prefix)
 			else if (i !=3D argc - 1)
 				usage(blame_usage); /* garbage at end */
=20
-			setup_work_tree();
 			if (!has_path_in_work_tree(path))
 				die("cannot stat path %s: %s",
 				    path, strerror(errno));
@@ -2343,7 +2343,7 @@ int cmd_blame(int argc, const char **argv, const =
char *prefix)
 		 * do not default to HEAD, but use the working tree
 		 * or "--contents".
 		 */
-		setup_work_tree();
+		prefix =3D setup_work_tree(prefix);
 		sb.final =3D fake_working_tree_commit(path, contents_from);
 		add_pending_object(&revs, &(sb.final->object), ":");
 	}
diff --git a/builtin-diff.c b/builtin-diff.c
index 1b61599..24c3080 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -246,8 +246,13 @@ int cmd_diff(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
 		argc =3D 0;
-	else
+	else {
+		prefix =3D setup_work_tree(prefix);
+		/* reinitialize rev as prefix can change */
+		init_revisions(&rev, prefix);
+		rev.diffopt.skip_stat_unmatch =3D !!diff_auto_refresh_index;
 		argc =3D setup_revisions(argc, argv, &rev, NULL);
+	}
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format =3D DIFF_FORMAT_PATCH;
 		if (diff_setup_done(&rev.diffopt) < 0)
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 0f0ab2d..3da6d0c 100644
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
@@ -433,8 +433,6 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 	struct dir_struct dir;
=20
 	memset(&dir, 0, sizeof(dir));
-	if (prefix)
-		prefix_offset =3D strlen(prefix);
 	git_config(git_default_config);
=20
 	for (i =3D 1; i < argc; i++) {
@@ -566,8 +564,10 @@ int cmd_ls_files(int argc, const char **argv, cons=
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
index 20d1789..e48c7ea 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -441,6 +441,8 @@ int cmd_rev_parse(int argc, const char **argv, cons=
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
index a3d25e6..920a18f 100644
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
index b5811ec..08d7bf6 100644
--- a/cache.h
+++ b/cache.h
@@ -229,7 +229,7 @@ extern const char *get_git_work_tree(void);
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
index c8b7e74..4b3b6b9 100644
--- a/git.c
+++ b/git.c
@@ -259,7 +259,7 @@ static int run_command(struct cmd_struct *p, int ar=
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
index b59dbe7..e23ee8d 100644
--- a/setup.c
+++ b/setup.c
@@ -188,38 +188,25 @@ int is_inside_work_tree(void)
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
@@ -262,24 +249,21 @@ const char *setup_git_directory_gently(int *nongi=
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
@@ -387,17 +371,5 @@ int check_repository_format(void)
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
index 7ee3820..3b610ac 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -58,6 +58,12 @@ cd sub/dir || exit 1
 test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
=20
+test_expect_success 'setup_work_tree() gives correct prefix' '
+	(cd work/sub && touch untracked &&
+	test "$(git ls-files -o)" =3D untracked)'
+
+rm work/sub/untracked || exit 1
+
 say "GIT_WORK_TREE=3Drelative path (override core.worktree)"
 export GIT_DIR=3D$(pwd)/repo.git
 export GIT_CONFIG=3D$GIT_DIR/config
@@ -103,7 +109,7 @@ test_expect_success 'repo finds its work tree from =
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
1.5.3.7.2155.g4c25
