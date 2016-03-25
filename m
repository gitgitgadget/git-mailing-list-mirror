From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH v2 1/5] refs: add new flag RESOLVE_REF_COMMON_DIR to resolve_ref_unsafe
Date: Sat, 26 Mar 2016 03:28:19 +0900
Message-ID: <7a5fbdea60e3eb8513e686eee4447526450b5131.1458927521.git.k@rhe.jp>
References: <cover.1458927521.git.k@rhe.jp>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>, Kazuki Yamaguchi <k@rhe.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 19:29:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWU5-00089o-8R
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbcCYS3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:29:18 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:51587 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbcCYS3P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:29:15 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 3D44E5AFE9;
	Fri, 25 Mar 2016 18:29:13 +0000 (UTC)
X-Mailer: git-send-email 2.8.0.rc4.21.g05df949
In-Reply-To: <cover.1458927521.git.k@rhe.jp>
In-Reply-To: <cover.1458927521.git.k@rhe.jp>
References: <1458553816-29091-1-git-send-email-k@rhe.jp> <cover.1458927521.git.k@rhe.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289929>

If the new flag RESOLVE_REF_COMMON_DIR is passed to resolve_ref_unsafe,
it assumes the refname belongs to $GIT_COMMON_DIR.

resolve_ref_unsafe currently has no way to resolve worktree-specific
refs such as HEAD of the main working tree when we are in a linked
working tree.
worktree.c has a simplified one for this purpose, and this patch allows
removing it.

Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
---
 refs.h               |   4 ++
 refs/files-backend.c |   5 ++-
 worktree.c           | 105 ++++++++++++++++-----------------------------------
 3 files changed, 41 insertions(+), 73 deletions(-)

diff --git a/refs.h b/refs.h
index 2f3decb432cf..5d9ab5c1c5dd 100644
--- a/refs.h
+++ b/refs.h
@@ -25,6 +25,9 @@
  * reference will always be null_sha1 in this case, and the return
  * value is the reference that the symref refers to directly.
  *
+ * If the RESOLVE_REF_COMMON_DIR flag is passed, assumes the refname is
+ * always directly under $GIT_COMMON_DIR.
+ *
  * If flags is non-NULL, set the value that it points to the
  * combination of REF_ISPACKED (if the reference was found among the
  * packed references), REF_ISSYMREF (if the initial reference was a
@@ -51,6 +54,7 @@
 #define RESOLVE_REF_READING 0x01
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
+#define RESOLVE_REF_COMMON_DIR 0x08
 
 extern const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 				      unsigned char *sha1, int *flags);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 81f68f846b69..a534f1a1e078 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1448,7 +1448,10 @@ static const char *resolve_ref_1(const char *refname,
 		}
 
 		strbuf_reset(sb_path);
-		strbuf_git_path(sb_path, "%s", refname);
+		if (resolve_flags & RESOLVE_REF_COMMON_DIR)
+			strbuf_addf(sb_path, "%s/%s", get_git_common_dir(), refname);
+		else
+			strbuf_git_path(sb_path, "%s", refname);
 		path = sb_path->buf;
 
 		/*
diff --git a/worktree.c b/worktree.c
index 6181a66f1ee2..e9e945ea1373 100644
--- a/worktree.c
+++ b/worktree.c
@@ -16,53 +16,19 @@ void free_worktrees(struct worktree **worktrees)
 	free (worktrees);
 }
 
-/*
- * read 'path_to_ref' into 'ref'.  Also if is_detached is not NULL,
- * set is_detached to 1 (0) if the ref is detatched (is not detached).
- *
- * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside $GIT_DIR so
- * for linked worktrees, `resolve_ref_unsafe()` won't work (it uses
- * git_path). Parse the ref ourselves.
- *
- * return -1 if the ref is not a proper ref, 0 otherwise (success)
- */
-static int parse_ref(char *path_to_ref, struct strbuf *ref, int *is_detached)
-{
-	if (is_detached)
-		*is_detached = 0;
-	if (!strbuf_readlink(ref, path_to_ref, 0)) {
-		/* HEAD is symbolic link */
-		if (!starts_with(ref->buf, "refs/") ||
-				check_refname_format(ref->buf, 0))
-			return -1;
-	} else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {
-		/* textual symref or detached */
-		if (!starts_with(ref->buf, "ref:")) {
-			if (is_detached)
-				*is_detached = 1;
-		} else {
-			strbuf_remove(ref, 0, strlen("ref:"));
-			strbuf_trim(ref);
-			if (check_refname_format(ref->buf, 0))
-				return -1;
-		}
-	} else
-		return -1;
-	return 0;
-}
-
 /**
- * Add the head_sha1 and head_ref (if not detached) to the given worktree
+ * Add the is_detached, head_sha1 and head_ref (if not detached) to the given worktree
  */
