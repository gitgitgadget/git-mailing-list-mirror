From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] per-directory-exclude: lazily read .gitignore files
Date: Thu, 29 Nov 2007 02:17:44 -0800
Message-ID: <7vy7chuzhz.fsf_-_@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
	<7vr6i9y6ju.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 11:18:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxgTC-0006wv-Bp
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 11:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501AbXK2KRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 05:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754503AbXK2KRx
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 05:17:53 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:42555 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbXK2KRu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 05:17:50 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 75A712EF;
	Thu, 29 Nov 2007 05:18:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 36B069A044;
	Thu, 29 Nov 2007 05:18:08 -0500 (EST)
In-Reply-To: <7vr6i9y6ju.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 28 Nov 2007 21:17:09 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66525>

Operations that walk directories or trees, which potentially need to
consult the .gitignore files, used to always try to open the .gitignore
file every time they entered a new directory, even when they ended up
not needing to call excluded() function to see if a path in the
directory is ignored.

This changes the directory walking API to remove the need to call these
two functions.  Instead, the directory walk data structure caches the
data used by excluded() function the last time, and lazily reuses it as
much as possible.  Among the data the last check used, the ones from
deeper directories that the path we are checking is outside are
discarded, data from the common leading directories are reused, and then
the directories between the common directory and the directory the path
being checked is in are checked for .gitignore file.  This is very
similar to the way gitattributes are handled.

This API change also fixes "ls-files -c -i", which called excluded()
without setting up the gitignore data via the old push/pop functions.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Junio C Hamano <gitster@pobox.com> writes:
 > Linus Torvalds <torvalds@linux-foundation.org> writes:
 >
 >> Less than a hundredth of a second may not sound much, but when we have 
 >> 1700+ directories in the kernel trees, doing that for each possible 
 >> .gitignore file is really really expensive!
 >
 > The only thing that wants to use excluded() in the unpack_trees()
 > codepath is the code to allow overwriting an existing, untracked file in
 > verify_absent().  When we find an untracked file at the same path as we
 > are just trying to check out a file, we allow overwriting it only if
 > that file is "ignored".
 > ...
 > The newer gitattributes subsystem maintains a similar per-directory data
 > structure but this is purely done on-demand; until somebody asks "what
 > are the attrs for this path", we do not read .gitattributes file.  We
 > should be able to restructure exclude-per-directory code in a similar
 > way.

 I haven't seriously benched this, other than the same read-tree test
 you mentioned.  With the good locality the directory walking (both by
 read_directory() aka ls-files and unpack_trees() aka read-tree) tends
 to have, checks for paths from the same directory come next to each
 other, and that seems to help.

 dir.c          |  103 +++++++++++++++++++++++++++++---------------------------
 dir.h          |   32 ++++++++++-------
 unpack-trees.c |    6 ---
 3 files changed, 72 insertions(+), 69 deletions(-)

