From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH] branch: update all per-worktree HEADs when renaming a branch
Date: Mon, 21 Mar 2016 18:50:16 +0900
Message-ID: <1458553816-29091-1-git-send-email-k@rhe.jp>
Cc: Kazuki Yamaguchi <k@rhe.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 10:56:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahwZS-0001Uv-Hg
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 10:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364AbcCUJ4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 05:56:19 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:51834 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358AbcCUJ4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 05:56:17 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Mar 2016 05:56:17 EDT
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 34EEC51C62;
	Mon, 21 Mar 2016 09:50:52 +0000 (UTC)
X-Mailer: git-send-email 2.8.0.rc3.13.gcd7ec22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289413>

When renaming a branch, the current code only updates the current
working tree's HEAD, but it should update .git/HEAD of all checked out
working trees.

This is the current behavior, /path/to/wt's HEAD is not updated:

  % git worktree list
  /path/to     2c3c5f2 [master]
  /path/to/wt  2c3c5f2 [oldname]
  % git branch -m master master2
  % git worktree list
  /path/to     2c3c5f2 [master2]
  /path/to/wt  2c3c5f2 [oldname]
  % git branch -m oldname newname
  % git worktree list
  /path/to     2c3c5f2 [master2]
  /path/to/wt  0000000 [oldname]

This patch fixes this issue by updating all relevant worktree HEADs
when renaming a branch.

Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
---
 builtin/branch.c  |  4 ++--
 t/t3200-branch.sh | 14 +++++++++++++-
 worktree.c        | 38 ++++++++++++++++++++++++++++++++++++++
 worktree.h        |  7 +++++++
 4 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7b45b6b..596fb5f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -20,6 +20,7 @@
 #include "utf8.h"
 #include "wt-status.h"
 #include "ref-filter.h"
+#include "worktree.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
@@ -552,8 +553,7 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	if (recovery)
 		warning(_("Renamed a misnamed branch '%s' away"), oldref.buf + 11);
 
-	/* no need to pass logmsg here as HEAD didn't really move */
-	if (!strcmp(oldname, head) && create_symref("HEAD", newref.buf, NULL))
+	if (update_worktrees_head_symref(oldref.buf, newref.buf))
 		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
 
 	strbuf_addf(&oldsection, "branch.%s", oldref.buf + 11);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a897248..da107d0 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -126,7 +126,19 @@ test_expect_success 'git branch -M foo bar should fail when bar is checked out'
 test_expect_success 'git branch -M baz bam should succeed when baz is checked out' '
 	git checkout -b baz &&
 	git branch bam &&
-	git branch -M baz bam
+	git branch -M baz bam &&
+	test $(git rev-parse --abbrev-ref HEAD) = bam
+'
+
+test_expect_success 'git branch -M baz bam should succeed when baz is checked out as linked working tree' '
+	git checkout master &&
+	git branch &&
+	git worktree add -b baz bazdir &&
+	git branch -M baz bam &&
+	(
+		cd bazdir &&
+		test $(git rev-parse --abbrev-ref HEAD) = bam
+	)
 '
 
 test_expect_success 'git branch -M master should work when master is checked out' '
diff --git a/worktree.c b/worktree.c
index 6181a66..9e7d0f3 100644
--- a/worktree.c
+++ b/worktree.c
@@ -217,3 +217,41 @@ char *find_shared_symref(const char *symref, const char *target)
 
 	return existing;
 }
+
+int update_worktrees_head_symref(const char *oldref, const char *newref)
+{
+	int error = 0;
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf origref = STRBUF_INIT;
+	int i;
+	struct worktree **worktrees = get_worktrees();
+
+	for (i = 0; worktrees[i]; i++) {
+		if (worktrees[i]->is_detached)
+			continue;
+
+		strbuf_reset(&path);
+		strbuf_reset(&origref);
+		strbuf_addf(&path, "%s/HEAD", worktrees[i]->git_dir);
+
+		if (parse_ref(path.buf, &origref, NULL))
+			continue;
+
+		if (!strcmp(origref.buf, oldref)) {
+			int prefix_len = strlen(absolute_path(get_git_common_dir())) + 1;
+			const char *symref = path.buf + prefix_len;
+
+			/* no need to pass logmsg here as HEAD didn't really move */
+			if (create_symref(symref, newref, NULL)) {
+				error = -1;
+				break;
+			}
+		}
+	}
+
+	strbuf_release(&path);
+	strbuf_release(&origref);
+	free_worktrees(worktrees);
+
+	return error;
+}
diff --git a/worktree.h b/worktree.h
index b4b3dda..0d15d11 100644
--- a/worktree.h
+++ b/worktree.h
@@ -35,4 +35,11 @@ extern void free_worktrees(struct worktree **);
  */
 extern char *find_shared_symref(const char *symref, const char *target);
 
+/*
+ * Update all per-worktree HEADs pointing the old ref to point the new ref.
+ * This will be used when renaming a branch. Returns 0 if successful,
+ * non-zero otherwise.
+ */
+extern int update_worktrees_head_symref(const char *, const char *);
+
 #endif
-- 
2.8.0.rc3.13.gcd7ec22
