From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/7] Add SVN revision parser and exporter
Date: Sun, 23 May 2010 23:40:31 +0200
Message-ID: <1274650832-7411-7-git-send-email-artagnon@gmail.com>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 23 23:39:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGItQ-0004R9-1e
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 23:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329Ab0EWVj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 17:39:26 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40688 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387Ab0EWVjW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 17:39:22 -0400
Received: by mail-wy0-f174.google.com with SMTP id 29so1098038wyb.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 14:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=L/7MwFRLL1x6vyX35x45+dHftMv5qDbWFuGgJajddkg=;
        b=Zd73E2fduDUNGzT7df+8iLvmLvsXKjIcNwS1RDYlK3n9ko0InDzAI8TAVd1ZUfC6Wo
         uHH5e4jLQf3hr13F7CmKcww8z+ECltHriYKVlM0KkDJbXl7t7zVe8jphLcuZG7AoAHiD
         stf0OqIwYobnK9HoH6EKxtzasvWT0htDH2AC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=j1u4woNyd9bP7ONk+BXgf7sc+Q1ReD7yToCQrpFTlfO6Y4su49QuOXYuexK7D70eY/
         0VbFusere/kozqZcASYzRvWQDtPVtBB20YlwWLuq+zHKeW0fGy7WL5WEfI4TIoP83CrX
         zmV4bn1bTnMCu7eUX2vvffYUziTd/FS0nSBLU=
Received: by 10.227.151.75 with SMTP id b11mr4480135wbw.184.1274650761825;
        Sun, 23 May 2010 14:39:21 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 15sm1592610ewy.0.2010.05.23.14.39.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 14:39:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147591>

