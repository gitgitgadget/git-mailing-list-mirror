From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 19/31] setup.c: support multi-checkout repo setup
Date: Sun, 13 Jul 2014 11:50:56 +0700
Message-ID: <1405227068-25506-20-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:54:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6BoO-0000nx-Dz
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbaGMEyx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:54:53 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:44330 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbaGMEyv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:54:51 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so3554938pab.8
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Bn5W8aSDgv4iwFp4GuR3efThwmEO6LSFs7BXWWg5GQU=;
        b=M4QpYUn4x0Nsh2JwqjMc2entj5c2SNDfJsUaqpfUAIfCfmfe6TxhKgTaILkNIEzwzU
         TJLXPNDV7Ly1kPNRkLkwoWX07IEzJEPJfrzLfnL2+PlyZfsTA2gt7Hfw/+hlsNzQg+U9
         uMWZQJMAQvsQEIEgKzuLQ71pNdcXMwRd310+zKtwXVqdzrbzNFLBgURYEEeW1Qaor2Fx
         e37TrnbwjxATkPKdM7GP+Ym2e1yatBAatcKoiDnWmAbl+VR9BSV57awfGZFIgWHpyWhC
         VK6R94jR2I/i8hMMxg/fvqfHWIXbsT0KpvrKA6bgzUuWSXnU8lISxA9ne/tB5adLIjM7
         4CdA==
X-Received: by 10.68.94.225 with SMTP id df1mr9020796pbb.86.1405227291029;
        Sat, 12 Jul 2014 21:54:51 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id v5sm9102848pdc.7.2014.07.12.21.54.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:54:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:54:51 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253422>

The repo setup procedure is updated to detect $GIT_DIR/commondir and
set $GIT_COMMON_DIR properly.

The core.worktree is ignored when $GIT_COMMON_DIR is set. This is
because the config file is shared in multi-checkout setup, but
checkout directories _are_ different. Making core.worktree effective
in all checkouts mean it's back to a single checkout.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt        |  2 ++
 Documentation/git-rev-parse.txt |  3 ++
 builtin/rev-parse.c             |  4 +++
 cache.h                         |  1 +
 environment.c                   |  8 ++---
 setup.c                         | 33 +++++++++++++-----
 t/t1501-worktree.sh             | 76 +++++++++++++++++++++++++++++++++=
++++++++
 t/t1510-repo-setup.sh           |  1 +
 trace.c                         |  1 +
 9 files changed, 115 insertions(+), 14 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1d718bd..286e539 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -380,6 +380,8 @@ false), while all other repositories are assumed to=
 be bare (bare
=20
 core.worktree::
 	Set the path to the root of the working tree.
+	If GIT_COMMON_DIR environment variable is set, core.worktree
+	is ignored and not used for determining the root of working tree.
 	This can be overridden by the GIT_WORK_TREE environment
 	variable and the '--work-tree' command-line option.
 	The value can be an absolute path or relative to the path to
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index 9465399..f1867d3 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -215,6 +215,9 @@ If `$GIT_DIR` is not defined and the current direct=
ory
 is not detected to lie in a Git repository or work tree
 print a message to stderr and exit with nonzero status.
=20
+--git-common-dir::
+	Show `$GIT_COMMON_DIR` if defined, else `$GIT_DIR`.
+
 --is-inside-git-dir::
 	When the current working directory is below the repository
 	directory print "true", otherwise "false".
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 7606d43..29475c5 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -757,6 +757,10 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
 				printf("%s%s.git\n", cwd, len && cwd[len-1] !=3D '/' ? "/" : "");
 				continue;
 			}
