From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/9] setup: clean up setup_discovered_git_dir()
Date: Mon,  1 Nov 2010 13:26:32 +0700
Message-ID: <1288592794-24221-7-git-send-email-pclouds@gmail.com>
References: <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 07:27:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCnrm-0001t5-Ss
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 07:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab0KAG1a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 02:27:30 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36067 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab0KAG12 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 02:27:28 -0400
Received: by mail-gx0-f174.google.com with SMTP id 23so2961184gxk.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 23:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=uQ7QbHNhJMQV/A1vOGP7WVUhkG9Yw12oFI9Nfty7bjI=;
        b=uUkbZBFSk8ZFlZLIPv/so2TzoqiWgJ8QhrzWPJfH+JDrY7qjEUXCwZUDQxKEzPTG3y
         juc4CiZ+XteCuttuhyrTZ7OKxSFHUm/I19nLMhnBIavUpfSWKJb44Akp3s8pqE9D8cR2
         5B51pFRw5nnMpnpDxsaBMPgzYU26ezM0mlh6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pkCnIKhgjVPWCgkbKpO40/swc8/LrxktF+LOe12qK3CBvHW5Xe6rLkAoGyL68+h00U
         Ijcrz+zNm2gKoUSwTVOZyIcoTMxJrTijGRxJjNAlYMINNfjtq19BwqIaIivJ2BYnd4ry
         BpTBXS/tU132Al8BGP4X+3POUXrc1Yvu0miPg=
Received: by 10.150.11.16 with SMTP id 16mr27835852ybk.299.1288592847772;
        Sun, 31 Oct 2010 23:27:27 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id q36sm7078705ybk.6.2010.10.31.23.27.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 23:27:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 01 Nov 2010 13:27:29 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160463>

If core.bare is true, discard the discovered worktree, move back to
original cwd.

This change may set GIT_DIR env var to ".git" via set_git_dir(). This
bothers alias handling because handle_alias() does

1. prefix =3D setup_git_directory_gently(..)
2. look up alias
3. chdir(prefix)

After step 1, GIT_DIR may be set to ".git" (relative to worktree), but
step 3 moves cwd back to original cwd. When the next
setup_git_directory_gently() is called by run_builtin(), it will
mistakenly find ".git" in original cwd.

As a workaround, teach set_git_dir() not to set to
".git". setup_git_env() will default to ".git" later on. Alias
handling code will need more work later.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The alias breakage is new. It should be fixed by calling setup_git_*
 only once. No "chdir(prefix)" any more. And that fix will be needed
 before we can turn more git_dir to relative path.

 But for now the workaround is enough, I think.

 environment.c         |    6 +++-
 setup.c               |   71 ++++++++++++++++++++++++-----------------=
--------
 t/t1510-repo-setup.sh |   24 ++++++++--------
 3 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/environment.c b/environment.c
index d811049..15764ee 100644
--- a/environment.c
+++ b/environment.c
@@ -193,8 +193,10 @@ char *get_graft_file(void)
=20
 int set_git_dir(const char *path)
 {
-	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
-		return error("Could not set GIT_DIR to '%s'", path);
+	if (strcmp(path, DEFAULT_GIT_DIR_ENVIRONMENT)) {
+		if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
+			return error("Could not set GIT_DIR to '%s'", path);
+	}
 	setup_git_env();
 	return 0;
 }
diff --git a/setup.c b/setup.c
index a6cc044..2dd5f78 100644
--- a/setup.c
+++ b/setup.c
@@ -362,39 +362,26 @@ static const char *setup_explicit_git_dir(const c=
har *gitdirenv,
 	return retval;
 }
