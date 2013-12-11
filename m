From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/POC 6/7] setup.c: add split-repo support to setup_git_directory*
Date: Wed, 11 Dec 2013 21:15:32 +0700
Message-ID: <1386771333-32574-7-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 15:11:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqkVb-0007qZ-HP
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 15:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990Ab3LKOLX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Dec 2013 09:11:23 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:42002 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3LKOLW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 09:11:22 -0500
Received: by mail-pb0-f54.google.com with SMTP id un15so10037258pbc.13
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 06:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fB6/mbTU5At8Fz98oKWwI4QhBztxKFhjIyaFmwxQ8d0=;
        b=WLLRLvBrtyl8GuLMkLws9sC9x0gzHUhkaFZR75g8Oy9n1KeudyqT58FRBEcHjNwM50
         W2L9Vb+Hvcirh1nXm0U6YFXjA24KbK0PYQYFLgXQSBGqAuZPcWf6wW02vIIH4CJSDhbN
         yjEKzJHWy+lktCgN21ZXwwqHs/KEi5tAwRonvow2wMGaT34FOR0nYXewn0QdEpYKljx6
         b9EFBWPzAcMvAuemF+n85W5pyHjpFuEd1XtqJ/w3KJFDQEjBZibgo0Vj0yFMHuVAusec
         ap2VN8SHd+jxaat62y3p6ME5OARTM+/UCtK0PehzwHEMUXL/oyNTbPLc1xGjfZINo9eo
         yH8Q==
X-Received: by 10.68.189.101 with SMTP id gh5mr1883135pbc.39.1386771081998;
        Wed, 11 Dec 2013 06:11:21 -0800 (PST)
Received: from lanh ([115.73.201.231])
        by mx.google.com with ESMTPSA id ka3sm32934624pbc.32.2013.12.11.06.11.18
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Dec 2013 06:11:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 11 Dec 2013 21:16:11 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239200>

XXX bare repos probably not worth supporting..

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h       |  1 +
 environment.c | 19 ++++++++++++++++--
 setup.c       | 62 +++++++++++++++++++++++++++++++++++++++------------=
--------
 trace.c       |  1 +
 4 files changed, 60 insertions(+), 23 deletions(-)

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
index d5ae7a3..8152c7e 100644
--- a/environment.c
+++ b/environment.c
@@ -125,13 +125,17 @@ static char *expand_namespace(const char *raw_nam=
espace)
 static void setup_git_env(void)
 {
 	const char *gitfile;
+	char *super;
=20
 	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir)
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
-	gitfile =3D read_gitfile(git_dir);
+	gitfile =3D read_gitfile_super(git_dir, &super);
 	git_dir =3D xstrdup(gitfile ? gitfile : git_dir);
-	git_super_dir =3D getenv(GIT_SUPER_DIR_ENVIRONMENT);
+	if (super)
+		git_super_dir =3D xstrdup(super);
+	else
+		git_super_dir =3D getenv(GIT_SUPER_DIR_ENVIRONMENT);
 	git_object_dir =3D getenv(DB_ENVIRONMENT);
 	if (!git_object_dir) {
 		git_object_dir =3D xmalloc(strlen(git_dir) + 9);
@@ -280,6 +284,17 @@ int set_git_dir(const char *path)
 	return 0;
 }
