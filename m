From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Make locked paths absolute when current directory is changed
Date: Fri, 18 Jul 2014 20:08:57 +0700
Message-ID: <1405688937-22925-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 15:09:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X87us-0006kd-6g
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 15:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965483AbaGRNJ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 09:09:26 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:64216 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965475AbaGRNJW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 09:09:22 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so5357979pad.27
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 06:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=0ZWh0XXfa0a+Kuo4I3Znr0zfNCDQM9CJLxKTljfxwRQ=;
        b=Rbu0xdvE5XdxzP+q9jp/nm23j2OYi45Z5rCJrUiJ0UM9sMctKiR2RCBNN5CmTfTCqb
         kRbvFYtgnXge4Fksn19VcKW3VWcFfNihk9PrG59GUeU8mqoYKjNAd56G7A+50zl9SeBP
         5w/2IEl0q2PQMUAWGH21eH6iSaPDYXblisvUeV8LKPPCZ2kJJWGJAsuFO6gIC0Y1RfxJ
         b+gqh+6ureIzDLdonP4VPp6q9we75sm3LUSfTCSjS6IXAlKnlVYOR9H23VdF+IIsUddq
         04jdm93eewzDtbaYWCttBChKAuZkwrBU1qZy+HgxOHv1hLBzy9h3CUDT+f7a1b7KBy0E
         PZLA==
X-Received: by 10.70.38.136 with SMTP id g8mr4819079pdk.135.1405688955173;
        Fri, 18 Jul 2014 06:09:15 -0700 (PDT)
Received: from lanh ([115.73.249.170])
        by mx.google.com with ESMTPSA id hs5sm5565603pbb.92.2014.07.18.06.09.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jul 2014 06:09:14 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 18 Jul 2014 20:09:07 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253817>

Locked paths are saved in a linked list so that if something wrong
happens, *.lock are removed. This works fine if we keep cwd the same,
which is true 99% of time except:

 - update-index and read-tree hold the lock on $GIT_DIR/index really
   early, then later on may call setup_work_tree() to move cwd.

 - Suppose a lock is being held (e.g. by "git add") then somewhere
   down the line, somebody calls real_path (e.g. "link_alt_odb_entry"),
   which temporarily moves cwd away and back.

During that time when cwd is moved (either permanently or temporarily)
and we decide to die(), attempts to remove relative *.lock will fail,
and the next operation will complain that some files are still locked.

Avoid this case by turning relative paths to absolute when chdir() is
called (or soon to be called, in setup_git_directory_gently case).

Reported-by: Yue Lin Ho <yuelinho777@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 It occurred to me while writing this commit message that it would be
 better if we can unlink via a file descriptor so we don't have to
 convert paths. But I'm not sure about the availability of unlinkat(),
 especially on Windows.

 abspath.c     |  2 +-
 cache.h       |  6 ++++++
 git.c         |  6 +++---
 lockfile.c    | 16 ++++++++++++++++
 path.c        |  4 ++--
 run-command.c |  2 +-
 setup.c       |  3 ++-
 unix-socket.c |  2 +-
 8 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/abspath.c b/abspath.c
index ca33558..78c963f 100644
--- a/abspath.c
+++ b/abspath.c
@@ -87,7 +87,7 @@ static const char *real_path_internal(const char *pat=
h, int die_on_error)
 					goto error_out;
 			}
