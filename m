From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/12] vcs-svn: eliminate repo_tree structure
Date: Sun, 6 Mar 2011 17:12:12 -0600
Message-ID: <20110306231212.GK24327@elie>
References: <20101210102007.GA26298@burratino>
 <20110306225419.GA24327@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 00:12:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwN7h-00014U-9h
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 00:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413Ab1CFXMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 18:12:21 -0500
Received: from mail-gw0-f51.google.com ([74.125.83.51]:48402 "EHLO
	mail-gw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901Ab1CFXMT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 18:12:19 -0500
Received: by gwb15 with SMTP id 15so2203808gwb.10
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 15:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=8ISeZ7gBaKy+jtn8vdVruXCButIZxhun5fg6LJOHj4M=;
        b=lW8rfnaRXI5d6/3C6ucrQCS8ErdKhH6l69RrfThRm6OH2b3J22utO24mDhZQjmVlcj
         1l4RlaBT7qnBv/QTIGMuo+3m3+VUgXTFzgu79W113swLorbaLlUL+cTjX7R+osexSphi
         JSIk4AaK67U2ImGH1ZpLzKyoFL2r2cwcJJdFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gG6a/VEKxd6uO6n0Rlluly77yFs4UNndGYBPM16E/s6GKDuFJ8/0AWVNI0XJogu6iZ
         9d4E4o5TYOMWqF47T1auiDTIT8sgfcT3L1MC0rxuWXslG5azbWNDk/sQ0GSjM91MAcBv
         j9K/+H6q0DkQ7GJgSboAu/PbZRtn7LiTqO5OI=
Received: by 10.151.5.14 with SMTP id h14mr3739250ybi.138.1299453138671;
        Sun, 06 Mar 2011 15:12:18 -0800 (PST)
Received: from elie (adsl-69-209-66-207.dsl.chcgil.ameritech.net [69.209.66.207])
        by mx.google.com with ESMTPS id v13sm1252494ybk.6.2011.03.06.15.12.15
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 15:12:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110306225419.GA24327@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168556>

Date: Fri, 10 Dec 2010 04:00:55 -0600

Rely on fast-import for information about previous revs.

This requires always setting up backward flow of information, even for
v2 dumps.  On the plus side, it simplifies the code by quite a bit and
opens the door to further simplifications.

[db: adjusted to support final version of the cat-blob patch]
[jn: avoiding hard-coding git's name for the empty tree for
 portability to other backends]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/fast_export.c |  108 ++++++++++++--
 vcs-svn/fast_export.h |   44 +++---
 vcs-svn/repo_tree.c   |  389 ++++++++-----------------------------------------
 vcs-svn/repo_tree.h   |    2 +-
 vcs-svn/string_pool.c |    2 +-
 vcs-svn/string_pool.h |    2 +-
 vcs-svn/svndump.c     |   53 +++++--
 7 files changed, 222 insertions(+), 378 deletions(-)
 rewrite vcs-svn/fast_export.h (65%)
 rewrite vcs-svn/repo_tree.c (95%)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 8786ed2..a8ce5c6 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -8,6 +8,7 @@
 #include "line_buffer.h"
 #include "repo_tree.h"
 #include "string_pool.h"
+#include "strbuf.h"
 
 #define MAX_GITSVN_LINE_LEN 4096
 
@@ -31,7 +32,7 @@ void fast_export_reset(void)
 	buffer_reset(&report_buffer);
 }
 
-void fast_export_delete(uint32_t depth, uint32_t *path)
+void fast_export_delete(uint32_t depth, const uint32_t *path)
 {
 	putchar('D');
 	putchar(' ');
@@ -39,22 +40,27 @@ void fast_export_delete(uint32_t depth, uint32_t *path)
 	putchar('\n');
 }
 
-void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
-			uint32_t mark)
+static void fast_export_truncate(uint32_t depth, const uint32_t *path, uint32_t mode)
+{
+	fast_export_modify(depth, path, mode, "inline");
+	printf("data 0\n\n");
+}
+
+void fast_export_modify(uint32_t depth, const uint32_t *path, uint32_t mode,
+			const char *dataref)
 {
 	/* Mode must be 100644, 100755, 120000, or 160000. */
-	printf("M %06"PRIo32" :%"PRIu32" ", mode, mark);
+	if (!dataref) {
+		fast_export_truncate(depth, path, mode);
+		return;
+	}
+	printf("M %06"PRIo32" %s ", mode, dataref);
 	pool_print_seq(depth, path, '/', stdout);
 	putchar('\n');
 }
 
