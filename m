From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/20] untracked cache: record/validate dir mtime and reuse cached output
Date: Wed,  7 May 2014 21:51:48 +0700
Message-ID: <1399474320-6840-9-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:52:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3DI-0005rL-7i
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbaEGOws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:52:48 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38315 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224AbaEGOwr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:52:47 -0400
Received: by mail-pa0-f46.google.com with SMTP id kx10so1305299pab.33
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0dBhuSpR2sJfxJ0mkHakpDdJmnKw+Qq07OGpzQanaHs=;
        b=E7i+RoS/rDmUk8oH8fEi+lJTVFUiq/NkdF3TIO3IKQfhNWmZmjNB3pERyu3sKTcGxn
         CZIfuFLbeq6MNxCQ1rRRNf2JkDkP0CNX2Io9oN33NaSMnHZUZmSe3BfKTAuyKl7cQPFu
         tcFdL40hdjqsq5uQPZBJuH2nLqY/A4rEifWiURz0qfQez9wjdjiRI+5fiIAgNqwL6tp/
         WzNQGGWiBuP7g9DploGshJf9obpmCVnjDvGTSkp022ZVSea1KTvNm6WlYJQvHsB2xiOg
         2ZMPlstdr28IXwP234jjYOS1JCPhSZs4bhCuog2DJYa3CJQWVky9f5ysQohg+PfeN9TR
         4SyA==
X-Received: by 10.66.102.74 with SMTP id fm10mr10210942pab.86.1399474366145;
        Wed, 07 May 2014 07:52:46 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id qp12sm8504705pab.47.2014.05.07.07.52.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:52:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:52:45 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248314>

The main readdir loop in read_directory_recursive() is replaced with a
new one that checks if cached results of a directory is still valid.

If a file is added or removed from the index, the containing directory
is invalidated (but not its subdirs). If directory's mtime is changed,
the same happens. If a .gitignore is updated, the containing directory
and all subdirs are invalidated recursively. If dir_struct#flags or
other conditions change, the cache is ignored.

If a directory is invalidated, we opendir/readdir/closedir and run the
exclude machinery on that directory listing as usual. If untracked
cache is also enabled, we'll update the cache along the way. If a
directory is validated, we simply pull the untracked listing out from
the cache. The cache also records the list of direct subdirs that we
have to recurse in. Fully excluded directories are seen as "untracked
files".

In the best case when no dirs are invalidated, read_directory()
becomes a series of stat(dir), open(.gitignore), fstat, read, close
and optionally hash_sha1_file. For comparison, standard
read_directory() is a sequence of opendir, readdir, open(gitignore),
fstat, read, close, (expensive) last_exclude_matching and closedir.

We already try not to open(gitignore) if we know it does not exist, so
open/fstat/read/close sequence does not apply to every directory. The
sequence could be reduced further, as noted in prep_exclude(). So in
theory, the entire best-case read_directory sequence could be reduced
to a series of stat() and nothing else.

This is not a silver bullet approach. When you compile a C file, for
example, the old .o file is removed and a new one with the same name
created, effectively invalidating the containing directory's cache
(but not its subdirectories). If your build process touches every
directory, this cache adds extra overhead for nothing, so it's a good
idea to separate generated files from tracked files.. Editors may use
the same strategy for saving files. And of course you're out of luck
running your repo on an unsupported filesytem and/or operating system.
---
 dir.c | 180 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 dir.h |   2 +
 2 files changed, 172 insertions(+), 10 deletions(-)

diff --git a/dir.c b/dir.c
index 6370f6e..205f323 100644
--- a/dir.c
+++ b/dir.c
@@ -31,6 +31,24 @@ enum path_treatment {
 	path_untracked
 };
 
+/*
+ * Support data structure for our opendir/readdir/closedir wrappers
+ */
+struct cached_dir {
+	DIR *fdir;
+	struct untracked_cache_dir *untracked;
+	int nr_files;
+	int nr_dirs;
+
+	/*
+	 * return data from read_cached_dir(). name and state are only
+	 * valid if de is NULL
+	 */
+	struct dirent *de;
+	const char *file;
+	struct untracked_cache_dir *ucd;
+};
+
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	const char *path, int len, struct untracked_cache_dir *untracked,
 	int check_only, const struct path_simplify *simplify);
