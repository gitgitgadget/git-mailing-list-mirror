From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v7 2/3] worktree: move/refactor find_shared_symref from branch.c
Date: Fri,  4 Sep 2015 17:39:28 -0400
Message-ID: <1441402769-35897-3-git-send-email-rappazzo@gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Fri Sep 04 23:39:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXyi6-0000FJ-5k
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 23:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933929AbbIDVjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 17:39:45 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34982 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933906AbbIDVjo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 17:39:44 -0400
Received: by igbkq10 with SMTP id kq10so21641696igb.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 14:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CUuMvgOHcI+EdIsBWm3YN1kt/8otDIORCmiB5qQxLOQ=;
        b=K+uyiRWh+uRL1WzYf5h+ZuteQpirobDFz8Ic1rFh1EOPwVwsOb7hZhtPxn0/3au/mk
         iPEBENg3TgIiLAY6LorLs9VoU5555d919+wPg+31hpcB1l1VU3I4xHjpRNgicsxgxaaW
         fo+HXX02rmRBh7E3jscMzMo9BWBztSBAhZNeL5RW5t3qZg+n/3vc1ye3HZt4Oenj/l5I
         JVCw8rxU/6OcUvUMb3h6Klz5KPxoEzFAHJoSfkUWHM9K1G0z+xUAJYrFN64UiOHfJKLs
         gxkDaG+wy0hPYDKuhI3spz+cu2UH3maXFwH+e5pSNFWysJhMJwVsSEwfz6tUOZeVpWmh
         +PGQ==
X-Received: by 10.50.66.197 with SMTP id h5mr10624579igt.82.1441402783253;
        Fri, 04 Sep 2015 14:39:43 -0700 (PDT)
Received: from localhost.localdomain (155.sub-70-208-71.myvzw.com. [70.208.71.155])
        by smtp.gmail.com with ESMTPSA id vk8sm2325936igb.4.2015.09.04.14.39.42
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Sep 2015 14:39:42 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277334>

The code formerly in branch.c was largely the basis of the
get_worktree_list implementation is now moved to worktree.c,
and the find_shared_symref implementation has been refactored
to use get_worktree_list

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 branch.c        | 79 +--------------------------------------------------------
 branch.h        |  8 ------
 builtin/notes.c |  1 +
 worktree.c      | 40 +++++++++++++++++++++++++++++
 worktree.h      |  7 +++++
 5 files changed, 49 insertions(+), 86 deletions(-)

diff --git a/branch.c b/branch.c
index d013374..77d7f2a 100644
--- a/branch.c
+++ b/branch.c
@@ -4,6 +4,7 @@
 #include "refs.h"
 #include "remote.h"
 #include "commit.h"
+#include "worktree.h"
 
 struct tracking {
 	struct refspec spec;
@@ -311,84 +312,6 @@ void remove_branch_state(void)
 	unlink(git_path_squash_msg());
 }
 
