From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 11/16] worktree: add_worktree: construct worktree-population command locally
Date: Fri, 10 Jul 2015 20:05:41 -0400
Message-ID: <1436573146-3893-12-git-send-email-sunshine@sunshineco.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 09:31:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDpG9-0002Sy-RM
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 09:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbbGKHbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 03:31:37 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36822 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbbGKHbh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 03:31:37 -0400
Received: by iecvh10 with SMTP id vh10so209196604iec.3
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 00:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U75nyjnHvH5L8S3vl7GswYMEBVIghngMWS2c/hkpiZw=;
        b=kTXFfS+3h8ntXzZzFJZ0oSCq/rdhR46RNYVgsl8GWFNNcdJrAbuHq9Jtsy2p9vDVme
         CKkMm70LtITblPR8z8wxLKgCssaCPQ5VLX7BawNsuJeqEdTCg0BW9TyWCR4lu6QCaL60
         0lbDxh6hlf373D2v+peXM2lG3Jt8GVYPPmokmQ9K+wGQYpTISrwJJ1GAbwUkL4cMAdEF
         IsEuVKpIAXMLudO6WJNuVPOZTKuUkg+1qTFdAD6/Iain/wUTI34RLE/yh5zLdo8Ag0A0
         VEbBJrvxiYTwkXDm5MXP3J2SuDApeJo97YYmH7eyE3VdT5muPamjC94RUskDLEuCyjfO
         icEQ==
X-Received: by 10.50.39.66 with SMTP id n2mr1204176igk.71.1436573197623;
        Fri, 10 Jul 2015 17:06:37 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.36
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:37 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273865>

The caller of add_worktree() provides it with a command to invoke to
populate the new worktree. This was a useful abstraction during the
conversion of "git checkout --to" functionality to "git worktree add"
since git-checkout and git-worktree constructed the population command
differently. However, now that "git checkout --to" has been retired, and
add_worktree() has access to the options given to "worktree add", this
extra indirection is no longer useful, and makes the code a bit more
convoluted than it needs to be.

Moreover, the eventual goal is for git-worktree to populate the new
worktree via "git reset --hard" rather than "git checkout", and to do
so, it may need to invoke other commands in addition to the
worktree-population command, so it will be doing command construction
itself anyhow. Therefore, relocate construction of the
worktree-population command from add() to add_worktree().

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9be1c74..e04a6d1 100644
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
@@ -260,7 +260,12 @@ static int add_worktree(const char *path, const char **child_argv,
 	setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
 	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd = 1;
-	cp.argv = child_argv;
+	argv_array_push(&cp.args, "checkout");
+	if (opts->force)
+		argv_array_push(&cp.args, "--ignore-other-worktrees");
+	if (opts->detach)
+		argv_array_push(&cp.args, "--detach");
+	argv_array_push(&cp.args, refname);
 	ret = run_command(&cp);
 	if (!ret) {
 		is_junk = 0;
@@ -283,7 +288,6 @@ static int add(int ac, const char **av, const char *prefix)
 	struct add_opts opts;
 	const char *new_branch_force = NULL;
 	const char *path, *branch;
-	struct argv_array cmd = ARGV_ARRAY_INIT;
 	struct option options[] = {
 		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
@@ -328,14 +332,7 @@ static int add(int ac, const char **av, const char *prefix)
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
2.5.0.rc1.201.ga12d9f8
