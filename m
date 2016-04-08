From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH] set_worktree_head_symref(): fix error message
Date: Fri,  8 Apr 2016 17:03:07 +0900
Message-ID: <1460102587-22297-1-git-send-email-k@rhe.jp>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kazuki Yamaguchi <k@rhe.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 10:04:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoROc-000655-Sc
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 10:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757971AbcDHIDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 04:03:43 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:44720 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757969AbcDHIDk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 04:03:40 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 77E7261876;
	Fri,  8 Apr 2016 08:03:22 +0000 (UTC)
X-Mailer: git-send-email 2.8.0.rc4.18.g70999e9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291019>

Emit an informative error when failed to hold lock of HEAD.

2233066 (refs: add a new function set_worktree_head_symref) added
set_worktree_head_symref() but this is missing a call to
unable_to_lock_message() after hold_lock_file_for_update() fails, so it
emits an empty error message:

  % git branch -m oldname newname
  error:
  error: HEAD of working tree /path/to/wt is not updated
  fatal: Branch renamed to newname, but HEAD is not updated!

Thanks to Eric Sunshine for pointing this out.

Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
---
I'm sorry, this is my mistake in my previous patch which is already
merged to 'next':
- 2233066 (refs: add a new function set_worktree_head_symref)
- http://thread.gmane.org/gmane.comp.version-control.git/289413/focus=290008

This applies on top of ky/branch-m-worktree.

Thanks,

 refs/files-backend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ec237efec35d..ea78ce9d90f0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2898,7 +2898,6 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 {
 	static struct lock_file head_lock;
 	struct ref_lock *lock;
-	struct strbuf err = STRBUF_INIT;
 	struct strbuf head_path = STRBUF_INIT;
 	const char *head_rel;
 	int ret;
@@ -2906,6 +2905,8 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 	strbuf_addf(&head_path, "%s/HEAD", absolute_path(gitdir));
 	if (hold_lock_file_for_update(&head_lock, head_path.buf,
 				      LOCK_NO_DEREF) < 0) {
+		struct strbuf err = STRBUF_INIT;
+		unable_to_lock_message(head_path.buf, errno, &err);
 		error("%s", err.buf);
 		strbuf_release(&err);
 		strbuf_release(&head_path);
-- 
2.8.0.rc4.18.g70999e9.dirty
