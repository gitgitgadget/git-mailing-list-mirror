Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C045220373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbdCMVnv (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:43:51 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35606 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdCMVns (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:43:48 -0400
Received: by mail-pg0-f46.google.com with SMTP id b129so70794278pgc.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 14:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/v5udQl2MsEad3eYWYK+F+eZcB60jG16X+FDstobBH0=;
        b=jvXRN21/8sVs0Y5fOV4roqIWwjjOQFm+O7bZPoEtoAgeJXcjP6A6cXr+Y8K0WsbiAB
         L/fYqDA9HExKbAK9anvjSkq4fdJp+G4aWm/zV/HdRSacGGqQ4PJi0KbzBdMJ0bDfRYFq
         3Yc7xZwqj8JBX2K62iRLk8LJDOsx0UsaTmHaKY+MN+eqXs6c2Oxpn40dbn3MrJQinqQ7
         eBlF42JmgNJ05N7cVwvnmMWa5C8mpp4lptDvR+spVqkq0IdP4/4xVDRObj6fv7fRl1M5
         t1R0RjNlSH/vagtoe/8F9nuonY379UQUM9O+Q055UPRGg6IdnRzUtUhRVmRwIj5nlQmN
         O2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/v5udQl2MsEad3eYWYK+F+eZcB60jG16X+FDstobBH0=;
        b=Amw257tBM7ZWj0aEAiAViGlpVwT82/y8Esa5wsurPp7AgnuHZ7Vti5kXoYa4KWlxrr
         4tGs5DmPGBzm6KmihJ4pnqCnZPOtFOqHomLPKcgUpoCe7r9rPBDurGJrIgQqtjTMvjBu
         9Lk4PEulIuDgckkdkVbkvMp8LPgKEStgwyOjPwe0Omyc3ut9bvWMbzJz5nxm1cK6HINk
         yiIys4jI+Oosszo3M59fU8yIF5H/g3WqfTBcLRUveiZ5AnxBL3YN/k5qGkWkAxKtLUVF
         l4zDbI8hQckwzr7YWj0sSzX+hhXldGx349aPv5C/JAYcsC0VqOoTaV6fTprKcTI8OxrO
         dNlg==
X-Gm-Message-State: AMke39nkShWe6cQlfan0rYyCCF9T451+Wzu1BS6AEHkuJ/HfXajJ0sD7amg2JlSwYuT9fL5A
X-Received: by 10.99.199.69 with SMTP id v5mr39225114pgg.90.1489441426975;
        Mon, 13 Mar 2017 14:43:46 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm34525937pgj.59.2017.03.13.14.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 14:43:45 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v3 01/10] submodule--helper: add is_active command
Date:   Mon, 13 Mar 2017 14:43:32 -0700
Message-Id: <20170313214341.172676-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170313214341.172676-1-bmwill@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a lot of places where an explicit check for
submodule."<name>".url is done to see if a submodule exists.  In order
to centralize this check introduce a helper which can be used to query
if a submodule is active or not.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/submodule--helper.c    | 11 +++++++++++
 t/t7413-submodule-is-active.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100755 t/t7413-submodule-is-active.sh

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 15a5430c0..5fe7e23b1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1127,6 +1127,16 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int is_active(int argc, const char **argv, const char *prefix)
+{
+	if (argc != 2)
+		die("submodule--helper is-active takes exactly 1 arguments");
+
+	gitmodules_config();
+
+	return !is_submodule_initialized(argv[1]);
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -1146,6 +1156,7 @@ static struct cmd_struct commands[] = {
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
+	{"is-active", is_active, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
new file mode 100755
index 000000000..f18e0c925
--- /dev/null
+++ b/t/t7413-submodule-is-active.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description='Test submodule--helper is-active
+
+This test verifies that `git submodue--helper is-active` correclty identifies
+submodules which are "active" and interesting to the user.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git init sub &&
+	test_commit -C sub initial &&
+	git init super &&
+	test_commit -C super initial &&
+	git -C super submodule add ../sub sub1 &&
+	git -C super submodule add ../sub sub2 &&
+	git -C super commit -a -m "add 2 submodules at sub{1,2}"
+'
+
+test_expect_success 'is-active works with urls' '
+	git -C super submodule--helper is-active sub1 &&
+	git -C super submodule--helper is-active sub2 &&
+
+	git -C super config --unset submodule.sub1.URL &&
+	test_must_fail git -C super submodule--helper is-active sub1 &&
+	git -C super config submodule.sub1.URL ../sub &&
+	git -C super submodule--helper is-active sub1
+'
+
+test_done
-- 
2.12.0.246.ga2ecc84866-goog

