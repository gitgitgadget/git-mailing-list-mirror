From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC] Speed up "git status" by caching untracked file info
Date: Thu, 17 Apr 2014 12:51:58 +0700
Message-ID: <1397713918-22829-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 07:52:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WafFF-0003cd-4D
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 07:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbaDQFwQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2014 01:52:16 -0400
Received: from mail-ve0-f169.google.com ([209.85.128.169]:60842 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124AbaDQFwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 01:52:15 -0400
Received: by mail-ve0-f169.google.com with SMTP id pa12so12368888veb.28
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 22:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=0L3g49oJp6+wV9nDEBtfZQorbXNsn3xFMcD3s0SFMWc=;
        b=XZLbadbxrzdF8U2pf+8rPAyIHNPfYmjsm5gYbofgERkN1jrsil1Y0b9nWIPpZE7zuq
         DRZn+vTrCgYAWdNl8FsJ43NCoGRhMnWWRF8WzaIr3rhkZWZ2hDQxZ+0D8DqbNhBoKLCu
         SkL5/peunWhrbrfEyLZXYdfrnjF4j2bVRnxe/OIF/wrHmzpzwRerEUjNJzWYTP5rtfMq
         zlJTq/HHFNIzZfSWGGQgslOGrJE8s2ltWuRxFqukQfwOT2JKzXc7V9loo7uwC1G0bDgE
         W/A3yrZLcg8GeZzs5lZ6ExaRZGvgO0w09MYkU/wh++nCTf0rX3g1oOEUgw0T7XINcreS
         d0sQ==
X-Received: by 10.220.10.2 with SMTP id n2mr434111vcn.26.1397713933741;
        Wed, 16 Apr 2014 22:52:13 -0700 (PDT)
Received: from duynguyen-vnpc.dek-tpc.internal.internal ([14.161.32.83])
        by mx.google.com with ESMTPSA id zb18sm21745192vdb.18.2014.04.16.22.52.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Apr 2014 22:52:13 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.346.ga2b5940
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246407>

This patch serves as a heads up about a feature I'm working on. I hope
that by posting it early, people could double check if I have made
some fundamental mistakes that completely ruin the idea. It's about
speeding up "git status" by caching untracked file info in the index
_if_ your file system supports it (more below).

The whole WIP series is at

https://github.com/pclouds/git/commits/untracked-cache

I only post the real meat here. I'm aware of a few incomplete details
in this patch, but nothing fundamentally wrong. So far the numbers are
promising.  ls-files is updated to run fill_directory() twice in a
row and "ls-files -o --directory --no-empty-directory --exclude-standar=
d"
(with gcc -O0) gives me:

           first run  second (cached) run
gentoo-x86    500 ms             71.6  ms
wine          140 ms              9.72 ms
webkit        125 ms              6.88 ms
linux-2.6     106 ms             16.2  ms

Basically untracked time is cut to one tenth in the best case
scenario. The final numbers would be a bit higher because I haven't
stored or read the cache from index yet. Real commit message follows..


read_directory() plays a bit part in the slowness of "git status"
because it has to read every directory and check for excluded entries,
which is really expensive. This patch adds an option to cache the
results so that after the first slow read_directory(), the following
calls should be cheap and fast.

The following inputs are sufficient to determine what files in a
directory are excluded:

 - The list of files and directories of the direction in question
 - The $GIT_DIR/index
 - The content of $GIT_DIR/info/exclude
 - The content of core.excludesfile
 - The content (or the lack) of .gitignore of all parent directories
   from $GIT_WORK_TREE

If we can cheaply validate all those inputs for a certain directory,
we are sure that the current code will always produce the same
results, so we can cache and reuse those results.

This is not a silver bullet approach. When you compile a C file, for
example, the old .o file is removed and a new one with the same name
created, effectively invalidating the containing directory's
cache. But at least with a large enough work tree, there could be many
directories you never touch. The cache could help there.

The first input can be checked using directory mtime. In many
filesystems, directory mtime is updated when direct files/dirs are
added or removed (*). If you do not use such a file system, this
feature is not for you.

The second one can be hooked from read-cache.c. Whenever a file (or a
submodule) is added or removed from a directory, we invalidate that
directory. This will be done in a later patch.

The remaining inputs are easy, their SHA-1 could be used to verify
their contents. We do need to read .gitignore files and digest
them. But they are usually few and small, so the overhead should not
be much.

At the implementation level, the whole directory structure is saved,
each directory corresponds to one struct untracked_dir. Each directory
holds SHA-1 of the .gitignore underneath (or null if it does not
exist) and the list of untracked "files" and subdirs that need to
recurse into if all is well. Untracked subdirectories are saved in the
file queue and are the reason of quoting "files" in the previous
sentence.

On the first run, no untracked_dir is valid, the default code path is
run. prep_exclude() is updated to record SHA-1 of .gitignore along the
way. read_directory_recursive() is updated to record untracked files.

On subsequent runs, read_directory_recursive() reads stat info of the
directory in question and verifies if files/dirs have been added or
removed. With the help of prep_exclude() to verify .gitignore chain,
it may decide "all is well" and enable the fast path in
treat_path(). read_directory_recursive() is still called for
subdirectories even in fast path, because a directory mtime does not
cover all subdirs recursively.

So if all is really well, read_directory() becomes a series of
open(".gitignore"), read(".gitignore"), close(), hash_sha1_file() and
stat(<dir>) _without_ heavyweight exclude filtering. There should be
no overhead if this feature is disabled.

(*) Looking at the code in linux-2.6, ext* family seems to expose this
behavior. vfat also does (but not so sure about fat). btrfs probably
does. statfs() could be used to detect file system.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 336 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-----
 dir.h |  31 ++++++
 2 files changed, 343 insertions(+), 24 deletions(-)

diff --git a/dir.c b/dir.c
index bd58c14..f5d6315 100644
--- a/dir.c
+++ b/dir.c
@@ -31,8 +31,23 @@ enum path_treatment {
 	path_untracked
 };
=20
+struct cached_dir {
+	DIR *fdir;
+	struct untracked_dir *untracked;
+	int nr_files;
+	int nr_dirs;
+
+	/*
+	 * return data from read_cached_dir(). name and state are only
+	 * valid if de is NULL
+	 */
+	struct dirent *de;
+	struct strbuf name;
+	enum path_treatment state;
+};
+
 static enum path_treatment read_directory_recursive(struct dir_struct =
*dir,
-	const char *path, int len,
+	const char *path, int len, struct untracked_dir *untracked,
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path, int len);
=20
@@ -796,6 +811,56 @@ static struct exclude *last_exclude_matching_from_=
lists(struct dir_struct *dir,
 	return NULL;
 }
=20
+static struct untracked_dir *lookup_untracked(struct untracked_dir *di=
r,
+					      const char *name, int len)
+{
+	int first, last;
+	struct untracked_dir *d;
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
+	d =3D xmalloc(sizeof(*d) + len);
+	memset(d, 0, sizeof(*d) + len);
+	d->untracked_nr =3D -1;
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
+static void invalidate_untracked(struct untracked_dir *dir)
+{
+	int i;
+	if (dir->untracked_nr =3D=3D -1)
+		/* it is assumed that all subdirs are already invalidated */
+		return;
+	dir->untracked_nr =3D -1;
+	for (i =3D 0; i < dir->dirs_nr; i++)
+		invalidate_untracked(dir->dirs[i]);
+}
+
 /*
  * Loads the per-directory exclude list for the substring of base
  * which has a char length of baselen.
@@ -805,6 +870,7 @@ static void prep_exclude(struct dir_struct *dir, co=
nst char *base, int baselen)
 	struct exclude_list_group *group;
 	struct exclude_list *el;
 	struct exclude_stack *stk =3D NULL;
+	struct untracked_dir *untracked =3D NULL;
 	int current;
=20
 	group =3D &dir->exclude_list_group[EXC_DIRS];
@@ -842,18 +908,35 @@ static void prep_exclude(struct dir_struct *dir, =
const char *base, int baselen)
 	/* Read from the parent directories and push them down. */
 	current =3D stk ? stk->baselen : -1;
 	strbuf_setlen(&dir->basebuf, current < 0 ? 0 : current);
+
+	if (dir->untracked && current >=3D 0 && current < baselen) {
+		const char *start =3D base;
+		const char *end =3D base + current;
+		untracked =3D &dir->untracked->root;
+		while (start < end) {
+			const char *cp =3D strchrnul(start, '/');
+			untracked =3D lookup_untracked(untracked, start, cp - start);
+			start =3D *cp =3D=3D '/' ? cp + 1 : cp;
+		}
+	}
+
 	while (current < baselen) {
 		struct exclude_stack *stk =3D xcalloc(1, sizeof(*stk));
 		const char *cp;
+		unsigned char sha1[20];
=20
 		if (current < 0) {
 			cp =3D base;
 			current =3D 0;
+			if (dir->untracked)
+				untracked =3D &dir->untracked->root;
 		} else {
 			cp =3D strchr(base + current + 1, '/');
 			if (!cp)
 				die("oops in prep_exclude");
 			cp++;
+			untracked =3D lookup_untracked(untracked, base + current,
+						     cp - base - current);
 		}
 		stk->prev =3D dir->exclude_stack;
 		stk->baselen =3D cp - base;
@@ -880,7 +963,22 @@ static void prep_exclude(struct dir_struct *dir, c=
onst char *base, int baselen)
 		}
=20
 		/* Try to read per-directory file */
-		if (dir->exclude_per_dir) {
+		hashclr(sha1);
+		if (dir->exclude_per_dir &&
+		    /*
+		     * If we know that no files have been added in
+		     * this directory (i.e. valid_cached_dir() has
+		     * been executed and untracked_nr is non-zero) ..
+		     */
+		    (!untracked || untracked->untracked_nr < 0 ||
+		     /*
+		      * .. and .gitignore does not exist before
+		      * (i.e. null exclude_sha1 and skip_worktree is
+		      * not set). Then we can skip loading .gitignore,
+		      * which would result in ENOENT anyway.
+		      * skip_worktree is taken care in read_directory()
+		      */
+		     !is_null_sha1(untracked->exclude_sha1))) {
 			/*
 			 * dir->basebuf gets reused by the traversal, but we
 			 * need fname to remain unchanged to ensure the src
@@ -895,7 +993,13 @@ static void prep_exclude(struct dir_struct *dir, c=
onst char *base, int baselen)
 			el->src =3D strbuf_detach(&sb, NULL);
 			add_excludes_from_file_to_list(el->src, el->src,
 						       stk->baselen, el, 1,
-						       NULL);
+						       untracked ? sha1 : NULL);
+		}
+		if (untracked) {
+			if (untracked->untracked_nr >=3D 0 &&
+			    hashcmp(sha1, untracked->exclude_sha1))
+				invalidate_untracked(untracked);
+			hashcpy(untracked->exclude_sha1, sha1);
 		}
 		dir->exclude_stack =3D stk;
 		current =3D stk->baselen;
@@ -1076,6 +1180,7 @@ static enum exist_status directory_exists_in_inde=
x(const char *dirname, int len)
  *  (c) otherwise, we recurse into it.
  */
 static enum path_treatment treat_directory(struct dir_struct *dir,
+	struct untracked_dir *untracked,
 	const char *dirname, int len, int exclude,
 	const struct path_simplify *simplify)
 {
@@ -1103,7 +1208,9 @@ static enum path_treatment treat_directory(struct=
 dir_struct *dir,
 	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		return exclude ? path_excluded : path_untracked;
=20
-	return read_directory_recursive(dir, dirname, len, 1, simplify);
+	return read_directory_recursive(dir, dirname, len,
+					lookup_untracked(untracked, dirname, len),
+					1, simplify);
 }
=20
 /*
@@ -1219,6 +1326,7 @@ static int get_dtype(struct dirent *de, const cha=
r *path, int len)
 }
=20
 static enum path_treatment treat_one_path(struct dir_struct *dir,
+					  struct untracked_dir *untracked,
 					  struct strbuf *path,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
@@ -1271,7 +1379,7 @@ static enum path_treatment treat_one_path(struct =
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
@@ -1280,13 +1388,28 @@ static enum path_treatment treat_one_path(struc=
t dir_struct *dir,
 }
=20
 static enum path_treatment treat_path(struct dir_struct *dir,
-				      struct dirent *de,
+				      struct untracked_dir *untracked,
+				      struct cached_dir *cdir,
 				      struct strbuf *path,
 				      int baselen,
 				      const struct path_simplify *simplify)
 {
 	int dtype;
+	struct dirent *de =3D cdir->de;
=20
+	/* fast path after verifying cached data is still valid */
+	if (!de) {
+		strbuf_setlen(path, baselen);
+		strbuf_addbuf(path, &cdir->name);
+		/*
+		 * treat_one_path() does this before it calls
+		 * treat_directory()
+		 */
+		if (cdir->state =3D=3D path_recurse &&
+		    path->buf[path->len - 1] !=3D '/')
+			strbuf_addch(path, '/');
+		return cdir->state;
+	}
 	if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
 		return path_none;
 	strbuf_setlen(path, baselen);
@@ -1295,7 +1418,122 @@ static enum path_treatment treat_path(struct di=
r_struct *dir,
 		return path_none;
=20
 	dtype =3D DTYPE(de);
-	return treat_one_path(dir, path, simplify, dtype, de);
+	return treat_one_path(dir, untracked, path, simplify, dtype, de);
+}
+
+static void add_untracked(struct untracked_dir *dir, const char *name)
+{
+	if (!dir)
+		return;
+	if (dir->untracked_nr < 0)
+		dir->untracked_nr =3D 0;
+	ALLOC_GROW(dir->untracked, dir->untracked_nr + 1,
+		   dir->untracked_alloc);
+	dir->untracked[dir->untracked_nr++] =3D xstrdup(name);
+}
+
+static int valid_cached_dir(struct dir_struct *dir,
+			    struct untracked_dir *untracked,
+			    struct strbuf *path)
+{
+	struct stat st;
+	if (stat(path->len ? path->buf : ".", &st)) {
+		memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
+		invalidate_untracked(untracked);
+		return 0;
+	}
+	if (untracked->untracked_nr < 0 ||
+	    match_stat_data(&untracked->stat_data, &st)) {
+		fill_stat_data(&untracked->stat_data, &st);
+		/*
+		 * We could leave subdirs validated if .gitignore is
+		 * not added or removed, but for now just invalidate
+		 * recursively for safety, there's the an assumption
+		 * elsewhere that if dir X is invalidated, then
+		 * everything inside must be invalidated.
+		 */
+		invalidate_untracked(untracked);
+		return 0;
+	}
+
+	/*
+	 * prep_exclude will be called eventually, but it's called
+	 * much later in last_exclude_matching(), deep in
+	 * treat_path(), We need it now to determine the validity of
+	 * the cache. The next call is nearly no-op, the way
+	 * prep_exclude() is designed.
+	 */
+	if (path->len && path->buf[path->len - 1] !=3D '/') {
+		strbuf_addch(path, '/');
+		prep_exclude(dir, path->buf, path->len);
+		strbuf_setlen(path, path->len - 1);
+	} else
+		prep_exclude(dir, path->buf, path->len);
+
+	/* hopefully prep_exclude() will not invalidate this entry... */
+	return untracked->untracked_nr >=3D 0;
+}
+
+static int open_cached_dir(struct cached_dir *cdir,
+			   struct dir_struct *dir,
+			   struct untracked_dir *untracked,
+			   struct strbuf *path)
+{
+	memset(cdir, 0, sizeof(*cdir));
+	strbuf_init(&cdir->name, 100);
+	cdir->untracked =3D untracked;
+	if (!untracked || !valid_cached_dir(dir, untracked, path)) {
+		cdir->fdir =3D opendir(path->len ? path->buf : ".");
+		if (!cdir->fdir)
+			return -1;
+	}
+	return 0;
+}
+
+int read_cached_dir(struct cached_dir *cdir)
+{
+	if (cdir->fdir) {
+		cdir->de =3D readdir(cdir->fdir);
+		if (!cdir->de)
+			return -1;
+		return 0;
+	}
+	if (cdir->nr_files < cdir->untracked->untracked_nr) {
+		struct untracked_dir *d =3D cdir->untracked;
+		strbuf_reset(&cdir->name);
+		strbuf_addstr(&cdir->name, d->untracked[cdir->nr_files]);
+		cdir->nr_files++;
+		cdir->de =3D NULL;
+		cdir->state =3D path_untracked;
+		return 0;
+	}
+	while (cdir->nr_dirs < cdir->untracked->dirs_nr) {
+		struct untracked_dir *d =3D cdir->untracked->dirs[cdir->nr_dirs];
+		if (!d->recurse) {
+			cdir->nr_dirs++;
+			continue;
+		}
+		strbuf_reset(&cdir->name);
+		strbuf_addstr(&cdir->name, d->name);
+		cdir->nr_dirs++;
+		cdir->de =3D NULL;
+		cdir->state =3D path_recurse;
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
+	if (cdir->untracked && cdir->untracked->untracked_nr < 0)
+		cdir->untracked->untracked_nr =3D 0;
+	strbuf_release(&cdir->name);
 }
=20
 /*
@@ -1311,30 +1549,35 @@ static enum path_treatment treat_path(struct di=
r_struct *dir,
  */
 static enum path_treatment read_directory_recursive(struct dir_struct =
*dir,
 				    const char *base, int baselen,
-				    int check_only,
+				    struct untracked_dir *untracked, int check_only,
 				    const struct path_simplify *simplify)
 {
-	DIR *fdir;
+	struct cached_dir cdir;
 	enum path_treatment state, subdir_state, dir_state =3D path_none;
-	struct dirent *de;
 	struct strbuf path =3D STRBUF_INIT;
=20
 	strbuf_add(&path, base, baselen);
=20
-	fdir =3D opendir(path.len ? path.buf : ".");
-	if (!fdir)
+	if (open_cached_dir(&cdir, dir, untracked, &path))
 		goto out;
=20
-	while ((de =3D readdir(fdir)) !=3D NULL) {
+	while (!read_cached_dir(&cdir)) {
 		/* check how the file or directory should be treated */
-		state =3D treat_path(dir, de, &path, baselen, simplify);
+		state =3D treat_path(dir, untracked, &cdir, &path, baselen, simplify=
);
+
 		if (state > dir_state)
 			dir_state =3D state;
=20
 		/* recurse into subdir if instructed by treat_path */
 		if (state =3D=3D path_recurse) {
-			subdir_state =3D read_directory_recursive(dir, path.buf,
-				path.len, check_only, simplify);
+			struct untracked_dir *ud;
+			ud =3D lookup_untracked(untracked, path.buf + baselen,
+					      path.len - baselen);
+			if (ud)
+				ud->recurse =3D 1;
+			subdir_state =3D
+				read_directory_recursive(dir, path.buf, path.len,
+							 ud, check_only, simplify);
 			if (subdir_state > dir_state)
 				dir_state =3D subdir_state;
 		}
@@ -1360,15 +1603,18 @@ static enum path_treatment read_directory_recur=
sive(struct dir_struct *dir,
 			break;
=20
 		case path_untracked:
-			if (!(dir->flags & DIR_SHOW_IGNORED))
-				dir_add_name(dir, path.buf, path.len);
+			if (dir->flags & DIR_SHOW_IGNORED)
+				break;
+			dir_add_name(dir, path.buf, path.len);
+			if (cdir.fdir)
+				add_untracked(untracked, path.buf + baselen);
 			break;
=20
 		default:
 			break;
 		}
 	}
-	closedir(fdir);
+	close_cached_dir(&cdir);
  out:
 	strbuf_release(&path);
=20
@@ -1439,7 +1685,7 @@ static int treat_leading_path(struct dir_struct *=
dir,
 			break;
 		if (simplify_away(sb.buf, sb.len, simplify))
 			break;
-		if (treat_one_path(dir, &sb, simplify,
+		if (treat_one_path(dir, NULL, &sb, simplify,
 				   DT_DIR, NULL) =3D=3D path_none)
 			break; /* do not recurse into it */
 		if (len <=3D baselen) {
@@ -1455,6 +1701,7 @@ static int treat_leading_path(struct dir_struct *=
dir,
 int read_directory(struct dir_struct *dir, const char *path, int len, =
const struct pathspec *pathspec)
 {
 	struct path_simplify *simplify;
+	struct untracked_dir *untracked =3D NULL;
=20
 	/*
 	 * Check out create_simplify()
@@ -1478,8 +1725,47 @@ int read_directory(struct dir_struct *dir, const=
 char *path, int len, const stru
 	 * create_simplify().
 	 */
 	simplify =3D create_simplify(pathspec ? pathspec->_raw : NULL);
-	if (!len || treat_leading_path(dir, path, len, simplify))
-		read_directory_recursive(dir, path, len, 0, simplify);
+	/* dir->untracked->dir_flags =3D DIR_SHOW_OTHER_DIRECTORIES | DIR_HID=
E_EMPTY_DIRECTORIES; */
+	/* if EXC_CMDL is loaded, ignore untracked cache */
+	if ((!pathspec || !pathspec->nr) && dir->untracked &&
+	    dir->flags =3D=3D dir->untracked->dir_flags &&
+	    (dir->exclude_per_dir =3D=3D dir->untracked->exclude_per_dir || /=
* both are NULL? */
+	     !strcmp(dir->exclude_per_dir, dir->untracked->exclude_per_dir)))=
 {
+		int i;
+		untracked =3D &dir->untracked->root;
+		if (hashcmp(dir->info_exclude_sha1,
+			    dir->untracked->info_exclude_sha1)) {
+			invalidate_untracked(untracked);
+			hashcpy(dir->untracked->info_exclude_sha1,
+				dir->info_exclude_sha1);
+		}
+		if (hashcmp(dir->excludes_file_sha1,
+			    dir->untracked->excludes_file_sha1)) {
+			invalidate_untracked(untracked);
+			hashcpy(dir->untracked->excludes_file_sha1,
+				dir->excludes_file_sha1);
+		}
+		untracked->recurse =3D 1;
+
+		/*
+		 * An optimization in prep_exclude() does not play
+		 * well with CE_SKIP_WORKTREE. It's a rare case
+		 * anyway, if a single entry has that bit set, disable
+		 * the whole untracked cache.
+		 */
+		for (i =3D 0; i < active_nr; i++)
+			if (ce_skip_worktree(active_cache[i])) {
+				dir->untracked =3D NULL;
+				untracked =3D NULL;
+				break;
+			}
+	} else
+		/* make sure untracked cache code path is disabled */
+		dir->untracked =3D NULL;
+	if (!len || treat_leading_path(dir, path, len, simplify)) {
+		read_directory_recursive(dir, path, len, untracked,
+					 0, simplify);
+	}
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_=
name);
@@ -1646,9 +1932,11 @@ void setup_standard_excludes(struct dir_struct *=
dir)
 		excludes_file =3D xdg_path;
 	}
 	if (!access_or_warn(path, R_OK, 0))
-		add_excludes_from_file(dir, path, NULL);
+		add_excludes_from_file(dir, path,
+				       dir->untracked ? dir->info_exclude_sha1 : NULL);
 	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
-		add_excludes_from_file(dir, excludes_file, NULL);
+		add_excludes_from_file(dir, excludes_file,
+				       dir->untracked ? dir->excludes_file_sha1 : NULL);
 }
=20
 int remove_path(const char *name)
diff --git a/dir.h b/dir.h
index 71ad8c6..d293744 100644
--- a/dir.h
+++ b/dir.h
@@ -73,6 +73,31 @@ struct exclude_list_group {
 	struct exclude_list *el;
 };
=20
+struct untracked_dir {
+	/* null SHA-1 means this directory does not have .gitignore */
+	unsigned char exclude_sha1[20];
+	struct stat_data stat_data;
+	int recurse;
+	struct untracked_dir **dirs;
+	char **untracked;
+	unsigned dirs_nr, dirs_alloc;
+	/* untracked_nr =3D=3D -1 means this entry is invalid */
+	int untracked_nr, untracked_alloc;
+	char name[1];
+};
+
+struct untracked_cache {
+	unsigned char info_exclude_sha1[20];
+	unsigned char excludes_file_sha1[20];
+	const char *exclude_per_dir;
+	/*
+	 * dir_struct#flags must match dir_flags or the untracked
+	 * cache is ignored.
+	 */
+	unsigned dir_flags;
+	struct untracked_dir root;
+};
+
 struct dir_struct {
 	int nr, alloc;
 	int ignored_nr, ignored_alloc;
@@ -120,6 +145,12 @@ struct dir_struct {
 	struct exclude_stack *exclude_stack;
 	struct exclude *exclude;
 	struct strbuf basebuf;
+
+	/* Enable untracked file cache if set */
+	struct untracked_cache *untracked;
+	/* temporary data for validating untracked->[same field name] */
+	unsigned char info_exclude_sha1[20];
+	unsigned char excludes_file_sha1[20];
 };
=20
 /*
--=20
1.9.1.346.ga2b5940