-static char *find_linked_symref(const char *symref, const char *branch,
-				const char *id)
-{
-	struct strbuf sb = STRBUF_INIT;
-	struct strbuf path = STRBUF_INIT;
-	struct strbuf gitdir = STRBUF_INIT;
-	char *existing = NULL;
-
-	/*
-	 * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside
-	 * $GIT_DIR so resolve_ref_unsafe() won't work (it uses
-	 * git_path). Parse the ref ourselves.
-	 */
-	if (id)
-		strbuf_addf(&path, "%s/worktrees/%s/%s", get_git_common_dir(), id, symref);
-	else
-		strbuf_addf(&path, "%s/%s", get_git_common_dir(), symref);
-
-	if (!strbuf_readlink(&sb, path.buf, 0)) {
-		if (!starts_with(sb.buf, "refs/") ||
-		    check_refname_format(sb.buf, 0))
-			goto done;
-	} else if (strbuf_read_file(&sb, path.buf, 0) >= 0 &&
-	    starts_with(sb.buf, "ref:")) {
-		strbuf_remove(&sb, 0, strlen("ref:"));
-		strbuf_trim(&sb);
-	} else
-		goto done;
-	if (strcmp(sb.buf, branch))
-		goto done;
-	if (id) {
-		strbuf_reset(&path);
-		strbuf_addf(&path, "%s/worktrees/%s/gitdir", get_git_common_dir(), id);
-		if (strbuf_read_file(&gitdir, path.buf, 0) <= 0)
-			goto done;
-		strbuf_rtrim(&gitdir);
-	} else
-		strbuf_addstr(&gitdir, get_git_common_dir());
-	strbuf_strip_suffix(&gitdir, ".git");
-
-	existing = strbuf_detach(&gitdir, NULL);
-done:
-	strbuf_release(&path);
-	strbuf_release(&sb);
-	strbuf_release(&gitdir);
-
-	return existing;
-}
-
-char *find_shared_symref(const char *symref, const char *target)
-{
-	struct strbuf path = STRBUF_INIT;
-	DIR *dir;
-	struct dirent *d;
-	char *existing;
-
-	if ((existing = find_linked_symref(symref, target, NULL)))
-		return existing;
-
-	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
-	dir = opendir(path.buf);
-	strbuf_release(&path);
-	if (!dir)
-		return NULL;
-
-	while ((d = readdir(dir)) != NULL) {
-		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
-			continue;
-		existing = find_linked_symref(symref, target, d->d_name);
-		if (existing)
-			goto done;
-	}
-done:
-	closedir(dir);
-
-	return existing;
-}
-
 void die_if_checked_out(const char *branch)
 {
 	char *existing;
diff --git a/branch.h b/branch.h
index d3446ed..58aa45f 100644
--- a/branch.h
+++ b/branch.h
@@ -59,12 +59,4 @@ extern int read_branch_desc(struct strbuf *, const char *branch_name);
  */
 extern void die_if_checked_out(const char *branch);
 
-/*
- * Check if a per-worktree symref points to a ref in the main worktree
- * or any linked worktree, and return the path to the exising worktree
- * if it is.  Returns NULL if there is no existing ref.  The caller is
- * responsible for freeing the returned path.
- */
-extern char *find_shared_symref(const char *symref, const char *target);
-
 #endif
diff --git a/builtin/notes.c b/builtin/notes.c
index 3608c64..8b30334 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -20,6 +20,7 @@
 #include "notes-merge.h"
 #include "notes-utils.h"
 #include "branch.h"
+#include "worktree.h"
 
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
diff --git a/worktree.c b/worktree.c
index 33d2e57..e45b651 100644
--- a/worktree.c
+++ b/worktree.c
@@ -155,3 +155,43 @@ done:
 	return list;
 }
 
+char *find_shared_symref(const char *symref, const char *target)
+{
+	char *existing = NULL;
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	struct worktree_list *worktree_list = get_worktree_list();
+	struct worktree_list *orig_list = worktree_list;
+	struct worktree *matched = NULL;
+
+	while (!matched && worktree_list) {
+		if (strcmp("HEAD", symref)) {
+			strbuf_reset(&path);
+			strbuf_reset(&sb);
+			strbuf_addf(&path, "%s/%s", worktree_list->worktree->git_dir, symref);
+
+			if (_parse_ref(path.buf, &sb, NULL)) {
+				continue;
+			}
+
+			if (!strcmp(sb.buf, target))
+				matched = worktree_list->worktree;
+		} else {
+			if (worktree_list->worktree->head_ref && !strcmp(worktree_list->worktree->head_ref, target))
+				matched = worktree_list->worktree;
+		}
+		worktree_list = worktree_list->next ? worktree_list->next : NULL;
+	}
+
+	if (matched) {
+		existing = malloc(strlen(matched->path) + 1);
+		strcpy(existing, matched->path);
+	}
+
+done:
+	strbuf_release(&path);
+	strbuf_release(&sb);
+	worktree_list_release(orig_list);
+
+	return existing;
+}
diff --git a/worktree.h b/worktree.h
index 2bc0ab8..320f17e 100644
--- a/worktree.h
+++ b/worktree.h
@@ -45,4 +45,11 @@ struct worktree *get_worktree(const char *id);
 extern void worktree_list_release(struct worktree_list *);
 extern void worktree_release(struct worktree *);
 
+/*
+ * Look for a symref in any worktree, and return the path to the first
+ * worktree found or NULL if not found.  The caller is responsible for
+ * freeing the returned path.
+ */
+extern char *find_shared_symref(const char *symref, const char *target);
+
 #endif
-- 
2.5.0
