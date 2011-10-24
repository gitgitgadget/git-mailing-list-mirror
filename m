From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 10/11] read-dir: stop using path_simplify code in favor of tree_entry_interesting()
Date: Mon, 24 Oct 2011 17:36:15 +1100
Message-ID: <1319438176-7304-11-git-send-email-pclouds@gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 08:39:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIECM-00012H-OI
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 08:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab1JXGjq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 02:39:46 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47409 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab1JXGjp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 02:39:45 -0400
Received: by mail-gy0-f174.google.com with SMTP id 13so5420704gyb.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 23:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eMB++6ABsCcKrYpuzUp84aIHDd08t4S+HCzgNZzzDiE=;
        b=kp2D7TxQTsaNJBHI31yLc2dqCv2cm4OrfIkjTGY9K9ygcakcA08z6Peq+20fCvnsHd
         6ysSzS7fiXwuood+HJ8tWFNzu32n1fSsuzVk2hWAMbW8y3UaP0H3YpzKki5hePx7hYrV
         hbeBrOUVWieHBa2lq5uqFCon77DTY2+U8rHOA=
Received: by 10.236.79.103 with SMTP id h67mr32119394yhe.122.1319438384654;
        Sun, 23 Oct 2011 23:39:44 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id j25sm31201338yhm.12.2011.10.23.23.39.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 23:39:43 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 24 Oct 2011 17:38:01 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184163>

Current code tries to find a prefix set of given pathspecs and filter
on the set. Call sites are supposed to do exact pathspec matching
again to remove unmatched entries (but matches the prefix set).

This patch makes read_directory() use tree_entry_interesting()
directly, thus remove the need to filter again by call sites (although
call sites are untouched in this patch).

A less intrusive way would be to use match_pathspec_depth(), but I'd
rather reduce the use of that function and eventually remove it, so we
only have to maintain pathspec matching at one place:
tree_entry_interesting().

In order to make use of tree_entry_interesting(), directory content
from readdir() must be converted to tree object format, which means we
have to read all items of a directory at once and sort it. If the
directory is large, it may become expensive operation. But again,
current code does nothing to stop reading directory early, so nothing
is lost.

ignored_nr and ignored[] are not longer filled. read_directory() users
are supposed to use useful[] instead.

Many functions are left unused in this patch to avoid clutter up the
patch. They will be removed later.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c |   22 +++--
 dir.c         |  317 ++++++++++++++++++++++++++++++++++++++-----------=
--------
 dir.h         |    5 +
 tree-walk.c   |    2 +
 4 files changed, 236 insertions(+), 110 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 23ad4b8..92ba3d4 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -307,7 +307,7 @@ static int edit_patch(int argc, const char **argv, =
const char *prefix)
 static struct lock_file lock_file;
=20
 static const char ignore_error[] =3D
