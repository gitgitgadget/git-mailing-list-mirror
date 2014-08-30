From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/32] $GIT_COMMON_DIR: a new environment variable
Date: Sat, 30 Aug 2014 15:33:41 +0700
Message-ID: <1409387642-24492-12-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:35:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe7j-0001vb-Ox
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbaH3Ie6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:34:58 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:51014 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbaH3Ie4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:34:56 -0400
Received: by mail-pd0-f176.google.com with SMTP id g10so2047626pdj.7
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XACNAfCxX6YPa9gLV0gOyImdUfnSa2Ej3zubp/R5g7Y=;
        b=p6bSUGy8DMONdn4aZx/5pL31Gtub0O/AekOVA2wjTkld691MPxrd4XVjZdZDyRUVn6
         j7J0gQ9uSI/vsEMTNErHWP6GgvvO6vy+3GH24kZ4HMQgHAzsds60Xd2KgtYxTRHRX+Kk
         4EFywTefL/fOG1X+pNSfe+M9M5DYpLfsQSsQr+aZ18UF/bg7JzuJCkq7J70KOjItivdn
         UDARj4R/YW9oPDaOfkBQW+fwUBTRyr49xdL8NFo0oQlD2eiAQIqH9/4OtVckLBn4ikwp
         AARpAZwJ66zjmNkK6wKNPEaYY9HzNei+rTNHkE0Aj19QoJOSSGy5ucPik28N+DELaqQQ
         5ZJg==
X-Received: by 10.70.37.227 with SMTP id b3mr22418766pdk.147.1409387694732;
        Sat, 30 Aug 2014 01:34:54 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id z3sm3243612pdj.12.2014.08.30.01.34.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:34:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:35:03 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256221>

This variable is intended to support multiple working directories
attached to a repository. Such a repository may have a main working
directory, created by either "git init" or "git clone" and one or more
linked working directories. These working directories and the main
repository share the same repository directory.

In linked working directories, $GIT_COMMON_DIR must be defined to point
to the real repository directory and $GIT_DIR points to an unused
subdirectory inside $GIT_COMMON_DIR. File locations inside the
repository are reorganized from the linked worktree view point:

 - worktree-specific such as HEAD, logs/HEAD, index, other top-level
   refs and unrecognized files are from $GIT_DIR.

 - the rest like objects, refs, info, hooks, packed-refs, shallow...
   are from $GIT_COMMON_DIR (except info/sparse-checkout, but that's
   a separate patch)

Scripts are supposed to retrieve paths in $GIT_DIR with "git rev-parse
--git-path", which will take care of "$GIT_DIR vs $GIT_COMMON_DIR"
business.

The redirection is done by git_path(), git_pathdup() and
strbuf_git_path(). The selected list of paths goes to $GIT_COMMON_DIR,
not the other way around in case a developer adds a new
worktree-specific file and it's accidentally promoted to be shared
across repositories (this includes unknown files added by third party
commands)

The list of known files that belong to $GIT_DIR are:

ADD_EDIT.patch BISECT_ANCESTORS_OK BISECT_EXPECTED_REV BISECT_LOG
BISECT_NAMES CHERRY_PICK_HEAD COMMIT_MSG FETCH_HEAD HEAD MERGE_HEAD
MERGE_MODE MERGE_RR NOTES_EDITMSG NOTES_MERGE_WORKTREE ORIG_HEAD
REVERT_HEAD SQUASH_MSG TAG_EDITMSG fast_import_crash_* logs/HEAD
next-index-* rebase-apply rebase-merge rsync-refs-* sequencer/*
shallow_*

Path mapping is NOT done for git_path_submodule(). Multi-checkouts are
not supported as submodules.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt                  |  8 ++++++
 Documentation/gitrepository-layout.txt | 45 +++++++++++++++++++++++++-=
--------
 cache.h                                |  4 ++-
 environment.c                          | 28 +++++++++++++++------
 path.c                                 | 34 +++++++++++++++++++++++++
 t/t0060-path-utils.sh                  | 16 ++++++++++++
 6 files changed, 116 insertions(+), 19 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7924209..749052f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -788,6 +788,14 @@ Git so take care if using Cogito etc.
 	an explicit repository directory set via 'GIT_DIR' or on the
 	command line.
=20
+'GIT_COMMON_DIR'::
+	If this variable is set to a path, non-worktree files that are
+	normally in $GIT_DIR will be taken from this path
+	instead. Worktree-specific files such as HEAD or index are
+	taken from $GIT_DIR. See linkgit:gitrepository-layout[5] for
+	details. This variable has lower precedence than other path
+	variables such as GIT_INDEX_FILE, GIT_OBJECT_DIRECTORY...
+
 Git Commits
 ~~~~~~~~~~~
 'GIT_AUTHOR_NAME'::
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index 17d2ea6..b88ac65 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -46,6 +46,9 @@ of incomplete object store is not suitable to be publ=
ished for
 use with dumb transports but otherwise is OK as long as
 `objects/info/alternates` points at the object stores it
 borrows from.
++
+This directory is ignored if $GIT_COMMON_DIR is set and
+"$GIT_COMMON_DIR/objects" will be used instead.
=20
 objects/[0-9a-f][0-9a-f]::
 	A newly created object is stored in its own file.
@@ -92,7 +95,8 @@ refs::
 	References are stored in subdirectories of this
 	directory.  The 'git prune' command knows to preserve
 	objects reachable from refs found in this directory and
-	its subdirectories.
+	its subdirectories. This directory is ignored if $GIT_COMMON_DIR
+	is set and "$GIT_COMMON_DIR/refs" will be used instead.
=20
 refs/heads/`name`::
 	records tip-of-the-tree commit objects of branch `name`
@@ -114,7 +118,8 @@ refs/replace/`<obj-sha1>`::
 packed-refs::
 	records the same information as refs/heads/, refs/tags/,
 	and friends record in a more efficient way.  See
-	linkgit:git-pack-refs[1].
+	linkgit:git-pack-refs[1]. This file is ignored if $GIT_COMMON_DIR
+	is set and "$GIT_COMMON_DIR/packed-refs" will be used instead.
=20
 HEAD::
 	A symref (see glossary) to the `refs/heads/` namespace
@@ -133,6 +138,11 @@ being a symref to point at the current branch.  Su=
ch a state
 is often called 'detached HEAD.'  See linkgit:git-checkout[1]
 for details.
=20
+config::
+	Repository specific configuration file. This file is ignored
+	if $GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/config" will be
+	used instead.
+
 branches::
 	A slightly deprecated way to store shorthands to be used
 	to specify a URL to 'git fetch', 'git pull' and 'git push'.
@@ -140,7 +150,10 @@ branches::
 	'name' can be given to these commands in place of
 	'repository' argument.  See the REMOTES section in
 	linkgit:git-fetch[1] for details.  This mechanism is legacy
-	and not likely to be found in modern repositories.
+	and not likely to be found in modern repositories. This
+	directory is ignored if $GIT_COMMON_DIR is set and
+	"$GIT_COMMON_DIR/branches" will be used instead.
+
=20
 hooks::
 	Hooks are customization scripts used by various Git
@@ -149,7 +162,9 @@ hooks::
 	default.  To enable, the `.sample` suffix has to be
 	removed from the filename by renaming.
 	Read linkgit:githooks[5] for more details about
-	each hook.
+	each hook. This directory is ignored if $GIT_COMMON_DIR is set
+	and "$GIT_COMMON_DIR/hooks" will be used instead.
+
=20
 index::
 	The current index file for the repository.  It is
@@ -157,7 +172,8 @@ index::
=20
 info::
 	Additional information about the repository is recorded
-	in this directory.
+	in this directory. This directory is ignored if $GIT_COMMON_DIR
+	is set and "$GIT_COMMON_DIR/index" will be used instead.
=20
 info/refs::
 	This file helps dumb transports discover what refs are
@@ -197,12 +213,15 @@ remotes::
 	when interacting with remote repositories via 'git fetch',
 	'git pull' and 'git push' commands.  See the REMOTES section
 	in linkgit:git-fetch[1] for details.  This mechanism is legacy
-	and not likely to be found in modern repositories.
+	and not likely to be found in modern repositories. This
+	directory is ignored if $GIT_COMMON_DIR is set and
+	"$GIT_COMMON_DIR/remotes" will be used instead.
=20
 logs::
-	Records of changes made to refs are stored in this
-	directory.  See linkgit:git-update-ref[1]
-	for more information.
+	Records of changes made to refs are stored in this directory.
+	See linkgit:git-update-ref[1] for more information. This
+	directory is ignored $GIT_COMMON_DIR is set and
+	"$GIT_COMMON_DIR/logs" will be used instead.
=20
 logs/refs/heads/`name`::
 	Records all changes made to the branch tip named `name`.
@@ -213,10 +232,14 @@ logs/refs/tags/`name`::
 shallow::
 	This is similar to `info/grafts` but is internally used
 	and maintained by shallow clone mechanism.  See `--depth`
-	option to linkgit:git-clone[1] and linkgit:git-fetch[1].
+	option to linkgit:git-clone[1] and linkgit:git-fetch[1]. This
+	file is ignored if $GIT_COMMON_DIR is set and
+	"$GIT_COMMON_DIR/shallow" will be used instead.
=20
 modules::
-	Contains the git-repositories of the submodules.
+	Contains the git-repositories of the submodules. This
+	directory is ignored if $GIT_COMMON_DIR is set and
+	"$GIT_COMMON_DIR/modules" will be used instead.
=20
 SEE ALSO
 --------
diff --git a/cache.h b/cache.h
index 0128b9a..b606ee4 100644
--- a/cache.h
+++ b/cache.h
@@ -362,6 +362,7 @@ static inline enum object_type object_type(unsigned=
 int mode)
=20
 /* Double-check local_repo_env below if you add to this list. */
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
+#define GIT_COMMON_DIR_ENVIRONMENT "GIT_COMMON_DIR"
 #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
