Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2915520953
	for <e@80x24.org>; Thu, 16 Mar 2017 22:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754665AbdCPWik (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:38:40 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36527 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753346AbdCPWii (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:38:38 -0400
Received: by mail-pf0-f173.google.com with SMTP id o126so30697132pfb.3
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 15:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LZVZpX/lITymXbF/KfDcunmFePIqbjHD2hcqVopnP/E=;
        b=bnWh4rAkDpMc9oXbU3UZo1GLl/4Qj0Dl6pX4EONNUEhTVrzgSYCHTMNsED3lvcMN1G
         9D0prmsM8PHTQmN+ODqd3vHoCFpntYWKPD3FhpYavlBB6XMntLDh8xzkGZIqA/jgDVWH
         WyWn62XD8CySECDhe+zZaNfGUfw8VX89hCF4BrIZqayCvrw01nEKcLLlYyz9Tpj8gau/
         0WfC2WQC//lHCdDW3YZ6V6YawxxKaeYfoNWnvWoicAkdW06SCOU9KjD1hv19A4Byfn2p
         DJ6u1TM0S/ab2aRaJao9ATUoGjYA/CA+QuCP4GUrkbcj6RvG0gPpG8fNDM0doUEBvRZw
         9cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LZVZpX/lITymXbF/KfDcunmFePIqbjHD2hcqVopnP/E=;
        b=ZLW9abmN1OhCb8tl6Ce/r5u7vlp+PnwDVz7gTHl92xMAyKxrapVI0ZDmXfBgrtD+bx
         dgpHghPslbtLgxRwGC8Y3X5hKhLIlNp+WXCwF4oXDnrxxxlCl857P9K7MpW3eUSu3dFu
         WvInZMK/Shcq4tsCCnNprjg4rlVT2ZEG8HRKUUHwN4zIb0OiA0MCI8fFJvQHfnDccVH7
         hosYBxiEM2UP40Z8BVdJsjKjA45CaYHXWhnpfH5DLXl5rmzc353Bzc/W+b1eGD8lpGDE
         lbLvRTwcSlMZlD6gmM6eqtWbQpPEh+5D9IBipchbco3XluxZbHRIQi/hWAUMAnXowvdM
         1bwA==
X-Gm-Message-State: AFeK/H0fw7eBLoKq2RDUPnTALUGg0EUWrcL4+FsjQs2sY/Y7m1KsD/yz9+91Airkhpm2U1R/
X-Received: by 10.99.171.75 with SMTP id k11mr12581539pgp.98.1489703400172;
        Thu, 16 Mar 2017 15:30:00 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id t5sm12520946pgb.36.2017.03.16.15.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 15:29:59 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v4 01/10] submodule--helper: add is-active subcommand
Date:   Thu, 16 Mar 2017 15:29:43 -0700
Message-Id: <20170316222952.53801-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170316222952.53801-1-bmwill@google.com>
References: <20170313214341.172676-1-bmwill@google.com>
 <20170316222952.53801-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The definition of which submodules are of interest by the user
is tied to the configuration submodule.<name>.url; when it is
set to a non-empty string, it is of interest.  We'd want to be
able to later change this definition, but there are many places
that explicitly check this condition in the scripted Porcelain.

Introduce the "is-active" subcommand to "submodule--helper", so
that the exact definition of what submodule is of interest can
be centrally defined (and changed in later steps).  In a few
patches that follow, this helper is used to replace the explicit
checks of the configuration variable in scripts.

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
2.12.0.367.g23dc2f6d3c-goog