-N_("The following paths are ignored by one of your .gitignore files:\n=
");
+N_("The following pathspecs are ignored by one of your .gitignore file=
s:\n");
=20
 static int verbose =3D 0, show_only =3D 0, ignored_too =3D 0, refresh_=
only =3D 0;
 static int ignore_add_errors, addremove, intent_to_add;
@@ -342,12 +342,20 @@ static int add_files(struct dir_struct *dir, int =
flags)
 {
 	int i, exit_status =3D 0;
=20
-	if (dir->ignored_nr) {
-		fprintf(stderr, _(ignore_error));
-		for (i =3D 0; i < dir->ignored_nr; i++)
-			fprintf(stderr, "%s\n", dir->ignored[i]->name);
-		fprintf(stderr, _("Use -f if you really want to add them.\n"));
-		die(_("no files added"));
+	if (dir->useful) {
+		int show_header =3D 0;
+		for (i =3D 0; i < dir->ps2.nr; i++)
+			if (!dir->useful[i]) {
+				if (!show_header) {
+					fprintf(stderr, _(ignore_error));
+					show_header =3D 1;
+				}
+				fprintf(stderr, "%s\n", dir->ps2.items[i].match);
+			}
+		if (show_header) {
+			fprintf(stderr, _("Use -f if you really want to add them.\n"));
+			die(_("no files added"));
+		}
 	}
=20
 	for (i =3D 0; i < dir->nr; i++)
diff --git a/dir.c b/dir.c
index 0a78d00..2946b2d 100644
--- a/dir.c
+++ b/dir.c
@@ -8,14 +8,18 @@
 #include "cache.h"
 #include "dir.h"
 #include "refs.h"
+#include "tree-walk.h"
+#include "string-list.h"
=20
 struct path_simplify {
 	int len;
 	const char *path;
 };
=20
-static int read_directory_recursive(struct dir_struct *dir, const char=
 *path, int len,
-	int check_only, const struct path_simplify *simplify);
+static int read_directory_recursive(struct dir_struct *dir,
+				    struct strbuf *base,
+				    int check_only,
+				    enum interesting match);
 static int get_dtype(struct dirent *de, const char *path, int len);
=20
 /* helper string functions with support for the ignore_case flag */
@@ -609,6 +613,93 @@ struct dir_entry *dir_add_ignored(struct dir_struc=
t *dir, const char *pathname,
 	return dir->ignored[dir->ignored_nr++] =3D dir_entry_new(pathname, le=
n);
 }
=20
+/* Read and convert directory to tree object (with invalid SHA-1) */
+static void* dir_to_tree(struct strbuf *path, unsigned long *size)
+{
+	int pathlen =3D path->len;
+	DIR *fdir =3D opendir(pathlen ? path->buf : ".");
+	struct string_list paths =3D STRING_LIST_INIT_DUP;
+	struct dirent *de;
+	char *tree, *p;
+	int i,dtype;
+
+	if (!fdir)
+		return NULL;
+
+	*size =3D 0;
+	while ((de =3D readdir(fdir)) !=3D NULL) {
+		int namelen =3D strlen(de->d_name);
+		struct string_list_item *item;
+		const char *mode =3D NULL;
+
+		if (is_dot_or_dotdot(de->d_name) ||
+		    !strcmp(de->d_name, ".git") ||
+		    /* Ignore overly long pathnames! */
+		    namelen + pathlen + 8 > PATH_MAX)
+			continue;
+
+		strbuf_add(path, de->d_name, namelen);
+		dtype =3D get_dtype(de, path->buf, path->len);
+		strbuf_setlen(path, pathlen);
+
+		switch (dtype) {
+		case DT_DIR: mode =3D "040000 "; break;
+		case DT_REG: mode =3D "100644 "; break;
+		case DT_LNK: mode =3D "120000 "; break;
+		default: continue;
+		}
+		item =3D string_list_insert(&paths, de->d_name);
+		item->util =3D (void*)mode;
+		/* 100644 SPC path NUL SHA-1 */
+		*size +=3D 6 + 1 + namelen + 1 + 20;
+	}
+	closedir(fdir);
+
+	tree =3D xmalloc(*size);
+	for (i =3D 0, p =3D tree;i < paths.nr; i++) {
+		int len =3D strlen(paths.items[i].string) + 1;
+		if (!paths.items[i].util ||
+		    strlen(paths.items[i].util) !=3D 7)
+			die("BUG: util should contain a mode");
+		memcpy(p, paths.items[i].util, 7);
+		p +=3D 7;
+		memcpy(p, paths.items[i].string, len);
+		p +=3D len;
+		/* we don't need valid SHA-1 for tree_entry_interesting() */
+		memcpy(p, "\xbb\xaa\xdd\xbb\xaa\xdd\xbb\xaa\xdd", 9);
+		p +=3D 20;
+	}
+	string_list_clear(&paths, 0);
+	return tree;
+}
+
+static enum interesting match_both_pathspecs(struct dir_struct *dir,
+					     struct strbuf *base,
+					     const struct name_entry *ne)
+{
+	int i;
+	enum interesting ret1, ret2;
+
+	/* ps1 contains the base path, no need to care about it */
+	for (i =3D 0; i < dir->ps2.nr; i++)
+		dir->ps2.items[i].useful =3D 0;
+
+	ret1 =3D tree_entry_interesting(ne, base, 0, &dir->ps1);
+	if (ret1 <=3D 0)
+		return ret1;
+	ret2 =3D tree_entry_interesting(ne, base, 0, &dir->ps2);
+	if (ret2 <=3D 0)
+		return ret2;
+
+	if (ret1 =3D=3D all_entries_interesting && ret2 =3D=3D all_entries_in=
teresting)
+		return all_entries_interesting;
+	else if ((ret1 =3D=3D entry_matched || ret1 =3D=3D all_entries_intere=
sting) &&
+		 (ret2 =3D=3D entry_matched || ret2 =3D=3D all_entries_interesting))
+		return entry_matched;
+	else
+		return entry_interesting;
+}
+
 enum exist_status {
 	index_nonexistent =3D 0,
 	index_directory,
@@ -722,11 +813,10 @@ enum directory_treatment {
 };
=20
 static enum directory_treatment treat_directory(struct dir_struct *dir=
,
-	const char *dirname, int len,
-	const struct path_simplify *simplify)
+						struct strbuf *dirname)
 {
 	/* The "len-1" is to strip the final '/' */
-	switch (directory_exists_in_index(dirname, len-1)) {
+	switch (directory_exists_in_index(dirname->buf, dirname->len-1)) {
 	case index_directory:
 		return recurse_into_directory;
=20
@@ -740,7 +830,7 @@ static enum directory_treatment treat_directory(str=
uct dir_struct *dir,
 			break;
 		if (!(dir->flags & DIR_NO_GITLINKS)) {
 			unsigned char sha1[20];
-			if (resolve_gitlink_ref(dirname, "HEAD", sha1) =3D=3D 0)
+			if (resolve_gitlink_ref(dirname->buf, "HEAD", sha1) =3D=3D 0)
 				return show_directory;
 		}
 		return recurse_into_directory;
@@ -749,7 +839,7 @@ static enum directory_treatment treat_directory(str=
uct dir_struct *dir,
 	/* This is the "show_other_directories" case */
 	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		return show_directory;
-	if (!read_directory_recursive(dir, dirname, len, 1, simplify))
+	if (!read_directory_recursive(dir, dirname, 1, entry_not_interesting)=
)
 		return ignore_directory;
 	return show_directory;
 }
@@ -780,31 +870,35 @@ static int simplify_away(const char *path, int pa=
thlen, const struct path_simpli
 }
=20
 /*
- * This function tells us whether an excluded path matches a
- * list of "interesting" pathspecs. That is, whether a path matched
- * by any of the pathspecs could possibly be ignored by excluding
- * the specified path. This can happen if:
+ * This function flags pathspecs that are completely excluded, which
+ * usually means an input mistake. In other words, if all matched
+ * _files_ of a pathspec are excluded, flag the pathspec.
  *
- *   1. the path is mentioned explicitly in the pathspec
+ * The negated version would be: if any of matched files (by pathspec
+ * X) are not excluded, pathspec X is clear, which is exactly what
+ * this function does.
  *
- *   2. the path is a directory prefix of some element in the
- *      pathspec
+ * This function ignores dir->ps1 because that contains exactly one
+ * pathspec item: the path base. No need to worry about that.
  */
-static int exclude_matches_pathspec(const char *path, int len,
-		const struct path_simplify *simplify)
+static void mark_useful(struct dir_struct *dir,
+			const char *path, int len,
+			int dtype,
+			struct pathspec *ps, int exclude,
+			enum interesting match)
 {
-	if (simplify) {
-		for (; simplify->path; simplify++) {
-			if (len =3D=3D simplify->len
-			    && !memcmp(path, simplify->path, len))
-				return 1;
-			if (len < simplify->len
-			    && simplify->path[len] =3D=3D '/'
-			    && !memcmp(path, simplify->path, len))
-				return 1;
-		}
-	}
-	return 0;
+	int i;
+	if (!(dir->flags & DIR_COLLECT_IGNORED))
+		return;
+	/* half-matches (eg. prefix matches) do not count as useful */
+	if (match !=3D all_entries_interesting && match !=3D entry_matched)
+		return;
+	if (exclude && cache_name_is_other(path, len))
+		return;
+
+	for (i =3D 0; i < ps->nr; i++)
+		if (ps->items[i].useful)
+			dir->useful[i] =3D 1;
 }
=20
 static int get_index_dtype(const char *path, int len)
@@ -872,15 +966,24 @@ enum path_treatment {
 	path_recurse
 };
=20
-static enum path_treatment treat_one_path(struct dir_struct *dir,
-					  char *path, int *len,
-					  const struct path_simplify *simplify,
-					  int dtype, struct dirent *de)
+/* base is modified to contain ne */
+static int treat_path(struct dir_struct *dir,
+		      struct strbuf *base, const struct name_entry *ne,
+		      enum interesting match)
 {
-	int exclude =3D excluded(dir, path, &dtype);
-	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
-	    && exclude_matches_pathspec(path, *len, simplify))
-		dir_add_ignored(dir, path, *len);
+	int exclude, dtype;
+
+	strbuf_add(base, ne->path, tree_entry_len(ne));
+
+	/* It does not matter DT_REG or something else, excluded()
+	 * only cares if it's DT_DIR or not */
+	dtype =3D S_ISDIR(ne->mode) ? DT_DIR : DT_REG;
+	exclude =3D excluded(dir, base->buf, &dtype);
+
+	/* intermediate directory match does not count */
+	if (dtype =3D=3D DT_REG)
+		mark_useful(dir, base->buf, base->len, dtype,
+				       &dir->ps2, exclude, match);
=20
 	/*
 	 * Excluded? If we don't explicitly want to show
@@ -889,9 +992,6 @@ static enum path_treatment treat_one_path(struct di=
r_struct *dir,
 	if (exclude && !(dir->flags & DIR_SHOW_IGNORED))
 		return path_ignored;
=20
-	if (dtype =3D=3D DT_UNKNOWN)
-		dtype =3D get_dtype(de, path, *len);
-
 	/*
 	 * Do we want to see just the ignored files?
 	 * We still need to recurse into directories,
@@ -899,17 +999,13 @@ static enum path_treatment treat_one_path(struct =
dir_struct *dir,
 	 * directory may contain files that we do..
 	 */
 	if (!exclude && (dir->flags & DIR_SHOW_IGNORED)) {
-		if (dtype !=3D DT_DIR)
+		if (!S_ISDIR(ne->mode))
 			return path_ignored;
 	}
=20
-	switch (dtype) {
-	default:
-		return path_ignored;
-	case DT_DIR:
-		memcpy(path + *len, "/", 2);
-		(*len)++;
-		switch (treat_directory(dir, path, *len, simplify)) {
+	if (S_ISDIR(ne->mode)) {
+		strbuf_addch(base, '/');
+		switch (treat_directory(dir, base)) {
 		case show_directory:
 			if (exclude !=3D !!(dir->flags
 					  & DIR_SHOW_IGNORED))
@@ -920,38 +1016,14 @@ static enum path_treatment treat_one_path(struct=
 dir_struct *dir,
 		case ignore_directory:
 			return path_ignored;
 		}
-		break;
-	case DT_REG:
-	case DT_LNK:
-		break;
+
+		/* path_handled for dirs, must be gitlinks */
+		mark_useful(dir, base->buf, base->len, dtype,
+				       &dir->ps2, exclude, match);
 	}
 	return path_handled;
 }
=20
-static enum path_treatment treat_path(struct dir_struct *dir,
-				      struct dirent *de,
-				      char *path, int path_max,
-				      int baselen,
-				      const struct path_simplify *simplify,
-				      int *len)
-{
-	int dtype;
-
-	if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
-		return path_ignored;
-	*len =3D strlen(de->d_name);
-	/* Ignore overly long pathnames! */
-	if (*len + baselen + 8 > path_max)
-		return path_ignored;
-	memcpy(path + baselen, de->d_name, *len + 1);
-	*len +=3D baselen;
-	if (simplify_away(path, *len, simplify))
-		return path_ignored;
-
-	dtype =3D DTYPE(de);
-	return treat_one_path(dir, path, len, simplify, dtype, de);
-}
-
 /*
  * Read a directory tree. We currently ignore anything but
  * directories, regular files and symlinks. That's because git
@@ -962,40 +1034,46 @@ static enum path_treatment treat_path(struct dir=
_struct *dir,
  * That likely will not change.
  */
 static int read_directory_recursive(struct dir_struct *dir,
-				    const char *base, int baselen,
+				    struct strbuf *base,
 				    int check_only,
-				    const struct path_simplify *simplify)
+				    enum interesting match)
 {
-	DIR *fdir =3D opendir(*base ? base : ".");
-	int contents =3D 0;
-	struct dirent *de;
-	char path[PATH_MAX + 1];
+	unsigned long size;
+	void *tree_buf =3D dir_to_tree(base, &size);
+	int contents =3D 0, baselen =3D base->len;
+	struct tree_desc desc;
+	struct name_entry ne;
=20
-	if (!fdir)
+	if (!tree_buf)
 		return 0;
=20
-	memcpy(path, base, baselen);
+	init_tree_desc(&desc, tree_buf, size);
=20
-	while ((de =3D readdir(fdir)) !=3D NULL) {
-		int len;
-		switch (treat_path(dir, de, path, sizeof(path),
-				   baselen, simplify, &len)) {
+	while (tree_entry(&desc, &ne)) {
+		strbuf_setlen(base, baselen);
+		if (match !=3D all_entries_interesting) {
+			match =3D match_both_pathspecs(dir, base, &ne);
+			if (match =3D=3D all_entries_not_interesting)
+				break;
+			if (match =3D=3D entry_not_interesting)
+				continue;
+		}
+		switch (treat_path(dir, base, &ne, match)) {
 		case path_recurse:
-			contents +=3D read_directory_recursive(dir, path, len, 0, simplify)=
;
-			continue;
-		case path_ignored:
+			contents +=3D read_directory_recursive(dir, base, 0, match);
 			continue;
 		case path_handled:
+			contents++;
+			if (check_only)
+				goto exit_early;
+
+			dir_add_name(dir, base->buf, base->len);
 			break;
 		}
-		contents++;
-		if (check_only)
-			goto exit_early;
-		else
-			dir_add_name(dir, path, len);
 	}
 exit_early:
-	closedir(fdir);
+	free(tree_buf);
+	strbuf_setlen(base, baselen);
=20
 	return contents;
 }
@@ -1054,6 +1132,7 @@ static void free_simplify(struct path_simplify *s=
implify)
 	free(simplify);
 }
=20
+#if 0
 static int treat_leading_path(struct dir_struct *dir,
 			      const char *path, int len,
 			      const struct path_simplify *simplify)
@@ -1088,20 +1167,52 @@ static int treat_leading_path(struct dir_struct=
 *dir,
 			return 1; /* finished checking */
 	}
 }
+#endif
=20
-int read_directory(struct dir_struct *dir, const char *path, int len, =
const char **pathspec)
+int read_directory(struct dir_struct *dir, const char *path, int len,
+		   const char **pathspec)
 {
-	struct path_simplify *simplify;
+	char *newpath =3D NULL;
+	struct strbuf base =3D STRBUF_INIT;
=20
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
=20
-	simplify =3D create_simplify(pathspec);
-	if (!len || treat_leading_path(dir, path, len, simplify))
-		read_directory_recursive(dir, path, len, 0, simplify);
-	free_simplify(simplify);
+	/*
+	 * tree_entry_interesting() does not implement AND operator on
+	 * pathspecs so we call tree_entry_interesting() twice and
+	 * join the results ourselves in match_both_pathspecs()
+	 */
+	if (path && *path) {
+		const char *pathspec1[2];
+		newpath =3D xmalloc(len + 1);
+		memcpy(newpath, path, len);
+		newpath[len] =3D 0;
+		pathspec1[0] =3D newpath;
+		pathspec1[1] =3D NULL;
+		init_pathspec(&dir->ps1, pathspec1);
+	}
+	else
+		init_pathspec(&dir->ps1, NULL);
+	init_pathspec(&dir->ps2, pathspec);
+
+	if (dir->flags & DIR_COLLECT_IGNORED) {
+		int size =3D sizeof(*dir->useful) * dir->ps2.nr;
+		dir->useful =3D xmalloc(size);
+		/* guilty until proven useful */
+		memset(dir->useful, 0, size);
+	}
+
+	read_directory_recursive(dir, &base, 0, entry_not_interesting);
+
+	strbuf_release(&base);
+	free_pathspec(&dir->ps1);
+	if (!(dir->flags & DIR_COLLECT_IGNORED))
+		free_pathspec(&dir->ps2);
+	free(newpath);
+
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
-	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_=
name);
+
 	return dir->nr;
 }
=20
diff --git a/dir.h b/dir.h
index dd6947e..362d7b1 100644
--- a/dir.h
+++ b/dir.h
@@ -43,6 +43,11 @@ struct dir_struct {
 	} flags;
 	struct dir_entry **entries;
 	struct dir_entry **ignored;
+	int *useful;
+
+	/* Include info (a joint of ps1 and ps2) */
+	struct pathspec ps1;
+	struct pathspec ps2;
=20
 	/* Exclude info */
 	const char *exclude_per_dir;
diff --git a/tree-walk.c b/tree-walk.c
index 6e12f0f..b56fec1 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -600,6 +600,8 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 		const char *base_str =3D base->buf + base_offset;
 		int matchlen =3D item->len;
=20
+		/* TODO: 07ccbff (runstatus: do not recurse into subdirectories if n=
ot needed - 2006-09-28) */
+
 		/* assume it will be used (which usually means break
 		   the loop and return), reset it otherwise */
 		item->useful =3D 1;
--=20
1.7.3.1.256.g2539c.dirty
