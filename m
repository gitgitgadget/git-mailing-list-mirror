From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 15/20] worktree: add_worktree: construct worktree-population command locally
Date: Thu, 16 Jul 2015 04:20:20 -0400
Message-ID: <1437034825-32054-16-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:21:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFePs-0008Ik-EZ
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbbGPIVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:21:06 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33426 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbbGPIVA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:21:00 -0400
Received: by iggp10 with SMTP id p10so8073628igg.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JY7QMt1hBMl9pKYsQmSswPmqVFZN/FOnh8uDPJ0PSfs=;
        b=XDkHZ0zXmqZ1qza6CvTq5c7OejP/wAoLCyliPAg2OeqYnKrts0/Q7VUz1dc/DskZPT
         OpdjO97cS11kaT/6rbuPryvtqPjpto/bFroE8T5pUeUafCiYKmyFSIcsu0cEVq9WMNZg
         UIV/btDz7Pk2m9cRZ5l4mlCxEjjmJFz2od1VKo8yKGDeKFp+cQWsZsehCM1pgZhnS2in
         3BD6hRXlL0zf4TjzjqdzHKsuxtfh14vOs84c1FErz5sCO7uAp8vTHiYyux7SmFmbiV/v
         UYbFVCKGWU3jL6lWRkXY5eA2UWK4ZToRZmXDCZrkCX/pZqVEa9gOzPwkKyRAw+aE7Rei
         Cq9w==
X-Received: by 10.107.5.1 with SMTP id 1mr10015187iof.88.1437034859619;
        Thu, 16 Jul 2015 01:20:59 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.58
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:59 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274012>

The caller of add_worktree() provides it with a command to invoke to
populate the new worktree. This was a useful abstraction during the
conversion of "git checkout --to" functionality to "git worktree add"
since git-checkout and git-worktree constructed the population command
differently. However, now that "git checkout --to" has been retired, and
add_worktree() has access to the options given to "worktree add", this
extra indirection is no longer useful and makes the code a bit
convoluted.

Moreover, the eventual goal is for git-worktree to make setting of HEAD
and worktree population distinct operations, whereas they are currently
conflated into a single git-checkout invocation. As such, add_worktree()
will eventually invoke other commands in addition to the worktree
population command, so it will be doing command construction itself
anyhow.

Therefore, relocate construction of the worktree population command from
add() to add_worktree().

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Changes since v1: reword commit message.

 builtin/worktree.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7ae186f..28095c1 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -178,7 +178,7 @@ static const char *worktree_basename(const char *path, int *olen)
 	return name;
 }
 
-static int add_worktree(const char *path, const char **child_argv,
+static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
 	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
@@ -261,7 +261,12 @@ static int add_worktree(const char *path, const char **child_argv,
 	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd = 1;
-	cp.argv = child_argv;
+	argv_array_push(&cp.args, "checkout");
+	if (opts->force)
+		argv_array_push(&cp.args, "--ignore-other-worktrees");
+	if (opts->detach)
+		argv_array_push(&cp.args, "--detach");
+	argv_array_push(&cp.args, refname);
 	cp.env = child_env.argv;
 	ret = run_command(&cp);
 	if (!ret) {
@@ -286,7 +291,6 @@ static int add(int ac, const char **av, const char *prefix)
 	struct add_opts opts;
 	const char *new_branch_force = NULL;
 	const char *path, *branch;
-	struct argv_array cmd = ARGV_ARRAY_INIT;
 	struct option options[] = {
 		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
@@ -331,14 +335,7 @@ static int add(int ac, const char **av, const char *prefix)
 		branch = opts.new_branch;
 	}
 
-	argv_array_push(&cmd, "checkout");
-	if (opts.force)
-		argv_array_push(&cmd, "--ignore-other-worktrees");
-	if (opts.detach)
-		argv_array_push(&cmd, "--detach");
-	argv_array_push(&cmd, branch);
-
-	return add_worktree(path, cmd.argv, &opts);
+	return add_worktree(path, branch, &opts);
 }
 
 int cmd_worktree(int ac, const char **av, const char *prefix)
-- 
2.5.0.rc2.378.g0af52e8
