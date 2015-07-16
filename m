From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 11/20] worktree: introduce options container
Date: Thu, 16 Jul 2015 04:20:16 -0400
Message-ID: <1437034825-32054-12-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:22:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFeQn-0000KH-C6
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbbGPIWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:22:10 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36628 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045AbbGPIU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:20:57 -0400
Received: by igbij6 with SMTP id ij6so8313061igb.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E/thgPgrh26U7kbnk+Rk9Awvup7Kb+Jep0TOrdB2cN8=;
        b=Dwo4wQtFHPchcBuQIZUDblEDJlnmk3coMh6ebxgUCkNcTf4I6xoXEt4w18Y6POH3GJ
         EYNDTJkqWR1qTTdJX8o3l0AAebJxhC2xuQl0xmr9LQHaM0aIuxKLhsqmsnWcPhtFstAL
         4oNYkWWrm72ztQpYFyoGxe6Fp2U+jgf+jJvKxUzVX0uZcag0ZfVmRzWEd3aBJFK7T4x9
         HsNwipCgyYo9dD4B/xmadwIUOLCM3BDUCD+2LGA2CJ0W0UjmKqXMZtnm43TWBhtrx1Gv
         If1LpDmKLPrCfpHqckdwaW2RGsssQ4mKiimYI+GyknFOU0JG8BNvRCZiKtT19BWm68Lo
         fwNA==
X-Received: by 10.107.31.134 with SMTP id f128mr9199177iof.19.1437034856632;
        Thu, 16 Jul 2015 01:20:56 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.55
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:56 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274020>

add_worktree() will eventually need to deal with some options itself, so
introduce a structure into which options can be conveniently bundled,
and pass it along to add_worktree().

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v1.

 builtin/worktree.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index c267410..253382a 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -12,6 +12,13 @@ static const char * const worktree_usage[] = {
 	NULL
 };
 
+struct add_opts {
+	int force;
+	int detach;
+	const char *new_branch;
+	int force_new_branch;
+};
+
 static int show_only;
 static int verbose;
 static unsigned long expire;
@@ -171,7 +178,8 @@ static const char *worktree_basename(const char *path, int *olen)
 	return name;
 }
 
-static int add_worktree(const char *path, const char **child_argv)
+static int add_worktree(const char *path, const char **child_argv,
+			const struct add_opts *opts)
 {
 	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
@@ -272,22 +280,23 @@ static int add_worktree(const char *path, const char **child_argv)
 
 static int add(int ac, const char **av, const char *prefix)
 {
-	int force = 0, detach = 0, force_new_branch;
-	const char *new_branch = NULL, *new_branch_force = NULL;
+	struct add_opts opts;
+	const char *new_branch_force = NULL;
 	const char *path, *branch;
 	struct argv_array cmd = ARGV_ARRAY_INIT;
 	struct option options[] = {
-		OPT__FORCE(&force, N_("checkout <branch> even if already checked out in other worktree")),
-		OPT_STRING('b', NULL, &new_branch, N_("branch"),
+		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
+		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
 			   N_("create a new branch")),
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
 			   N_("create or reset a branch")),
-		OPT_BOOL(0, "detach", &detach, N_("detach HEAD at named commit")),
+		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_END()
 	};
 
+	memset(&opts, 0, sizeof(opts));
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
-	if (new_branch && new_branch_force)
+	if (opts.new_branch && new_branch_force)
 		die(_("-b and -B are mutually exclusive"));
 	if (ac < 1 || ac > 2)
 		usage_with_options(worktree_usage, options);
@@ -295,27 +304,27 @@ static int add(int ac, const char **av, const char *prefix)
 	path = prefix ? prefix_filename(prefix, strlen(prefix), av[0]) : av[0];
 	branch = ac < 2 ? "HEAD" : av[1];
 
-	force_new_branch = !!new_branch_force;
-	if (force_new_branch)
-		new_branch = new_branch_force;
+	opts.force_new_branch = !!new_branch_force;
+	if (opts.force_new_branch)
+		opts.new_branch = new_branch_force;
 
-	if (ac < 2 && !new_branch) {
+	if (ac < 2 && !opts.new_branch) {
 		int n;
 		const char *s = worktree_basename(path, &n);
-		new_branch = xstrndup(s, n);
+		opts.new_branch = xstrndup(s, n);
 	}
 
 	argv_array_push(&cmd, "checkout");
-	if (force)
+	if (opts.force)
 		argv_array_push(&cmd, "--ignore-other-worktrees");
-	if (new_branch)
-		argv_array_pushl(&cmd, force_new_branch ? "-B" : "-b",
-				 new_branch, NULL);
-	if (detach)
+	if (opts.new_branch)
+		argv_array_pushl(&cmd, opts.force_new_branch ? "-B" : "-b",
+				 opts.new_branch, NULL);
+	if (opts.detach)
 		argv_array_push(&cmd, "--detach");
 	argv_array_push(&cmd, branch);
 
-	return add_worktree(path, cmd.argv);
+	return add_worktree(path, cmd.argv, &opts);
 }
 
 int cmd_worktree(int ac, const char **av, const char *prefix)
-- 
2.5.0.rc2.378.g0af52e8
