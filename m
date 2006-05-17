From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] libify git-ls-files directory traversal
Date: Tue, 16 May 2006 19:02:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605161859050.16475@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed May 17 04:02:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgBN2-0001ma-IA
	for gcvg-git@gmane.org; Wed, 17 May 2006 04:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWEQCC1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 22:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWEQCC1
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 22:02:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750811AbWEQCC0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 22:02:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4H22FtH030006
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 May 2006 19:02:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4H22Ea9031445;
	Tue, 16 May 2006 19:02:15 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-9 required=5 tests=PATCH_SUBJECT_OSDL,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20154>


This moves the core directory traversal and filename exclusion logic
into the general git library, making it available for other users
directly.

If we ever want to do "git commit" or "git add" as a built-in (and we
do), we want to be able to handle most of git-ls-files as a library.

NOTE! Not all of git-ls-files is libified by this.  The index matching
and pathspec prefix calculation is still in ls-files.c, but this is a
big part of it.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 Makefile   |    4 -
 dir.c      |  295 +++++++++++++++++++++++++++++++++++++++++++++++++
 dir.h      |   50 ++++++++
 ls-files.c |  363 +++++-------------------------------------------------------
 4 files changed, 376 insertions(+), 336 deletions(-)

diff --git a/Makefile b/Makefile
index 9ba608c..f43ac63 100644
--- a/Makefile
+++ b/Makefile
@@ -199,7 +199,7 @@ LIB_H = \
 	blob.h cache.h commit.h csum-file.h delta.h \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
-	tree-walk.h log-tree.h
+	tree-walk.h log-tree.h dir.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -210,7 +210,7 @@ LIB_OBJS = \
 	blob.o commit.o connect.o csum-file.o base85.o \
 	date.o diff-delta.o entry.o exec_cmd.o ident.o index.o \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o \
