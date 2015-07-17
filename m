From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 11/22] worktree: simplify new branch (-b/-B) option checking
Date: Fri, 17 Jul 2015 19:00:06 -0400
Message-ID: <1437174017-81687-12-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:01:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEdi-0002al-Gg
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950AbbGQXBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:25 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38760 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbbGQXBX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:23 -0400
Received: by iggf3 with SMTP id f3so47295097igg.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fvnp5gCRusnSECHNBQBUFsew4X+845aPG9V4oas3fLw=;
        b=Z54zpI+bexW2YZogMg16l8XkEweGr7Po3FcembQksB+QMi8/LR0KnfbUUW77ShMJWm
         MyQZN6gVSRIsLSM+lGi/yu6W3arjXnL0+8UQBpZ+cqL55q0RPlChRboatOkmtEiEKoaF
         /eYBs3qMA40j+NGaYWeoMNfN2MpM5ZPd9ZDCUc/T7NSs6St/fRB9uraPnVYxbVGbnUfF
         i3jZ3QLu2GMSgtDy+cpyX5n9NHlmYk3QyxTZQViR5dh2RuAP7tnXBRPP0+YpaHpXUP30
         02htgUe14ssWHXYysqhNBk8OyvMBV49ytC5MWQo39ehHSj3mTPm7cmCe0ur+EqRCLml5
         4ALg==
X-Received: by 10.107.132.215 with SMTP id o84mr23415742ioi.36.1437174082766;
        Fri, 17 Jul 2015 16:01:22 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.21
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:22 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274144>

Make 'new_branch' be the name of the new branch for both forced and
non-forced cases; and add boolean 'force_new_branch' to indicate forced
branch creation. This will simplify logic later on when git-worktree
handles branch creation locally rather than delegating it to
git-checkout as part of the worktree population phase.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v2.

 builtin/worktree.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 5f0e3c2..bf4db9f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -272,7 +272,7 @@ static int add_worktree(const char *path, const char **child_argv)
 
 static int add(int ac, const char **av, const char *prefix)
 {
-	int force = 0, detach = 0;
+	int force = 0, detach = 0, force_new_branch;
 	const char *new_branch = NULL, *new_branch_force = NULL;
 	const char *path, *branch;
 	struct argv_array cmd = ARGV_ARRAY_INIT;
@@ -295,7 +295,11 @@ static int add(int ac, const char **av, const char *prefix)
 	path = prefix ? prefix_filename(prefix, strlen(prefix), av[0]) : av[0];
 	branch = ac < 2 ? "HEAD" : av[1];
 
-	if (ac < 2 && !new_branch && !new_branch_force) {
+	force_new_branch = !!new_branch_force;
+	if (force_new_branch)
+		new_branch = new_branch_force;
+
+	if (ac < 2 && !new_branch) {
 		int n;
 		const char *s = worktree_basename(path, &n);
 		new_branch = xstrndup(s, n);
@@ -305,9 +309,8 @@ static int add(int ac, const char **av, const char *prefix)
 	if (force)
 		argv_array_push(&cmd, "--ignore-other-worktrees");
 	if (new_branch)
-		argv_array_pushl(&cmd, "-b", new_branch, NULL);
-	if (new_branch_force)
-		argv_array_pushl(&cmd, "-B", new_branch_force, NULL);
+		argv_array_pushl(&cmd, force_new_branch ? "-B" : "-b",
+				 new_branch, NULL);
 	if (detach)
 		argv_array_push(&cmd, "--detach");
 	argv_array_push(&cmd, branch);
-- 
2.5.0.rc2.378.g0af52e8