repo_tree parses SVN revisions to build a Git objects, and use
fast_export to emit them so they can be imported into the Git object
store via a fast-import. Taken directly from David Michael Barr's
svn-dump-fast-export repository.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 vcs-svn/fast_export.c |   61 +++++++++
 vcs-svn/fast_export.h |   17 +++
 vcs-svn/repo_tree.c   |  333 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/repo_tree.h   |   31 +++++
 4 files changed, 442 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/fast_export.c
 create mode 100644 vcs-svn/fast_export.h
 create mode 100644 vcs-svn/repo_tree.c
 create mode 100644 vcs-svn/repo_tree.h

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
new file mode 100644
index 0000000..f4d9ab7
--- /dev/null
+++ b/vcs-svn/fast_export.c
@@ -0,0 +1,61 @@
+#include <string.h>
+
+#include "fast_export.h"
+#include "line_buffer.h"
+#include "repo_tree.h"
+#include "string_pool.h"
+
+#define MAX_GITSVN_LINE_LEN 4096
+
+void fast_export_delete(uint32_t depth, uint32_t *path)
+{
+    putchar('D');
+    putchar(' ');
+    pool_print_seq(depth, path, '/', stdout);
+    putchar('\n');
+}
+
+void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
+                        uint32_t mark)
+{
+    printf("M %06o :%d ", mode, mark);
+    pool_print_seq(depth, path, '/', stdout);
+    putchar('\n');
+}
+
+static char gitsvnline[MAX_GITSVN_LINE_LEN];
+void fast_export_commit(uint32_t revision, char *author, char *log,
+                        char *uuid, char *url, time_t timestamp)
+{
+    if (!author)
+        author = "nobody";
+    if (!log)
+        log = "";
+    if (uuid && url) {
+        snprintf(gitsvnline, MAX_GITSVN_LINE_LEN, "\n\ngit-svn-id: %s@%d %s\n",
+             url, revision, uuid);
+    } else {
+        *gitsvnline = '\0';
+    }
+    printf("commit refs/heads/master\nmark :%d\n", revision);
+    printf("committer %s <%s@%s> %ld +0000\n",
+         author, author, uuid ? uuid : "local", timestamp);
+    printf("data %ld\n%s%s\n",
+           strlen(log) + strlen(gitsvnline), log, gitsvnline);
+    repo_diff(revision - 1, revision);
+    fputc('\n', stdout);
+
+    printf("progress Imported commit %d.\n\n", revision);
+}
+
+void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len)
+{
+    if (mode == REPO_MODE_LNK) {
+        /* svn symlink blobs start with "link " */
+        buffer_skip_bytes(5);
+        len -= 5;
+    }
+    printf("blob\nmark :%d\ndata %d\n", mark, len);
+    buffer_copy_bytes(len);
+    fputc('\n', stdout);
+}
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
new file mode 100644
index 0000000..e84144e
--- /dev/null
+++ b/vcs-svn/fast_export.h
@@ -0,0 +1,17 @@
+#ifndef FAST_EXPORT_H_
+#define FAST_EXPORT_H_
+
+#include <stdint.h>
+#include <time.h>
+
+void fast_export_delete(uint32_t depth, uint32_t *path);
+
+void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
+                        uint32_t mark);
+
+void fast_export_commit(uint32_t revision, char *author, char *log,
+                        char *uuid, char *url, time_t timestamp);
+
+void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len);
+
+#endif
diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
new file mode 100644
index 0000000..7c4a70f
--- /dev/null
+++ b/vcs-svn/repo_tree.c
@@ -0,0 +1,333 @@
+#include <string.h>
+
+#include "string_pool.h"
+#include "repo_tree.h"
+#include "obj_pool.h"
+#include "fast_export.h"
+
+typedef struct repo_dirent_s repo_dirent_t;
+
+struct repo_dirent_s {
+    uint32_t name_offset;
+    uint32_t mode;
+    uint32_t content_offset;
+};
+
+typedef struct repo_dir_s repo_dir_t;
+
+struct repo_dir_s {
+    uint32_t size;
+    uint32_t first_offset;
+};
+
+typedef struct repo_commit_s repo_commit_t;
+
+struct repo_commit_s {
+    uint32_t mark;
+    uint32_t root_dir_offset;
+};
+
+/* Generate memory pools for commit, dir and dirent */
+obj_pool_gen(commit, repo_commit_t, 4096);
+obj_pool_gen(dir, repo_dir_t, 4096);
+obj_pool_gen(dirent, repo_dirent_t, 4096);
+
+static uint32_t num_dirs_saved = 0;
+static uint32_t num_dirents_saved = 0;
+static uint32_t active_commit = -1;
+
+static repo_dir_t *repo_commit_root_dir(repo_commit_t *commit)
+{
+    return dir_pointer(commit->root_dir_offset);
+}
+
+static repo_dirent_t *repo_first_dirent(repo_dir_t *dir)
+{
+    return dirent_pointer(dir->first_offset);
+}
+
+static int repo_dirent_name_cmp(const void *a, const void *b)
+{
+    return (((repo_dirent_t *) a)->name_offset
+            > ((repo_dirent_t *) b)->name_offset) -
+        (((repo_dirent_t *) a)->name_offset
+         < ((repo_dirent_t *) b)->name_offset);
+}
+
+static repo_dirent_t *repo_dirent_by_name(repo_dir_t *dir,
+                                          uint32_t name_offset)
+{
+    repo_dirent_t key;
+    if (dir == NULL || dir->size == 0)
+        return NULL;
+    key.name_offset = name_offset;
+    return bsearch(&key, repo_first_dirent(dir), dir->size,
+                   sizeof(repo_dirent_t), repo_dirent_name_cmp);
+}
+
+static int repo_dirent_is_dir(repo_dirent_t *dirent)
+{
+    return dirent != NULL && dirent->mode == REPO_MODE_DIR;
+}
+
+static repo_dir_t *repo_dir_from_dirent(repo_dirent_t *dirent)
+{
+    if (!repo_dirent_is_dir(dirent))
+        return NULL;
+    return dir_pointer(dirent->content_offset);
+}
+
+static uint32_t dir_with_dirents_alloc(uint32_t size)
+{
+    uint32_t offset = dir_alloc(1);
+    dir_pointer(offset)->size = size;
+    dir_pointer(offset)->first_offset = dirent_alloc(size);
+    return offset;
+}
+
+static repo_dir_t *repo_clone_dir(repo_dir_t *orig_dir, uint32_t padding)
+{
+    uint32_t orig_o, new_o, dirent_o;
+    orig_o = dir_offset(orig_dir);
+    if (orig_o < num_dirs_saved) {
+        new_o = dir_with_dirents_alloc(orig_dir->size + padding);
+        orig_dir = dir_pointer(orig_o);
+        dirent_o = dir_pointer(new_o)->first_offset;
+    } else {
+        if (padding == 0)
+            return orig_dir;
+        new_o = orig_o;
+        dirent_o = dirent_alloc(orig_dir->size + padding);
+    }
+    memcpy(dirent_pointer(dirent_o), repo_first_dirent(orig_dir),
+           orig_dir->size * sizeof(repo_dirent_t));
+    dir_pointer(new_o)->size = orig_dir->size + padding;
+    dir_pointer(new_o)->first_offset = dirent_o;
+    return dir_pointer(new_o);
+}
+
+static char repo_path_buffer[REPO_MAX_PATH_LEN];
+static repo_dirent_t *repo_read_dirent(uint32_t revision, char *path)
+{
+    char *ctx = NULL;
+    uint32_t name = 0;
+    repo_dir_t *dir = NULL;
+    repo_dirent_t *dirent = NULL;
+    dir = repo_commit_root_dir(commit_pointer(revision));
+    strncpy(repo_path_buffer, path, REPO_MAX_PATH_LEN);
+    repo_path_buffer[REPO_MAX_PATH_LEN - 1] = '\0';
+    path = repo_path_buffer;
+    for (name = pool_tok_r(path, "/", &ctx);
+         ~name; name = pool_tok_r(NULL, "/", &ctx)) {
+        dirent = repo_dirent_by_name(dir, name);
+        if (dirent == NULL) {
+            return NULL;
+        } else if (repo_dirent_is_dir(dirent)) {
+            dir = repo_dir_from_dirent(dirent);
+        } else {
+            break;
+        }
+    }
+    return dirent;
+}
+
+static void
+repo_write_dirent(char *path, uint32_t mode, uint32_t content_offset,
+                  uint32_t del)
+{
+    char *ctx;
+    uint32_t name, revision, dirent_o, dir_o, parent_dir_o;
+    repo_dir_t *dir;
+    repo_dirent_t *dirent = NULL;
+    revision = active_commit;
+    dir = repo_commit_root_dir(commit_pointer(revision));
+    dir = repo_clone_dir(dir, 0);
+    commit_pointer(revision)->root_dir_offset = dir_offset(dir);
+    strncpy(repo_path_buffer, path, REPO_MAX_PATH_LEN);
+    repo_path_buffer[REPO_MAX_PATH_LEN - 1] = '\0';
+    path = repo_path_buffer;
+    for (name = pool_tok_r(path, "/", &ctx); ~name;
+         name = pool_tok_r(NULL, "/", &ctx)) {
+        parent_dir_o = dir_offset(dir);
+        dirent = repo_dirent_by_name(dir, name);
+        if (dirent == NULL) {
+            dir = repo_clone_dir(dir, 1);
+            dirent = &repo_first_dirent(dir)[dir->size - 1];
+            dirent->name_offset = name;
+            dirent->mode = REPO_MODE_DIR;
+            qsort(repo_first_dirent(dir), dir->size,
+                  sizeof(repo_dirent_t), repo_dirent_name_cmp);
+            dirent = repo_dirent_by_name(dir, name);
+            dir_o = dir_with_dirents_alloc(0);
+            dirent->content_offset = dir_o;
+            dir = dir_pointer(dir_o);
+        } else if ((dir = repo_dir_from_dirent(dirent))) {
+            dirent_o = dirent_offset(dirent);
+            dir = repo_clone_dir(dir, 0);
+            if (dirent_o != ~0)
+                dirent_pointer(dirent_o)->content_offset = dir_offset(dir);
+        } else {
+            dirent->mode = REPO_MODE_DIR;
+            dirent_o = dirent_offset(dirent);
+            dir_o = dir_with_dirents_alloc(0);
+            dirent = dirent_pointer(dirent_o);
+            dir = dir_pointer(dir_o);
+            dirent->content_offset = dir_o;
+        }
+    }
+    if (dirent) {
+        dirent->mode = mode;
+        dirent->content_offset = content_offset;
+        if (del && ~parent_dir_o) {
+            dirent->name_offset = ~0;
+            dir = dir_pointer(parent_dir_o);
+            qsort(repo_first_dirent(dir), dir->size,
+                  sizeof(repo_dirent_t), repo_dirent_name_cmp);
+            dir->size--;
+        }
+    }
+}
+
+uint32_t repo_copy(uint32_t revision, char *src, char *dst)
+{
+    uint32_t mode = 0, content_offset = 0;
+    repo_dirent_t *src_dirent;
+    src_dirent = repo_read_dirent(revision, src);
+    if (src_dirent != NULL) {
+        mode = src_dirent->mode;
+        content_offset = src_dirent->content_offset;
+        repo_write_dirent(dst, mode, content_offset, 0);
+    }
+    return mode;
+}
+
+void repo_add(char *path, uint32_t mode, uint32_t blob_mark)
+{
+    repo_write_dirent(path, mode, blob_mark, 0);
+}
+
+uint32_t repo_replace(char *path, uint32_t blob_mark)
+{
+    uint32_t mode = 0;
+    repo_dirent_t *src_dirent;
+    src_dirent = repo_read_dirent(active_commit, path);
+    if (src_dirent != NULL) {
+        mode = src_dirent->mode;
+        repo_write_dirent(path, mode, blob_mark, 0);
+    }
+    return mode;
+}
+
+void repo_modify(char *path, uint32_t mode, uint32_t blob_mark)
+{
+    repo_write_dirent(path, mode, blob_mark, 0);
+}
+
+void repo_delete(char *path)
+{
+    repo_write_dirent(path, 0, 0, 1);
+}
+
+static void
+repo_git_add_r(uint32_t depth, uint32_t *path, repo_dir_t *dir);
+
+static void
+repo_git_add(uint32_t depth, uint32_t *path, repo_dirent_t *dirent)
+{
+    if (repo_dirent_is_dir(dirent)) {
+        repo_git_add_r(depth, path, repo_dir_from_dirent(dirent));
+    } else {
+        fast_export_modify(depth, path, dirent->mode, dirent->content_offset);
+    }
+}
+
+static void
+repo_git_add_r(uint32_t depth, uint32_t *path, repo_dir_t *dir)
+{
+    uint32_t o;
+    repo_dirent_t *de;
+    de = repo_first_dirent(dir);
+    for (o = 0; o < dir->size; o++) {
+        path[depth] = de[o].name_offset;
+        repo_git_add(depth + 1, path, &de[o]);
+    }
+}
+
+static void
+repo_diff_r(uint32_t depth, uint32_t *path, repo_dir_t *dir1,
+            repo_dir_t *dir2)
+{
+    repo_dirent_t *de1, *de2, *max_de1, *max_de2;
+    de1 = repo_first_dirent(dir1);
+    de2 = repo_first_dirent(dir2);
+    max_de1 = &de1[dir1->size];
+    max_de2 = &de2[dir2->size];
+
+    while (de1 < max_de1 && de2 < max_de2) {
+        if (de1->name_offset < de2->name_offset) {
+            path[depth] = (de1++)->name_offset;
+            fast_export_delete(depth + 1, path);
+        } else if (de1->name_offset == de2->name_offset) {
+            path[depth] = de1->name_offset;
+            if (de1->content_offset != de2->content_offset) {
+                if (repo_dirent_is_dir(de1) && repo_dirent_is_dir(de2)) {
+                    repo_diff_r(depth + 1, path,
+                                repo_dir_from_dirent(de1),
+                                repo_dir_from_dirent(de2));
+                } else {
+                    if (repo_dirent_is_dir(de1) != repo_dirent_is_dir(de2)) {
+                        fast_export_delete(depth + 1, path);
+                    }
+                    repo_git_add(depth + 1, path, de2);
+                }
+            }
+            de1++;
+            de2++;
+        } else {
+            path[depth] = de2->name_offset;
+            repo_git_add(depth + 1, path, de2++);
+        }
+    }
+    while (de1 < max_de1) {
+        path[depth] = (de1++)->name_offset;
+        fast_export_delete(depth + 1, path);
+    }
+    while (de2 < max_de2) {
+        path[depth] = de2->name_offset;
+        repo_git_add(depth + 1, path, de2++);
+    }
+}
+
+static uint32_t path_stack[1000];
+void repo_diff(uint32_t r1, uint32_t r2)
+{
+    repo_diff_r(0,
+                path_stack,
+                repo_commit_root_dir(commit_pointer(r1)),
+                repo_commit_root_dir(commit_pointer(r2)));
+}
+
+void repo_commit(uint32_t revision, char *author, char *log, char *uuid,
+                 char *url, time_t timestamp)
+{
+    if (revision == 0) {
+        active_commit = commit_alloc(1);
+        commit_pointer(active_commit)->root_dir_offset =
+            dir_with_dirents_alloc(0);
+    } else {
+        fast_export_commit(revision, author, log, uuid, url, timestamp);
+    }
+    num_dirs_saved = dir_pool.size;
+    num_dirents_saved = dirent_pool.size;
+    active_commit = commit_alloc(1);
+    commit_pointer(active_commit)->root_dir_offset =
+        commit_pointer(active_commit - 1)->root_dir_offset;
+}
+
+void repo_reset(void)
+{
+    pool_reset();
+    commit_reset();
+    dir_reset();
+    dirent_reset();
+}
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
new file mode 100644
index 0000000..2d645dc
--- /dev/null
+++ b/vcs-svn/repo_tree.h
@@ -0,0 +1,31 @@
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
+
+uint32_t repo_copy(uint32_t revision, char *src, char *dst);
+
+void repo_add(char *path, uint32_t mode, uint32_t blob_mark);
+
+uint32_t repo_replace(char *path, uint32_t blob_mark);
+
+void repo_modify(char *path, uint32_t mode, uint32_t blob_mark);
+
+void repo_delete(char *path);
+
+void repo_commit(uint32_t revision, char *author, char *log, char *uuid,
+                 char *url, time_t timestamp);
+
+void repo_diff(uint32_t r1, uint32_t r2);
+
+void repo_reset(void);
+
+#endif
-- 
1.7.1
