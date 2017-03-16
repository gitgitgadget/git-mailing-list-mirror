Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 385B020953
	for <e@80x24.org>; Thu, 16 Mar 2017 22:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754643AbdCPWi0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:38:26 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34461 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754297AbdCPWiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:38:25 -0400
Received: by mail-pg0-f50.google.com with SMTP id 141so31656035pgd.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 15:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x7a7bd6JO0Dt34cNcq7FW8vB3jn4yn6QELMEmQuB064=;
        b=n17Y4TfuNfcIV74l2Nykg/gMbhlAaBSLWZtzUItYlKNnq32vzZEVmC5nF2sw3jiuIJ
         9jdMnG+CVfKlv8hN4WLxupWTJj3ygPNYUkKWyhRbfW8THbFJhvB0CtMGW8OSzKl3vqDu
         b+8+yaLxsTMPFdV+hXSSUT2RLnMwnjeDtZ9U5G8XMaHiFvSJpRTsjg1QPH8pwQWfiAml
         L5EaqTnx1g5kGviXSlIfnn1oZxWM5sIyUKN+4p/UHEXMvyMQz391nCcFMyLIWe/lxkF5
         jdotq7fNv93TAg+Kst3R3QENBEevu2/DjiIFkst8nJgQuY6eiAfuF70O/xty778ijDqd
         VJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x7a7bd6JO0Dt34cNcq7FW8vB3jn4yn6QELMEmQuB064=;
        b=S8afcAArdTuHMMq0RI50j8tF6qOx1i9tjfgn8wz83dysTizCmy/fr2Dmc8cJ4yssbt
         5qFHCkUjb5bT29kTRgBLU37lBFRPYhWDGRWeQqG0i/Gr1FWbZ8b0FM6TjUdTz6PxUs0n
         Qdi/kBtcAHmnG+F6nC4PZ+QhdvKiXtH4KFB1d3d72ujcVAWqrLuvB8mG7AHxqmh9VZYI
         nkjo1EnL1wgUq+GPgyjCWa8edO+ES0PU5ylufSW0cOs7mzTii9zl+gtlmjwkezS7Zr2G
         mBKM4Qe2LeI4FUf7wETSq/H42uo93pTaKyr9/M7QocPb5/TFswfletouciKPBSO7qMVo
         T7cQ==
X-Gm-Message-State: AFeK/H3974mRYFCKRPs2RnMOn5X2+iES1i5o1Ndpj28Mj/ZKv/PDruDk19++gf8sGxvQha1n
X-Received: by 10.99.229.5 with SMTP id r5mr12641951pgh.206.1489703409338;
        Thu, 16 Mar 2017 15:30:09 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id t5sm12520946pgb.36.2017.03.16.15.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 15:30:08 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v4 07/10] submodule init: initialize active submodules
Date:   Thu, 16 Mar 2017 15:29:49 -0700
Message-Id: <20170316222952.53801-8-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170316222952.53801-1-bmwill@google.com>
References: <20170313214341.172676-1-bmwill@google.com>
 <20170316222952.53801-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach `submodule init` to initialize submodules which have been
configured to be active by setting 'submodule.active' with a pathspec.

Now if no path arguments are given and 'submodule.active' is configured,
`init` will initialize all submodules which have been configured to be
active.  If no path arguments are given and 'submodule.active' is not
configured, then `init` will retain the old behavior of initializing all
submodules.

This allows users to record more complex patterns as it saves retyping
them whenever you invoke update.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-submodule.txt |  4 ++-
 builtin/submodule--helper.c     | 36 +++++++++++++++++++++++++-
 t/t7400-submodule-basic.sh      | 57 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e05d0cdde..74bc6200d 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -129,7 +129,9 @@ init [--] [<path>...]::
 	repository will be assumed to be upstream.
 +
 Optional <path> arguments limit which submodules will be initialized.
-If no path is specified, all submodules are initialized.
+If no path is specified and submodule.active has been configured, submodules
+configured to be active will be initialized, otherwise all submodules are
+initialized.
 +
 When present, it will also copy the value of `submodule.$name.update`.
 This command does not alter existing information in .git/config.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f38e332c5..e95738b42 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -270,6 +270,34 @@ static int module_list_compute(int argc, const char **argv,
 	return result;
 }
 
+static void module_list_active(struct module_list *list)
+{
+	int i;
+
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
+	gitmodules_config();
+
+	for (i = 0; i < active_nr; i++) {
+		const struct cache_entry *ce = active_cache[i];
+
+		if (!S_ISGITLINK(ce->ce_mode) ||
+		    !is_submodule_initialized(ce->name))
+			continue;
+
+		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
+		list->entries[list->nr++] = ce;
+		while (i + 1 < active_nr &&
+		       !strcmp(ce->name, active_cache[i + 1]->name))
+			/*
+			 * Skip entries with the same name in different stages
+			 * to make sure an entry is returned only once.
+			 */
+			i++;
+	}
+}
+
 static int module_list(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -417,7 +445,13 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_init_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+	/*
+	 * If there are no path args and submodule.active is set then,
+	 * by default, only initialize 'active' modules.
+	 */
+	if (!argc && git_config_get_value_multi("submodule.active"))
+		module_list_active(&list);
+	else if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
 		return 1;
 
 	for (i = 0; i < list.nr; i++)
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index c09ce0d4c..fbbe932d1 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1130,5 +1130,62 @@ test_expect_success 'submodule helper list is not confused by common prefixes' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup superproject with submodules' '
+	git init sub1 &&
+	test_commit -C sub1 test &&
+	test_commit -C sub1 test2 &&
+	git init multisuper &&
+	git -C multisuper submodule add ../sub1 sub0 &&
+	git -C multisuper submodule add ../sub1 sub1 &&
+	git -C multisuper submodule add ../sub1 sub2 &&
+	git -C multisuper submodule add ../sub1 sub3 &&
+	git -C multisuper commit -m "add some submodules"
+'
+
+cat >expect <<-EOF
+-sub0
+ sub1 (test2)
+ sub2 (test2)
+ sub3 (test2)
+EOF
+
+test_expect_success 'submodule update --init with a specification' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	git -C multisuper_clone submodule update --init . ":(exclude)sub0" &&
+	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'submodule update --init with submodule.active set' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	git -C multisuper_clone config submodule.active "." &&
+	git -C multisuper_clone config --add submodule.active ":(exclude)sub0" &&
+	git -C multisuper_clone submodule update --init &&
+	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'submodule update and setting submodule.<name>.active' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	git -C multisuper_clone config --bool submodule.sub0.active "true" &&
+	git -C multisuper_clone config --bool submodule.sub1.active "false" &&
+	git -C multisuper_clone config --bool submodule.sub2.active "true" &&
+
+	cat >expect <<-\EOF &&
+	 sub0 (test2)
+	-sub1
+	 sub2 (test2)
+	-sub3
+	EOF
+	git -C multisuper_clone submodule update &&
+	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
+	test_cmp expect actual
+'
 
 test_done
-- 
2.12.0.367.g23dc2f6d3c-goog

