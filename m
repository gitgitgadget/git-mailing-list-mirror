From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/20] untracked cache: record .gitignore information and dir hierarchy
Date: Wed,  7 May 2014 21:51:45 +0700
Message-ID: <1399474320-6840-6-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:52:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3D0-0005fo-Qx
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbaEGOwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:52:30 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33678 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250AbaEGOw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:52:29 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so1297461pad.23
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=twagHVDvJPmVoBuBJKq5hfA8NJLKpvk5uhuRt0itXnw=;
        b=CURr0KyqzbUxxRuJBH0NsF07hTsDDVPFJMd6OInSQfNlqD67WPs0oictU0V9TsajJk
         AJpPmVo91QcQPwjMFY7L8cvhczQ1y07dn3qpqGk0pqUuUPqflAw2PN6b3jLT8W1dkMRv
         P1Tz4DhRPRymFDacieqQ3oqcpk4RjQc3iw4i9zzVmsbc7IMkRmyw+Y7aLhsJihMvcUBI
         TjlxrHUQ/Angl9xuwW5fnVREK3NscjSGdVklfW2qfPxe//Mi1ORBIltiIC6y+4Em4lEH
         wKHPPALTkwTenp+71NfO0XdQhorsXjslm3Vbj18IgRFUEfCBaxEb+5mJn6Lj3RSDGxpv
         lksQ==
X-Received: by 10.67.13.226 with SMTP id fb2mr20058269pad.146.1399474349188;
        Wed, 07 May 2014 07:52:29 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id ec2sm3636577pbc.63.2014.05.07.07.52.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:52:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:52:28 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248311>

The idea is if we can capture all input and output of
read_directory_recursive() and verify at a later time that all the
input is the same, then read_directory_recursive() should produce the
same output, so we can bypass read_directory_recursive() and reuse the
cached output for the directory in question (the bypass code needs to
verify subdirectories separately)

The list of input of read_directory_recursive() is in the big comment
block in dir.h. This cache focuses on only untracked files as the
output from r_d_r(), not ignored files because the number of tracked
files is usually small, so small cache overhead, while the number of
ignored files could go really high (e.g. *.o files mixing with source
code).

This patch captures .gitignore information, check_only bit and the
list of directories that read_directory_recursive() examines.

Two hash_sha1_file() are required for $GIT_DIR/info/exclude and
core.excludesfile unless their stat data matches. hash_sha1_file() is
only needed when .gitignore files in the worktree are modified,
otherwise their SHA-1 in index is used.

We could store stat data for .gitignore files so we don't have to
rehash them if their content is different from index, but I think
.gitignore files are rarely modified, so not worth extra cache data
(and hashing penalty read-cache.c:verify_hdr(), as we will be storing
this as an index extension).

This means if you change .gitignore at root directory, you better add
it to the index soon or you lose all the benefit of untracked cache (a
change at root .gitignore invalidates everything) and pay the cache
overhead for nothing.
---
 dir.c | 167 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 dir.h |  64 +++++++++++++++++++++++++
 2 files changed, 210 insertions(+), 21 deletions(-)

diff --git a/dir.c b/dir.c
index e2edeca..34a10b2 100644
--- a/dir.c
+++ b/dir.c
@@ -32,7 +32,7 @@ enum path_treatment {
 };
 
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
-	const char *path, int len,
+	const char *path, int len, struct untracked_cache_dir *untracked,
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path, int len);
 
@@ -528,6 +528,46 @@ static void trim_trailing_spaces(char *buf)
 		buf[last_space] = '\0';
 }
 