-void fast_export_begin_commit(uint32_t revision)
-{
-	printf("# commit %"PRIu32".\n", revision);
-}
-
 static char gitsvnline[MAX_GITSVN_LINE_LEN];
-void fast_export_commit(uint32_t revision, uint32_t author, char *log,
+void fast_export_begin_commit(uint32_t revision, uint32_t author, char *log,
 			uint32_t uuid, uint32_t url,
 			unsigned long timestamp)
 {
@@ -81,12 +87,31 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 			printf("from refs/heads/master^0\n");
 		first_commit_done = 1;
 	}
-	repo_diff(revision - 1, revision);
-	fputc('\n', stdout);
+}
 
+void fast_export_end_commit(uint32_t revision)
+{
 	printf("progress Imported commit %"PRIu32".\n\n", revision);
 }
 
+static void ls_from_rev(uint32_t rev, uint32_t depth, const uint32_t *path)
+{
+	/* ls :5 path/to/old/file */
+	printf("ls :%"PRIu32" ", rev);
+	pool_print_seq(depth, path, '/', stdout);
+	putchar('\n');
+	fflush(stdout);
+}
+
+static void ls_from_active_commit(uint32_t depth, const uint32_t *path)
+{
+	/* ls "path/to/file" */
+	printf("ls \"");
+	pool_print_seq(depth, path, '/', stdout);
+	printf("\"\n");
+	fflush(stdout);
+}
+
 static const char *get_response_line(void)
 {
 	const char *line = buffer_read_line(&report_buffer);
@@ -97,14 +122,69 @@ static const char *get_response_line(void)
 	die("unexpected end of fast-import feedback");
 }
 
-void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len, struct line_buffer *input)
+void fast_export_data(uint32_t mode, uint32_t len, struct line_buffer *input)
 {
 	if (mode == REPO_MODE_LNK) {
 		/* svn symlink blobs start with "link " */
 		buffer_skip_bytes(input, 5);
 		len -= 5;
 	}
-	printf("blob\nmark :%"PRIu32"\ndata %"PRIu32"\n", mark, len);
+	printf("data %"PRIu32"\n", len);
 	buffer_copy_bytes(input, len);
 	fputc('\n', stdout);
 }
