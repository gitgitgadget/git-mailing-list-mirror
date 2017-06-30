Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C18F202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751601AbdF3Aiz (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:38:55 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34822 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbdF3Aiy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:38:54 -0400
Received: by mail-pf0-f172.google.com with SMTP id c73so58396963pfk.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wNZCKlXZ1PiU6f5N2sTs43my6zQxUMTWlel67xckVlU=;
        b=TI7SaCQRfFn/OalZrIrC1sGprCDumkW2SAzhanZDOd7CkD8I2+LJKzSYWRg232Eig5
         HFBzieZfd9p8iousYiVLfdY5uMGYgGbwwJ5PfCaU6YfgBxBVaraFU7E8wfDa7NYO0Vh1
         s4I6hymqfViW2M0ssjulSMXgcYOT/47MYO4D/ZUZhpQrtnZNmYCzaLONPaj1Rk/S9uvT
         W/Qpeq1pKb3hnjD4eZk4Hg56sKQZOIu0HptDgGg9FuvEYiixqgrJ7a6Mm2p38XBg0BOW
         +gBU7bDAZRItZ9J2i5LQd78jARfeuEzAYNrDi9ayCkzZ11RVJt5cpbTSEUwixOqGaWVg
         TGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wNZCKlXZ1PiU6f5N2sTs43my6zQxUMTWlel67xckVlU=;
        b=JlFnkM9TXkCg2K80QJA4Ipfy02CIOU7D+dL8MMrdnr/WiFP7kgQKCW/2b4RMSwjyIy
         bhc2t8Dqj2FRGIZHM3gNqGMHWcZc02zf/YmDqq6nJF0j5oJUqyzr/7khQ8x0MqrFMcOi
         CciPshxGFvMYv3lS8bzrYzQNE9DtGwIXPM+T21cL5urg7B00tPPVEeal7QWMK1ujxA9o
         c20u3UyCyMfwsJG9rdteGrH+l8EYE1IysdocJxP5Aea10WHEGR7orVTHZUJa4xeA7MCy
         0/qGJwQPoVKqkrzhpJSDcuZ7JjULMbv5DI4u+RnCvJOhBVpyvUJnUPUzarzhL7TIABv3
         L6eQ==
X-Gm-Message-State: AKS2vOxKwW0wqy3wkBcGznJlqBUgkLv7X0Bm5fFyHUaJVnx40reX9qtn
        6ptw5gpzpulv4XHhR2eNPA==
X-Received: by 10.84.193.36 with SMTP id e33mr21149066pld.122.1498783133952;
        Thu, 29 Jun 2017 17:38:53 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id t189sm12782797pfb.13.2017.06.29.17.38.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:38:53 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH] recursive submodules: detach HEAD from new state, keeping branches sane
Date:   Thu, 29 Jun 2017 17:38:51 -0700
Message-Id: <20170630003851.17288-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule is on a branch and in its superproject you run a recursive
checkout, the branch of the submodule is updated to what the superproject
checks out. This is very unexpected. Instead detach the HEAD when updating
it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c               |  3 ++-
 t/lib-submodule-update.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index da0b805493..719e8bd7a2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1604,7 +1604,8 @@ int submodule_move_head(const char *path,
 			cp.dir = path;
 
 			prepare_submodule_repo_env(&cp.env_array);
-			argv_array_pushl(&cp.args, "update-ref", "HEAD", new, NULL);
+			argv_array_pushl(&cp.args, "update-ref", "HEAD",
+					 "--no-deref", new, NULL);
 
 			if (run_command(&cp)) {
 				ret = -1;
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 2d26f86800..fc406b95d7 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -848,6 +848,23 @@ test_submodule_switch_recursing_with_args () {
 			test_submodule_content sub1 origin/add_sub1
 		)
 	'
+	test_expect_success "$command: submodule branch is not changed, detach HEAD instead" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git -C sub1 checkout -b keep_branch &&
+			git -C sub1 rev-parse HEAD >expect &&
+			git branch -t check-keep origin/modify_sub1 &&
+			$command check-keep &&
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1 &&
+			git -C sub1 rev-parse keep_branch >actual &&
+			test_cmp expect actual &&
+			test_must_fail git -C sub1 symbolic-ref HEAD
+		)
+	'
+
 	# Replacing a tracked file with a submodule produces a checked out submodule
 	test_expect_success "$command: replace tracked file with submodule checks out submodule" '
 		prolog &&
-- 
2.13.0.31.g9b732c453e

