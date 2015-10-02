From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v9 3/5] worktree: add a function to get worktree details
Date: Fri,  2 Oct 2015 07:55:33 -0400
Message-ID: <1443786935-81131-4-git-send-email-rappazzo@gmail.com>
References: <1443786935-81131-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Fri Oct 02 13:56:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zhywp-00027e-JD
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 13:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbbJBL4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 07:56:13 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34713 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbbJBLzs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 07:55:48 -0400
Received: by ykdg206 with SMTP id g206so106417902ykd.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 04:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sPSL008rJTNl3YqU08nN91S4HGWVtkK2b6XYW135GDc=;
        b=s+OTp8U5Fnga8s4rvipSEQE/uPAMpF9/9otjl+ecLZlEwjvhZLlE4bgJUYepo6iRxv
         OLX1SJCehL6T2jqTxbPYLqjy2zvPZr2PLJnyQQFHW8lj2EFGNz4klpZGzcly+uKttseb
         rUhYAf2uZTRsSCmXvZngLZ9/s0g/420atnGkmdtjj1i/uPlPlko8/EmgGPhirZT9NjYr
         akkEdVhXLOXSXh85c++iLsjdkLGlGZOuhxCSxRlXXw6KyJ0s3IiitDBM+I561iLdZGAU
         /n+Wc0IFhmf417mqC5BryrLfEtMAGXyD7X9LXtmCLX6hqAx9StQpxaArhy0Be/qDjZ+I
         0gjA==
X-Received: by 10.170.96.196 with SMTP id n187mr12951766yka.54.1443786947782;
        Fri, 02 Oct 2015 04:55:47 -0700 (PDT)
Received: from localhost.localdomain (113.sub-70-208-69.myvzw.com. [70.208.69.113])
        by smtp.gmail.com with ESMTPSA id v4sm7550431ywf.5.2015.10.02.04.55.46
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Oct 2015 04:55:47 -0700 (PDT)
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1443786935-81131-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278914>

The worktree structure provided for an individual worktree includes the
absolute path of the worktree.  The fuction to get the worktree details
is a refactor of the find main/linked symref functions.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 worktree.c | 161 ++++++++++++++++++++++++++++++++++++++++++-------------------
 worktree.h |  22 +++++++++
 2 files changed, 133 insertions(+), 50 deletions(-)

diff --git a/worktree.c b/worktree.c
index c049947..11a3364 100644
--- a/worktree.c
+++ b/worktree.c
@@ -3,6 +3,17 @@
 #include "strbuf.h"
 #include "worktree.h"
 
+void free_worktrees(struct worktree **worktrees)
+{
+	int i = 0;
+
+	for (i = 0; worktrees[i]; i++) {
+		free(worktrees[i]->path);
+		free(worktrees[i]);
+	}
+	free (worktrees);
+}
+
 /*
  * read 'path_to_ref' into 'ref'.  Also if is_detached is not NULL,
  * set is_detached to 1 (0) if the ref is detatched (is not detached).
@@ -17,15 +28,15 @@ static int parse_ref(char *path_to_ref, struct strbuf *ref, int *is_detached)
 {
 	if (is_detached)
 		*is_detached = 0;
-	if (!strbuf_readlink(ref, path_to_ref, 0))
+	if (!strbuf_readlink(ref, path_to_ref, 0)) {
 		if (!starts_with(ref->buf, "refs/") ||
 				check_refname_format(ref->buf, 0))
 			return -1;
-	else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {
-		if (!starts_with(ref->buf, "ref:"))
+	} else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {
+		if (!starts_with(ref->buf, "ref:")) {
 			if (is_detached)
 				*is_detached = 1;
-		else {
+		} else {
 			strbuf_remove(ref, 0, strlen("ref:"));
 			strbuf_trim(ref);
 			if (check_refname_format(ref->buf, 0))
@@ -36,87 +47,137 @@ static int parse_ref(char *path_to_ref, struct strbuf *ref, int *is_detached)
 	return 0;
 }
 
-static char *find_main_symref(const char *symref, const char *branch)
+/**
+ * get the main worktree
+ */
+static struct worktree *get_main_worktree(void)
 {
-	struct strbuf sb = STRBUF_INIT;
+	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
+	struct strbuf worktree_path = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
-	char *existing = NULL;
+	struct strbuf head_ref = STRBUF_INIT;
 
-	strbuf_addf(&path, "%s/%s", get_git_common_dir(), symref);
-	if (parse_ref(path.buf, &sb, NULL) < 0)
-		goto done;
-	if (strcmp(sb.buf, branch))
-		goto done;
-	strbuf_addstr(&gitdir, get_git_common_dir());
-	strbuf_strip_suffix(&gitdir, ".git");
-	existing = strbuf_detach(&gitdir, NULL);
-done:
+	strbuf_addf(&gitdir, "%s", absolute_path(get_git_common_dir()));
+	strbuf_addbuf(&worktree_path, &gitdir);
+	if (!strbuf_strip_suffix(&worktree_path, "/.git"))
+		strbuf_strip_suffix(&worktree_path, "/.");
+
+	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
+
+	if (parse_ref(path.buf, &head_ref, NULL) >= 0) {
+		worktree = xmalloc(sizeof(struct worktree));
+		worktree->path = strbuf_detach(&worktree_path, NULL);
+		worktree->git_dir = strbuf_detach(&gitdir, NULL);
+	}
 	strbuf_release(&path);
-	strbuf_release(&sb);
 	strbuf_release(&gitdir);
-
-	return existing;
+	strbuf_release(&worktree_path);
+	strbuf_release(&head_ref);
+	return worktree;
 }
 
