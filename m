From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 13/20] worktree: make branch creation distinct from worktree population
Date: Thu, 16 Jul 2015 04:20:18 -0400
Message-ID: <1437034825-32054-14-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:21:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFeQY-0000Eb-TD
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519AbbGPIVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:21:55 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35044 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731AbbGPIU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:20:58 -0400
Received: by igcqs7 with SMTP id qs7so8319994igc.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iwpCFHjfgrMGgECIExfYUuSxj4DpanhqOx5ME/dXPkQ=;
        b=z66FykXavyzpmIF99o8g32VLu6LVMPXUuM7Jf9zTRiTSrzqJQlhdGf+WPsLLVocBvF
         6OI6XQ4arEiPTjkyCP30mA4RdpW0SO+oTjpvxmEFLm0AlHJiu0tDysBdajnSNl1hYW1p
         FHseLB8e2VBSHs743qcAOYY603KM46TQrafzMQZtKogEb9e1C1sMPRaDfdv5mVVUNPgX
         N1d5WYuG+K626fzReltg/Afbf0ppJDr0O7Eew7jBXZrlPwmBIGmvSDoxN4Jgi8a3xQ4w
         RmpxjAzGTZnsUciei8ZWgHXN/fhAGFSiMbuEA3Xe+74h+Hwy3l+9kD1xWR/2NZ+ooCsP
         m5KA==
X-Received: by 10.107.164.38 with SMTP id n38mr9861080ioe.73.1437034858170;
        Thu, 16 Jul 2015 01:20:58 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.57
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:57 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274016>

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

Changes since v1: reword commit message.

 builtin/worktree.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index cd06bf5..9be1c74 100644
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
