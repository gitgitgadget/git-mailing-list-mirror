From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 4/9] Make setup_work_tree() return new prefix
Date: Wed, 27 Feb 2008 23:39:02 +0700
Message-ID: <20080227163902.GA28058@laptop>
References: <cover.1204130175.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 17:39:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUPJp-0001Yw-EU
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 17:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbYB0QjL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 11:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752797AbYB0QjJ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 11:39:09 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:56726 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbYB0QjI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 11:39:08 -0500
Received: by an-out-0708.google.com with SMTP id d31so645074and.103
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 08:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=zRqqPVpdjE+hYeOJca5blx2sSRLmaCmMafjUXRKo5LE=;
        b=Am9xpn1nT6DwvKgD2RKINI6DRtF45zGKKT9QEKEmgRgKA/TcqMc9vs/Ba9xjHCFpVJ4+paZQBBNMljdVkBnbfaRiabC5bVFUpX1g+KGrDThHivZUhOT4/BuRmeyhLAMmdiP1xie8iXCbWEo5XGDSwR8BxssFmpJQQbIqigCqIlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=TwC5Z4j2vWUqQPC6wiMFFYxvowijY40Nin+qPUqBqPE9tIBZYhTpWaanG6Msx3zESH7lQ1Clmena+/P2wK4U1wqD5STwUb7q9r6j6BWyXTxk3ZrN6WrIAE+otHJjm4zpEgbmE4dr1wUY8cPvz53iBFVuB1QoRHENzN8oW1/vn4g=
Received: by 10.100.126.19 with SMTP id y19mr12580353anc.78.1204130347837;
        Wed, 27 Feb 2008 08:39:07 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.231])
        by mx.google.com with ESMTPS id c9sm11128902ana.35.2008.02.27.08.39.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Feb 2008 08:39:06 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Feb 2008 23:39:02 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204130175.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75236>

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
index 95318e3..0a398f9 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -220,7 +220,7 @@ int cmd_read_tree(int argc, const char **argv, cons=
t char *unused_prefix)
 		die("--exclude-per-directory is meaningless unless -u");
=20
 	if (opts.merge)
-		setup_work_tree();
+		setup_work_tree(NULL);
=20
 	if (opts.prefix) {
 		int pfxlen =3D strlen(opts.prefix);
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 651b5e6..e82cac2 100644
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
-
-	return retval;
+	return setup_git_directory_gently(NULL);
 }
--=20
1.5.4.2.281.g28d0e
