Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED59D203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 17:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756623AbdGXRil (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 13:38:41 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:37556 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756456AbdGXRgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 13:36:25 -0400
Received: by mail-pg0-f48.google.com with SMTP id y129so59907344pgy.4
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ABhnrj3qE1ypAEg7M8Syyfq3u3eWm5YfWona8ICrhPQ=;
        b=i4Rq1FaNBzuVtJycfv1oIqYzTT/uolYWUcvVyoqdbt4Rej3pp0RxNuxDEn+5GpQXuu
         Dih92CuHzs37VjB14zj8SEkkNzWoVIZX0vN+GRUN/ekZp64AL4xutu7NWSIZzWd66oup
         IYP9aCvuRJhy3M59ADKtAOziOsFHF5+fziKpeJW2h37gXnp+N5kXLPrLi82GaQbwQFxz
         okwwoIvLF8ddvxd6fiI0xNDP95r+JG3Wsq18qCnxnPOGhfP9ekvQfjMTAP7DSm4KyAaJ
         J50alWzuiys9hSQMunMlOaF+VNwZJUC7+kfqAxrk/nFK7rKqxFGJus4dAEPolwYzw9kd
         VFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ABhnrj3qE1ypAEg7M8Syyfq3u3eWm5YfWona8ICrhPQ=;
        b=mdpI+t79LmsHhsliYACjCzBW5YTl0I8pI1GU6XmXuZhaxPtzKoCh0gOl661PIxRkTF
         O52IlR7WtNwtiu4kz+lxUjSoOKl+XD4gFDe6xG0BvueX9Weajzz9LABNVaw3GieMiZwd
         pKxoFsII/9QiQlBEfOPZXdhahXTZkUcOVD/v5V7wI9zt8BfUGY9FWg7KZVLKEP7atUVg
         BjXWjv3IE4o7nEHh4mvlbUgsWVgOiAyPJkfWH2es2fRxsQP8jaOH+HFcK+aci8oq659k
         RRfq19fv7wSykZXwdYktOPv1l63py8uW1kNNbCgcu3687sB3Cif+hoXzKie1H8YDlLB2
         S4PQ==
X-Gm-Message-State: AIVw110r2oPI9nDw3IXKYqie77n/LdnSfE1rI55jqVLBz9Cml5kXJx2c
        92zRNmCBDHSMFA2WMzIlcA==
X-Received: by 10.98.33.148 with SMTP id o20mr16472481pfj.89.1500917784021;
        Mon, 24 Jul 2017 10:36:24 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:d00e:f9cd:bdce:3a86])
        by smtp.gmail.com with ESMTPSA id r2sm12599392pgs.85.2017.07.24.10.36.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 10:36:23 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] recursive submodules: detach HEAD from new state
Date:   Mon, 24 Jul 2017 10:36:01 -0700
Message-Id: <20170724173601.19921-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule is on a branch and in its superproject you run a
recursive checkout, the branch of the submodule is updated to what the
superproject checks out. This is very unexpected in the current model of
Git as e.g. 'submodule update' always detaches the submodule HEAD.

Despite having plans to have submodule HEADS not detached in the future,
the current behavior is really bad as it doesn't match user expectations
and it is not checking for loss of commits (only to be recovered via the
reflog).

Detach the HEAD unconditionally in the submodule when updating it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This is a resend of [1], which did not receive any attention.
I improved the commit message laying out the current state of affairs,
arguing that any future plan should not weigh in as much as the current
possible data loss.

[1] https://public-inbox.org/git/20170630003851.17288-1-sbeller@google.com/

Thanks,
Stefan

 submodule.c               |  3 ++-
 t/lib-submodule-update.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index ef83c2a9ee..4b7c0a4c82 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1653,7 +1653,8 @@ int submodule_move_head(const char *path,
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
2.14.0.rc0.3.g6c2e499285

