From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 13/21] setup: support $GIT_SUPER_DIR as well as super .git files
Date: Sat, 14 Dec 2013 17:54:59 +0700
Message-ID: <1387018507-21999-14-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 11:52:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrmpn-0001Ar-0q
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543Ab3LNKwb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:52:31 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:55660 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab3LNKw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:52:29 -0500
Received: by mail-pa0-f54.google.com with SMTP id rd3so1070927pab.27
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Sq8EMfcPCOzQ8Ed+ii6j5FCdtIADpGaapYw+Wtd6m6A=;
        b=yQPiMPptqvc7Nj7icGUSuKek+xTfSZcaTV/8Wvb4pfUDX/1hMVybBTVRpruhojkNNv
         qOZswd3OLrYkNkJYUpQfy2ryzTTVOq3Rg1kFQHoUt2HJPyNyF7IvHEzqdpG7ynmBpefU
         lpmuLq9MoxlNifyvgejic6OndnkFRtrl8UucLW+O24V/cNbMqm9Etc8v51FJQltC9elS
         qqNoOFM+nKYAOQW6kyIWSnITAuy3Qwy3762AZm7e6sFzMjE6KOOARriA+GFcm1BC1GGs
         ceAEYMdpteywtlIAGDn0wI7YrBffEypEb8/+HQ8ERXGZqCWmCpqGREBw1WR/DLwyzkgu
         yb/Q==
X-Received: by 10.68.170.225 with SMTP id ap1mr8663938pbc.117.1387018349348;
        Sat, 14 Dec 2013 02:52:29 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id ik1sm11439330pbc.9.2013.12.14.02.52.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:52:28 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:57:21 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239295>

The same rules for git repo setup apply except:

- detect super .git files, set $GIT_SUPER_DIR accordingly

- if $GIT_SUPER_DIR is set (or specified by super .git files), look
  for non-worktree stuff in this directory instead of $GIT_DIR. This
  mostly affects is_git_directory() and check_repository_format()

- the worktree setting precedence goes from lower to higher:
  core.worktree, GIT_SUPER_DIR then GIT_WORK_TREE

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt               |  3 +-
 Documentation/gitrepository-layout.txt | 10 ++++
 builtin/rev-parse.c                    |  6 +++
 cache.h                                |  1 +
 environment.c                          | 11 +++++
 setup.c                                | 89 ++++++++++++++++++++++++--=
