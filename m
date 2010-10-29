From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 41/42] setup: rework setup_explicit_git_dir()
Date: Fri, 29 Oct 2010 13:48:53 +0700
Message-ID: <1288334934-17216-42-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:54:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBirD-0007mg-M6
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933566Ab0J2Gy2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:54:28 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933422Ab0J2Gy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:54:26 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Lpukg+oaVrYJfgDbyPulxMZujpH5qFHH/66Pt1KWxfs=;
        b=TE3z9MsECMhY9asfBy9VlSiO385/JijqtdXrwbQxV7MRi5uf3JAakrWIPuSkO3R56T
         tT+RAonouZyhPJlbwy+32qSLzM8bcawvujdYOvDT4uyG74WnngsyOftCuZyYtdzZC41w
         3icjmU34az2Kxb7+gJpJ6IIlq4D5vdbrJnJlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=il06YHIl/HdepaefNyhuNIr5LXKHb6bz0yv26iWs8keonG34i7me6KdAfxx4eg7mkN
         45KfcP80CL240MiuFuvCVyX3BSOWG/ySuGQO1MVUJzgpVhutVDrqAoEwGJXtmzBJ6miT
         yQtXsS3N3zZq6sgQC+u6rZlwxhHu//QNCZUsc=
Received: by 10.142.47.7 with SMTP id u7mr990169wfu.46.1288335265989;
        Thu, 28 Oct 2010 23:54:25 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id e14sm1029386wfg.20.2010.10.28.23.54.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:54:24 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:54:24 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160309>

This function is the most complex one among the three setup_*
functions because all GIT_DIR, GIT_WORK_TREE, core.worktree and
core.bare are involved.

Because core.worktree is only effective inside
setup_explicit_git_dir() and the extra code in setup_git_directory()
is to handle that. The extra code can now be retired.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c |  135 ++++++++++++++++++++++++++++++++++++-------------------=
-------
 1 files changed, 78 insertions(+), 57 deletions(-)

diff --git a/setup.c b/setup.c
index dc91e0a..ba2a90e 100644
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
@@ -326,38 +308,92 @@ const char *read_gitfile_gently(const char *path)
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
@@ -442,7 +478,6 @@ static dev_t get_device_or_die(const char *path, co=
nst char *prefix)
  */
 static const char *setup_git_directory_gently_1(int *nongit_ok)
 {
-	const char *work_tree_env =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
 	const char *env_ceiling_dirs =3D getenv(CEILING_DIRECTORIES_ENVIRONME=
NT);
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv, *ret;
@@ -459,6 +494,10 @@ static const char *setup_git_directory_gently_1(in=
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
@@ -466,10 +505,7 @@ static const char *setup_git_directory_gently_1(in=
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
@@ -486,7 +522,6 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 	 * - ../../.git/
 	 *   etc.
 	 */
-	offset =3D len =3D strlen(cwd);
 	one_filesystem =3D !git_env_bool("GIT_DISCOVERY_ACROSS_FILESYSTEM", 0=
);
 	if (one_filesystem)
 		current_device =3D get_device_or_die(".", NULL);
@@ -629,19 +664,5 @@ int check_repository_format(void)
  */
 const char *setup_git_directory(void)
 {
-	const char *retval =3D setup_git_directory_gently(NULL);
-
-	/* If the work tree is not the default one, recompute prefix */
-	if (inside_work_tree < 0) {
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
--=20
1.7.0.2.445.gcbdb3