=20
-			if (chdir(buf)) {
+			if (chdir_safe(buf)) {
 				if (die_on_error)
 					die_errno("Could not switch to '%s'", buf);
 				else
diff --git a/cache.h b/cache.h
index 44aa439..d3f2596 100644
--- a/cache.h
+++ b/cache.h
@@ -564,6 +564,12 @@ extern int hold_lock_file_for_update(struct lock_f=
ile *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *p=
ath, int);
 extern int commit_lock_file(struct lock_file *);
 extern void update_index_if_able(struct index_state *, struct lock_fil=
e *);
+extern void make_locked_paths_absolute(void);
+static inline int chdir_safe(const char *path)
+{
+	make_locked_paths_absolute();
+	return chdir(path);
+}
=20
 extern int hold_locked_index(struct lock_file *, int);
 extern int commit_locked_index(struct lock_file *);
diff --git a/git.c b/git.c
index 5b6c761..27766c3 100644
--- a/git.c
+++ b/git.c
@@ -48,7 +48,7 @@ static void save_env(void)
 static void restore_env(void)
 {
 	int i;
-	if (*orig_cwd && chdir(orig_cwd))
+	if (*orig_cwd && chdir_safe(orig_cwd))
 		die_errno("could not move to %s", orig_cwd);
 	for (i =3D 0; i < ARRAY_SIZE(env_names); i++) {
 		if (orig_env[i])
@@ -206,7 +206,7 @@ static int handle_options(const char ***argv, int *=
argc, int *envchanged)
 				fprintf(stderr, "No directory given for -C.\n" );
 				usage(git_usage_string);
 			}
-			if (chdir((*argv)[1]))
+			if (chdir_safe((*argv)[1]))
 				die_errno("Cannot change to '%s'", (*argv)[1]);
 			if (envchanged)
 				*envchanged =3D 1;
@@ -292,7 +292,7 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 		ret =3D 1;
 	}
=20
-	if (subdir && chdir(subdir))
+	if (subdir && chdir_safe(subdir))
 		die_errno("Cannot change to '%s'", subdir);
=20
 	errno =3D saved_errno;
diff --git a/lockfile.c b/lockfile.c
index 8fbcb6a..a70d107 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -280,3 +280,19 @@ void rollback_lock_file(struct lock_file *lk)
 	}
 	lk->filename[0] =3D 0;
 }
+
+void make_locked_paths_absolute(void)
+{
+	struct lock_file *lk;
+	const char *abspath;
+	for (lk =3D lock_file_list; lk !=3D NULL; lk =3D lk->next) {
+		if (!lk->filename[0] || lk->filename[0] =3D=3D '/')
+			continue;
+		abspath =3D absolute_path(lk->filename);
+		if (strlen(abspath) >=3D sizeof(lk->filename))
+			warning("locked path %s is relative when current directory "
+				"is changed", lk->filename);
+		else
+			strcpy(lk->filename, abspath);
+	}
+}
diff --git a/path.c b/path.c
index bc804a3..9e8e101 100644
--- a/path.c
+++ b/path.c
@@ -372,11 +372,11 @@ const char *enter_repo(const char *path, int stri=
ct)
 		gitfile =3D read_gitfile(used_path) ;
 		if (gitfile)
 			strcpy(used_path, gitfile);
-		if (chdir(used_path))
+		if (chdir_safe(used_path))
 			return NULL;
 		path =3D validated_path;
 	}
-	else if (chdir(path))
+	else if (chdir_safe(path))
 		return NULL;
=20
 	if (access("objects", X_OK) =3D=3D 0 && access("refs", X_OK) =3D=3D 0=
 &&
diff --git a/run-command.c b/run-command.c
index be07d4a..55f360e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -399,7 +399,7 @@ fail_pipe:
 			close(cmd->out);
 		}
=20
-		if (cmd->dir && chdir(cmd->dir))
+		if (cmd->dir && chdir_safe(cmd->dir))
 			die_errno("exec '%s': cd to '%s' failed", cmd->argv[0],
 			    cmd->dir);
 		if (cmd->env) {
diff --git a/setup.c b/setup.c
index 0a22f8b..921045e 100644
--- a/setup.c
+++ b/setup.c
@@ -290,7 +290,7 @@ void setup_work_tree(void)
 	git_dir =3D get_git_dir();
 	if (!is_absolute_path(git_dir))
 		git_dir =3D real_path(get_git_dir());
-	if (!work_tree || chdir(work_tree))
+	if (!work_tree || chdir_safe(work_tree))
 		die("This operation must be run in a work tree");
=20
 	/*
@@ -636,6 +636,7 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 		die_errno("Unable to read current working directory");
 	offset =3D len =3D strlen(cwd);
=20
+	make_locked_paths_absolute();
 	/*
 	 * If GIT_DIR is set explicitly, we're not going
 	 * to do any discovery, but we still do repository
diff --git a/unix-socket.c b/unix-socket.c
index 01f119f..eeb8007 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -12,7 +12,7 @@ static int unix_stream_socket(void)
 static int chdir_len(const char *orig, int len)
 {
 	char *path =3D xmemdupz(orig, len);
-	int r =3D chdir(path);
+	int r =3D chdir_safe(path);
 	free(path);
 	return r;
 }
--=20
1.9.1.346.ga2b5940
