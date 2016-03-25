From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH v2 3/5] refs: add create_symref_common_dir as a variation of create_symref
Date: Sat, 26 Mar 2016 03:28:21 +0900
Message-ID: <1d91378d1f1e994ccc69d5c6ef4f0d5332d37eec.1458927521.git.k@rhe.jp>
References: <cover.1458927521.git.k@rhe.jp>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>, Kazuki Yamaguchi <k@rhe.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 19:29:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWUD-0008G9-Ev
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbcCYS3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:29:20 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:51596 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbcCYS3T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:29:19 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 728ED5AFF5;
	Fri, 25 Mar 2016 18:29:15 +0000 (UTC)
X-Mailer: git-send-email 2.8.0.rc4.21.g05df949
In-Reply-To: <cover.1458927521.git.k@rhe.jp>
In-Reply-To: <cover.1458927521.git.k@rhe.jp>
References: <1458553816-29091-1-git-send-email-k@rhe.jp> <cover.1458927521.git.k@rhe.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289931>

Add a new function create_symref_common_dir. This function passes
REF_COMMON_DIR to lock_ref_sha1_basic, unlike create_symref, so to make
it possible to update main working tree's per-worktree symbolic refs
(HEAD) when we are in a linked working tree.

Assume we have a linked working tree and we are in it. If we call
create_symref("HEAD", "refs/heads/branch-a", NULL), this updates the
working tree's HEAD, located at .git/worktrees/tree-a/HEAD, rather than
the main working tree's HEAD, .git/HEAD.
The new function create_symref_common_dir always updates the main
working tree's HEAD regardless of where we are.

This will be needed when renaming a branch.

Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
---
 refs.h               |  3 +++
 refs/files-backend.c | 17 ++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/refs.h b/refs.h
index dc4782241e49..ff8dbbe1a0e5 100644
--- a/refs.h
+++ b/refs.h
@@ -312,7 +312,10 @@ extern char *shorten_unambiguous_ref(const char *refname, int strict);
 /** rename ref, return 0 on success **/
 extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
 
+/* create or update a symref */
 extern int create_symref(const char *refname, const char *target, const char *logmsg);
+/* same as create_symref, but refname is always $GIT_COMMON_DIR/refname */
+extern int create_symref_common_dir(const char *refname, const char *target, const char *logmsg);
 
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2a808d520213..1fe4d4e75188 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2886,14 +2886,15 @@ static int create_symref_locked(struct ref_lock *lock, const char *refname,
 	return 0;
 }
 
-int create_symref(const char *refname, const char *target, const char *logmsg)
+static int create_symref_internal(const char *refname, const char *target,
+				  const char *logmsg, unsigned int flags)
 {
 	struct strbuf err = STRBUF_INIT;
 	struct ref_lock *lock;
 	int ret;
 
-	lock = lock_ref_sha1_basic(refname, NULL, NULL, NULL, REF_NODEREF, NULL,
-				   &err);
+	lock = lock_ref_sha1_basic(refname, NULL, NULL, NULL, REF_NODEREF | flags,
+				   NULL, &err);
 	if (!lock) {
 		error("%s", err.buf);
 		strbuf_release(&err);
@@ -2905,6 +2906,16 @@ int create_symref(const char *refname, const char *target, const char *logmsg)
 	return ret;
 }
 
+int create_symref(const char *refname, const char *target, const char *logmsg)
+{
+	return create_symref_internal(refname, target, logmsg, 0);
+}
+
+int create_symref_common_dir(const char *refname, const char *target, const char *logmsg)
+{
+	return create_symref_internal(refname, target, logmsg, REF_COMMON_DIR);
+}
+
 int reflog_exists(const char *refname)
 {
 	struct stat st;
-- 
2.8.0.rc4.21.g05df949
