From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 22/23] worktree: add: auto-vivify new branch when <branch> is omitted
Date: Mon,  6 Jul 2015 13:30:59 -0400
Message-ID: <1436203860-846-23-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:32:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAFM-0007pX-Px
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbbGFRbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:31:53 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37546 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbbGFRbv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:51 -0400
Received: by igau2 with SMTP id u2so16964223iga.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H/eEkhZBo2sm6QIYCem8ncg335tFi7y73zWQ+EYpA9k=;
        b=RkFd2wQSGdL8EUKCHJB4ndnBZ1K3Khu3TXgcCjnTcmuYPF6KCq2WyyQ4hb35TJrzu7
         DG/Bu/3vFhqLjqpsRgjg1ltc2ZjEDixRPy8sMNE7v6vWLEfP6r0Akd4AG81Iolc1Dl0J
         nZ806bXAGy+fLn6Z8XHEJ4Shhi76PqUuCUignTNMrvQ83dEBve81vwEK9pH+IDLJ2L7q
         x8cSzpcXTRyeD0jNtAo38oWDdomL+CPppjqeXNXE6KOGq776CCDfwJW/aqdB9xaJfqng
         eF9x2JaOwMrofH/OjLU7Ux4eketlvXtpdKCydvVnPl9CaezOhqAubgRBe2cdKcf3LSHi
         7THg==
X-Received: by 10.107.152.146 with SMTP id a140mr11682ioe.72.1436203910661;
        Mon, 06 Jul 2015 10:31:50 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.49
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:50 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273421>

As a convenience, when <branch> is omitted from "git worktree <path>
<branch>" and neither -b nor -B is used, automatically create a new
branch named after <path>, as if "-b $(basename <path>)" was specified.
Thus, "git worktree add ../hotfix" creates a new branch named "hotfix"
and associates it with new worktree "../hotfix".

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 8 ++++++--
 builtin/worktree.c             | 8 ++++++--
 t/t2025-worktree-add.sh        | 5 +++++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 377ae0f..da71f50 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,7 @@ git-worktree - Manage multiple worktrees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] [-b <new-branch>] <path> <branch>
+'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
 'git worktree prune' [-n] [-v] [--expire <expire>]
 
 DESCRIPTION
@@ -45,11 +45,15 @@ pruning should be suppressed. See section "DETAILS" for more information.
 
 COMMANDS
 --------
-add <path> <branch>::
+add <path> [<branch>]::
 
 Create `<path>` and checkout `<branch>` into it. The new working directory
 is linked to the current repository, sharing everything except working
 directory specific files such as HEAD, index, etc.
++
+If `<branch>` is omitted and neither `-b` nor `-B` is used, then, as a
+convenience, a new branch based at HEAD is created automatically, as if
+`-b $(basename <path>)` was specified.
 
 prune::
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 323d444..69248ba 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -291,12 +291,16 @@ static int add(int ac, const char **av, const char *prefix)
 		die(_("-b and -B are mutually exclusive"));
 	if (ac < 1 || ac > 2)
 		usage_with_options(worktree_usage, options);
-	if (ac < 2 && !new_branch && !new_branch_force)
-		usage_with_options(worktree_usage, options);
 
 	path = prefix ? prefix_filename(prefix, strlen(prefix), av[0]) : av[0];
 	branch = ac < 2 ? "HEAD" : av[1];
 
+	if (ac < 2 && !new_branch && !new_branch_force) {
+		int n;
+		const char *s = worktree_basename(path, &n);
+		new_branch = xstrndup(s, n);
+	}
+
 	argv_array_push(&cmd, "checkout");
 	if (force)
 		argv_array_push(&cmd, "--ignore-other-worktrees");
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 8964dec..8fe242f 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -145,4 +145,9 @@ test_expect_success '"add -b" with <branch> omitted' '
 	test_cmp_rev HEAD burble
 '
 
+test_expect_success '"add" with <branch> omitted' '
+	git worktree add wiffle/bat &&
+	test_cmp_rev HEAD bat
+'
+
 test_done
-- 
2.5.0.rc1.197.g417e668
