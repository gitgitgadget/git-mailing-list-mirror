From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 3/3] Use the new {real,absolute}_path function names
Date: Wed, 16 Mar 2011 17:06:19 +0100
Message-ID: <1300291579-25852-4-git-send-email-cmn@elego.de>
References: <1300291579-25852-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 17:06:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PztFC-0005La-HU
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 17:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959Ab1CPQG3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 12:06:29 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:42455 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661Ab1CPQGV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 12:06:21 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id AA7E946101;
	Wed, 16 Mar 2011 17:06:14 +0100 (CET)
Received: (nullmailer pid 25897 invoked by uid 1000);
	Wed, 16 Mar 2011 16:06:20 -0000
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1300291579-25852-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169165>

Use the new names for path functions in the code. Replace uses of
make_absolute_path with real_path, make_nonrelative_path with
absolute_path and make_relative_path with relative_path.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 builtin/clone.c        |   12 ++++++------
 builtin/init-db.c      |    8 ++++----
 builtin/receive-pack.c |    2 +-
 dir.c                  |    4 ++--
 environment.c          |    4 ++--
 exec_cmd.c             |    2 +-
 lockfile.c             |    4 ++--
 setup.c                |   14 ++++++--------
 8 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 60d9a64..780809d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -100,7 +100,7 @@ static char *get_repo_path(const char *repo, int *i=
s_bundle)
 		path =3D mkpath("%s%s", repo, suffix[i]);
 		if (is_directory(path)) {
 			*is_bundle =3D 0;
-			return xstrdup(make_nonrelative_path(path));
+			return xstrdup(absolute_path(path));
 		}
 	}
=20
@@ -109,7 +109,7 @@ static char *get_repo_path(const char *repo, int *i=
s_bundle)
 		path =3D mkpath("%s%s", repo, bundle_suffix[i]);
 		if (!stat(path, &st) && S_ISREG(st.st_mode)) {
 			*is_bundle =3D 1;
-			return xstrdup(make_nonrelative_path(path));
+			return xstrdup(absolute_path(path));
 		}
 	}
=20
@@ -203,7 +203,7 @@ static void setup_reference(const char *repo)
 	struct transport *transport;
 	const struct ref *extra;
=20
-	ref_git =3D make_absolute_path(option_reference);
+	ref_git =3D real_path(option_reference);
=20
 	if (is_directory(mkpath("%s/.git/objects", ref_git)))
 		ref_git =3D mkpath("%s/.git", ref_git);
@@ -411,9 +411,9 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
=20
 	path =3D get_repo_path(repo_name, &is_bundle);
 	if (path)
-		repo =3D xstrdup(make_nonrelative_path(repo_name));
+		repo =3D xstrdup(absolute_path(repo_name));
 	else if (!strchr(repo_name, ':'))
-		repo =3D xstrdup(make_absolute_path(repo_name));
+		repo =3D xstrdup(real_path(repo_name));
 	else
 		repo =3D repo_name;
 	is_local =3D path && !is_bundle;
@@ -466,7 +466,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (safe_create_leading_directories_const(git_dir) < 0)
 		die("could not create leading directories of '%s'", git_dir);
-	set_git_dir(make_absolute_path(git_dir));
+	set_git_dir(real_path(git_dir));
=20
 	if (0 <=3D option_verbosity)
 		printf("Cloning into %s%s...\n",
diff --git a/builtin/init-db.c b/builtin/init-db.c
index fbeb380..63cf259 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -501,7 +501,7 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 		const char *git_dir_parent =3D strrchr(git_dir, '/');
 		if (git_dir_parent) {
 			char *rel =3D xstrndup(git_dir, git_dir_parent - git_dir);
-			git_work_tree_cfg =3D xstrdup(make_absolute_path(rel));
+			git_work_tree_cfg =3D xstrdup(real_path(rel));
 			free(rel);
 		}
 		if (!git_work_tree_cfg) {
@@ -510,7 +510,7 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 				die_errno ("Cannot access current working directory");
 		}
 		if (work_tree)
-			set_git_work_tree(make_absolute_path(work_tree));
+		  set_git_work_tree(real_path(work_tree));
 		else
 			set_git_work_tree(git_work_tree_cfg);
 		if (access(get_git_work_tree(), X_OK))
@@ -519,10 +519,10 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
 	}
 	else {
 		if (work_tree)
-			set_git_work_tree(make_absolute_path(work_tree));
+			set_git_work_tree(real_path(work_tree));
 	}
