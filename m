From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 21/23] worktree: add: make -b/-B default to HEAD when <branch> is omitted
Date: Mon,  6 Jul 2015 13:30:58 -0400
Message-ID: <1436203860-846-22-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:32:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAFN-0007pX-D9
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbbGFRbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:31:55 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34934 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbbGFRbu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:50 -0400
Received: by igcqs7 with SMTP id qs7so15124824igc.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ls/SYPZy+gHdasBXDLWH7ZoQlpkJuNYknuKX4Udz3YA=;
        b=P/HzZUmmgkUZh+gFpct9BxtEsh2GR9WxiRpe8mDRL2C4sRAL6VlmiT1evMWJxxudm/
         lMhUHZOaYd5FxU7WZ0xcWi/NlgrzRnZ90tBt7QYbGIGU1/W825E1efdiQwAphVbgw2xb
         BVxQMdd5lNg0qyl/C8AvMpQR0M3JcFR7/P9rkFEKso6X/vCNS9zDeDltY76FL37vHyiS
         3YglU1qE8bVnMc/+bP3gFrK5jqCaFPZ8sTUo1Wa7wLOSgWfNtzU1vbhONEj+EYOZzD6y
         sHBBdNmHVuPZDOBks3WqEhONbKk8M5JNHfup5FztltiqCMrQz3n1ZI+F3dhcThaCYS7O
         KlpA==
X-Received: by 10.107.170.163 with SMTP id g35mr31009761ioj.79.1436203909769;
        Mon, 06 Jul 2015 10:31:49 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.48
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:49 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273422>

As a convenience, like "git branch" and "git checkout -b", make
"git worktree add -b <newbranch> <path> <branch>" default to HEAD when
<branch> is omitted.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 1 +
 builtin/worktree.c             | 6 ++++--
 t/t2025-worktree-add.sh        | 5 +++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index f44cd78..377ae0f 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -68,6 +68,7 @@ OPTIONS
 -B <new-branch>::
 	With `add`, create a new branch named `<new-branch>` starting at
 	`<branch>`, and check out `<new-branch>` into the new worktree.
+	If `<branch>` is omitted, it defaults to HEAD.
 	By default, `-b` refuses to create a new branch if it already
 	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
 	`<branch>`.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 25fe25b..323d444 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -289,11 +289,13 @@ static int add(int ac, const char **av, const char *prefix)
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (new_branch && new_branch_force)
 		die(_("-b and -B are mutually exclusive"));
-	if (ac != 2)
+	if (ac < 1 || ac > 2)
+		usage_with_options(worktree_usage, options);
+	if (ac < 2 && !new_branch && !new_branch_force)
 		usage_with_options(worktree_usage, options);
 
 	path = prefix ? prefix_filename(prefix, strlen(prefix), av[0]) : av[0];
-	branch = av[1];
+	branch = ac < 2 ? "HEAD" : av[1];
 
 	argv_array_push(&cmd, "checkout");
 	if (force)
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 192c936..8964dec 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -140,4 +140,9 @@ test_expect_success '"add" from relative HEAD' '
 	test_cmp expected actual
 '
 
+test_expect_success '"add -b" with <branch> omitted' '
+	git worktree add -b burble flornk &&
+	test_cmp_rev HEAD burble
+'
+
 test_done
-- 
2.5.0.rc1.197.g417e668