-	quote.o read-cache.o refs.o run-command.o \
+	quote.o read-cache.o refs.o run-command.o dir.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
diff --git a/dir.c b/dir.c
new file mode 100644
index 0000000..3f41a5d
--- /dev/null
+++ b/dir.c
@@ -0,0 +1,295 @@
+/*
+ * This handles recursive filename detection with exclude
+ * files, index knowledge etc..
+ *
+ * Copyright (C) Linus Torvalds, 2005-2006
+ *		 Junio Hamano, 2005-2006
+ */
+#include <dirent.h>
+#include <fnmatch.h>
+
+#include "cache.h"
+#include "dir.h"
+
+void add_exclude(const char *string, const char *base,
+		 int baselen, struct exclude_list *which)
+{
+	struct exclude *x = xmalloc(sizeof (*x));
+
+	x->pattern = string;
+	x->base = base;
+	x->baselen = baselen;
+	if (which->nr == which->alloc) {
+		which->alloc = alloc_nr(which->alloc);
+		which->excludes = realloc(which->excludes,
+					  which->alloc * sizeof(x));
+	}
+	which->excludes[which->nr++] = x;
+}
+
+static int add_excludes_from_file_1(const char *fname,
+				    const char *base,
+				    int baselen,
+				    struct exclude_list *which)
+{
+	int fd, i;
+	long size;
+	char *buf, *entry;
+
+	fd = open(fname, O_RDONLY);
+	if (fd < 0)
+		goto err;
+	size = lseek(fd, 0, SEEK_END);
+	if (size < 0)
+		goto err;
+	lseek(fd, 0, SEEK_SET);
+	if (size == 0) {
+		close(fd);
+		return 0;
+	}
+	buf = xmalloc(size+1);
+	if (read(fd, buf, size) != size)
+		goto err;
+	close(fd);
+
+	buf[size++] = '\n';
+	entry = buf;
+	for (i = 0; i < size; i++) {
+		if (buf[i] == '\n') {
+			if (entry != buf + i && entry[0] != '#') {
+				buf[i - (i && buf[i-1] == '\r')] = 0;
+				add_exclude(entry, base, baselen, which);
+			}
+			entry = buf + i + 1;
+		}
+	}
+	return 0;
+
+ err:
+	if (0 <= fd)
+		close(fd);
+	return -1;
+}
+
+void add_excludes_from_file(struct dir_struct *dir, const char *fname)
+{
+	if (add_excludes_from_file_1(fname, "", 0,
+				     &dir->exclude_list[EXC_FILE]) < 0)
+		die("cannot use %s as an exclude file", fname);
+}
+
+int push_exclude_per_directory(struct dir_struct *dir, const char *base, int baselen)
+{
+	char exclude_file[PATH_MAX];
+	struct exclude_list *el = &dir->exclude_list[EXC_DIRS];
+	int current_nr = el->nr;
+
+	if (dir->exclude_per_dir) {
+		memcpy(exclude_file, base, baselen);
+		strcpy(exclude_file + baselen, dir->exclude_per_dir);
+		add_excludes_from_file_1(exclude_file, base, baselen, el);
+	}
+	return current_nr;
+}
+
+static void pop_exclude_per_directory(struct dir_struct *dir, int stk)
+{
+	struct exclude_list *el = &dir->exclude_list[EXC_DIRS];
+
+	while (stk < el->nr)
+		free(el->excludes[--el->nr]);
+}
+
+/* Scan the list and let the last match determines the fate.
+ * Return 1 for exclude, 0 for include and -1 for undecided.
+ */
+static int excluded_1(const char *pathname,
+		      int pathlen,
+		      struct exclude_list *el)
+{
+	int i;
+
+	if (el->nr) {
+		for (i = el->nr - 1; 0 <= i; i--) {
+			struct exclude *x = el->excludes[i];
+			const char *exclude = x->pattern;
+			int to_exclude = 1;
+
+			if (*exclude == '!') {
+				to_exclude = 0;
+				exclude++;
+			}
+
+			if (!strchr(exclude, '/')) {
+				/* match basename */
+				const char *basename = strrchr(pathname, '/');
+				basename = (basename) ? basename+1 : pathname;
+				if (fnmatch(exclude, basename, 0) == 0)
+					return to_exclude;
+			}
+			else {
+				/* match with FNM_PATHNAME:
+				 * exclude has base (baselen long) implicitly
+				 * in front of it.
+				 */
+				int baselen = x->baselen;
+				if (*exclude == '/')
+					exclude++;
+
+				if (pathlen < baselen ||
+				    (baselen && pathname[baselen-1] != '/') ||
+				    strncmp(pathname, x->base, baselen))
+				    continue;
+
+				if (fnmatch(exclude, pathname+baselen,
+					    FNM_PATHNAME) == 0)
+					return to_exclude;
+			}
+		}
+	}
+	return -1; /* undecided */
+}
+
+int excluded(struct dir_struct *dir, const char *pathname)
+{
+	int pathlen = strlen(pathname);
+	int st;
+
+	for (st = EXC_CMDL; st <= EXC_FILE; st++) {
+		switch (excluded_1(pathname, pathlen, &dir->exclude_list[st])) {
+		case 0:
+			return 0;
+		case 1:
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static void add_name(struct dir_struct *dir, const char *pathname, int len)
+{
+	struct dir_entry *ent;
+
+	if (cache_name_pos(pathname, len) >= 0)
+		return;
+
+	if (dir->nr == dir->alloc) {
+		int alloc = alloc_nr(dir->alloc);
+		dir->alloc = alloc;
+		dir->entries = xrealloc(dir->entries, alloc*sizeof(ent));
+	}
+	ent = xmalloc(sizeof(*ent) + len + 1);
+	ent->len = len;
+	memcpy(ent->name, pathname, len);
+	ent->name[len] = 0;
+	dir->entries[dir->nr++] = ent;
+}
+
+static int dir_exists(const char *dirname, int len)
+{
+	int pos = cache_name_pos(dirname, len);
+	if (pos >= 0)
+		return 1;
+	pos = -pos-1;
+	if (pos >= active_nr) /* can't */
+		return 0;
+	return !strncmp(active_cache[pos]->name, dirname, len);
+}
+
+/*
+ * Read a directory tree. We currently ignore anything but
+ * directories, regular files and symlinks. That's because git
+ * doesn't handle them at all yet. Maybe that will change some
+ * day.
+ *
+ * Also, we ignore the name ".git" (even if it is not a directory).
+ * That likely will not change.
+ */
+static int read_directory_recursive(struct dir_struct *dir, const char *path, const char *base, int baselen)
+{
+	DIR *fdir = opendir(path);
+	int contents = 0;
+
+	if (fdir) {
+		int exclude_stk;
+		struct dirent *de;
+		char fullname[MAXPATHLEN + 1];
+		memcpy(fullname, base, baselen);
+
+		exclude_stk = push_exclude_per_directory(dir, base, baselen);
+
+		while ((de = readdir(fdir)) != NULL) {
+			int len;
+
+			if ((de->d_name[0] == '.') &&
+			    (de->d_name[1] == 0 ||
+			     !strcmp(de->d_name + 1, ".") ||
+			     !strcmp(de->d_name + 1, "git")))
+				continue;
+			len = strlen(de->d_name);
+			memcpy(fullname + baselen, de->d_name, len+1);
+			if (excluded(dir, fullname) != dir->show_ignored) {
+				if (!dir->show_ignored || DTYPE(de) != DT_DIR) {
+					continue;
+				}
+			}
+
+			switch (DTYPE(de)) {
+			struct stat st;
+			int subdir, rewind_base;
+			default:
+				continue;
+			case DT_UNKNOWN:
+				if (lstat(fullname, &st))
+					continue;
+				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode))
+					break;
+				if (!S_ISDIR(st.st_mode))
+					continue;
+				/* fallthrough */
+			case DT_DIR:
+				memcpy(fullname + baselen + len, "/", 2);
+				len++;
+				rewind_base = dir->nr;
+				subdir = read_directory_recursive(dir, fullname, fullname,
+				                        baselen + len);
+				if (dir->show_other_directories &&
+				    (subdir || !dir->hide_empty_directories) &&
+				    !dir_exists(fullname, baselen + len)) {
+					// Rewind the read subdirectory
+					while (dir->nr > rewind_base)
+						free(dir->entries[--dir->nr]);
+					break;
+				}
+				contents += subdir;
+				continue;
+			case DT_REG:
+			case DT_LNK:
+				break;
+			}
+			add_name(dir, fullname, baselen + len);
+			contents++;
+		}
+		closedir(fdir);
+
+		pop_exclude_per_directory(dir, exclude_stk);
+	}
+
+	return contents;
+}
+
+static int cmp_name(const void *p1, const void *p2)
+{
+	const struct dir_entry *e1 = *(const struct dir_entry **)p1;
+	const struct dir_entry *e2 = *(const struct dir_entry **)p2;
+
+	return cache_name_compare(e1->name, e1->len,
+				  e2->name, e2->len);
+}
+
+int read_directory(struct dir_struct *dir, const char *path, const char *base, int baselen)
+{
+	read_directory_recursive(dir, path, base, baselen);
+	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
+	return dir->nr;
+}
diff --git a/dir.h b/dir.h
new file mode 100644
index 0000000..e8fc441
--- /dev/null
+++ b/dir.h
@@ -0,0 +1,50 @@
+#ifndef DIR_H
+#define DIR_H
+
+/*
+ * We maintain three exclude pattern lists:
+ * EXC_CMDL lists patterns explicitly given on the command line.
+ * EXC_DIRS lists patterns obtained from per-directory ignore files.
+ * EXC_FILE lists patterns from fallback ignore files.
+ */
+#define EXC_CMDL 0
+#define EXC_DIRS 1
+#define EXC_FILE 2
+
+
+struct dir_entry {
+	int len;
+	char name[FLEX_ARRAY]; /* more */
+};
+
+struct exclude_list {
+	int nr;
+	int alloc;
+	struct exclude {
+		const char *pattern;
+		const char *base;
+		int baselen;
+	} **excludes;
+};
+
+struct dir_struct {
+	int nr, alloc;
+	unsigned int show_ignored:1,
+		     show_other_directories:1,
+		     hide_empty_directories:1;
+	struct dir_entry **entries;
+
+	/* Exclude info */
+	const char *exclude_per_dir;
+	struct exclude_list exclude_list[3];
+};
+
+extern int read_directory(struct dir_struct *, const char *path, const char *base, int baselen);
+extern int excluded(struct dir_struct *, const char *);
+extern void add_excludes_from_file(struct dir_struct *, const char *fname);
+extern void add_exclude(const char *string, const char *base,
+			int baselen, struct exclude_list *which);
+extern int push_exclude_per_directory(struct dir_struct *,
+				      const char *base, int baselen);
+
+#endif
diff --git a/ls-files.c b/ls-files.c
index 4a4af1c..89941a3 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -5,23 +5,20 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include <dirent.h>
 #include <fnmatch.h>
 
 #include "cache.h"
 #include "quote.h"
+#include "dir.h"
 
 static int abbrev = 0;
 static int show_deleted = 0;
 static int show_cached = 0;
 static int show_others = 0;
-static int show_ignored = 0;
 static int show_stage = 0;
 static int show_unmerged = 0;
 static int show_modified = 0;
 static int show_killed = 0;
-static int show_other_directories = 0;
-static int hide_empty_directories = 0;
 static int show_valid_bit = 0;
 static int line_terminator = '\n';
 
@@ -38,309 +35,6 @@ static const char *tag_other = "";
 static const char *tag_killed = "";
 static const char *tag_modified = "";
 
-static const char *exclude_per_dir = NULL;
-
-/* We maintain three exclude pattern lists:
- * EXC_CMDL lists patterns explicitly given on the command line.
- * EXC_DIRS lists patterns obtained from per-directory ignore files.
- * EXC_FILE lists patterns from fallback ignore files.
- */
-#define EXC_CMDL 0
-#define EXC_DIRS 1
-#define EXC_FILE 2
-static struct exclude_list {
-	int nr;
-	int alloc;
-	struct exclude {
-		const char *pattern;
-		const char *base;
-		int baselen;
-	} **excludes;
-} exclude_list[3];
-
-static void add_exclude(const char *string, const char *base,
-			int baselen, struct exclude_list *which)
-{
-	struct exclude *x = xmalloc(sizeof (*x));
-
-	x->pattern = string;
-	x->base = base;
-	x->baselen = baselen;
-	if (which->nr == which->alloc) {
-		which->alloc = alloc_nr(which->alloc);
-		which->excludes = realloc(which->excludes,
-					  which->alloc * sizeof(x));
-	}
-	which->excludes[which->nr++] = x;
-}
-
-static int add_excludes_from_file_1(const char *fname,
-				    const char *base,
-				    int baselen,
-				    struct exclude_list *which)
-{
-	int fd, i;
-	long size;
-	char *buf, *entry;
-
-	fd = open(fname, O_RDONLY);
-	if (fd < 0)
-		goto err;
-	size = lseek(fd, 0, SEEK_END);
-	if (size < 0)
-		goto err;
-	lseek(fd, 0, SEEK_SET);
-	if (size == 0) {
-		close(fd);
-		return 0;
-	}
-	buf = xmalloc(size+1);
-	if (read(fd, buf, size) != size)
-		goto err;
-	close(fd);
-
-	buf[size++] = '\n';
-	entry = buf;
-	for (i = 0; i < size; i++) {
-		if (buf[i] == '\n') {
-			if (entry != buf + i && entry[0] != '#') {
-				buf[i - (i && buf[i-1] == '\r')] = 0;
-				add_exclude(entry, base, baselen, which);
-			}
-			entry = buf + i + 1;
-		}
-	}
-	return 0;
-
- err:
-	if (0 <= fd)
-		close(fd);
-	return -1;
-}
-
-static void add_excludes_from_file(const char *fname)
-{
-	if (add_excludes_from_file_1(fname, "", 0,
-				     &exclude_list[EXC_FILE]) < 0)
-		die("cannot use %s as an exclude file", fname);
-}
-
-static int push_exclude_per_directory(const char *base, int baselen)
-{
-	char exclude_file[PATH_MAX];
-	struct exclude_list *el = &exclude_list[EXC_DIRS];
-	int current_nr = el->nr;
-
-	if (exclude_per_dir) {
-		memcpy(exclude_file, base, baselen);
-		strcpy(exclude_file + baselen, exclude_per_dir);
-		add_excludes_from_file_1(exclude_file, base, baselen, el);
-	}
-	return current_nr;
-}
-
-static void pop_exclude_per_directory(int stk)
-{
-	struct exclude_list *el = &exclude_list[EXC_DIRS];
-
-	while (stk < el->nr)
-		free(el->excludes[--el->nr]);
-}
-
-/* Scan the list and let the last match determines the fate.
- * Return 1 for exclude, 0 for include and -1 for undecided.
- */
-static int excluded_1(const char *pathname,
-		      int pathlen,
-		      struct exclude_list *el)
-{
-	int i;
-
-	if (el->nr) {
-		for (i = el->nr - 1; 0 <= i; i--) {
-			struct exclude *x = el->excludes[i];
-			const char *exclude = x->pattern;
-			int to_exclude = 1;
-
-			if (*exclude == '!') {
-				to_exclude = 0;
-				exclude++;
-			}
-
-			if (!strchr(exclude, '/')) {
-				/* match basename */
-				const char *basename = strrchr(pathname, '/');
-				basename = (basename) ? basename+1 : pathname;
-				if (fnmatch(exclude, basename, 0) == 0)
-					return to_exclude;
-			}
-			else {
-				/* match with FNM_PATHNAME:
-				 * exclude has base (baselen long) implicitly
-				 * in front of it.
-				 */
-				int baselen = x->baselen;
-				if (*exclude == '/')
-					exclude++;
-
-				if (pathlen < baselen ||
-				    (baselen && pathname[baselen-1] != '/') ||
-				    strncmp(pathname, x->base, baselen))
-				    continue;
-
-				if (fnmatch(exclude, pathname+baselen,
-					    FNM_PATHNAME) == 0)
-					return to_exclude;
-			}
-		}
-	}
-	return -1; /* undecided */
-}
-
-static int excluded(const char *pathname)
-{
-	int pathlen = strlen(pathname);
-	int st;
-
-	for (st = EXC_CMDL; st <= EXC_FILE; st++) {
-		switch (excluded_1(pathname, pathlen, &exclude_list[st])) {
-		case 0:
-			return 0;
-		case 1:
-			return 1;
-		}
-	}
-	return 0;
-}
-
-struct nond_on_fs {
-	int len;
-	char name[FLEX_ARRAY]; /* more */
-};
-
-static struct nond_on_fs **dir;
-static int nr_dir;
-static int dir_alloc;
-
-static void add_name(const char *pathname, int len)
-{
-	struct nond_on_fs *ent;
-
-	if (cache_name_pos(pathname, len) >= 0)
-		return;
-
-	if (nr_dir == dir_alloc) {
-		dir_alloc = alloc_nr(dir_alloc);
-		dir = xrealloc(dir, dir_alloc*sizeof(ent));
-	}
-	ent = xmalloc(sizeof(*ent) + len + 1);
-	ent->len = len;
-	memcpy(ent->name, pathname, len);
-	ent->name[len] = 0;
-	dir[nr_dir++] = ent;
-}
-
-static int dir_exists(const char *dirname, int len)
-{
-	int pos = cache_name_pos(dirname, len);
-	if (pos >= 0)
-		return 1;
-	pos = -pos-1;
-	if (pos >= active_nr) /* can't */
-		return 0;
-	return !strncmp(active_cache[pos]->name, dirname, len);
-}
-
-/*
- * Read a directory tree. We currently ignore anything but
- * directories, regular files and symlinks. That's because git
- * doesn't handle them at all yet. Maybe that will change some
- * day.
- *
- * Also, we ignore the name ".git" (even if it is not a directory).
- * That likely will not change.
- */
-static int read_directory(const char *path, const char *base, int baselen)
-{
-	DIR *fdir = opendir(path);
-	int contents = 0;
-
-	if (fdir) {
-		int exclude_stk;
-		struct dirent *de;
-		char fullname[MAXPATHLEN + 1];
-		memcpy(fullname, base, baselen);
-
-		exclude_stk = push_exclude_per_directory(base, baselen);
-
-		while ((de = readdir(fdir)) != NULL) {
-			int len;
-
-			if ((de->d_name[0] == '.') &&
-			    (de->d_name[1] == 0 ||
-			     !strcmp(de->d_name + 1, ".") ||
-			     !strcmp(de->d_name + 1, "git")))
-				continue;
-			len = strlen(de->d_name);
-			memcpy(fullname + baselen, de->d_name, len+1);
-			if (excluded(fullname) != show_ignored) {
-				if (!show_ignored || DTYPE(de) != DT_DIR) {
-					continue;
-				}
-			}
-
-			switch (DTYPE(de)) {
-			struct stat st;
-			int subdir, rewind_base;
-			default:
-				continue;
-			case DT_UNKNOWN:
-				if (lstat(fullname, &st))
-					continue;
-				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode))
-					break;
-				if (!S_ISDIR(st.st_mode))
-					continue;
-				/* fallthrough */
-			case DT_DIR:
-				memcpy(fullname + baselen + len, "/", 2);
-				len++;
-				rewind_base = nr_dir;
-				subdir = read_directory(fullname, fullname,
-				                        baselen + len);
-				if (show_other_directories &&
-				    (subdir || !hide_empty_directories) &&
-				    !dir_exists(fullname, baselen + len)) {
-					// Rewind the read subdirectory
-					while (nr_dir > rewind_base)
-						free(dir[--nr_dir]);
-					break;
-				}
-				contents += subdir;
-				continue;
-			case DT_REG:
-			case DT_LNK:
-				break;
-			}
-			add_name(fullname, baselen + len);
-			contents++;
-		}
-		closedir(fdir);
-
-		pop_exclude_per_directory(exclude_stk);
-	}
-
-	return contents;
-}
-
-static int cmp_name(const void *p1, const void *p2)
-{
-	const struct nond_on_fs *e1 = *(const struct nond_on_fs **)p1;
-	const struct nond_on_fs *e2 = *(const struct nond_on_fs **)p2;
-
-	return cache_name_compare(e1->name, e1->len,
-				  e2->name, e2->len);
-}
 
 /*
  * Match a pathspec against a filename. The first "len" characters
@@ -377,7 +71,7 @@ static int match(const char **spec, char
 	return 0;
 }
 
-static void show_dir_entry(const char *tag, struct nond_on_fs *ent)
+static void show_dir_entry(const char *tag, struct dir_entry *ent)
 {
 	int len = prefix_len;
 	int offset = prefix_offset;
@@ -393,14 +87,14 @@ static void show_dir_entry(const char *t
 	putchar(line_terminator);
 }
 
-static void show_other_files(void)
+static void show_other_files(struct dir_struct *dir)
 {
 	int i;
-	for (i = 0; i < nr_dir; i++) {
+	for (i = 0; i < dir->nr; i++) {
 		/* We should not have a matching entry, but we
 		 * may have an unmerged entry for this path.
 		 */
