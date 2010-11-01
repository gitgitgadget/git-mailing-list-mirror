From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/9] setup: rework setup_explicit_git_dir()
Date: Mon,  1 Nov 2010 13:26:33 +0700
Message-ID: <1288592794-24221-8-git-send-email-pclouds@gmail.com>
References: <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 07:27:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCnrz-0001yM-Tc
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 07:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427Ab0KAG1k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 02:27:40 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36067 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab0KAG1i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 02:27:38 -0400
Received: by mail-gx0-f174.google.com with SMTP id 23so2961184gxk.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 23:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=O4LxGwJq4tes7+OG7MxWHjGsGakXL8SYwZCAX+rXcKw=;
        b=iD6JImmgz4zttz5PwYO8PPdF8qsrrppPNA/NzB5HJR+AT+10CH72rw6+/kfDVcjZrE
         dyOgBoqePqztG9eQ45NUdo2+dRt5StU3bP+2UOfGeSGZt4E7fL9WyJErY5FKabaZjkFi
         WFtJPKNToZYJ4D1AsDrKMkdXCZ0oZCylMOm8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qvxzh1VOdd5KPkD42to/qsbJRq9wmuyQSst96fwH14b79WaQf/TicoB4BLXlkjH7uz
         bjeqqHzz0TxHRKy4X3vo+q41zf6q834njqxT/v4OwaMOst21HZv/jDS8EvXJY0fI9Q4K
         74hdSI4z85A8WI9CHZGVXlMf+GshX9B+FG7v8=
Received: by 10.150.226.9 with SMTP id y9mr1197645ybg.102.1288592858095;
        Sun, 31 Oct 2010 23:27:38 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id m12sm129971ybn.0.2010.10.31.23.27.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 23:27:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 01 Nov 2010 13:27:37 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160465>

This function is the most complex one among the three setup_*
functions because all GIT_DIR, GIT_WORK_TREE, core.worktree and
core.bare are involved.

Because core.worktree is only effective inside
setup_explicit_git_dir() and the extra code in setup_git_directory()
is to handle that. The extra code can now be retired.

Also note that setup_explicit assignment is removed, worktree setting
is no longer decided by get_git_work_tree(). get_git_work_tree() will
be simplified in the next commit.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c               |  138 +++++++++++++----------
 t/t1510-repo-setup.sh |  286 ++++++++++++++++++++++++-----------------=
-------
 2 files changed, 221 insertions(+), 203 deletions(-)

diff --git a/setup.c b/setup.c
index 2dd5f78..f6ea1ac 100644
--- a/setup.c
+++ b/setup.c
@@ -208,24 +208,6 @@ int is_inside_work_tree(void)
 	return inside_work_tree;
 }
=20
-/*
- * set_work_tree() is only ever called if you set GIT_DIR explicitly.
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
 void setup_work_tree(void)
 {
 	const char *work_tree, *git_dir;
@@ -326,40 +308,92 @@ const char *read_gitfile_gently(const char *path)
 }
=20
 static const char *setup_explicit_git_dir(const char *gitdirenv,
-				const char *work_tree_env, int *nongit_ok)
+					  char *cwd, int len,
+					  int *nongit_ok)
 {
-	static char buffer[1024 + 1];
-	const char *retval;
+	const char *work_tree_env =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
+	const char *worktree;
+	char *gitfile;
=20
-	if (startup_info)
-		startup_info->setup_explicit =3D 1;
 	if (PATH_MAX - 40 < strlen(gitdirenv))
 		die("'$%s' too big", GIT_DIR_ENVIRONMENT);
+
+	gitfile =3D (char*)read_gitfile_gently(gitdirenv);
+	if (gitfile) {
+		gitfile =3D xstrdup(gitfile);
+		gitdirenv =3D gitfile;
+	}
+
 	if (!is_git_directory(gitdirenv)) {
 		if (nongit_ok) {
 			*nongit_ok =3D 1;
+			free(gitfile);
 			return NULL;
 		}
 		die("Not a git repository: '%s'", gitdirenv);
 	}
-	if (!work_tree_env) {
-		retval =3D set_work_tree(gitdirenv);
-		/* config may override worktree */
-		if (check_repository_format_gently(gitdirenv, nongit_ok))
-			return NULL;
-		return retval;
+
+	if (check_repository_format_gently(gitdirenv, nongit_ok)) {
+		free(gitfile);
+		return NULL;
 	}