+static struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
+						    struct untracked_cache_dir *dir,
+						    const char *name, int len)
+{
+	int first, last;
+	struct untracked_cache_dir *d;
+	if (!dir)
+		return NULL;
+	if (len && name[len - 1] == '/')
+		len--;
+	first = 0;
+	last = dir->dirs_nr;
+	while (last > first) {
+		int cmp, next = (last + first) >> 1;
+		d = dir->dirs[next];
+		cmp = strncmp(name, d->name, len);
+		if (!cmp && strlen(d->name) > len)
+			cmp = -1;
+		if (!cmp)
+			return d;
+		if (cmp < 0) {
+			last = next;
+			continue;
+		}
+		first = next+1;
+	}
+
+	uc->dir_created++;
+	d = xmalloc(sizeof(*d) + len);
+	memset(d, 0, sizeof(*d) + len);
+	memcpy(d->name, name, len);
+
+	ALLOC_GROW(dir->dirs, dir->dirs_nr + 1, dir->dirs_alloc);
+	memmove(dir->dirs + first + 1, dir->dirs + first,
+		(dir->dirs_nr - first) * sizeof(*dir->dirs));
+	dir->dirs_nr++;
+	dir->dirs[first] = d;
+	return d;
+}
+
 static int add_excludes(const char *fname,
 			const char *base,
 			int baselen,
@@ -639,14 +679,22 @@ struct exclude_list *add_exclude_list(struct dir_struct *dir,
 /*
  * Used to set up core.excludesfile and .git/info/exclude lists.
  */
-void add_excludes_from_file(struct dir_struct *dir, const char *fname)
+void add_excludes_from_file_1(struct dir_struct *dir, const char *fname,
+			      unsigned char *sha1,
+			      struct stat_data *ref_stat,
+			      const unsigned char *ref_sha1)
 {
 	struct exclude_list *el;
 	el = add_exclude_list(dir, EXC_FILE, fname);
-	if (add_excludes_from_file_to_list(fname, "", 0, el, 0) < 0)
+	if (add_excludes(fname, "", 0, el, 0, sha1, ref_stat, ref_sha1) < 0)
 		die("cannot use %s as an exclude file", fname);
 }
 
+void add_excludes_from_file(struct dir_struct *dir, const char *fname)
+{
+	add_excludes_from_file_1(dir, fname, NULL, NULL, NULL);
+}
+
 int match_basename(const char *basename, int basenamelen,
 		   const char *pattern, int prefix, int patternlen,
 		   int flags)
@@ -821,6 +869,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 	struct exclude_list_group *group;
 	struct exclude_list *el;
 	struct exclude_stack *stk = NULL;
+	struct untracked_cache_dir *untracked = NULL;
 	int current;
 
 	group = &dir->exclude_list_group[EXC_DIRS];
@@ -858,18 +907,39 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 	/* Read from the parent directories and push them down. */
 	current = stk ? stk->baselen : -1;
 	strbuf_setlen(&dir->basebuf, current < 0 ? 0 : current);
+
+	if (dir->untracked && current >= 0 && current < baselen) {
+		const char *start = base;
+		const char *end	  = base + current;
+		untracked = dir->untracked->root;
+		while (start < end) {
+			const char *cp = strchrnul(start, '/');
+			untracked =
+				lookup_untracked(dir->untracked, untracked,
+						 start, cp - start);
+			start = *cp == '/' ? cp + 1 : cp;
+		}
+	}
+
 	while (current < baselen) {
 		struct exclude_stack *stk = xcalloc(1, sizeof(*stk));
 		const char *cp;
+		unsigned char sha1[20];
 
 		if (current < 0) {
 			cp = base;
 			current = 0;
+			if (dir->untracked)
+				untracked = dir->untracked->root;
 		} else {
 			cp = strchr(base + current + 1, '/');
 			if (!cp)
 				die("oops in prep_exclude");
 			cp++;
+			untracked =
+				lookup_untracked(dir->untracked, untracked,
+						 base + current,
+						 cp - base - current);
 		}
 		stk->prev = dir->exclude_stack;
 		stk->baselen = cp - base;
@@ -896,6 +966,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 		}
 
 		/* Try to read per-directory file */
+		hashclr(sha1);
 		if (dir->exclude_per_dir) {
 			/*
 			 * dir->basebuf gets reused by the traversal, but we
@@ -909,8 +980,11 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 			strbuf_addbuf(&sb, &dir->basebuf);
 			strbuf_addstr(&sb, dir->exclude_per_dir);
 			el->src = strbuf_detach(&sb, NULL);
-			add_excludes_from_file_to_list(el->src, el->src,
-						       stk->baselen, el, 1);
+			add_excludes(el->src, el->src, stk->baselen, el, 1,
+				     untracked ? sha1 : NULL, NULL, NULL);
+		}
+		if (untracked) {
+			hashcpy(untracked->exclude_sha1, sha1);
 		}
 		dir->exclude_stack = stk;
 		current = stk->baselen;
@@ -1091,6 +1165,7 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
  *  (c) otherwise, we recurse into it.
  */
 static enum path_treatment treat_directory(struct dir_struct *dir,
+	struct untracked_cache_dir *untracked,
 	const char *dirname, int len, int exclude,
 	const struct path_simplify *simplify)
 {
@@ -1118,7 +1193,9 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		return exclude ? path_excluded : path_untracked;
 
-	return read_directory_recursive(dir, dirname, len, 1, simplify);
+	untracked = lookup_untracked(dir->untracked, untracked, dirname, len);
+	return read_directory_recursive(dir, dirname, len,
+					untracked, 1, simplify);
 }
 
 /*
@@ -1234,6 +1311,7 @@ static int get_dtype(struct dirent *de, const char *path, int len)
 }
 
 static enum path_treatment treat_one_path(struct dir_struct *dir,
+					  struct untracked_cache_dir *untracked,
 					  struct strbuf *path,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
@@ -1286,7 +1364,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 		return path_none;
 	case DT_DIR:
 		strbuf_addch(path, '/');
-		return treat_directory(dir, path->buf, path->len, exclude,
+		return treat_directory(dir, untracked, path->buf, path->len, exclude,
 			simplify);
 	case DT_REG:
 	case DT_LNK:
@@ -1295,6 +1373,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 }
 
 static enum path_treatment treat_path(struct dir_struct *dir,
+				      struct untracked_cache_dir *untracked,
 				      struct dirent *de,
 				      struct strbuf *path,
 				      int baselen,
@@ -1310,7 +1389,16 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 		return path_none;
 
 	dtype = DTYPE(de);
-	return treat_one_path(dir, path, simplify, dtype, de);
+	return treat_one_path(dir, untracked, path, simplify, dtype, de);
+}
+
+static void add_untracked(struct untracked_cache_dir *dir, const char *name)
+{
+	if (!dir)
+		return;
+	ALLOC_GROW(dir->untracked, dir->untracked_nr + 1,
+		   dir->untracked_alloc);
+	dir->untracked[dir->untracked_nr++] = xstrdup(name);
 }
 
 /*
@@ -1326,7 +1414,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
  */
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 				    const char *base, int baselen,
-				    int check_only,
+				    struct untracked_cache_dir *untracked, int check_only,
 				    const struct path_simplify *simplify)
 {
 	DIR *fdir;
@@ -1340,24 +1428,36 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	if (!fdir)
 		goto out;
 
+	if (untracked)
+		untracked->check_only = !!check_only;
+
 	while ((de = readdir(fdir)) != NULL) {
 		/* check how the file or directory should be treated */
-		state = treat_path(dir, de, &path, baselen, simplify);
+		state = treat_path(dir, untracked, de, &path, baselen, simplify);
+
 		if (state > dir_state)
 			dir_state = state;
 
 		/* recurse into subdir if instructed by treat_path */
 		if (state == path_recurse) {
-			subdir_state = read_directory_recursive(dir, path.buf,
-				path.len, check_only, simplify);
+			struct untracked_cache_dir *ud;
+			ud = lookup_untracked(dir->untracked, untracked,
+					      path.buf + baselen,
+					      path.len - baselen);
+			subdir_state =
+				read_directory_recursive(dir, path.buf, path.len,
+							 ud, check_only, simplify);
 			if (subdir_state > dir_state)
 				dir_state = subdir_state;
 		}
 
 		if (check_only) {
 			/* abort early if maximum state has been reached */
-			if (dir_state == path_untracked)
+			if (dir_state == path_untracked) {
+				if (untracked)
+					add_untracked(untracked, path.buf + baselen);
 				break;
+			}
 			/* skip the dir_add_* part */
 			continue;
 		}
@@ -1375,8 +1475,11 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			break;
 
 		case path_untracked:
-			if (!(dir->flags & DIR_SHOW_IGNORED))
-				dir_add_name(dir, path.buf, path.len);
+			if (dir->flags & DIR_SHOW_IGNORED)
+				break;
+			dir_add_name(dir, path.buf, path.len);
+			if (untracked)
+				add_untracked(untracked, path.buf + baselen);
 			break;
 
 		default:
@@ -1454,7 +1557,7 @@ static int treat_leading_path(struct dir_struct *dir,
 			break;
 		if (simplify_away(sb.buf, sb.len, simplify))
 			break;
-		if (treat_one_path(dir, &sb, simplify,
+		if (treat_one_path(dir, NULL, &sb, simplify,
 				   DT_DIR, NULL) == path_none)
 			break; /* do not recurse into it */
 		if (len <= baselen) {
@@ -1494,7 +1597,9 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const stru
 	 */
 	simplify = create_simplify(pathspec ? pathspec->_raw : NULL);
 	if (!len || treat_leading_path(dir, path, len, simplify))
-		read_directory_recursive(dir, path, len, 0, simplify);
+		read_directory_recursive(dir, path, len,
+					 dir->untracked ? dir->untracked->root : NULL,
+					 0, simplify);
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_name);
@@ -1660,10 +1765,30 @@ void setup_standard_excludes(struct dir_struct *dir)
 		home_config_paths(NULL, &xdg_path, "ignore");
 		excludes_file = xdg_path;
 	}
-	if (!access_or_warn(path, R_OK, 0))
-		add_excludes_from_file(dir, path);
-	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
-		add_excludes_from_file(dir, excludes_file);
+	if (!access_or_warn(path, R_OK, 0)) {
+		const unsigned char*ref_sha1 = NULL;
+		struct stat_data   *ref_stat = NULL;
+		unsigned char	   *sha1     = NULL;
+		if (dir->untracked) {
+			sha1	 = dir->info_exclude_sha1;
+			ref_stat = &dir->info_exclude_stat;
+			ref_sha1 = sha1;
+		}
+		add_excludes_from_file_1(dir, path, sha1,
+					 ref_stat, ref_sha1);
+	}
+	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0)) {
+		const unsigned char*ref_sha1 = NULL;
+		struct stat_data   *ref_stat = NULL;
+		unsigned char	   *sha1     = NULL;
+		if (dir->untracked) {
+			sha1	 = dir->excludes_file_sha1;
+			ref_stat = &dir->excludes_file_stat;
+			ref_sha1 = sha1;
+		}
+		add_excludes_from_file_1(dir, excludes_file,
+					 sha1, ref_stat, ref_sha1);
+	}
 }
 
 int remove_path(const char *name)
diff --git a/dir.h b/dir.h
index 6c45e9d..bce7055 100644
--- a/dir.h
+++ b/dir.h
@@ -73,6 +73,63 @@ struct exclude_list_group {
 	struct exclude_list *el;
 };
 
+
+/*
+ *  Untracked cache
+ *
+ *  The following inputs are sufficient to determine what files in a
+ *  directory are excluded:
+ *
+ *   - The list of files and directories of the direction in question
+ *   - The $GIT_DIR/index
+ *   - dir_struct flags
+ *   - The content of $GIT_DIR/info/exclude
+ *   - The content of core.excludesfile
+ *   - The content (or the lack) of .gitignore of all parent directories
+ *     from $GIT_WORK_TREE
+ *   - The check_only flag in read_directory_recursive (for
+ *     DIR_HIDE_EMPTY_DIRECTORIES)
+ *
+ *  The first input can be checked using directory mtime. In many
+ *  filesystems, directory mtime (stat_data field) is updated when its
+ *  files or direct subdirs are added or removed.
+ *
+ *  The second one can be hooked from cache_tree_invalidate_path().
+ *  Whenever a file (or a submodule) is added or removed from a directory,
+ *  we invalidate (i.e. setting untracked_nr to -1) that directory.
+ *
+ *  The remaining inputs are easy, their SHA-1 could be used to verify
+ *  their contents (exclude_sha1[], info_exclude_sha1[] and
+ *  excludes_file_sha1[])
+ */
+struct untracked_cache_dir {
+	struct untracked_cache_dir **dirs;
+	char **untracked;
+	/* null SHA-1 means this directory does not have .gitignore */
+	unsigned char exclude_sha1[20];
+	struct stat_data stat_data;
+	unsigned int check_only : 1;
+	unsigned int untracked_nr : 29;
+	unsigned int untracked_alloc, dirs_nr, dirs_alloc;
+	char name[1];
+};
+
+struct untracked_cache {
+	struct stat_data info_exclude_stat;
+	struct stat_data excludes_file_stat;
+	unsigned char info_exclude_sha1[20];
+	unsigned char excludes_file_sha1[20];
+	const char *exclude_per_dir;
+	/*
+	 * dir_struct#flags must match dir_flags or the untracked
+	 * cache is ignored.
+	 */
+	unsigned dir_flags;
+	struct untracked_cache_dir *root;
+	/* Statistics */
+	int dir_created;
+};
+
 struct dir_struct {
 	int nr, alloc;
 	int ignored_nr, ignored_alloc;
@@ -120,6 +177,13 @@ struct dir_struct {
 	struct exclude_stack *exclude_stack;
 	struct exclude *exclude;
 	struct strbuf basebuf;
+
+	/* Enable untracked file cache if set */
+	struct untracked_cache *untracked;
+	struct stat_data info_exclude_stat;
+	struct stat_data excludes_file_stat;
+	unsigned char info_exclude_sha1[20];
+	unsigned char excludes_file_sha1[20];
 };
 
 /*
-- 
1.9.1.346.ga2b5940
