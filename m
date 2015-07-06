From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 13/23] worktree: introduce "add" command
Date: Mon,  6 Jul 2015 13:30:50 -0400
Message-ID: <1436203860-846-14-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:31:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAFC-0007jC-Vm
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031AbbGFRbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:31:44 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37441 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857AbbGFRbm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:42 -0400
Received: by igau2 with SMTP id u2so16961213iga.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hDzTPjV7F+m1nlrZVOpnvlwyQ7p7uHcQM1dccrzpZcE=;
        b=WOB0r82wslBwwtJMmy9NziNEWyREellzoWknHaRPBWpoM4SuxaBlLs8Mx49Kgk4KZM
         yle/MGEAw8ElbkhEOpUc9/AIWROD8vCgH0hYQVVCxN0Bht5VtQZUDTvbw11so5LxR0oC
         XxTug9NSv0SQHChQ7KrS6FQHpyLj5Yl5UMu/PJMJvKQQnkO3oDIyu6iboOLo0b09/EYY
         xIPmGInngOgnE2lg6EVqyUqE6osymJ40S7VO3jzS1GDweGt2u1tIfSCjzv85k1YT3RTI
         1dVaoFTKZVAkT7gJdZowB9nzUM030YxDbhhUnIZm+x1hVaIk+nJlYbrewUOV6d5rcVcu
         eH6A==
X-Received: by 10.50.8.68 with SMTP id p4mr44762787iga.4.1436203901970;
        Mon, 06 Jul 2015 10:31:41 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.41
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:41 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273418>

The plan is to relocate "git checkout --to" functionality to "git
worktree add". As a first step, introduce a bare-bones git-worktree
"add" command along with documentation. At this stage, "git worktree
add" merely invokes "git checkout --to" behind the scenes, but an
upcoming patch will move the actual functionality
(checkout.c:prepare_linked_checkout() and its helpers) to worktree.c.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 20 ++++++++++----------
 builtin/worktree.c             | 31 +++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 6afff1e..def3027 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,13 +9,13 @@ git-worktree - Manage multiple worktrees
 SYNOPSIS
 --------
 [verse]
+'git worktree add' <path> <branch>
 'git worktree prune' [-n] [-v] [--expire <expire>]
 
 DESCRIPTION
 -----------
 
-Manage multiple worktrees attached to the same repository. These are
-created by the command `git checkout --to`.
+Manage multiple worktrees attached to the same repository.
 
 A git repository can support multiple working trees, allowing you to check
 out more than one branch at a time.  With `git checkout --to` a new working
@@ -45,6 +45,12 @@ pruning should be suppressed. See section "DETAILS" for more information.
 
 COMMANDS
 --------
+add <path> <branch>::
+
+Create `<path>` and checkout `<branch>` into it. The new working directory
+is linked to the current repository, sharing everything except working
+directory specific files such as HEAD, index, etc.
+
 prune::
 
 Prune working tree information in $GIT_DIR/worktrees.
@@ -118,7 +124,7 @@ refactoring session.
 
 ------------
 $ git branch emergency-fix master
-$ git checkout --to ../temp emergency-fix
+$ git worktree add ../temp emergency-fix
 $ pushd ../temp
 # ... hack hack hack ...
 $ git commit -a -m 'emergency fix for boss'
@@ -133,9 +139,8 @@ Multiple checkout support for submodules is incomplete. It is NOT
 recommended to make multiple checkouts of a superproject.
 
 git-worktree could provide more automation for tasks currently
-performed manually or via other commands, such as:
+performed manually, such as:
 
-- `add` to create a new linked worktree
 - `remove` to remove a linked worktree and its administrative files (and
   warn if the worktree is dirty)
 - `mv` to move or rename a worktree and update its administrative files
@@ -143,11 +148,6 @@ performed manually or via other commands, such as:
 - `lock` to prevent automatic pruning of administrative files (for instance,
   for a worktree on a portable device)
 
-SEE ALSO
---------
-
-linkgit:git-checkout[1]
-
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2a729c6..e0749c0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -2,8 +2,11 @@
 #include "builtin.h"
 #include "dir.h"
 #include "parse-options.h"
+#include "argv-array.h"
+#include "run-command.h"
 
 static const char * const worktree_usage[] = {
+	N_("git worktree add <path> <branch>"),
 	N_("git worktree prune [<options>]"),
 	NULL
 };
@@ -119,6 +122,32 @@ static int prune(int ac, const char **av, const char *prefix)
 	return 0;
 }
 
+static int add(int ac, const char **av, const char *prefix)
+{
+	struct child_process c;
+	const char *path, *branch;
+	struct argv_array cmd = ARGV_ARRAY_INIT;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac != 2)
+		usage_with_options(worktree_usage, options);
+
+	path = prefix ? prefix_filename(prefix, strlen(prefix), av[0]) : av[0];
+	branch = av[1];
+
+	argv_array_push(&cmd, "checkout");
+	argv_array_pushl(&cmd, "--to", path, NULL);
+	argv_array_push(&cmd, branch);
+
+	memset(&c, 0, sizeof(c));
+	c.git_cmd = 1;
+	c.argv = cmd.argv;
+	return run_command(&c);
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -127,6 +156,8 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 
 	if (ac < 2)
 		usage_with_options(worktree_usage, options);
+	if (!strcmp(av[1], "add"))
+		return add(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "prune"))
 		return prune(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
-- 
2.5.0.rc1.197.g417e668