=20
-	set_git_dir(make_absolute_path(git_dir));
+	set_git_dir(real_path(git_dir));
=20
 	return init_db(template_dir, flags);
 }
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 760817d..d883585 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -740,7 +740,7 @@ static int add_refs_from_alternate(struct alternate=
_object_database *e, void *un
 	const struct ref *extra;
=20
 	e->name[-1] =3D '\0';
-	other =3D xstrdup(make_absolute_path(e->base));
+	other =3D xstrdup(real_path(e->base));
 	e->name[-1] =3D '/';
 	len =3D strlen(other);
=20
diff --git a/dir.c b/dir.c
index 570b651..5a9372a 100644
--- a/dir.c
+++ b/dir.c
@@ -1023,8 +1023,8 @@ char *get_relative_cwd(char *buffer, int size, co=
nst char *dir)
 	if (!getcwd(buffer, size))
 		die_errno("can't find the current directory");
=20
-	if (!is_absolute_path(dir))
-		dir =3D make_absolute_path(dir);
+	/* getcwd resolves links and gives us the real path */
+	dir =3D real_path(dir);
=20
 	while (*dir && *dir =3D=3D *cwd) {
 		dir++;
diff --git a/environment.c b/environment.c
index c3efbb9..cc670b1 100644
--- a/environment.c
+++ b/environment.c
@@ -139,7 +139,7 @@ static int git_work_tree_initialized;
 void set_git_work_tree(const char *new_work_tree)
 {
 	if (git_work_tree_initialized) {
-		new_work_tree =3D make_absolute_path(new_work_tree);
+		new_work_tree =3D real_path(new_work_tree);
 		if (strcmp(new_work_tree, work_tree))
 			die("internal error: work tree has already been set\n"
 			    "Current worktree: %s\nNew worktree: %s",
@@ -147,7 +147,7 @@ void set_git_work_tree(const char *new_work_tree)
 		return;
 	}
 	git_work_tree_initialized =3D 1;
-	work_tree =3D xstrdup(make_absolute_path(new_work_tree));
+	work_tree =3D xstrdup(real_path(new_work_tree));
 }
=20
 const char *get_git_work_tree(void)
diff --git a/exec_cmd.c b/exec_cmd.c
index 38545e8..171e841 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -89,7 +89,7 @@ static void add_path(struct strbuf *out, const char *=
path)
 		if (is_absolute_path(path))
 			strbuf_addstr(out, path);
 		else
-			strbuf_addstr(out, make_nonrelative_path(path));
+			strbuf_addstr(out, absolute_path(path));
=20
 		strbuf_addch(out, PATH_SEP);
 	}
diff --git a/lockfile.c b/lockfile.c
index b0d74cd..c6fb77b 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -164,10 +164,10 @@ static char *unable_to_lock_message(const char *p=
ath, int err)
 		    "If no other git process is currently running, this probably mea=
ns a\n"
 		    "git process crashed in this repository earlier. Make sure no ot=
her git\n"
 		    "process is running and remove the file manually to continue.",
-			    make_nonrelative_path(path), strerror(err));
+			    absolute_path(path), strerror(err));
 	} else
 		strbuf_addf(&buf, "Unable to create '%s.lock': %s",
-			    make_nonrelative_path(path), strerror(err));
+			    absolute_path(path), strerror(err));
 	return strbuf_detach(&buf, NULL);
 }
=20
diff --git a/setup.c b/setup.c
index dadc666..8cb1ad3 100644
--- a/setup.c
+++ b/setup.c
@@ -216,9 +216,7 @@ void setup_work_tree(void)
 	if (initialized)
 		return;
 	work_tree =3D get_git_work_tree();
-	git_dir =3D get_git_dir();
-	if (!is_absolute_path(git_dir))
-		git_dir =3D make_absolute_path(git_dir);
+	git_dir =3D real_path(get_git_dir());
 	if (!work_tree || chdir(work_tree))
 		die("This operation must be run in a work tree");
=20
@@ -229,7 +227,7 @@ void setup_work_tree(void)
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
 		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
=20
-	set_git_dir(make_relative_path(git_dir, work_tree));
+	set_git_dir(relative_path(git_dir, work_tree));
 	initialized =3D 1;
 }
=20
@@ -309,7 +307,7 @@ const char *read_gitfile_gently(const char *path)
=20
 	if (!is_git_directory(dir))
 		die("Not a git repository: %s", dir);
-	path =3D make_absolute_path(dir);
+	path =3D real_path(dir);
=20
 	free(buf);
 	return path;
@@ -389,7 +387,7 @@ static const char *setup_explicit_git_dir(const cha=
r *gitdirenv,
=20
 	if (!prefixcmp(cwd, worktree) &&
 	    cwd[strlen(worktree)] =3D=3D '/') { /* cwd inside worktree */
-		set_git_dir(make_absolute_path(gitdirenv));
+		set_git_dir(real_path(gitdirenv));
 		if (chdir(worktree))
 			die_errno("Could not chdir to '%s'", worktree);
 		cwd[len++] =3D '/';
@@ -414,7 +412,7 @@ static const char *setup_discovered_git_dir(const c=
har *gitdir,
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
 		if (offset !=3D len && !is_absolute_path(gitdir))
-			gitdir =3D xstrdup(make_absolute_path(gitdir));
+			gitdir =3D xstrdup(real_path(gitdir));
 		if (chdir(cwd))
 			die_errno("Could not come back to cwd");
 		return setup_explicit_git_dir(gitdir, cwd, len, nongit_ok);
@@ -422,7 +420,7 @@ static const char *setup_discovered_git_dir(const c=
har *gitdir,
=20
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
 	if (is_bare_repository_cfg > 0) {
-		set_git_dir(offset =3D=3D len ? gitdir : make_absolute_path(gitdir))=
;
+		set_git_dir(offset =3D=3D len ? gitdir : real_path(gitdir));
 		if (chdir(cwd))
 			die_errno("Could not come back to cwd");
 		return NULL;
--=20
1.7.4.1