-	if (check_repository_format_gently(gitdirenv, nongit_ok))
+
+	/* #3, #7, #11, #15, #19, #23, #27, #31 (see t1510) */
+	if (work_tree_env)
+		set_git_work_tree(work_tree_env);
+	else if (is_bare_repository_cfg > 0) {
+		if (git_work_tree_cfg) /* #22.2, #30 */
+			die("core.bare and core.worktree do not make sense");
+
+		/* #18, #26 */
+		set_git_dir(gitdirenv);
+		free(gitfile);
 		return NULL;
-	retval =3D get_relative_cwd(buffer, sizeof(buffer) - 1,
-			get_git_work_tree());
-	if (!retval || !*retval)
+	}
+	else if (git_work_tree_cfg) { /* #6, #14 */
+		if (is_absolute_path(git_work_tree_cfg))
+			set_git_work_tree(git_work_tree_cfg);
+		else {
+			char core_worktree[PATH_MAX];
+			if (chdir(gitdirenv))
+				die_errno("Could not chdir to '%s'", gitdirenv);
+			if (chdir(git_work_tree_cfg))
+				die_errno("Could not chdir to '%s'", git_work_tree_cfg);
+			if (!getcwd(core_worktree, PATH_MAX))
+				die_errno("Could not get directory '%s'", git_work_tree_cfg);
+			if (chdir(cwd))
+				die_errno("Could not come back to cwd");
+			set_git_work_tree(core_worktree);
+		}
+	}
+	else /* #2, #10 */
+		set_git_work_tree(".");
+
+	/* set_git_work_tree() must have been called by now */
+	worktree =3D get_git_work_tree();
+
+	/* both get_git_work_tree() and cwd are already normalized */
+	if (!strcmp(cwd, worktree)) { /* cwd =3D=3D worktree */
+		set_git_dir(gitdirenv);
+		free(gitfile);
 		return NULL;
-	set_git_dir(make_absolute_path(gitdirenv));
-	if (chdir(work_tree_env) < 0)
-		die_errno ("Could not chdir to '%s'", work_tree_env);
-	strcat(buffer, "/");
-	return retval;
+	}
+
+	if (!prefixcmp(cwd, worktree) &&
+	    cwd[strlen(worktree)] =3D=3D '/') { /* cwd inside worktree */
+		set_git_dir(make_absolute_path(gitdirenv));
+		if (chdir(worktree))
+			die_errno("Could not chdir to '%s'", worktree);
+		cwd[len++] =3D '/';
+		cwd[len] =3D '\0';
+		free(gitfile);
+		return cwd + strlen(worktree) + 1;
+	}
+
+	/* cwd outside worktree */
+	set_git_dir(gitdirenv);
+	free(gitfile);
+	return NULL;
 }
