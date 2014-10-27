From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/19] untracked cache: record .gitignore information and dir hierarchy
Date: Mon, 27 Oct 2014 19:10:29 +0700
Message-ID: <1414411846-4450-3-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 13:11:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xij8X-0002XJ-OJ
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbaJ0MK5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 08:10:57 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53874 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbaJ0MK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 08:10:56 -0400
Received: by mail-pa0-f46.google.com with SMTP id lf10so3683970pab.5
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 05:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jjYxlKvmWTD0aPjJCLzH25NvR/YYk+LSy6adgw4wxh0=;
        b=vQYxB3sd9zioYaLSDd3kXwcuiwBYrRnjfK/kVsd+gmULHKwx3uKxDSxt7PNN3R114E
         MIE2zU49IKwjmPMk3ADCpIvth/efeRAREzgAnBhmhTnfy6yf88VmYarvI4nhS+7rephJ
         PITVlOAg4fhBo2jks7EdS2XotyJJgEoQaaWerwM9kZB3NmfLn3ZnDTvSCGmOXusnrHrt
         6p3nsRS34UWYgaGywXPfa9kqQm/Whk+Mx9quDNcytVi8BI73CF95R6u3Z79Fe3fjcbm6
         hm3/CADclfmM/e7YCXW8ucqRZSCe39CdtVJEiLoILHB2uMekeqL36wTssYSaKD3kKcM1
         Qeug==
X-Received: by 10.70.103.174 with SMTP id fx14mr24088390pdb.23.1414411856004;
        Mon, 27 Oct 2014 05:10:56 -0700 (PDT)
Received: from lanh ([115.73.192.230])
        by mx.google.com with ESMTPSA id f2sm10798310pdo.29.2014.10.27.05.10.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 05:10:55 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 Oct 2014 19:10:58 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The idea is if we can capture all input and (non-rescursive) output of
read_directory_recursive(), and can verify later that all the input is
the same, then the second r_d_r() should produce the same output as in
the first run.

The requirement for this to work is stat info of a directory MUST
change if an entry is added to or removed from that directory (and
should not change often otherwise). If your OS and filesytem do not
meet this requirement, untracked cache is not for you. Most file
systems on *nix should be fine. On Windows, NTFS is fine while FAT may
be not [1] even though FAT on Linux seems to be fine.

The list of input of r_d_r() is in the big comment block in dir.h. In
short, the output of a directory (not counting subdirs) mainly depends
on stat info of the directory in question, all .gitignore leading to
it and the check_only flag when r_d_r() is called recursively. This
patch records all this info (and the output) as r_d_r() runs.

Two hash_sha1_file() are required for $GIT_DIR/info/exclude and
core.excludesfile unless their stat data matches. hash_sha1_file() is
only needed when .gitignore files in the worktree are modified,
otherwise their SHA-1 in index is used (see the previous patch).

We could store stat data for .gitignore files so we don't have to
rehash them if their content is different from index, but I think
=2Egitignore files are rarely modified, so not worth extra cache data
(and hashing penalty read-cache.c:verify_hdr(), as we will be storing
this as an index extension).

The implication is, if you change .gitignore, you better add it to the
index soon or you lose all the benefit of untracked cache because a
modified .gitignore invalidates all subdirs recursively. This is
especially bad for .gitignore at root.

This cached output is about untracked files only, not ignored files
because the number of tracked files is usually small, so small cache
overhead, while the number of ignored files could go really high
(e.g. *.o files mixing with source code).

[1] "Description of NTFS date and time stamps for files and folders"
    http://support.microsoft.com/kb/299648

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--=
--------
 dir.h |  60 +++++++++++++++++++++++++++
 2 files changed, 189 insertions(+), 21 deletions(-)

diff --git a/dir.c b/dir.c
index 33a35c1..25d8c5d 100644
--- a/dir.c
+++ b/dir.c
@@ -32,7 +32,7 @@ enum path_treatment {
 };
=20
 static enum path_treatment read_directory_recursive(struct dir_struct =
*dir,
-	const char *path, int len,
+	const char *path, int len, struct untracked_cache_dir *untracked,
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path, int len);
=20
@@ -535,6 +535,53 @@ static void trim_trailing_spaces(char *buf)
 }