@@ -415,6 +416,7 @@ extern int is_inside_git_dir(void);
 extern char *git_work_tree_cfg;
 extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
+extern const char *get_git_common_dir(void);
 extern int is_git_directory(const char *path);
 extern char *get_object_directory(void);
 extern char *get_index_file(void);
@@ -612,7 +614,7 @@ extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
-extern int git_db_env, git_index_env, git_graft_env;
+extern int git_db_env, git_index_env, git_graft_env, git_common_dir_en=
v;
=20
 /*
  * The character that begins a commented line in user-editable file
diff --git a/environment.c b/environment.c
index fee12a6..78a07e4 100644
--- a/environment.c
+++ b/environment.c
@@ -81,9 +81,9 @@ static char *work_tree;
 static const char *namespace;
 static size_t namespace_len;
=20
-static const char *git_dir;
+static const char *git_dir, *git_common_dir;
 static char *git_object_dir, *git_index_file, *git_graft_file;
-int git_db_env, git_index_env, git_graft_env;
+int git_db_env, git_index_env, git_graft_env, git_common_dir_env;
=20
 /*
  * Repository-local GIT_* environment variables; see cache.h for detai=
ls.
@@ -125,8 +125,8 @@ static char *expand_namespace(const char *raw_names=
pace)
 	return strbuf_detach(&buf, NULL);
 }
=20
-static char *git_path_from_env(const char *envvar, const char *path,
-			       int *fromenv)
+static char *git_path_from_env(const char *envvar, const char *git_dir=
,
+			       const char *path, int *fromenv)
 {
 	const char *value =3D getenv(envvar);
 	if (!value) {
@@ -149,9 +149,18 @@ static void setup_git_env(void)
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
 	gitfile =3D read_gitfile(git_dir);
 	git_dir =3D xstrdup(gitfile ? gitfile : git_dir);
-	git_object_dir =3D git_path_from_env(DB_ENVIRONMENT, "objects", &git_=
db_env);
-	git_index_file =3D git_path_from_env(INDEX_ENVIRONMENT, "index", &git=
_index_env);
-	git_graft_file =3D git_path_from_env(GRAFT_ENVIRONMENT, "info/grafts"=
, &git_graft_env);
+	git_common_dir =3D getenv(GIT_COMMON_DIR_ENVIRONMENT);
+	if (git_common_dir) {
+		git_common_dir_env =3D 1;
+		git_common_dir =3D xstrdup(git_common_dir);
+	} else
+		git_common_dir =3D git_dir;
+	git_object_dir =3D git_path_from_env(DB_ENVIRONMENT, git_common_dir,
+					   "objects", &git_db_env);
+	git_index_file =3D git_path_from_env(INDEX_ENVIRONMENT, git_dir,
+					   "index", &git_index_env);
+	git_graft_file =3D git_path_from_env(GRAFT_ENVIRONMENT, git_common_di=
r,
+					   "info/grafts", &git_graft_env);
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		check_replace_refs =3D 0;
 	namespace =3D expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
@@ -174,6 +183,11 @@ const char *get_git_dir(void)
 	return git_dir;
 }
=20
+const char *get_git_common_dir(void)
+{
+	return git_common_dir;
+}
+
 const char *get_git_namespace(void)
 {
 	if (!namespace)
diff --git a/path.c b/path.c
index 3deb80c..8a6586c 100644
--- a/path.c
+++ b/path.c
@@ -90,6 +90,38 @@ static void replace_dir(struct strbuf *buf, int len,=
 const char *newdir)
 		buf->buf[newlen] =3D '/';
 }
=20
+static const char *common_list[] =3D {
+	"/branches", "/hooks", "/info", "/logs", "/lost-found", "/modules",
+	"/objects", "/refs", "/remotes", "/rr-cache", "/svn",
+	"config", "gc.pid", "packed-refs", "shallow",
+	NULL
+};
+
+static void update_common_dir(struct strbuf *buf, int git_dir_len)
+{
+	char *base =3D buf->buf + git_dir_len;
+	const char **p;
+
+	if (is_dir_file(base, "logs", "HEAD"))
+		return;	/* keep this in $GIT_DIR */
+	for (p =3D common_list; *p; p++) {
+		const char *path =3D *p;
+		int is_dir =3D 0;
+		if (*path =3D=3D '/') {
+			path++;
+			is_dir =3D 1;
+		}
+		if (is_dir && dir_prefix(base, path)) {
+			replace_dir(buf, git_dir_len, get_git_common_dir());
+			return;
+		}
+		if (!is_dir && !strcmp(base, path)) {
+			replace_dir(buf, git_dir_len, get_git_common_dir());
+			return;
+		}
+	}
+}
+
 static void adjust_git_path(struct strbuf *buf, int git_dir_len)
 {
 	const char *base =3D buf->buf + git_dir_len;
@@ -101,6 +133,8 @@ static void adjust_git_path(struct strbuf *buf, int=
 git_dir_len)
 			      get_index_file(), strlen(get_index_file()));
 	else if (git_db_env && dir_prefix(base, "objects"))
 		replace_dir(buf, git_dir_len + 7, get_object_directory());
