From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 00/23] nd/untracked-cache updates
Date: Mon,  8 Dec 2014 21:04:43 +0700
Message-ID: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:54:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxym2-00043M-I0
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444AbaLHNyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 08:54:45 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:52545 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755435AbaLHNyn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:54:43 -0500
Received: by mail-pd0-f175.google.com with SMTP id y10so5201054pdj.34
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=MABSJilz60ligZHLBRDPYNSbFXchLiFUV9oUHXwX0k8=;
        b=zMT1F3NK8DJ2aQLG/DHzOgKH8R4vowhd6jUQBiYz7/X4FASpkqE5O19cqzckEgPlkv
         2x7o1lhs8gLUB4VrDLOZE9UzVKVwylGEnMhcbBA3/G0UUEN0Ccxp0Q/gABk9TOOW0xwp
         AnxeJhctXz/D/jJz6w+eAFQV7yWhWlwZHdQBEZju7BOYjv7zBvAxWVjV36yBO4iRwP/Q
         KAcxI4Ky+IrXnn3uL8nw1jDItONtH/VsFkbwNrr5Iw5qUvxdswDS4tTnglKcK94Nf5Hu
         82brcvRHsHFxRvVTIoZ1odk3CwNkIBZ9vuDO6H9wosIlfkwaNMDRvPON0XriFpw1HCfm
         uzYQ==
X-Received: by 10.70.48.235 with SMTP id p11mr21315544pdn.134.1418046883069;
        Mon, 08 Dec 2014 05:54:43 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id gz10sm36802470pac.23.2014.12.08.05.54.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 05:54:42 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 21:05:17 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261017>

Compare to v1 (the one on 'pu' as v2 never got to 'pu'):

 - New cleanup patch 09/23

 - New patch 17/23 allows to ignore untracked cache without destroying
   it (for comparison and verification)

 - New patches 22/23 and 23/23 add some protection against filesystem
   or operating system changes

 - Document UNTR extension

 - Reorganize UNTR to avoid saving SHA-1/stat data when it's useless

 - Fix writing UNTR to base index in split index mode

 - Various review comments since v1

-- 8< --
diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index fe6f316..5dc2bee 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -233,3 +233,64 @@ Git index format
   The remaining index entries after replaced ones will be added to the
   final index. These added entries are also sorted by entry namme then
   stage.