=20
 /*
+ * Given a subdirectory name and "dir" of the current directory,
+ * search the subdir in "dir" and return it, or create a new one if it
+ * does not exist in "dir".
+ *
+ * If "name" has the trailing slash, it'll be excluded in the search.
+ */
+static struct untracked_cache_dir *lookup_untracked(struct untracked_c=
ache *uc,
+						    struct untracked_cache_dir *dir,
+						    const char *name, int len)
+{
+	int first, last;
+	struct untracked_cache_dir *d;
+	if (!dir)
+		return NULL;
+	if (len && name[len - 1] =3D=3D '/')
+		len--;
+	first =3D 0;
+	last =3D dir->dirs_nr;
+	while (last > first) {
+		int cmp, next =3D (last + first) >> 1;
+		d =3D dir->dirs[next];
+		cmp =3D strncmp(name, d->name, len);
+		if (!cmp && strlen(d->name) > len)
+			cmp =3D -1;
+		if (!cmp)
+			return d;
+		if (cmp < 0) {
+			last =3D next;
+			continue;
+		}
+		first =3D next+1;
+	}
+
+	uc->dir_created++;
+	d =3D xmalloc(sizeof(*d) + len);
+	memset(d, 0, sizeof(*d) + len);
+	memcpy(d->name, name, len);
+
+	ALLOC_GROW(dir->dirs, dir->dirs_nr + 1, dir->dirs_alloc);
+	memmove(dir->dirs + first + 1, dir->dirs + first,
+		(dir->dirs_nr - first) * sizeof(*dir->dirs));
+	dir->dirs_nr++;
+	dir->dirs[first] =3D d;
+	return d;
+}
+
+/*
  * Given a file with name "fname", read it (either from disk, or from
  * the index if "check_index" is non-zero), parse it and store the
  * exclude rules in "el".
@@ -642,14 +689,20 @@ struct exclude_list *add_exclude_list(struct dir_=
struct *dir,
 /*
  * Used to set up core.excludesfile and .git/info/exclude lists.
  */
-void add_excludes_from_file(struct dir_struct *dir, const char *fname)
+static void add_excludes_from_file_1(struct dir_struct *dir, const cha=
r *fname,
+				     struct sha1_stat *ss, int ss_valid)
 {
 	struct exclude_list *el;
 	el =3D add_exclude_list(dir, EXC_FILE, fname);
-	if (add_excludes_from_file_to_list(fname, "", 0, el, 0) < 0)
+	if (add_excludes(fname, "", 0, el, 0, ss, ss_valid) < 0)
 		die("cannot use %s as an exclude file", fname);
 }
=20
+void add_excludes_from_file(struct dir_struct *dir, const char *fname)
+{
+	add_excludes_from_file_1(dir, fname, NULL, 0);
+}
+
 int match_basename(const char *basename, int basenamelen,
 		   const char *pattern, int prefix, int patternlen,
 		   int flags)
@@ -824,6 +877,7 @@ static void prep_exclude(struct dir_struct *dir, co=
nst char *base, int baselen)
 	struct exclude_list_group *group;
 	struct exclude_list *el;
 	struct exclude_stack *stk =3D NULL;
+	struct untracked_cache_dir *untracked;
 	int current;
=20
 	group =3D &dir->exclude_list_group[EXC_DIRS];
@@ -861,9 +915,15 @@ static void prep_exclude(struct dir_struct *dir, c=
onst char *base, int baselen)
 	/* Read from the parent directories and push them down. */
 	current =3D stk ? stk->baselen : -1;
 	strbuf_setlen(&dir->basebuf, current < 0 ? 0 : current);
+	if (dir->untracked)
+		untracked =3D stk ? stk->ucd : dir->untracked->root;
+	else
+		untracked =3D NULL;
+
 	while (current < baselen) {
 		struct exclude_stack *stk =3D xcalloc(1, sizeof(*stk));
 		const char *cp;
+		struct sha1_stat ss;
=20
 		if (current < 0) {
 			cp =3D base;
@@ -873,10 +933,15 @@ static void prep_exclude(struct dir_struct *dir, =
const char *base, int baselen)
 			if (!cp)
 				die("oops in prep_exclude");
 			cp++;
+			untracked =3D
+				lookup_untracked(dir->untracked, untracked,
+						 base + current,
+						 cp - base - current);
 		}
 		stk->prev =3D dir->exclude_stack;
 		stk->baselen =3D cp - base;
 		stk->exclude_ix =3D group->nr;
+		stk->ucd =3D untracked;
 		el =3D add_exclude_list(dir, EXC_DIRS, NULL);
 		strbuf_add(&dir->basebuf, base + current, stk->baselen - current);
 		assert(stk->baselen =3D=3D dir->basebuf.len);
@@ -899,6 +964,7 @@ static void prep_exclude(struct dir_struct *dir, co=
nst char *base, int baselen)
 		}
=20
 		/* Try to read per-directory file */
