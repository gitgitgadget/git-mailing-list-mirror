Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF85B20135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932113AbdCIBdJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:33:09 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33575 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932081AbdCIBdI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 20:33:08 -0500
Received: by mail-pg0-f53.google.com with SMTP id 25so19822441pgy.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 17:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A2vzXom5wkEUPWbTQPZwLcYxHELtlOq8jIrXA+iwOjA=;
        b=Hohz+IWETF75VTUsK6xcjroxpSriBBuhDMfEqxF31A3XwAQ1Uq6/fNCNgFk6RV95iz
         1B4Tp0/pmd8w8Rg+WeKjKdFrioUw8tX3LeQ1eRifdM3XaM4wyrc/N+taCY8Br4ZmLIeK
         k/f4MU8a5PK7tgMKSAqCTSXL01nbM2X8UWQ4EIDqwfkQXTt0IVxGeE+J5cCK248aajUI
         AcNHflA8cW3IcA84kDVYwW0TBPMPpGAYEZvHYTaoX3psl/xxFggn9zVWpf6k7ustm8c6
         +xApwgfe6GHLia0+IsZgaV0RtvQkuLICpqz0nx3kxp4ClC/9jAji4AlQJnLVsX3uPizT
         AFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A2vzXom5wkEUPWbTQPZwLcYxHELtlOq8jIrXA+iwOjA=;
        b=GRbwrtaL5W0hiGala9tq8U6vLCjGEGfzF4UHz9wUwqRhY6l+kugiKlQ6GIZI8sQfkN
         sVelkS+4xhxgkHwWeBcYDXTFWi8wDD3Wn7gLGv7QHKp2xezpu6yD/33Jgp1WSCvcTWDz
         qCtD8fecUGiRUUrfVuqYqqnra03E94+FZSHFloY/t9lYgu98cMnYO1vxMInzyNFHbl7d
         bN/TR3Mqc4kv8vHR4IwPjpcjhYAUbVHih4VFs9dXcCqkozGJZ5hhoX1fn58sMz1jj3EY
         u5DILFVGCgw8Bl3kgiV6z0afmEuYL2HLUisrv3x2euJwyWBvgJ0VIa8N9U6EjA8sjl8a
         0gNw==
X-Gm-Message-State: AMke39kWs0bSBOsSR1Cd/vGSPl8Y91B7k4z/7u2JiT+ECZkZz8/oy+KOvQKFACsEs/PtP+Xn
X-Received: by 10.98.131.75 with SMTP id h72mr11062015pfe.4.1489022635036;
        Wed, 08 Mar 2017 17:23:55 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id l71sm8479948pga.7.2017.03.08.17.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 17:23:54 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v2 01/11] submodule--helper: add is_active command
Date:   Wed,  8 Mar 2017 17:23:35 -0800
Message-Id: <20170309012345.180702-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170309012345.180702-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170309012345.180702-1-bmwill@google.com>
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
index df0d9c166..dac02604d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1128,6 +1128,16 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
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
@@ -1147,6 +1157,7 @@ static struct cmd_struct commands[] = {
 	{"init", module_init, 0},
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

