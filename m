From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 21/23] worktree: add: make -b/-B default to HEAD when <branch> is omitted
Date: Fri,  3 Jul 2015 20:17:30 -0400
Message-ID: <1435969052-540-22-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:19:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBBB-0000X2-92
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087AbbGDAT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:19:28 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34347 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829AbbGDASp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:45 -0400
Received: by igcsj18 with SMTP id sj18so196950831igc.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6aRrjmYnOCsnpNilTaObbiiGAid3Zary1Fw/T+ehEFU=;
        b=EwAdiaBpxd3VnEW6QzBnvG4wBB0qdW2lkxypjPhRHzas+0+X12lNs69xY8D4THQxyL
         6s8YTmfhj3DmQL+EtykXyv+RKCh9s6sI3Ew6O3jgSTujrBA2N38BhCzMDOjSy2GD+dHD
         Wgatj9ZdnLoFn9GlqJXkWaYFSXoGgnZBrPHYbXqbqQOy9fk9xRYHgY/HJ/zqzs08FRPL
         3qMRFS44FAZJGZ13Y/SlsT/xdjsaFUed3SQ4x0Qc8SnewnkodiEONDlMsJozFVvOV1JG
         DaN0Y2hmxMn7qYtKVtMAkTlydd9lH2LsuT79vJqC/bSdsfFS4lZzfVIMur/WMPDk4M3f
         Kn3Q==
X-Received: by 10.43.54.20 with SMTP id vs20mr20899441icb.96.1435969124978;
        Fri, 03 Jul 2015 17:18:44 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.44
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:44 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273332>

As a convenience, like "git branch" and "git checkout -b", make
"git worktree add -b <newbranch> <path> <branch>" default to HEAD when
<branch> is omitted.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 1 +
 builtin/worktree.c             | 6 ++++--
 t/t2025-worktree-add.sh        | 7 +++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index f6c3747..5ca11f6 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -69,6 +69,7 @@ OPTIONS
 -B <new-branch>::
 	With `add`, create a new branch named `<new-branch>` starting at
 	`<branch>`, and check out `<new-branch>` into the new worktree.
+	If `<branch>` is omitted, it defaults to HEAD.
 	By default, `-b` refuses to create a new branch if it already
 	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
 	`<branch>`.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index a1d863d..bf634a6 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -284,11 +284,13 @@ static int add(int ac, const char **av, const char *prefix)
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
index 192c936..95a1141 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -140,4 +140,11 @@ test_expect_success '"add" from relative HEAD' '
 	test_cmp expected actual
 '
 
+test_expect_success '"add -b" with <branch> omitted' '
+	git rev-parse HEAD >expected &&
+	git worktree add -b burble flornk &&
+	git rev-parse burble >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.5.0.rc1.197.g417e668
