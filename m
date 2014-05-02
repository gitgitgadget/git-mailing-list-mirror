From: dturner@twopensource.com
Subject: [PATCH 3/3] Watchman support
Date: Fri,  2 May 2014 19:14:11 -0400
Message-ID: <1399072451-15561-4-git-send-email-dturner@twopensource.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 01:15:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgMfT-0006ca-0y
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 01:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbaEBXOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 19:14:53 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:55076 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbaEBXOp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 19:14:45 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so2960935qcx.27
        for <git@vger.kernel.org>; Fri, 02 May 2014 16:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=agotFSrvhP/gNN/zCKgWVsmhLSqL1ou+ActBvtgVVPU=;
        b=CCi1ZGfv6Q0zAyzuj5yFSoP1K7/l+5HNvWIaQgLzc2+gqJYRl3bL16udIEfQJNKpHR
         76g6RDouaLu3bC5dogOg1njdsBY1kYd/a5DOPtnhq+52/yd45zHddKA6IvkJpxCj6HxZ
         OWu2AkUcDO2wcXui+qVbOf0No/6Q9qSlxZ9SBn1EcAB6Wz8XASwloZCfNLG5udR7Dmlq
         F1P6fmDMTw2V8qxwQMEer+MjWpp8sMYlF9I32G24cUDV+FK0n2NiN/Bo7sTX4k4mgMoQ
         UyyUD/tOBmhYCnUYvr42ERSBwL6qTsvkltaxTOPqHwpwC/jIXP0wQ9ryyRG74ORY+c8Y
         wGIg==
X-Gm-Message-State: ALoCoQkG+Fs34Udr0g1eIO/sOr3D/e1FOsJJTTyZop1F6w09pnrGm2Gwobn7MjPxgHey7/gBT1Sy
X-Received: by 10.224.41.75 with SMTP id n11mr26253877qae.21.1399072483919;
        Fri, 02 May 2014 16:14:43 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.196.25])
        by mx.google.com with ESMTPSA id q62sm598071qgd.0.2014.05.02.16.14.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 May 2014 16:14:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc0.31.g69c1a2d
In-Reply-To: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248006>

From: David Turner <dturner@twitter.com>

Add support for filesystem view caching and updating via Facebook's
Watchman daemon.

Signed-off-by: David Turner <dturner@twitter.com>
---
 Documentation/watchman.txt       |  27 ++
 Makefile                         |   9 +
 cache.h                          |   4 +
 config.c                         |  10 +
 configure.ac                     |   8 +
 diff-lib.c                       |  70 +++--
 dir.c                            | 210 +++++++++----
 dir.h                            |  18 +-
 environment.c                    |  18 +-
 fs_cache.c                       | 645 +++++++++++++++++++++++++++++++++++++++
 fs_cache.h                       | 138 +++++++++
 hash-io.c                        |   4 +-
 read-cache.c                     |  61 +++-
 t/t1012-read-tree-df.sh          |   2 +-
 t/t2201-add-update-typechange.sh |   5 +-
 t/t2204-add-ignored.sh           |   6 +-
 t/t6001-rev-list-graft.sh        |   2 +-
 t/t7900-watchman.sh              | 249 +++++++++++++++
 t/test-lib.sh                    |   1 +
 unpack-trees.c                   |   2 +-
 watchman-support.c               | 640 ++++++++++++++++++++++++++++++++++++++
 watchman-support.h               |  10 +
 22 files changed, 2045 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/watchman.txt
 create mode 100644 fs_cache.c
 create mode 100644 fs_cache.h
 create mode 100755 t/t7900-watchman.sh
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

