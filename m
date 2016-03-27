From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH v3 1/2] refs: add a new function set_worktree_head_symref
Date: Sun, 27 Mar 2016 23:37:13 +0900
Message-ID: <39bc3c1da6daf31f2a10e592dbb5d3daadc96199.1459087958.git.k@rhe.jp>
References: <cover.1459087958.git.k@rhe.jp>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Kazuki Yamaguchi <k@rhe.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 27 16:37:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akBp5-0002VE-W6
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 16:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbcC0Ohk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 10:37:40 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:57896 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948AbcC0Ohj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 10:37:39 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 909FA5B8C7;
	Sun, 27 Mar 2016 14:37:37 +0000 (UTC)
X-Mailer: git-send-email 2.8.0.rc4.21.g05df949
In-Reply-To: <cover.1459087958.git.k@rhe.jp>
In-Reply-To: <cover.1459087958.git.k@rhe.jp>
References: <1458553816-29091-1-git-send-email-k@rhe.jp> <cover.1459087958.git.k@rhe.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290008>

Add a new function set_worktree_head_symref, to update HEAD symref for
the specified worktree.

To update HEAD of a linked working tree,
create_symref("worktrees/$work_tree/HEAD", "refs/heads/$branch", msg)
could be used. However when it comes to updating HEAD of the main
working tree, it is unusable because it uses $GIT_DIR for
worktree-specific symrefs (HEAD).

The new function takes git_dir (real directory) as an argument, and
updates HEAD of the working tree. This function will be used when
renaming a branch.

Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
---
 refs.h               |  8 ++++++++
 refs/files-backend.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/refs.h b/refs.h
index 2f3decb432cf..f11154cf5faf 100644
--- a/refs.h
+++ b/refs.h
@@ -306,6 +306,14 @@ extern int rename_ref(const char *oldref, const char *newref, const char *logmsg
 
 extern int create_symref(const char *refname, const char *target, const char *logmsg);
 
+/*
+ * Update HEAD of the specified gitdir.
+ * Similar to create_symref("relative-git-dir/HEAD", target, NULL), but this is
+ * able to update the main working tree's HEAD wherever $GIT_DIR points to.
+ * Return 0 if successful, non-zero otherwise.
+ * */
+extern int set_worktree_head_symref(const char *gitdir, const char *target);
+
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
 	UPDATE_REFS_DIE_ON_ERR,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 81f68f846b69..ec237efec35d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2894,6 +2894,41 @@ int create_symref(const char *refname, const char *target, const char *logmsg)
 	return ret;
 }
 
+int set_worktree_head_symref(const char *gitdir, const char *target)
+{
+	static struct lock_file head_lock;
+	struct ref_lock *lock;
+	struct strbuf err = STRBUF_INIT;
+	struct strbuf head_path = STRBUF_INIT;
+	const char *head_rel;
+	int ret;
+
+	strbuf_addf(&head_path, "%s/HEAD", absolute_path(gitdir));
+	if (hold_lock_file_for_update(&head_lock, head_path.buf,
+				      LOCK_NO_DEREF) < 0) {
+		error("%s", err.buf);
+		strbuf_release(&err);
+		strbuf_release(&head_path);
+		return -1;
+	}
+
+	/* head_rel will be "HEAD" for the main tree, "worktrees/wt/HEAD" for
+	   linked trees */
+	head_rel = remove_leading_path(head_path.buf,
+				       absolute_path(get_git_common_dir()));
+	/* to make use of create_symref_locked(), initialize ref_lock */
+	lock = xcalloc(1, sizeof(struct ref_lock));
+	lock->lk = &head_lock;
+	lock->ref_name = xstrdup(head_rel);
+	lock->orig_ref_name = xstrdup(head_rel);
+
+	ret = create_symref_locked(lock, head_rel, target, NULL);
+
+	unlock_ref(lock); /* will free lock */
+	strbuf_release(&head_path);
+	return ret;
+}
+
 int reflog_exists(const char *refname)
 {
 	struct stat st;
-- 
2.8.0.rc4.21.g05df949
