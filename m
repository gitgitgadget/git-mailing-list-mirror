From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 16/21] setup.c: keep track of the .git file location if read
Date: Sat, 14 Dec 2013 17:55:02 +0700
Message-ID: <1387018507-21999-17-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Dec 14 11:52:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrmq7-0001Im-7z
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596Ab3LNKwv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:52:51 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:38258 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576Ab3LNKwu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:52:50 -0500
Received: by mail-pb0-f54.google.com with SMTP id un15so3625050pbc.13
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=s04CjkLuEO41SLer8oWrEHHB36pD74+3gd7KWza7ydw=;
        b=mb5D2EZUjql1PDylLmcD1Epwqevl8Q1uvDSxVocJ7XaeBG9o27z5JL/WsglRzC02ZF
         tN6vbZRlT0srYEQoA1cJkDEy1v/tmmwAAJYcmaGV3cy6Syo28H8HZA8azXE7IiRTkjrr
         GhzoMhwGpismTxIq/aXOwYQXUZXCDeWWN2fP0UcmiBGeW/Znv7vp7BfoR+UV1SesmENo
         lMMQBSnMRmkA7jZaQZZ5HnKbFT/chOjJiIheoEO+fK/FeOavZaheJbrmBqKJeMakPGAz
         cGjK2KzgKae+rEquZ9q19I9yXexPnebe6KWgXzNMV+KI98eKrwrNLDj4uRdAjOjxBViz
         8V7Q==
X-Received: by 10.68.236.35 with SMTP id ur3mr3023980pbc.137.1387018370305;
        Sat, 14 Dec 2013 02:52:50 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id sg1sm11433355pbb.16.2013.12.14.02.52.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:52:46 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:57:40 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239298>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h       |  2 +-
 environment.c |  2 +-
 setup.c       | 44 ++++++++++++++++++++++++++++++--------------
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index 4c09223..e036a7d 100644
--- a/cache.h
+++ b/cache.h
@@ -411,7 +411,7 @@ extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
 extern const char *get_git_work_tree(void);
 extern const char *read_gitfile(const char *path);
-extern const char *read_gitfile_super(const char *path, char **super);
+extern const char *read_gitfile_super(const char *path, char **super, =
char **gitfile);
 extern const char *resolve_gitdir(const char *suspect);
 extern void set_git_work_tree(const char *tree);
=20
diff --git a/environment.c b/environment.c
index 5cbbe11..61aff23 100644
--- a/environment.c
+++ b/environment.c
@@ -130,7 +130,7 @@ static void setup_git_env(void)
 	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir)
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
-	gitfile =3D read_gitfile_super(git_dir, &super);
+	gitfile =3D read_gitfile_super(git_dir, &super, NULL);
 	git_dir =3D xstrdup(gitfile ? gitfile : git_dir);
 	if (super)
 		git_super_dir =3D xstrdup(super);
diff --git a/setup.c b/setup.c
index 7ccb1f8..ac7d90c 100644
--- a/setup.c
+++ b/setup.c
@@ -332,7 +332,7 @@ static char *path_from_gitfile(const char *path, co=
nst char *buf, int len)
  * to the absolute path of the given path. The next line contains the
  * repo id.
  */