diff --git a/Documentation/watchman.txt b/Documentation/watchman.txt
new file mode 100644
index 0000000..b849e98
--- /dev/null
+++ b/Documentation/watchman.txt
@@ -0,0 +1,27 @@
+How git uses watchman
+---------------------
+
+Git status (and some other commands) have to determine which files
+have changed between the working copy and the index.  Ordinarily, this
+requires checking every file in the working directory.  But if you
+have watchman (https://github.com/facebook/watchman) installed, git
+can cache the state of the working directory and use watchman to track
+file changes, making commands like git status faster.
+
+set core.usewatchman = true to use watchman.
+You can also set
+core.watchmansynctimeout = [number of milliseconds]
+to change watchman's sync timeout; see the watchman docs for details
+on this.  You should only change this if you see watchman timeout
+error messages.
+
+Internals
+---------
+
+The filesystem cache stores information about every file in the
+working tree.  In almost every case where git calls lstat or
+opendir/readdir, the modified file cache can be consulted instead.
+
+The file system cache is stored on disk in .git/fs_cache.  It is
+stored very similarly to the index, except without path prefix
+compression.
diff --git a/Makefile b/Makefile
index 4cd642d..0c10a28 100644
--- a/Makefile
+++ b/Makefile
@@ -667,6 +667,7 @@ LIB_H += ewah/ewok.h
 LIB_H += ewah/ewok_rlw.h
 LIB_H += fetch-pack.h
 LIB_H += fmt-merge-msg.h
+LIB_H += fs_cache.h
 LIB_H += fsck.h
 LIB_H += gettext.h
 LIB_H += git-compat-util.h
@@ -808,6 +809,7 @@ LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec_cmd.o
 LIB_OBJS += fetch-pack.o
+LIB_OBJS += fs_cache.o
 LIB_OBJS += fsck.o
 LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
@@ -1445,6 +1447,13 @@ ifdef RUNTIME_PREFIX
 	COMPAT_CFLAGS += -DRUNTIME_PREFIX
 endif
 
+ifdef USE_WATCHMAN
+	LIB_H += watchman-support.h
+	LIB_OBJS += watchman-support.o
+	EXTLIBS += $(WATCHMAN_LIBS)
+	BASIC_CFLAGS += -DUSE_WATCHMAN
+endif
+
 ifdef NO_PTHREADS
 	BASIC_CFLAGS += -DNO_PTHREADS
 else
diff --git a/cache.h b/cache.h
index c5917f4..023f9c9 100644
--- a/cache.h
+++ b/cache.h
@@ -272,6 +272,7 @@ struct index_state {
 	struct cache_entry **cache;
 	unsigned int version;
 	unsigned int cache_nr, cache_alloc, cache_changed;
+	struct fs_cache *fs_cache;
 	struct string_list *resolve_undo;
 	struct cache_tree *cache_tree;
 	struct cache_time timestamp;
@@ -352,6 +353,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
+#define FS_CACHE_ENVIRONMENT "GIT_FS_CACHE_FILE"
 #define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
 #define GIT_SHALLOW_FILE_ENVIRONMENT "GIT_SHALLOW_FILE"
 #define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
@@ -594,6 +596,8 @@ extern int check_replace_refs;
 
 extern int fsync_object_files;
 extern int core_preload_index;
+extern int core_use_watchman;
+extern int core_watchman_sync_timeout;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 
diff --git a/config.c b/config.c
index a30cb5c..6bbdac4 100644
--- a/config.c
+++ b/config.c
@@ -854,6 +854,16 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.usewatchman")) {
+		core_use_watchman = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.watchmansynctimeout")) {
+		core_watchman_sync_timeout = git_config_int(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.createobject")) {
 		if (!strcmp(value, "rename"))
 			object_creation_mode = OBJECT_CREATION_USES_RENAMES;
diff --git a/configure.ac b/configure.ac
index b711254..76fcb83 100644
--- a/configure.ac
+++ b/configure.ac
@@ -962,6 +962,14 @@ GIT_CONF_SUBST([NO_INITGROUPS])
 #
 # Define NO_ICONV if your libc does not properly support iconv.
 
+# Check for watchman client library
+
+AC_CHECK_LIB([watchman], [watchman_connect],
+       [WATCHMAN_LIBS="-lwatchman"
+	USE_WATCHMAN=YesPlease],
+       [USE_WATCHMAN=])
+GIT_CONF_SUBST([WATCHMAN_LIBS])
+GIT_CONF_SUBST([USE_WATCHMAN])
 
 ## Other checks.
 # Define USE_PIC if you need the main git objects to be built with -fPIC
diff --git a/diff-lib.c b/diff-lib.c
index 0448729..bbeca00 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -2,6 +2,7 @@
  * Copyright (C) 2005 Junio C Hamano
  */
 #include "cache.h"
+#include "fs_cache.h"
 #include "quote.h"
 #include "commit.h"
 #include "diff.h"
@@ -17,24 +18,8 @@
  * diff-files
  */
 
-/*
- * Has the work tree entity been removed?
- *
- * Return 1 if it was removed from the work tree, 0 if an entity to be
- * compared with the cache entry ce still exists (the latter includes
- * the case where a directory that is not a submodule repository
- * exists for ce that is a submodule -- it is a submodule that is not
- * checked out).  Return negative for an error.
- */
-static int check_removed(const struct cache_entry *ce, struct stat *st)
+static int check_gitlink(const struct cache_entry *ce, struct stat *st)
 {
-	if (lstat(ce->name, st) < 0) {
-		if (errno != ENOENT && errno != ENOTDIR)
-			return -1;
-		return 1;
-	}
-	if (has_symlink_leading_path(ce->name, ce_namelen(ce)))
-		return 1;
 	if (S_ISDIR(st->st_mode)) {
 		unsigned char sub[20];
 
@@ -56,6 +41,57 @@ static int check_removed(const struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
+static int fs_cache_check_removed(const struct fs_cache *fs_cache, const struct cache_entry *ce, struct stat *st)
+{
+	struct fsc_entry *fe;
+
+	fe = fs_cache_file_exists(fs_cache, ce->name, ce_namelen(ce));
+	if (!fe) {
+		return 1;
+	}
+	if (fe_deleted(fe)) {
+		return 1;
+	}
+
+	fe_to_stat(fe, st);
+
+/* This should not be necessary, because the fs_cache does not store
+   children of symlinked directories.  TODO: ensure this
+	if (has_symlink_leading_path(ce->name, ce_namelen(ce)))
+		return 1;
+*/
+	if (check_gitlink(ce, st))
+		return 1;
+
+	return 0;
+}
+
+/*
+ * Has the work tree entity been removed?
+ *
+ * Return 1 if it was removed from the work tree, 0 if an entity to be
+ * compared with the cache entry ce still exists (the latter includes
+ * the case where a directory that is not a submodule repository
+ * exists for ce that is a submodule -- it is a submodule that is not
+ * checked out).  Return negative for an error.
+ */
+static int check_removed(const struct cache_entry *ce, struct stat *st)
+{
+	if (the_index.fs_cache)
+		return fs_cache_check_removed(the_index.fs_cache, ce, st);
+
+	if (lstat(ce->name, st) < 0) {
+		if (errno != ENOENT && errno != ENOTDIR)
+			return -1;
+		return 1;
+	}
+	if (has_symlink_leading_path(ce->name, ce_namelen(ce)))
+		return 1;
+	if (check_gitlink(ce, st))
+		return 1;
+	return 0;
+}
+
 /*
  * Has a file changed or has a submodule new commits or a dirty work tree?
  *
diff --git a/dir.c b/dir.c
index eb6f581..41258ce 100644
--- a/dir.c
+++ b/dir.c
@@ -8,6 +8,7 @@
  *		 Junio Hamano, 2005-2006
  */
 #include "cache.h"
+#include "fs_cache.h"
 #include "dir.h"
 #include "refs.h"
 #include "wildmatch.h"
@@ -33,8 +34,8 @@ enum path_treatment {
 
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	const char *path, int len,
-	int check_only, const struct path_simplify *simplify);
-static int get_dtype(struct dirent *de, const char *path, int len);
+	int check_only, const struct path_simplify *simplify,
+	struct fsc_entry *fe);
 
 /* helper string functions with support for the ignore_case flag */
 int strcmp_icase(const char *a, const char *b)
@@ -179,7 +180,8 @@ int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec)
 	len = common_prefix_len(pathspec);
 
 	/* Read the directory and prune it */
-	read_directory(dir, pathspec->nr ? pathspec->_raw[0] : "", len, pathspec);
+	read_directory(&the_index, dir, pathspec->nr ? pathspec->_raw[0] : "",
+		       len, pathspec);
 	return len;
 }
 
@@ -536,7 +538,7 @@ int add_excludes_from_file_to_list(const char *fname,
 	size_t size = 0;
 	char *buf, *entry;
 
-	fd = open(fname, O_RDONLY);
+	fd = fs_cache_open(the_index.fs_cache, fname, O_RDONLY);
 	if (fd < 0 || fstat(fd, &st) < 0) {
 		if (errno != ENOENT)
 			warn_on_inaccessible(fname);
@@ -597,6 +599,8 @@ struct exclude_list *add_exclude_list(struct dir_struct *dir,
 	el = &group->el[group->nr++];
 	memset(el, 0, sizeof(*el));
 	el->src = src;
+	if (group_type == EXC_FILE)
+		dir->flags &= ~DIR_STD_EXCLUDES;
 	return el;
 }
 
@@ -609,6 +613,7 @@ void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 	el = add_exclude_list(dir, EXC_FILE, fname);
 	if (add_excludes_from_file_to_list(fname, "", 0, el, 0) < 0)
 		die("cannot use %s as an exclude file", fname);
+	dir->flags &= ~DIR_STD_EXCLUDES;
 }
 
 int match_basename(const char *basename, int basenamelen,
@@ -763,7 +768,9 @@ static struct exclude *last_exclude_matching_from_lists(struct dir_struct *dir,
 	int i, j;
 	struct exclude_list_group *group;
 	struct exclude *exclude;
-	for (i = EXC_CMDL; i <= EXC_FILE; i++) {
+	int last = dir->flags & DIR_EXCLUDE_CMDL_ONLY ? EXC_CMDL : EXC_FILE;
+
+	for (i = EXC_CMDL; i <= last; i++) {
 		group = &dir->exclude_list_group[i];
 		for (j = group->nr - 1; j >= 0; j--) {
 			exclude = last_exclude_matching_from_list(
@@ -852,6 +859,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 
 		/* Try to read per-directory file unless path is too long */
 		if (dir->exclude_per_dir &&
+		    !(dir->flags & DIR_EXCLUDE_CMDL_ONLY) &&
 		    stk->baselen + strlen(dir->exclude_per_dir) < PATH_MAX) {
 			strcpy(dir->basebuf + stk->baselen,
 					dir->exclude_per_dir);
@@ -910,6 +918,17 @@ int is_excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
 	return 0;
 }
 
+static int fs_cache_is_excluded(struct dir_struct *dir, const char *pathname, int *dtype_p, struct fsc_entry *fe)
+{
+	struct exclude *exclude;
+	exclude = last_exclude_matching(dir, pathname, dtype_p);
+	if (exclude)
+		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
+	if (dir->flags & DIR_STD_EXCLUDES && fe)
+		return fe_excluded(fe);
+	return 0;
+}
+
 static struct dir_entry *dir_entry_new(const char *pathname, int len)
 {
 	struct dir_entry *ent;
@@ -1047,7 +1066,7 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
  */
 static enum path_treatment treat_directory(struct dir_struct *dir,
 	const char *dirname, int len, int exclude,
-	const struct path_simplify *simplify)
+	const struct path_simplify *simplify, struct fsc_entry *fe)
 {
 	/* The "len-1" is to strip the final '/' */
 	switch (directory_exists_in_index(dirname, len-1)) {
@@ -1073,7 +1092,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		return exclude ? path_excluded : path_untracked;
 
-	return read_directory_recursive(dir, dirname, len, 1, simplify);
+	return read_directory_recursive(dir, dirname, len, 1, simplify, fe);
 }
 
 /*
@@ -1167,7 +1186,7 @@ static int get_index_dtype(const char *path, int len)
 	return DT_UNKNOWN;
 }
 
-static int get_dtype(struct dirent *de, const char *path, int len)
+int get_dtype(struct dirent *de, const char *path, int len)
 {
 	int dtype = de ? DTYPE(de) : DT_UNKNOWN;
 	struct stat st;
@@ -1191,7 +1210,8 @@ static int get_dtype(struct dirent *de, const char *path, int len)
 static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  struct strbuf *path,
 					  const struct path_simplify *simplify,
-					  int dtype, struct dirent *de)
+					  int dtype, struct dirent *de,
+					  struct fsc_entry *fe)
 {
 	int exclude;
 	int has_path_in_index = !!cache_file_exists(path->buf, path->len, ignore_case);
@@ -1227,7 +1247,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	    (directory_exists_in_index(path->buf, path->len) == index_nonexistent))
 		return path_none;
 
-	exclude = is_excluded(dir, path->buf, &dtype);
+	exclude = fs_cache_is_excluded(dir, path->buf, &dtype, fe);
 
 	/*
 	 * Excluded? If we don't explicitly want to show
@@ -1242,7 +1262,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	case DT_DIR:
 		strbuf_addch(path, '/');
 		return treat_directory(dir, path->buf, path->len, exclude,
-			simplify);
+			simplify, fe);
 	case DT_REG:
 	case DT_LNK:
 		return exclude ? path_excluded : path_untracked;
@@ -1253,7 +1273,8 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 				      struct dirent *de,
 				      struct strbuf *path,
 				      int baselen,
-				      const struct path_simplify *simplify)
+				      const struct path_simplify *simplify,
+				      struct fsc_entry *fe)
 {
 	int dtype;
 
@@ -1265,7 +1286,59 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 		return path_none;
 
 	dtype = DTYPE(de);
-	return treat_one_path(dir, path, simplify, dtype, de);
+	return treat_one_path(dir, path, simplify, dtype, de, fe);
+}
+
+static int handle(struct dir_struct *dir, const char *base, int baselen,
+		  int check_only, const struct path_simplify *simplify,
+		  struct dirent *de, enum path_treatment *dir_state,
+		  struct strbuf *path, struct fsc_entry *fe)
+{
+	enum path_treatment state, subdir_state;
+
+	/* check how the file or directory should be treated */
+	state = treat_path(dir, de, path, baselen, simplify, fe);
+
+	if (state > *dir_state)
+		*dir_state = state;
+
+	/* recurse into subdir if instructed by treat_path */
+	if (state == path_recurse) {
+		subdir_state = read_directory_recursive(dir, path->buf,
+			path->len, check_only, simplify, fe);
+		if (subdir_state > *dir_state)
+			*dir_state = subdir_state;
+	}
+
+	if (check_only) {
+		/* abort early if maximum state has been reached */
+		if (*dir_state == path_untracked)
+			return 1;
+		/* skip the dir_add_* part */
+		return 0;
+	}
+
+	/* add the path to the appropriate result list */
+	switch (state) {
+	case path_excluded:
+		if (dir->flags & DIR_SHOW_IGNORED)
+			dir_add_name(dir, path->buf, path->len);
+		else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
+			 ((dir->flags & DIR_COLLECT_IGNORED) &&
+			  exclude_matches_pathspec(path->buf, path->len,
+				simplify)))
+			dir_add_ignored(dir, path->buf, path->len);
+		break;
+
+	case path_untracked:
+		if (!(dir->flags & DIR_SHOW_IGNORED))
+			dir_add_name(dir, path->buf, path->len);
+		break;
+
+	default:
+		break;
+	}
+	return 0;
 }
 
 /*
@@ -1282,63 +1355,44 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 				    const char *base, int baselen,
 				    int check_only,
-				    const struct path_simplify *simplify)
+				    const struct path_simplify *simplify,
+				    struct fsc_entry *parent)
 {
 	DIR *fdir;
-	enum path_treatment state, subdir_state, dir_state = path_none;
-	struct dirent *de;
+	enum path_treatment dir_state = path_none;
 	struct strbuf path = STRBUF_INIT;
 
 	strbuf_add(&path, base, baselen);
 
-	fdir = opendir(path.len ? path.buf : ".");
-	if (!fdir)
-		goto out;
-
-	while ((de = readdir(fdir)) != NULL) {
-		/* check how the file or directory should be treated */
-		state = treat_path(dir, de, &path, baselen, simplify);
-		if (state > dir_state)
-			dir_state = state;
-
-		/* recurse into subdir if instructed by treat_path */
-		if (state == path_recurse) {
-			subdir_state = read_directory_recursive(dir, path.buf,
-				path.len, check_only, simplify);
-			if (subdir_state > dir_state)
-				dir_state = subdir_state;
-		}
+	if (the_index.fs_cache) {
+		struct fsc_entry *fe;
 
-		if (check_only) {
-			/* abort early if maximum state has been reached */
-			if (dir_state == path_untracked)
+		if (!parent)
+			goto out;
+
+		for (fe = parent->first_child; fe; fe = fe->next_sibling) {
+			struct dirent de;
+			if (fe_deleted(fe))
+				continue;
+			de.d_ino = -1;
+			de.d_type = fe_dtype(fe);
+			strcpy(de.d_name, basename(fe->path));
+			if (handle(dir, base, baselen, check_only, simplify, &de, &dir_state, &path, fe))
 				break;
-			/* skip the dir_add_* part */
-			continue;
 		}
+	} else {
+		struct dirent *de;
+		fdir = opendir(path.len ? path.buf : ".");
+		if (!fdir)
+			goto out;
 
-		/* add the path to the appropriate result list */
-		switch (state) {
-		case path_excluded:
-			if (dir->flags & DIR_SHOW_IGNORED)
-				dir_add_name(dir, path.buf, path.len);
-			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
-				((dir->flags & DIR_COLLECT_IGNORED) &&
-				exclude_matches_pathspec(path.buf, path.len,
-					simplify)))
-				dir_add_ignored(dir, path.buf, path.len);
-			break;
-
-		case path_untracked:
-			if (!(dir->flags & DIR_SHOW_IGNORED))
-				dir_add_name(dir, path.buf, path.len);
-			break;
-
-		default:
-			break;
+		while ((de = readdir(fdir)) != NULL) {
+			if (handle(dir, base, baselen, check_only, simplify, de, &dir_state, &path, NULL))
+				break;
 		}
+		closedir(fdir);
 	}
-	closedir(fdir);
+
  out:
 	strbuf_release(&path);
 
@@ -1383,7 +1437,8 @@ static void free_simplify(struct path_simplify *simplify)
 
 static int treat_leading_path(struct dir_struct *dir,
 			      const char *path, int len,
-			      const struct path_simplify *simplify)
+			      const struct path_simplify *simplify,
+			      struct fsc_entry *fe)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int baselen, rc = 0;
@@ -1410,7 +1465,7 @@ static int treat_leading_path(struct dir_struct *dir,
 		if (simplify_away(sb.buf, sb.len, simplify))
 			break;
 		if (treat_one_path(dir, &sb, simplify,
-				   DT_DIR, NULL) == path_none)
+				   DT_DIR, NULL, fe) == path_none)
 			break; /* do not recurse into it */
 		if (len <= baselen) {
 			rc = 1;
@@ -1422,9 +1477,13 @@ static int treat_leading_path(struct dir_struct *dir,
 	return rc;
 }
 
-int read_directory(struct dir_struct *dir, const char *path, int len, const struct pathspec *pathspec)
+
+int read_directory(struct index_state *istate, struct dir_struct *dir,
+		   const char *path, int len, const struct pathspec *pathspec)
 {
 	struct path_simplify *simplify;
+	int saved_flags = dir->flags;
+	struct fsc_entry *fe = NULL;
 
 	/*
 	 * Check out create_simplify()
@@ -1448,11 +1507,32 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const stru
 	 * create_simplify().
 	 */
 	simplify = create_simplify(pathspec ? pathspec->_raw : NULL);
-	if (!len || treat_leading_path(dir, path, len, simplify))
-		read_directory_recursive(dir, path, len, 0, simplify);
+
+	/*
+	  Check for standard excludes.
+	  Standard excludes means: exclude_per_dir
+	 */
+	if (!dir->exclude_per_dir || strcmp(dir->exclude_per_dir, ".gitignore"))
+		dir->flags &= ~DIR_STD_EXCLUDES;
+
+	if (istate->fs_cache && dir->flags & DIR_STD_EXCLUDES) {
+		dir->flags |= DIR_EXCLUDE_CMDL_ONLY;
+	}
+
+	if (istate->fs_cache) {
+		int len_no_slash = len;
+		if (len && path[len - 1] == '/')
+			len_no_slash --;
+		fe = fs_cache_file_exists(istate->fs_cache, path, len_no_slash);
+	}
+
+	if (!len || treat_leading_path(dir, path, len, simplify, fe)) {
+		read_directory_recursive(dir, path, len, 0, simplify, fe);
+	}
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_name);
+	dir->flags = saved_flags;
 	return dir->nr;
 }
 
@@ -1608,6 +1688,7 @@ void setup_standard_excludes(struct dir_struct *dir)
 {
 	const char *path;
 	char *xdg_path;
+	int previously_empty;
 
 	dir->exclude_per_dir = ".gitignore";
 	path = git_path("info/exclude");
@@ -1615,10 +1696,13 @@ void setup_standard_excludes(struct dir_struct *dir)
 		home_config_paths(NULL, &xdg_path, "ignore");
 		excludes_file = xdg_path;
 	}
+	previously_empty = dir->exclude_list_group[EXC_FILE].nr == 0;
 	if (!access_or_warn(path, R_OK, 0))
 		add_excludes_from_file(dir, path);
 	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
 		add_excludes_from_file(dir, excludes_file);
+	if (previously_empty)
+		dir->flags |= DIR_STD_EXCLUDES;
 }
 
 int remove_path(const char *name)
diff --git a/dir.h b/dir.h
index 55e5345..6453faf 100644
--- a/dir.h
+++ b/dir.h
@@ -81,7 +81,18 @@ struct dir_struct {
 		DIR_NO_GITLINKS = 1<<3,
 		DIR_COLLECT_IGNORED = 1<<4,
 		DIR_SHOW_IGNORED_TOO = 1<<5,
-		DIR_COLLECT_KILLED_ONLY = 1<<6
+		DIR_COLLECT_KILLED_ONLY = 1<<6,
+		/*
+		 * Whether the standard excludes are the only file
+		 * excludes which have been set up (if so, we can use
+		 * the fs_cache to optimize is_excluded).
+		 */
+		DIR_STD_EXCLUDES = 1<<7,
+		/*
+		 * Excludes should only check the command-line (for
+		 * use with fs_cache)
+		 */
+		DIR_EXCLUDE_CMDL_ONLY = 1<<8
 	} flags;
 	struct dir_entry **entries;
 	struct dir_entry **ignored;
@@ -138,7 +149,7 @@ extern int match_pathspec(const struct pathspec *pathspec,
 extern int within_depth(const char *name, int namelen, int depth, int max_depth);
 
 extern int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec);
-extern int read_directory(struct dir_struct *, const char *path, int len, const struct pathspec *pathspec);
+extern int read_directory(struct index_state *index, struct dir_struct *, const char *path, int len, const struct pathspec *pathspec);
 
 extern int is_excluded_from_list(const char *pathname, int pathlen, const char *basename,
 				 int *dtype, struct exclude_list *el);
@@ -223,4 +234,7 @@ static inline int dir_path_match(const struct dir_entry *ent,
 			      has_trailing_dir);
 }
 
+int get_dtype(struct dirent *de, const char *path, int len);
+
+
 #endif
diff --git a/environment.c b/environment.c
index 5c4815d..060e473 100644
--- a/environment.c
+++ b/environment.c
@@ -73,6 +73,10 @@ char comment_line_char = '#';
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
 
+/* Use Watchman for faster status queries */
+int core_use_watchman = 0;
+int core_watchman_sync_timeout = 300;
+
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
 static char *work_tree;
@@ -81,7 +85,7 @@ static const char *namespace;
 static size_t namespace_len;
 
 static const char *git_dir;
-static char *git_object_dir, *git_index_file, *git_graft_file;
+static char *git_object_dir, *git_index_file, *git_graft_file, *git_fs_cache_file;
 
 /*
  * Repository-local GIT_* environment variables; see cache.h for details.
@@ -143,6 +147,11 @@ static void setup_git_env(void)
 		git_index_file = xmalloc(strlen(git_dir) + 7);
 		sprintf(git_index_file, "%s/index", git_dir);
 	}
+	git_fs_cache_file = getenv(FS_CACHE_ENVIRONMENT);
+	if (!git_fs_cache_file) {
+		git_fs_cache_file = xmalloc(strlen(git_dir) + 10);
+		sprintf(git_fs_cache_file, "%s/fs_cache", git_dir);
+	}
 	git_graft_file = getenv(GRAFT_ENVIRONMENT);
 	if (!git_graft_file)
 		git_graft_file = git_pathdup("info/grafts");
@@ -266,6 +275,13 @@ char *get_graft_file(void)
 	return git_graft_file;
 }
 
+char *get_fs_cache_file(void)
+{
+	if (!git_fs_cache_file)
+		setup_git_env();
+	return git_fs_cache_file;
+}
+
 int set_git_dir(const char *path)
 {
 	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
diff --git a/fs_cache.c b/fs_cache.c
new file mode 100644
index 0000000..3702186
--- /dev/null
+++ b/fs_cache.c
@@ -0,0 +1,645 @@
+#include "cache.h"
+#include "fs_cache.h"
+#include "strbuf.h"
+#include "hashmap.h"
+#include "hash-io.h"
+
+#define FS_CACHE_SIGNATURE 0x4D4F4443	/* "MODC" */
+
+static int fe_entry_cmp(const struct fsc_entry *f1,
+			const struct fsc_entry *f2,
+			const char *name)
+{
+	if (f1->pathlen != f2->pathlen)
+		return 1;
+	name = name ? name : f2->path;
+	return ignore_case ? strncasecmp(f1->path, name, f1->pathlen) :
+		strncmp(f1->path, name, f1->pathlen);
+
+}
+
+unsigned char fe_dtype(struct fsc_entry *file)
+{
+	if (fe_is_reg(file)) {
+		return DT_REG;
+	}
+	if (fe_is_dir(file)) {
+		return DT_DIR;
+	}
+	if (fe_is_lnk(file)) {
+		return DT_LNK;
+	}
+	return DT_UNKNOWN;
+}
+
+#define FS_CACHE_FORMAT_LB 1
+#define FS_CACHE_FORMAT_UB 2
+
+static int verify_hdr(struct fs_cache_header *hdr, unsigned long size)
+{
+	vmac_ctx_t c;
+	unsigned char sha1[20];
+	int hdr_version;
+
+	if (hdr->hdr_signature != htonl(FS_CACHE_SIGNATURE)) {
+		warning("bad fs_cache signature");
+		return -1;
+	}
+	hdr_version = ntohl(hdr->hdr_version);
+	if (hdr_version < FS_CACHE_FORMAT_LB || FS_CACHE_FORMAT_UB < hdr_version) {
+		warning("bad fs_cache version %d", hdr_version);
+		return -1;
+	}
+
+	unsigned char *key = (unsigned char *)"abcdefghijklmnop";
+	vmac_set_key(key, &c);
+	vmac_update_unaligned(hdr, size - 20, &c);
+	vmac_final(sha1, &c);
+	if (hashcmp(sha1, (unsigned char *)hdr + size - 20)) {
+		warning("bad fs_cache file vmac signature");
+		return -1;
+	}
+
+	return 0;
+}
+
+static struct fsc_entry *create_from_disk(struct fs_cache *fs_cache, struct ondisk_fsc_entry *disk_fe, unsigned long *consumed)
+{
+	struct fsc_entry *fe;
+	int pathlen = strlen(disk_fe->path);
+
+	fe = obstack_alloc(&fs_cache->obs, sizeof(*fe) + pathlen + 1);
+
+	fe->size = ntohl(disk_fe->size);
+	fe->mode = ntohl(disk_fe->mode);
+	fe->flags = ntohl(disk_fe->flags);
+
+	fe->ctime.sec = ntohl(disk_fe->ctime.sec);
+	fe->mtime.sec = ntohl(disk_fe->mtime.sec);
+	fe->ctime.nsec = ntohl(disk_fe->ctime.nsec);
+	fe->mtime.nsec = ntohl(disk_fe->mtime.nsec);
+
+	fe->ino = ntohl(disk_fe->ino);
+	fe->dev = ntohl(disk_fe->dev);
+
+	fe->uid = ntohl(disk_fe->uid);
+	fe->gid = ntohl(disk_fe->gid);
+
+	fe->parent = NULL;
+	fe->first_child = NULL;
+	fe->next_sibling = NULL;
+	memcpy(fe->path, disk_fe->path, pathlen + 1);
+	fe->pathlen = pathlen;
+
+	hashmap_entry_init(fe, memihash(fe->path, pathlen));
+	*consumed = sizeof(*disk_fe) + pathlen + 1;
+	return fe;
+}
+
+static void copy_fs_cache_entry_to_ondisk(
+	struct ondisk_fsc_entry *ondisk,
+	struct fsc_entry *fe)
+{
+
+	ondisk->size = htonl(fe->size);
+	ondisk->mode = htonl(fe->mode);
+	ondisk->flags = htonl(fe->flags & ~FE_NEW);
+
+	ondisk->ctime.sec = htonl(fe->ctime.sec);
+	ondisk->mtime.sec = htonl(fe->mtime.sec);
+	ondisk->ctime.nsec = htonl(fe->ctime.nsec);
+	ondisk->mtime.nsec = htonl(fe->mtime.nsec);
+
+	ondisk->ino = htonl(fe->ino);
+	ondisk->dev = htonl(fe->dev);
+
+	ondisk->uid = htonl(fe->uid);
+	ondisk->gid = htonl(fe->gid);
+
+	memcpy(ondisk->path, fe->path, fe->pathlen + 1);
+
+}
+
+static int fe_write_entry(struct fsc_entry *fe, int fd, struct hash_context *context)
+{
+	int result;
+	static struct ondisk_fsc_entry *ondisk = NULL;
+	static size_t max_size = sizeof(*ondisk) + 1 + PATH_MAX;
+	size_t size;
+
+	size = sizeof(*ondisk) + fe->pathlen + 1;
+	if (size > max_size) {
+		max_size = size;
+		if (ondisk) {
+			ondisk = xrealloc(ondisk, max_size);
+			memset(ondisk, 0, max_size);
+		}
+	}
+
+
+	if (!ondisk)
+		ondisk = xcalloc(1, max_size);
+
+	copy_fs_cache_entry_to_ondisk(ondisk, fe);
+
+	result = write_with_hash(context, fd, ondisk, size);
+
+	return result ? -1 : 0;
+}
+
+static int fe_write_entry_recursive(struct fsc_entry *fe, int fd, struct hash_context *c)
+{
+	if (fe_write_entry(fe, fd, c))
+		return error("failed to write some file of fs_cache");
+	fe = fe->first_child;
+	while (fe) {
+		fe_write_entry_recursive(fe, fd, c);
+		fe = fe->next_sibling;
+	}
+
+	return 0;
+}
+
+static char *xstrcpy(char *dest, const char *src)
+{
+	while ((*dest++ = *src++)) {
+	}
+
+	return dest;
+}
+
+int write_fs_cache(struct fs_cache *fs_cache)
+{
+	struct hash_context c;
+	struct fs_cache_header *hdr;
+	int hdr_size;
+	struct stat st;
+	int fd;
+	const char *path;
+	char *cur;
+	int string_size;
+
+	path = get_fs_cache_file();
+
+	fd = open(path, O_WRONLY|O_TRUNC|O_CREAT, 0666);
+	if (fd < 0)
+		die_errno("failed to open fs_cache file %s", path);
+
+	string_size = strlen(fs_cache->last_update) +
+		strlen(fs_cache->repo_path) +
+		strlen(fs_cache->excludes_file) + 3;
+
+	hdr_size = sizeof(*hdr) + string_size;
+	hdr = xmalloc(hdr_size);
+	hdr->hdr_signature = htonl(FS_CACHE_SIGNATURE);
+	hdr->hdr_version = htonl(fs_cache->version);
+	hdr->hdr_entries = htonl(fs_cache->nr);
+	hdr->flags = htonl(fs_cache->flags);
+	hashcpy(hdr->git_excludes_sha1, fs_cache->git_excludes_sha1);
+	hashcpy(hdr->user_excludes_sha1, fs_cache->user_excludes_sha1);
+	cur = xstrcpy(hdr->strings, fs_cache->last_update);
+	cur = xstrcpy(cur, fs_cache->repo_path);
+	cur = xstrcpy(cur, fs_cache->excludes_file);
+
+	hash_context_init(&c, HASH_IO_VMAC);
+
+	if (write_with_hash(&c, fd, hdr, hdr_size) < 0)
+		die_errno("failed to write header of fs_cache");
+
+	fe_write_entry_recursive(fs_cache_file_exists(fs_cache, "", 0), fd, &c);
+	if (write_with_hash_flush(&c, fd) || fstat(fd, &st))
+		return error("Failed to flush/fstat fs_cache file");
+
+	hash_context_release(&c);
+	free(hdr);
+	return 0;
+}
+
+void *mmap_fs_cache(size_t *mmap_size) {
+	struct stat st;
+	void *mmap;
+	const char *path = get_fs_cache_file();
+	int fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		if (errno == ENOENT)
+			return NULL;
+		die_errno("fs_cache file open failed");
+	}
+
+	if (fstat(fd, &st))
+		die_errno("cannot stat the open fs_cache");
+
+	*mmap_size = xsize_t(st.st_size);
+	if (*mmap_size < sizeof(struct fs_cache_header) + 20) {
+		warning("fs_cache file smaller than expected");
+		return NULL;
+	}
+
+	mmap = xmmap(NULL, *mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (mmap == MAP_FAILED)
+		die_errno("unable to map fs_cache file");
+	close(fd);
+	return mmap;
+}
+
+/* Loading the fs_cache can take some time, and we might want to thread
+ * it with other loads; we need the last-update time and the repo path
+ * to check whether this is a good idea, so this function will preload
+ * it.  Note that the caller must free the returned strings.
+ */
+void fs_cache_preload_metadata(char **last_update, char **repo_path) {
+	size_t mmap_size;
+	void *mmap;
+	struct fs_cache_header *hdr;
+	int version;
+
+	mmap = mmap_fs_cache(&mmap_size);
+	if (!mmap) {
+		*last_update = *repo_path = NULL;
+		return;
+	}
+	hdr = mmap;
+	version = ntohl(hdr->hdr_version);
+	if (version < FS_CACHE_FORMAT_LB || FS_CACHE_FORMAT_UB < version) {
+		warning("bad fs_cache version %d", version);
+		goto unmap;
+	}
+
+	*last_update = xstrdup(hdr->strings);
+	*repo_path = xstrdup(hdr->strings + strlen(*last_update) + 1);
+
+unmap:
+	munmap(mmap, mmap_size);
+}
+
+static void write_fs_cache_if_necessary(void)
+{
+	struct fs_cache *fs_cache = the_index.fs_cache;
+	if (fs_cache && fs_cache->needs_write && fs_cache->fully_loaded) {
+		write_fs_cache(fs_cache);
+		the_index.fs_cache = 0;
+	}
+}
+
+static void fe_set_parent(struct fsc_entry *fe, struct fsc_entry *parent)
+{
+	fe->parent = parent;
+	fe->next_sibling = fe->parent->first_child;
+	fe->parent->first_child = fe;
+}
+
+void set_up_parent(struct fs_cache *fs_cache, struct fsc_entry *fe)
+{
+	char *last_slash;
+	int parent_len;
+	struct fsc_entry *parent;
+	if (fe->pathlen == 0)
+		return;
+
+	last_slash = strrchr(fe->path, '/');
+
+	if (last_slash) {
+		parent_len = last_slash - fe->path;
+	} else {
+		parent_len = 0;
+	}
+
+	parent = fs_cache_file_exists(fs_cache, fe->path, parent_len);
+	if (!parent) {
+		die("Missing parent directory for %s", fe->path);
+	}
+	fe_set_parent(fe, parent);
+}
+
+static char *read_string(char **out, char *in) {
+	int len = strlen(in);
+	*out = xstrdup(in);
+	return in + len + 1;
+}
+
+/* Load the modified file cache from disk.  If the cache is corrupt,
+ * prints a warning and returns NULL; we can safely recreate it.  If
+ * the cache is missing, also returns NULL.  If there is some other
+ * problem reading the cache (say it's read-only, or we get an io
+ * error), die with an error message. */
+struct fs_cache *read_fs_cache(void)
+{
+	struct fs_cache *fs_cache;
+	struct fs_cache_header *hdr;
+	int i;
+	unsigned int nr;
+	void *mmap;
+	void *mmap_cur;
+	size_t mmap_size;
+
+	mmap = mmap_fs_cache(&mmap_size);
+	if (!mmap) {
+		return NULL;
+	}
+
+	hdr = mmap;
+	if (verify_hdr(hdr, mmap_size) < 0)
+		goto unmap;
+
+	fs_cache = xcalloc(1, sizeof(*fs_cache));
+	obstack_init(&fs_cache->obs);
+	nr = ntohl(hdr->hdr_entries);
+	fs_cache->flags = ntohl(hdr->flags);
+	fs_cache->version = ntohl(hdr->hdr_version);
+	hashmap_init(&fs_cache->paths, (hashmap_cmp_fn) fe_entry_cmp, nr);
+	fs_cache->nr = 0;
+	hashcpy(fs_cache->git_excludes_sha1, hdr->git_excludes_sha1);
+	hashcpy(fs_cache->user_excludes_sha1, hdr->user_excludes_sha1);
+
+	mmap_cur = hdr->strings;
+	mmap_cur = read_string(&fs_cache->last_update, mmap_cur);
+	mmap_cur = read_string(&fs_cache->repo_path, mmap_cur);
+	mmap_cur = read_string(&fs_cache->excludes_file, mmap_cur);
+
+	struct fsc_entry *parent_stack[PATH_MAX];
+	int parent_top = -1;
+
+	for (i = 0; i < nr; i++) {
+		struct ondisk_fsc_entry *disk_fe;
+		struct fsc_entry *fe;
+		unsigned long consumed;
+
+		disk_fe = (struct ondisk_fsc_entry *) mmap_cur;
+		fe = create_from_disk(fs_cache, disk_fe, &consumed);
+		/*
+		 * We eliminate deleted cache entries on read because
+		 * otherwise we have to count them in advance to fill
+		 * in nr, and that would be expensive.
+		 */
+		if (!fe_deleted(fe)) {
+			fs_cache_insert(fs_cache, fe);
+			if (parent_top == -1) {
+				parent_top = 0;
+				parent_stack[0] = fe;
+			} else {
+				char *p = parent_stack[parent_top]->path;
+				char *c = fe->path;
+				parent_top = 1;
+				for (; *p && *c; ++p, ++c) {
+					if (*p != *c)
+						break;
+					if (*p == '/')
+						parent_top ++;
+				}
+				if (*p == 0 && *c == '/')
+					parent_top ++;
+				parent_stack[parent_top] = fe;
+				fe_set_parent(fe, parent_stack[parent_top - 1]);
+			}
+		}
+		mmap_cur += consumed;
+	}
+
+	fs_cache->fully_loaded = 1;
+
+	munmap(mmap, mmap_size);
+
+	atexit(write_fs_cache_if_necessary);
+	return fs_cache;
+
+unmap:
+	munmap(mmap, mmap_size);
+	return NULL;
+}
+
+struct fs_cache *empty_fs_cache(void)
+{
+	struct fs_cache *fs_cache = xcalloc(1, sizeof(*fs_cache));
+	fs_cache->version = 1;
+	fs_cache->needs_write = 1;
+	fs_cache->fully_loaded = 1;
+	hashmap_init(&fs_cache->paths, (hashmap_cmp_fn) fe_entry_cmp, 1);
+	atexit(write_fs_cache_if_necessary);
+	return fs_cache;
+}
+
+struct fsc_entry *fs_cache_file_exists(const struct fs_cache *fs_cache,
+				       const char *name, int namelen)
+{
+	return fs_cache_file_exists_prehash(fs_cache, name, namelen,
+					  memihash(name, namelen));
+}
+
+struct fsc_entry *fs_cache_file_exists_prehash(const struct fs_cache *fs_cache, const char *path, int pathlen, unsigned int hash)
+{
+	struct fsc_entry key;
+
+	hashmap_entry_init(&key, hash);
+	key.pathlen = pathlen;
+	return hashmap_get(&fs_cache->paths, &key, path);
+}
+
+struct fsc_entry *make_fs_cache_entry(const char *path)
+{
+	return make_fs_cache_entry_len(path, strlen(path));
+}
+
+struct fsc_entry *make_fs_cache_entry_len(const char *path, int len)
+{
+	struct fsc_entry *fe = xcalloc(1, sizeof(*fe) + len + 1);
+	fe_set_new(fe);
+	memcpy(fe->path, path, len);
+	fe->pathlen = len;
+	hashmap_entry_init(fe, memihash(fe->path, fe->pathlen));
+	return fe;
+}
+
+void fs_cache_insert(struct fs_cache *fs_cache, struct fsc_entry *fe)
+{
+	hashmap_add(&fs_cache->paths, fe);
+	fs_cache->nr ++;
+}
+
+static void fs_cache_remove_recursive(struct fs_cache *fs_cache,
+				    struct fsc_entry *fe)
+{
+	struct fsc_entry *cur, *next;
+	for (cur = fe->first_child; cur; cur = next) {
+		fs_cache_remove_recursive(fs_cache, cur);
+		next = cur->next_sibling;
+		cur->next_sibling = NULL;
+		cur->parent = NULL;
+		cur->first_child = NULL;
+	}
+
+	hashmap_remove(&fs_cache->paths, fe, fe);
+	fs_cache->nr --;
+}
+
+static void fe_remove_from_parent(struct fsc_entry *fe)
+{
+	struct fsc_entry *prev, *cur;
+	if (fe->parent) {
+		prev = NULL;
+		for (cur = fe->parent->first_child; cur; cur = cur->next_sibling) {
+			if (cur == fe) {
+				if (prev)
+					prev->next_sibling = fe->next_sibling;
+				else
+					fe->parent->first_child = fe->next_sibling;
+				break;
+			}
+			prev = cur;
+		}
+	}
+}
+
+void fe_delete_children(struct fsc_entry *fe)
+{
+	for (fe = fe->first_child; fe; fe = fe->next_sibling) {
+		fe_set_deleted(fe);
+	}
+}
+
+void fe_clear_children(struct fs_cache *fs_cache, struct fsc_entry *fe) {
+	for (fe = fe->first_child; fe; fe = fe->next_sibling) {
+		fs_cache_remove(fs_cache, fe);
+	}
+
+}
+
+void fe_set_deleted(struct fsc_entry *fe)
+{
+	fe->flags |= FE_DELETED;
+	fe_delete_children(fe);
+}
+
+void fs_cache_remove_nonrecursive(struct fs_cache *fs_cache,
+				  struct fsc_entry *fe)
+{
+
+	hashmap_remove(&fs_cache->paths, fe, fe);
+	fs_cache->nr --;
+
+	fe_remove_from_parent(fe);
+}
+
+void fs_cache_remove(struct fs_cache *fs_cache,
+		   struct fsc_entry *fe)
+{
+
+	fs_cache_remove_recursive(fs_cache, fe);
+
+	fe_remove_from_parent(fe);
+}
+
+void free_fs_cache(struct fs_cache *fs_cache)
+{
+	obstack_free(&fs_cache->obs, NULL);
+	free(fs_cache->last_update);
+	free(fs_cache->repo_path);
+	free(fs_cache->excludes_file);
+}
+
+void fe_to_stat(struct fsc_entry *fe, struct stat *st)
+{
+	st->st_mtime = fe->mtime.sec;
+	st->st_ctime = fe->ctime.sec;
+#ifndef NO_NSEC
+#ifdef USE_ST_TIMESPEC
+	st->st_mtimespec.tv_nsec = fe->mtime.nsec;
+	st->st_ctimespec.tv_nsec = fe->ctime.nsec;
+#else
+	st->st_mtim.tv_nsec = fe->mtime.nsec;
+	st->st_ctim.tv_nsec = fe->ctime.nsec;
+#endif
+#endif
+	st->st_mode  = fe->mode;
+	st->st_ino  = fe->ino;
+	st->st_dev  = fe->dev;
+	st->st_uid  = fe->uid;
+	st->st_gid  = fe->gid;
+	st->st_size  = fe->size;
+}
+
+int is_in_dot_git(const char *name)
+{
+	char *evil = ".git";
+	char *cur = evil;
+	while (*name) {
+		if (*name == *cur++) {
+			name++;
+			if (*cur == 0) {
+				if (*name == 0 || *name == '/') {
+					return 1;
+				}
+			}
+		} else {
+			if (*name == '/') {
+				cur = evil;
+			} else {
+				cur = "";
+			}
+			name++;
+		}
+	}
+	return 0;
+}
+
+static int is_path_prefix(const char *putative_parent, const char *fname) {
+	const char* c;
+	for (c = putative_parent; *c && *fname; ++c, ++fname) {
+		if (*c != *fname) {
+			return 0;
+		}
+	}
+	return *c == 0 && (*fname == 0 || *fname == '/');
+}
+
+int fs_cache_open(struct fs_cache *fs_cache, const char *fname, int flags) {
+	if (fs_cache && fname[0] != '/' && !is_path_prefix(get_git_dir(), fname)) {
+		struct fsc_entry *fe = fs_cache_file_exists(fs_cache, fname, strlen(fname));
+		if (!fe || fe_deleted(fe)) {
+			errno = ENOENT;
+			return -1;
+		}
+	}
+	return open(fname, flags);
+}
+
+static const int topological_rank[256] = {
+	0, /* slash moved here */ 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
+	15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
+	32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
+	1 /* slash is special */,
+	48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62,
+	63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78,
+	79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94,
+	95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106,
+	107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120,
+	121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134,
+	135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148,
+	149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162,
+	163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176,
+	177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190,
+	191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204,
+	205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218,
+	219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232,
+	233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246,
+	247, 248, 249, 250, 251, 252, 253, 254, 255
+};
+
+/*
+ * Compare fsc_entry structs topologically -- that is, so that parent
+ * directories come before their children.
+ */
+int cmp_fsc_entry(const void *a, const void *b)
+{
+	struct fsc_entry* const * sa = a;
+	struct fsc_entry* const * sb = b;
+	const unsigned char* pa = (unsigned char *)(*sa)->path;
+	const unsigned char* pb = (unsigned char *)(*sb)->path;
+	while (*pa && *pb) {
+		int ca = topological_rank[*pa++];
+		int cb = topological_rank[*pb++];
+		int diff = ca - cb;
+		if (diff)
+			return diff;
+	}
+	return topological_rank[*pa] - topological_rank[*pb];
+}
diff --git a/fs_cache.h b/fs_cache.h
new file mode 100644
index 0000000..fb558e1
--- /dev/null
+++ b/fs_cache.h
@@ -0,0 +1,138 @@
+#ifndef FS_CACHE_H
+#define FS_CACHE_H
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include "compat/obstack.h"
+
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "hashmap.h"
+
+#define obstack_chunk_alloc xmalloc
+#define obstack_chunk_free free
+
+/* The filesystem cache (fs_cache) stores the state of every file
+ * inside the root directory (excluding those in .git).  The state
+ * includes whether or not the file exists, as well as most of what
+ * lstat returns.
+ */
+
+#define fe_is_reg(fe) (S_ISREG((fe)->mode))
+#define fe_is_dir(fe) (S_ISDIR((fe)->mode))
+#define fe_is_lnk(fe) (S_ISLNK((fe)->mode))
+
+/* Directories get very different treatment generally; the normal bits
+ * don't apply to them, since they have no independent existence in
+ * git.  Also, they are subject to spooky action at a distance -- if a
+ * file called x/a/b/c is created (and added to the index), then x
+ * suddenly must get added to the index.
+ */
+
+struct fsc_entry {
+	struct hashmap_entry ent;
+	unsigned int mode;
+	off_t size;
+	unsigned int flags;
+	struct cache_time ctime;
+	struct cache_time mtime;
+	ino_t ino;
+	dev_t dev;
+	uid_t uid;
+	gid_t gid;
+	struct fsc_entry *parent;
+	struct fsc_entry *first_child;
+	struct fsc_entry *next_sibling;
+	int pathlen;
+	char path[FLEX_ARRAY];
+};
+
+#define FE_DELETED           (1 << 0)
+
+/* Excluded by the standard set of gitexcludes */
+#define FE_EXCLUDED          (1 << 8)
+
+/* Not yet saved to disk */
+#define FE_NEW               (1 << 10)
+
+void fe_set_deleted(struct fsc_entry *fe);
+#define fe_clear_deleted(fe) ((fe)->flags &= ~FE_DELETED)
+#define fe_deleted(fe) ((fe)->flags & FE_DELETED)
+
+#define fe_excluded(fe) ((fe)->flags & FE_EXCLUDED)
+#define fe_set_excluded(fe) ((fe)->flags |= FE_EXCLUDED)
+#define fe_clear_excluded(fe) ((fe)->flags &= ~FE_EXCLUDED)
+
+#define fe_new(fe) ((fe)->flags & FE_NEW)
+#define fe_set_new(fe) ((fe)->flags |= FE_NEW)
+#define fe_clear_new(fe) ((fe)->flags &= ~FE_NEW)
+
+struct fs_cache {
+	char *last_update;
+	char *repo_path;
+	char *excludes_file;
+	unsigned char git_excludes_sha1[20]; /* for .git/info/exclude */
+	unsigned char user_excludes_sha1[20]; /* for core.excludesfile */
+	unsigned int version;
+	struct hashmap paths;
+	int nr;
+	unsigned invalid : 1; /* A commit hook might have made fs
+			       * changes, necessitating a reload. */
+	unsigned needs_write : 1;
+	unsigned fully_loaded : 1;
+	uint32_t flags;
+	struct obstack obs;
+};
+
+struct fs_cache_header {
+	uint32_t hdr_signature;
+	uint32_t hdr_version;
+	uint32_t hdr_entries;
+	uint32_t flags;
+	unsigned char git_excludes_sha1[20];
+	unsigned char user_excludes_sha1[20];
+	char strings[FLEX_ARRAY];
+};
+
+struct ondisk_fsc_entry {
+	uint64_t ino;
+	uint64_t dev;
+	struct cache_time ctime;
+	struct cache_time mtime;
+	uint32_t mode;
+	uint32_t size;
+	uint32_t flags;
+	uint32_t uid;
+	uint32_t gid;
+	char path[FLEX_ARRAY];
+};
+
+extern char *get_fs_cache_file(void);
+
+unsigned char fe_dtype(struct fsc_entry *file);
+void fe_to_stat(struct fsc_entry *fe, struct stat *st);
+void fe_delete_children(struct fsc_entry *fe);
+void fe_clear_children(struct fs_cache *fs_cache, struct fsc_entry *fe);
+
+struct fs_cache *read_fs_cache(void);
+int write_fs_cache(struct fs_cache *fs_cache);
+struct fs_cache *empty_fs_cache(void);
+struct fsc_entry *fs_cache_file_exists(const struct fs_cache *fs_cache, const char *name, int namelen);
+struct fsc_entry *fs_cache_file_exists_prehash(const struct fs_cache *fs_cache, const char *name, int namelen, unsigned int hash);
+struct fsc_entry *make_fs_cache_entry(const char *path);
+struct fsc_entry *make_fs_cache_entry_len(const char *path, int len);
+void fs_cache_preload_metadata(char **last_update, char **repo_path);
+
+void fs_cache_remove(struct fs_cache *fs_cache, struct fsc_entry *fe);
+void fs_cache_insert(struct fs_cache *fs_cache, struct fsc_entry *fe);
+void free_fs_cache(struct fs_cache *fs_cache);
+void set_up_parent(struct fs_cache *fs_cache, struct fsc_entry *fe);
+
+int fs_cache_open(struct fs_cache *fs_cache, const char *fname, int flags);
+
+int is_in_dot_git(const char *name);
+
+int cmp_fsc_entry(const void *a, const void *b);
+
+#endif /* FS_CACHE_H */
diff --git a/hash-io.c b/hash-io.c
index ab4c7e4..907a360 100644
--- a/hash-io.c
+++ b/hash-io.c
@@ -154,11 +154,11 @@ void hash_context_init(struct hash_context *ctx, enum hash_io_type type)
 	ctx->write_buffer_len = 0;
 	switch (type) {
 	case HASH_IO_VMAC:
-		ctx->c.vc = malloc(sizeof *ctx->c.vc);
+		ctx->c.vc = xmalloc(sizeof *ctx->c.vc);
 		vmac_set_key(VMAC_KEY, ctx->c.vc);
 		break;
 	case HASH_IO_SHA1:
-		ctx->c.sc = malloc(sizeof *ctx->c.sc);
+		ctx->c.sc = xmalloc(sizeof *ctx->c.sc);
 		git_SHA1_Init(ctx->c.sc);
 		break;
 	default:
diff --git a/read-cache.c b/read-cache.c
index a124e59..5b1ca78 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -5,6 +5,7 @@
  */
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "fs_cache.h"
 #include "cache-tree.h"
 #include "refs.h"
 #include "dir.h"
@@ -16,6 +17,10 @@
 #include "varint.h"
 #include "hash-io.h"
 
+#ifdef USE_WATCHMAN
+#include "watchman-support.h"
+#endif
+
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
 
@@ -1004,6 +1009,30 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 	return 0;
 }
 
+static int fs_cache_lstat(struct fs_cache *fs_cache,
+			const char *name, int len, struct stat *st)
+{
+
+	struct fsc_entry *fe;
+	if (!fs_cache)
+		return lstat(name, st);
+
+	fe = fs_cache_file_exists(fs_cache, name, len);
+	if (!fe) {
+		/* This is necessary because children of symlinks are not
+		 * included in the fs_cache. */
+		return lstat(name, st);
+	}
+
+	if (fe_deleted(fe)) {
+		errno = ENOENT;
+		return -1;
+	} else {
+		fe_to_stat(fe, st);
+	}
+	return 0;
+}
+
 /*
  * "refresh" does not calculate a new sha1 file or bring the
  * cache up-to-date for mode/content changes. But what it
@@ -1045,7 +1074,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 		return ce;
 	}
 
-	if (lstat(ce->name, &st) < 0) {
+	if (fs_cache_lstat(the_index.fs_cache, ce->name, ce_namelen(ce), &st) < 0) {
 		if (ignore_missing && errno == ENOENT)
 			return ce;
 		if (err)
@@ -1446,6 +1475,25 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	return ce;
 }
 
+static void do_load_fs_cache(struct index_state *istate, int force)
+{
+#ifdef USE_WATCHMAN
+	if (core_use_watchman && (istate->initialized || force)) {
+		if (istate->fs_cache) {
+			if (istate->fs_cache->invalid)
+				watchman_reload_fs_cache(istate);
+		} else {
+			if (watchman_load_fs_cache(istate)) {
+				if (istate->fs_cache) {
+					istate->fs_cache->needs_write = 0;
+					istate->fs_cache = NULL;
+				}
+			}
+		}
+	}
+#endif
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
@@ -1457,6 +1505,8 @@ int read_index_from(struct index_state *istate, const char *path)
 	size_t mmap_size;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 
+	do_load_fs_cache(istate, 0);
+
 	if (istate->initialized)
 		return istate->cache_nr;
 
@@ -1464,8 +1514,10 @@ int read_index_from(struct index_state *istate, const char *path)
 	istate->timestamp.nsec = 0;
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		if (errno == ENOENT)
+		if (errno == ENOENT) {
+			do_load_fs_cache(istate, 1);
 			return 0;
+		}
 		die_errno("index file open failed");
 	}
 
@@ -1530,6 +1582,9 @@ int read_index_from(struct index_state *istate, const char *path)
 		src_offset += 8;
 		src_offset += extsize;
 	}
+
+	do_load_fs_cache(istate, 0);
+
 	munmap(mmap, mmap_size);
 	return istate->cache_nr;
 
@@ -1560,6 +1615,8 @@ int discard_index(struct index_state *istate)
 	free(istate->cache);
 	istate->cache = NULL;
 	istate->cache_alloc = 0;
+	if (istate->fs_cache)
+		istate->fs_cache->invalid = 1;
 	return 0;
 }
 
diff --git a/t/t1012-read-tree-df.sh b/t/t1012-read-tree-df.sh
index a6a04b6..a677053 100755
--- a/t/t1012-read-tree-df.sh
+++ b/t/t1012-read-tree-df.sh
@@ -23,7 +23,7 @@ maketree () {
 }
 
 settree () {
-	rm -f .git/index .git/index.lock &&
+	rm -f .git/index .git/index.lock .git/fs_cache &&
 	git clean -d -f -f -q -x &&
 	git read-tree "$1" &&
 	git checkout-index -f -q -u -a &&
diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
index 954fc51..ad49535 100755
--- a/t/t2201-add-update-typechange.sh
+++ b/t/t2201-add-update-typechange.sh
@@ -124,7 +124,9 @@ test_expect_success diff-index '
 
 test_expect_success 'add -u' '
 	rm -f ".git/saved-index" &&
+	rm -f ".git/saved-fs_cache" &&
 	cp -p ".git/index" ".git/saved-index" &&
+	(test ! -f .git/fs_cache || cp -p ".git/fs_cache" ".git/saved-fs_cache") &&
 	git add -u &&
 	git ls-files -s >actual &&
 	test_cmp expect-final actual
@@ -134,7 +136,8 @@ test_expect_success 'commit -a' '
 	if test -f ".git/saved-index"
 	then
 		rm -f ".git/index" &&
-		mv ".git/saved-index" ".git/index"
+		mv ".git/saved-index" ".git/index" &&
+		(test ! -f .git/saved-fs_cache || mv ".git/saved-fs_cache" ".git/fs_cache")
 	fi &&
 	git commit -m "second" -a &&
 	git ls-files -s >actual &&
diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
index 8340ac2..6653aa8 100755
--- a/t/t2204-add-ignored.sh
+++ b/t/t2204-add-ignored.sh
@@ -18,7 +18,7 @@ test_expect_success setup '
 for i in file dir/file dir 'd*'
 do
 	test_expect_success "no complaints for unignored $i" '
-		rm -f .git/index &&
+		rm -f .git/index .git/fs_cache &&
 		git add "$i" &&
 		git ls-files "$i" >out &&
 		test -s out
@@ -28,7 +28,7 @@ done
 for i in ign dir/ign dir/sub dir/sub/*ign sub/file sub sub/*
 do
 	test_expect_success "complaints for ignored $i" '
-		rm -f .git/index &&
+		rm -f .git/index .git/fs_cache &&
 		test_must_fail git add "$i" 2>err &&
 		git ls-files "$i" >out &&
 		! test -s out
@@ -39,7 +39,7 @@ do
 	'
 
 	test_expect_success "complaints for ignored $i with unignored file" '
-		rm -f .git/index &&
+		rm -f .git/index .git/fs_cache &&
 		test_must_fail git add "$i" file 2>err &&
 		git ls-files "$i" >out &&
 		! test -s out
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 8efcd13..56f8ac0 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -20,7 +20,7 @@ test_expect_success setup '
 	git commit -a -m "Third in one history." &&
 	A2=`git rev-parse --verify HEAD` &&
 
-	rm -f .git/refs/heads/master .git/index &&
+	rm -f .git/refs/heads/master .git/index .git/fs_cache &&
 
 	echo >fileA fileA again &&
 	echo >subdir/fileB fileB again &&
diff --git a/t/t7900-watchman.sh b/t/t7900-watchman.sh
new file mode 100755
index 0000000..bea6180
--- /dev/null
+++ b/t/t7900-watchman.sh
@@ -0,0 +1,249 @@
+#!/bin/sh
+#
+# Copyright (c) 2014 Twitter, Inc
+#
+
+test_description='Watchman'
+
+. ./test-lib.sh
+
+if ! test_have_prereq WATCHMAN
+then
+	skip_all='skipping watchman tests - no watchman'
+	test_done
+fi
+
+xpgrep () {
+	result=$(ps xopid,comm | grep " $1\$" | awk '{ print $1 }')
+	echo $result
+	test "x$result" != "x"
+}
+
+kill_watchman() {
+	#stop watchman
+	xpgrep watchman | xargs kill
+}
+
+#make sure that watchman is not running, but that it is runnable
+test_expect_success setup '
+	git config core.usewatchman true &&
+	#watchman is maybe running
+	xpgrep watchman > running-watchman
+	grep . running-watchman > /dev/null && kill $(cat running-watchman)
+	rm running-watchman &&
+	sleep 0.25 &&
+	#watchman is stopped
+	! xpgrep watchman > /dev/null &&
+	#watchman is startable
+	watchman &&
+	kill_watchman
+'
+
+cat >expect <<\EOF
+?? expect
+?? morx
+?? output
+EOF
+
+test_expect_success 'watchman sees new files' '
+	touch morx &&
+	git status -s > output &&
+	test_cmp expect output
+'
+
+cat >expect <<\EOF
+?? expect
+?? output
+EOF
+
+test_expect_success 'watchman sees file deletion' '
+	rm morx &&
+	git status -s > output &&
+	test_cmp expect output
+'
+
+cat >expect <<\EOF
+?? .gitignore
+?? bramp
+EOF
+
+test_expect_success 'watchman understands .gitignore' '
+	touch bramp &&
+	cat >.gitignore <<-EOF &&
+	expect*
+	output*
+EOF
+	git status -s > output &&
+	test_cmp expect output
+'
+
+cat >expect <<\EOF
+?? .gitignore
+EOF
+
+test_expect_success 'watchman notices changes to .gitignore' '
+	cat >.gitignore <<-EOF &&
+	expect*
+	output*
+	bramp
+EOF
+	git status -s > output &&
+	test_cmp expect output
+'
+
+cat >expect <<\EOF
+?? .gitignore
+EOF
+
+test_expect_success 'watchman understands .git/info/exclude' '
+	touch fleem &&
+	cat >.git/info/exclude <<-EOF &&
+	fleem
+EOF
+	git status -s > output &&
+	test_cmp expect output
+'
+
+cat >expect <<\EOF
+?? .gitignore
+?? fleem
+EOF
+
+test_expect_success 'watchman notices changes to .git/info/exclude' '
+	touch crubbins &&
+	cat >.git/info/exclude <<-EOF &&
+	crubbins
+EOF
+	git status -s > output &&
+	test_cmp expect output
+'
+
+cat >expect <<\EOF
+?? .gitignore
+?? crubbins
+?? fleem
+EOF
+
+test_expect_success 'watchman notices removal of .git/info/exclude' '
+	rm .git/info/exclude &&
+	git status -s > output &&
+	test_cmp expect output &&
+	rm crubbins bramp fleem
+'
+
+
+cat >expect <<\EOF
+?? .gitignore
+?? fleem
+?? myignore
+EOF
+
+test_expect_success 'watchman notices changes to file configured by core.excludesfile' '
+	touch fleem &&
+	touch crubbins &&
+	cat >myignore <<-EOF &&
+	crubbins
+EOF
+	git config core.excludesfile myignore &&
+	git status -s > output &&
+	test_cmp expect output
+'
+
+cat >expect <<\EOF
+?? .gitignore
+?? crubbins
+?? myignore
+?? myignore2
+EOF
+
+test_expect_success 'watchman notices changes to config variable core.excludesfile' '
+	touch fleem &&
+	touch crubbins &&
+	cat >myignore2 <<-EOF &&
+	fleem
+EOF
+	git config core.excludesfile myignore2 &&
+	git status -s > output &&
+	test_cmp expect output
+'
+
+cat >expect <<\EOF
+?? .gitignore
+?? crubbins
+?? fleem
+?? myignore
+EOF
+
+test_expect_success 'watchman notices removal of file referred to by' '
+	rm myignore2 &&
+	git status -s > output &&
+	test_cmp expect output &&
+	rm crubbins fleem myignore
+'
+
+
+cat >expect.nothing <<\EOF
+EOF
+
+cat >expect.2 <<\EOF
+EOF
+
+test_expect_success 'git diff still works' '
+	echo 1 > diffy &&
+	git add diffy .gitignore &&
+	git commit -m initial &&
+	git status -s > output &&
+	test_cmp expect.nothing output &&
+	echo 2 >> diffy &&
+	test_cmp expect.2 output
+'
+
+cat >expect <<\EOF
+ D diffy
+EOF
+
+test_expect_success 'file to directory changes still work' '
+	rm diffy &&
+	mkdir diffy &&
+	touch diffy/a &&
+	git status -s > output &&
+	test_cmp expect output &&
+	git add diffy/a &&
+	git commit -m two &&
+	git status -s > output.nothing
+'
+
+cat >expect <<\EOF
+ D diffy/a
+?? diffy
+EOF
+
+test_expect_success 'directory to file changes still work' '
+	rm -r diffy &&
+	touch diffy &&
+	git status -s > output &&
+	test_cmp expect output &&
+	rm diffy &&
+	git rm diffy/a &&
+	git commit -m "remove diffy"
+'
+
+cat >expect <<\EOF
+?? dead
+EOF
+
+test_expect_success 'changes while watchman is not running are detected' '
+	kill_watchman &&
+	sleep 0.25 &&
+	! xpgrep watchman > /dev/null &&
+	touch dead &&
+	git status -s > output &&
+	test_cmp expect output
+'
+
+test_expect_success 'Restore default test environment' '
+	git config --unset core.usewatchman &&
+	kill_watchman
+'
+
+test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c081668..19d1ec5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -781,6 +781,7 @@ test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -n "$USE_LIBPCRE" && test_set_prereq LIBPCRE
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
+test -n "$USE_WATCHMAN" && test_set_prereq WATCHMAN
 
 # Can we rely on git's output in the C locale?
 if test -n "$GETTEXT_POISON"
diff --git a/unpack-trees.c b/unpack-trees.c
index 97fc995..5161de3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1339,7 +1339,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	memset(&d, 0, sizeof(d));
 	if (o->dir)
 		d.exclude_per_dir = o->dir->exclude_per_dir;
-	i = read_directory(&d, pathbuf, namelen+1, NULL);
+	i = read_directory(o->src_index, &d, pathbuf, namelen+1, NULL);
 	if (i)
 		return o->gently ? -1 :
 			add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
diff --git a/watchman-support.c b/watchman-support.c
new file mode 100644
index 0000000..9c5a87d
--- /dev/null
+++ b/watchman-support.c
@@ -0,0 +1,640 @@
+#include <dirent.h>
+
+#include "git-compat-util.h"
+#include "cache.h"
+#include "dir.h"
+#include "fs_cache.h"
+#include "strbuf.h"
+#include "pathspec.h"
+#include "watchman-support.h"
+
+#define NS_PER_SEC 1000000000L
+
+#define SET_TIME_FROM_NS(time, ns)	      \
+	do {				      \
+		(time).sec = (ns) / NS_PER_SEC;      \
+		(time).nsec = (ns) % NS_PER_SEC;     \
+	} while(0)
+
+static inline unsigned int create_fe_mode(unsigned int mode)
+{
+	if (S_ISLNK(mode))
+		return S_IFLNK;
+	if (S_ISDIR(mode))
+		return S_IFDIR;
+	return S_IFREG | ce_permissions(mode);
+}
+
+static void copy_wm_stat_to_fe(struct watchman_stat *wm, struct fsc_entry *fe)
+{
+	if (!wm->exists) {
+		fe_set_deleted(fe);
+		return;
+	} else
+		fe_clear_deleted(fe);
+	fe->size = wm->size;
+	fe->mode = create_fe_mode(wm->mode);
+	fe->ino = wm->ino;
+	fe->dev = wm->dev;
+	fe->uid = wm->uid;
+	fe->gid = wm->gid;
+	SET_TIME_FROM_NS(fe->mtime, wm->mtime_ns);
+	SET_TIME_FROM_NS(fe->ctime, wm->ctime_ns);
+	return;
+}
+
+static struct fsc_entry *wm_stat_to_fe(struct watchman_stat *wm)
+{
+	struct fsc_entry *fe = make_fs_cache_entry(wm->name);
+	fe_set_new(fe);
+	copy_wm_stat_to_fe(wm, fe);
+	return fe;
+}
+
+static void update_exclude(struct dir_struct *dir, struct fsc_entry *fe)
+{
+	int dtype = fe_dtype(fe);
+	if (is_excluded(dir, fe->path, &dtype)) {
+		fe_set_excluded(fe);
+	} else {
+		fe_clear_excluded(fe);
+	}
+	for (fe = fe->first_child; fe; fe = fe->next_sibling) {
+		update_exclude(dir, fe);
+	}
+}
+
+static struct fsc_entry *fs_cache_file_deleted(struct fs_cache *fs_cache,
+					       struct watchman_stat *wm)
+{
+	int namelen = strlen(wm->name);
+	struct fsc_entry *fe;
+
+	fe = fs_cache_file_exists(fs_cache, wm->name, namelen);
+
+	if (fe) {
+		fe_set_deleted(fe);
+		fe_clear_children(fs_cache, fe);
+	}
+
+	return fe;
+}
+
+static struct fsc_entry *fs_cache_file_modified(struct fs_cache *fs_cache,
+						struct watchman_stat *wm)
+{
+	int namelen = strlen(wm->name);
+	struct fsc_entry *fe;
+	fe = fs_cache_file_exists(fs_cache, wm->name, namelen);
+	if (!fe) {
+		fe = wm_stat_to_fe(wm);
+		fs_cache_insert(fs_cache, fe);
+		set_up_parent(fs_cache, fe);
+	} else {
+		int was_dir = fe_is_dir(fe);
+		if (fe_deleted(fe))
+			fe_set_new(fe);
+		copy_wm_stat_to_fe(wm, fe);
+		if (was_dir && !fe_is_dir(fe)) {
+			fe_clear_children(fs_cache, fe);
+		}
+	}
+	return fe;
+}
+
+static struct watchman_expression *make_expression()
+{
+	struct watchman_expression *types[3];
+	types[0] = watchman_type_expression('f');
+	types[1] = watchman_type_expression('d');
+	types[2] = watchman_type_expression('l');
+	struct watchman_expression *expr = watchman_anyof_expression(3, types);
+
+	return expr;
+}
+
+struct watchman_query *make_query(const char *last_update)
+{
+	struct watchman_query *query = watchman_query();
+
+	watchman_query_set_fields(query,
+				  WATCHMAN_FIELD_NAME |
+				  WATCHMAN_FIELD_MTIME_NS |
+				  WATCHMAN_FIELD_CTIME_NS |
+				  WATCHMAN_FIELD_INO |
+				  WATCHMAN_FIELD_DEV |
+				  WATCHMAN_FIELD_UID |
+				  WATCHMAN_FIELD_GID |
+				  WATCHMAN_FIELD_EXISTS |
+				  WATCHMAN_FIELD_MODE |
+				  WATCHMAN_FIELD_SIZE);
+	watchman_query_set_empty_on_fresh(query, 1);
+
+	query->sync_timeout = core_watchman_sync_timeout;
+
+	if (last_update) {
+		watchman_query_set_since_oclock(query, last_update);
+	}
+	return query;
+}
+
+enum path_treatment {
+	path_recurse,
+	path_file
+};
+
+void fe_from_stat(struct fsc_entry *fe, struct stat *st)
+{
+	fe->mode = create_fe_mode(st->st_mode);
+	fe->size = st->st_size;
+	fe->ino = st->st_ino;
+	fe->dev = st->st_dev;
+	fe->ctime.sec = st->st_ctime;
+	fe->ctime.nsec = ST_CTIME_NSEC(*st);
+	fe->mtime.sec = st->st_mtime;
+	fe->mtime.nsec = ST_MTIME_NSEC(*st);
+	fe->uid = st->st_uid;
+	fe->gid = st->st_gid;
+}
+
+static void update_all_excludes(struct fs_cache *fs_cache)
+{
+	struct fsc_entry *root = fs_cache_file_exists(fs_cache, "", 0);
+	struct dir_struct dir;
+	char original_path[PATH_MAX + 1];
+	const char *fs_path = get_git_work_tree();
+
+	if (!getcwd(original_path, PATH_MAX + 1))
+			die_errno("failed to get working directory\n");
+	if (chdir(fs_path))
+			die_errno("failed to chdir to git work tree\n");
+
+	assert (root);
+
+	memset(&dir, 0, sizeof(dir));
+	setup_standard_excludes(&dir);
+	update_exclude(&dir, root);
+	clear_directory(&dir);
+
+	if (chdir(original_path))
+			die_errno("failed to chdir back to original path\n");
+}
+
+static enum path_treatment watchman_handle(struct index_state *istate, struct strbuf *path, struct dirent *de, int rootlen, struct fsc_entry **out)
+{
+	struct fs_cache *fs_cache = istate->fs_cache;
+	struct fsc_entry *fe;
+	struct stat st;
+	int dtype;
+
+	fe = make_fs_cache_entry(path->buf + rootlen);
+	*out = fe;
+	fs_cache_insert(fs_cache, fe);
+	set_up_parent(fs_cache, fe);
+	lstat(path->buf, &st);
+	fe_from_stat(fe, &st);
+
+	dtype = DTYPE(de);
+	if (dtype == DT_UNKNOWN) {
+		/* this involves an extra stat call, but only on
+		 * Cygwin, which watchman doesn't support anyway. */
+		dtype = get_dtype(de, path->buf, path->len);
+	}
+	if (dtype == DT_DIR) {
+		return path_recurse;
+	}
+
+	return path_file;
+}
+
+static void path_set_last_component(struct strbuf *path, int baselen, const char *add)
+{
+	strbuf_setlen(path, baselen);
+	if (baselen) {
+		strbuf_addch(path, '/');
+	}
+	strbuf_addstr(path, add);
+}
+
+static int preload_wt_recursive(struct index_state *istate, struct strbuf *path, int rootlen)
+{
+	DIR *fdir;
+	struct dirent *de;
+	int baselen = path->len;
+
+	fdir = opendir(path->buf);
+	if (!fdir) {
+		return error("Failed to open %s", path->buf);
+	}
+
+	while ((de = readdir(fdir)) != NULL) {
+		struct fsc_entry *fe;
+		if (is_dot_or_dotdot(de->d_name) || is_in_dot_git(de->d_name))
+			continue;
+
+		path_set_last_component(path, baselen, de->d_name);
+
+		/* recurse into subdir if necessary */
+		if (watchman_handle(istate, path, de, rootlen, &fe) == path_recurse) {
+			int result = preload_wt_recursive(istate, path, rootlen);
+			if (result) {
+				closedir(fdir);
+				return result;
+			}
+		}
+	}
+
+	closedir(fdir);
+	return 0;
+}
+
+static void init_excludes_config()
+{
+	char *xdg_path;
+	if (!excludes_file) {
+		home_config_paths(NULL, &xdg_path, "ignore");
+		excludes_file = xdg_path;
+	}
+}
+
+static void compute_sha1(const char *path, unsigned char *sha1)
+{
+	struct stat st;
+	if (stat(path, &st)) {
+		memset(sha1, 0, 20);
+	} else {
+		if (index_path(sha1, path, &st, 0)) {
+			memset(sha1, 0, 20);
+		}
+	}
+}
+
+static void init_excludes_files(struct fs_cache *fs_cache)
+{
+	init_excludes_config();
+	if (fs_cache->excludes_file) {
+		free(fs_cache->excludes_file);
+	}
+	if (excludes_file) {
+		fs_cache->excludes_file = xstrdup(excludes_file);
+		compute_sha1(excludes_file, fs_cache->user_excludes_sha1);
+	} else {
+		fs_cache->excludes_file = xstrdup("");
+		memset(fs_cache->user_excludes_sha1, 0, 20);
+	}
+	compute_sha1(git_path("info/excludes"), fs_cache->git_excludes_sha1);
+}
+
+static int git_excludes_file_changed(struct fs_cache *fs_cache)
+{
+	unsigned char sha1[20];
+
+	compute_sha1(git_path("info/exclude"), sha1);
+	if (!hashcmp(fs_cache->git_excludes_sha1, sha1))
+		return 0;
+	hashcpy(fs_cache->git_excludes_sha1, sha1);
+	return 1;
+}
+
+static int user_excludes_file_changed(struct fs_cache *fs_cache)
+{
+	unsigned char sha1[20] = {0};
+	struct stat st;
+
+	init_excludes_config();
+
+	if (!excludes_file) {
+		if (strlen(fs_cache->excludes_file) == 0) {
+			return 0;
+		}
+
+		fs_cache->excludes_file[0] = 0;
+		if (is_null_sha1(fs_cache->user_excludes_sha1))
+			return 0;
+
+		memset(fs_cache->user_excludes_sha1, 0, 20);
+		return 1;
+	}
+
+	/* A change in exclude filename forces an exclude reload */
+	if (strcmp(fs_cache->excludes_file, excludes_file)) {
+		init_excludes_files(fs_cache);
+		return 1;
+	}
+
+	if (!strlen(fs_cache->excludes_file)) {
+		return 0;
+	}
+
+	if (stat(excludes_file, &st)) {
+		/* There is a problem reading the excludes file; this
+		 * could be a persistent condition, so we need to
+		 * check if the file is presently marked as invalid */
+		if (is_null_sha1(fs_cache->user_excludes_sha1))
+			return 0;
+		else {
+			memset(fs_cache->user_excludes_sha1, 0, 20);
+			return 1;
+		}
+	}
+
+	if (index_path(sha1, excludes_file, &st, 0)) {
+		if (is_null_sha1(fs_cache->user_excludes_sha1)) {
+			return 0;
+		} else {
+			memset(fs_cache->user_excludes_sha1, 0, 20);
+			return 1;
+		}
+	} else {
+		if (!hashcmp(fs_cache->user_excludes_sha1, sha1))
+			return 0;
+		hashcpy(fs_cache->user_excludes_sha1, sha1);
+		return 1;
+	}
+}
+
+static void create_fs_cache(struct index_state *istate)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *fs_path = get_git_work_tree();
+	struct fsc_entry *root;
+
+	strbuf_addstr(&buf, fs_path);
+	istate->fs_cache = empty_fs_cache();
+	root = make_fs_cache_entry("");
+	root->mode = 040644;
+	fs_cache_insert(istate->fs_cache, root);
+	preload_wt_recursive(istate, &buf, buf.len + 1);
+	strbuf_release(&buf);
+
+	init_excludes_files(istate->fs_cache);
+	update_all_excludes(istate->fs_cache);
+}
+
+static void load_fs_cache(struct index_state *istate)
+{
+	if (istate->fs_cache)
+		return;
+	istate->fs_cache = read_fs_cache();
+	if (!istate->fs_cache) {
+		create_fs_cache(istate);
+	}
+}
+
+static struct watchman_query_result *watchman_fs_cache_query(struct watchman_connection *connection, const char *fs_path, const char *last_update)
+{
+	struct watchman_error wm_error;
+	struct watchman_expression *expr;
+	struct watchman_query *query;
+	struct watchman_query_result *result = NULL;
+	struct stat st;
+	int fs_path_len = strlen(fs_path);
+	char *git_path;
+
+	expr = make_expression();
+	query = make_query(last_update);
+	if (lstat(fs_path, &st)) {
+		return NULL;
+	}
+
+	git_path = xmalloc(fs_path_len + 6);
+	strcpy(git_path, fs_path);
+	strcpy(git_path + fs_path_len, "/.git");
+
+	if (lstat(git_path, &st)) {
+		/* Watchman gets confused if we delete the .git
+		 * directory out from under it, since that's where it
+		 * stores its cookies.  So we'll need to delete the
+		 * watch and then recreate it. It's OK for this to
+		 * fail, as the watch might have already been
+		 * deleted. */
+		watchman_watch_del(connection, fs_path, &wm_error);
+
+		if (watchman_watch(connection, fs_path, &wm_error)) {
+			warning("Watchman watch error: %s", wm_error.message);
+			goto out;
+		}
+	}
+	result = watchman_do_query(connection, fs_path, query, expr, &wm_error);
+	if (!result) {
+		warning("Watchman query error: %s (at %s)", wm_error.message, last_update);
+		goto out;
+	}
+	watchman_free_expression(expr);
+	watchman_free_query(query);
+
+out:
+	free(git_path);
+	return result;
+}
+
+static int cmp_stat(const void *a, const void *b)
+{
+	const struct watchman_stat* sa = a;
+	const struct watchman_stat* sb = b;
+	return strcmp(sa->name, sb->name);
+}
+
+static void append(struct fsc_entry ***list, int* cap, int* len, struct fsc_entry *entry)
+{
+	if (*len >= *cap) {
+		int sz;
+		*cap = *cap ? *cap * 2 : 10;
+		sz = *cap * sizeof(**list);
+		*list = xrealloc(*list, sz);
+	}
+	(*list)[(*len)++] = entry;
+}
+
+static int is_child_of(struct fsc_entry *putative_child, struct fsc_entry *parent)
+{
+	while (putative_child) {
+		putative_child = putative_child->parent;
+		if (putative_child == parent) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static void update_fs_cache(struct index_state *istate, struct watchman_query_result *result)
+{
+	struct fs_cache *fs_cache = istate->fs_cache;
+	struct fsc_entry *fe;
+	int i;
+	struct fsc_entry **exclude_dirty = NULL;
+	int cap = 0, len = 0, all_dirty = 0;
+	/* note that we always want to call both of these functions,
+	 * since they update the fs_cache's view of files which are
+	 * not watched by watchman */
+	int user_changed = user_excludes_file_changed(fs_cache);
+	int git_changed = git_excludes_file_changed(fs_cache);
+
+	all_dirty = user_changed || git_changed;
+
+	qsort(result->stats, result->nr, sizeof(*result->stats), cmp_stat);
+
+	for (i = 0; i < result->nr; ++i) {
+		/*for each result in the changed set, we need to check
+		  it against the index and HEAD */
+
+		struct watchman_stat *wm = result->stats + i;
+
+		if (is_in_dot_git(wm->name)) {
+			continue;
+		}
+		fs_cache->needs_write = 1;
+		if (wm->exists) {
+			fe = fs_cache_file_modified(fs_cache, wm);
+		} else {
+			fe = fs_cache_file_deleted(fs_cache, wm);
+		}
+		if (fe && !all_dirty) {
+			if (ends_with(wm->name, "/.gitignore") ||
+			    !strcmp(wm->name, ".gitignore")) {
+				append(&exclude_dirty, &cap, &len, fe->parent);
+			} else if (fe_new(fe)) {
+				append(&exclude_dirty, &cap, &len, fe);
+			}
+		}
+	}
+
+	if (exclude_dirty) {
+		struct dir_struct dir;
+		struct fsc_entry *last = NULL;
+		char original_path[PATH_MAX + 1];
+		qsort(exclude_dirty, len, sizeof(*exclude_dirty), cmp_fsc_entry);
+
+		if (!getcwd(original_path, PATH_MAX + 1))
+			die_errno("failed to get working directory\n");
+		if (chdir(get_git_work_tree()))
+			die_errno("failed to chdir to git work tree\n");
+
+		memset(&dir, 0, sizeof(dir));
+		setup_standard_excludes(&dir);
+
+		for (i = 0; i < len; i++) {
+			struct fsc_entry *fe = exclude_dirty[i];
+
+			if (i == 0 || !is_child_of(fe, last)) {
+				update_exclude(&dir, fe);
+				last = fe;
+			}
+		}
+		clear_directory(&dir);
+		free(exclude_dirty);
+		if (chdir(original_path))
+			die_errno("failed to chdir back to original path\n");
+	} else if (all_dirty) {
+		update_all_excludes(fs_cache);
+	}
+
+}
+
+int watchman_reload_fs_cache(struct index_state *istate)
+{
+	struct watchman_error wm_error;
+	struct watchman_query_result *result;
+	struct watchman_connection *connection;
+	int ret = -1;
+	const char *fs_path;
+	const char *last_update = istate->fs_cache->last_update;
+
+	fs_path = get_git_work_tree();
+	if (!fs_path)
+		return -1;
+
+	connection = watchman_connect(&wm_error);
+
+	if (!connection) {
+		warning("Watchman watch error: %s", wm_error.message);
+		return -1;
+	}
+
+	result = watchman_fs_cache_query(connection, fs_path, last_update);
+	if (!result) {
+		goto done;
+	}
+	istate->fs_cache->last_update = xstrdup(result->clock);
+
+	update_fs_cache(istate, result);
+	watchman_free_query_result(result);
+	ret = 0;
+done:
+	watchman_connection_close(connection);
+	return ret;
+}
+
+int watchman_load_fs_cache(struct index_state *istate)
+{
+	struct watchman_error wm_error;
+	int ret = -1;
+	const char *fs_path;
+	char *last_update = NULL;
+	char *stored_repo_path = NULL;
+	struct watchman_query_result *result;
+	struct watchman_connection *connection;
+
+	fs_path = get_git_work_tree();
+	if (!fs_path)
+		return -1;
+
+	connection = watchman_connect(&wm_error);
+
+	if (!connection) {
+		warning("Watchman watch error: %s", wm_error.message);
+		return -1;
+	}
+
+	if (watchman_watch(connection, fs_path, &wm_error)) {
+		warning("Watchman watch error: %s", wm_error.message);
+		goto done;
+	}
+
+	fs_cache_preload_metadata(&last_update, &stored_repo_path);
+	if (!last_update || strcmp(stored_repo_path, fs_path)) {
+		if (istate->fs_cache) {
+			free_fs_cache(istate->fs_cache);
+			istate->fs_cache = NULL;
+		}
+		/* fs_cache is corrupt, or refers to another repo path;
+		 * let's try recreating it. */
+		if (last_update)
+			free(last_update);
+		last_update = NULL;
+		/* now we continue, because we need to get the
+		 * a last-update time from watchman. */
+	}
+	free(stored_repo_path);
+
+	result = watchman_fs_cache_query(connection, fs_path, last_update);
+	if (last_update) {
+		free(last_update);
+		last_update = NULL;
+	}
+	if (!result) {
+		goto done;
+	}
+
+	if (result->is_fresh_instance) {
+		if (istate->fs_cache) {
+			free_fs_cache(istate->fs_cache);
+			istate->fs_cache = NULL;
+		}
+		create_fs_cache(istate);
+		istate->fs_cache->repo_path = xstrdup(fs_path);
+	} else {
+		load_fs_cache(istate);
+		update_fs_cache(istate, result);
+	}
+
+	istate->fs_cache->last_update = xstrdup(result->clock);
+
+	watchman_free_query_result(result);
+	ret = 0;
+
+done:
+	watchman_connection_close(connection);
+	return ret;
+
+}
diff --git a/watchman-support.h b/watchman-support.h
new file mode 100644
index 0000000..1ab865f
--- /dev/null
+++ b/watchman-support.h
@@ -0,0 +1,10 @@
+#ifndef WATCHMAN_SUPPORT_H
+#define WATCHMAN_SUPPORT_H
+
+#include "cache.h"
+#include <watchman.h>
+
+int watchman_load_fs_cache(struct index_state *index);
+int watchman_reload_fs_cache(struct index_state *index);
+
+#endif /* WATCHMAN_SUPPORT_H */
-- 
2.0.0.rc0.31.g69c1a2d