-		struct nond_on_fs *ent = dir[i];
+		struct dir_entry *ent = dir->entries[i];
 		int pos = cache_name_pos(ent->name, ent->len);
 		struct cache_entry *ce;
 		if (0 <= pos)
@@ -416,11 +110,11 @@ static void show_other_files(void)
 	}
 }
 
-static void show_killed_files(void)
+static void show_killed_files(struct dir_struct *dir)
 {
 	int i;
-	for (i = 0; i < nr_dir; i++) {
-		struct nond_on_fs *ent = dir[i];
+	for (i = 0; i < dir->nr; i++) {
+		struct dir_entry *ent = dir->entries[i];
 		char *cp, *sp;
 		int pos, len, killed = 0;
 
@@ -461,7 +155,7 @@ static void show_killed_files(void)
 			}
 		}
 		if (killed)
-			show_dir_entry(tag_killed, dir[i]);
+			show_dir_entry(tag_killed, dir->entries[i]);
 	}
 }
 
@@ -512,7 +206,7 @@ static void show_ce_entry(const char *ta
 	}
 }
 
-static void show_files(void)
+static void show_files(struct dir_struct *dir)
 {
 	int i;
 
@@ -523,14 +217,14 @@ static void show_files(void)
 
 		if (baselen) {
 			path = base = prefix;
-			if (exclude_per_dir) {
+			if (dir->exclude_per_dir) {
 				char *p, *pp = xmalloc(baselen+1);
 				memcpy(pp, prefix, baselen+1);
 				p = pp;
 				while (1) {
 					char save = *p;
 					*p = 0;
-					push_exclude_per_directory(pp, p-pp);
+					push_exclude_per_directory(dir, pp, p-pp);
 					*p++ = save;
 					if (!save)
 						break;
@@ -543,17 +237,16 @@ static void show_files(void)
 				free(pp);
 			}
 		}
-		read_directory(path, base, baselen);
-		qsort(dir, nr_dir, sizeof(struct nond_on_fs *), cmp_name);
+		read_directory(dir, path, base, baselen);
 		if (show_others)
-			show_other_files();
+			show_other_files(dir);
 		if (show_killed)
-			show_killed_files();
+			show_killed_files(dir);
 	}
 	if (show_cached | show_stage) {
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
-			if (excluded(ce->name) != show_ignored)
+			if (excluded(dir, ce->name) != dir->show_ignored)
 				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
@@ -565,7 +258,7 @@ static void show_files(void)
 			struct cache_entry *ce = active_cache[i];
 			struct stat st;
 			int err;
-			if (excluded(ce->name) != show_ignored)
+			if (excluded(dir, ce->name) != dir->show_ignored)
 				continue;
 			err = lstat(ce->name, &st);
 			if (show_deleted && err)
@@ -652,7 +345,9 @@ int main(int argc, const char **argv)
 {
 	int i;
 	int exc_given = 0;
+	struct dir_struct dir;
 
+	memset(&dir, 0, sizeof(dir));
 	prefix = setup_git_directory();
 	if (prefix)
 		prefix_offset = strlen(prefix);
@@ -697,7 +392,7 @@ int main(int argc, const char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "-i") || !strcmp(arg, "--ignored")) {
-			show_ignored = 1;
+			dir.show_ignored = 1;
 			continue;
 		}
 		if (!strcmp(arg, "-s") || !strcmp(arg, "--stage")) {
@@ -709,11 +404,11 @@ int main(int argc, const char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "--directory")) {
-			show_other_directories = 1;
+			dir.show_other_directories = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--no-empty-directory")) {
-			hide_empty_directories = 1;
+			dir.hide_empty_directories = 1;
 			continue;
 		}
 		if (!strcmp(arg, "-u") || !strcmp(arg, "--unmerged")) {
@@ -726,27 +421,27 @@ int main(int argc, const char **argv)
 		}
 		if (!strcmp(arg, "-x") && i+1 < argc) {
 			exc_given = 1;
-			add_exclude(argv[++i], "", 0, &exclude_list[EXC_CMDL]);
+			add_exclude(argv[++i], "", 0, &dir.exclude_list[EXC_CMDL]);
 			continue;
 		}
 		if (!strncmp(arg, "--exclude=", 10)) {
 			exc_given = 1;
-			add_exclude(arg+10, "", 0, &exclude_list[EXC_CMDL]);
+			add_exclude(arg+10, "", 0, &dir.exclude_list[EXC_CMDL]);
 			continue;
 		}
 		if (!strcmp(arg, "-X") && i+1 < argc) {
 			exc_given = 1;
-			add_excludes_from_file(argv[++i]);
+			add_excludes_from_file(&dir, argv[++i]);
 			continue;
 		}
 		if (!strncmp(arg, "--exclude-from=", 15)) {
 			exc_given = 1;
-			add_excludes_from_file(arg+15);
+			add_excludes_from_file(&dir, arg+15);
 			continue;
 		}
 		if (!strncmp(arg, "--exclude-per-directory=", 24)) {
 			exc_given = 1;
-			exclude_per_dir = arg + 24;
+			dir.exclude_per_dir = arg + 24;
 			continue;
 		}
 		if (!strcmp(arg, "--full-name")) {
@@ -788,7 +483,7 @@ int main(int argc, const char **argv)
 		ps_matched = xcalloc(1, num);
 	}
 
-	if (show_ignored && !exc_given) {
+	if (dir.show_ignored && !exc_given) {
 		fprintf(stderr, "%s: --ignored needs some exclude pattern\n",
 			argv[0]);
 		exit(1);
@@ -802,7 +497,7 @@ int main(int argc, const char **argv)
 	read_cache();
 	if (prefix)
 		prune_cache();
-	show_files();
+	show_files(&dir);
 
 	if (ps_matched) {
 		/* We need to make sure all pathspec matched otherwise