-static void add_head_info(struct strbuf *head_ref, struct worktree *worktree)
+static void add_head_info(const char *head_ref, const unsigned char *sha1,
+			  struct worktree *worktree)
 {
-	if (head_ref->len) {
-		if (worktree->is_detached) {
-			get_sha1_hex(head_ref->buf, worktree->head_sha1);
-		} else {
-			resolve_ref_unsafe(head_ref->buf, 0, worktree->head_sha1, NULL);
-			worktree->head_ref = strbuf_detach(head_ref, NULL);
-		}
+	worktree->is_detached = !is_null_sha1(sha1);
+	if (worktree->is_detached) {
+		hashcpy(worktree->head_sha1, sha1);
+		worktree->head_ref = NULL;
+	} else {
+		resolve_ref_unsafe(head_ref, 0, worktree->head_sha1, NULL);
+		worktree->head_ref = xstrdup(head_ref);
 	}
 }
 
@@ -72,12 +38,11 @@ static void add_head_info(struct strbuf *head_ref, struct worktree *worktree)
 static struct worktree *get_main_worktree(void)
 {
 	struct worktree *worktree = NULL;
-	struct strbuf path = STRBUF_INIT;
 	struct strbuf worktree_path = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
-	struct strbuf head_ref = STRBUF_INIT;
+	const char *head_ref;
+	unsigned char sha1[20];
 	int is_bare = 0;
-	int is_detached = 0;
 
 	strbuf_addf(&gitdir, "%s", absolute_path(get_git_common_dir()));
 	strbuf_addbuf(&worktree_path, &gitdir);
@@ -85,24 +50,21 @@ static struct worktree *get_main_worktree(void)
 	if (is_bare)
 		strbuf_strip_suffix(&worktree_path, "/.");
 
-	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
-
-	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
+	head_ref = resolve_ref_unsafe("HEAD",
+			RESOLVE_REF_NO_RECURSE | RESOLVE_REF_COMMON_DIR,
+			sha1, NULL);
+	if (!head_ref)
 		goto done;
 
 	worktree = xmalloc(sizeof(struct worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->git_dir = strbuf_detach(&gitdir, NULL);
 	worktree->is_bare = is_bare;
-	worktree->head_ref = NULL;
-	worktree->is_detached = is_detached;
-	add_head_info(&head_ref, worktree);
+	add_head_info(head_ref, sha1, worktree);
 
 done:
-	strbuf_release(&path);
 	strbuf_release(&gitdir);
 	strbuf_release(&worktree_path);
-	strbuf_release(&head_ref);
 	return worktree;
 }
 
@@ -112,8 +74,8 @@ static struct worktree *get_linked_worktree(const char *id)
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf worktree_path = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
-	struct strbuf head_ref = STRBUF_INIT;
-	int is_detached = 0;
+	const char *head_ref;
+	unsigned char sha1[20];
 
 	if (!id)
 		die("Missing linked worktree name");
@@ -133,24 +95,23 @@ static struct worktree *get_linked_worktree(const char *id)
 	}
 
 	strbuf_reset(&path);
-	strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
-
-	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
+	strbuf_addf(&path, "worktrees/%s/HEAD", id);
+	head_ref = resolve_ref_unsafe(path.buf,
+			RESOLVE_REF_NO_RECURSE | RESOLVE_REF_COMMON_DIR,
+			sha1, NULL);
+	if (!head_ref)
 		goto done;
 
 	worktree = xmalloc(sizeof(struct worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->git_dir = strbuf_detach(&gitdir, NULL);
 	worktree->is_bare = 0;
-	worktree->head_ref = NULL;
-	worktree->is_detached = is_detached;
-	add_head_info(&head_ref, worktree);
+	add_head_info(head_ref, sha1, worktree);
 
 done:
 	strbuf_release(&path);
 	strbuf_release(&gitdir);
 	strbuf_release(&worktree_path);
-	strbuf_release(&head_ref);
 	return worktree;
 }
 
@@ -192,27 +153,27 @@ char *find_shared_symref(const char *symref, const char *target)
 {
 	char *existing = NULL;
 	struct strbuf path = STRBUF_INIT;
-	struct strbuf sb = STRBUF_INIT;
 	struct worktree **worktrees = get_worktrees();
+	const char *resolved;
 	int i = 0;
+	unsigned char sha1[20];
+	int common_prefix_len = strlen(absolute_path(get_git_common_dir())) + 1;
 
 	for (i = 0; worktrees[i]; i++) {
 		strbuf_reset(&path);
-		strbuf_reset(&sb);
 		strbuf_addf(&path, "%s/%s", worktrees[i]->git_dir, symref);
+		strbuf_remove(&path, 0, common_prefix_len);
 
-		if (parse_ref(path.buf, &sb, NULL)) {
-			continue;
-		}
-
-		if (!strcmp(sb.buf, target)) {
+		resolved = resolve_ref_unsafe(path.buf,
+				RESOLVE_REF_NO_RECURSE | RESOLVE_REF_COMMON_DIR,
+				sha1, NULL);
+		if (resolved && !strcmp(resolved, target)) {
 			existing = xstrdup(worktrees[i]->path);
 			break;
 		}
 	}
 
 	strbuf_release(&path);
-	strbuf_release(&sb);
 	free_worktrees(worktrees);
 
 	return existing;
-- 
2.8.0.rc4.21.g05df949
