From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 06/10] Completely move out worktree setup from
	setup_git_directory_gently()
Date: Sun, 2 Mar 2008 17:34:33 +0700
Message-ID: <20080302103433.GA8970@laptop>
References: <cover.1204453703.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 11:35:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVlXN-0003Om-PG
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 11:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbYCBKeo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2008 05:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbYCBKeo
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 05:34:44 -0500
Received: from gv-out-0910.google.com ([216.239.58.187]:54970 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbYCBKem (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 05:34:42 -0500
Received: by gv-out-0910.google.com with SMTP id s4so2353724gve.37
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 02:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=wrIg9rDnLXsMBHWq/wvJPncKtBfkWtnFFQgqzPvVYLg=;
        b=pJ59KHYvfG9r8ckrLdZ1bFwC/OBElmY88kNjRvJ4Kyf6j2bfgh0+tYtBv+ojdnPL8mnFyQFsyaxt2F8E6M/Z0PJxO2fKIs9sIYqMZfT5HX0CUGqznjvSYMm7bJ3gzP5DlwEKPvr2+c6GuFaK1bbAI3tatjKv3sbgWfLnGDWWlK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=TEonjyuXj6j3+BS28LtrD07+zZoCXM3KWWxIY2lTBeh25yHgCXa6zJNKskRFUDF0cq4lZ0elckA54gCva+jRNvsx7l8QiGfQfW6/74jkEyxhy6odOMS5q9VIjhKyB5HEdMN5xCZYS50bMSHJ/deMvgkDrZWeh6PkSHjJkfLtObs=
Received: by 10.114.25.3 with SMTP id 3mr1597898way.22.1204454079933;
        Sun, 02 Mar 2008 02:34:39 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.2.84])
        by mx.google.com with ESMTPS id l30sm18482656waf.53.2008.03.02.02.34.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 02:34:38 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  2 Mar 2008 17:34:33 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204453703.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75766>

This was impossible earlier because git_dir can be relative. Now that
git_dir is absolute, I see no reason for worktree setup inside
setup_git_directory_gently(). The semantic is now clearer: if you need
worktree, call setup_work_tree yourself (well, I will clean up
setup_git_directory() part later)

This patch will free some commands from prefix handling if they don't
ever need worktree.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-apply.c          |    7 +++++--
 builtin-bundle.c         |    9 ++-------
 builtin-config.c         |   15 +++++----------
 builtin-diff-files.c     |   11 ++++++-----
 builtin-diff.c           |   11 ++++++-----
 builtin-upload-archive.c |    4 ++--
 cache.h                  |    2 +-
 git.c                    |    6 +-----
 hash-object.c            |    8 +-------
 setup.c                  |   34 +++++++++++++++++-----------------
 10 files changed, 46 insertions(+), 61 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index a3f075d..b77e84e 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2998,8 +2998,11 @@ int cmd_apply(int argc, const char **argv, const=
 char *unused_prefix)
=20
 	const char *whitespace_option =3D NULL;
=20
-	prefix =3D setup_git_directory_gently(&is_not_gitdir);
-	prefix_length =3D prefix ? strlen(prefix) : 0;
+	setup_git_directory_gently(&is_not_gitdir);
+	if (!is_not_gitdir && is_inside_work_tree()) {
+		prefix =3D setup_work_tree(NULL);
+		prefix_length =3D prefix ? strlen(prefix) : 0;
+	}
 	git_config(git_apply_config);
 	if (apply_default_whitespace)
 		parse_whitespace_option(apply_default_whitespace);
diff --git a/builtin-bundle.c b/builtin-bundle.c
index 9f38e21..2a7687e 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -11,7 +11,7 @@
=20
 static const char *bundle_usage=3D"git-bundle (create <bundle> <git-re=
v-list args> | verify <bundle> | list-heads <bundle> [refname]... | unb=
undle <bundle> [refname]... )";
=20
-int cmd_bundle(int argc, const char **argv, const char *prefix)
+int cmd_bundle(int argc, const char **argv, const char *unused_prefix)
 {
 	struct bundle_header header;
 	int nongit =3D 0;
@@ -27,12 +27,7 @@ int cmd_bundle(int argc, const char **argv, const ch=
ar *prefix)
 	argc -=3D 2;
 	argv +=3D 2;
=20
-	prefix =3D setup_git_directory_gently(&nongit);
-	if (prefix && bundle_file[0] !=3D '/') {
-		snprintf(buffer, sizeof(buffer), "%s/%s", prefix, bundle_file);
-		bundle_file =3D buffer;
-	}
-
+	setup_git_directory_gently(&nongit);
 	memset(&header, 0, sizeof(header));
 	if (strcmp(cmd, "create") && (bundle_fd =3D
 				read_bundle_header(bundle_file, &header)) < 0)
diff --git a/builtin-config.c b/builtin-config.c
index 2b9a426..ae6be9b 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -262,11 +262,11 @@ static int get_colorbool(int argc, const char **a=
rgv)
 	}
 }