+
+static int parse_ls_response(const char *response, uint32_t *mode,
+					struct strbuf *dataref)
+{
+	const char *tab;
+	const char *response_end;
+
+	assert(response);
+	response_end = response + strlen(response);
+
+	if (*response == 'm') {	/* Missing. */
+		errno = ENOENT;
+		return -1;
+	}
+
+	/* Mode. */
+	if (response_end - response < strlen("100644") ||
+	    response[strlen("100644")] != ' ')
+		die("invalid ls response: missing mode: %s", response);
+	*mode = 0;
+	for (; *response != ' '; response++) {
+		char ch = *response;
+		if (ch < '0' || ch > '7')
+			die("invalid ls response: mode is not octal: %s", response);
+		*mode *= 8;
+		*mode += ch - '0';
+	}
+
+	/* ' blob ' or ' tree ' */
+	if (response_end - response < strlen(" blob ") ||
+	    (response[1] != 'b' && response[1] != 't'))
+		die("unexpected ls response: not a tree or blob: %s", response);
+	response += strlen(" blob ");
+
+	/* Dataref. */
+	tab = memchr(response, '\t', response_end - response);
+	if (!tab)
+		die("invalid ls response: missing tab: %s", response);
+	strbuf_add(dataref, response, tab - response);
+	return 0;
+}
+
+int fast_export_ls_rev(uint32_t rev, uint32_t depth, const uint32_t *path,
+				uint32_t *mode, struct strbuf *dataref)
+{
+	ls_from_rev(rev, depth, path);
+	return parse_ls_response(get_response_line(), mode, dataref);
+}
+
+int fast_export_ls(uint32_t depth, const uint32_t *path,
+				uint32_t *mode, struct strbuf *dataref)
+{
+	ls_from_active_commit(depth, path);
+	return parse_ls_response(get_response_line(), mode, dataref);
+}
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
dissimilarity index 65%
index 09b2033..633d219 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -1,19 +1,25 @@
-#ifndef FAST_EXPORT_H_
-#define FAST_EXPORT_H_
-
-#include "line_buffer.h"
-
-void fast_export_init(int fd);
-void fast_export_deinit(void);
-void fast_export_reset(void);
-
-void fast_export_delete(uint32_t depth, uint32_t *path);
-void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
-			uint32_t mark);
-void fast_export_begin_commit(uint32_t revision);
-void fast_export_commit(uint32_t revision, uint32_t author, char *log,
-			uint32_t uuid, uint32_t url, unsigned long timestamp);
-void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
-		      struct line_buffer *input);
-
-#endif
+#ifndef FAST_EXPORT_H_
+#define FAST_EXPORT_H_
+
+struct strbuf;
+struct line_buffer;
+
+void fast_export_init(int fd);
+void fast_export_deinit(void);
+void fast_export_reset(void);
+
+void fast_export_delete(uint32_t depth, const uint32_t *path);
+void fast_export_modify(uint32_t depth, const uint32_t *path,
+			uint32_t mode, const char *dataref);
+void fast_export_begin_commit(uint32_t revision, uint32_t author, char *log,
+			uint32_t uuid, uint32_t url, unsigned long timestamp);
+void fast_export_end_commit(uint32_t revision);
+void fast_export_data(uint32_t mode, uint32_t len, struct line_buffer *input);
+
+/* If there is no such file at that rev, returns -1, errno == ENOENT. */
+int fast_export_ls_rev(uint32_t rev, uint32_t depth, const uint32_t *path,
+			uint32_t *mode_out, struct strbuf *dataref_out);
+int fast_export_ls(uint32_t depth, const uint32_t *path,
+			uint32_t *mode_out, struct strbuf *dataref_out);
+
+#endif
diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
dissimilarity index 95%
index 036a686..e75f580 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -1,325 +1,64 @@
-/*
- * Licensed under a two-clause BSD-style license.
- * See LICENSE for details.
- */
-
-#include "git-compat-util.h"
-
-#include "string_pool.h"
-#include "repo_tree.h"
-#include "obj_pool.h"
-#include "fast_export.h"
-
-#include "trp.h"
-
-struct repo_dirent {
-	uint32_t name_offset;
-	struct trp_node children;
-	uint32_t mode;
-	uint32_t content_offset;
-};
-
-struct repo_dir {
-	struct trp_root entries;
-};
-
-struct repo_commit {
-	uint32_t root_dir_offset;
-};
-
-/* Memory pools for commit, dir and dirent */
-obj_pool_gen(commit, struct repo_commit, 4096)
-obj_pool_gen(dir, struct repo_dir, 4096)
-obj_pool_gen(dent, struct repo_dirent, 4096)
-
-static uint32_t active_commit;
-static uint32_t mark;
-
-static int repo_dirent_name_cmp(const void *a, const void *b);
-
-/* Treap for directory entries */
-trp_gen(static, dent_, struct repo_dirent, children, dent, repo_dirent_name_cmp);
-
-uint32_t next_blob_mark(void)
-{
-	return mark++;
-}
-
-static struct repo_dir *repo_commit_root_dir(struct repo_commit *commit)
-{
-	return dir_pointer(commit->root_dir_offset);
-}
-
-static struct repo_dirent *repo_first_dirent(struct repo_dir *dir)
-{
-	return dent_first(&dir->entries);
-}
-
-static int repo_dirent_name_cmp(const void *a, const void *b)
-{
-	const struct repo_dirent *dent1 = a, *dent2 = b;
-	uint32_t a_offset = dent1->name_offset;
-	uint32_t b_offset = dent2->name_offset;
-	return (a_offset > b_offset) - (a_offset < b_offset);
-}
-
-static int repo_dirent_is_dir(struct repo_dirent *dent)
-{
-	return dent != NULL && dent->mode == REPO_MODE_DIR;
-}
-
-static struct repo_dir *repo_dir_from_dirent(struct repo_dirent *dent)
-{
-	if (!repo_dirent_is_dir(dent))
-		return NULL;
-	return dir_pointer(dent->content_offset);
-}
-
-static struct repo_dir *repo_clone_dir(struct repo_dir *orig_dir)
-{
-	uint32_t orig_o, new_o;
-	orig_o = dir_offset(orig_dir);
-	if (orig_o >= dir_pool.committed)
-		return orig_dir;
-	new_o = dir_alloc(1);
-	orig_dir = dir_pointer(orig_o);
-	*dir_pointer(new_o) = *orig_dir;
-	return dir_pointer(new_o);
-}
-
-static struct repo_dirent *repo_read_dirent(uint32_t revision,
-					    const uint32_t *path)
-{
-	uint32_t name = 0;
-	struct repo_dirent *key = dent_pointer(dent_alloc(1));
-	struct repo_dir *dir = NULL;
-	struct repo_dirent *dent = NULL;
-	dir = repo_commit_root_dir(commit_pointer(revision));
-	while (~(name = *path++)) {
-		key->name_offset = name;
-		dent = dent_search(&dir->entries, key);
-		if (dent == NULL || !repo_dirent_is_dir(dent))
-			break;
-		dir = repo_dir_from_dirent(dent);
-	}
-	dent_free(1);
-	return dent;
-}
-
-static void repo_write_dirent(const uint32_t *path, uint32_t mode,
-			      uint32_t content_offset, uint32_t del)
-{
-	uint32_t name, revision, dir_o = ~0, parent_dir_o = ~0;
-	struct repo_dir *dir;
-	struct repo_dirent *key;
-	struct repo_dirent *dent = NULL;
-	revision = active_commit;
-	dir = repo_commit_root_dir(commit_pointer(revision));
-	dir = repo_clone_dir(dir);
-	commit_pointer(revision)->root_dir_offset = dir_offset(dir);
-	while (~(name = *path++)) {
-		parent_dir_o = dir_offset(dir);
-
-		key = dent_pointer(dent_alloc(1));
-		key->name_offset = name;
-
-		dent = dent_search(&dir->entries, key);
-		if (dent == NULL)
-			dent = key;
-		else
-			dent_free(1);
-
-		if (dent == key) {
-			dent->mode = REPO_MODE_DIR;
-			dent->content_offset = 0;
-			dent = dent_insert(&dir->entries, dent);
-		}
-
-		if (dent_offset(dent) < dent_pool.committed) {
-			dir_o = repo_dirent_is_dir(dent) ?
-					dent->content_offset : ~0;
-			dent_remove(&dir->entries, dent);
-			dent = dent_pointer(dent_alloc(1));
-			dent->name_offset = name;
-			dent->mode = REPO_MODE_DIR;
-			dent->content_offset = dir_o;
-			dent = dent_insert(&dir->entries, dent);
-		}
-
-		dir = repo_dir_from_dirent(dent);
-		dir = repo_clone_dir(dir);
-		dent->content_offset = dir_offset(dir);
-	}
-	if (dent == NULL)
-		return;
-	dent->mode = mode;
-	dent->content_offset = content_offset;
-	if (del && ~parent_dir_o)
-		dent_remove(&dir_pointer(parent_dir_o)->entries, dent);
-}
-
-uint32_t repo_read_path(const uint32_t *path)
-{
-	uint32_t content_offset = 0;
-	struct repo_dirent *dent = repo_read_dirent(active_commit, path);
-	if (dent != NULL)
-		content_offset = dent->content_offset;
-	return content_offset;
-}
-
-uint32_t repo_read_mode(const uint32_t *path)
-{
-	struct repo_dirent *dent = repo_read_dirent(active_commit, path);
-	if (dent == NULL)
-		die("invalid dump: path to be modified is missing");
-	return dent->mode;
-}
-
-void repo_copy(uint32_t revision, const uint32_t *src, const uint32_t *dst)
-{
-	uint32_t mode = 0, content_offset = 0;
-	struct repo_dirent *src_dent;
-	src_dent = repo_read_dirent(revision, src);
-	if (src_dent != NULL) {
-		mode = src_dent->mode;
-		content_offset = src_dent->content_offset;
-		repo_write_dirent(dst, mode, content_offset, 0);
-	}
-}
-
-void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark)
-{
-	repo_write_dirent(path, mode, blob_mark, 0);
-}
-
-void repo_delete(uint32_t *path)
-{
-	repo_write_dirent(path, 0, 0, 1);
-}
-
-static void repo_git_add_r(uint32_t depth, uint32_t *path, struct repo_dir *dir);
-
-static void repo_git_add(uint32_t depth, uint32_t *path, struct repo_dirent *dent)
-{
-	if (repo_dirent_is_dir(dent))
-		repo_git_add_r(depth, path, repo_dir_from_dirent(dent));
-	else
-		fast_export_modify(depth, path,
-				   dent->mode, dent->content_offset);
-}
-
-static void repo_git_add_r(uint32_t depth, uint32_t *path, struct repo_dir *dir)
-{
-	struct repo_dirent *de = repo_first_dirent(dir);
-	while (de) {
-		path[depth] = de->name_offset;
-		repo_git_add(depth + 1, path, de);
-		de = dent_next(&dir->entries, de);
-	}
-}
-
-static void repo_diff_r(uint32_t depth, uint32_t *path, struct repo_dir *dir1,
-			struct repo_dir *dir2)
-{
-	struct repo_dirent *de1, *de2;
-	de1 = repo_first_dirent(dir1);
-	de2 = repo_first_dirent(dir2);
-
-	while (de1 && de2) {
-		if (de1->name_offset < de2->name_offset) {
-			path[depth] = de1->name_offset;
-			fast_export_delete(depth + 1, path);
-			de1 = dent_next(&dir1->entries, de1);
-			continue;
-		}
-		if (de1->name_offset > de2->name_offset) {
-			path[depth] = de2->name_offset;
-			repo_git_add(depth + 1, path, de2);
-			de2 = dent_next(&dir2->entries, de2);
-			continue;
-		}
-		path[depth] = de1->name_offset;
-
-		if (de1->mode == de2->mode &&
-		    de1->content_offset == de2->content_offset) {
-			; /* No change. */
-		} else if (repo_dirent_is_dir(de1) && repo_dirent_is_dir(de2)) {
-			repo_diff_r(depth + 1, path,
-				    repo_dir_from_dirent(de1),
-				    repo_dir_from_dirent(de2));
-		} else if (!repo_dirent_is_dir(de1) && !repo_dirent_is_dir(de2)) {
-			repo_git_add(depth + 1, path, de2);
-		} else {
-			fast_export_delete(depth + 1, path);
-			repo_git_add(depth + 1, path, de2);
-		}
-		de1 = dent_next(&dir1->entries, de1);
-		de2 = dent_next(&dir2->entries, de2);
-	}
-	while (de1) {
-		path[depth] = de1->name_offset;
-		fast_export_delete(depth + 1, path);
-		de1 = dent_next(&dir1->entries, de1);
-	}
-	while (de2) {
-		path[depth] = de2->name_offset;
-		repo_git_add(depth + 1, path, de2);
-		de2 = dent_next(&dir2->entries, de2);
-	}
-}
-
-static uint32_t path_stack[REPO_MAX_PATH_DEPTH];
-
-void repo_diff(uint32_t r1, uint32_t r2)
-{
-	repo_diff_r(0,
-		    path_stack,
-		    repo_commit_root_dir(commit_pointer(r1)),
-		    repo_commit_root_dir(commit_pointer(r2)));
-}
-
-void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
-		 uint32_t url, unsigned long timestamp)
-{
-	fast_export_commit(revision, author, log, uuid, url, timestamp);
-	dent_commit();
-	dir_commit();
-	active_commit = commit_alloc(1);
-	commit_pointer(active_commit)->root_dir_offset =
-		commit_pointer(active_commit - 1)->root_dir_offset;
-}
-
-static void mark_init(void)
-{
-	uint32_t i;
-	mark = 1024 * 1024 * 1024;
-	for (i = 0; i < dent_pool.size; i++)
-		if (!repo_dirent_is_dir(dent_pointer(i)) &&
-		    dent_pointer(i)->content_offset > mark)
-			mark = dent_pointer(i)->content_offset;
-	mark++;
-}
-
-void repo_init(void)
-{
-	mark_init();
-	if (commit_pool.size == 0) {
-		/* Create empty tree for commit 0. */
-		commit_alloc(1);
-		commit_pointer(0)->root_dir_offset = dir_alloc(1);
-		dir_pointer(0)->entries.trp_root = ~0;
-		dir_commit();
-	}
-	/* Preallocate next commit, ready for changes. */
-	active_commit = commit_alloc(1);
-	commit_pointer(active_commit)->root_dir_offset =
-		commit_pointer(active_commit - 1)->root_dir_offset;
-}
-
-void repo_reset(void)
-{
-	pool_reset();
-	commit_reset();
-	dir_reset();
-	dent_reset();
-}
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "repo_tree.h"
+#include "fast_export.h"
+
+const char *repo_read_path(const uint32_t *path)
+{
+	int err;
+	uint32_t dummy;
+	static struct strbuf buf = STRBUF_INIT;
+
+	strbuf_reset(&buf);
+	err = fast_export_ls(REPO_MAX_PATH_DEPTH, path, &dummy, &buf);
+	if (err) {
+		if (errno != ENOENT)
+			die_errno("BUG: unexpected fast_export_ls error");
+		return NULL;
+	}
+	return buf.buf;
+}
+
+uint32_t repo_read_mode(const uint32_t *path)
+{
+	int err;
+	uint32_t result;
+	static struct strbuf dummy = STRBUF_INIT;
+
+	strbuf_reset(&dummy);
+	err = fast_export_ls(REPO_MAX_PATH_DEPTH, path, &result, &dummy);
+	if (err) {
+		if (errno != ENOENT)
+			die_errno("BUG: unexpected fast_export_ls error");
+		/* Treat missing paths as directories. */
+		return REPO_MODE_DIR;
+	}
+	return result;
+}
+
+void repo_copy(uint32_t revision, const uint32_t *src, const uint32_t *dst)
+{
+	int err;
+	uint32_t mode;
+	static struct strbuf data = STRBUF_INIT;
+
+	strbuf_reset(&data);
+	err = fast_export_ls_rev(revision, REPO_MAX_PATH_DEPTH, src, &mode, &data);
+	if (err) {
+		if (errno != ENOENT)
+			die_errno("BUG: unexpected fast_export_ls_rev error");
+		fast_export_delete(REPO_MAX_PATH_DEPTH, dst);
+		return;
+	}
+	fast_export_modify(REPO_MAX_PATH_DEPTH, dst, mode, data.buf);
+}
+
+void repo_delete(uint32_t *path)
+{
+	fast_export_delete(REPO_MAX_PATH_DEPTH, path);
+}
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index 11d48c2..d690784 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -14,7 +14,7 @@
 uint32_t next_blob_mark(void);
 void repo_copy(uint32_t revision, const uint32_t *src, const uint32_t *dst);
 void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark);