=20
+int set_git_dir_super(const char *path, const char *super)
+{
+	if (super !=3D path &&
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
index dfe9d08..f22381e 100644
--- a/setup.c
+++ b/setup.c
@@ -255,7 +255,8 @@ void setup_work_tree(void)
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
 		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
=20
-	set_git_dir(remove_leading_path(git_dir, work_tree));
+	set_git_dir_super(remove_leading_path(git_dir, work_tree),
+			  get_git_super_dir());
 	initialized =3D 1;
 }
=20
@@ -368,24 +369,28 @@ const char *read_gitfile(const char *path)
=20
=20
 static const char *setup_explicit_git_dir(const char *gitdirenv,
+					  const char *super_,
 					  char *cwd, int len,
 					  int *nongit_ok)
 {
 	const char *work_tree_env =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
 	const char *worktree;
-	char *gitfile;
+	char *gitfile, *super =3D (char *)super_;
 	int offset;
=20
 	if (PATH_MAX - 40 < strlen(gitdirenv))
 		die("'$%s' too big", GIT_DIR_ENVIRONMENT);
=20
-	gitfile =3D (char*)read_gitfile(gitdirenv);
+	gitfile =3D (char*)read_gitfile_super(gitdirenv, !super ? &super : NU=
LL);
 	if (gitfile) {
 		gitfile =3D xstrdup(gitfile);
 		gitdirenv =3D gitfile;
-	}
+		if (!super)
+			super =3D gitfile;
+	} else if (!super)
+		super =3D (char *)gitdirenv;
=20
-	if (!is_git_directory(gitdirenv)) {
+	if (!is_git_directory_super(gitdirenv, super)) {
 		if (nongit_ok) {
 			*nongit_ok =3D 1;
 			goto done_null;
@@ -393,7 +398,7 @@ static const char *setup_explicit_git_dir(const cha=
r *gitdirenv,
 		die("Not a git repository: '%s'", gitdirenv);
 	}
=20
-	if (check_repository_format_gently(gitdirenv, nongit_ok))
+	if (check_repository_format_gently(super, nongit_ok))
 		goto done_null;
=20
 	/* #3, #7, #11, #15, #19, #23, #27, #31 (see t1510) */
@@ -404,7 +409,7 @@ static const char *setup_explicit_git_dir(const cha=
r *gitdirenv,
 			die("core.bare and core.worktree do not make sense");
=20
 		/* #18, #26 */
-		set_git_dir(gitdirenv);
+		set_git_dir_super(gitdirenv, super);
 		goto done_null;
 	}
 	else if (git_work_tree_cfg) { /* #6, #14 */
@@ -425,7 +430,7 @@ static const char *setup_explicit_git_dir(const cha=
r *gitdirenv,
 	}
 	else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
 		/* #16d */
-		set_git_dir(gitdirenv);
+		set_git_dir_super(gitdirenv, super);
 		goto done_null;
 	}
 	else /* #2, #10 */
@@ -436,34 +441,39 @@ static const char *setup_explicit_git_dir(const c=
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
+		if (super !=3D gitdirenv && super !=3D super_)
+			free(super);
 		return cwd + offset;
 	}
=20
 	/* cwd outside worktree */
-	set_git_dir(gitdirenv);
+	set_git_dir_super(gitdirenv, super);
=20
 done_null:
 	free(gitfile);
+	if (super !=3D gitdirenv && super !=3D super_)
+		free(super);
 	return NULL;
 }
=20
 static const char *setup_discovered_git_dir(const char *gitdir,
+					    const char *super,
 					    char *cwd, int offset, int len,
 					    int *nongit_ok)
 {
-	if (check_repository_format_gently(gitdir, nongit_ok))
+	if (check_repository_format_gently(super, nongit_ok))
 		return NULL;
=20
 	/* --work-tree is set without --git-dir; use discovered one */
@@ -472,7 +482,7 @@ static const char *setup_discovered_git_dir(const c=
har *gitdir,
 			gitdir =3D xstrdup(real_path(gitdir));
 		if (chdir(cwd))
 			die_errno("Could not come back to cwd");
-		return setup_explicit_git_dir(gitdir, cwd, len, nongit_ok);
+		return setup_explicit_git_dir(gitdir, super, cwd, len, nongit_ok);
 	}
=20
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
@@ -486,7 +496,7 @@ static const char *setup_discovered_git_dir(const c=
har *gitdir,
 	/* #0, #1, #5, #8, #9, #12, #13 */
 	set_git_work_tree(".");
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
-		set_git_dir(gitdir);
+		set_git_dir_super(gitdir, super);
 	inside_git_dir =3D 0;
 	inside_work_tree =3D 1;
 	if (offset =3D=3D len)
@@ -516,7 +526,7 @@ static const char *setup_bare_git_dir(char *cwd, in=
t offset, int len, int *nongi
 		gitdir =3D offset =3D=3D len ? "." : xmemdupz(cwd, offset);
 		if (chdir(cwd))
 			die_errno("Could not come back to cwd");
-		return setup_explicit_git_dir(gitdir, cwd, len, nongit_ok);
+		return setup_explicit_git_dir(gitdir, NULL, cwd, len, nongit_ok);
 	}
=20
 	inside_git_dir =3D 1;
@@ -596,7 +606,7 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 	struct string_list ceiling_dirs =3D STRING_LIST_INIT_DUP;
 	static char cwd[PATH_MAX + 1];
 	const char *gitdirenv, *ret;
-	char *gitfile;
+	char *gitfile, *super;
 	int len, offset, offset_parent, ceil_offset =3D -1;
 	dev_t current_device =3D 0;
 	int one_filesystem =3D 1;
@@ -620,7 +630,9 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 	 */
 	gitdirenv =3D getenv(GIT_DIR_ENVIRONMENT);
 	if (gitdirenv)
-		return setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
+		return setup_explicit_git_dir(gitdirenv,
+					      getenv(GIT_SUPER_DIR_ENVIRONMENT),
+					      cwd, len, nongit_ok);
=20
 	if (env_ceiling_dirs) {
 		int empty_entry_found =3D 0;
@@ -650,21 +662,29 @@ static const char *setup_git_directory_gently_1(i=
nt *nongit_ok)
 	if (one_filesystem)
 		current_device =3D get_device_or_die(".", NULL, 0);
 	for (;;) {
-		gitfile =3D (char*)read_gitfile(DEFAULT_GIT_DIR_ENVIRONMENT);
-		if (gitfile)
+		gitfile =3D (char*)read_gitfile_super(DEFAULT_GIT_DIR_ENVIRONMENT,
+						    &super);
+		if (gitfile) {
 			gitdirenv =3D gitfile =3D xstrdup(gitfile);
-		else {
+			if (!super)
+				super =3D gitfile;
+		} else {
 			if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
 				gitdirenv =3D DEFAULT_GIT_DIR_ENVIRONMENT;
+			super =3D (char *)gitdirenv;
 		}
=20
 		if (gitdirenv) {
-			ret =3D setup_discovered_git_dir(gitdirenv,
+			ret =3D setup_discovered_git_dir(gitdirenv, super,
 						       cwd, offset, len,
 						       nongit_ok);
+			if (super !=3D gitdirenv)
+				free(super);
 			free(gitfile);
 			return ret;
 		}
+		if (super !=3D gitdirenv)
+			free(super);
 		free(gitfile);
=20
 		if (is_git_directory("."))
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