=20
 static const char *setup_discovered_git_dir(const char *gitdir,
@@ -440,7 +474,6 @@ static dev_t get_device_or_die(const char *path, co=
nst char *prefix)
  */
 static const char *setup_git_directory_gently_1(int *nongit_ok)
 {
-	const char *work_tree_env =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
 	const char *env_ceiling_dirs =3D getenv(CEILING_DIRECTORIES_ENVIRONME=
NT);
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv, *ret;
@@ -457,6 +490,10 @@ static const char *setup_git_directory_gently_1(in=
t *nongit_ok)
 	if (nongit_ok)
 		*nongit_ok =3D 0;
=20
+	if (!getcwd(cwd, sizeof(cwd)-1))
+		die_errno("Unable to read current working directory");
+	offset =3D len =3D strlen(cwd);
+
 	/*
 	 * If GIT_DIR is set explicitly, we're not going
 	 * to do any discovery, but we still do repository
@@ -464,10 +501,7 @@ static const char *setup_git_directory_gently_1(in=
t *nongit_ok)
 	 */
 	gitdirenv =3D getenv(GIT_DIR_ENVIRONMENT);
 	if (gitdirenv)
-		return setup_explicit_git_dir(gitdirenv, work_tree_env, nongit_ok);
-
-	if (!getcwd(cwd, sizeof(cwd)-1))
-		die_errno("Unable to read current working directory");
+		return setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
=20
 	ceil_offset =3D longest_ancestor_length(cwd, env_ceiling_dirs);
 	if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
@@ -484,7 +518,6 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 	 * - ../../.git/
 	 *   etc.
 	 */
-	offset =3D len =3D strlen(cwd);
 	one_filesystem =3D !git_env_bool("GIT_DISCOVERY_ACROSS_FILESYSTEM", 0=
);
 	if (one_filesystem)
 		current_device =3D get_device_or_die(".", NULL);
@@ -627,20 +660,5 @@ int check_repository_format(void)
  */
 const char *setup_git_directory(void)
 {
-	const char *retval =3D setup_git_directory_gently(NULL);
-
-	/* If the work tree is not the default one, recompute prefix */
-	if ((!startup_info || startup_info->setup_explicit) &&
-	    inside_work_tree < 0) {
-		static char buffer[PATH_MAX + 1];
-		char *rel;
-		if (retval && chdir(retval))
-			die_errno ("Could not jump back into original cwd");
-		rel =3D get_relative_cwd(buffer, PATH_MAX, get_git_work_tree());
-		if (rel && *rel && chdir(get_git_work_tree()))
-			die_errno ("Could not jump to working directory");
-		return rel && *rel ? strcat(rel, "/") : NULL;
-	}
-
-	return retval;
+	return setup_git_directory_gently(NULL);
 }
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index d492996..0343045 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -647,7 +647,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6
 '
=20
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D.. in subdir' '
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D.. in subdir' '
 	cat >6/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY/6
@@ -658,7 +658,7 @@ EOF
 	GIT_DIR=3D../../.git test_repo 6/sub/sub
 '
=20
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D..(rel) in subd=
ir' '
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D..(rel) in subd=
ir' '
 	cat >6/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY/6
@@ -779,7 +779,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6/sub/sub
 '
=20
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../.. at root' =
'
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../.. at root' =
'
 	cat >6/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY
@@ -790,7 +790,7 @@ EOF
 	GIT_DIR=3D.git test_repo 6
 '
=20
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../..(rel) at r=
oot' '
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../..(rel) at r=
oot' '
 	cat >6/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY
@@ -823,7 +823,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6
 '
=20
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../.. in subdir=
' '
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../.. in subdir=
' '
 	cat >6/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY
@@ -834,7 +834,7 @@ EOF
 	GIT_DIR=3D../../.git test_repo 6/sub/sub
 '
=20
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../..(rel) in s=
ubdir' '
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../..(rel) in s=
ubdir' '
 	cat >6/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1254,7 +1254,7 @@ test_expect_success '#10: setup' '
 	cd ..
 '
=20
-test_expect_failure '#10: at root' '
+test_expect_success '#10: at root' '
 	cat >10/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/10.git
 setup: worktree: $TRASH_DIRECTORY/10
@@ -1264,7 +1264,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/10/.git" test_repo 10
 '
=20
-test_expect_failure '#10: in subdir' '
+test_expect_success '#10: in subdir' '
 	cat >10/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/10.git
 setup: worktree: $TRASH_DIRECTORY/10/sub
@@ -1274,7 +1274,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/10/.git" test_repo 10/sub
 '
=20
-test_expect_failure '#10: relative GIT_DIR at root' '
+test_expect_success '#10: relative GIT_DIR at root' '
 	cat >10/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/10.git
 setup: worktree: $TRASH_DIRECTORY/10
@@ -1284,7 +1284,7 @@ EOF
 	GIT_DIR=3D.git test_repo 10
 '
=20
-test_expect_failure '#10: relative GIT_DIR in subdir' '
+test_expect_success '#10: relative GIT_DIR in subdir' '
 	cat >10/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/10.git
 setup: worktree: $TRASH_DIRECTORY/10/sub
@@ -1321,7 +1321,7 @@ test_expect_success '#11: setup' '
 	cd ..
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1331,7 +1331,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/11" test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1341,7 +1341,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1351,7 +1351,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/11" test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1361,7 +1361,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D. test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1371,7 +1371,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/11" test_repo =
11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1381,7 +1381,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+test_expect_success '#11: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
 	cat >11/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1391,7 +1391,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/11" test_repo 11/sub
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+test_expect_success '#11: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1401,7 +1401,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D../.. test_repo =
11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1411,7 +1411,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/11/wt" test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1421,7 +1421,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1431,7 +1431,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3Dwt test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1441,7 +1441,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/11/wt" test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1451,7 +1451,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/11/wt" test_re=
po 11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1461,7 +1461,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1471,7 +1471,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D../../wt test_re=
po 11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1481,7 +1481,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/11/wt" test_repo 11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1491,7 +1491,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1501,7 +1501,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1511,7 +1511,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D.. test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1521,7 +1521,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1531,7 +1531,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 11/=
sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1541,7 +1541,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1551,7 +1551,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1686,7 +1686,7 @@ test_expect_success '#14: setup' '
 	cd ..
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14 at root'=
 '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14 at root'=
 '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1697,7 +1697,7 @@ EOF
 	GIT_DIR=3D.git test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14(rel) at =
root' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14(rel) at =
root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1708,7 +1708,7 @@ EOF
 	GIT_DIR=3D.git test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14 at root' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14 at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1719,7 +1719,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14(rel) at root'=
 '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14(rel) at root'=
 '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1730,7 +1730,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14 in subdi=
r' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14 in subdi=
r' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1741,7 +1741,7 @@ EOF
 	GIT_DIR=3D../../.git test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14(rel) in =
subdir' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14(rel) in =
subdir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1752,7 +1752,7 @@ EOF
 	GIT_DIR=3D../../.git test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14 in subdir' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14 in subdir' '
 	cat >14/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1763,7 +1763,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14(rel) in subdi=
r' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14(rel) in subdi=
r' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1774,7 +1774,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt at ro=
ot' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14/wt at ro=
ot' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1785,7 +1785,7 @@ EOF
 	GIT_DIR=3D.git test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt(rel) =
at root' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14/wt(rel) =
at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1796,7 +1796,7 @@ EOF
 	GIT_DIR=3D.git test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt(rel) at ro=
ot' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14/wt(rel) at ro=
ot' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1807,7 +1807,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt at root' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14/wt at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1818,7 +1818,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt in su=
bdir' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14/wt in su=
bdir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1829,7 +1829,7 @@ EOF
 	GIT_DIR=3D../../.git test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt(rel) =
in subdir' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14/wt(rel) =
in subdir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1840,7 +1840,7 @@ EOF
 	GIT_DIR=3D../../.git test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt(rel) in su=
bdir' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14/wt(rel) in su=
bdir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1851,7 +1851,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt in subdir'=
 '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14/wt in subdir'=
 '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1862,7 +1862,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D.. at root' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D.. at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1873,7 +1873,7 @@ EOF
 	GIT_DIR=3D.git test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D..(rel) at roo=
t' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D..(rel) at roo=
t' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1884,7 +1884,7 @@ EOF
 	GIT_DIR=3D.git test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D..(rel) at root' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D..(rel) at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1895,7 +1895,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D.. at root' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D.. at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1906,7 +1906,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D.. in subdir' =
'
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D.. in subdir' =
'
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1917,7 +1917,7 @@ EOF
 	GIT_DIR=3D../../.git test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D..(rel) in sub=
dir' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D..(rel) in sub=
dir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1928,7 +1928,7 @@ EOF
 	GIT_DIR=3D../../.git test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D..(rel) in subdir' =
'
+test_expect_success '#14: GIT_DIR, core.worktree=3D..(rel) in subdir' =
'
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1939,7 +1939,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D.. in subdir' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D.. in subdir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1978,7 +1978,7 @@ test_expect_success '#15: setup' '
 	cd ..
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -1988,7 +1988,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/15" test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -1998,7 +1998,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2008,7 +2008,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/15" test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2018,7 +2018,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D. test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2028,7 +2028,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/15" test_repo =
15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2038,7 +2038,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+test_expect_success '#15: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
 	cat >15/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2048,7 +2048,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/15" test_repo 15/sub
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+test_expect_success '#15: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2058,7 +2058,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D../.. test_repo =
15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2068,7 +2068,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/15/wt" test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2078,7 +2078,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2088,7 +2088,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3Dwt test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2098,7 +2098,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/15/wt" test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2108,7 +2108,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/15/wt" test_re=
po 15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2118,7 +2118,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2128,7 +2128,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D../../wt test_re=
po 15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2138,7 +2138,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/15/wt" test_repo 15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2148,7 +2148,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2158,7 +2158,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2168,7 +2168,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D.. test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2178,7 +2178,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2188,7 +2188,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 15/=
sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2198,7 +2198,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2208,7 +2208,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -3151,7 +3151,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D. in .git/su=
b' '
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D. in .git/su=
b' '
 	cat >22/.git/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22/.git
@@ -3162,7 +3162,7 @@ EOF
 	GIT_DIR=3D.. test_repo 22/.git/sub
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D.(rel) in .g=
it/sub' '
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D.(rel) in .g=
it/sub' '
 	cat >22/.git/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22/.git
@@ -3283,7 +3283,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git/sub
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D.. at .git' =
'
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D.. at .git' =
'
 	cat >22/.git/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22
@@ -3294,7 +3294,7 @@ EOF
 	GIT_DIR=3D. test_repo 22/.git
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D..(rel) at .=
git' '
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D..(rel) at .=
git' '
 	cat >22/.git/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22
@@ -3327,7 +3327,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D.. in .git/s=
ub' '
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D.. in .git/s=
ub' '
 	cat >22/.git/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22
@@ -3338,7 +3338,7 @@ EOF
 	GIT_DIR=3D.. test_repo 22/.git/sub
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D..(rel) in .=
git/sub' '
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D..(rel) in .=
git/sub' '
 	cat >22/.git/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22
@@ -3392,7 +3392,7 @@ test_expect_success '#22.2: setup' '
 	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.bare true
 '
=20
-test_expect_failure '#22.2: at .git' '
+test_expect_success '#22.2: at .git' '
 	(
 	cd 22/.git &&
 	GIT_DIR=3D. test_must_fail git symbolic-ref HEAD 2>result &&
@@ -3400,7 +3400,7 @@ test_expect_failure '#22.2: at .git' '
 	)
 '
=20
-test_expect_failure '#22.2: at root' '
+test_expect_success '#22.2: at root' '
 	(
 	cd 22 &&
 	GIT_DIR=3D.git test_must_fail git symbolic-ref HEAD 2>result &&
@@ -3800,7 +3800,7 @@ test_expect_success '#26: setup' '
 	cd ..
 '
=20
-test_expect_failure '#26: (rel) at root' '
+test_expect_success '#26: (rel) at root' '
 	cat >26/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/26.git
 setup: worktree: (null)
@@ -3810,7 +3810,7 @@ EOF
 	 GIT_DIR=3D.git test_repo 26
 '
=20
-test_expect_failure '#26: at root' '
+test_expect_success '#26: at root' '
 	cat >26/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/26.git
 setup: worktree: (null)
@@ -3820,7 +3820,7 @@ EOF
 	 GIT_DIR=3D"$TRASH_DIRECTORY/26/.git" test_repo 26
 '
=20
-test_expect_failure '#26: (rel) in subdir' '
+test_expect_success '#26: (rel) in subdir' '
 	cat >26/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/26.git
 setup: worktree: (null)
@@ -3830,7 +3830,7 @@ EOF
 	GIT_DIR=3D../.git test_repo 26/sub
 '
=20
-test_expect_failure '#26: in subdir' '
+test_expect_success '#26: in subdir' '
 	cat >26/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/26.git
 setup: worktree: (null)
@@ -3868,7 +3868,7 @@ test_expect_success '#27: setup' '
 	cd ..
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3878,7 +3878,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/27" test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3888,7 +3888,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3898,7 +3898,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/27" test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3908,7 +3908,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D. test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3918,7 +3918,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/27" test_repo =
27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3928,7 +3928,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+test_expect_success '#27: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
 	cat >27/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3938,7 +3938,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/27" test_repo 27/sub
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+test_expect_success '#27: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3948,7 +3948,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D../.. test_repo =
27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -3958,7 +3958,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/27/wt" test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -3968,7 +3968,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -3978,7 +3978,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3Dwt test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -3988,7 +3988,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/27/wt" test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -3998,7 +3998,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/27/wt" test_re=
po 27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -4008,7 +4008,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -4018,7 +4018,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D../../wt test_re=
po 27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -4028,7 +4028,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/27/wt" test_repo 27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4038,7 +4038,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4048,7 +4048,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4058,7 +4058,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D.. test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4068,7 +4068,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4078,7 +4078,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 27/=
sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4088,7 +4088,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4098,7 +4098,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4235,7 +4235,7 @@ test_expect_success '#30: setup' '
 	cd ..
 '
=20
-test_expect_failure '#30: at root' '
+test_expect_success '#30: at root' '
 	(
 	cd 30 &&
 	GIT_DIR=3D.git test_must_fail git symbolic-ref HEAD 2>result &&
@@ -4272,7 +4272,7 @@ test_expect_success '#31: setup' '
 	cd ..
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4282,7 +4282,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/31" test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4292,7 +4292,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4302,7 +4302,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/31" test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4312,7 +4312,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D. test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4322,7 +4322,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/31" test_repo =
31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4332,7 +4332,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+test_expect_success '#31: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
 	cat >31/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4342,7 +4342,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/31" test_repo 31/sub
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+test_expect_success '#31: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4352,7 +4352,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D../.. test_repo =
31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4362,7 +4362,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/31/wt" test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4372,7 +4372,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4382,7 +4382,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3Dwt test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4392,7 +4392,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/31/wt" test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4402,7 +4402,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/31/wt" test_re=
po 31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4412,7 +4412,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4422,7 +4422,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D../../wt test_re=
po 31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4432,7 +4432,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/31/wt" test_repo 31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4442,7 +4442,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4452,7 +4452,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4462,7 +4462,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D.. test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4472,7 +4472,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4482,7 +4482,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 31/=
sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4492,7 +4492,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4502,7 +4502,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
--=20
1.7.3.2.210.g045198
