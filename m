From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/6] Add infrastructure to write revisions in fast-export format
Date: Fri,  4 Jun 2010 15:41:10 +0200
Message-ID: <1275658871-1473-6-git-send-email-artagnon@gmail.com>
References: <1275658871-1473-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 04 15:40:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKX8O-0005nH-D0
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 15:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217Ab0FDNkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 09:40:05 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:41712 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172Ab0FDNkA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 09:40:00 -0400
Received: by mail-ew0-f223.google.com with SMTP id 23so312332ewy.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 06:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2+JsM4MwLYIxTw3OI+SNjTn7rsGv3FrQsKjej3fv7BI=;
        b=EKW3FVPCumKK6J/UKorJiu9RzJVaEGcPSsZsR+xywWiuk4fV6fBlEvfNLFHjHIB46o
         freyGSs9lXF2NR3uJ8g8yZGKhVRnvQdsHn+fgH3iZjb7mwpVIzMkTcPoPqRfGxTt7kyx
         c+ASoAF3jbLHvGu2VRNcA8P9CLy3Jo7OF5w8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LRgn+ordIS7bvebCwbrW47csz+PuOCMZ1scHG4SEa8VZxi9J3IhvB/w+MA5+Q5KeN/
         FPlDh6ax4zrvru+J9lIvxV7oxgFbHPHqZArTr+xO59k0TVGBk6+0bbSjSDzXbAH1Z7TN
         9qunpagLD+Zxl8D2aBFg9i1KD6ytrw6OCEP/E=
Received: by 10.213.108.73 with SMTP id e9mr7870411ebp.42.1275658798203;
        Fri, 04 Jun 2010 06:39:58 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 14sm740256ewy.14.2010.06.04.06.39.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 06:39:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275658871-1473-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148413>

From: David Barr <david.barr@cordelta.com>