-const char *read_gitfile_super(const char *path, char **super)
+const char *read_gitfile_super(const char *path, char **super, char **=
gitfile)
 {
 	char *buf, *dir;
 	struct stat st;
@@ -384,6 +384,10 @@ const char *read_gitfile_super(const char *path, c=
har **super)
=20
 	if (!is_git_directory_super(dir, super ? *super : NULL))
 		die("Not a git repository: %s", dir);
+
+	if (gitfile)
+		*gitfile =3D xstrdup(real_path(path));
+
 	path =3D real_path(dir);
=20
 	free(dir);
@@ -393,14 +397,15 @@ const char *read_gitfile_super(const char *path, =
char **super)
=20
 const char *read_gitfile(const char *path)
 {
-	return read_gitfile_super(path, NULL);
+	return read_gitfile_super(path, NULL, NULL);
 }
=20
=20
 static const char *setup_explicit_git_dir(const char *gitdirenv,
 					  const char *super,
 					  char *cwd, int len,
-					  int *nongit_ok)
+					  int *nongit_ok,
+					  char **gitfile_path)
 {
 	const char *work_tree_env =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
 	const char *worktree;
@@ -413,7 +418,8 @@ static const char *setup_explicit_git_dir(const cha=
r *gitdirenv,
 	if (super)
 		gitfile =3D (char*)read_gitfile(gitdirenv);
 	else {
-		gitfile =3D (char*)read_gitfile_super(gitdirenv, &super_new);
+		gitfile =3D (char*)read_gitfile_super(gitdirenv, &super_new,
+						    gitfile_path);
 		super =3D super_new;
 	}
 	if (gitfile) {
@@ -500,7 +506,8 @@ done_null:
 static const char *setup_discovered_git_dir(const char *gitdir,
 					    const char *super,
 					    char *cwd, int offset, int len,
-					    int *nongit_ok)
+					    int *nongit_ok,
+					    char **gitfile_path)
 {
 	if (check_repository_format_gently(super ? super : gitdir, nongit_ok)=
)
 		return NULL;
@@ -512,7 +519,8 @@ static const char *setup_discovered_git_dir(const c=
har *gitdir,
 			gitdir =3D xstrdup(real_path(gitdir));
 		if (chdir(cwd))
 			die_errno("Could not come back to cwd");
-		return setup_explicit_git_dir(gitdir, super, cwd, len, nongit_ok);
+		return setup_explicit_git_dir(gitdir, super, cwd, len,
+					      nongit_ok, gitfile_path);
 	}
=20
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
@@ -540,7 +548,8 @@ static const char *setup_discovered_git_dir(const c=
har *gitdir,
 }
=20
 /* #16.1, #17.1, #20.1, #21.1, #22.1 (see t1510) */
-static const char *setup_bare_git_dir(char *cwd, int offset, int len, =
int *nongit_ok)
+static const char *setup_bare_git_dir(char *cwd, int offset, int len,
+				      int *nongit_ok, char **gitfile_path)
 {
 	int root_len;
=20
@@ -556,7 +565,8 @@ static const char *setup_bare_git_dir(char *cwd, in=
t offset, int len, int *nongi
 		gitdir =3D offset =3D=3D len ? "." : xmemdupz(cwd, offset);
 		if (chdir(cwd))
 			die_errno("Could not come back to cwd");
-		return setup_explicit_git_dir(gitdir, NULL, cwd, len, nongit_ok);
+		return setup_explicit_git_dir(gitdir, NULL, cwd, len,
+					      nongit_ok, gitfile_path);
 	}
=20
 	inside_git_dir =3D 1;
@@ -630,7 +640,8 @@ static int canonicalize_ceiling_entry(struct string=
_list_item *item,
  * We cannot decide in this function whether we are in the work tree o=
r
  * not, since the config can only be read _after_ this function was ca=
lled.
  */
-static const char *setup_git_directory_gently_1(int *nongit_ok)
+static const char *setup_git_directory_gently_1(int *nongit_ok,
+						char **gitfile_path)
 {
 	const char *env_ceiling_dirs =3D getenv(CEILING_DIRECTORIES_ENVIRONME=
NT);
 	struct string_list ceiling_dirs =3D STRING_LIST_INIT_DUP;
@@ -662,7 +673,8 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 	super =3D getenv(GIT_SUPER_DIR_ENVIRONMENT);
 	if (gitdirenv)
 		return setup_explicit_git_dir(gitdirenv, super,
-					      cwd, len, nongit_ok);
+					      cwd, len, nongit_ok,
+					      gitfile_path);
=20
 	if (env_ceiling_dirs) {
 		int empty_entry_found =3D 0;
@@ -696,7 +708,7 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 			gitfile =3D (char*)read_gitfile(DEFAULT_GIT_DIR_ENVIRONMENT);
 		else {
 			gitfile =3D (char*)read_gitfile_super(DEFAULT_GIT_DIR_ENVIRONMENT,
-							    &super_new);
+							    &super_new, gitfile_path);
 			super =3D super_new;
 		}
 		if (gitfile)
@@ -709,7 +721,8 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 		if (gitdirenv) {
 			ret =3D setup_discovered_git_dir(gitdirenv, super,
 						       cwd, offset, len,
-						       nongit_ok);
+						       nongit_ok,
+						       gitfile_path);
 			free(gitfile);
 			free(super_new);
 			return ret;
@@ -717,7 +730,8 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 		free(gitfile);
=20
 		if (is_git_directory(".")) {
-			ret =3D setup_bare_git_dir(cwd, offset, len, nongit_ok);
+			ret =3D setup_bare_git_dir(cwd, offset, len,
+						 nongit_ok, gitfile_path);
 			free(super_new);
 			return ret;
 		}
@@ -754,8 +768,9 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	const char *prefix;
+	char *gitfile =3D NULL;
=20
-	prefix =3D setup_git_directory_gently_1(nongit_ok);
+	prefix =3D setup_git_directory_gently_1(nongit_ok, &gitfile);
 	if (prefix)
 		setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
 	else
@@ -765,6 +780,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 		startup_info->have_repository =3D !nongit_ok || !*nongit_ok;
 		startup_info->prefix =3D prefix;
 	}
+	free(gitfile);
 	return prefix;
 }
=20
--=20
1.8.5.1.77.g42c48fa