+
+== Untracked cache
+
+  Untracked cache saves the untracked file list and necessary data to
+  verify the cache. The signature for this extension is { 'U', 'N',
+  'T', 'R' }.
+
+  The extension starts with
+
+  - A NUL-terminated string describing the environment when the cache
+    is created.
+
+  - Stat data of $GIT_DIR/info/exclude. See "Index entry" section from
+    ctime field until "file size".
+
+  - Stat data of core.excludesfile
+
+  - 32-bit dir_flags (see struct dir_struct)
+
+  - 160-bit SHA-1 of $GIT_DIR/info/exclude. Null SHA-1 means the file
+    does not exist.
+
+  - 160-bit SHA-1 of core.excludesfile. Null SHA-1 means the file does
+    not exist.
+
+  - NUL-terminated string of per-dir exclude file name. This usually
+    is ".gitignore".
+
+  - The number of following directory blocks, variable width
+    encoding. If this number is zero, the extension ends here with a
+    following NUL.
+
+  - A number of directory blocks in depth-first-search order, each
+    consists of
+
+    - The number of untracked entries, variable witdh encoding.
+
+    - The number of sub-directory blocks, variable with encoding.
+
+    - The directory name terminated by NUL.
+
+    - A number of untrached file/dir names terminated by NUL.
+
+The remaining data of each directory block is grouped by type:
+
+  - An ewah bitmap, the n-th bit marks whether the n-th directory has
+    valid untracked cache entries.
+
+  - An ewah bitmap, the n-th bit records "check-only" bit of
+    read_directory_recursive() for the n-th directory.
+
+  - An ewah bitmap, the n-th bit indicates whether SHA-1 and stat data
+    is valid for the n-th directory and exists in the next data.
+
+  - An array of stat data. The n-th data corresponds with the n-th
+    "one" bit in the previous ewah bitmap.
+
+  - An array of SHA-1. The n-th SHA-1 corresponds with the n-th "one" bit
+    in the previous ewah bitmap.
+
+  - One NUL.
diff --git a/builtin/update-index.c b/builtin/update-index.c
index c1c18db..f23ec83 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -115,6 +115,7 @@ static int test_if_untracked_cache_is_supported(void)
 	fd = create_file("dir-mtime-test/newfile");
 	xstat("dir-mtime-test", &st);
 	if (!match_stat_data(&base, &st)) {
+		close(fd);
 		fputc('\n', stderr);
 		fprintf_ln(stderr,_("directory stat info does not "
 				    "change after adding a new file"));
@@ -127,6 +128,7 @@ static int test_if_untracked_cache_is_supported(void)
 	xmkdir("dir-mtime-test/new-dir");
 	xstat("dir-mtime-test", &st);
 	if (!match_stat_data(&base, &st)) {
+		close(fd);
 		fputc('\n', stderr);
 		fprintf_ln(stderr, _("directory stat info does not change "
 				     "after adding a new directory"));
@@ -1094,10 +1096,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		/* should be the same flags used by git-status */
 		uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
 		the_index.untracked = uc;
-		the_index.cache_changed |= SOMETHING_CHANGED;
+		the_index.cache_changed |= UNTRACKED_CHANGED;
 	} else if (!untracked_cache && the_index.untracked) {
 		the_index.untracked = NULL;
-		the_index.cache_changed |= SOMETHING_CHANGED;
+		the_index.cache_changed |= UNTRACKED_CHANGED;
 	}
 
 	if (active_cache_changed) {
diff --git a/cache.h b/cache.h
index 201b22e..fca979b 100644
--- a/cache.h
+++ b/cache.h
@@ -295,7 +295,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 #define RESOLVE_UNDO_CHANGED	(1 << 4)
 #define CACHE_TREE_CHANGED	(1 << 5)
 #define SPLIT_INDEX_ORDERED	(1 << 6)
-#define UNTRACKED_CHANGED       (1 << 7)
+#define UNTRACKED_CHANGED	(1 << 7)
 
 struct split_index;
 struct untracked_cache;
diff --git a/compat/mingw.c b/compat/mingw.c
index c5c37e5..88140e4 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2128,3 +2128,14 @@ void mingw_startup()
 	/* initialize Unicode console */
 	winansi_init();
 }
+
+int uname(struct utsname *buf)
+{
+	DWORD v = GetVersion();
+	memset(buf, 0, sizeof(*buf));
+	strcpy(buf->sysname, "Windows");
+	sprintf(buf->release, "%u.%u", v & 0xff, (v >> 8) & 0xff);
+	/* assuming NT variants only.. */
+	sprintf(buf->version, "%u", (v >> 16) & 0x7fff);
+	return 0;
+}
diff --git a/compat/mingw.h b/compat/mingw.h
index df0e320..d00ba7a 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -77,6 +77,14 @@ struct itimerval {
 };
 #define ITIMER_REAL 0
 
+struct utsname {
+	char sysname[16];
+	char nodename[1];
+	char release[16];
+	char version[16];
+	char machine[1];
+};
+
 /*
  * sanitize preprocessor namespace polluted by Windows headers defining
  * macros which collide with git local versions
@@ -166,6 +174,7 @@ struct passwd *getpwuid(uid_t uid);
 int setitimer(int type, struct itimerval *in, struct itimerval *out);
 int sigaction(int sig, struct sigaction *in, struct sigaction *out);
 int link(const char *oldpath, const char *newpath);
+int uname(struct utsname *buf);
 
 /*
  * replacements of existing functions
diff --git a/dir.c b/dir.c
index 0ae2188..ef58547 100644
--- a/dir.c
+++ b/dir.c
@@ -13,6 +13,7 @@
 #include "wildmatch.h"
 #include "pathspec.h"
 #include "varint.h"
+#include "ewah/ewok.h"
 
 struct path_simplify {
 	int len;
@@ -482,7 +483,7 @@ void add_exclude(const char *string, const char *base,
 }
 
 static void *read_skip_worktree_file_from_index(const char *path, size_t *size,
-						struct sha1_stat *ss)
+						struct sha1_stat *sha1_stat)
 {
 	int pos, len;
 	unsigned long sz;
@@ -501,9 +502,9 @@ static void *read_skip_worktree_file_from_index(const char *path, size_t *size,
 		return NULL;
 	}
 	*size = xsize_t(sz);
-	if (ss) {
-		memset(&ss->stat, 0, sizeof(ss->stat));
-		hashcpy(ss->sha1, active_cache[pos]->sha1);
+	if (sha1_stat) {
+		memset(&sha1_stat->stat, 0, sizeof(sha1_stat->stat));
+		hashcpy(sha1_stat->sha1, active_cache[pos]->sha1);
 	}
 	return data;
 }
@@ -584,9 +585,10 @@ static struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
 	}
 
 	uc->dir_created++;
-	d = xmalloc(sizeof(*d) + len);
-	memset(d, 0, sizeof(*d) + len);
+	d = xmalloc(sizeof(*d) + len + 1);
+	memset(d, 0, sizeof(*d));
 	memcpy(d->name, name, len);
+	d->name[len] = '\0';
 
 	ALLOC_GROW(dir->dirs, dir->dirs_nr + 1, dir->dirs_alloc);
 	memmove(dir->dirs + first + 1, dir->dirs + first,
@@ -634,7 +636,7 @@ static void invalidate_directory(struct untracked_cache *uc,
  */
 static int add_excludes(const char *fname, const char *base, int baselen,
 			struct exclude_list *el, int check_index,
-			struct sha1_stat *ss, int ss_valid)
+			struct sha1_stat *sha1_stat)
 {
 	struct stat st;
 	int fd, i, lineno = 1;
@@ -648,7 +650,7 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 		if (0 <= fd)
 			close(fd);
 		if (!check_index ||
-		    (buf = read_skip_worktree_file_from_index(fname, &size, ss)) == NULL)
+		    (buf = read_skip_worktree_file_from_index(fname, &size, sha1_stat)) == NULL)
 			return -1;
 		if (size == 0) {
 			free(buf);
@@ -661,9 +663,10 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 	} else {
 		size = xsize_t(st.st_size);
 		if (size == 0) {
-			if (ss) {
-				fill_stat_data(&ss->stat, &st);
-				hashcpy(ss->sha1, EMPTY_BLOB_SHA1_BIN);
+			if (sha1_stat) {
+				fill_stat_data(&sha1_stat->stat, &st);
+				hashcpy(sha1_stat->sha1, EMPTY_BLOB_SHA1_BIN);
+				sha1_stat->valid = 1;
 			}
 			close(fd);
 			return 0;
@@ -676,19 +679,20 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 		}
 		buf[size++] = '\n';
 		close(fd);
-		if (ss) {
+		if (sha1_stat) {
 			int pos;
-			if (ss_valid &&
-			    !match_stat_data_racy(&the_index, &ss->stat, &st))
+			if (sha1_stat->valid &&
+			    !match_stat_data_racy(&the_index, &sha1_stat->stat, &st))
 				; /* no content change, ss->sha1 still good */
 			else if (check_index &&
 				 (pos = cache_name_pos(fname, strlen(fname))) >= 0 &&
 				 !ce_stage(active_cache[pos]) &&
 				 ce_uptodate(active_cache[pos]))
-				hashcpy(ss->sha1, active_cache[pos]->sha1);
+				hashcpy(sha1_stat->sha1, active_cache[pos]->sha1);
 			else
-				hash_sha1_file(buf, size, "blob", ss->sha1);
-			fill_stat_data(&ss->stat, &st);
+				hash_sha1_file(buf, size, "blob", sha1_stat->sha1);
+			fill_stat_data(&sha1_stat->stat, &st);
+			sha1_stat->valid = 1;
 		}
 	}
 
@@ -712,7 +716,7 @@ int add_excludes_from_file_to_list(const char *fname, const char *base,
 				   int baselen, struct exclude_list *el,
 				   int check_index)
 {
-	return add_excludes(fname, base, baselen, el, check_index, NULL, 0);
+	return add_excludes(fname, base, baselen, el, check_index, NULL);
 }
 
 struct exclude_list *add_exclude_list(struct dir_struct *dir,
@@ -733,7 +737,7 @@ struct exclude_list *add_exclude_list(struct dir_struct *dir,
  * Used to set up core.excludesfile and .git/info/exclude lists.
  */
 static void add_excludes_from_file_1(struct dir_struct *dir, const char *fname,
-				     struct sha1_stat *ss, int ss_valid)
+				     struct sha1_stat *sha1_stat)
 {
 	struct exclude_list *el;
 	/*
@@ -744,14 +748,14 @@ static void add_excludes_from_file_1(struct dir_struct *dir, const char *fname,
 	if (!dir->untracked)
 		dir->unmanaged_exclude_files++;
 	el = add_exclude_list(dir, EXC_FILE, fname);
-	if (add_excludes(fname, "", 0, el, 0, ss, ss_valid) < 0)
+	if (add_excludes(fname, "", 0, el, 0, sha1_stat) < 0)
 		die("cannot use %s as an exclude file", fname);
 }
 
 void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 {
 	dir->unmanaged_exclude_files++; /* see validate_untracked_cache() */
-	add_excludes_from_file_1(dir, fname, NULL, 0);
+	add_excludes_from_file_1(dir, fname, NULL);
 }
 
 int match_basename(const char *basename, int basenamelen,
@@ -974,7 +978,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 	while (current < baselen) {
 		struct exclude_stack *stk = xcalloc(1, sizeof(*stk));
 		const char *cp;
-		struct sha1_stat ss;
+		struct sha1_stat sha1_stat;
 
 		if (current < 0) {
 			cp = base;
@@ -1015,7 +1019,8 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 		}
 
 		/* Try to read per-directory file */
-		hashclr(ss.sha1);
+		hashclr(sha1_stat.sha1);
+		sha1_stat.valid = 0;
 		if (dir->exclude_per_dir &&
 		    /*
 		     * If we know that no files have been added in
@@ -1044,7 +1049,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 			strbuf_addstr(&sb, dir->exclude_per_dir);
 			el->src = strbuf_detach(&sb, NULL);
 			add_excludes(el->src, el->src, stk->baselen, el, 1,
-				     untracked ? &ss : NULL, 0);
+				     untracked ? &sha1_stat : NULL);
 		}
 		/*
 		 * NEEDSWORK: when untracked cache is enabled, prep_exclude()
@@ -1060,9 +1065,10 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 		 * last_exclude_matching(). Be careful about ignore rule
 		 * order, though, if you do that.
 		 */
-		if (untracked && hashcmp(ss.sha1, untracked->exclude_sha1)) {
+		if (untracked &&
+		    hashcmp(sha1_stat.sha1, untracked->exclude_sha1)) {
 			invalidate_gitignore(dir->untracked, untracked);
-			hashcpy(untracked->exclude_sha1, ss.sha1);
+			hashcpy(untracked->exclude_sha1, sha1_stat.sha1);
 		}
 		dir->exclude_stack = stk;
 		current = stk->baselen;
@@ -1457,12 +1463,11 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 					   int baselen,
 					   const struct path_simplify *simplify)
 {
+	strbuf_setlen(path, baselen);
 	if (!cdir->ucd) {
-		strbuf_setlen(path, baselen);
 		strbuf_addstr(path, cdir->file);
 		return path_untracked;
 	}
-	strbuf_setlen(path, baselen);
 	strbuf_addstr(path, cdir->ucd->name);
 	/* treat_one_path() does this before it calls treat_directory() */
 	if (path->buf[path->len - 1] != '/')
@@ -1474,7 +1479,6 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 		 * with check_only set.
 		 */
 		return read_directory_recursive(dir, path->buf, path->len,
-
 						cdir->ucd, 1, simplify);
 	/*
 	 * We get path_recurse in the first run when
@@ -1582,7 +1586,7 @@ static int open_cached_dir(struct cached_dir *cdir,
 	return 0;
 }
 
-int read_cached_dir(struct cached_dir *cdir)
+static int read_cached_dir(struct cached_dir *cdir)
 {
 	if (cdir->fdir) {
 		cdir->de = readdir(cdir->fdir);
@@ -1796,7 +1800,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	struct untracked_cache_dir *root;
 	int i;
 
-	if (!dir->untracked)
+	if (!dir->untracked || getenv("GIT_DISABLE_UNTRACKED_CACHE"))
 		return NULL;
 
 	/*
@@ -2101,30 +2105,12 @@ void setup_standard_excludes(struct dir_struct *dir)
 		home_config_paths(NULL, &xdg_path, "ignore");
 		excludes_file = xdg_path;
 	}
-	if (!access_or_warn(path, R_OK, 0)) {
-		struct sha1_stat *ss = NULL;
-		int ss_valid = 0;
-		if (dir->untracked) {
-			ss = &dir->ss_info_exclude;
-			if (dir->untracked->loaded) {
-				*ss = dir->untracked->ss_info_exclude;
-				ss_valid = 1;
-			}
-		}
-		add_excludes_from_file_1(dir, path, ss, ss_valid);
-	}
-	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0)) {
-		struct sha1_stat *ss = NULL;
-		int ss_valid = 0;
-		if (dir->untracked) {
-			ss = &dir->ss_excludes_file;
-			if (dir->untracked->loaded) {
-				*ss = dir->untracked->ss_excludes_file;
-				ss_valid = 1;
-			}
-		}
-		add_excludes_from_file_1(dir, excludes_file, ss, ss_valid);
-	}
+	if (!access_or_warn(path, R_OK, 0))
+		add_excludes_from_file_1(dir, path,
+					 dir->untracked ? &dir->ss_info_exclude : NULL);
+	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
+		add_excludes_from_file_1(dir, excludes_file,
+					 dir->untracked ? &dir->ss_excludes_file : NULL);
 }
 
 int remove_path(const char *name)
@@ -2186,6 +2172,16 @@ struct ondisk_untracked_cache {
 	char exclude_per_dir[1];
 };
 
+struct write_data {
+	int index;	   /* number of written untracked_cache_dir */
+	struct ewah_bitmap *check_only; /* from untracked_cache_dir */
+	struct ewah_bitmap *valid;	/* from untracked_cache_dir */
+	struct ewah_bitmap *sha1_valid; /* set if exclude_sha1 is not null */
+	struct strbuf out;
+	struct strbuf sb_stat;
+	struct strbuf sb_sha1;
+};
+
 static void stat_data_to_disk(struct stat_data *to, const struct stat_data *from)
 {
 	to->sd_ctime.sec  = htonl(from->sd_ctime.sec);
@@ -2199,16 +2195,14 @@ static void stat_data_to_disk(struct stat_data *to, const struct stat_data *from
 	to->sd_size	  = htonl(from->sd_size);
 }
 
-static void write_one_dir(struct strbuf *out, struct untracked_cache_dir *untracked)
+static void write_one_dir(struct untracked_cache_dir *untracked,
+			  struct write_data *wd)
 {
 	struct stat_data stat_data;
+	struct strbuf *out = &wd->out;
 	unsigned char intbuf[16];
 	unsigned int intlen, value;
-	int i;
-
-	stat_data_to_disk(&stat_data, &untracked->stat_data);
-	strbuf_add(out, &stat_data, sizeof(stat_data));
-	strbuf_add(out, untracked->exclude_sha1, 20);
+	int i = wd->index++;
 
 	/*
 	 * untracked_nr should be reset whenever valid is clear, but
@@ -2219,10 +2213,19 @@ static void write_one_dir(struct strbuf *out, struct untracked_cache_dir *untrac
 		untracked->check_only = 0;
 	}
 
-	value  = untracked->valid;
-	value |= untracked->check_only   << 1;
-	value |= untracked->untracked_nr << 2;
-	intlen = encode_varint(value, intbuf);
+	if (untracked->check_only)
+		ewah_set(wd->check_only, i);
+	if (untracked->valid) {
+		ewah_set(wd->valid, i);
+		stat_data_to_disk(&stat_data, &untracked->stat_data);
+		strbuf_add(&wd->sb_stat, &stat_data, sizeof(stat_data));
+	}
+	if (!is_null_sha1(untracked->exclude_sha1)) {
+		ewah_set(wd->sha1_valid, i);
+		strbuf_add(&wd->sb_sha1, untracked->exclude_sha1, 20);
+	}
+
+	intlen = encode_varint(untracked->untracked_nr, intbuf);
 	strbuf_add(out, intbuf, intlen);
 
 	/* skip non-recurse directories */
@@ -2240,13 +2243,26 @@ static void write_one_dir(struct strbuf *out, struct untracked_cache_dir *untrac
 
 	for (i = 0; i < untracked->dirs_nr; i++)
 		if (untracked->dirs[i]->recurse)
-			write_one_dir(out, untracked->dirs[i]);
+			write_one_dir(untracked->dirs[i], wd);
+}
+
+static void get_ident_string(struct strbuf *sb)
+{
+	struct utsname uts;
+
+	if (uname(&uts))
+		die_errno(_("failed to get kernel name and information"));
+	strbuf_addf(sb, "Location %s, system %s %s %s", get_git_work_tree(),
+		    uts.sysname, uts.release, uts.version);
 }
 
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked)
 {
 	struct ondisk_untracked_cache *ouc;
-	int len = 0;
+	struct write_data wd;
+	struct strbuf sb = STRBUF_INIT;
+	unsigned char varbuf[16];
+	int len = 0, varint_len;
 	if (untracked->exclude_per_dir)
 		len = strlen(untracked->exclude_per_dir);
 	ouc = xmalloc(sizeof(*ouc) + len);
@@ -2256,9 +2272,43 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	hashcpy(ouc->excludes_file_sha1, untracked->ss_excludes_file.sha1);
 	ouc->dir_flags = htonl(untracked->dir_flags);
 	memcpy(ouc->exclude_per_dir, untracked->exclude_per_dir, len + 1);
+
+	get_ident_string(&sb);
+	strbuf_add(out, sb.buf, sb.len + 1);
+	strbuf_release(&sb);
+
 	strbuf_add(out, ouc, sizeof(*ouc) + len);
-	if (untracked->root)
-		write_one_dir(out, untracked->root);
+	if (!untracked->root) {
+		varint_len = encode_varint(0, varbuf);
+		strbuf_add(out, varbuf, varint_len);
+		return;
+	}
+
+	wd.index      = 0;
+	wd.check_only = ewah_new();
+	wd.valid      = ewah_new();
+	wd.sha1_valid = ewah_new();
+	strbuf_init(&wd.out, 1024);
+	strbuf_init(&wd.sb_stat, 1024);
+	strbuf_init(&wd.sb_sha1, 1024);
+	write_one_dir(untracked->root, &wd);
+
+	varint_len = encode_varint(wd.index, varbuf);
+	strbuf_add(out, varbuf, varint_len);
+	strbuf_addbuf(out, &wd.out);
+	ewah_serialize_strbuf(wd.valid, out);
+	ewah_serialize_strbuf(wd.check_only, out);
+	ewah_serialize_strbuf(wd.sha1_valid, out);
+	strbuf_addbuf(out, &wd.sb_stat);
+	strbuf_addbuf(out, &wd.sb_sha1);
+	strbuf_addch(out, '\0'); /* safe guard for string lists */
+
+	ewah_free(wd.valid);
+	ewah_free(wd.check_only);
+	ewah_free(wd.sha1_valid);
+	strbuf_release(&wd.out);
+	strbuf_release(&wd.sb_stat);
+	strbuf_release(&wd.sb_sha1);
 }
 
 static void free_untracked(struct untracked_cache_dir *ucd)
@@ -2282,6 +2332,16 @@ void free_untracked_cache(struct untracked_cache *uc)
 	free(uc);
 }
 
+struct read_data {
+	int index;
+	struct untracked_cache_dir **ucd;
+	struct ewah_bitmap *check_only;
+	struct ewah_bitmap *valid;
+	struct ewah_bitmap *sha1_valid;
+	const unsigned char *data;
+	const unsigned char *end;
+};
+
 static void stat_data_from_disk(struct stat_data *to, const struct stat_data *from)
 {
 	to->sd_ctime.sec  = get_be32(&from->sd_ctime.sec);
@@ -2296,43 +2356,34 @@ static void stat_data_from_disk(struct stat_data *to, const struct stat_data *fr
 }
 
 static int read_one_dir(struct untracked_cache_dir **untracked_,
-			const unsigned char *data_, unsigned long sz)
+			struct read_data *rd)
 {
 #define NEXT(x) \
 	next = data + (x); \
-	if (next > data_ + sz) \
+	if (next > rd->end) \
 		return -1;
 
 	struct untracked_cache_dir ud, *untracked;
-	const unsigned char *next, *data = data_;
+	const unsigned char *next, *data = rd->data, *end = rd->end;
 	unsigned int value;
 	int i, len;
 
 	memset(&ud, 0, sizeof(ud));
 
-	NEXT(sizeof(struct stat_data));
-	stat_data_from_disk(&ud.stat_data, (struct stat_data *)data);
-	data = next;
-
-	NEXT(20);
-	hashcpy(ud.exclude_sha1, data);
-	data = next;
-
 	next = data;
 	value = decode_varint(&next);
-	if (next > data_ + sz)
+	if (next > end)
 		return -1;
-	ud.recurse = 1;
-	ud.valid = value & 1;
-	ud.check_only = (value >> 1) & 1;
-	ud.untracked_alloc = ud.untracked_nr = value >> 2;
+	ud.recurse	   = 1;
+	ud.untracked_alloc = value;
+	ud.untracked_nr	   = value;
 	if (ud.untracked_nr)
 		ud.untracked = xmalloc(sizeof(*ud.untracked) * ud.untracked_nr);
 	data = next;
 
 	next = data;
 	ud.dirs_alloc = ud.dirs_nr = decode_varint(&next);
-	if (next > data_ + sz)
+	if (next > end)
 		return -1;
 	ud.dirs = xmalloc(sizeof(*ud.dirs) * ud.dirs_nr);
 	data = next;
@@ -2351,41 +2402,145 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 		data = next;
 	}
 
+	rd->ucd[rd->index++] = untracked;
+	rd->data = data;
+
 	for (i = 0; i < untracked->dirs_nr; i++) {
-		len = read_one_dir(untracked->dirs + i, data, sz - (data - data_));
+		len = read_one_dir(untracked->dirs + i, rd);
 		if (len < 0)
 			return -1;
-		data += len;
 	}
-	return data - data_;
+	return 0;
+}
+
+static void set_check_only(size_t pos, void *cb)
+{
+	struct read_data *rd = cb;
+	struct untracked_cache_dir *ud = rd->ucd[pos];
+	ud->check_only = 1;
+}
+
+static void read_stat(size_t pos, void *cb)
+{
+	struct read_data *rd = cb;
+	struct untracked_cache_dir *ud = rd->ucd[pos];
+	if (rd->data + sizeof(struct stat_data) > rd->end) {
+		rd->data = rd->end + 1;
+		return;
+	}
+	stat_data_from_disk(&ud->stat_data, (struct stat_data *)rd->data);
+	rd->data += sizeof(struct stat_data);
+	ud->valid = 1;
+}
+
+static void read_sha1(size_t pos, void *cb)
+{
+	struct read_data *rd = cb;
+	struct untracked_cache_dir *ud = rd->ucd[pos];
+	if (rd->data + 20 > rd->end) {
+		rd->data = rd->end + 1;
+		return;
+	}
+	hashcpy(ud->exclude_sha1, rd->data);
+	rd->data += 20;
+}
+
+static void load_sha1_stat(struct sha1_stat *sha1_stat,
+			   const struct stat_data *stat,
+			   const unsigned char *sha1)
+{
+	stat_data_from_disk(&sha1_stat->stat, stat);
+	hashcpy(sha1_stat->sha1, sha1);
+	sha1_stat->valid = 1;
 }
 
 struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz)
 {
-	const struct ondisk_untracked_cache *ouc = data;
+	const struct ondisk_untracked_cache *ouc;
 	struct untracked_cache *uc;
+	struct read_data rd;
+	const unsigned char *next = data, *end = data + sz;
+	struct strbuf sb = STRBUF_INIT;
 	int len;
 
-	if (sz < sizeof(*ouc))
+	if (sz <= 1 || end[-1] != '\0')
+		return NULL;
+	end--;
+
+	get_ident_string(&sb);
+	if (strcmp(sb.buf, (const char *)next)) {
+		warning(_("system identification does not match, untracked cache disabled.\n"
+			  "Stored: %s\nCurrent: %s\n"),
+			next, sb.buf);
+		strbuf_release(&sb);
+		return NULL;
+	}
+	next += sb.len + 1;
+	strbuf_release(&sb);
+
+	ouc = (const struct ondisk_untracked_cache *)next;
+	if (next + sizeof(*ouc) > end)
 		return NULL;
 
 	uc = xcalloc(1, sizeof(*uc));
-	stat_data_from_disk(&uc->ss_info_exclude.stat, &ouc->info_exclude_stat);
-	stat_data_from_disk(&uc->ss_excludes_file.stat, &ouc->excludes_file_stat);
-	hashcpy(uc->ss_info_exclude.sha1, ouc->info_exclude_sha1);
-	hashcpy(uc->ss_excludes_file.sha1, ouc->excludes_file_sha1);
+	load_sha1_stat(&uc->ss_info_exclude, &ouc->info_exclude_stat,
+		       ouc->info_exclude_sha1);
+	load_sha1_stat(&uc->ss_excludes_file, &ouc->excludes_file_stat,
+		       ouc->excludes_file_sha1);
 	uc->dir_flags = get_be32(&ouc->dir_flags);
 	uc->exclude_per_dir = xstrdup(ouc->exclude_per_dir);
-	uc->loaded = 1;
-	len = sizeof(*ouc) + strlen(ouc->exclude_per_dir);
-	if (sz == len)
-		return uc;
-	if (sz > len &&
-	    read_one_dir(&uc->root, (const unsigned char *)data + len,
-			 sz - len) == sz - len)
-		return uc;
-	free_untracked_cache(uc);
-	return NULL;
+	/* NUL after exclude_per_dir is covered by sizeof(*ouc) */
+	next += sizeof(*ouc) + strlen(ouc->exclude_per_dir);
+	if (next >= end)
+		goto done2;
+
+	len = decode_varint(&next);
+	if (next > end || len == 0)
+		goto done2;
+
+	rd.valid      = ewah_new();
+	rd.check_only = ewah_new();
+	rd.sha1_valid = ewah_new();
+	rd.data	      = next;
+	rd.end	      = end;
+	rd.index      = 0;
+	rd.ucd        = xmalloc(sizeof(*rd.ucd) * len);
+
+	if (read_one_dir(&uc->root, &rd) || rd.index != len)
+		goto done;
+
+	next = rd.data;
+	len = ewah_read_mmap(rd.valid, next, end - next);
+	if (len < 0)
+		goto done;
+
+	next += len;
+	len = ewah_read_mmap(rd.check_only, next, end - next);
+	if (len < 0)
+		goto done;
+
+	next += len;
+	len = ewah_read_mmap(rd.sha1_valid, next, end - next);
+	if (len < 0)
+		goto done;
+
+	ewah_each_bit(rd.check_only, set_check_only, &rd);
+	rd.data = next + len;
+	ewah_each_bit(rd.valid, read_stat, &rd);
+	ewah_each_bit(rd.sha1_valid, read_sha1, &rd);
+	next = rd.data;
+
+done:
+	free(rd.ucd);
+	ewah_free(rd.valid);
+	ewah_free(rd.check_only);
+	ewah_free(rd.sha1_valid);
+done2:
+	if (next != end) {
+		free_untracked_cache(uc);
+		uc = NULL;
+	}
+	return uc;
 }
 
 void untracked_cache_invalidate_path(struct index_state *istate,
diff --git a/dir.h b/dir.h
index 8c29324..2ce7dd3 100644
--- a/dir.h
+++ b/dir.h
@@ -77,6 +77,7 @@ struct exclude_list_group {
 struct sha1_stat {
 	struct stat_data stat;
 	unsigned char sha1[20];
+	int valid;
 };
 
 /*
@@ -85,7 +86,7 @@ struct sha1_stat {
  *  The following inputs are sufficient to determine what files in a
  *  directory are excluded:
  *
- *   - The list of files and directories of the direction in question
+ *   - The list of files and directories of the directory in question
  *   - The $GIT_DIR/index
  *   - dir_struct flags
  *   - The content of $GIT_DIR/info/exclude
@@ -110,16 +111,16 @@ struct sha1_stat {
 struct untracked_cache_dir {
 	struct untracked_cache_dir **dirs;
 	char **untracked;
-	/* null SHA-1 means this directory does not have .gitignore */
-	unsigned char exclude_sha1[20];
 	struct stat_data stat_data;
-	unsigned int recurse : 1;
+	unsigned int untracked_alloc, dirs_nr, dirs_alloc;
+	unsigned int untracked_nr;
 	unsigned int check_only : 1;
 	/* all data except 'dirs' in this struct are good */
 	unsigned int valid : 1;
-	unsigned int untracked_nr : 29;
-	unsigned int untracked_alloc, dirs_nr, dirs_alloc;
-	char name[1];
+	unsigned int recurse : 1;
+	/* null SHA-1 means this directory does not have .gitignore */
+	unsigned char exclude_sha1[20];
+	char name[FLEX_ARRAY];
 };
 
 struct untracked_cache {
@@ -137,7 +138,6 @@ struct untracked_cache {
 	int gitignore_invalidated;
 	int dir_invalidated;
 	int dir_opened;
-	int loaded;
 };
 
 struct dir_struct {
diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index 1c2d7af..43481b9 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -19,6 +19,7 @@
  */
 #include "git-compat-util.h"
 #include "ewok.h"
+#include "strbuf.h"
 
 int ewah_serialize_native(struct ewah_bitmap *self, int fd)
 {
@@ -110,6 +111,18 @@ int ewah_serialize(struct ewah_bitmap *self, int fd)
 	return ewah_serialize_to(self, write_helper, (void *)(intptr_t)fd);
 }
 
+static int write_strbuf(void *user_data, const void *data, size_t len)
+{
+	struct strbuf *sb = user_data;
+	strbuf_add(sb, data, len);
+	return len;
+}
+
+int ewah_serialize_strbuf(struct ewah_bitmap *self, struct strbuf *sb)
+{
+	return ewah_serialize_to(self, write_strbuf, sb);
+}
+
 int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len)
 {
 	const uint8_t *ptr = map;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index f6ad190..4d7f5e9 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -30,6 +30,7 @@
 #	define ewah_calloc xcalloc
 #endif
 
+struct strbuf;
 typedef uint64_t eword_t;
 #define BITS_IN_WORD (sizeof(eword_t) * 8)
 
@@ -97,6 +98,7 @@ int ewah_serialize_to(struct ewah_bitmap *self,
 		      void *out);
 int ewah_serialize(struct ewah_bitmap *self, int fd);
 int ewah_serialize_native(struct ewah_bitmap *self, int fd);
+int ewah_serialize_strbuf(struct ewah_bitmap *self, struct strbuf *);
 
 int ewah_deserialize(struct ewah_bitmap *self, int fd);
 int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len);
diff --git a/git-compat-util.h b/git-compat-util.h
index f587749..e9502a1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -132,6 +132,7 @@
 #elif defined(_MSC_VER)
 #include "compat/msvc.h"
 #else
+#include <sys/utsname.h>
 #include <sys/wait.h>
 #include <sys/resource.h>
 #include <sys/socket.h>
diff --git a/read-cache.c b/read-cache.c
index 21ae963..71d8e20 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2040,7 +2040,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 		if (err)
 			return -1;
 	}
-	if (istate->untracked) {
+	if (!strip_extensions && istate->untracked) {
 		struct strbuf sb = STRBUF_INIT;
 
 		write_untracked_extension(&sb, istate->untracked);
diff --git a/split-index.c b/split-index.c
index 21485e2..968b780 100644
--- a/split-index.c
+++ b/split-index.c
@@ -41,13 +41,6 @@ int read_link_extension(struct index_state *istate,
 	return 0;
 }
 
-static int write_strbuf(void *user_data, const void *data, size_t len)
-{
-	struct strbuf *sb = user_data;
-	strbuf_add(sb, data, len);
-	return len;
-}
-
 int write_link_extension(struct strbuf *sb,
 			 struct index_state *istate)
 {
@@ -55,8 +48,8 @@ int write_link_extension(struct strbuf *sb,
 	strbuf_add(sb, si->base_sha1, 20);
 	if (!si->delete_bitmap && !si->replace_bitmap)
 		return 0;
-	ewah_serialize_to(si->delete_bitmap, write_strbuf, sb);
-	ewah_serialize_to(si->replace_bitmap, write_strbuf, sb);
+	ewah_serialize_strbuf(si->delete_bitmap, sb);
+	ewah_serialize_strbuf(si->replace_bitmap, sb);
 	return 0;
 }
 
diff --git a/test-dump-untracked-cache.c b/test-dump-untracked-cache.c
index 710441e..25d855d 100644
--- a/test-dump-untracked-cache.c
+++ b/test-dump-untracked-cache.c
@@ -44,6 +44,7 @@ int main(int ac, char **av)
 {
 	struct untracked_cache *uc;
 	struct strbuf base = STRBUF_INIT;
+	setup_git_directory();
 	if (read_cache() < 0)
 		die("unable to read index file");
 	uc = the_index.untracked;
-- 8< --
-- 
2.2.0.60.gb7b3c64