=20
-static int cwd_contains_git_dir(const char **gitfile_dirp)
+static const char *setup_discovered_git_dir(const char *gitdir,
+					    char *cwd, int offset, int len,
+					    int *nongit_ok)
 {
-	const char *gitfile_dir =3D read_gitfile_gently(DEFAULT_GIT_DIR_ENVIR=
ONMENT);
-	*gitfile_dirp =3D gitfile_dir;
-	if (gitfile_dir) {
-		if (set_git_dir(gitfile_dir))
-			die("Repository setup failed");
-		return 1;
-	}
-	if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT)) {
-		*gitfile_dirp =3D DEFAULT_GIT_DIR_ENVIRONMENT;
-		return 1;
-	}
-	return 0;
-}
+	if (check_repository_format_gently(gitdir, nongit_ok))
+		return NULL;
=20
-static const char *setup_discovered_git_dir(const char *work_tree_env,
-					    const char *gitdir,
-					    int offset, int len,
-					    char *cwd, int *nongit_ok)
-{
-	int root_len;
-	char *work_tree;
+	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
+	if (is_bare_repository_cfg > 0) {
+		set_git_dir(offset =3D=3D len ? gitdir : make_absolute_path(gitdir))=
;
+		if (chdir(cwd))
+			die_errno("Could not come back to cwd");
+		return NULL;
+	}
=20
+	/* #0, #1, #5, #8, #9, #12, #13 */
+	set_git_work_tree(".");
+	set_git_dir(gitdir);
 	inside_git_dir =3D 0;
-	if (!work_tree_env)
-		inside_work_tree =3D 1;
-	root_len =3D offset_1st_component(cwd);
-	work_tree =3D xstrndup(cwd, offset > root_len ? offset : root_len);
-	set_git_work_tree(work_tree);
-	free(work_tree);
-	if (check_repository_format_gently(gitdir, nongit_ok))
-		return NULL;
+	inside_work_tree =3D 1;
 	if (offset =3D=3D len)
 		return NULL;
=20
@@ -456,8 +443,8 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 	const char *work_tree_env =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
 	const char *env_ceiling_dirs =3D getenv(CEILING_DIRECTORIES_ENVIRONME=
NT);
 	static char cwd[PATH_MAX+1];
-	const char *gitdirenv;
-	const char *gitfile_dir;
+	const char *gitdirenv, *ret;
+	char *gitfile;
 	int len, offset, ceil_offset;
 	dev_t current_device =3D 0;
 	int one_filesystem =3D 1;
@@ -502,11 +489,23 @@ static const char *setup_git_directory_gently_1(i=
nt *nongit_ok)
 	if (one_filesystem)
 		current_device =3D get_device_or_die(".", NULL);
 	for (;;) {
-		if (cwd_contains_git_dir(&gitfile_dir))
-			return setup_discovered_git_dir(work_tree_env,
-							gitfile_dir,
-							offset, len,
-							cwd, nongit_ok);
+		gitfile =3D (char*)read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
+		if (gitfile)
+			gitdirenv =3D gitfile =3D xstrdup(gitfile);
+		else {
+			if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
+				gitdirenv =3D DEFAULT_GIT_DIR_ENVIRONMENT;
+		}
+
+		if (gitdirenv) {
+			ret =3D setup_discovered_git_dir(gitdirenv,
+						       cwd, offset, len,
+						       nongit_ok);
+			free(gitfile);
+			return ret;
+		}
+		free(gitfile);
+
 		if (is_git_directory("."))
 			return setup_bare_git_dir(cwd, offset, len, nongit_ok);
=20
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 629ba34..d492996 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2343,7 +2343,7 @@ EOF
 	test_repo 16
 '
=20
-test_expect_failure '#16.2: in subdir' '
+test_expect_success '#16.2: in subdir' '
 	cat >16/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/16/.git
 setup: worktree: (null)
@@ -2471,7 +2471,7 @@ EOF
 	test_repo 17
 '
=20
-test_expect_failure '#17.2: in subdir' '
+test_expect_success '#17.2: in subdir' '
 	cat >17/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/17/.git
 setup: worktree: (null)
@@ -2936,7 +2936,7 @@ EOF
 	test_repo 20
 '
=20
-test_expect_failure '#20.2: in subdir' '
+test_expect_success '#20.2: in subdir' '
 	cat >20/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/20/.git
 setup: worktree: (null)
@@ -3065,7 +3065,7 @@ EOF
 	test_repo 21
 '
=20
-test_expect_failure '#21.2: in subdir' '
+test_expect_success '#21.2: in subdir' '
 	cat >21/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/21/.git
 setup: worktree: (null)
@@ -3703,7 +3703,7 @@ test_expect_success '#24: setup' '
 	cd ..
 '
=20
-test_expect_failure '#24: at root' '
+test_expect_success '#24: at root' '
 	cat >24/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/24.git
 setup: worktree: (null)
@@ -3713,7 +3713,7 @@ EOF
 	test_repo 24
 '
=20
-test_expect_failure '#24: in subdir' '
+test_expect_success '#24: in subdir' '
 	cat >24/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/24.git
 setup: worktree: (null)
@@ -3752,7 +3752,7 @@ test_expect_success '#25: setup' '
 	cd ..
 '
=20
-test_expect_failure '#25: at root' '
+test_expect_success '#25: at root' '
 	cat >25/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/25.git
 setup: worktree: (null)
@@ -3762,7 +3762,7 @@ EOF
 	test_repo 25
 '
=20
-test_expect_failure '#25: in subdir' '
+test_expect_success '#25: in subdir' '
 	cat >25/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/25.git
 setup: worktree: (null)
@@ -4137,7 +4137,7 @@ test_expect_success '#28: setup' '
 	cd ..
 '
=20
-test_expect_failure '#28: at root' '
+test_expect_success '#28: at root' '
 	cat >28/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/28.git
 setup: worktree: (null)
@@ -4147,7 +4147,7 @@ EOF
 	test_repo 28
 '
=20
-test_expect_failure '#28: in subdir' '
+test_expect_success '#28: in subdir' '
 	cat >28/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/28.git
 setup: worktree: (null)
@@ -4186,7 +4186,7 @@ test_expect_success '#29: setup' '
 	cd ..
 '
=20
-test_expect_failure '#29: at root' '
+test_expect_success '#29: at root' '
 	cat >29/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/29.git
 setup: worktree: (null)
@@ -4196,7 +4196,7 @@ EOF
 	test_repo 29
 '
=20
-test_expect_failure '#29: in subdir' '
+test_expect_success '#29: in subdir' '
 	cat >29/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/29.git
 setup: worktree: (null)
--=20
1.7.3.2.210.g045198
