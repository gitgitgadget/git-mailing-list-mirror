From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v8 3/4] worktree: add functions to get worktree details
Date: Fri, 18 Sep 2015 09:30:26 -0400
Message-ID: <1442583027-47653-4-git-send-email-rappazzo@gmail.com>
References: <1442583027-47653-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Fri Sep 18 15:31:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcvl0-0005du-Lo
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 15:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbbIRNbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 09:31:10 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34264 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbbIRNbI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 09:31:08 -0400
Received: by qgez77 with SMTP id z77so38550247qge.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DQvUBvotZ+auUWeGsPATHZvTFswkX54uqwEo2N0T+HE=;
        b=uwLiDqXNzuDLwsPwVTDCwhV2SI1vr5HK1EyN7f0DcqJ3lU5cjg2xMuqZJMvQ+ZRm63
         nxDA/zE1XjQMkskffoaiL0niEQhq81xtkFbxhCM2deFvzRLfoLTfn6QjIYsSmVHRYJ6u
         AlJ/CtxbtdSc9ovLuLJZqASslpIhbsjEHmHKU2klbjVY/IyurNTLGSRfyXwRW3Ppygtm
         JgAiedkcM8Z8BmiXdBgnPEUBhvcBOG8MCfWhU7CqOQBLtLAQajaxQnRLOlPBL1qpDq3D
         qXA5/Eopn1Vt7IEg2CVEjtmRUT949COVLWNC+vZ0SBIwXxGrJ8wAORwYEMm4CdRG2Vif
         Ii3w==
X-Received: by 10.140.128.81 with SMTP id 78mr6842328qha.62.1442583067561;
        Fri, 18 Sep 2015 06:31:07 -0700 (PDT)
Received: from localhost.localdomain (109.sub-70-199-70.myvzw.com. [70.199.70.109])
        by smtp.gmail.com with ESMTPSA id i19sm3586051qkh.13.2015.09.18.06.31.06
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Sep 2015 06:31:06 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1442583027-47653-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278191>

The worktree structure provided for an individual worktree includes the
absolute path, the location of the git dir, the head ref (if not
detached), the head revision sha1, whether or not head is detached, and
whether or not the worktree is a bare repo.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 worktree.c | 224 ++++++++++++++++++++++++++++++++++++++++++++++---------------
 worktree.h |  26 +++++++
 2 files changed, 195 insertions(+), 55 deletions(-)

diff --git a/worktree.c b/worktree.c
index 5c75875..74a2ffa 100644
--- a/worktree.c
+++ b/worktree.c
@@ -3,6 +3,17 @@
 #include "strbuf.h"
 #include "worktree.h"
 
+void free_worktrees(struct worktree **worktrees)
+{
+	for (int i = 0; worktrees[i]; i++) {
+		free(worktrees[i]->path);
+		free(worktrees[i]->git_dir);
+		free(worktrees[i]->head_ref);
+		free(worktrees[i]);
+	}
+	free (worktrees);
+}
+
 /*
  * read 'path_to_ref' into 'ref'.  Also if is_detached is not NULL,
  * set is_detached to 1 if the ref is detatched.
@@ -34,91 +45,194 @@ static int parse_ref(char *path_to_ref, struct strbuf *ref, int *is_detached)
 	return 0;
 }
 
-static char *find_main_symref(const char *symref, const char *branch)
+/**
+ * Add the head_sha1 and head_ref (if not detached) to the given worktree
+ */
+static void add_head_info(struct strbuf *head_ref, struct worktree *worktree)
 {
-	struct strbuf sb = STRBUF_INIT;
+	if (head_ref->len) {
+		if (worktree->is_detached) {
+			get_sha1_hex(head_ref->buf, worktree->head_sha1);
+		} else {
+			resolve_ref_unsafe(head_ref->buf, 0, worktree->head_sha1, NULL);
+			worktree->head_ref = strbuf_detach(head_ref, NULL);
+		}
+	}
+}
+
+/**
+ * get the main worktree
+ */
+static struct worktree *get_main_worktree()
+{
+	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
-	struct strbuf gitdir = STRBUF_INIT;
-	char *existing = NULL;
+	struct strbuf worktree_path = STRBUF_INIT;
+	struct strbuf git_dir = STRBUF_INIT;
+	struct strbuf head_ref = STRBUF_INIT;
+	int is_bare = 0;
+	int is_detached = 0;
 
-	strbuf_addf(&path, "%s/%s", get_git_common_dir(), symref);
-	if (parse_ref(path.buf, &sb, NULL) == -1)
-		goto done;
-	if (strcmp(sb.buf, branch))
-		goto done;
-	strbuf_addstr(&gitdir, get_git_common_dir());
-	strbuf_strip_suffix(&gitdir, ".git");
-	existing = strbuf_detach(&gitdir, NULL);
-done:
-	strbuf_release(&path);
-	strbuf_release(&sb);
-	strbuf_release(&gitdir);
+	strbuf_addf(&git_dir, "%s", absolute_path(get_git_common_dir()));
+	strbuf_addf(&worktree_path, "%s", absolute_path(get_git_common_dir()));
+	is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
+	if (is_bare)
+		strbuf_strip_suffix(&worktree_path, "/.");
 
-	return existing;
+	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
+
+	if (!parse_ref(path.buf, &head_ref, &is_detached)) {
+		worktree = xmalloc(sizeof(struct worktree));
+		worktree->path = strbuf_detach(&worktree_path, NULL);
+		worktree->git_dir = strbuf_detach(&git_dir, NULL);
+		worktree->is_bare = is_bare;
+		worktree->head_ref = NULL;
+		worktree->is_detached = is_detached;
+		add_head_info(&head_ref, worktree);
+	}
+	return worktree;
 }
 
