From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 03/20] checkout: improve die_if_checked_out() robustness
Date: Thu, 16 Jul 2015 04:20:08 -0400
Message-ID: <1437034825-32054-4-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:23:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFeS5-0000uA-Sz
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbbGPIXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:23:25 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34335 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbbGPIUv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:20:51 -0400
Received: by igvi1 with SMTP id i1so8054124igv.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AlzlYBTKj7nq4KdcOde3XXWRNCYM3JWzUAGfSH7bkpU=;
        b=rg0PveDS+bvKWvvpVk1ucaXvCn+l8oZCigVMguy0i64TWjbr3PlVckpJL26TTEsPTv
         4FeyX41EQuGpOIuETXGlHkLTkkCwWAjv1P3sc0rp0AnI6wsjlE8L7wWjC9cHq7PDRRWO
         /WXksZqENj+kVLqs+bBuSfByHQSQBM2PwGst0mwm/iADJGT0QqYUrJaq64CI5Y4mVJ9X
         6EPereIhd9TC6lJo6692h8Hs8kc94nSFLkt69YqZ/k4zqNGBphTCBn2g5JbiVNkJmFLr
         Vh/Y36v29ubUTvIz7dJ1l0mT+mVvbvKWHSHfdcJg0LR5pfspo+XtBYGPFqWpd7wrod9b
         3jMQ==
X-Received: by 10.107.30.209 with SMTP id e200mr9674258ioe.57.1437034850593;
        Thu, 16 Jul 2015 01:20:50 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.49
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:50 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274027>

die_if_checked_out() is intended to check if the branch about to be
checked out is already checked out either in the main worktree or in a
linked worktree. However, if .git/worktrees directory does not exist,
then it never bothers checking the main worktree, even though the
specified branch might indeed be checked out there, which is fragile
behavior.

This hasn't been a problem in practice since the current implementation
of "git worktree add" (and, earlier, "git checkout --to") always creates
.git/worktrees before die_if_checked_out() is called by the child "git
checkout" invocation which populates the new worktree.

However, git-worktree will eventually want to call die_if_checked_out()
itself rather than only doing so indirectly as a side-effect of invoking
git-checkout, and reliance upon order of operations (creating
.git/worktrees before checking if a branch is already checked out) is
fragile. As a general function, callers should not be expected to abide
by this undocumented and unwarranted restriction. Therefore, make
die_if_checked_out() more robust by checking the main worktree whether
.git/worktrees exists or not.

While here, also move a comment explaining why die_if_checked_out()'s
helper parses HEAD manually. Such information resides more naturally
with the helper itself rather than at its first point of call.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Changes since v1: relocate comment; reword commit message.

 builtin/checkout.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e75fb5e..1992c41 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -880,6 +880,11 @@ static void check_linked_checkout(struct branch_info *new, const char *id)
 	struct strbuf gitdir = STRBUF_INIT;
 	const char *start, *end;
 
+	/*
+	 * $GIT_COMMON_DIR/HEAD is practically outside
+	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
+	 * uses git_path). Parse the ref ourselves.
+	 */
 	if (id)
 		strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
 	else
@@ -916,19 +921,14 @@ static void die_if_checked_out(struct branch_info *new)
 	DIR *dir;
 	struct dirent *d;
 
+	check_linked_checkout(new, NULL);
+
 	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
 	if ((dir = opendir(path.buf)) == NULL) {
 		strbuf_release(&path);
 		return;
 	}
 
-	/*
-	 * $GIT_COMMON_DIR/HEAD is practically outside
-	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
-	 * uses git_path). Parse the ref ourselves.
-	 */
-	check_linked_checkout(new, NULL);
-
 	while ((d = readdir(dir)) != NULL) {
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
-- 
2.5.0.rc2.378.g0af52e8
