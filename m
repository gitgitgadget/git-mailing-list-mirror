From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 10/16] worktree: make branch creation distinct from worktree population
Date: Fri, 10 Jul 2015 20:05:40 -0400
Message-ID: <1436573146-3893-11-git-send-email-sunshine@sunshineco.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 09:06:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDos8-0006ZH-L2
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 09:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbbGKHGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 03:06:49 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36368 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbbGKHGs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 03:06:48 -0400
Received: by igrv9 with SMTP id v9so26975320igr.1
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 00:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CTj1VesXcZtqWMHzLKUdls80egA67nrx7JTC79S49gE=;
        b=F9RSFKcC6SoQT4INHFI299H5PQzwPeej3Le86sq1aWCNm5WMBvALF9NIeJUKK9XgLD
         eopmNj+GQSaJPfigRxkPRO+pzVvJ6VEB4UZxZZLyCpfArm34DYYB4BqKavOMkPthQU4R
         TQOqKivJ2Zwc5QnXQcLTdrD5djlRAGoyn/GciP+te/laM34HkwjixKBO2nKbIv4Fi6By
         7L241QSmwsq0HzuoRmyxMSQcIg5qJBUF05fH+jTYwcVq5DjmswLHrCJF+5veYLht5oQ+
         hQ5u9O8RuMe5YJBa/PA0lmrkaNtIg+22yvYdsWxxosEiPaRKP74WHWjTec0PAl67J0Bx
         oMIA==
X-Received: by 10.50.72.41 with SMTP id a9mr1218854igv.51.1436573196824;
        Fri, 10 Jul 2015 17:06:36 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.35
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:36 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273854>

The plan is eventually to populate the new worktree via "git reset
--hard" rather than "git checkout". Thus, rather than piggybacking on
git-checkout's -b/-B ability to create a new branch at checkout time,
git-worktree will need to do so itself.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

I considered calling branch-related API, such as create_branch(),
directly, however, git-branch provides extra value which may be useful
in the future (such as when --track and --orphan get added to
git-worktree), so it seemed wise to re-use git-branch's implementation
rather than duplicating the functionality. If this proves the wrong
choice, then the series can either be re-rolled or follow-on patches can
address the issue.

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
2.5.0.rc1.201.ga12d9f8
