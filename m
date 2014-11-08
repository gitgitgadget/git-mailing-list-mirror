From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/22] untracked cache updates
Date: Sat,  8 Nov 2014 16:39:33 +0700
Message-ID: <1415439595-469-1-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 10:40:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn2Uw-0000Eq-MJ
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 10:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbaKHJjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 04:39:53 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:62522 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbaKHJjt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 04:39:49 -0500
Received: by mail-pd0-f180.google.com with SMTP id ft15so4792156pdb.11
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 01:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SAIDh2+we2DPhbJ4VPhe6RBji0Gz4004gXjcCX6EFCM=;
        b=EPc3sn381qy0edzFttYdChz7wwg/cG6wPIxslbRD9gyorIInFjUeCcyT+QBwZ+JlLR
         qt5S3kuq3gjqXXnrHUTxVnX+xe63uBF7clOBDk3pmYWDs62BSZG3jPhqDaF41ZQMUpgP
         mkPDE5z3g9JbJSgPjiiGTQBgSR3iT452p4sWwIpu9mveGUEJRm592Gstzp1ynETtvfy4
         GGZa/i4jfVs/aoP/Ztwoe4Qd3sHCdVcpI5oKkl6NWDJhNPbwPEmACk0Llhu4btPbUkpV
         sCaNgAxMK0XnA45+O6Bk0wsoWjry4bRiUa04IvJyk8/haXYY5RxUlkRUQRUPWfT2HXUw
         6ssA==
X-Received: by 10.66.66.2 with SMTP id b2mr18328615pat.49.1415439589049;
        Sat, 08 Nov 2014 01:39:49 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id nv7sm10983467pdb.68.2014.11.08.01.39.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 01:39:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Nov 2014 16:40:02 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated based on comments from the list, including three new patches:

 - 16/22 allows to ignore untracked cache without destroying it (for
   comparison and verification)
 - 21/22 and 22/22 add some protection against filesystem or operating
   system changes

Also fix 'update-index --untracked-cache' essentially merging the
split index back because I set wrong update flag.

This series is also available on github [1] but you will have to
ignore the few top debugging patches first. Diff against the version
on 'pu' below.

