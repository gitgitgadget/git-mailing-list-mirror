Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04D820951
	for <e@80x24.org>; Sat, 18 Mar 2017 00:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbdCRAYQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 20:24:16 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35665 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbdCRAYP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 20:24:15 -0400
Received: by mail-pg0-f41.google.com with SMTP id b129so50379419pgc.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 17:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LZVZpX/lITymXbF/KfDcunmFePIqbjHD2hcqVopnP/E=;
        b=U6mvMchaZELNP6urETDCSzxd6/Moiv8MFSzPhwFKuz83HXgCbmQu0VPY32XUdEkgF3
         aKVv2ui3lbcnF/tdzPdhsP/4wVLCmoJinYsPvn6MO6JCeTie7R2a22ERabCsDHUZhrcF
         MFR9Twlw4Ng6EQMfprm+DxD4YZOiiOatMv9yAc0fOOao1xd2sxQuw39c9OzFAIlEt6DQ
         eZftn04563C01b7tO4j2/JhL0W9HitZRpHQ4qhoC4w9PRPJFiPXbSC17dzLrFDyJu5ld
         ixVHtNc5YiF9SjOchmdvwh9oPZOrX6HpwTlOt0ryULjB1NzJbAP/huaFIs3eP7/h3JmL
         /I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LZVZpX/lITymXbF/KfDcunmFePIqbjHD2hcqVopnP/E=;
        b=qxyE8wDey4gs6wEgN3dKG+GoHvheTXN4lmMXkDlu9Ct6x1F8+qF6rrmxgNFUFSGaaR
         nFdqD5+F3HQKoftryEU1vGFn9ctvP83YlOSgvokTRB/u3XPtveyBw06p+R5icvVAegQJ
         2N7AbQjlcbjNU7wlSLkZ/kSNrYq4rp8CuSvmSGy3jXBTdpLZpeqxWv4y6v/tWnVfqa5B
         nHbWn6btZBkkOfab5WxU7bkLz5ZANL3nDA6xBKXRvCvNYZaT2nlKQ4EqWVOmRmZP+gqT
         YGl9YuaG5WkanKcSYjBEJOcjBWmBI9uhxZa8S3DKiBjJlU8pa+JyK7MaT3Afpab55Y/u
         V9ag==
X-Gm-Message-State: AFeK/H1GR3CTBfsS9SdGPIv5UGOO2F5Elk5kpo9nrlM7mZ0uMEVEUQxXHofThe4ANdts9H+K
X-Received: by 10.99.119.65 with SMTP id s62mr3457535pgc.64.1489790296376;
        Fri, 17 Mar 2017 15:38:16 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id d3sm18699763pfc.51.2017.03.17.15.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 15:38:15 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v5 01/10] submodule--helper: add is-active subcommand
Date:   Fri, 17 Mar 2017 15:37:56 -0700
Message-Id: <20170317223805.95271-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170317223805.95271-1-bmwill@google.com>
References: <20170316222952.53801-1-bmwill@google.com>
 <20170317223805.95271-1-bmwill@google.com>
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

