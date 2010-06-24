From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/9] Add infrastructure to write revisions in fast-export
 format
Date: Thu, 24 Jun 2010 06:02:17 -0500
Message-ID: <20100624110217.GG12376@burratino>
References: <20100624105004.GA12336@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 13:02:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORkCY-0006LP-GT
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 13:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867Ab0FXLC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 07:02:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38877 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585Ab0FXLC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 07:02:28 -0400
Received: by iwn41 with SMTP id 41so738063iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 04:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=81sCzmSDWhO2gzbAONWC9p932tM3ciExOJypYIp9mac=;
        b=jY5q/+G6U1DCE51eqMsO5FUJfKkmKsA4IVNb+rL+NczmzH/cVJ+s6kTKAGdc5sNBkP
         ZIPJjYkdgap7L7vOvNaRoGZ5V/WoIcivraAbgzft9uH3pZ1+/8iL98RW8yhwGYqr/Yjv
         Rz66tb57+KcxpEeFzSlBkbWzY40vK0CJYxGtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=D0ORTGIPz+EhoMDGJHYb5R/ubKQQXAo3kHqerTVyxsug0JaVuZGfXO0lsFcfDCHo8Z
         ayMxjZAshkPX/dHTub+r4dP2c+dVrHqYvvBIdED3z+w4lr9YDGmX058iSxMjpHG0dDn7
         kFktCYnNP7wran177GBTKye9BNZhfPFg8j7kk=
Received: by 10.231.148.131 with SMTP id p3mr11202182ibv.18.1277377346678;
        Thu, 24 Jun 2010 04:02:26 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm16825754ibl.22.2010.06.24.04.02.25
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 04:02:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100624105004.GA12336@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149578>

From: David Barr <david.barr@cordelta.com>

repo_tree maintains the exporter's state and provides a facility to to
call fast_export, which writes objects to stdout suitable for
consumption by fast-import.

The exported functions roughly correspond to Subversion FS operations.

 . repo_add adds a file to the current commit.

 . repo_modify adds a replacement for an existing file;
   it is implemented exactly the same way, but a check could be
   added later to distinguish the two cases.

 . repo_copy copies a blob from a previous revision to the current
   commit.

 . repo_replace modifies the content of a file from the current
   commit, if and only if it exists.

 . repo_delete removes a file or directory from the current commit.

 . repo_commit calls out to fast_export to write the current commit to
   the fast-import stream in stdout.

 . repo_diff is used by the fast_export module to write the changes
   for a commit.

 . repo_reset erases the exporter's state, so valgrind can be happy.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile              |    5 +-
 vcs-svn/fast_export.c |   75 +++++++++++
 vcs-svn/fast_export.h |   14 ++
 vcs-svn/repo_tree.c   |  335 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/repo_tree.h   |   26 ++++
 5 files changed, 453 insertions(+), 2 deletions(-)
 create mode 100644 vcs-svn/fast_export.c
 create mode 100644 vcs-svn/fast_export.h
 create mode 100644 vcs-svn/repo_tree.c
 create mode 100644 vcs-svn/repo_tree.h

diff --git a/Makefile b/Makefile
index 8223d9b..7c66dcc 100644
--- a/Makefile
+++ b/Makefile
@@ -1740,7 +1740,8 @@ ifndef NO_CURL
 endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
-VCSSVN_OBJS = vcs-svn/string_pool.o vcs-svn/line_buffer.o
+VCSSVN_OBJS = vcs-svn/string_pool.o vcs-svn/line_buffer.o \
+	vcs-svn/repo_tree.o vcs-svn/fast_export.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
@@ -1865,7 +1866,7 @@ xdiff-interface.o $(XDIFF_OBJS): \
 
 $(VCSSVN_OBJS): \
 	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h \
