From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 22/23] worktree: add: auto-vivify new branch when <branch> is omitted
Date: Fri,  3 Jul 2015 20:17:31 -0400
Message-ID: <1435969052-540-23-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:19:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBBL-0000bU-49
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109AbbGDATm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:19:42 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34352 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755861AbbGDASq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:46 -0400
Received: by igcsj18 with SMTP id sj18so196950949igc.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vFc7+8ZNqkM/E8xufLgM8syJy2DLwaDzcBNfIrzOxYo=;
        b=MT5dN7hXzmV65zBQ9CpRUVbZCjIY40mNReOVHstt0tiIO5AwAU804E5yF5oH+GnjFl
         LnL9HP6/umcUNQZk8hS6jvV463kw+dp7rWq4Y8kT18d7igQsubgR22VONULwsp6k2aWQ
         pqypOXQvUqk/AM3XSGBaSvfyNAbjiBrSl3VZlaI0/OFKbWolapTFsBEvmV3pceFlL+BA
         MYCWiOKpf5ZPpGTaloqncvFGQ3if7YNsocdEG08KDKP5GikTbAHt9G0AO4Ci3FnnBc/E
         lmJkxlIKcL4d37/AvTa8sAkDWPJASpCODXpv86r7a5Rtmlq61Knih0BW55pdDMr+xUJA
         ep7w==
X-Received: by 10.50.61.130 with SMTP id p2mr25979034igr.9.1435969125740;
        Fri, 03 Jul 2015 17:18:45 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.45
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:45 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273335>

As a convenience, when <branch> is omitted from "git worktree <path>
<branch>" and neither -b nor -B used, automatically create a new branch
named after <path>, as if "-b $(basename <path>)" was specified. Thus,
"git worktree add ../hotfix" creates a new branch named "hotfix" and
associates it with new worktree "../hotfix".

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 8 ++++++--
 builtin/worktree.c             | 8 ++++++--
 t/t2025-worktree-add.sh        | 7 +++++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 5ca11f6..938bdab 100644
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
@@ -45,12 +45,16 @@ pruning should be suppressed. See section "DETAILS" for more information.
 
 COMMANDS
 --------
-add <path> <branch>::
+add <path> [<branch>]::
 
 Check out `<branch>` into a separate working directory, `<path>`, creating
 `<path>` if necessary. The new working directory is linked to the current
 repository, sharing everything except working directory specific files
 such as HEAD, index, etc. If `<path>` already exists, it must be empty.
++
+If `<branch>` is omitted and neither `-b` nor `-B` used, then, as a
+convenience, a new branch rooted at HEAD is created automatically, as if
+`-b $(basename <path>)` was specified.
 
 prune::
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index bf634a6..c8c6fa7 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -286,12 +286,16 @@ static int add(int ac, const char **av, const char *prefix)
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
index 95a1141..59d73ff 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -147,4 +147,11 @@ test_expect_success '"add -b" with <branch> omitted' '
 	test_cmp expected actual
 '
 
+test_expect_success '"add" with <branch> omitted' '
+	git rev-parse HEAD >expected &&
+	git worktree add wiffle/bat &&
+	git rev-parse bat >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.5.0.rc1.197.g417e668