+			if (!strcmp(arg, "--git-common-dir")) {
+				puts(get_git_common_dir());
+				continue;
+			}
 			if (!strcmp(arg, "--resolve-git-dir")) {
 				const char *gitdir =3D argv[++i];
 				if (!gitdir)
diff --git a/cache.h b/cache.h
index b606ee4..e3ff7dc 100644
--- a/cache.h
+++ b/cache.h
@@ -422,6 +422,7 @@ extern char *get_object_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
+extern int get_common_dir(struct strbuf *sb, const char *gitdir);
 extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
 extern const char *get_git_work_tree(void);
diff --git a/environment.c b/environment.c
index 6b74f68..50ed40a 100644
--- a/environment.c
+++ b/environment.c
@@ -141,6 +141,7 @@ static char *git_path_from_env(const char *envvar, =
const char *git_dir,
=20
 static void setup_git_env(void)
 {
+	struct strbuf sb =3D STRBUF_INIT;
 	const char *gitfile;
 	const char *shallow_file;
=20
@@ -149,12 +150,9 @@ static void setup_git_env(void)
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
 	gitfile =3D read_gitfile(git_dir);
 	git_dir =3D xstrdup(gitfile ? gitfile : git_dir);
-	git_common_dir =3D getenv(GIT_COMMON_DIR_ENVIRONMENT);
-	if (git_common_dir) {
+	if (get_common_dir(&sb, git_dir))
 		git_common_dir_env =3D 1;
-		git_common_dir =3D xstrdup(git_common_dir);
-	} else
-		git_common_dir =3D git_dir;
+	git_common_dir =3D strbuf_detach(&sb, NULL);
 	git_object_dir =3D git_path_from_env(DB_ENVIRONMENT, git_common_dir,
 					   "objects", &git_db_env);
 	git_index_file =3D git_path_from_env(INDEX_ENVIRONMENT, git_dir,
diff --git a/setup.c b/setup.c
index 79f79f2..8f90bc3 100644
--- a/setup.c
+++ b/setup.c
@@ -224,14 +224,15 @@ void verify_non_filename(const char *prefix, cons=
t char *arg)
 	    "'git <command> [<revision>...] -- [<file>...]'", arg);
 }
=20
-static void get_common_dir(struct strbuf *sb, const char *gitdir)
+int get_common_dir(struct strbuf *sb, const char *gitdir)
 {
 	struct strbuf data =3D STRBUF_INIT;
 	struct strbuf path =3D STRBUF_INIT;
 	const char *git_common_dir =3D getenv(GIT_COMMON_DIR_ENVIRONMENT);
+	int ret =3D 0;
 	if (git_common_dir) {
 		strbuf_addstr(sb, git_common_dir);
-		return;
+		return 1;
 	}
 	strbuf_addf(&path, "%s/commondir", gitdir);
 	if (file_exists(path.buf)) {
@@ -246,10 +247,12 @@ static void get_common_dir(struct strbuf *sb, con=
st char *gitdir)
 			strbuf_addf(&path, "%s/", gitdir);
 		strbuf_addbuf(&path, &data);
 		strbuf_addstr(sb, real_path(path.buf));
+		ret =3D 1;
 	} else
 		strbuf_addstr(sb, gitdir);
 	strbuf_release(&data);
 	strbuf_release(&path);
+	return ret;
 }
=20
 /*
@@ -340,13 +343,26 @@ void setup_work_tree(void)
 	initialized =3D 1;
 }
=20
+static int check_repo_format(const char *var, const char *value, void =
*cb)
+{
+	if (strcmp(var, "core.repositoryformatversion") =3D=3D 0)
+		repository_format_version =3D git_config_int(var, value);
+	else if (strcmp(var, "core.sharedrepository") =3D=3D 0)
+		shared_repository =3D git_config_perm(var, value);
+	return 0;
+}
+
 static int check_repository_format_gently(const char *gitdir, int *non=
git_ok)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	const char *repo_config;
+	config_fn_t fn;
 	int ret =3D 0;
=20
-	get_common_dir(&sb, gitdir);
+	if (get_common_dir(&sb, gitdir))
+		fn =3D check_repo_format;
+	else
+		fn =3D check_repository_format_version;
 	strbuf_addstr(&sb, "/config");
 	repo_config =3D sb.buf;
=20
@@ -359,7 +375,7 @@ static int check_repository_format_gently(const cha=
r *gitdir, int *nongit_ok)
 	 * Use a gentler version of git_config() to check if this repo
 	 * is a good one.
 	 */
-	git_config_early(check_repository_format_version, NULL, repo_config);
+	git_config_early(fn, NULL, repo_config);
 	if (GIT_REPO_VERSION < repository_format_version) {
 		if (!nongit_ok)
 			die ("Expected git repo version <=3D %d, found %d",
@@ -831,11 +847,10 @@ int git_config_perm(const char *var, const char *=
value)
=20
 int check_repository_format_version(const char *var, const char *value=
, void *cb)
 {
-	if (strcmp(var, "core.repositoryformatversion") =3D=3D 0)
-		repository_format_version =3D git_config_int(var, value);
-	else if (strcmp(var, "core.sharedrepository") =3D=3D 0)
-		shared_repository =3D git_config_perm(var, value);
-	else if (strcmp(var, "core.bare") =3D=3D 0) {
+	int ret =3D check_repo_format(var, value, cb);
+	if (ret)
+		return ret;
+	if (strcmp(var, "core.bare") =3D=3D 0) {
 		is_bare_repository_cfg =3D git_config_bool(var, value);
 		if (is_bare_repository_cfg =3D=3D 1)
 			inside_work_tree =3D -1;
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 8f36aa9..e6ac7a4 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -346,4 +346,80 @@ test_expect_success 'relative $GIT_WORK_TREE and g=
it subprocesses' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'Multi-worktree setup' '
+	mkdir work &&
+	mkdir -p repo.git/repos/foo &&
+	cp repo.git/HEAD repo.git/index repo.git/repos/foo &&
+	sane_unset GIT_DIR GIT_CONFIG GIT_WORK_TREE
+'
+
+test_expect_success 'GIT_DIR set (1)' '
+	echo "gitdir: repo.git/repos/foo" >gitfile &&
+	echo ../.. >repo.git/repos/foo/commondir &&
+	(
+		cd work &&
+		GIT_DIR=3D../gitfile git rev-parse --git-common-dir >actual &&
+		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'GIT_DIR set (2)' '
+	echo "gitdir: repo.git/repos/foo" >gitfile &&
+	echo "$TRASH_DIRECTORY/repo.git" >repo.git/repos/foo/commondir &&
+	(
+		cd work &&
+		GIT_DIR=3D../gitfile git rev-parse --git-common-dir >actual &&
+		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'Auto discovery' '
+	echo "gitdir: repo.git/repos/foo" >.git &&
+	echo ../.. >repo.git/repos/foo/commondir &&
+	(
+		cd work &&
+		git rev-parse --git-common-dir >actual &&
+		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
+		test_cmp expect actual &&
+		echo haha >data1 &&
+		git add data1 &&
+		git ls-files --full-name :/ | grep data1 >actual &&
+		echo work/data1 >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '$GIT_DIR/common overrides core.worktree' '
+	mkdir elsewhere &&
+	git --git-dir=3Drepo.git config core.worktree "$TRASH_DIRECTORY/elsew=
here" &&
+	echo "gitdir: repo.git/repos/foo" >.git &&
+	echo ../.. >repo.git/repos/foo/commondir &&
+	(
+		cd work &&
+		git rev-parse --git-common-dir >actual &&
+		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
+		test_cmp expect actual &&
+		echo haha >data2 &&
+		git add data2 &&
+		git ls-files --full-name :/ | grep data2 >actual &&
+		echo work/data2 >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '$GIT_WORK_TREE overrides $GIT_DIR/common' '
+	echo "gitdir: repo.git/repos/foo" >.git &&
+	echo ../.. >repo.git/repos/foo/commondir &&
+	(
+		cd work &&
+		echo haha >data3 &&
+		git --git-dir=3D../.git --work-tree=3D. add data3 &&
+		git ls-files --full-name -- :/ | grep data3 >actual &&
+		echo data3 >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index e1b2a99..33c1a58 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -106,6 +106,7 @@ setup_env () {
 expect () {
 	cat >"$1/expected" <<-EOF
 	setup: git_dir: $2
+	setup: git_common_dir: $2
 	setup: worktree: $3
 	setup: cwd: $4
 	setup: prefix: $5
diff --git a/trace.c b/trace.c
index 08180a9..a594761 100644
--- a/trace.c
+++ b/trace.c
@@ -173,6 +173,7 @@ void trace_repo_setup(const char *prefix)
 		prefix =3D "(null)";
=20
 	trace_printf_key(key, "setup: git_dir: %s\n", quote_crnl(get_git_dir(=
)));
+	trace_printf_key(key, "setup: git_common_dir: %s\n", quote_crnl(get_g=
it_common_dir()));
 	trace_printf_key(key, "setup: worktree: %s\n", quote_crnl(git_work_tr=
ee));
 	trace_printf_key(key, "setup: cwd: %s\n", quote_crnl(cwd));
 	trace_printf_key(key, "setup: prefix: %s\n", quote_crnl(prefix));
--=20
1.9.1.346.ga2b5940
