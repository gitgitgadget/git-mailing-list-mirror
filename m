From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH v2 2/5] refs: add REF_COMMON_DIR flag
Date: Sat, 26 Mar 2016 03:28:20 +0900
Message-ID: <baa0ab35c01c536fc25dbc83402c116f8515d3e7.1458927521.git.k@rhe.jp>
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
	id 1ajWUF-0008G9-5p
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbcCYS3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:29:17 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:51590 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbcCYS3P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:29:15 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 318405AFF2;
	Fri, 25 Mar 2016 18:29:14 +0000 (UTC)
X-Mailer: git-send-email 2.8.0.rc4.21.g05df949
In-Reply-To: <cover.1458927521.git.k@rhe.jp>
In-Reply-To: <cover.1458927521.git.k@rhe.jp>
References: <1458553816-29091-1-git-send-email-k@rhe.jp> <cover.1458927521.git.k@rhe.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289933>

Add a flag to force using $GIT_COMMON_DIR, instead of selecting $GIT_DIR
or $GIT_COMMON_DIR by refname.

This allows updating worktree-specific refs of the main working tree
from a linked working tree. We will use this later.

Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
---
 refs.h               |  4 ++++
 refs/files-backend.c | 12 ++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/refs.h b/refs.h
index 5d9ab5c1c5dd..dc4782241e49 100644
--- a/refs.h
+++ b/refs.h
@@ -238,10 +238,14 @@ int pack_refs(unsigned int flags);
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
  *
+ * REF_COMMON_DIR: use $GIT_COMMON_DIR always. If not specified, $GIT_DIR or
+ *                 $GIT_COMMON_DIR is used depending on refname.
+ *
  * Other flags are reserved for internal use.
  */
 #define REF_NODEREF	0x01
 #define REF_FORCE_CREATE_REFLOG 0x40
+#define REF_COMMON_DIR 0x80
 
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a534f1a1e078..2a808d520213 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1918,6 +1918,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		resolve_flags |= RESOLVE_REF_NO_RECURSE;
 		lflags |= LOCK_NO_DEREF;
 	}
+	if (flags & REF_COMMON_DIR)
+		resolve_flags |= RESOLVE_REF_COMMON_DIR;
 
 	refname = resolve_ref_unsafe(refname, resolve_flags,
 				     lock->old_oid.hash, &type);
@@ -1928,7 +1930,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		 * it is normal for the empty directory 'foo'
 		 * to remain.
 		 */
-		strbuf_git_path(&orig_ref_file, "%s", orig_refname);
+		if (flags & REF_COMMON_DIR)
+			strbuf_addf(&orig_ref_file, "%s/%s", get_git_common_dir(), orig_refname);
+		else
+			strbuf_git_path(&orig_ref_file, "%s", orig_refname);
 		if (remove_empty_directories(&orig_ref_file)) {
 			last_errno = errno;
 			if (!verify_refname_available_dir(orig_refname, extras, skip,
@@ -1973,7 +1978,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
 	lock->ref_name = xstrdup(refname);
 	lock->orig_ref_name = xstrdup(orig_refname);
-	strbuf_git_path(&ref_file, "%s", refname);
+	if (flags & REF_COMMON_DIR)
+		strbuf_addf(&ref_file, "%s/%s", get_git_common_dir(), refname);
+	else
+		strbuf_git_path(&ref_file, "%s", refname);
 
  retry:
 	switch (safe_create_leading_directories_const(ref_file.buf)) {
-- 
2.8.0.rc4.21.g05df949
