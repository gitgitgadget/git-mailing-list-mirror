From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] Make locked paths absolute when current directory is changed
Date: Sun, 20 Jul 2014 19:13:19 +0700
Message-ID: <1405858399-23082-2-git-send-email-pclouds@gmail.com>
References: <1405688937-22925-1-git-send-email-pclouds@gmail.com>
 <1405858399-23082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 14:15:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8q1W-0005k0-I4
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 14:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbaGTMPT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 08:15:19 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:47482 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbaGTMPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 08:15:13 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so8032291pad.23
        for <git@vger.kernel.org>; Sun, 20 Jul 2014 05:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8rifkQgMhKOq02A9wnZzK+S7YKSnm2607s4Im80XnWg=;
        b=LHaRQE3TYwsTPxxkq0YvPZPso5603yRu5lw354DgodK94yqeb+Aeo2u8c8y+8BS6o7
         WclwCyjP+LTOkwe+Hdjm4x9NauD+up1JPS8HkHF0fe9pFvMaDKr9+q7QIPIxqDX7uux5
         gh6olzghTCY6vDA+B4VfU6IszGAx5OFQUff+2FPvuSmz1DGr0lneIs7x6SirLOCzX1VL
         x5PFUX7g0ku0x4ugtdihrwIAus5JnbBLEhUPM8PB7Ox/Nvr+4kNbE7hqfOkJLa85b4hy
         Epn+OypqHpWG+PhzfT4aVA6iTH7+dQFLO5bJLAIVXv+vOfyfICo4ajHHVJllSZfkw2NW
         sWzA==
X-Received: by 10.70.136.229 with SMTP id qd5mr17990048pdb.105.1405858512237;
        Sun, 20 Jul 2014 05:15:12 -0700 (PDT)
Received: from lanh ([115.73.231.7])
        by mx.google.com with ESMTPSA id tf10sm11077589pbc.70.2014.07.20.05.15.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jul 2014 05:15:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 20 Jul 2014 19:15:07 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405858399-23082-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253920>

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
 Compared to v1, make_locked_paths_absolute() now always succeeds (ok
 absolute_path could die inside, but that's a separate problem) and
 supports Windows.

 abspath.c     |  2 +-
 cache.h       |  6 ++++++
 git.c         |  6 +++---
 lockfile.c    | 12 ++++++++++++
 path.c        |  4 ++--
 run-command.c |  2 +-
 setup.c       |  3 ++-
 unix-socket.c |  2 +-
 8 files changed, 28 insertions(+), 9 deletions(-)

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
index 9ecb636..48ffa21 100644
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
index 968b28f..cf1e795 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -288,3 +288,15 @@ void rollback_lock_file(struct lock_file *lk)
 	}
 	clear_filename(lk);
 }
+
+void make_locked_paths_absolute(void)
+{
+	struct lock_file *lk;
+	for (lk =3D lock_file_list; lk !=3D NULL; lk =3D lk->next) {
+		if (lk->filename && !is_absolute_path(lk->filename)) {
+			char *to_free =3D lk->filename;
+			lk->filename =3D xstrdup(absolute_path(lk->filename));
+			free(to_free);
+		}
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