-static char *find_linked_symref(const char *symref, const char *branch,
-				const char *id)
+static struct worktree *get_linked_worktree(const char *id)
 {
-	struct strbuf sb = STRBUF_INIT;
+	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
-	struct strbuf gitdir = STRBUF_INIT;
-	char *existing = NULL;
+	struct strbuf worktree_path = STRBUF_INIT;
+	struct strbuf git_dir = STRBUF_INIT;
+	struct strbuf head_ref = STRBUF_INIT;
+	int is_detached = 0;
 
 	if (!id)
 		goto done;
-	/*
-	 * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside
-	 * $GIT_DIR so resolve_ref_unsafe() won't work (it uses
-	 * git_path). Parse the ref ourselves.
-	 */
-	strbuf_addf(&path, "%s/worktrees/%s/%s", get_git_common_dir(), id, symref);
-
-	if (parse_ref(path.buf, &sb, NULL) == -1)
-		goto done;
-	if (strcmp(sb.buf, branch))
+
+	strbuf_addf(&git_dir, "%s/worktrees/%s",
+			absolute_path(get_git_common_dir()), id);
+	strbuf_addf(&path, "%s/gitdir", git_dir.buf);
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
+	strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
+
+	if (parse_ref(path.buf, &head_ref, &is_detached))
 		goto done;
-	strbuf_rtrim(&gitdir);
-	strbuf_strip_suffix(&gitdir, ".git");
 
-	existing = strbuf_detach(&gitdir, NULL);
+	worktree = xmalloc(sizeof(struct worktree));
+	worktree->path = strbuf_detach(&worktree_path, NULL);
+	worktree->git_dir = strbuf_detach(&git_dir, NULL);
+	worktree->is_bare = 0;
+	worktree->head_ref = NULL;
+	worktree->is_detached = is_detached;
+	add_head_info(&head_ref, worktree);
+
 done:
 	strbuf_release(&path);
-	strbuf_release(&sb);
-	strbuf_release(&gitdir);
+	strbuf_release(&git_dir);
+	strbuf_release(&head_ref);
+	strbuf_release(&worktree_path);
+	return worktree;
+}
 
-	return existing;
+/**
+ * get the estimated worktree count for use in sizing the worktree array
+ * Note that the minimum count should be 2 (main worktree + NULL).  Using the
+ * file count in $GIT_COMMON_DIR/worktrees includes '.' and '..' so the
+ * minimum is satisfied by counting those entries.
+ */
+static int get_estimated_worktree_count()
+{
+	struct strbuf path = STRBUF_INIT;
+	DIR *dir;
+	int count = 0;
+
+	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
+	dir = opendir(path.buf);
+	strbuf_release(&path);
+	if (dir) {
+		while (readdir(dir))
+			count++;
+		closedir(dir);
+	}
+
+	if (!count)
+		count = 2;
+
+	return count;
 }
 
-char *find_shared_symref(const char *symref, const char *target)
+struct worktree **get_worktrees(void)
 {
+	struct worktree **list = NULL;
 	struct strbuf path = STRBUF_INIT;
 	DIR *dir;
 	struct dirent *d;
-	char *existing;
+	int counter = 0;
+
+	list = xmalloc(get_estimated_worktree_count() * sizeof(struct worktree *));
 
-	if ((existing = find_main_symref(symref, target)))
-		return existing;
+	if ((list[counter] = get_main_worktree()))
+		counter++;
 
 	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
 	dir = opendir(path.buf);
 	strbuf_release(&path);
-	if (!dir)
-		return NULL;
-
-	while ((d = readdir(dir)) != NULL) {
-		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
-			continue;
-		existing = find_linked_symref(symref, target, d->d_name);
-		if (existing)
-			goto done;
+	if (dir) {
+		while ((d = readdir(dir)) != NULL) {
+			struct worktree *linked = NULL;
+			if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+				continue;
+
+			if ((linked = get_linked_worktree(d->d_name))) {
+				list[counter++] = linked;
+			}
+		}
+		closedir(dir);
 	}
-done:
-	closedir(dir);
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
+	int symref_is_head = !strcmp("HEAD", symref);
+
+	for (int i = 0; worktrees[i]; i++) {
+		if (!symref_is_head) {
+			strbuf_reset(&path);
+			strbuf_reset(&sb);
+			strbuf_addf(&path, "%s/%s", worktrees[i]->git_dir, symref);
+
+			if (parse_ref(path.buf, &sb, NULL)) {
+				continue;
+			}
+
+			if (!strcmp(sb.buf, target)) {
+				existing = xstrdup(worktrees[i]->path);
+				break;
+			}
+		} else {
+			if (worktrees[i]->head_ref && !strcmp(worktrees[i]->head_ref, target)) {
+				existing = xstrdup(worktrees[i]->path);
+				break;
+			}
+		}
+	}
+
+	strbuf_release(&path);
+	strbuf_release(&sb);
+	free_worktrees(worktrees);
 
 	return existing;
 }
diff --git a/worktree.h b/worktree.h
index 71b1409..b4b3dda 100644
--- a/worktree.h
+++ b/worktree.h
@@ -1,6 +1,32 @@
 #ifndef WORKTREE_H
 #define WORKTREE_H
 
+struct worktree {
+	char *path;
+	char *git_dir;
+	char *head_ref;
+	unsigned char head_sha1[20];
+	int is_detached;
+	int is_bare;
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
2.5.0
