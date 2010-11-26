From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 42/47] setup: clean up setup_discovered_git_dir()
Date: Fri, 26 Nov 2010 22:32:38 +0700
Message-ID: <1290785563-15339-43-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:50:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0Ys-0001Hc-Ob
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133Ab0KZPuD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:50:03 -0500
Received: from mail-pz0-f66.google.com ([209.85.210.66]:57504 "EHLO
	mail-pz0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187Ab0KZPuC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:50:02 -0500
Received: by pzk26 with SMTP id 26so458422pzk.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xFuNa9vJmyL4PwA12LrPxs8F4hDWd9hJqhCxP0YvBts=;
        b=h1zSbg89v72lsm9wcvEmUCBhrGcrcHQuySHzhOQuTucF/zO5AV27wIFDr2ucMzSPRw
         oHSjeu4l+4hVKquEbvAHgAjxPtCJns5hD5Wo7Sw8SmoxnF/shE+TKAQsak3njTUXQQnH
         QAzO6AKVvFsah7XB54ZSs5A1eCBylIkfi02/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TdoiYAPurXNzFK08RdC1+pK4q4Bmvq4YEFA4ClO95dunXQHexHaT5oK+yrlwBIh0km
         YO2aNMgOOVIRIPSBgv15txnGucsZwQePhSIUCbW/lVZBpSytvCT5Y7yc0fpRnYG2sIxl
         zarHJbkHlI/872/agMLTqCFb5qJaD40QmroeM=
Received: by 10.142.239.21 with SMTP id m21mr2523729wfh.198.1290786601908;
        Fri, 26 Nov 2010 07:50:01 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id w14sm2693128wfd.6.2010.11.26.07.49.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:50:00 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:48:24 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162253>

If core.bare is true, discard the discovered worktree, move back to
original cwd.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c               |   72 ++++++++++++++++++++++++-----------------=
-------
 t/t1510-repo-setup.sh |   24 ++++++++--------
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/setup.c b/setup.c
index a6cc044..3ee9c2e 100644
--- a/setup.c
+++ b/setup.c
@@ -362,39 +362,27 @@ static const char *setup_explicit_git_dir(const c=
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
+	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
+		set_git_dir(gitdir);
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
@@ -456,8 +444,8 @@ static const char *setup_git_directory_gently_1(int=
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
@@ -502,11 +490,23 @@ static const char *setup_git_directory_gently_1(i=
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
index 45feb80..5ae02ee 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2350,7 +2350,7 @@ EOF
 	test_repo 16
 '
=20
-test_expect_failure '#16.2: in subdir' '
+test_expect_success '#16.2: in subdir' '
 	cat >16/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/16/.git
 setup: worktree: (null)
@@ -2479,7 +2479,7 @@ EOF
 	test_repo 17
 '
=20
-test_expect_failure '#17.2: in subdir' '
+test_expect_success '#17.2: in subdir' '
 	cat >17/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/17/.git
 setup: worktree: (null)
@@ -2944,7 +2944,7 @@ EOF
 	test_repo 20
 '
=20
-test_expect_failure '#20.2: in subdir' '
+test_expect_success '#20.2: in subdir' '
 	cat >20/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/20/.git
 setup: worktree: (null)
@@ -3074,7 +3074,7 @@ EOF
 	test_repo 21
 '
=20
-test_expect_failure '#21.2: in subdir' '
+test_expect_success '#21.2: in subdir' '
 	cat >21/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/21/.git
 setup: worktree: (null)
@@ -3716,7 +3716,7 @@ test_expect_success '#24: setup' '
 	cd ..
 '
=20
-test_expect_failure '#24: at root' '
+test_expect_success '#24: at root' '
 	cat >24/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/24.git
 setup: worktree: (null)
@@ -3726,7 +3726,7 @@ EOF
 	test_repo 24
 '
=20
-test_expect_failure '#24: in subdir' '
+test_expect_success '#24: in subdir' '
 	cat >24/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/24.git
 setup: worktree: (null)
@@ -3766,7 +3766,7 @@ test_expect_success '#25: setup' '
 	cd ..
 '
=20
-test_expect_failure '#25: at root' '
+test_expect_success '#25: at root' '
 	cat >25/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/25.git
 setup: worktree: (null)
@@ -3776,7 +3776,7 @@ EOF
 	test_repo 25
 '
=20
-test_expect_failure '#25: in subdir' '
+test_expect_success '#25: in subdir' '
 	cat >25/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/25.git
 setup: worktree: (null)
@@ -4151,7 +4151,7 @@ test_expect_success '#28: setup' '
 	cd ..
 '
=20
-test_expect_failure '#28: at root' '
+test_expect_success '#28: at root' '
 	cat >28/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/28.git
 setup: worktree: (null)
@@ -4161,7 +4161,7 @@ EOF
 	test_repo 28
 '
=20
-test_expect_failure '#28: in subdir' '
+test_expect_success '#28: in subdir' '
 	cat >28/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/28.git
 setup: worktree: (null)
@@ -4201,7 +4201,7 @@ test_expect_success '#29: setup' '
 	cd ..
 '
=20
-test_expect_failure '#29: at root' '
+test_expect_success '#29: at root' '
 	cat >29/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/29.git
 setup: worktree: (null)
@@ -4211,7 +4211,7 @@ EOF
 	test_repo 29
 '
=20
-test_expect_failure '#29: in subdir' '
+test_expect_success '#29: in subdir' '
 	cat >29/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/29.git
 setup: worktree: (null)
--=20
1.7.3.2.316.gda8b3