+	else if (git_common_dir_env)
+		update_common_dir(buf, git_dir_len);
 }
=20
 static void do_git_path(struct strbuf *buf, const char *fmt, va_list a=
rgs)
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 33d2818..f5d6f80 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -262,5 +262,21 @@ test_expect_success 'setup fake objects directory =
foo' 'mkdir foo'
 test_git_path GIT_OBJECT_DIRECTORY=3Dfoo objects foo
 test_git_path GIT_OBJECT_DIRECTORY=3Dfoo objects/foo foo/foo
 test_git_path GIT_OBJECT_DIRECTORY=3Dfoo objects2 .git/objects2
+test_expect_success 'setup common repository' 'git --git-dir=3Dbar ini=
t'
+test_git_path GIT_COMMON_DIR=3Dbar index                    .git/index
+test_git_path GIT_COMMON_DIR=3Dbar HEAD                     .git/HEAD
+test_git_path GIT_COMMON_DIR=3Dbar logs/HEAD                .git/logs/=
HEAD
+test_git_path GIT_COMMON_DIR=3Dbar objects                  bar/object=
s
+test_git_path GIT_COMMON_DIR=3Dbar objects/bar              bar/object=
s/bar
+test_git_path GIT_COMMON_DIR=3Dbar info/exclude             bar/info/e=
xclude
+test_git_path GIT_COMMON_DIR=3Dbar info/grafts              bar/info/g=
rafts
+test_git_path GIT_COMMON_DIR=3Dbar remotes/bar              bar/remote=
s/bar
+test_git_path GIT_COMMON_DIR=3Dbar branches/bar             bar/branch=
es/bar
+test_git_path GIT_COMMON_DIR=3Dbar logs/refs/heads/master   bar/logs/r=
efs/heads/master
+test_git_path GIT_COMMON_DIR=3Dbar refs/heads/master        bar/refs/h=
eads/master
+test_git_path GIT_COMMON_DIR=3Dbar hooks/me                 bar/hooks/=
me
+test_git_path GIT_COMMON_DIR=3Dbar config                   bar/config
+test_git_path GIT_COMMON_DIR=3Dbar packed-refs              bar/packed=
-refs
+test_git_path GIT_COMMON_DIR=3Dbar shallow                  bar/shallo=
w
=20
 test_done
--=20
2.1.0.rc0.78.gc0d8480
