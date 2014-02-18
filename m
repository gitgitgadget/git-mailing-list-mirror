From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 10/25] Add new environment variable $GIT_COMMON_DIR
Date: Tue, 18 Feb 2014 20:39:59 +0700
Message-ID: <1392730814-19656-11-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:41:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkvj-0007tj-9Q
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659AbaBRNlR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:41:17 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:45089 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655AbaBRNlO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:41:14 -0500
Received: by mail-pa0-f48.google.com with SMTP id kx10so16621861pab.21
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PNYipLaSQ0sDE3paOWBTzjtPCC8oHHNBxQEv4t/+Ra4=;
        b=mfeHWKsWqsc7QGFw60JpS52jymNvnjLhmy0BhQZfqTrSow/iDORhFr3PWW7CV5p9Zn
         5MkB3gbME54HFoVC0IY8uD0xHVIwpO0xQgbK9gspssUVSHh5KLklp0X1gP2pyTpqxC0M
         mjP1v8IKr8lRmin+/2XDtXjkBtSyU7A92UC8LOIL1oE/4HKSa/GKTqIwzxX1PyvnciEN
         19MZ7iOeQ326CKJgDgKFGTX37zzDCYk8lniBzll33a0ULSvRcawvcQiUgOZU7WBRXdly
         8YivX4ZXGc859774DcAzaLt8JUxxDVPlu+UA8LqC6DsuQHmE4NnBXsUNmM80JFFsX58W
         tTag==
X-Received: by 10.66.139.130 with SMTP id qy2mr32883767pab.73.1392730873772;
        Tue, 18 Feb 2014 05:41:13 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id qq5sm56093133pbb.24.2014.02.18.05.41.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:41:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:41:26 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242310>

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
   are from $GIT_COMMON_DIR

Scripts are supposed to retrieve paths in $GIT_DIR with "git rev-parse
--git-path", which will take care of "$GIT_DIR vs $GIT_COMMON_DIR"
business.

Note that logs/refs/.tmp-renamed-log is used to prepare new reflog
entry and it's supposed to be on the same filesystem as the target
reflog file. This is not guaranteed true for logs/HEAD when it's
mapped to repos/xx/logs/HEAD because the user can put "repos"
directory on different filesystem. Don't mess with .git unless you
know what you're doing.

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
 Documentation/git.txt |  8 ++++++++
 cache.h               |  4 +++-
 environment.c         | 19 +++++++++++++++----
 path.c                | 28 ++++++++++++++++++++++++++++
 t/t0060-path-utils.sh | 15 +++++++++++++++
 5 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 02bbc08..2c4a055 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -773,6 +773,14 @@ Git so take care if using Cogito etc.
 	an explicit repository directory set via 'GIT_DIR' or on the
 	command line.
=20
+'GIT_COMMON_DIR'::
+	If this variable is set to a path, non-worktree files that are
+	normally in $GIT_DIR will be taken from this path
+	instead. Worktree-specific files such as HEAD or index are
+	taken from $GIT_DIR. This variable has lower precedence than
+	other path variables such as GIT_INDEX_FILE,
+	GIT_OBJECT_DIRECTORY...
+
 Git Commits
 ~~~~~~~~~~~
 'GIT_AUTHOR_NAME'::
diff --git a/cache.h b/cache.h
index 6c08e4a..51ade32 100644
--- a/cache.h
+++ b/cache.h
@@ -347,6 +347,7 @@ static inline enum object_type object_type(unsigned=
 int mode)
=20
 /* Double-check local_repo_env below if you add to this list. */
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
+#define GIT_COMMON_DIR_ENVIRONMENT "GIT_COMMON_DIR"
 #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
@@ -400,6 +401,7 @@ extern int is_inside_git_dir(void);
 extern char *git_work_tree_cfg;
 extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
+extern const char *get_git_common_dir(void);
 extern int is_git_directory(const char *path);
 extern char *get_object_directory(void);
 extern char *get_index_file(void);
@@ -585,7 +587,7 @@ extern int fsync_object_files;
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
index f513479..c998120 100644
--- a/environment.c
+++ b/environment.c
@@ -80,9 +80,9 @@ static char *work_tree;
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
@@ -134,10 +134,16 @@ static void setup_git_env(void)
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
 	gitfile =3D read_gitfile(git_dir);
 	git_dir =3D xstrdup(gitfile ? gitfile : git_dir);
+	git_common_dir =3D getenv(GIT_COMMON_DIR_ENVIRONMENT);
+	if (git_common_dir) {
+		git_common_dir_env =3D 1;
+		git_common_dir =3D xstrdup(git_common_dir);
+	} else
+		git_common_dir =3D git_dir;
 	git_object_dir =3D getenv(DB_ENVIRONMENT);
 	if (!git_object_dir) {
-		git_object_dir =3D xmalloc(strlen(git_dir) + 9);
-		sprintf(git_object_dir, "%s/objects", git_dir);
+		git_object_dir =3D xmalloc(strlen(git_common_dir) + 9);
+		sprintf(git_object_dir, "%s/objects", git_common_dir);
 	} else
 		git_db_env =3D 1;
 	git_index_file =3D getenv(INDEX_ENVIRONMENT);
@@ -173,6 +179,11 @@ const char *get_git_dir(void)
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
index 0f8c3dc..2d757dc 100644
--- a/path.c
+++ b/path.c
@@ -90,6 +90,32 @@ static void replace_dir(struct strbuf *buf, int len,=
 const char *newdir)
 		buf->buf[newlen] =3D '/';
 }
=20
+static void update_common_dir(struct strbuf *buf, int git_dir_len)
+{
+	const char *common_dir_list[] =3D {
+		"branches", "hooks", "info", "logs", "lost-found", "modules",
+		"objects", "refs", "remotes", "rr-cache", "svn",
+		NULL
+	};
+	const char *common_top_file_list[] =3D {
+		"config", "gc.pid", "packed-refs", "shallow", NULL
+	};
+	char *base =3D buf->buf + git_dir_len;
+	const char **p;
+	if (is_dir_file(base, "logs", "HEAD"))
+		return;	/* keep this in $GIT_DIR */
+	for (p =3D common_dir_list; *p; p++)
+		if (dir_prefix(base, *p)) {
+			replace_dir(buf, git_dir_len, get_git_common_dir());
+			return;
+		}
+	for (p =3D common_top_file_list; *p; p++)
+		if (!strcmp(base, *p)) {
+			replace_dir(buf, git_dir_len, get_git_common_dir());
+			return;
+		}
+}
+
 static void adjust_git_path(struct strbuf *buf, int git_dir_len)
 {
 	const char *base =3D buf->buf + git_dir_len;
@@ -101,6 +127,8 @@ static void adjust_git_path(struct strbuf *buf, int=
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
index 1d29901..f9a77e4 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -241,5 +241,20 @@ test_expect_success 'setup fake objects directory =
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
1.8.5.2.240.g8478abd
