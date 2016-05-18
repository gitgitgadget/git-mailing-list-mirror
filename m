From: Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>
Subject: [PATCH] Allow the short-hand - replacing @{-1} in git worktree add
Date: Thu, 19 May 2016 00:49:18 +0200
Message-ID: <1463611758-1210-1-git-send-email-jordan.de-gea@ensimag.grenoble-inp.fr>
Cc: samuel.groot@ensimag.grenoble-inp.fr,
	erwan.mathoniere@ensimag.grenoble-inp.fr,
	tom.russello@grenoble-inp.org, Matthieu.Moy@grenoble-inp.fr,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 00:57:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3APb-0001pG-1s
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 00:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbcERW5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 18:57:51 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:44489 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751081AbcERW5u (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2016 18:57:50 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 May 2016 18:57:50 EDT
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 7A4F92506;
	Thu, 19 May 2016 00:49:46 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jGy2Tz0AucG1; Thu, 19 May 2016 00:49:46 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 67DCD24A7;
	Thu, 19 May 2016 00:49:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 620562066;
	Thu, 19 May 2016 00:49:46 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ef-CfbzwEBXK; Thu, 19 May 2016 00:49:46 +0200 (CEST)
Received: from macbook-pro-de-jordan.home (LFbn-1-8005-19.w90-112.abo.wanadoo.fr [90.112.16.19])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id F312F2064;
	Thu, 19 May 2016 00:49:45 +0200 (CEST)
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295026>

Since `git worktree add` uses `git checkout` when `[<branch>]` is used,
and `git checkout -` is already supported, it makes sense to allow the
same shortcut in `git worktree add`.

Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>
---
 Documentation/git-worktree.txt |  3 ++-
 builtin/worktree.c             |  3 +++
 t/t2025-worktree-add.sh        | 17 +++++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index c622345..28dc559 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -48,7 +48,8 @@ add <path> [<branch>]::
 
 Create `<path>` and checkout `<branch>` into it. The new working directory
 is linked to the current repository, sharing everything except working
-directory specific files such as HEAD, index, etc.
+directory specific files such as HEAD, index, etc. You may also specify
+`-` as `<branch>` which is synonymous with `"@{-1}"`.
 +
 If `<branch>` is omitted and neither `-b` nor `-B` nor `--detached` used,
 then, as a convenience, a new branch based at HEAD is created automatically,
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d8e3795..d800d47 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -340,6 +340,9 @@ static int add(int ac, const char **av, const char *prefix)
 	path = prefix ? prefix_filename(prefix, strlen(prefix), av[0]) : av[0];
 	branch = ac < 2 ? "HEAD" : av[1];
 
+	if (!strcmp(branch, "-"))
+		branch = "@{-1}";
+
 	opts.force_new_branch = !!new_branch_force;
 	if (opts.force_new_branch) {
 		struct strbuf symref = STRBUF_INIT;
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 3acb992..3f8437b 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -18,6 +18,23 @@ test_expect_success '"add" an existing empty worktree' '
 	git worktree add --detach existing_empty master
 '
 
+test_expect_success '"add" using shorthand - fails when no previous branch' '
+	test_must_fail git worktree add existing -
+'
+
+test_expect_success '"add" using shorthand' '
+	git checkout -b newbranch &&
+	echo hello >myworld &&
+	git add myworld &&
+	git commit -m myworld &&
+	git checkout master &&
+	git worktree add short-hand - && 
+	(
+		cd short-hand &&
+		git status | head -1 | grep newbranch
+	)
+'
+
 test_expect_success '"add" refuses to checkout locked branch' '
 	test_must_fail git worktree add zere master &&
 	! test -d zere &&
-- 
2.7.4 (Apple Git-66)