-uint32_t repo_read_path(const uint32_t *path);
+const char *repo_read_path(const uint32_t *path);
 uint32_t repo_read_mode(const uint32_t *path);
 void repo_delete(uint32_t *path);
 void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
diff --git a/vcs-svn/string_pool.c b/vcs-svn/string_pool.c
index f5b1da8..c08abac 100644
--- a/vcs-svn/string_pool.c
+++ b/vcs-svn/string_pool.c
@@ -65,7 +65,7 @@ uint32_t pool_tok_r(char *str, const char *delim, char **saveptr)
 	return token ? pool_intern(token) : ~0;
 }
 
-void pool_print_seq(uint32_t len, uint32_t *seq, char delim, FILE *stream)
+void pool_print_seq(uint32_t len, const uint32_t *seq, char delim, FILE *stream)
 {
 	uint32_t i;
 	for (i = 0; i < len && ~seq[i]; i++) {
diff --git a/vcs-svn/string_pool.h b/vcs-svn/string_pool.h
index 222fb66..3720cf8 100644
--- a/vcs-svn/string_pool.h
+++ b/vcs-svn/string_pool.h
@@ -4,7 +4,7 @@
 uint32_t pool_intern(const char *key);
 const char *pool_fetch(uint32_t entry);
 uint32_t pool_tok_r(char *str, const char *delim, char **saveptr);
-void pool_print_seq(uint32_t len, uint32_t *seq, char delim, FILE *stream);
+void pool_print_seq(uint32_t len, const uint32_t *seq, char delim, FILE *stream);
 uint32_t pool_tok_seq(uint32_t sz, uint32_t *seq, const char *delim, char *str);
 void pool_reset(void);
 
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 3cc4135..7ecb227 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -36,6 +36,8 @@ obj_pool_gen(log, char, 4096)
 
 static struct line_buffer input = LINE_BUFFER_INIT;
 
+#define REPORT_FILENO 3
+
 static char *log_copy(uint32_t length, const char *log)
 {
 	char *buffer;
@@ -202,15 +204,21 @@ static void read_props(void)
 
 static void handle_node(void)
 {
-	uint32_t mark = 0;
 	const uint32_t type = node_ctx.type;
 	const int have_props = node_ctx.propLength != LENGTH_UNKNOWN;
 	const int have_text = node_ctx.textLength != LENGTH_UNKNOWN;
+	/*
+	 * Old text for this node:
+	 *  NULL	- directory or bug
+	 *  empty_blob	- empty
+	 *  "<dataref>"	- data retrievable from fast-import
+	 */
+	static const char *const empty_blob = "::empty::";
+	const char *old_data = NULL;
 
 	if (node_ctx.text_delta)
 		die("text deltas not supported");
-	if (have_text)
-		mark = next_blob_mark();
+
 	if (node_ctx.action == NODEACT_DELETE) {
 		if (have_text || have_props || node_ctx.srcRev)
 			die("invalid dump: deletion node has "
@@ -230,15 +238,15 @@ static void handle_node(void)
 		die("invalid dump: directories cannot have text attached");
 
 	/*
-	 * Decide on the new content (mark) and mode (node_ctx.type).
+	 * Find old content (old_data) and decide on the new mode.
 	 */
 	if (node_ctx.action == NODEACT_CHANGE && !~*node_ctx.dst) {
 		if (type != REPO_MODE_DIR)
 			die("invalid dump: root of tree is not a regular file");
+		old_data = NULL;
 	} else if (node_ctx.action == NODEACT_CHANGE) {
 		uint32_t mode;
-		if (!have_text)
-			mark = repo_read_path(node_ctx.dst);
+		old_data = repo_read_path(node_ctx.dst);
 		mode = repo_read_mode(node_ctx.dst);
 		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
 			die("invalid dump: cannot modify a directory into a file");
@@ -246,7 +254,11 @@ static void handle_node(void)
 			die("invalid dump: cannot modify a file into a directory");
 		node_ctx.type = mode;
 	} else if (node_ctx.action == NODEACT_ADD) {
-		if (!have_text && type != REPO_MODE_DIR)
+		if (type == REPO_MODE_DIR)
+			old_data = NULL;
+		else if (have_text)
+			old_data = empty_blob;
+		else
 			die("invalid dump: adds node without text");
 	} else {
 		die("invalid dump: Node-path block lacks Node-action");
@@ -265,24 +277,34 @@ static void handle_node(void)
 	/*
 	 * Save the result.
 	 */
-	repo_add(node_ctx.dst, node_ctx.type, mark);
-	if (have_text)
-		fast_export_blob(node_ctx.type, mark,
-				 node_ctx.textLength, &input);
+	if (type == REPO_MODE_DIR)	/* directories are not tracked. */
+		return;
+	assert(old_data);
+	if (old_data == empty_blob)
+		/* For the fast_export_* functions, NULL means empty. */
+		old_data = NULL;
+	if (!have_text) {
+		fast_export_modify(REPO_MAX_PATH_DEPTH, node_ctx.dst,
+					node_ctx.type, old_data);
+		return;
+	}
+	fast_export_modify(REPO_MAX_PATH_DEPTH, node_ctx.dst,
+				node_ctx.type, "inline");
+	fast_export_data(node_ctx.type, node_ctx.textLength, &input);
 }
 
 static void begin_revision(void)
 {
 	if (!rev_ctx.revision)	/* revision 0 gets no git commit. */
 		return;
-	fast_export_begin_commit(rev_ctx.revision);
+	fast_export_begin_commit(rev_ctx.revision, rev_ctx.author, rev_ctx.log,
+		dump_ctx.uuid, dump_ctx.url, rev_ctx.timestamp);
 }
 
 static void end_revision(void)
 {
 	if (rev_ctx.revision)
-		repo_commit(rev_ctx.revision, rev_ctx.author, rev_ctx.log,
-			dump_ctx.uuid, dump_ctx.url, rev_ctx.timestamp);
+		fast_export_end_commit(rev_ctx.revision);
 }
 
 void svndump_read(const char *url)
@@ -383,7 +405,6 @@ int svndump_init(const char *filename)
 {
 	if (buffer_init(&input, filename))
 		return error("cannot open %s: %s", filename, strerror(errno));
-	repo_init();
 	fast_export_init(REPORT_FILENO);
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
@@ -396,7 +417,6 @@ void svndump_deinit(void)
 {
 	log_reset();
 	fast_export_deinit();
-	repo_reset();
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
@@ -411,7 +431,6 @@ void svndump_reset(void)
 	log_reset();
 	fast_export_reset();
 	buffer_reset(&input);
-	repo_reset();
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
-- 
1.7.4.1
