From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v10 1/5] worktree: add top-level worktree.c
Date: Thu,  8 Oct 2015 13:01:01 -0400
Message-ID: <1444323665-64590-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Thu Oct 08 19:01:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkEZH-0003cj-85
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 19:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbbJHRBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 13:01:19 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34344 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964843AbbJHRBR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 13:01:17 -0400
Received: by qkdo1 with SMTP id o1so12799218qkd.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 10:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+9u8EX4T2gsj57ajjJSwQoBPkIwrLlLZEZS4cU//gIw=;
        b=iERBCmgW2ex5nLCKlwB5f5kc1sz4Gzd9hrld/RJdqWmVVnUus2nP5ZojiKDh6b26Jr
         kIodqG2WPe5rQ/HACzdTsdgRO+dbEnmiswfQJ33oUslXxcKnoV+jNn5q8laGUFQx+3Gg
         SY+KVRSk/pdhTcZCOfnVN4OS2MakZ013ssjw1VEE/O1ZcS50Mg5dKFUTZGoHcu7egpec
         Hc36zt3xgzlFWqpN2DRcBfVaAuCceilLWcmbba3z552sq65oJxDgn2Y2cgHTpqKozy1Z
         DfEDxTjVwnW1JzZ1fRuFqNYOo6NkLpdcFXyKdNZ3D6zVqQk+iQ6prUg+JwPljW+98qUV
         8DFA==
X-Received: by 10.55.207.4 with SMTP id e4mr9209547qkj.84.1444323674195;
        Thu, 08 Oct 2015 10:01:14 -0700 (PDT)
Received: from localhost.localdomain (16.sub-70-199-78.myvzw.com. [70.199.78.16])
        by smtp.gmail.com with ESMTPSA id e131sm18913002qhc.10.2015.10.08.10.01.12
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Oct 2015 10:01:13 -0700 (PDT)
X-Mailer: git-send-email 2.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279245>

worktree.c contains functions to work with and get information from
worktrees.  This introduction moves functions related to worktrees
from branch.c into worktree.c

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 Makefile        |  1 +
 branch.c        | 79 +-----------------------------------------------------
 branch.h        |  8 ------
 builtin/notes.c |  2 +-
 worktree.c      | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 worktree.h      | 12 +++++++++
 6 files changed, 97 insertions(+), 87 deletions(-)
 create mode 100644 worktree.c
 create mode 100644 worktree.h

diff --git a/Makefile b/Makefile
index 36bc54c..9cc010c 100644
--- a/Makefile
+++ b/Makefile
@@ -810,6 +810,7 @@ LIB_OBJS += version.o
 LIB_OBJS += versioncmp.o
 LIB_OBJS += walker.o
 LIB_OBJS += wildmatch.o
+LIB_OBJS += worktree.o
 LIB_OBJS += wrapper.o
 LIB_OBJS += write_or_die.o
 LIB_OBJS += ws.o
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
index 3608c64..13c0af9 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -19,7 +19,7 @@
 #include "string-list.h"
 #include "notes-merge.h"
 #include "notes-utils.h"
-#include "branch.h"
+#include "worktree.h"
 
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
diff --git a/worktree.c b/worktree.c
new file mode 100644
index 0000000..10e1496
--- /dev/null
+++ b/worktree.c
@@ -0,0 +1,82 @@
+#include "cache.h"
+#include "refs.h"
+#include "strbuf.h"
+#include "worktree.h"
+
+static char *find_linked_symref(const char *symref, const char *branch,
+				const char *id)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf gitdir = STRBUF_INIT;
+	char *existing = NULL;
+
+	/*
+	 * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside
+	 * $GIT_DIR so resolve_ref_unsafe() won't work (it uses
+	 * git_path). Parse the ref ourselves.
+	 */
+	if (id)
+		strbuf_addf(&path, "%s/worktrees/%s/%s", get_git_common_dir(), id, symref);
+	else
+		strbuf_addf(&path, "%s/%s", get_git_common_dir(), symref);
+
+	if (!strbuf_readlink(&sb, path.buf, 0)) {
+		if (!starts_with(sb.buf, "refs/") ||
+		    check_refname_format(sb.buf, 0))
+			goto done;
+	} else if (strbuf_read_file(&sb, path.buf, 0) >= 0 &&
+	    starts_with(sb.buf, "ref:")) {
+		strbuf_remove(&sb, 0, strlen("ref:"));
+		strbuf_trim(&sb);
+	} else
+		goto done;
+	if (strcmp(sb.buf, branch))
+		goto done;
+	if (id) {
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s/worktrees/%s/gitdir", get_git_common_dir(), id);
+		if (strbuf_read_file(&gitdir, path.buf, 0) <= 0)
+			goto done;
+		strbuf_rtrim(&gitdir);
+	} else
+		strbuf_addstr(&gitdir, get_git_common_dir());
+	strbuf_strip_suffix(&gitdir, ".git");
+
+	existing = strbuf_detach(&gitdir, NULL);
+done:
+	strbuf_release(&path);
+	strbuf_release(&sb);
+	strbuf_release(&gitdir);
+
+	return existing;
+}
+
+char *find_shared_symref(const char *symref, const char *target)
+{
+	struct strbuf path = STRBUF_INIT;
+	DIR *dir;
+	struct dirent *d;
+	char *existing;
+
+	if ((existing = find_linked_symref(symref, target, NULL)))
+		return existing;
+
+	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
+	dir = opendir(path.buf);
+	strbuf_release(&path);
+	if (!dir)
+		return NULL;
+
+	while ((d = readdir(dir)) != NULL) {
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+		existing = find_linked_symref(symref, target, d->d_name);
+		if (existing)
+			goto done;
+	}
+done:
+	closedir(dir);
+
+	return existing;
+}
diff --git a/worktree.h b/worktree.h
new file mode 100644
index 0000000..71b1409
--- /dev/null
+++ b/worktree.h
@@ -0,0 +1,12 @@
+#ifndef WORKTREE_H
+#define WORKTREE_H
+
+/*
+ * Check if a per-worktree symref points to a ref in the main worktree
+ * or any linked worktree, and return the path to the exising worktree
+ * if it is.  Returns NULL if there is no existing ref.  The caller is
+ * responsible for freeing the returned path.
+ */
+extern char *find_shared_symref(const char *symref, const char *target);
+
+#endif
-- 
2.6.0