[1] https://github.com/pclouds/git.git untracked-cache

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
diff --git a/compat/mingw.c b/compat/mingw.c
index c5c37e5..b817678 100644
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
+	sprintf(buf->sysname, "Windows");
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
index 0ae2188..2324c52 100644
--- a/dir.c
+++ b/dir.c
@@ -482,7 +482,7 @@ void add_exclude(const char *string, const char *base,
 }
 
 static void *read_skip_worktree_file_from_index(const char *path, size_t *size,
-						struct sha1_stat *ss)
+						struct sha1_stat *sha1_stat)
 {
 	int pos, len;
 	unsigned long sz;
@@ -501,9 +501,9 @@ static void *read_skip_worktree_file_from_index(const char *path, size_t *size,
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
@@ -634,7 +634,7 @@ static void invalidate_directory(struct untracked_cache *uc,
  */
 static int add_excludes(const char *fname, const char *base, int baselen,
 			struct exclude_list *el, int check_index,
-			struct sha1_stat *ss, int ss_valid)
+			struct sha1_stat *sha1_stat)
 {
 	struct stat st;
 	int fd, i, lineno = 1;
@@ -648,7 +648,7 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 		if (0 <= fd)
 			close(fd);
 		if (!check_index ||
-		    (buf = read_skip_worktree_file_from_index(fname, &size, ss)) == NULL)
+		    (buf = read_skip_worktree_file_from_index(fname, &size, sha1_stat)) == NULL)
 			return -1;
 		if (size == 0) {
 			free(buf);
@@ -661,9 +661,10 @@ static int add_excludes(const char *fname, const char *base, int baselen,
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
@@ -676,19 +677,20 @@ static int add_excludes(const char *fname, const char *base, int baselen,
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
 
@@ -712,7 +714,7 @@ int add_excludes_from_file_to_list(const char *fname, const char *base,
 				   int baselen, struct exclude_list *el,
 				   int check_index)
 {
-	return add_excludes(fname, base, baselen, el, check_index, NULL, 0);
+	return add_excludes(fname, base, baselen, el, check_index, NULL);
 }
 
 struct exclude_list *add_exclude_list(struct dir_struct *dir,
@@ -733,7 +735,7 @@ struct exclude_list *add_exclude_list(struct dir_struct *dir,
  * Used to set up core.excludesfile and .git/info/exclude lists.
  */
 static void add_excludes_from_file_1(struct dir_struct *dir, const char *fname,
-				     struct sha1_stat *ss, int ss_valid)
+				     struct sha1_stat *sha1_stat)
 {
 	struct exclude_list *el;
 	/*
@@ -744,14 +746,14 @@ static void add_excludes_from_file_1(struct dir_struct *dir, const char *fname,
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
@@ -974,7 +976,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 	while (current < baselen) {
 		struct exclude_stack *stk = xcalloc(1, sizeof(*stk));
 		const char *cp;
-		struct sha1_stat ss;
+		struct sha1_stat sha1_stat;
 
 		if (current < 0) {
 			cp = base;
@@ -1015,7 +1017,8 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 		}
 
 		/* Try to read per-directory file */
-		hashclr(ss.sha1);
+		hashclr(sha1_stat.sha1);
+		sha1_stat.valid = 0;
 		if (dir->exclude_per_dir &&
 		    /*
 		     * If we know that no files have been added in
@@ -1044,7 +1047,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 			strbuf_addstr(&sb, dir->exclude_per_dir);
 			el->src = strbuf_detach(&sb, NULL);
 			add_excludes(el->src, el->src, stk->baselen, el, 1,
-				     untracked ? &ss : NULL, 0);
+				     untracked ? &sha1_stat : NULL);
 		}
 		/*
 		 * NEEDSWORK: when untracked cache is enabled, prep_exclude()
@@ -1060,9 +1063,10 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
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
@@ -1457,12 +1461,11 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
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
@@ -1474,7 +1477,6 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 		 * with check_only set.
 		 */
 		return read_directory_recursive(dir, path->buf, path->len,
-
 						cdir->ucd, 1, simplify);
 	/*
 	 * We get path_recurse in the first run when
@@ -1582,7 +1584,7 @@ static int open_cached_dir(struct cached_dir *cdir,
 	return 0;
 }
 
-int read_cached_dir(struct cached_dir *cdir)
+static int read_cached_dir(struct cached_dir *cdir)
 {
 	if (cdir->fdir) {
 		cdir->de = readdir(cdir->fdir);
@@ -1796,7 +1798,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	struct untracked_cache_dir *root;
 	int i;
 
-	if (!dir->untracked)
+	if (!dir->untracked || getenv("GIT_DISABLE_UNTRACKED_CACHE"))
 		return NULL;
 
 	/*
@@ -2101,30 +2103,12 @@ void setup_standard_excludes(struct dir_struct *dir)
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
@@ -2243,10 +2227,22 @@ static void write_one_dir(struct strbuf *out, struct untracked_cache_dir *untrac
 			write_one_dir(out, untracked->dirs[i]);
 }
 
+static void get_ident_string(struct strbuf *sb)
+{
+	struct utsname uts;
+
+	if (uname(&uts))
+		die_errno(_("failed to get kernel name and information"));
+	strbuf_addf(sb, "Location %s, system %s %s %s", get_git_work_tree(),
+		    uts.sysname, uts.release, uts.version);
+}
+
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked)
 {
 	struct ondisk_untracked_cache *ouc;
-	int len = 0;
+	struct strbuf sb = STRBUF_INIT;
+	unsigned char varbuf[16];
+	int len = 0, varint_len;
 	if (untracked->exclude_per_dir)
 		len = strlen(untracked->exclude_per_dir);
 	ouc = xmalloc(sizeof(*ouc) + len);
@@ -2256,6 +2252,13 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	hashcpy(ouc->excludes_file_sha1, untracked->ss_excludes_file.sha1);
 	ouc->dir_flags = htonl(untracked->dir_flags);
 	memcpy(ouc->exclude_per_dir, untracked->exclude_per_dir, len + 1);
+
+	get_ident_string(&sb);
+	varint_len = encode_varint(sb.len + 1, varbuf);
+	strbuf_add(out, varbuf, varint_len);
+	strbuf_add(out, sb.buf, sb.len + 1);
+	strbuf_release(&sb);
+
 	strbuf_add(out, ouc, sizeof(*ouc) + len);
 	if (untracked->root)
 		write_one_dir(out, untracked->root);
@@ -2360,28 +2363,55 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 	return data - data_;
 }
 
+static void load_sha1_stat(struct sha1_stat *sha1_stat,
+			   const struct stat_data *stat,
+			   const unsigned char *sha1)
+{
+	stat_data_from_disk(&sha1_stat->stat, stat);
+	hashcpy(sha1_stat->sha1, sha1);
+	sha1_stat->valid = 1;
+}
+
 struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz)
 {
-	const struct ondisk_untracked_cache *ouc = data;
+	const struct ondisk_untracked_cache *ouc;
 	struct untracked_cache *uc;
+	const unsigned char *next = data;
+	struct strbuf sb = STRBUF_INIT;
 	int len;
 
+	len = decode_varint(&next);
+	if (sz <= (next - (const unsigned char *)data) + len ||
+	    next[len - 1] != '\0')
+		return NULL;
+
+	get_ident_string(&sb);
+	if (strcmp(sb.buf, (const char *)next)) {
+		warning(_("system identification does not match, untracked cache disabled.\n"
+			  "Stored: %s\nCurrent: %s\n"),
+			next, sb.buf);
+		strbuf_release(&sb);
+		return NULL;
+	}
+	strbuf_release(&sb);
+	ouc = (const struct ondisk_untracked_cache *)(next + len);
+	sz -= (const char *)ouc - (const char *)data;
+
 	if (sz < sizeof(*ouc))
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
 	len = sizeof(*ouc) + strlen(ouc->exclude_per_dir);
 	if (sz == len)
 		return uc;
 	if (sz > len &&
-	    read_one_dir(&uc->root, (const unsigned char *)data + len,
+	    read_one_dir(&uc->root, (const unsigned char *)ouc + len,
 			 sz - len) == sz - len)
 		return uc;
 	free_untracked_cache(uc);
diff --git a/dir.h b/dir.h
index 8c29324..708cdd5 100644
--- a/dir.h
+++ b/dir.h
@@ -77,6 +77,7 @@ struct exclude_list_group {
 struct sha1_stat {
 	struct stat_data stat;
 	unsigned char sha1[20];
+	int valid;
 };
 
 /*
@@ -110,15 +111,15 @@ struct sha1_stat {
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
+	unsigned int recurse : 1;
+	/* null SHA-1 means this directory does not have .gitignore */
+	unsigned char exclude_sha1[20];
 	char name[1];
 };
 
@@ -137,7 +138,6 @@ struct untracked_cache {
 	int gitignore_invalidated;
 	int dir_invalidated;
 	int dir_opened;
-	int loaded;
 };
 
 struct dir_struct {
diff --git a/git-compat-util.h b/git-compat-util.h
index f587749..6b1f259 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -125,6 +125,7 @@
 #else
 #include <poll.h>
 #endif
+#include <sys/utsname.h>
 
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
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
-- 
2.1.0.rc0.78.gc0d8480