@@ -584,6 +602,14 @@ static void invalidate_gitignore(struct untracked_cache *uc,
 	do_invalidate_gitignore(dir);
 }
 
+static void invalidate_directory(struct untracked_cache *uc,
+				 struct untracked_cache_dir *dir)
+{
+	uc->dir_invalidated++;
+	dir->valid = 0;
+	dir->untracked_nr = 0;
+}
+
 static int add_excludes(const char *fname,
 			const char *base,
 			int baselen,
@@ -1415,15 +1441,54 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	}
 }
 
+static enum path_treatment treat_path_fast(struct dir_struct *dir,
+					   struct untracked_cache_dir *untracked,
+					   struct cached_dir *cdir,
+					   struct strbuf *path,
+					   int baselen,
+					   const struct path_simplify *simplify)
+{
+	if (!cdir->ucd) {
+		strbuf_setlen(path, baselen);
+		strbuf_addstr(path, cdir->file);
+		return path_untracked;
+	}
+	strbuf_setlen(path, baselen);
+	strbuf_addstr(path, cdir->ucd->name);
+	/* treat_one_path() does this before it calls treat_directory() */
+	if (path->buf[path->len - 1] != '/')
+		strbuf_addch(path, '/');
+	if (cdir->ucd->check_only)
+		/*
+		 * check_only is set as a result of treat_directory() getting
+		 * to its bottom. Verify again the same set of directories
+		 * with check_only set.
+		 */
+		return read_directory_recursive(dir, path->buf, path->len,
+
+						cdir->ucd, 1, simplify);
+	/*
+	 * We get path_recurse in the first run when
+	 * directory_exists_in_index() returns index_nonexistent. We
+	 * are sure that new changes in the index does not impact the
+	 * outcome. Return now.
+	 */
+	return path_recurse;
+}
+
 static enum path_treatment treat_path(struct dir_struct *dir,
 				      struct untracked_cache_dir *untracked,
-				      struct dirent *de,
+				      struct cached_dir *cdir,
 				      struct strbuf *path,
 				      int baselen,
 				      const struct path_simplify *simplify)
 {
 	int dtype;
+	struct dirent *de = cdir->de;
 
+	if (!de)
+		return treat_path_fast(dir, untracked, cdir, path,
+				       baselen, simplify);
 	if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
 		return path_none;
 	strbuf_setlen(path, baselen);
@@ -1444,6 +1509,103 @@ static void add_untracked(struct untracked_cache_dir *dir, const char *name)
 	dir->untracked[dir->untracked_nr++] = xstrdup(name);
 }
 
