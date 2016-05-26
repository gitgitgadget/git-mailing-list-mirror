From: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Subject: [PATCH] worktree: allow "-" short-hand for @{-1} in add command
Date: Thu, 26 May 2016 13:54:22 +0200
Message-ID: <1464263662-1290-1-git-send-email-jordan.de-gea@grenoble-inp.org>
References: <vpqshx5cb51.fsf@anie.imag.fr>
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, tom.russello@grenoble-inp.org,
	Matthieu.Moy@grenoble-inp.fr,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 26 13:54:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5ts3-0000S5-Qw
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 13:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbcEZLyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 07:54:32 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:49407 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbcEZLyb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 07:54:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4DDF92541;
	Thu, 26 May 2016 13:54:27 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1hfwN1cQjTB0; Thu, 26 May 2016 13:54:27 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 3E5292129;
	Thu, 26 May 2016 13:54:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 3740D2077;
	Thu, 26 May 2016 13:54:27 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GgnkuyPFdMSU; Thu, 26 May 2016 13:54:27 +0200 (CEST)
Received: from eduroam-033039.grenet.fr (eduroam-033039.grenet.fr [130.190.33.39])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 179812055;
	Thu, 26 May 2016 13:54:27 +0200 (CEST)
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <vpqshx5cb51.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295647>

From: Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>

Since `git worktree add` uses `git checkout` when `[<branch>]` is used,
and `git checkout -` is already supported, it makes sense to allow the
same shortcut in `git worktree add`.

Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
---
 Documentation/git-worktree.txt |  3 ++-
 builtin/worktree.c             |  3 +++
 t/t2025-worktree-add.sh        | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index c622345..48e5fdf 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -48,7 +48,8 @@ add <path> [<branch>]::
 
 Create `<path>` and checkout `<branch>` into it. The new working directory
 is linked to the current repository, sharing everything except working
-directory specific files such as HEAD, index, etc.
+directory specific files such as HEAD, index, etc. The last branch you 
+were on can be specify with `-` as `<branch>` which is synonymous with `"@{-1}"`.
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
index 3acb992..b713efb 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -18,6 +18,24 @@ test_expect_success '"add" an existing empty worktree' '
 	git worktree add --detach existing_empty master
 '
 
+test_expect_success '"add" using shorthand - fails when no previous branch' '
+	test_must_fail git worktree add existing -
+'
+
+test_expect_success '"add" using - shorthand' '
+	git checkout -b newbranch &&
+	echo hello >myworld &&
+	git add myworld &&
+	git commit -m myworld &&
+	git checkout master &&
+	git worktree add short-hand - &&
+	cd short-hand &&
+	test $(git rev-parse --symbolic-full-name HEAD) = "refs/heads/newbranch"
+	branch=$(cd short-hand && git rev-parse --symbolic-full-name HEAD) &&
+	test "$branch" = refs/heads/newbranch &&
+	cd ..
+'
+
 test_expect_success '"add" refuses to checkout locked branch' '
 	test_must_fail git worktree add zere master &&
 	! test -d zere &&
-- 
2.7.4 (Apple Git-66)
