From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 15/22] worktree: make branch creation distinct from worktree population
Date: Fri, 17 Jul 2015 19:00:10 -0400
Message-ID: <1437174017-81687-16-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:01:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEdc-0002Wq-EN
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbbGQXBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:47 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38788 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbbGQXB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:26 -0400
Received: by iggf3 with SMTP id f3so47295934igg.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ARln1+VFP8Db4zbQhKr9xsBaJK9NdnU8X3KqFthHZw=;
        b=0R9lfxrIAP/shl5xdVpsZcH7GweDrdz5Nmtf750Z1O2hZJ+EYOtIqkFKmdej4GDy8F
         tsNOjywcLB6TkoqZhD/jxfbsl1MYBrQ6GrDzpK1gvTR9UYb57MLrF9ZB9ct5WJC3zARp
         wZdygws0EKlbl3rwbgxjX6hSszU8Y6jzvo7g1+7hz0lNeLaK8nNR0CaWfvQYGedMx3Zr
         WR3nnCiJCMgF3O2lxYrS6EBmEyrR/7A3N2nEkF97BA0OBulJzufuN/72jzppd4zyVWDW
         75TLZKCM7HLxVCkjKSU1esvt++8d/LPPxerE1M81bmRo3QRm5B0k1SIHYQ4T1ZSF8yEp
         zJ5Q==
X-Received: by 10.107.3.104 with SMTP id 101mr21979867iod.48.1437174086430;
        Fri, 17 Jul 2015 16:01:26 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.25
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:25 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274140>

git-worktree currently conflates branch creation, setting of HEAD in the
new worktree, and worktree population into a single sub-invocation of
git-checkout, which requires git-checkout to be specially aware that it
is operating in a newly-created worktree. The goal is to free
git-checkout of that special knowledge, and to do so, git-worktree will
eventually perform those operations separately. Thus, as a first step,
rather than piggybacking on git-checkout's -b/-B ability to create a new
branch at checkout time, make git-worktree responsible for branch
creation itself.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v2.

 builtin/worktree.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 83484ad..8225468 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -314,12 +314,23 @@ static int add(int ac, const char **av, const char *prefix)
 		opts.new_branch = xstrndup(s, n);
 	}
 
+	if (opts.new_branch) {
+		struct child_process cp;
+		memset(&cp, 0, sizeof(cp));
+		cp.git_cmd = 1;
+		argv_array_push(&cp.args, "branch");
+		if (opts.force_new_branch)
+			argv_array_push(&cp.args, "--force");
+		argv_array_push(&cp.args, opts.new_branch);
+		argv_array_push(&cp.args, branch);
+		if (run_command(&cp))
+			return -1;
+		branch = opts.new_branch;
+	}
+
 	argv_array_push(&cmd, "checkout");
 	if (opts.force)
 		argv_array_push(&cmd, "--ignore-other-worktrees");
-	if (opts.new_branch)
-		argv_array_pushl(&cmd, opts.force_new_branch ? "-B" : "-b",
-				 opts.new_branch, NULL);
 	if (opts.detach)
 		argv_array_push(&cmd, "--detach");
 	argv_array_push(&cmd, branch);
-- 
2.5.0.rc2.378.g0af52e8