+static int valid_cached_dir(struct dir_struct *dir,
+			    struct untracked_cache_dir *untracked,
+			    struct strbuf *path,
+			    int check_only)
+{
+	struct stat st;
+
+	if (stat(path->len ? path->buf : ".", &st)) {
+		invalidate_directory(dir->untracked, untracked);
+		memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
+		return 0;
+	}
+	if (!untracked->valid ||
+	    match_stat_data(&untracked->stat_data, &st)) {
+		if (untracked->valid)
+			invalidate_directory(dir->untracked, untracked);
+		fill_stat_data(&untracked->stat_data, &st);
+		return 0;
+	}
+
+	if (untracked->check_only != !!check_only) {
+		invalidate_directory(dir->untracked, untracked);
+		return 0;
+	}
+
+	/*
+	 * prep_exclude will be called eventually on this directory,
+	 * but it's called much later in last_exclude_matching(). We
+	 * need it now to determine the validity of the cache for this
+	 * path. The next calls will be nearly no-op, the way
+	 * prep_exclude() is designed.
+	 */
+	if (path->len && path->buf[path->len - 1] != '/') {
+		strbuf_addch(path, '/');
+		prep_exclude(dir, path->buf, path->len);
+		strbuf_setlen(path, path->len - 1);
+	} else
+		prep_exclude(dir, path->buf, path->len);
+
+	/* hopefully prep_exclude() haven't invalidated this entry... */
+	return untracked->valid;
+}
+
+static int open_cached_dir(struct cached_dir *cdir,
+			   struct dir_struct *dir,
+			   struct untracked_cache_dir *untracked,
+			   struct strbuf *path,
+			   int check_only)
+{
+	memset(cdir, 0, sizeof(*cdir));
+	cdir->untracked = untracked;
+	if (!untracked ||
+	    !valid_cached_dir(dir, untracked, path, check_only)) {
+		cdir->fdir = opendir(path->len ? path->buf : ".");
+		if (dir->untracked)
+			dir->untracked->dir_opened++;
+		if (!cdir->fdir)
+			return -1;
+	}
+	return 0;
+}
+
+int read_cached_dir(struct cached_dir *cdir)
+{
+	if (cdir->fdir) {
+		cdir->de = readdir(cdir->fdir);
+		if (!cdir->de)
+			return -1;
+		return 0;
+	}
+	while (cdir->nr_dirs < cdir->untracked->dirs_nr) {
+		struct untracked_cache_dir *d = cdir->untracked->dirs[cdir->nr_dirs];
+		cdir->ucd = d;
+		cdir->nr_dirs++;
+		return 0;
+	}
+	cdir->ucd = NULL;
+	if (cdir->nr_files < cdir->untracked->untracked_nr) {
+		struct untracked_cache_dir *d = cdir->untracked;
+		cdir->file = d->untracked[cdir->nr_files++];
+		return 0;
+	}
+	return -1;
+}
+
+static void close_cached_dir(struct cached_dir *cdir)
+{
+	if (cdir->fdir)
+		closedir(cdir->fdir);
+	/*
+	 * We have gone through this directory and found no untracked
+	 * entries. Set untracked_nr to zero to make it valid.
+	 */
+	if (cdir->untracked && !cdir->untracked->valid)
+		cdir->untracked->valid = 1;
+}
+
 /*
  * Read a directory tree. We currently ignore anything but
  * directories, regular files and symlinks. That's because git
@@ -1460,23 +1622,21 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 				    struct untracked_cache_dir *untracked, int check_only,
 				    const struct path_simplify *simplify)
 {
-	DIR *fdir;
+	struct cached_dir cdir;
 	enum path_treatment state, subdir_state, dir_state = path_none;
-	struct dirent *de;
 	struct strbuf path = STRBUF_INIT;
 
 	strbuf_add(&path, base, baselen);
 
-	fdir = opendir(path.len ? path.buf : ".");
-	if (!fdir)
+	if (open_cached_dir(&cdir, dir, untracked, &path, check_only))
 		goto out;
 
 	if (untracked)
 		untracked->check_only = !!check_only;
 
-	while ((de = readdir(fdir)) != NULL) {
+	while (!read_cached_dir(&cdir)) {
 		/* check how the file or directory should be treated */
-		state = treat_path(dir, untracked, de, &path, baselen, simplify);
+		state = treat_path(dir, untracked, &cdir, &path, baselen, simplify);
 
 		if (state > dir_state)
 			dir_state = state;
@@ -1497,7 +1657,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		if (check_only) {
 			/* abort early if maximum state has been reached */
 			if (dir_state == path_untracked) {
-				if (untracked)
+				if (cdir.fdir)
 					add_untracked(untracked, path.buf + baselen);
 				break;
 			}
@@ -1521,7 +1681,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			if (dir->flags & DIR_SHOW_IGNORED)
 				break;
 			dir_add_name(dir, path.buf, path.len);
-			if (untracked)
+			if (cdir.fdir)
 				add_untracked(untracked, path.buf + baselen);
 			break;
 
@@ -1529,7 +1689,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			break;
 		}
 	}
-	closedir(fdir);
+	close_cached_dir(&cdir);
  out:
 	strbuf_release(&path);
 
diff --git a/dir.h b/dir.h
index ded251e..8955945 100644
--- a/dir.h
+++ b/dir.h
@@ -130,6 +130,8 @@ struct untracked_cache {
 	/* Statistics */
 	int dir_created;
 	int gitignore_invalidated;
+	int dir_invalidated;
+	int dir_opened;
 };
 
 struct dir_struct {
-- 
1.9.1.346.ga2b5940
