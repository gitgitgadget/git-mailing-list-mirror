From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH v2 4/5] branch -m: update all per-worktree HEADs
Date: Sat, 26 Mar 2016 03:28:22 +0900
Message-ID: <30620c02662c2eac34e50027326f190940b51fb8.1458927521.git.k@rhe.jp>
References: <cover.1458927521.git.k@rhe.jp>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>, Kazuki Yamaguchi <k@rhe.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 19:29:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWUE-0008G9-0U
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbcCYS3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:29:22 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:51604 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbcCYS3V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:29:21 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id ACBF35AFFF;
	Fri, 25 Mar 2016 18:29:18 +0000 (UTC)
X-Mailer: git-send-email 2.8.0.rc4.21.g05df949
In-Reply-To: <cover.1458927521.git.k@rhe.jp>
In-Reply-To: <cover.1458927521.git.k@rhe.jp>
References: <1458553816-29091-1-git-send-email-k@rhe.jp> <cover.1458927521.git.k@rhe.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289934>

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
 branch.c          | 32 ++++++++++++++++++++++++++++++++
 branch.h          |  7 +++++++
 builtin/branch.c  |  3 +--
 t/t3200-branch.sh | 23 ++++++++++++++++++++++-
 4 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/branch.c b/branch.c
index c50ea42172ce..df0928e32a70 100644
--- a/branch.c
+++ b/branch.c
@@ -344,3 +344,35 @@ void die_if_checked_out(const char *branch)
 		die(_("'%s' is already checked out at '%s'"), branch, existing);
 	}
 }
+
+int update_worktrees_head_symref(const char *oldref, const char *newref)
+{
+	int ret = 0;
+	struct strbuf symref = STRBUF_INIT;
+	struct worktree **worktrees = get_worktrees();
+	int i;
+	int common_prefix_len = strlen(absolute_path(get_git_common_dir())) + 1;
+
+	for (i = 0; worktrees[i]; i++) {
+		if (worktrees[i]->is_detached)
+			continue;
+
+		if (strcmp(oldref, worktrees[i]->head_ref))
+			continue;
+
+		strbuf_reset(&symref);
+		strbuf_addf(&symref, "%s/HEAD", worktrees[i]->git_dir);
+		strbuf_remove(&symref, 0, common_prefix_len);
+
+		if (create_symref_common_dir(symref.buf, newref, NULL)) {
+			ret = -1;
+			error(_("HEAD of working tree %s is not updated."),
+			      worktrees[i]->path);
+		}
+	}
+
+	strbuf_release(&symref);
+	free_worktrees(worktrees);
+
+	return ret;
+}
diff --git a/branch.h b/branch.h
index 78ad4387cd32..3f5ae4b8866e 100644
--- a/branch.h
+++ b/branch.h
@@ -60,4 +60,11 @@ extern int read_branch_desc(struct strbuf *, const char *branch_name);
  */
 extern void die_if_checked_out(const char *branch);
 
+/*
+ * Update all per-worktree HEADs pointing the old ref to point the new ref.
+ * This will be used when renaming a branch. Returns 0 if successful,
+ * non-zero otherwise.
+ */
+extern int update_worktrees_head_symref(const char *, const char *);
+
 #endif
diff --git a/builtin/branch.c b/builtin/branch.c
index 7b45b6bd6b80..31eb473d3e6a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -552,8 +552,7 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	if (recovery)
 		warning(_("Renamed a misnamed branch '%s' away"), oldref.buf + 11);
 
-	/* no need to pass logmsg here as HEAD didn't really move */
-	if (!strcmp(oldname, head) && create_symref("HEAD", newref.buf, NULL))
+	if (update_worktrees_head_symref(oldref.buf, newref.buf))
 		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
 
 	strbuf_addf(&oldsection, "branch.%s", oldref.buf + 11);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a89724849065..f7d438bd7d1d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -126,7 +126,28 @@ test_expect_success 'git branch -M foo bar should fail when bar is checked out'
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
+	git worktree add -b baz bazdir &&
+	git worktree add -f bazdir2 baz &&
+	git branch -M baz bam &&
+	test $(git -C bazdir rev-parse --abbrev-ref HEAD) = bam &&
+	test $(git -C bazdir2 rev-parse --abbrev-ref HEAD) = bam
+'
+
+test_expect_success 'git branch -M baz bam should succeed within a worktree in which baz is checked out' '
+	git checkout -b baz &&
+	git worktree add -f bazdir3 baz &&
+	(
+		cd bazdir3 &&
+		git branch -M baz bam &&
+		test $(git rev-parse --abbrev-ref HEAD) = bam
+	) &&
+	test $(git rev-parse --abbrev-ref HEAD) = bam
 '
 
 test_expect_success 'git branch -M master should work when master is checked out' '
-- 
2.8.0.rc4.21.g05df949