-static char *find_linked_symref(const char *symref, const char *branch,
-				const char *id)
+static struct worktree *get_linked_worktree(const char *id)
 {
-	struct strbuf sb = STRBUF_INIT;
+	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
+	struct strbuf worktree_path = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
-	char *existing = NULL;
+	struct strbuf head_ref = STRBUF_INIT;
 
 	if (!id)
 		die("Missing linked worktree name");
 
-	strbuf_addf(&path, "%s/worktrees/%s/%s", get_git_common_dir(), id, symref);
-
-	if (parse_ref(path.buf, &sb, NULL) < 0)
-		goto done;
-	if (strcmp(sb.buf, branch))
+	strbuf_addf(&gitdir, "%s/worktrees/%s",
+			absolute_path(get_git_common_dir()), id);
+	strbuf_addf(&path, "%s/gitdir", gitdir.buf);
+	if (strbuf_read_file(&worktree_path, path.buf, 0) <= 0)
+		/* invalid gitdir file */
 		goto done;
+
+	strbuf_rtrim(&worktree_path);
+	if (!strbuf_strip_suffix(&worktree_path, "/.git")) {
+		strbuf_reset(&worktree_path);
+		strbuf_addstr(&worktree_path, absolute_path("."));
+		strbuf_strip_suffix(&worktree_path, "/.");
+	}
+
 	strbuf_reset(&path);
-	strbuf_addf(&path, "%s/worktrees/%s/gitdir", get_git_common_dir(), id);
-	if (strbuf_read_file(&gitdir, path.buf, 0) <= 0)
-		goto done;
-	strbuf_rtrim(&gitdir);
-	strbuf_strip_suffix(&gitdir, ".git");
+	strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
+
+	if (parse_ref(path.buf, &head_ref, NULL) >= 0) {
+		worktree = xmalloc(sizeof(struct worktree));
+		worktree->path = strbuf_detach(&worktree_path, NULL);
+		worktree->git_dir = strbuf_detach(&gitdir, NULL);
+	}
 
-	existing = strbuf_detach(&gitdir, NULL);
 done:
 	strbuf_release(&path);
-	strbuf_release(&sb);
 	strbuf_release(&gitdir);
-
-	return existing;
+	strbuf_release(&worktree_path);
+	strbuf_release(&head_ref);
+	return worktree;
 }
 
-char *find_shared_symref(const char *symref, const char *target)
+struct worktree **get_worktrees(void)
 {
+	struct worktree **list = NULL;
 	struct strbuf path = STRBUF_INIT;
 	DIR *dir;
 	struct dirent *d;
-	char *existing;
+	int counter = 0, alloc = 2;
+
+	list = xmalloc(alloc * sizeof(struct worktree *));
 
-	if ((existing = find_main_symref(symref, target)))
-		return existing;
+	if ((list[counter] = get_main_worktree()))
+		counter++;
 
 	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
 	dir = opendir(path.buf);
 	strbuf_release(&path);
-	if (!dir)
-		return NULL;
+	if (dir) {
+		while ((d = readdir(dir)) != NULL) {
+			struct worktree *linked = NULL;
+			if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+				continue;
 
-	while ((d = readdir(dir)) != NULL) {
-		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+				if ((linked = get_linked_worktree(d->d_name))) {
+					ALLOC_GROW(list, alloc + 1, alloc);
+					list[counter++] = linked;
+				}
+		}
+		closedir(dir);
+	}
+	list[counter] = NULL;
+	return list;
+}
+
+char *find_shared_symref(const char *symref, const char *target)
+{
+	char *existing = NULL;
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	struct worktree **worktrees = get_worktrees();
+	int i = 0;
+
+	for (i = 0; worktrees[i]; i++) {
+		strbuf_reset(&path);
+		strbuf_reset(&sb);
+		strbuf_addf(&path, "%s/%s", worktrees[i]->git_dir, symref);
+
+		if (parse_ref(path.buf, &sb, NULL)) {
 			continue;
-		existing = find_linked_symref(symref, target, d->d_name);
-		if (existing)
-			goto done;
+		}
+
+		if (!strcmp(sb.buf, target)) {
+			existing = xstrdup(worktrees[i]->path);
+			break;
+		}
 	}
-done:
-	closedir(dir);
+
+	strbuf_release(&path);
+	strbuf_release(&sb);
+	free_worktrees(worktrees);
 
 	return existing;
 }
diff --git a/worktree.h b/worktree.h
index 71b1409..7022029 100644
--- a/worktree.h
+++ b/worktree.h
@@ -1,6 +1,28 @@
 #ifndef WORKTREE_H
 #define WORKTREE_H
 
+struct worktree {
+	char *path;
+	char *git_dir;
+};
+
+/* Functions for acting on the information about worktrees. */
+
+/*
+ * Get the worktrees.  The primary worktree will always be the first returned,
+ * and linked worktrees will be pointed to by 'next' in each subsequent
+ * worktree.  No specific ordering is done on the linked worktrees.
+ *
+ * The caller is responsible for freeing the memory from the returned
+ * worktree(s).
+ */
+extern struct worktree **get_worktrees(void);
+
+/*
+ * Free up the memory for worktree(s)
+ */
+extern void free_worktrees(struct worktree **);
+
 /*
  * Check if a per-worktree symref points to a ref in the main worktree
  * or any linked worktree, and return the path to the exising worktree
-- 
2.6.0