+		hashclr(ss.sha1);
 		if (dir->exclude_per_dir) {
 			/*
 			 * dir->basebuf gets reused by the traversal, but we
@@ -912,8 +978,11 @@ static void prep_exclude(struct dir_struct *dir, c=
onst char *base, int baselen)
 			strbuf_addbuf(&sb, &dir->basebuf);
 			strbuf_addstr(&sb, dir->exclude_per_dir);
 			el->src =3D strbuf_detach(&sb, NULL);
-			add_excludes_from_file_to_list(el->src, el->src,
-						       stk->baselen, el, 1);
+			add_excludes(el->src, el->src, stk->baselen, el, 1,
+				     untracked ? &ss : NULL, 0);
+		}
+		if (untracked) {
+			hashcpy(untracked->exclude_sha1, ss.sha1);
 		}
 		dir->exclude_stack =3D stk;
 		current =3D stk->baselen;
@@ -1094,6 +1163,7 @@ static enum exist_status directory_exists_in_inde=
x(const char *dirname, int len)
  *  (c) otherwise, we recurse into it.
  */
 static enum path_treatment treat_directory(struct dir_struct *dir,
+	struct untracked_cache_dir *untracked,
 	const char *dirname, int len, int exclude,
 	const struct path_simplify *simplify)
 {
@@ -1121,7 +1191,9 @@ static enum path_treatment treat_directory(struct=
 dir_struct *dir,
 	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		return exclude ? path_excluded : path_untracked;
=20
-	return read_directory_recursive(dir, dirname, len, 1, simplify);
+	untracked =3D lookup_untracked(dir->untracked, untracked, dirname, le=
n);
+	return read_directory_recursive(dir, dirname, len,
+					untracked, 1, simplify);
 }
=20
 /*
@@ -1237,6 +1309,7 @@ static int get_dtype(struct dirent *de, const cha=
r *path, int len)
 }
=20
 static enum path_treatment treat_one_path(struct dir_struct *dir,
+					  struct untracked_cache_dir *untracked,
 					  struct strbuf *path,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
@@ -1289,7 +1362,7 @@ static enum path_treatment treat_one_path(struct =
dir_struct *dir,
 		return path_none;
 	case DT_DIR:
 		strbuf_addch(path, '/');
-		return treat_directory(dir, path->buf, path->len, exclude,
+		return treat_directory(dir, untracked, path->buf, path->len, exclude=
,
 			simplify);
 	case DT_REG:
 	case DT_LNK:
@@ -1298,6 +1371,7 @@ static enum path_treatment treat_one_path(struct =
dir_struct *dir,
 }
=20
 static enum path_treatment treat_path(struct dir_struct *dir,
+				      struct untracked_cache_dir *untracked,
 				      struct dirent *de,
 				      struct strbuf *path,
 				      int baselen,
@@ -1313,7 +1387,16 @@ static enum path_treatment treat_path(struct dir=
_struct *dir,
 		return path_none;
=20
 	dtype =3D DTYPE(de);
-	return treat_one_path(dir, path, simplify, dtype, de);
+	return treat_one_path(dir, untracked, path, simplify, dtype, de);
+}
+
+static void add_untracked(struct untracked_cache_dir *dir, const char =
*name)
+{
+	if (!dir)
+		return;
+	ALLOC_GROW(dir->untracked, dir->untracked_nr + 1,
+		   dir->untracked_alloc);
+	dir->untracked[dir->untracked_nr++] =3D xstrdup(name);
 }
=20
 /*
@@ -1329,7 +1412,7 @@ static enum path_treatment treat_path(struct dir_=
struct *dir,
  */
 static enum path_treatment read_directory_recursive(struct dir_struct =
*dir,
 				    const char *base, int baselen,
-				    int check_only,
+				    struct untracked_cache_dir *untracked, int check_only,
 				    const struct path_simplify *simplify)
 {
 	DIR *fdir;
@@ -1343,24 +1426,36 @@ static enum path_treatment read_directory_recur=
sive(struct dir_struct *dir,
 	if (!fdir)
 		goto out;
=20
+	if (untracked)
+		untracked->check_only =3D !!check_only;
+
 	while ((de =3D readdir(fdir)) !=3D NULL) {
 		/* check how the file or directory should be treated */
-		state =3D treat_path(dir, de, &path, baselen, simplify);
+		state =3D treat_path(dir, untracked, de, &path, baselen, simplify);
+
 		if (state > dir_state)
 			dir_state =3D state;
=20
 		/* recurse into subdir if instructed by treat_path */
 		if (state =3D=3D path_recurse) {
-			subdir_state =3D read_directory_recursive(dir, path.buf,
-				path.len, check_only, simplify);
+			struct untracked_cache_dir *ud;
+			ud =3D lookup_untracked(dir->untracked, untracked,
+					      path.buf + baselen,
+					      path.len - baselen);
+			subdir_state =3D
+				read_directory_recursive(dir, path.buf, path.len,
+							 ud, check_only, simplify);
 			if (subdir_state > dir_state)
 				dir_state =3D subdir_state;
 		}
=20
 		if (check_only) {
 			/* abort early if maximum state has been reached */
-			if (dir_state =3D=3D path_untracked)
+			if (dir_state =3D=3D path_untracked) {
+				if (untracked)
+					add_untracked(untracked, path.buf + baselen);
 				break;
+			}
 			/* skip the dir_add_* part */
 			continue;
 		}
@@ -1378,8 +1473,11 @@ static enum path_treatment read_directory_recurs=
ive(struct dir_struct *dir,
 			break;
=20
 		case path_untracked:
-			if (!(dir->flags & DIR_SHOW_IGNORED))
-				dir_add_name(dir, path.buf, path.len);
+			if (dir->flags & DIR_SHOW_IGNORED)
+				break;
+			dir_add_name(dir, path.buf, path.len);
+			if (untracked)
+				add_untracked(untracked, path.buf + baselen);
 			break;
=20
 		default:
@@ -1456,7 +1554,7 @@ static int treat_leading_path(struct dir_struct *=
dir,
 			break;
 		if (simplify_away(sb.buf, sb.len, simplify))
 			break;
-		if (treat_one_path(dir, &sb, simplify,
+		if (treat_one_path(dir, NULL, &sb, simplify,
 				   DT_DIR, NULL) =3D=3D path_none)
 			break; /* do not recurse into it */
 		if (len <=3D baselen) {
@@ -1496,7 +1594,9 @@ int read_directory(struct dir_struct *dir, const =
char *path, int len, const stru
 	 */
 	simplify =3D create_simplify(pathspec ? pathspec->_raw : NULL);
 	if (!len || treat_leading_path(dir, path, len, simplify))
-		read_directory_recursive(dir, path, len, 0, simplify);
+		read_directory_recursive(dir, path, len,
+					 dir->untracked ? dir->untracked->root : NULL,
+					 0, simplify);
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_=
name);
@@ -1666,10 +1766,18 @@ void setup_standard_excludes(struct dir_struct =
*dir)
 		home_config_paths(NULL, &xdg_path, "ignore");
 		excludes_file =3D xdg_path;
 	}
-	if (!access_or_warn(path, R_OK, 0))
-		add_excludes_from_file(dir, path);
-	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
-		add_excludes_from_file(dir, excludes_file);
+	if (!access_or_warn(path, R_OK, 0)) {
+		struct sha1_stat *ss =3D NULL;
+		if (dir->untracked)
+			ss =3D &dir->ss_info_exclude;
+		add_excludes_from_file_1(dir, path, ss, 0);
+	}
+	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0)) {
+		struct sha1_stat *ss =3D NULL;
+		if (dir->untracked)
+			ss =3D &dir->ss_excludes_file;
+		add_excludes_from_file_1(dir, excludes_file, ss, 0);
+	}
 }
=20
 int remove_path(const char *name)
diff --git a/dir.h b/dir.h
index 032d197..f282501 100644
--- a/dir.h
+++ b/dir.h
@@ -66,6 +66,7 @@ struct exclude_stack {
 	struct exclude_stack *prev; /* the struct exclude_stack for the paren=
t directory */
 	int baselen;
 	int exclude_ix; /* index of exclude_list within EXC_DIRS exclude_list=
_group */
+	struct untracked_cache_dir *ucd;
 };
=20
 struct exclude_list_group {
@@ -78,6 +79,60 @@ struct sha1_stat {
 	unsigned char sha1[20];
 };
=20
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
+ *   - The content (or the lack) of .gitignore of all parent directori=
es
+ *     from $GIT_WORK_TREE
+ *   - The check_only flag in read_directory_recursive (for
+ *     DIR_HIDE_EMPTY_DIRECTORIES)
+ *
+ *  The first input can be checked using directory mtime. In many
+ *  filesystems, directory mtime (stat_data field) is updated when its
+ *  files or direct subdirs are added or removed.
+ *
+ *  The second one can be hooked from cache_tree_invalidate_path().
+ *  Whenever a file (or a submodule) is added or removed from a
+ *  directory, we invalidate that directory.
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
+	struct sha1_stat ss_info_exclude;
+	struct sha1_stat ss_excludes_file;
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
@@ -125,6 +180,11 @@ struct dir_struct {
 	struct exclude_stack *exclude_stack;
 	struct exclude *exclude;
 	struct strbuf basebuf;
+
+	/* Enable untracked file cache if set */
+	struct untracked_cache *untracked;
+	struct sha1_stat ss_info_exclude;
+	struct sha1_stat ss_excludes_file;
 };
=20
 /*
--=20
2.1.0.rc0.78.gc0d8480