=20
-int cmd_config(int argc, const char **argv, const char *prefix)
+int cmd_config(int argc, const char **argv, const char *unused_prefix)
 {
 	int nongit =3D 0;
 	char* value;
-	const char *file =3D setup_git_directory_gently(&nongit);
+	setup_git_directory_gently(&nongit);
=20
 	while (1 < argc) {
 		if (!strcmp(argv[1], "--int"))
@@ -276,8 +276,8 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l")) {
 			if (argc !=3D 2)
 				usage(git_config_set_usage);
-			if (git_config(show_all_config) < 0 && file && errno)
-				die("unable to read config file %s: %s", file,
+			if (git_config(show_all_config) < 0 && errno)
+				die("unable to read config file: %s",
 				    strerror(errno));
 			return 0;
 		}
@@ -296,12 +296,7 @@ int cmd_config(int argc, const char **argv, const =
char *prefix)
 		else if (!strcmp(argv[1], "--file") || !strcmp(argv[1], "-f")) {
 			if (argc < 3)
 				usage(git_config_set_usage);
-			if (!is_absolute_path(argv[2]) && file)
-				file =3D prefix_filename(file, strlen(file),
-						       argv[2]);
-			else
-				file =3D argv[2];
-			setenv(CONFIG_ENVIRONMENT, file, 1);
+			setenv(CONFIG_ENVIRONMENT, argv[2], 1);
 			argc--;
 			argv++;
 		}
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 11671a8..826f052 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -13,21 +13,22 @@ static const char diff_files_usage[] =3D
 "git-diff-files [-q] [-0/-1/2/3 |-c|--cc|--no-index] [<common diff opt=
ions>] [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
=20
-int cmd_diff_files(int argc, const char **argv, const char *prefix)
+int cmd_diff_files(int argc, const char **argv, const char *unused_pre=
fix)
 {
 	struct rev_info rev;
 	int nongit =3D 0;
 	int result;
=20
-	prefix =3D setup_git_directory_gently(&nongit);
-	init_revisions(&rev, prefix);
+	setup_git_directory_gently(&nongit);
+	init_revisions(&rev, NULL);
 	git_config(git_diff_basic_config); /* no "diff" UI options */
 	rev.abbrev =3D 0;
=20
-	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
+	if (!setup_diff_no_index(&rev, argc, argv, nongit, NULL))
 		argc =3D 0;
 	else {
-		rev.prefix =3D setup_work_tree(prefix);
+		init_revisions(&rev, setup_work_tree(NULL));
+		rev.abbrev =3D 0;
 		argc =3D setup_revisions(argc, argv, &rev, NULL);
 	}
 	if (!rev.diffopt.output_format)
diff --git a/builtin-diff.c b/builtin-diff.c
index 254e5a0..a92ab0e 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -202,7 +202,7 @@ static void refresh_index_quietly(void)
 	rollback_lock_file(lock_file);
 }
=20
-int cmd_diff(int argc, const char **argv, const char *prefix)
+int cmd_diff(int argc, const char **argv, const char *unused_prefix)
 {
 	int i;
 	struct rev_info rev;
@@ -233,19 +233,20 @@ int cmd_diff(int argc, const char **argv, const c=
har *prefix)
 	 * Other cases are errors.
 	 */
=20
-	prefix =3D setup_git_directory_gently(&nongit);
+	setup_git_directory_gently(&nongit);
 	git_config(git_diff_ui_config);
=20
 	if (diff_use_color_default =3D=3D -1)
 		diff_use_color_default =3D git_use_color_default;
=20
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, NULL);
 	rev.diffopt.skip_stat_unmatch =3D !!diff_auto_refresh_index;
=20
-	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
+	if (!setup_diff_no_index(&rev, argc, argv, nongit, NULL))
 		argc =3D 0;
 	else {
-		rev.prefix =3D setup_work_tree(prefix);
+		init_revisions(&rev, setup_work_tree(NULL));
+		rev.diffopt.skip_stat_unmatch =3D !!diff_auto_refresh_index;
 		argc =3D setup_revisions(argc, argv, &rev, NULL);
 	}
 	if (!rev.diffopt.output_format) {
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 48ae09e..4f7fa35 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -17,7 +17,7 @@ static const char lostchild[] =3D
 "git-upload-archive: archiver process was lost";
=20
=20
-static int run_upload_archive(int argc, const char **argv, const char =
*prefix)
+static int run_upload_archive(int argc, const char **argv, const char =
*unused_prefix)
 {
 	struct archiver ar;
 	const char *sent_argv[MAX_ARGS];
@@ -67,7 +67,7 @@ static int run_upload_archive(int argc, const char **=
argv, const char *prefix)
 	/* parse all options sent by the client */
 	treeish_idx =3D parse_archive_args(sent_argc, sent_argv, &ar);
=20
-	parse_treeish_arg(sent_argv + treeish_idx, &ar.args, prefix);
+	parse_treeish_arg(sent_argv + treeish_idx, &ar.args, NULL);
 	parse_pathspec_arg(sent_argv + treeish_idx + 1, &ar.args);
=20
 	return ar.write_archive(&ar.args);
diff --git a/cache.h b/cache.h
index b98f7e8..33dcfb1 100644
--- a/cache.h
+++ b/cache.h
@@ -316,7 +316,7 @@ extern const char *get_git_work_tree(void);
=20
 extern const char **get_pathspec(const char *prefix, const char **path=
spec);
 extern const char *setup_work_tree(const char *prefix);
-extern const char *setup_git_directory_gently(int *);
+extern void setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
 extern const char *prefix_path(const char *prefix, int len, const char=
 *path);
 extern const char *prefix_filename(const char *prefix, int len, const =
char *path);
diff --git a/git.c b/git.c
index 9e53a2e..d87c33e 100644
--- a/git.c
+++ b/git.c
@@ -143,13 +143,12 @@ static int split_cmdline(char *cmdline, const cha=
r ***argv)
 static int handle_alias(int *argcp, const char ***argv)
 {
 	int nongit =3D 0, envchanged =3D 0, ret =3D 0, saved_errno =3D errno;
-	const char *subdir;
 	int count, option_count;
 	const char** new_argv;
 	const char *alias_command;
 	char *alias_string;
=20
-	subdir =3D setup_git_directory_gently(&nongit);
+	setup_git_directory_gently(&nongit);
=20
 	alias_command =3D (*argv)[0];
 	alias_string =3D alias_lookup(alias_command);
@@ -205,9 +204,6 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 		ret =3D 1;
 	}
=20
-	if (subdir)
-		chdir(subdir);
-
 	errno =3D saved_errno;
=20
 	return ret;
diff --git a/hash-object.c b/hash-object.c
index 46d57ad..5986701 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -38,14 +38,11 @@ int main(int argc, char **argv)
 	int i;
 	const char *type =3D blob_type;
 	int write_object =3D 0;
-	const char *prefix =3D NULL;
-	int prefix_length =3D -1;
 	int no_more_flags =3D 0;
 	int hashstdin =3D 0;
 	int nongit =3D 0;
=20
-	prefix =3D setup_git_directory_gently(&nongit);
-	prefix_length =3D prefix ? strlen(prefix) : 0;
+	setup_git_directory_gently(&nongit);
 	git_config(git_default_config);
=20
 	for (i =3D 1 ; i < argc; i++) {
@@ -80,9 +77,6 @@ int main(int argc, char **argv)
 				hash_stdin(type, write_object);
 				hashstdin =3D 0;
 			}
-			if (0 <=3D prefix_length)
-				arg =3D prefix_filename(prefix, prefix_length,
-						      arg);
 			hash_object(arg, type_from_string(type), write_object);
 			no_more_flags =3D 1;
 		}
diff --git a/setup.c b/setup.c
index 6c908a5..78ae2f9 100644
--- a/setup.c
+++ b/setup.c
@@ -301,7 +301,7 @@ static int check_repository_format_gently(int *nong=
it_ok)
  * We cannot decide in this function whether we are in the work tree o=
r
  * not, since the config can only be read _after_ this function was ca=
lled.
  */
-const char *setup_git_directory_gently(int *nongit_ok)
+void setup_git_directory_gently(int *nongit_ok)
 {
 	const char *work_tree_env =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
 	static char cwd[PATH_MAX+1];
@@ -335,11 +335,11 @@ const char *setup_git_directory_gently(int *nongi=
t_ok)
 				inside_work_tree =3D 1;
 			}
 			check_repository_format_gently(nongit_ok);
-			return NULL;
+			return;
 		}
 		if (nongit_ok) {
 			*nongit_ok =3D 1;
-			return NULL;
+			return;
 		}
 		die("Not a git repository: '%s'", gitdirenv);
 	}
@@ -364,9 +364,12 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 			inside_git_dir =3D 1;
 			if (!work_tree_env)
 				inside_work_tree =3D 0;
-			setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+			if (chdir(cwd))
+				die("Cannot come back to cwd");
+			cwd[offset] =3D '\0';
+			setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
 			check_repository_format_gently(nongit_ok);
-			return NULL;
+			return;
 		}
 		chdir("..");
 		do {
@@ -375,27 +378,23 @@ const char *setup_git_directory_gently(int *nongi=
t_ok)
 					if (chdir(cwd))
 						die("Cannot come back to cwd");
 					*nongit_ok =3D 1;
-					return NULL;
+					return;
 				}
 				die("Not a git repository");
 			}
 		} while (cwd[--offset] !=3D '/');
 	}
=20
+	if (chdir(cwd))
+		die("Cannot come back to cwd");
 	inside_git_dir =3D 0;
 	if (!work_tree_env)
 		inside_work_tree =3D 1;
 	git_work_tree_cfg =3D xstrndup(cwd, offset);
-	if (check_repository_format_gently(nongit_ok))
-		return NULL;
-	if (offset =3D=3D len)
-		return NULL;
