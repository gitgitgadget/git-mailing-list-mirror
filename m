Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DBBC433E0
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 07:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E2720739
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 07:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFMHeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 03:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgFMHeL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 03:34:11 -0400
X-Greylist: delayed 235 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 13 Jun 2020 00:34:10 PDT
Received: from dandelion.mymedia.su (unknown [IPv6:2604:180:2:1574::c9e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC4BC03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 00:34:10 -0700 (PDT)
Received: from dandelion.mymedia.su (localhost.localdomain [127.0.0.1])
        by dandelion.mymedia.su (8.15.2/8.15.2/Debian-3) with ESMTP id 05D7UBwQ010560
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 10:30:11 +0300
Received: (from mymedia@localhost)
        by dandelion.mymedia.su (8.15.2/8.15.2/Submit) id 05D7UB99010559
        for git@vger.kernel.org; Sat, 13 Jun 2020 10:30:11 +0300
Message-Id: <202006130730.05D7UB99010559@dandelion.mymedia.su>
From:   Nicholas Guriev <guriev-ns@ya.ru>
Date:   Sat, 13 Jun 2020 10:14:21 +0300
Subject: [PATCH] worktree: treat "list" as default command
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perceive simple "git worktree" without a subcommand as "git worktree list"
for consistency with "git submodule" that already can work in such a way.

Signed-off-by: Nicholas Guriev <guriev-ns@ya.ru>
---
 builtin/worktree.c       |  4 ++--
 t/t2402-worktree-list.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d99db356..ad949eb5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -960,10 +960,10 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 
 	git_config(git_worktree_config, NULL);
 
-	if (ac < 2)
-		usage_with_options(worktree_usage, options);
 	if (!prefix)
 		prefix = "";
+	if (ac < 2 || av[1][0] == '-')
+		return list(ac, av, prefix);
 	if (!strcmp(av[1], "add"))
 		return add(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "prune"))
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 52585ec2..e53bafa3 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -157,4 +157,16 @@ test_expect_success 'worktree path when called in .git directory' '
 	test_cmp list1 list2
 '
 
+test_expect_success '"list" is the default command' '
+	git worktree >out1 &&
+	git worktree list >out2 &&
+	test_cmp out1 out2
+'
+
+test_expect_success 'options are passed to default command' '
+	git worktree --porcelain >out1 &&
+	git worktree list --porcelain >out2 &&
+	test_cmp out1 out2
+'
+
 test_done
-- 
2.25.1

