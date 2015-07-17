From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 17/22] worktree: add_worktree: construct worktree-population command locally
Date: Fri, 17 Jul 2015 19:00:12 -0400
Message-ID: <1437174017-81687-18-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:01:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEdX-0002UY-6s
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbbGQXBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:30 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34677 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbbGQXB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:28 -0400
Received: by igvi1 with SMTP id i1so45054889igv.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=reLvrV6IXSwt4Xwcc3QqopKdGBSQoMK7ALPOul/5Fy4=;
        b=C5HiDe0nrZwrf29W7Eyf9jieIBVT0debzF3OuNgOfjExQs4Kwc1wIUBN0omyVA30WH
         xbD+GwGwINGZ8AqW99GlcN6QIPlb1KmaoEZRK4mMkpbl/fB8eAxiSlf8YPE50w4nvKrh
         xEYumsoMiVr7LcyZ3N800OYK8DUZ139Q56XdRIde8GjqQCumMdxubllke5EV7VvO7Tbj
         ZJH4SwDKq+y65Rfgv3n4k3RxwIiJ1xzNl0tSjVJdPPGlAhUMC//Ao/+mtKlG4pHhiB7n
         qreaH6pURN/ehlF84nHP9rFJd/WxEZq9Z676BpGgL46UGe690w/6xE8Zu7IUOl20mvMc
         BcBw==
X-Received: by 10.50.7.104 with SMTP id i8mr928831iga.50.1437174088407;
        Fri, 17 Jul 2015 16:01:28 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.27
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:27 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274142>

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

No changes since v2.

 builtin/worktree.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7bd6f17..da76eb7 100644
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
