From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 03/22] checkout: improve die_if_checked_out() robustness
Date: Fri, 17 Jul 2015 18:59:58 -0400
Message-ID: <1437174017-81687-4-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:02:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEe1-0002lq-AG
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbbGQXCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:02:12 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:32949 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712AbbGQXBP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:15 -0400
Received: by igbpg9 with SMTP id pg9so5819928igb.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x6StjCbJpGTZ7e9+ueGED6bJ+jqHQWJ3eAQ3BMiXtw8=;
        b=ZFOropkCUGKbY819EAYJq3CcDsoW5PCFoyAn8zNEqCKLmVum300OinyG/SrCGTnEVk
         itwHEvbCE2t2MgGZQDku6uzbqOZxUwBj0inVJvGndMaJ1OvU/I0uQJfC/YPClF49GFQo
         Ey3j1EbrexzNxAtiOFOxNQRFhHt9phu2Ywli7i7+6EpLiKRsak4+/k9yeZOXqoUZ2aGa
         6TAsY37ENP8jZ2df4TtjTzWab3J66rlaG3Pt8vpz34D8RqRyehP+CyKMcZ5GiPpz5UrS
         khCm2PqW8gOAvQ5y5Ogc/I6krzN0i3HJa6s1AgH+BtP8cDGmyXGBlBWEvAKIcFABUVIO
         nQ+A==
X-Received: by 10.107.3.104 with SMTP id 101mr21979003iod.48.1437174074871;
        Fri, 17 Jul 2015 16:01:14 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.14
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:14 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274149>

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

No changes since v2.

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