-	vcs-svn/line_buffer.h
+	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h
 endif
 
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
new file mode 100644
index 0000000..7552803
--- /dev/null
+++ b/vcs-svn/fast_export.c
@@ -0,0 +1,75 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "git-compat-util.h"
+
+#include "fast_export.h"
+#include "line_buffer.h"
+#include "repo_tree.h"
+#include "string_pool.h"
+
+#define MAX_GITSVN_LINE_LEN 4096
+
+static uint32_t first_commit_done;
+
+void fast_export_delete(uint32_t depth, uint32_t *path)
+{
+	putchar('D');
+	putchar(' ');
+	pool_print_seq(depth, path, '/', stdout);
+	putchar('\n');
+}
+
+void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
+                        uint32_t mark)
+{
+	/* Mode must be 100644, 100755, 120000, or 160000. */
+	printf("M %06o :%d ", mode, mark);
+	pool_print_seq(depth, path, '/', stdout);
+	putchar('\n');
+}
+
+static char gitsvnline[MAX_GITSVN_LINE_LEN];
+void fast_export_commit(uint32_t revision, uint32_t author, char *log,
+			uint32_t uuid, uint32_t url,
+			unsigned long timestamp)
+{
+	if (!log)
+		log = "";
+	if (~uuid && ~url) {
+		snprintf(gitsvnline, MAX_GITSVN_LINE_LEN, "\n\ngit-svn-id: %s@%d %s\n",
+				 pool_fetch(url), revision, pool_fetch(uuid));
+	} else {
+		*gitsvnline = '\0';
+	}
+	printf("commit refs/heads/master\n");
+	printf("committer %s <%s@%s> %ld +0000\n",
+		   ~author ? pool_fetch(author) : "nobody",
+		   ~author ? pool_fetch(author) : "nobody",
+		   ~uuid ? pool_fetch(uuid) : "local", timestamp);
+	printf("data %zd\n%s%s\n",
+		   strlen(log) + strlen(gitsvnline), log, gitsvnline);
+	if (!first_commit_done) {
+		if (revision > 1)
+			printf("from refs/heads/master^0\n");
+		first_commit_done = 1;
+	}
+	repo_diff(revision - 1, revision);
+	fputc('\n', stdout);
+
+	printf("progress Imported commit %d.\n\n", revision);
+}
+
+void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len)
+{
+	if (mode == REPO_MODE_LNK) {
+		/* svn symlink blobs start with "link " */
+		buffer_skip_bytes(5);
+		len -= 5;
+	}
+	printf("blob\nmark :%d\ndata %d\n", mark, len);
+	buffer_copy_bytes(len);
+	fputc('\n', stdout);
+}
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
new file mode 100644
index 0000000..47e8f56
--- /dev/null
+++ b/vcs-svn/fast_export.h
@@ -0,0 +1,14 @@
+#ifndef FAST_EXPORT_H_
+#define FAST_EXPORT_H_
+
+#include <stdint.h>
+#include <time.h>
+
+void fast_export_delete(uint32_t depth, uint32_t *path);
+void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
+			uint32_t mark);
+void fast_export_commit(uint32_t revision, uint32_t author, char *log,
+			uint32_t uuid, uint32_t url, unsigned long timestamp);
+void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len);
+
+#endif
diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
new file mode 100644
index 0000000..59a7434
--- /dev/null
+++ b/vcs-svn/repo_tree.c
@@ -0,0 +1,335 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "git-compat-util.h"
+
+#include "string_pool.h"
+#include "repo_tree.h"
+#include "obj_pool.h"
+#include "fast_export.h"
+
+#include "trp.h"
+
+struct repo_dirent {
+	uint32_t name_offset;
+	struct trp_node children;
+	uint32_t mode;
+	uint32_t content_offset;
+};
+
+struct repo_dir {
+	struct trp_root entries;
+};
+
+struct repo_commit {
+	uint32_t root_dir_offset;
+};
+
+/* Memory pools for commit, dir and dirent */
+obj_pool_gen(commit, struct repo_commit, 4096);
+obj_pool_gen(dir, struct repo_dir, 4096);
+obj_pool_gen(dirent, struct repo_dirent, 4096);
+
+static uint32_t active_commit;
+static uint32_t mark;
+
+static int repo_dirent_name_cmp(const void *a, const void *b);
+
+/* Treap for directory entries */
+trp_gen(static, dirent_, struct repo_dirent, children, dirent, repo_dirent_name_cmp);
+
+uint32_t next_blob_mark(void)
+{
+	return mark++;
+}
+
+static struct repo_dir *repo_commit_root_dir(struct repo_commit *commit)
+{
+	return dir_pointer(commit->root_dir_offset);
+}
+
+static struct repo_dirent *repo_first_dirent(struct repo_dir *dir)
+{
+	return dirent_first(&dir->entries);
+}
+
+static int repo_dirent_name_cmp(const void *a, const void *b)
+{
+	const struct repo_dirent *dirent1 = a, *dirent2 = b;
+	uint32_t a_offset = dirent1->name_offset;
+	uint32_t b_offset = dirent2->name_offset;
+	return (a_offset > b_offset) - (a_offset < b_offset);
+}
+
+static int repo_dirent_is_dir(struct repo_dirent *dirent)
+{
+	return dirent != NULL && dirent->mode == REPO_MODE_DIR;
+}
+
+static struct repo_dir *repo_dir_from_dirent(struct repo_dirent *dirent)
+{
+	if (!repo_dirent_is_dir(dirent))
+		return NULL;
+	return dir_pointer(dirent->content_offset);
+}
+
+static struct repo_dir *repo_clone_dir(struct repo_dir *orig_dir)
+{
+	uint32_t orig_o, new_o;
+	orig_o = dir_offset(orig_dir);
+	if (orig_o >= dir_pool.committed)
+		return orig_dir;
+	new_o = dir_alloc(1);
+	orig_dir = dir_pointer(orig_o);
+	*dir_pointer(new_o) = *orig_dir;
+	return dir_pointer(new_o);
+}
+
+static struct repo_dirent *repo_read_dirent(uint32_t revision, uint32_t *path)
+{
+	uint32_t name = 0;
+	struct repo_dirent *key = dirent_pointer(dirent_alloc(1));
+	struct repo_dir *dir = NULL;
+	struct repo_dirent *dirent = NULL;
+	dir = repo_commit_root_dir(commit_pointer(revision));
+	while (~(name = *path++)) {
+		key->name_offset = name;
+		dirent = dirent_search(&dir->entries, key);
+		if (dirent == NULL || !repo_dirent_is_dir(dirent))
+			break;
+		dir = repo_dir_from_dirent(dirent);
+	}
+	dirent_free(1);
+	return dirent;
+}
+
+static void repo_write_dirent(uint32_t *path, uint32_t mode,
+                              uint32_t content_offset, uint32_t del)
+{
+	uint32_t name, revision, dir_o = ~0, parent_dir_o = ~0;
+	struct repo_dir *dir;
+	struct repo_dirent *key;
+	struct repo_dirent *dirent = NULL;
+	revision = active_commit;
+	dir = repo_commit_root_dir(commit_pointer(revision));
+	dir = repo_clone_dir(dir);
+	commit_pointer(revision)->root_dir_offset = dir_offset(dir);
+	while (~(name = *path++)) {
+		parent_dir_o = dir_offset(dir);
+
+		key = dirent_pointer(dirent_alloc(1));
+		key->name_offset = name;
+
+		dirent = dirent_search(&dir->entries, key);
+		if (dirent == NULL)
+			dirent = key;
+		else
+			dirent_free(1);
+
+		if (dirent == key) {
+			dirent->mode = REPO_MODE_DIR;
+			dirent->content_offset = 0;
+			dirent_insert(&dir->entries, dirent);
+		}
+
+		if (dirent_offset(dirent) < dirent_pool.committed) {
+			dir_o = repo_dirent_is_dir(dirent) ?
+					dirent->content_offset : ~0;
+			dirent_remove(&dir->entries, dirent);
+			dirent = dirent_pointer(dirent_alloc(1));
+			dirent->name_offset = name;
+			dirent->mode = REPO_MODE_DIR;
+			dirent->content_offset = dir_o;
+			dirent_insert(&dir->entries, dirent);
+		}
+
+		dir = repo_dir_from_dirent(dirent);
+		dir = repo_clone_dir(dir);
+		dirent->content_offset = dir_offset(dir);
+	}
+	if (dirent == NULL)
+		return;
+	dirent->mode = mode;
+	dirent->content_offset = content_offset;
+	if (del && ~parent_dir_o)
+		dirent_remove(&dir_pointer(parent_dir_o)->entries, dirent);
+}
+
+uint32_t repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst)
+{
+	uint32_t mode = 0, content_offset = 0;
+	struct repo_dirent *src_dirent;
+	src_dirent = repo_read_dirent(revision, src);
+	if (src_dirent != NULL) {
+		mode = src_dirent->mode;
+		content_offset = src_dirent->content_offset;
+		repo_write_dirent(dst, mode, content_offset, 0);
+	}
+	return mode;
+}
+
+void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark)
+{
+	repo_write_dirent(path, mode, blob_mark, 0);
+}
+
+uint32_t repo_replace(uint32_t *path, uint32_t blob_mark)
+{
+	uint32_t mode = 0;
+	struct repo_dirent *src_dirent;
+	src_dirent = repo_read_dirent(active_commit, path);
+	if (src_dirent != NULL) {
+		mode = src_dirent->mode;
+		repo_write_dirent(path, mode, blob_mark, 0);
+	}
+	return mode;
+}
+
+void repo_modify(uint32_t *path, uint32_t mode, uint32_t blob_mark)
+{
+	struct repo_dirent *src_dirent;
+	src_dirent = repo_read_dirent(active_commit, path);
+	if (src_dirent != NULL && blob_mark == 0)
+		blob_mark = src_dirent->content_offset;
+	repo_write_dirent(path, mode, blob_mark, 0);
+}
+
+void repo_delete(uint32_t *path)
+{
+	repo_write_dirent(path, 0, 0, 1);
+}
+
+static void repo_git_add_r(uint32_t depth, uint32_t *path, struct repo_dir *dir);
+
+static void repo_git_add(uint32_t depth, uint32_t *path, struct repo_dirent *dirent)
+{
+	if (repo_dirent_is_dir(dirent))
+		repo_git_add_r(depth, path, repo_dir_from_dirent(dirent));
+	else
+		fast_export_modify(depth, path,
+		                   dirent->mode, dirent->content_offset);
+}
+
+static void repo_git_add_r(uint32_t depth, uint32_t *path, struct repo_dir *dir)
+{
+	struct repo_dirent *de = repo_first_dirent(dir);
+	while (de) {
+		path[depth] = de->name_offset;
+		repo_git_add(depth + 1, path, de);
+		de = dirent_next(&dir->entries, de);
+	}
+}
+
+static void repo_diff_r(uint32_t depth, uint32_t *path, struct repo_dir *dir1,
+                        struct repo_dir *dir2)
+{
+	struct repo_dirent *de1, *de2;
+	de1 = repo_first_dirent(dir1);
+	de2 = repo_first_dirent(dir2);
+
+	while (de1 && de2) {
+		if (de1->name_offset < de2->name_offset) {
+			path[depth] = de1->name_offset;
+			fast_export_delete(depth + 1, path);
+			de1 = dirent_next(&dir1->entries, de1);
+			continue;
+		}
+		if (de1->name_offset > de2->name_offset) {
+			path[depth] = de2->name_offset;
+			repo_git_add(depth + 1, path, de2);
+			de2 = dirent_next(&dir2->entries, de2);
+			continue;
+		}
+		path[depth] = de1->name_offset;
+
+		if (de1->mode == de2->mode &&
+		    de1->content_offset == de2->content_offset) {
+			; /* No change. */
+		} else if (repo_dirent_is_dir(de1) && repo_dirent_is_dir(de2)) {
+			repo_diff_r(depth + 1, path,
+				    repo_dir_from_dirent(de1),
+				    repo_dir_from_dirent(de2));
+		} else if (!repo_dirent_is_dir(de1) && !repo_dirent_is_dir(de2)) {
+			repo_git_add(depth + 1, path, de2);
+		} else {
+			fast_export_delete(depth + 1, path);
+			repo_git_add(depth + 1, path, de2);
+		}
+		de1 = dirent_next(&dir1->entries, de1);
+		de2 = dirent_next(&dir2->entries, de2);
+	}
+	while (de1) {
+		path[depth] = de1->name_offset;
+		fast_export_delete(depth + 1, path);
+		de1 = dirent_next(&dir1->entries, de1);
+	}
+	while (de2) {
+		path[depth] = de2->name_offset;
+		repo_git_add(depth + 1, path, de2);
+		de2 = dirent_next(&dir2->entries, de2);
+	}
+}
+
+static uint32_t path_stack[REPO_MAX_PATH_DEPTH];
+
+void repo_diff(uint32_t r1, uint32_t r2)
+{
+	repo_diff_r(0,
+	            path_stack,
+	            repo_commit_root_dir(commit_pointer(r1)),
+	            repo_commit_root_dir(commit_pointer(r2)));
+}
+
+void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
+                 uint32_t url, unsigned long timestamp)
+{
+	fast_export_commit(revision, author, log, uuid, url, timestamp);
+	pool_commit();
+	dirent_commit();
+	dir_commit();
+	commit_commit();
+	active_commit = commit_alloc(1);
+	commit_pointer(active_commit)->root_dir_offset =
+		commit_pointer(active_commit - 1)->root_dir_offset;
+}
+
+static void mark_init(void)
+{
+	uint32_t i;
+	mark = 0;
+	for (i = 0; i < dirent_pool.size; i++)
+		if (!repo_dirent_is_dir(dirent_pointer(i)) &&
+		    dirent_pointer(i)->content_offset > mark)
+			mark = dirent_pointer(i)->content_offset;
+	mark++;
+}
+
+void repo_init() {
+	pool_init();
+	commit_init();
+	dir_init();
+	dirent_init();
+	mark_init();
+	if (commit_pool.size == 0) {
+		/* Create empty tree for commit 0. */
+		commit_alloc(1);
+		commit_pointer(0)->root_dir_offset = dir_alloc(1);
+		dir_pointer(0)->entries.trp_root = ~0;
+		dir_commit();
+		commit_commit();
+	}
+	/* Preallocate next commit, ready for changes. */
+	active_commit = commit_alloc(1);
+	commit_pointer(active_commit)->root_dir_offset =
+		commit_pointer(active_commit - 1)->root_dir_offset;
+}
+
+void repo_reset(void)
+{
+	pool_reset();
+	commit_reset();
+	dir_reset();
+	dirent_reset();
+}
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
new file mode 100644
index 0000000..92a7a7b
--- /dev/null
+++ b/vcs-svn/repo_tree.h
@@ -0,0 +1,26 @@
+#ifndef REPO_TREE_H_
+#define REPO_TREE_H_
+
+#include "git-compat-util.h"
+
+#define REPO_MODE_DIR 0040000
+#define REPO_MODE_BLB 0100644
+#define REPO_MODE_EXE 0100755
+#define REPO_MODE_LNK 0120000
+
+#define REPO_MAX_PATH_LEN 4096
+#define REPO_MAX_PATH_DEPTH 1000
+
+uint32_t next_blob_mark(void);
+uint32_t repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst);
+void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark);
+uint32_t repo_replace(uint32_t *path, uint32_t blob_mark);
+void repo_modify(uint32_t *path, uint32_t mode, uint32_t blob_mark);
+void repo_delete(uint32_t *path);
+void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
+                 uint32_t url, long unsigned timestamp);
+void repo_diff(uint32_t r1, uint32_t r2);
+void repo_init(void);
+void repo_reset(void);
+
+#endif
-- 
1.7.1