--------
 t/t1501-worktree.sh                    | 52 ++++++++++++++++++++
 t/t1510-repo-setup.sh                  |  1 +
 trace.c                                |  1 +
 9 files changed, 147 insertions(+), 27 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a405806..df19aa8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -381,7 +381,8 @@ false), while all other repositories are assumed to=
 be bare (bare
=20
 core.worktree::
 	Set the path to the root of the working tree.
-	This can be overridden by the GIT_WORK_TREE environment
+	This can be overridden by the GIT_WORK_TREE
+	or GIT_SUPER_DIR environment
 	variable and the '--work-tree' command line option.
 	The value can be an absolute path or relative to the path to
 	the .git directory, which is either specified by --git-dir
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index aa03882..7ce31d4 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -29,6 +29,10 @@ containing superproject to `git checkout` a branch t=
hat does not
 have the submodule.  The `checkout` has to remove the entire
 submodule working tree, without losing the submodule repository.
=20
+If the text file contains `gitsuper: <path>`, this is a "working
+directory only" repository, attached to another repository and share
+everything with the attached repository except HEAD and the index.
+
 These things may exist in a Git repository.
=20
 objects::
@@ -214,6 +218,12 @@ shallow::
 modules::
 	Contains the git-repositories of the submodules.
=20
+repos/<id>::
+	If a repository's .git is a file contains two lines `gitsuper:
+	<path>` and `repo: <id>`. The directory `<path>/repos/<id>`
+	contains the real non-shared part of .git directory of the
+	repository in question (e.g. HEAD or index).
+
 SEE ALSO
 --------
 linkgit:git-init[1],
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 1d9ecaf..f5f766a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -725,6 +725,12 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
 				printf("%s%s.git\n", cwd, len && cwd[len-1] !=3D '/' ? "/" : "");
 				continue;
 			}
+			if (!strcmp(arg, "--git-super-dir")) {
+				const char *gitdir =3D getenv(GIT_SUPER_DIR_ENVIRONMENT);
+				if (gitdir)
+					puts(gitdir);
+				continue;
+			}
 			if (!strcmp(arg, "--resolve-git-dir")) {
 				const char *gitdir =3D resolve_gitdir(argv[i+1]);
 				if (!gitdir)
diff --git a/cache.h b/cache.h
index f85ee70..4c09223 100644
--- a/cache.h
+++ b/cache.h
@@ -406,6 +406,7 @@ extern char *get_object_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
+extern int set_git_dir_super(const char *path, const char *super);
 extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
 extern const char *get_git_work_tree(void);
diff --git a/environment.c b/environment.c
index cbfa879..5cbbe11 100644
--- a/environment.c
+++ b/environment.c
@@ -284,6 +284,17 @@ int set_git_dir(const char *path)
 	return 0;
 }
=20
+int set_git_dir_super(const char *path, const char *super)
+{
+	if (super && super !=3D path &&
+	    setenv(GIT_SUPER_DIR_ENVIRONMENT, super, 1))
+		return error("Could not set GIT_SUPER_DIR to '%s'", super);
+	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
+		return error("Could not set GIT_DIR to '%s'", path);
+	setup_git_env();
+	return 0;
+}
+
 const char *get_log_output_encoding(void)
 {
 	return git_log_output_encoding ? git_log_output_encoding
diff --git a/setup.c b/setup.c
index 397eecc..7ccb1f8 100644
--- a/setup.c
+++ b/setup.c
@@ -243,7 +243,8 @@ int is_inside_work_tree(void)
=20
 void setup_work_tree(void)
 {
-	const char *work_tree, *git_dir;
+	const char *work_tree, *git_dir, *git_super_dir;
+	char *super_new =3D NULL, *super_relative =3D NULL;
 	static int initialized =3D 0;
=20
 	if (initialized)
@@ -252,6 +253,9 @@ void setup_work_tree(void)
 	git_dir =3D get_git_dir();
 	if (!is_absolute_path(git_dir))
 		git_dir =3D real_path(get_git_dir());
+	git_super_dir =3D get_git_super_dir();
+	if (git_super_dir && !is_absolute_path(git_super_dir))
+		git_super_dir =3D super_new =3D xstrdup(real_path(get_git_super_dir(=
)));
 	if (!work_tree || chdir(work_tree))
 		die("This operation must be run in a work tree");
=20
@@ -262,8 +266,16 @@ void setup_work_tree(void)
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
 		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
=20
-	set_git_dir(remove_leading_path(git_dir, work_tree));
+	if (git_super_dir) {
+		super_relative =3D xstrdup(remove_leading_path(git_super_dir, work_t=
ree));
+		git_super_dir =3D super_relative;
+	}
+
+	set_git_dir_super(remove_leading_path(git_dir, work_tree),
+			  git_super_dir);
 	initialized =3D 1;
+	free(super_new);
+	free(super_relative);
 }
=20
 static int check_repository_format_gently(const char *gitdir, int *non=
git_ok)
@@ -386,24 +398,30 @@ const char *read_gitfile(const char *path)
=20
=20
 static const char *setup_explicit_git_dir(const char *gitdirenv,
+					  const char *super,
 					  char *cwd, int len,
 					  int *nongit_ok)
 {
 	const char *work_tree_env =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
 	const char *worktree;
-	char *gitfile;
+	char *gitfile, *super_new =3D NULL;
 	int offset;
=20
 	if (PATH_MAX - 40 < strlen(gitdirenv))
 		die("'$%s' too big", GIT_DIR_ENVIRONMENT);
=20
-	gitfile =3D (char*)read_gitfile(gitdirenv);
+	if (super)
+		gitfile =3D (char*)read_gitfile(gitdirenv);
+	else {
+		gitfile =3D (char*)read_gitfile_super(gitdirenv, &super_new);
+		super =3D super_new;
+	}
 	if (gitfile) {
 		gitfile =3D xstrdup(gitfile);
 		gitdirenv =3D gitfile;
 	}
=20
-	if (!is_git_directory(gitdirenv)) {
+	if (!is_git_directory_super(gitdirenv, super)) {
 		if (nongit_ok) {
 			*nongit_ok =3D 1;
 			goto done_null;
@@ -411,7 +429,7 @@ static const char *setup_explicit_git_dir(const cha=
r *gitdirenv,
 		die("Not a git repository: '%s'", gitdirenv);
 	}
=20
-	if (check_repository_format_gently(gitdirenv, nongit_ok))
+	if (check_repository_format_gently(super ? super : gitdirenv, nongit_=
ok))
 		goto done_null;
=20
 	/* #3, #7, #11, #15, #19, #23, #27, #31 (see t1510) */
@@ -422,10 +440,10 @@ static const char *setup_explicit_git_dir(const c=
har *gitdirenv,
 			die("core.bare and core.worktree do not make sense");
=20
 		/* #18, #26 */
-		set_git_dir(gitdirenv);
+		set_git_dir_super(gitdirenv, super);
 		goto done_null;
 	}
-	else if (git_work_tree_cfg) { /* #6, #14 */
+	else if (git_work_tree_cfg && !super) { /* #6, #14 */
 		if (is_absolute_path(git_work_tree_cfg))
 			set_git_work_tree(git_work_tree_cfg);
 		else {
@@ -443,7 +461,7 @@ static const char *setup_explicit_git_dir(const cha=
r *gitdirenv,
 	}
 	else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
 		/* #16d */
-		set_git_dir(gitdirenv);
+		set_git_dir_super(gitdirenv, super);
 		goto done_null;
 	}
 	else /* #2, #10 */
@@ -454,43 +472,47 @@ static const char *setup_explicit_git_dir(const c=
har *gitdirenv,
=20
 	/* both get_git_work_tree() and cwd are already normalized */
 	if (!strcmp(cwd, worktree)) { /* cwd =3D=3D worktree */
-		set_git_dir(gitdirenv);
+		set_git_dir_super(gitdirenv, super);
 		goto done_null;
 	}
=20
 	offset =3D dir_inside_of(cwd, worktree);
 	if (offset >=3D 0) {	/* cwd inside worktree? */
-		set_git_dir(real_path(gitdirenv));
+		set_git_dir_super(real_path(gitdirenv), super);
 		if (chdir(worktree))
 			die_errno("Could not chdir to '%s'", worktree);
 		cwd[len++] =3D '/';
 		cwd[len] =3D '\0';
 		free(gitfile);
+		free(super_new);
 		return cwd + offset;
 	}
=20
 	/* cwd outside worktree */
-	set_git_dir(gitdirenv);
+	set_git_dir_super(gitdirenv, super);
=20
 done_null:
 	free(gitfile);
+	free(super_new);
 	return NULL;
 }
=20
 static const char *setup_discovered_git_dir(const char *gitdir,
+					    const char *super,
 					    char *cwd, int offset, int len,
 					    int *nongit_ok)
 {
-	if (check_repository_format_gently(gitdir, nongit_ok))
+	if (check_repository_format_gently(super ? super : gitdir, nongit_ok)=
)
 		return NULL;
=20
 	/* --work-tree is set without --git-dir; use discovered one */
-	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
+	if (getenv(GIT_WORK_TREE_ENVIRONMENT) ||
+	    (git_work_tree_cfg && !super)) {
 		if (offset !=3D len && !is_absolute_path(gitdir))
 			gitdir =3D xstrdup(real_path(gitdir));
 		if (chdir(cwd))
 			die_errno("Could not come back to cwd");
-		return setup_explicit_git_dir(gitdir, cwd, len, nongit_ok);
+		return setup_explicit_git_dir(gitdir, super, cwd, len, nongit_ok);
 	}
=20
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
@@ -503,8 +525,8 @@ static const char *setup_discovered_git_dir(const c=
har *gitdir,
=20
 	/* #0, #1, #5, #8, #9, #12, #13 */
 	set_git_work_tree(".");
-	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
-		set_git_dir(gitdir);
+	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT) || super)
+		set_git_dir_super(gitdir, super);
 	inside_git_dir =3D 0;
 	inside_work_tree =3D 1;
 	if (offset =3D=3D len)
@@ -534,7 +556,7 @@ static const char *setup_bare_git_dir(char *cwd, in=
t offset, int len, int *nongi
 		gitdir =3D offset =3D=3D len ? "." : xmemdupz(cwd, offset);
 		if (chdir(cwd))
 			die_errno("Could not come back to cwd");
-		return setup_explicit_git_dir(gitdir, cwd, len, nongit_ok);
+		return setup_explicit_git_dir(gitdir, NULL, cwd, len, nongit_ok);
 	}
=20
 	inside_git_dir =3D 1;
@@ -613,8 +635,8 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 	const char *env_ceiling_dirs =3D getenv(CEILING_DIRECTORIES_ENVIRONME=
NT);
 	struct string_list ceiling_dirs =3D STRING_LIST_INIT_DUP;
 	static char cwd[PATH_MAX + 1];
-	const char *gitdirenv, *ret;
-	char *gitfile;
+	const char *gitdirenv, *ret, *super;
+	char *gitfile, *super_new =3D NULL;
 	int len, offset, offset_parent, ceil_offset =3D -1;
 	dev_t current_device =3D 0;
 	int one_filesystem =3D 1;
@@ -637,8 +659,10 @@ static const char *setup_git_directory_gently_1(in=
t *nongit_ok)
 	 * validation.
 	 */
 	gitdirenv =3D getenv(GIT_DIR_ENVIRONMENT);
+	super =3D getenv(GIT_SUPER_DIR_ENVIRONMENT);
 	if (gitdirenv)
-		return setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
+		return setup_explicit_git_dir(gitdirenv, super,
+					      cwd, len, nongit_ok);
=20
 	if (env_ceiling_dirs) {
 		int empty_entry_found =3D 0;
@@ -668,25 +692,38 @@ static const char *setup_git_directory_gently_1(i=
nt *nongit_ok)
 	if (one_filesystem)
 		current_device =3D get_device_or_die(".", NULL, 0);
 	for (;;) {
-		gitfile =3D (char*)read_gitfile(DEFAULT_GIT_DIR_ENVIRONMENT);
+		if (super)
+			gitfile =3D (char*)read_gitfile(DEFAULT_GIT_DIR_ENVIRONMENT);
+		else {
+			gitfile =3D (char*)read_gitfile_super(DEFAULT_GIT_DIR_ENVIRONMENT,
+							    &super_new);
+			super =3D super_new;
+		}
 		if (gitfile)
 			gitdirenv =3D gitfile =3D xstrdup(gitfile);
 		else {
-			if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
+			if (is_git_directory_super(DEFAULT_GIT_DIR_ENVIRONMENT, super))
 				gitdirenv =3D DEFAULT_GIT_DIR_ENVIRONMENT;
 		}
=20
 		if (gitdirenv) {
-			ret =3D setup_discovered_git_dir(gitdirenv,
+			ret =3D setup_discovered_git_dir(gitdirenv, super,
 						       cwd, offset, len,
 						       nongit_ok);
 			free(gitfile);
+			free(super_new);
 			return ret;
 		}
 		free(gitfile);
=20
-		if (is_git_directory("."))
-			return setup_bare_git_dir(cwd, offset, len, nongit_ok);
+		if (is_git_directory(".")) {
+			ret =3D setup_bare_git_dir(cwd, offset, len, nongit_ok);
+			free(super_new);
+			return ret;
+		}
+
+		free(super_new);
+		super_new =3D NULL;
=20
 		offset_parent =3D offset;
 		while (--offset_parent > ceil_offset && cwd[offset_parent] !=3D '/')=
;
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 8f36aa9..dcd8d16 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -346,4 +346,56 @@ test_expect_success 'relative $GIT_WORK_TREE and g=
it subprocesses' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'Split repo setup' '
+	mkdir work &&
+	mkdir -p repo.git/repos/foo &&
+	cp repo.git/HEAD repo.git/index repo.git/repos/foo
+'
+
+test_expect_success 'GIT_SUPER_DIR set' '
+	unset GIT_WORK_TREE GIT_DIR GIT_CONFIG &&
+	GIT_SUPER_DIR=3Drepo.git GIT_DIR=3Drepo.git/repos/foo git rev-parse -=
-git-super-dir >actual &&
+	echo repo.git >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'GIT_DIR set (1)' '
+	(
+		cat <<EOF >gitfile &&
+gitsuper: repo.git
+gitdir: foo
+EOF
+		cd work &&
+		GIT_DIR=3D../gitfile git rev-parse --git-super-dir >actual &&
+		echo ../repo.git >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'GIT_DIR set (2)' '
+	(
+		cat <<EOF >gitfile &&
+gitsuper: $TRASH_DIRECTORY/repo.git
+gitdir: foo
+EOF
+		cd work &&
+		GIT_DIR=3D../gitfile git rev-parse --git-super-dir >actual &&
+		echo "$TRASH_DIRECTORY"/repo.git >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'Auto discovery' '
+	(
+		cat <<EOF >.git &&
+gitsuper: repo.git
+gitdir: foo
+EOF
+		cd work &&
+		git rev-parse --git-super-dir >actual &&
+		echo repo.git >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index cf2ee78..713f4d7 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -106,6 +106,7 @@ setup_env () {
 expect () {
 	cat >"$1/expected" <<-EOF
 	setup: git_dir: $2
+	setup: git_super_dir: (null)
 	setup: worktree: $3
 	setup: cwd: $4
 	setup: prefix: $5
diff --git a/trace.c b/trace.c
index 3d744d1..53d800b 100644
--- a/trace.c
+++ b/trace.c
@@ -173,6 +173,7 @@ void trace_repo_setup(const char *prefix)
 		prefix =3D "(null)";
=20
 	trace_printf_key(key, "setup: git_dir: %s\n", quote_crnl(get_git_dir(=
)));
+	trace_printf_key(key, "setup: git_super_dir: %s\n", quote_crnl(get_gi=
t_super_dir()));
 	trace_printf_key(key, "setup: worktree: %s\n", quote_crnl(git_work_tr=
ee));
 	trace_printf_key(key, "setup: cwd: %s\n", quote_crnl(cwd));
 	trace_printf_key(key, "setup: prefix: %s\n", quote_crnl(prefix));
--=20
1.8.5.1.77.g42c48fa
