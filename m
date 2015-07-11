From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 08/16] worktree: introduce options container
Date: Fri, 10 Jul 2015 20:05:38 -0400
Message-ID: <1436573146-3893-9-git-send-email-sunshine@sunshineco.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 08:57:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDoj6-0001fA-No
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 08:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbbGKG53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 02:57:29 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36369 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbbGKG52 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 02:57:28 -0400
Received: by igrv9 with SMTP id v9so26896507igr.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 23:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ObhKyFNa05Ao3vQoiOZKreXjpam5sArLkJ55lQiEjm8=;
        b=t0kIwafvZ9clYBlPwi7BLcLrzAfqbFLqObiFu3sidHlKAJ3pVBoSRItDXdop+CxRri
         e/pMep4Zna7pbsUuBHsQvf4EKU51VyHrX2C2GimqyVaZTZcp/MO6B5sXPIRkpZ+M2WjG
         WlxKH0P6L6EGgGtql0/yBCquuM5vGgDo8XyRU9VG5nL25H4oHYntH34FtvyFDvGMcaOh
         h24VMRqesJXak1lwyr3qamOO4xTRJBq+yWciB1UZrG3ozRs7uw8CRES0aw+WKke4PF1D
         P3xnvWHJv3vRvJbOKlp+YOx0UI04WHlgQXOgZ2usZcC3UlhoNfLNddXzBi3xEjssJ6Cq
         yiDA==
X-Received: by 10.50.136.134 with SMTP id qa6mr1405970igb.26.1436573195067;
        Fri, 10 Jul 2015 17:06:35 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.34
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273849>

add_worktree() will eventually need to deal with some options itself, so
introduce a structure into which options can be conveniently bundled,
and pass it along to add_worktree().

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
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
2.5.0.rc1.201.ga12d9f8