repo_tree maintains the exporter's state and provides a facility to
to call fast_export, which then writes objects to stdout suitable for
consumption by git-fast-import.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 vcs-svn/fast_export.c |   69 ++++++++++
 vcs-svn/fast_export.h |   14 ++
 vcs-svn/repo_tree.c   |  353 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/repo_tree.h   |   27 ++++
 4 files changed, 463 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/fast_export.c
 create mode 100644 vcs-svn/fast_export.h
 create mode 100644 vcs-svn/repo_tree.c
 create mode 100644 vcs-svn/repo_tree.h

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
new file mode 100644
index 0000000..e5eb409
--- /dev/null
+++ b/vcs-svn/fast_export.c
@@ -0,0 +1,69 @@
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
+	printf("M %06o :%d ", mode, mark);
+	pool_print_seq(depth, path, '/', stdout);
+	putchar('\n');
+}
+
+static char gitsvnline[MAX_GITSVN_LINE_LEN];
+void fast_export_commit(uint32_t revision, uint32_t author, char *log,
+                        uint32_t uuid, uint32_t url,
+                        unsigned long timestamp)
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
index 0000000..e9ea3ed
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
+                        uint32_t mark);
+void fast_export_commit(uint32_t revision, uint32_t author, char *log,
+                        uint32_t uuid, uint32_t url, unsigned long timestamp);
+void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len);
+
+#endif
diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
new file mode 100644
index 0000000..5dfffb8
--- /dev/null
+++ b/vcs-svn/repo_tree.c
@@ -0,0 +1,353 @@
+#include "git-compat-util.h"
+
+#include "string_pool.h"
+#include "repo_tree.h"
+#include "obj_pool.h"
+#include "fast_export.h"
+
+struct repo_dirent {
+	uint32_t name_offset;
+	uint32_t mode;
+	uint32_t content_offset;
+};
+
+struct repo_dir {
+	uint32_t size;
+	uint32_t first_offset;
+};
+
+struct repo_commit {
+	uint32_t mark;
+	uint32_t root_dir_offset;
+};
+
+/* Generate memory pools for commit, dir and dirent */
+obj_pool_gen(commit, struct repo_commit, 4096);
+obj_pool_gen(dir, struct repo_dir, 4096);
+obj_pool_gen(dirent, struct repo_dirent, 4096);
+
+static uint32_t num_dirs_saved;
+static uint32_t num_dirents_saved;
+static uint32_t active_commit;
+static uint32_t _mark;
+
+uint32_t next_blob_mark(void)
+{
+	return _mark++;
+}
+
+static struct repo_dir *repo_commit_root_dir(struct repo_commit *commit)
+{
+	return dir_pointer(commit->root_dir_offset);
+}
+
+static struct repo_dirent *repo_first_dirent(struct repo_dir *dir)
+{
+	return dirent_pointer(dir->first_offset);
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
+static struct repo_dirent *repo_dirent_by_name(struct repo_dir *dir,
+                                          uint32_t name_offset)
+{
+	struct repo_dirent key;
+	if (dir == NULL || dir->size == 0)
+		return NULL;
+	key.name_offset = name_offset;
+	return bsearch(&key, repo_first_dirent(dir), dir->size,
+				   sizeof(struct repo_dirent), repo_dirent_name_cmp);
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
+static uint32_t dir_with_dirents_alloc(uint32_t size)
+{
+	uint32_t offset = dir_alloc(1);
+	dir_pointer(offset)->size = size;
+	dir_pointer(offset)->first_offset = dirent_alloc(size);
+	return offset;
+}
+
+static struct repo_dir *repo_clone_dir(struct repo_dir *orig_dir, uint32_t padding)
+{
+	uint32_t orig_o, new_o, dirent_o;
+	orig_o = dir_offset(orig_dir);
+	if (orig_o < num_dirs_saved) {
+		new_o = dir_with_dirents_alloc(orig_dir->size + padding);
+		orig_dir = dir_pointer(orig_o);
+		dirent_o = dir_pointer(new_o)->first_offset;
+	} else {
+		if (padding == 0)
+			return orig_dir;
+		new_o = orig_o;
+		dirent_o = dirent_alloc(orig_dir->size + padding);
+	}
+	memcpy(dirent_pointer(dirent_o), repo_first_dirent(orig_dir),
+		   orig_dir->size * sizeof(struct repo_dirent));
+	dir_pointer(new_o)->size = orig_dir->size + padding;
+	dir_pointer(new_o)->first_offset = dirent_o;
+	return dir_pointer(new_o);
+}
+
+static struct repo_dirent *repo_read_dirent(uint32_t revision, uint32_t *path)
+{
+	uint32_t name = 0;
+	struct repo_dir *dir = NULL;
+	struct repo_dirent *dirent = NULL;
+	dir = repo_commit_root_dir(commit_pointer(revision));
+	while (~(name = *path++)) {
+		dirent = repo_dirent_by_name(dir, name);
+		if (dirent == NULL) {
+			return NULL;
+		} else if (repo_dirent_is_dir(dirent)) {
+			dir = repo_dir_from_dirent(dirent);
+		} else {
+			break;
+		}
+	}
+	return dirent;
+}
+
+static void
+repo_write_dirent(uint32_t *path, uint32_t mode, uint32_t content_offset,
+                  uint32_t del)
+{
+	uint32_t name, revision, dirent_o = ~0, dir_o = ~0, parent_dir_o = ~0;
+	struct repo_dir *dir;
+	struct repo_dirent *dirent = NULL;
+	revision = active_commit;
+	dir = repo_commit_root_dir(commit_pointer(revision));
+	dir = repo_clone_dir(dir, 0);
+	commit_pointer(revision)->root_dir_offset = dir_offset(dir);
+	while (~(name = *path++)) {
+		parent_dir_o = dir_offset(dir);
+		dirent = repo_dirent_by_name(dir, name);
+		if (dirent == NULL) {
+			dir = repo_clone_dir(dir, 1);
+			dirent = &repo_first_dirent(dir)[dir->size - 1];
+			dirent->name_offset = name;
+			dirent->mode = REPO_MODE_DIR;
+			qsort(repo_first_dirent(dir), dir->size,
+				  sizeof(struct repo_dirent), repo_dirent_name_cmp);
+			dirent = repo_dirent_by_name(dir, name);
+			dir_o = dir_with_dirents_alloc(0);
+			dirent->content_offset = dir_o;
+			dir = dir_pointer(dir_o);
+		} else if ((dir = repo_dir_from_dirent(dirent))) {
+			dirent_o = dirent_offset(dirent);
+			dir = repo_clone_dir(dir, 0);
+			if (dirent_o != ~0)
+				dirent_pointer(dirent_o)->content_offset = dir_offset(dir);
+		} else {
+			dirent->mode = REPO_MODE_DIR;
+			dirent_o = dirent_offset(dirent);
+			dir_o = dir_with_dirents_alloc(0);
+			dirent = dirent_pointer(dirent_o);
+			dir = dir_pointer(dir_o);
+			dirent->content_offset = dir_o;
+		}
+	}
+	if (dirent) {
+		dirent->mode = mode;
+		dirent->content_offset = content_offset;
+		if (del && ~parent_dir_o) {
+			dirent->name_offset = ~0;
+			dir = dir_pointer(parent_dir_o);
+			qsort(repo_first_dirent(dir), dir->size,
+				  sizeof(struct repo_dirent), repo_dirent_name_cmp);
+			dir->size--;
+		}
+	}
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
+	if (src_dirent != NULL && blob_mark == 0) {
+		blob_mark = src_dirent->content_offset;
+	}
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
+	if (repo_dirent_is_dir(dirent)) {
+		repo_git_add_r(depth, path, repo_dir_from_dirent(dirent));
+	} else {
+		fast_export_modify(depth, path, dirent->mode, dirent->content_offset);
+	}
+}
+
+static void repo_git_add_r(uint32_t depth, uint32_t *path, struct repo_dir *dir)
+{
+	uint32_t o;
+	struct repo_dirent *de;
+	de = repo_first_dirent(dir);
+	for (o = 0; o < dir->size; o++) {
+		path[depth] = de[o].name_offset;
+		repo_git_add(depth + 1, path, &de[o]);
+	}
+}
+
+static void repo_diff_r(uint32_t depth, uint32_t *path, struct repo_dir *dir1,
+			struct repo_dir *dir2)
+{
+	struct repo_dirent *de1, *de2, *max_de1, *max_de2;
+	de1 = repo_first_dirent(dir1);
+	de2 = repo_first_dirent(dir2);
+	max_de1 = &de1[dir1->size];
+	max_de2 = &de2[dir2->size];
+
+	while (de1 < max_de1 && de2 < max_de2) {
+		if (de1->name_offset < de2->name_offset) {
+			path[depth] = (de1++)->name_offset;
+			fast_export_delete(depth + 1, path);
+		} else if (de1->name_offset > de2->name_offset) {
+			path[depth] = de2->name_offset;
+			repo_git_add(depth + 1, path, de2++);
+		} else {
+			path[depth] = de1->name_offset;
+			if (de1->mode != de2->mode ||
+				de1->content_offset != de2->content_offset) {
+				if (repo_dirent_is_dir(de1) && repo_dirent_is_dir(de2)) {
+					repo_diff_r(depth + 1, path,
+								repo_dir_from_dirent(de1),
+								repo_dir_from_dirent(de2));
+				} else {
+					if (repo_dirent_is_dir(de1) != repo_dirent_is_dir(de2)) {
+						fast_export_delete(depth + 1, path);
+					}
+					repo_git_add(depth + 1, path, de2);
+				}
+			}
+			de1++;
+			de2++;
+		}
+	}
+	while (de1 < max_de1) {
+		path[depth] = (de1++)->name_offset;
+		fast_export_delete(depth + 1, path);
+	}
+	while (de2 < max_de2) {
+		path[depth] = de2->name_offset;
+		repo_git_add(depth + 1, path, de2++);
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
+	num_dirs_saved = dir_pool.size;
+	num_dirents_saved = dirent_pool.size;
+	active_commit = commit_alloc(1);
+	commit_pointer(active_commit)->root_dir_offset =
+		commit_pointer(active_commit - 1)->root_dir_offset;
+}
+
+static void mark_init(void)
+{
+	uint32_t i;
+	_mark = 0;
+	for (i = 0; i < dirent_pool.size; i++)
+		if (!repo_dirent_is_dir(dirent_pointer(i)) &&
+			dirent_pointer(i)->content_offset > _mark)
+			_mark = dirent_pointer(i)->content_offset;
+	_mark++;
+}
+
+void repo_init() {
+	pool_init();
+	commit_init();
+	dir_init();
+	dirent_init();
+	mark_init();
+	num_dirs_saved = dir_pool.size;
+	num_dirents_saved = dirent_pool.size;
+	active_commit = commit_pool.size - 1;
+	if (active_commit == -1) {
+		commit_alloc(2);
+		/* Create empty tree for commit 0. */
+		commit_pointer(0)->root_dir_offset =
+			dir_with_dirents_alloc(0);
+		/* Preallocate commit 1, ready for changes. */
+		commit_pointer(1)->root_dir_offset =
+			commit_pointer(0)->root_dir_offset;
+		active_commit = 1;
+		num_dirs_saved = dir_pool.size;
+		num_dirents_saved = dirent_pool.size;
+	}
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
index 0000000..c49b65a
--- /dev/null
+++ b/vcs-svn/repo_tree.h
@@ -0,0 +1,27 @@
+#ifndef REPO_TREE_H_
+#define REPO_TREE_H_
+
+#include <stdint.h>
+#include <time.h>
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