diff --git a/dir.c b/dir.c
index 7c97483..d448902 100644
--- a/dir.c
+++ b/dir.c
@@ -151,6 +151,7 @@ void add_exclude(const char *string, const char *base,
 static int add_excludes_from_file_1(const char *fname,
 				    const char *base,
 				    int baselen,
+				    char **buf_p,
 				    struct exclude_list *which)
 {
 	struct stat st;
@@ -171,6 +172,8 @@ static int add_excludes_from_file_1(const char *fname,
 		goto err;
 	close(fd);
 
+	if (buf_p)
+		*buf_p = buf;
 	buf[size++] = '\n';
 	entry = buf;
 	for (i = 0; i < size; i++) {
@@ -192,31 +195,63 @@ static int add_excludes_from_file_1(const char *fname,
 
 void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 {
-	if (add_excludes_from_file_1(fname, "", 0,
+	if (add_excludes_from_file_1(fname, "", 0, NULL,
 				     &dir->exclude_list[EXC_FILE]) < 0)
 		die("cannot use %s as an exclude file", fname);
 }
 
-int push_exclude_per_directory(struct dir_struct *dir, const char *base, int baselen)
+static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 {
-	char exclude_file[PATH_MAX];
-	struct exclude_list *el = &dir->exclude_list[EXC_DIRS];
-	int current_nr = el->nr;
-
-	if (dir->exclude_per_dir) {
-		memcpy(exclude_file, base, baselen);
-		strcpy(exclude_file + baselen, dir->exclude_per_dir);
-		add_excludes_from_file_1(exclude_file, base, baselen, el);
+	struct exclude_list *el;
+	struct exclude_stack *stk = NULL;
+	int current;
+
+	if ((!dir->exclude_per_dir) ||
+	    (baselen + strlen(dir->exclude_per_dir) >= PATH_MAX))
+		return; /* too long a path -- ignore */
+
+	/* Pop the ones that are not the prefix of the path being checked. */
+	el = &dir->exclude_list[EXC_DIRS];
+	while ((stk = dir->exclude_stack) != NULL) {
+		if (stk->baselen <= baselen &&
+		    !strncmp(dir->basebuf, base, stk->baselen))
+			break;
+		dir->exclude_stack = stk->prev;
+		while (stk->exclude_ix < el->nr)
+			free(el->excludes[--el->nr]);
+		free(stk->filebuf);
+		free(stk);
 	}
-	return current_nr;
-}
 
-void pop_exclude_per_directory(struct dir_struct *dir, int stk)
-{
-	struct exclude_list *el = &dir->exclude_list[EXC_DIRS];
+	/* Read from the parent directories and push them down. */
+	current = stk ? stk->baselen : -1;
+	while (current < baselen) {
+		struct exclude_stack *stk = xcalloc(1, sizeof(*stk));
+		const char *cp;
 
-	while (stk < el->nr)
-		free(el->excludes[--el->nr]);
+		if (current < 0) {
+			cp = base;
+			current = 0;
+		}
+		else {
+			cp = strchr(base + current + 1, '/');
+			if (!cp)
+				die("oops in prep_exclude");
+			cp++;
+		}
+		stk->prev = dir->exclude_stack;
+		stk->baselen = cp - base;
+		stk->exclude_ix = el->nr;
+		memcpy(dir->basebuf + current, base + current,
+		       stk->baselen - current);
+		strcpy(dir->basebuf + stk->baselen, dir->exclude_per_dir);
+		add_excludes_from_file_1(dir->basebuf,
+					 dir->basebuf, stk->baselen,
+					 &stk->filebuf, el);
+		dir->exclude_stack = stk;
+		current = stk->baselen;
+	}
+	dir->basebuf[baselen] = '\0';
 }
 
 /* Scan the list and let the last match determines the fate.
@@ -283,6 +318,7 @@ int excluded(struct dir_struct *dir, const char *pathname)
 	const char *basename = strrchr(pathname, '/');
 	basename = (basename) ? basename+1 : pathname;
 
+	prep_exclude(dir, pathname, basename-pathname);
 	for (st = EXC_CMDL; st <= EXC_FILE; st++) {
 		switch (excluded_1(pathname, pathlen, basename, &dir->exclude_list[st])) {
 		case 0:
@@ -500,13 +536,10 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 	int contents = 0;
 
 	if (fdir) {
-		int exclude_stk;
 		struct dirent *de;
 		char fullname[PATH_MAX + 1];
 		memcpy(fullname, base, baselen);
 
-		exclude_stk = push_exclude_per_directory(dir, base, baselen);
-
 		while ((de = readdir(fdir)) != NULL) {
 			int len, dtype;
 			int exclude;
@@ -580,8 +613,6 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 		}
 exit_early:
 		closedir(fdir);
-
-		pop_exclude_per_directory(dir, exclude_stk);
 	}
 
 	return contents;
@@ -650,37 +681,9 @@ static void free_simplify(struct path_simplify *simplify)
 int read_directory(struct dir_struct *dir, const char *path, const char *base, int baselen, const char **pathspec)
 {
 	struct path_simplify *simplify = create_simplify(pathspec);
-	char *pp = NULL;
-
-	/*
-	 * Make sure to do the per-directory exclude for all the
-	 * directories leading up to our base.
-	 */
-	if (baselen) {
-		if (dir->exclude_per_dir) {
-			char *p;
-			pp = xmalloc(baselen+1);
-			memcpy(pp, base, baselen+1);
-			p = pp;
-			while (1) {
-				char save = *p;
-				*p = 0;
-				push_exclude_per_directory(dir, pp, p-pp);
-				*p++ = save;
-				if (!save)
-					break;
-				p = strchr(p, '/');
-				if (p)
-					p++;
-				else
-					p = pp + baselen;
-			}
-		}
-	}
 
 	read_directory_recursive(dir, path, base, baselen, 0, simplify);
 	free_simplify(simplify);
-	free(pp);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_name);
 	return dir->nr;
diff --git a/dir.h b/dir.h
index 82009dc..d8814dc 100644
--- a/dir.h
+++ b/dir.h
@@ -1,17 +1,6 @@
 #ifndef DIR_H
 #define DIR_H
 
-/*
- * We maintain three exclude pattern lists:
- * EXC_CMDL lists patterns explicitly given on the command line.
- * EXC_DIRS lists patterns obtained from per-directory ignore files.
- * EXC_FILE lists patterns from fallback ignore files.
- */
-#define EXC_CMDL 0
-#define EXC_DIRS 1
-#define EXC_FILE 2
-
-
 struct dir_entry {
 	unsigned int len;
 	char name[FLEX_ARRAY]; /* more */
@@ -34,6 +23,13 @@ struct exclude_list {
 	} **excludes;
 };
 
+struct exclude_stack {
+	struct exclude_stack *prev;
+	char *filebuf;
+	int baselen;
+	int exclude_ix;
+};
+
 struct dir_struct {
 	int nr, alloc;
 	int ignored_nr, ignored_alloc;
@@ -48,6 +44,18 @@ struct dir_struct {
 	/* Exclude info */
 	const char *exclude_per_dir;
 	struct exclude_list exclude_list[3];
+	/*
+	 * We maintain three exclude pattern lists:
+	 * EXC_CMDL lists patterns explicitly given on the command line.
+	 * EXC_DIRS lists patterns obtained from per-directory ignore files.
+	 * EXC_FILE lists patterns from fallback ignore files.
+	 */
+#define EXC_CMDL 0
+#define EXC_DIRS 1
+#define EXC_FILE 2
+
+	struct exclude_stack *exclude_stack;
+	char basebuf[PATH_MAX];
 };
 
 extern int common_prefix(const char **pathspec);
@@ -58,8 +66,6 @@ extern int common_prefix(const char **pathspec);
 extern int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen);
 
 extern int read_directory(struct dir_struct *, const char *path, const char *base, int baselen, const char **pathspec);
-extern int push_exclude_per_directory(struct dir_struct *, const char *, int);
-extern void pop_exclude_per_directory(struct dir_struct *, int);
 
 extern int excluded(struct dir_struct *, const char *);
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
diff --git a/unpack-trees.c b/unpack-trees.c
index aea16ad..e9eb795 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -71,12 +71,8 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 	int remove;
 	int baselen = strlen(base);
 	int src_size = len + 1;
-	int i_stk = i_stk;
 	int retval = 0;
 
-	if (o->dir)
-		i_stk = push_exclude_per_directory(o->dir, base, strlen(base));
-
 	do {
 		int i;
 		const char *first;
@@ -255,8 +251,6 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 	} while (1);
 
  leave_directory:
-	if (o->dir)
-		pop_exclude_per_directory(o->dir, i_stk);
 	return retval;
 }
 
-- 
1.5.3.6.2064.g2e22f
