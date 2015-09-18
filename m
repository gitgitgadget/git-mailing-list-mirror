From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v8 1/4] worktree: add top-level worktree.c
Date: Fri, 18 Sep 2015 09:30:24 -0400
Message-ID: <1442583027-47653-2-git-send-email-rappazzo@gmail.com>
References: <1442583027-47653-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Fri Sep 18 15:31:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcvl7-0005xq-QJ
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 15:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbbIRNbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 09:31:07 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33836 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbbIRNbF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 09:31:05 -0400
Received: by qkfq186 with SMTP id q186so19281389qkf.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 06:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cwBdItzOEnt66TY2V02U2f4M3/ZxWUH48/0MAtq+zuY=;
        b=IGDEE2yGW/QTIuNY1gK0hALCucDSlEzSCaAWs9UtsZu3jUyC0m6jbJMcJfVEJR9zjJ
         D8iAOZ3eEFRn2gYsp364K0p+0kS35BXqeWNK5knEe73LaLDZCKe9dGdFb+5seDnPWOm5
         sJWYAitJBib+gxQ2jFmlbJPXFCoj2vq5bKxtqXAGYnzJyDTkrgRk5ZPKNTjkc1ff1OnT
         7AZokVF72AeIxj0QjiMk5SnWE59ugmFCsk+PynJ1Crfp5xnZooUPSn6Oytvf3VUnHtB0
         7aZzkqhXeLICYuhVQ8RUXsR/EFaMp8sMuzYDM7B6we60ZwH/oOFOsH61kgYs3ptkUCwS
         tX9w==
X-Received: by 10.55.54.75 with SMTP id d72mr6447627qka.52.1442583064774;
        Fri, 18 Sep 2015 06:31:04 -0700 (PDT)
Received: from localhost.localdomain (109.sub-70-199-70.myvzw.com. [70.199.70.109])
        by smtp.gmail.com with ESMTPSA id i19sm3586051qkh.13.2015.09.18.06.31.03
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Sep 2015 06:31:04 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1442583027-47653-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278194>

worktree.c contains functions to work with and get information from
worktrees.  This introduction moves functions related to worktrees
from branch.c into worktree.c

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 Makefile        |  1 +
 branch.c        | 79 +-----------------------------------------------------
 branch.h        |  8 ------
 builtin/notes.c |  1 +
 worktree.c      | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 worktree.h      | 12 +++++++++
 6 files changed, 97 insertions(+), 86 deletions(-)
 create mode 100644 worktree.c
 create mode 100644 worktree.h

diff --git a/Makefile b/Makefile
index 8d5df7e..f4ee2d2 100644
--- a/Makefile
+++ b/Makefile
@@ -807,6 +807,7 @@ LIB_OBJS += version.o
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
2.5.0
