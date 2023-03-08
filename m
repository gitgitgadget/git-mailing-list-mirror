Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1E4C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 10:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCHKEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 05:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjCHKEl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 05:04:41 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC52B85B2D
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 02:04:39 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 183681F47D
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 10:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1678269879;
        bh=5bjJY/INBshH7EHWYvNtGtEbll6M8KnMfCdVLvkbPYw=;
        h=From:To:Subject:Date:From;
        b=dAHprr/SYxSx5Uk7RkhLgku9NnQRpLIUQWvZI93GTGkuQ7mlFTzPdsVHjLIPYg8Eh
         Xz6gNhqBMBRECkICTBB0xbujrqnFlL0QIRr9kHCHJtq+Ghv8CaUuTM4qPpldIFlObT
         jZtZqN/kwXwCWJrVVMw3YBMvyt9z7PU2mn2pxVIc=
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH] fetch: pass --no-write-fetch-head to subprocesses
Date:   Wed,  8 Mar 2023 10:04:38 +0000
Message-Id: <20230308100438.908471-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems a user would expect this option would work regardless
of whether it's fetching from a single remote or many.

Signed-off-by: Eric Wong <e@80x24.org>
---
 I haven't checked if there's other suitable options which could
 go into add_options_to_argv(); hopefully someone else can check :>

 builtin/fetch.c           | 2 ++
 t/t5514-fetch-multiple.sh | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a09606b472..78513f1708 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1880,6 +1880,8 @@ static void add_options_to_argv(struct strvec *argv)
 		strvec_push(argv, "--ipv4");
 	else if (family == TRANSPORT_FAMILY_IPV6)
 		strvec_push(argv, "--ipv6");
+	if (!write_fetch_head)
+		strvec_push(argv, "--no-write-fetch-head");
 }
 
 /* Fetch multiple remotes in parallel */
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 54f422ced3..98f034aa77 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -58,6 +58,13 @@ test_expect_success 'git fetch --all' '
 	 test_cmp expect output)
 '
 
+test_expect_success 'git fetch --all --no-write-fetch-head' '
+	(cd test &&
+	rm -f .git/FETCH_HEAD &&
+	git fetch --all --no-write-fetch-head &&
+	test_path_is_missing .git/FETCH_HEAD)
+'
+
 test_expect_success 'git fetch --all should continue if a remote has errors' '
 	(git clone one test2 &&
 	 cd test2 &&
