From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 43/47] setup: rework setup_explicit_git_dir()
Date: Fri, 26 Nov 2010 22:32:39 +0700
Message-ID: <1290785563-15339-44-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 17:05:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0nx-00049l-Ta
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 17:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078Ab0KZQFk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 11:05:40 -0500
Received: from mail-pz0-f66.google.com ([209.85.210.66]:43248 "EHLO
	mail-pz0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895Ab0KZQFj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 11:05:39 -0500
Received: by pzk26 with SMTP id 26so460814pzk.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 08:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=BmsZKYT5RgzXg9BW6FzOElUiWNjuJyB4tFz4SVfP4F0=;
        b=CyMNdGgT+r3cE8nwTUmmconQP9mChzgUuQKz9AX9CSK3A3dQQ8OK5mykGF6O6+cjVT
         gNnNz73q22P5YyUd3ECW6sF08B/grnAt9UC5SN4i6oB5bkx6WPYEliFvCieXgup2mWhv
         eKoz2XP8rU7pNbRDjqFWYOlOG740HC72YHjw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=t7fbJrbD+TVFx7z6xhTpryemUUzXilOD4cXvKaAyZ5WeU8hCnqQ4DW0zqHoT8MSUPq
         SIZLlVvA8auG75EGadBweeiXp9yG8JSL3EAkQZPLTFZmqMIyxDyNfm6wMk1zdwrKrH9g
         mbsm5HzduLUeiq7VuiMiIgv0+iqxvT+RQoAr0=
Received: by 10.142.51.14 with SMTP id y14mr2522728wfy.306.1290786629897;
        Fri, 26 Nov 2010 07:50:29 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id w22sm2687914wfd.7.2010.11.26.07.50.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:50:28 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:49:07 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162264>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c               |  138 +++++++++++++----------
 t/t1510-repo-setup.sh |  286 ++++++++++++++++++++++++-----------------=
-------
 2 files changed, 221 insertions(+), 203 deletions(-)

diff --git a/setup.c b/setup.c
index 3ee9c2e..2e2865c 100644
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
@@ -441,7 +475,6 @@ static dev_t get_device_or_die(const char *path, co=
nst char *prefix)
  */
 static const char *setup_git_directory_gently_1(int *nongit_ok)
 {
-	const char *work_tree_env =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
 	const char *env_ceiling_dirs =3D getenv(CEILING_DIRECTORIES_ENVIRONME=
NT);
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv, *ret;
@@ -458,6 +491,10 @@ static const char *setup_git_directory_gently_1(in=
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
@@ -465,10 +502,7 @@ static const char *setup_git_directory_gently_1(in=
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
@@ -485,7 +519,6 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 	 * - ../../.git/
 	 *   etc.
 	 */
-	offset =3D len =3D strlen(cwd);
 	one_filesystem =3D !git_env_bool("GIT_DISCOVERY_ACROSS_FILESYSTEM", 0=
);
 	if (one_filesystem)
 		current_device =3D get_device_or_die(".", NULL);
@@ -628,20 +661,5 @@ int check_repository_format(void)
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
index 5ae02ee..b7e4d5d 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -651,7 +651,7 @@ EOF
 	test_repo 6 "$TRASH_DIRECTORY/6/.git"
 '
=20
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D.. in subdir' '
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D.. in subdir' '
 	cat >6/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY/6
@@ -662,7 +662,7 @@ EOF
 	test_repo 6/sub/sub ../../.git
 '
=20
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D..(rel) in subd=
ir' '
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D..(rel) in subd=
ir' '
 	cat >6/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY/6
@@ -783,7 +783,7 @@ EOF
 	test_repo 6/sub/sub "$TRASH_DIRECTORY/6/.git"
 '
=20
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../.. at root' =
'
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../.. at root' =
'
 	cat >6/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY
@@ -794,7 +794,7 @@ EOF
 	test_repo 6 .git
 '
=20
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../..(rel) at r=
oot' '
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../..(rel) at r=
oot' '
 	cat >6/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY
@@ -827,7 +827,7 @@ EOF
 	test_repo 6 "$TRASH_DIRECTORY/6/.git"
 '
=20
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../.. in subdir=
' '
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../.. in subdir=
' '
 	cat >6/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY
@@ -838,7 +838,7 @@ EOF
 	test_repo 6/sub/sub ../../.git
 '
=20
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../..(rel) in s=
ubdir' '
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../..(rel) in s=
ubdir' '
 	cat >6/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1260,7 +1260,7 @@ test_expect_success '#10: setup' '
 	cd ..
 '
=20
-test_expect_failure '#10: at root' '
+test_expect_success '#10: at root' '
 	cat >10/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/10.git
 setup: worktree: $TRASH_DIRECTORY/10
@@ -1270,7 +1270,7 @@ EOF
 	test_repo 10 "$TRASH_DIRECTORY/10/.git"
 '
=20
-test_expect_failure '#10: in subdir' '
+test_expect_success '#10: in subdir' '
 	cat >10/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/10.git
 setup: worktree: $TRASH_DIRECTORY/10/sub
@@ -1280,7 +1280,7 @@ EOF
 	test_repo 10/sub "$TRASH_DIRECTORY/10/.git"
 '
=20
-test_expect_failure '#10: relative GIT_DIR at root' '
+test_expect_success '#10: relative GIT_DIR at root' '
 	cat >10/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/10.git
 setup: worktree: $TRASH_DIRECTORY/10
@@ -1290,7 +1290,7 @@ EOF
 	test_repo 10 .git
 '
=20
-test_expect_failure '#10: relative GIT_DIR in subdir' '
+test_expect_success '#10: relative GIT_DIR in subdir' '
 	cat >10/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/10.git
 setup: worktree: $TRASH_DIRECTORY/10/sub
@@ -1327,7 +1327,7 @@ test_expect_success '#11: setup' '
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
@@ -1337,7 +1337,7 @@ EOF
 	test_repo 11 .git "$TRASH_DIRECTORY/11"
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1347,7 +1347,7 @@ EOF
 	test_repo 11 .git .
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1357,7 +1357,7 @@ EOF
 	test_repo 11 "$TRASH_DIRECTORY/11/.git" "$TRASH_DIRECTORY/11"
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1367,7 +1367,7 @@ EOF
 	test_repo 11 "$TRASH_DIRECTORY/11/.git" .
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1377,7 +1377,7 @@ EOF
 	test_repo 11/sub/sub ../../.git "$TRASH_DIRECTORY/11"
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1387,7 +1387,7 @@ EOF
 	test_repo 11/sub/sub ../../.git ../..
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+test_expect_success '#11: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
 	cat >11/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1397,7 +1397,7 @@ EOF
 	test_repo 11/sub "$TRASH_DIRECTORY/11/.git" "$TRASH_DIRECTORY/11"
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+test_expect_success '#11: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1407,7 +1407,7 @@ EOF
 	test_repo 11/sub/sub "$TRASH_DIRECTORY/11/.git" ../..
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1417,7 +1417,7 @@ EOF
 	test_repo 11 .git "$TRASH_DIRECTORY/11/wt"
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1427,7 +1427,7 @@ EOF
 	test_repo 11 .git wt
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1437,7 +1437,7 @@ EOF
 	test_repo 11 "$TRASH_DIRECTORY/11/.git" wt
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1447,7 +1447,7 @@ EOF
 	test_repo 11 "$TRASH_DIRECTORY/11/.git" "$TRASH_DIRECTORY/11/wt"
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1457,7 +1457,7 @@ EOF
 	test_repo 11/sub/sub ../../.git "$TRASH_DIRECTORY/11/wt"
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1467,7 +1467,7 @@ EOF
 	test_repo 11/sub/sub ../../.git ../../wt
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1477,7 +1477,7 @@ EOF
 	test_repo 11/sub/sub "$TRASH_DIRECTORY/11/.git" ../../wt
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1487,7 +1487,7 @@ EOF
 	test_repo 11/sub/sub "$TRASH_DIRECTORY/11/.git" "$TRASH_DIRECTORY/11/=
wt"
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1497,7 +1497,7 @@ EOF
 	test_repo 11 .git "$TRASH_DIRECTORY"
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1507,7 +1507,7 @@ EOF
 	test_repo 11 .git ..
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1517,7 +1517,7 @@ EOF
 	test_repo 11 "$TRASH_DIRECTORY/11/.git" ..
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1527,7 +1527,7 @@ EOF
 	test_repo 11 "$TRASH_DIRECTORY/11/.git" "$TRASH_DIRECTORY"
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1537,7 +1537,7 @@ EOF
 	test_repo 11/sub/sub ../../.git "$TRASH_DIRECTORY"
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1547,7 +1547,7 @@ EOF
 	test_repo 11/sub/sub ../../.git ../../..
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1557,7 +1557,7 @@ EOF
 	test_repo 11/sub/sub "$TRASH_DIRECTORY/11/.git" ../../../
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1693,7 +1693,7 @@ test_expect_success '#14: setup' '
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
@@ -1704,7 +1704,7 @@ EOF
 	test_repo 14 .git
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14(rel) at =
root' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14(rel) at =
root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1715,7 +1715,7 @@ EOF
 	test_repo 14 .git
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14 at root' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14 at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1726,7 +1726,7 @@ EOF
 	test_repo 14 "$TRASH_DIRECTORY/14/.git"
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14(rel) at root'=
 '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14(rel) at root'=
 '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1737,7 +1737,7 @@ EOF
 	test_repo 14 "$TRASH_DIRECTORY/14/.git"
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14 in subdi=
r' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14 in subdi=
r' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1748,7 +1748,7 @@ EOF
 	test_repo 14/sub/sub ../../.git
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14(rel) in =
subdir' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14(rel) in =
subdir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1759,7 +1759,7 @@ EOF
 	test_repo 14/sub/sub ../../.git
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14 in subdir' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14 in subdir' '
 	cat >14/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1770,7 +1770,7 @@ EOF
 	test_repo 14/sub "$TRASH_DIRECTORY/14/.git"
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14(rel) in subdi=
r' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14(rel) in subdi=
r' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1781,7 +1781,7 @@ EOF
 	test_repo 14/sub/sub "$TRASH_DIRECTORY/14/.git"
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt at ro=
ot' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14/wt at ro=
ot' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1792,7 +1792,7 @@ EOF
 	test_repo 14 .git
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt(rel) =
at root' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14/wt(rel) =
at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1803,7 +1803,7 @@ EOF
 	test_repo 14 .git
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt(rel) at ro=
ot' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14/wt(rel) at ro=
ot' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1814,7 +1814,7 @@ EOF
 	test_repo 14 "$TRASH_DIRECTORY/14/.git"
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt at root' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14/wt at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1825,7 +1825,7 @@ EOF
 	test_repo 14 "$TRASH_DIRECTORY/14/.git"
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt in su=
bdir' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14/wt in su=
bdir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1836,7 +1836,7 @@ EOF
 	test_repo 14/sub/sub ../../.git
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt(rel) =
in subdir' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14/wt(rel) =
in subdir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1847,7 +1847,7 @@ EOF
 	test_repo 14/sub/sub ../../.git
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt(rel) in su=
bdir' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14/wt(rel) in su=
bdir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1858,7 +1858,7 @@ EOF
 	test_repo 14/sub/sub "$TRASH_DIRECTORY/14/.git"
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt in subdir'=
 '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14/wt in subdir'=
 '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1869,7 +1869,7 @@ EOF
 	test_repo 14/sub/sub "$TRASH_DIRECTORY/14/.git"
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D.. at root' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D.. at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1880,7 +1880,7 @@ EOF
 	test_repo 14 .git
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D..(rel) at roo=
t' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D..(rel) at roo=
t' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1891,7 +1891,7 @@ EOF
 	test_repo 14 .git
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D..(rel) at root' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D..(rel) at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1902,7 +1902,7 @@ EOF
 	test_repo 14 "$TRASH_DIRECTORY/14/.git"
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D.. at root' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D.. at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1913,7 +1913,7 @@ EOF
 	test_repo 14 "$TRASH_DIRECTORY/14/.git"
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D.. in subdir' =
'
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D.. in subdir' =
'
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1924,7 +1924,7 @@ EOF
 	test_repo 14/sub/sub ../../.git
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D..(rel) in sub=
dir' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D..(rel) in sub=
dir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1935,7 +1935,7 @@ EOF
 	test_repo 14/sub/sub ../../.git
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D..(rel) in subdir' =
'
+test_expect_success '#14: GIT_DIR, core.worktree=3D..(rel) in subdir' =
'
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1946,7 +1946,7 @@ EOF
 	test_repo 14/sub/sub "$TRASH_DIRECTORY/14/.git"
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D.. in subdir' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D.. in subdir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1985,7 +1985,7 @@ test_expect_success '#15: setup' '
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
@@ -1995,7 +1995,7 @@ EOF
 	test_repo 15 .git "$TRASH_DIRECTORY/15"
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2005,7 +2005,7 @@ EOF
 	test_repo 15 .git .
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2015,7 +2015,7 @@ EOF
 	test_repo 15 "$TRASH_DIRECTORY/15/.git" "$TRASH_DIRECTORY/15"
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2025,7 +2025,7 @@ EOF
 	test_repo 15 "$TRASH_DIRECTORY/15/.git" .
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2035,7 +2035,7 @@ EOF
 	test_repo 15/sub/sub ../../.git "$TRASH_DIRECTORY/15"
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2045,7 +2045,7 @@ EOF
 	test_repo 15/sub/sub ../../.git ../..
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+test_expect_success '#15: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
 	cat >15/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2055,7 +2055,7 @@ EOF
 	test_repo 15/sub "$TRASH_DIRECTORY/15/.git" "$TRASH_DIRECTORY/15"
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+test_expect_success '#15: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2065,7 +2065,7 @@ EOF
 	test_repo 15/sub/sub "$TRASH_DIRECTORY/15/.git" ../..
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2075,7 +2075,7 @@ EOF
 	test_repo 15 .git "$TRASH_DIRECTORY/15/wt"
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2085,7 +2085,7 @@ EOF
 	test_repo 15 .git wt
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2095,7 +2095,7 @@ EOF
 	test_repo 15 "$TRASH_DIRECTORY/15/.git" wt
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2105,7 +2105,7 @@ EOF
 	test_repo 15 "$TRASH_DIRECTORY/15/.git" "$TRASH_DIRECTORY/15/wt"
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2115,7 +2115,7 @@ EOF
 	test_repo 15/sub/sub ../../.git "$TRASH_DIRECTORY/15/wt"
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2125,7 +2125,7 @@ EOF
 	test_repo 15/sub/sub ../../.git ../../wt
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2135,7 +2135,7 @@ EOF
 	test_repo 15/sub/sub "$TRASH_DIRECTORY/15/.git" ../../wt
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2145,7 +2145,7 @@ EOF
 	test_repo 15/sub/sub "$TRASH_DIRECTORY/15/.git" "$TRASH_DIRECTORY/15/=
wt"
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2155,7 +2155,7 @@ EOF
 	test_repo 15 .git "$TRASH_DIRECTORY"
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2165,7 +2165,7 @@ EOF
 	test_repo 15 .git ..
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2175,7 +2175,7 @@ EOF
 	test_repo 15 "$TRASH_DIRECTORY/15/.git" ..
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2185,7 +2185,7 @@ EOF
 	test_repo 15 "$TRASH_DIRECTORY/15/.git" "$TRASH_DIRECTORY"
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2195,7 +2195,7 @@ EOF
 	test_repo 15/sub/sub ../../.git "$TRASH_DIRECTORY"
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2205,7 +2205,7 @@ EOF
 	test_repo 15/sub/sub ../../.git ../../..
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2215,7 +2215,7 @@ EOF
 	test_repo 15/sub/sub "$TRASH_DIRECTORY/15/.git" ../../../
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -3160,7 +3160,7 @@ EOF
 	test_repo 22/.git "$TRASH_DIRECTORY/22/.git"
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D. in .git/su=
b' '
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D. in .git/su=
b' '
 	cat >22/.git/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22/.git
@@ -3171,7 +3171,7 @@ EOF
 	test_repo 22/.git/sub ..
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D.(rel) in .g=
it/sub' '
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D.(rel) in .g=
it/sub' '
 	cat >22/.git/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22/.git
@@ -3292,7 +3292,7 @@ EOF
 	test_repo 22/.git/sub "$TRASH_DIRECTORY/22/.git"
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D.. at .git' =
'
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D.. at .git' =
'
 	cat >22/.git/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22
@@ -3303,7 +3303,7 @@ EOF
 	test_repo 22/.git .
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D..(rel) at .=
git' '
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D..(rel) at .=
git' '
 	cat >22/.git/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22
@@ -3336,7 +3336,7 @@ EOF
 	test_repo 22/.git "$TRASH_DIRECTORY/22/.git"
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D.. in .git/s=
ub' '
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D.. in .git/s=
ub' '
 	cat >22/.git/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22
@@ -3347,7 +3347,7 @@ EOF
 	test_repo 22/.git/sub ..
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D..(rel) in .=
git/sub' '
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D..(rel) in .=
git/sub' '
 	cat >22/.git/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22
@@ -3401,7 +3401,7 @@ test_expect_success '#22.2: setup' '
 	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.bare true
 '
=20
-test_expect_failure '#22.2: at .git' '
+test_expect_success '#22.2: at .git' '
 	(
 	cd 22/.git &&
 	GIT_DIR=3D. &&
@@ -3411,7 +3411,7 @@ test_expect_failure '#22.2: at .git' '
 	)
 '
=20
-test_expect_failure '#22.2: at root' '
+test_expect_success '#22.2: at root' '
 	(
 	cd 22 &&
 	GIT_DIR=3D.git &&
@@ -3814,7 +3814,7 @@ test_expect_success '#26: setup' '
 	cd ..
 '
=20
-test_expect_failure '#26: (rel) at root' '
+test_expect_success '#26: (rel) at root' '
 	cat >26/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/26.git
 setup: worktree: (null)
@@ -3824,7 +3824,7 @@ EOF
 	 test_repo 26 .git
 '
=20
-test_expect_failure '#26: at root' '
+test_expect_success '#26: at root' '
 	cat >26/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/26.git
 setup: worktree: (null)
@@ -3834,7 +3834,7 @@ EOF
 	 test_repo 26 "$TRASH_DIRECTORY/26/.git"
 '
=20
-test_expect_failure '#26: (rel) in subdir' '
+test_expect_success '#26: (rel) in subdir' '
 	cat >26/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/26.git
 setup: worktree: (null)
@@ -3844,7 +3844,7 @@ EOF
 	test_repo 26/sub ../.git
 '
=20
-test_expect_failure '#26: in subdir' '
+test_expect_success '#26: in subdir' '
 	cat >26/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/26.git
 setup: worktree: (null)
@@ -3882,7 +3882,7 @@ test_expect_success '#27: setup' '
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
@@ -3892,7 +3892,7 @@ EOF
 	test_repo 27 .git "$TRASH_DIRECTORY/27"
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3902,7 +3902,7 @@ EOF
 	test_repo 27 .git .
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3912,7 +3912,7 @@ EOF
 	test_repo 27 "$TRASH_DIRECTORY/27/.git" "$TRASH_DIRECTORY/27"
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3922,7 +3922,7 @@ EOF
 	test_repo 27 "$TRASH_DIRECTORY/27/.git" .
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3932,7 +3932,7 @@ EOF
 	test_repo 27/sub/sub ../../.git "$TRASH_DIRECTORY/27"
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3942,7 +3942,7 @@ EOF
 	test_repo 27/sub/sub ../../.git ../..
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+test_expect_success '#27: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
 	cat >27/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3952,7 +3952,7 @@ EOF
 	test_repo 27/sub "$TRASH_DIRECTORY/27/.git" "$TRASH_DIRECTORY/27"
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+test_expect_success '#27: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3962,7 +3962,7 @@ EOF
 	test_repo 27/sub/sub "$TRASH_DIRECTORY/27/.git" ../..
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -3972,7 +3972,7 @@ EOF
 	test_repo 27 .git "$TRASH_DIRECTORY/27/wt"
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -3982,7 +3982,7 @@ EOF
 	test_repo 27 .git wt
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -3992,7 +3992,7 @@ EOF
 	test_repo 27 "$TRASH_DIRECTORY/27/.git" wt
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -4002,7 +4002,7 @@ EOF
 	test_repo 27 "$TRASH_DIRECTORY/27/.git" "$TRASH_DIRECTORY/27/wt"
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -4012,7 +4012,7 @@ EOF
 	test_repo 27/sub/sub ../../.git "$TRASH_DIRECTORY/27/wt"
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -4022,7 +4022,7 @@ EOF
 	test_repo 27/sub/sub ../../.git ../../wt
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -4032,7 +4032,7 @@ EOF
 	test_repo 27/sub/sub "$TRASH_DIRECTORY/27/.git" ../../wt
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -4042,7 +4042,7 @@ EOF
 	test_repo 27/sub/sub "$TRASH_DIRECTORY/27/.git" "$TRASH_DIRECTORY/27/=
wt"
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4052,7 +4052,7 @@ EOF
 	test_repo 27 .git "$TRASH_DIRECTORY"
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4062,7 +4062,7 @@ EOF
 	test_repo 27 .git ..
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4072,7 +4072,7 @@ EOF
 	test_repo 27 "$TRASH_DIRECTORY/27/.git" ..
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4082,7 +4082,7 @@ EOF
 	test_repo 27 "$TRASH_DIRECTORY/27/.git" "$TRASH_DIRECTORY"
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4092,7 +4092,7 @@ EOF
 	test_repo 27/sub/sub ../../.git "$TRASH_DIRECTORY"
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4102,7 +4102,7 @@ EOF
 	test_repo 27/sub/sub ../../.git ../../..
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4112,7 +4112,7 @@ EOF
 	test_repo 27/sub/sub "$TRASH_DIRECTORY/27/.git" ../../../
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4250,7 +4250,7 @@ test_expect_success '#30: setup' '
 	cd ..
 '
=20
-test_expect_failure '#30: at root' '
+test_expect_success '#30: at root' '
 	(
 	cd 30 &&
 	GIT_DIR=3D.git &&
@@ -4289,7 +4289,7 @@ test_expect_success '#31: setup' '
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
@@ -4299,7 +4299,7 @@ EOF
 	test_repo 31 .git "$TRASH_DIRECTORY/31"
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4309,7 +4309,7 @@ EOF
 	test_repo 31 .git .
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4319,7 +4319,7 @@ EOF
 	test_repo 31 "$TRASH_DIRECTORY/31/.git" "$TRASH_DIRECTORY/31"
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4329,7 +4329,7 @@ EOF
 	test_repo 31 "$TRASH_DIRECTORY/31/.git" .
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4339,7 +4339,7 @@ EOF
 	test_repo 31/sub/sub ../../.git "$TRASH_DIRECTORY/31"
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4349,7 +4349,7 @@ EOF
 	test_repo 31/sub/sub ../../.git ../..
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+test_expect_success '#31: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
 	cat >31/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4359,7 +4359,7 @@ EOF
 	test_repo 31/sub "$TRASH_DIRECTORY/31/.git" "$TRASH_DIRECTORY/31"
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+test_expect_success '#31: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4369,7 +4369,7 @@ EOF
 	test_repo 31/sub/sub "$TRASH_DIRECTORY/31/.git" ../..
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4379,7 +4379,7 @@ EOF
 	test_repo 31 .git "$TRASH_DIRECTORY/31/wt"
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4389,7 +4389,7 @@ EOF
 	test_repo 31 .git wt
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4399,7 +4399,7 @@ EOF
 	test_repo 31 "$TRASH_DIRECTORY/31/.git" wt
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4409,7 +4409,7 @@ EOF
 	test_repo 31 "$TRASH_DIRECTORY/31/.git" "$TRASH_DIRECTORY/31/wt"
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4419,7 +4419,7 @@ EOF
 	test_repo 31/sub/sub ../../.git "$TRASH_DIRECTORY/31/wt"
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4429,7 +4429,7 @@ EOF
 	test_repo 31/sub/sub ../../.git ../../wt
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4439,7 +4439,7 @@ EOF
 	test_repo 31/sub/sub "$TRASH_DIRECTORY/31/.git" ../../wt
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4449,7 +4449,7 @@ EOF
 	test_repo 31/sub/sub "$TRASH_DIRECTORY/31/.git" "$TRASH_DIRECTORY/31/=
wt"
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4459,7 +4459,7 @@ EOF
 	test_repo 31 .git "$TRASH_DIRECTORY"
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4469,7 +4469,7 @@ EOF
 	test_repo 31 .git ..
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4479,7 +4479,7 @@ EOF
 	test_repo 31 "$TRASH_DIRECTORY/31/.git" ..
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4489,7 +4489,7 @@ EOF
 	test_repo 31 "$TRASH_DIRECTORY/31/.git" "$TRASH_DIRECTORY"
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4499,7 +4499,7 @@ EOF
 	test_repo 31/sub/sub ../../.git "$TRASH_DIRECTORY"
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4509,7 +4509,7 @@ EOF
 	test_repo 31/sub/sub ../../.git ../../..
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4519,7 +4519,7 @@ EOF
 	test_repo 31/sub/sub "$TRASH_DIRECTORY/31/.git" ../../../
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
--=20
1.7.3.2.316.gda8b3
