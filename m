Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F69920373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754037AbdCMVoA (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:44:00 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34063 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753920AbdCMVn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:43:57 -0400
Received: by mail-pg0-f52.google.com with SMTP id 77so70562748pgc.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 14:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E+2etXjI35UGdX2l2zdAwpoa0NqeGAuTa+G75t5yjvY=;
        b=BnGEptcck+GW9Cb68Dy4rx1uSeF8ElZZEQKqTochro00dC/qs3ffdvMH0GTjFDAa84
         QuN9DbKID7n0niMsIvp27ALrpspTx/c4Ph8k25QFa3WGJnJsdBQHWf+c1/Z/QINLWENA
         7WcL5pgq4JqK++8LpdVpNYwXEfuSXCbeW+OOBBmhE202AaKR/KZoKfAp54YFB+ajl892
         RYRC65DSaliGlyyWg5gqg2GO8JLFOzaD0rV5spVsuuiXv9aTDvIX4Ul/aW55fVPTukyr
         8Ya686bfPDPt7MV4W96/BaAxLMvOkxPjqrOaeFZ6gW9D0FpvZM4nPkxvBPfo4a5TmC6V
         vo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E+2etXjI35UGdX2l2zdAwpoa0NqeGAuTa+G75t5yjvY=;
        b=acQQRMp9q3vrdWcZok+hnfbQqE4w9v1KLA1bZcEd62nZHV9tiB2dGPxdKG7ev1m1hw
         qgnPGG0ooxuZJ2p8LYs5j+CXebEZJW0R5O2e3yEIZwe/pxC0G6CEMY6CFCljKibbTmT0
         z7jjkTm+1uVfXyqsB44rArhrcDLjt8LRvmeAJbMn2b0itlyI0xj3dFxX0GySao6Uo6Az
         KjFL+M/tpLUFpglsAaTDQ4UVjJVmn66MbqxE6wFn/5VU7UOxh4LpVTrmXCmtYAN7cxx+
         //tD1iTS69Xo1e80X+oIDZNTL/j3CEKwjG9acOwHfPNQ2Mb/hG2OVZIheMJMWYNqtqkD
         gRnA==
X-Gm-Message-State: AMke39ndvrA8xACxxHIsjezKMXh7rtc8HXTcQcVDF2bOlGPh73IaA2PrNMLkSK42YZ0aNn/a
X-Received: by 10.99.6.76 with SMTP id 73mr39233235pgg.83.1489441436059;
        Mon, 13 Mar 2017 14:43:56 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm34525937pgj.59.2017.03.13.14.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 14:43:55 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v3 07/10] clone: add --submodule-spec=<pathspec> switch
Date:   Mon, 13 Mar 2017 14:43:38 -0700
Message-Id: <20170313214341.172676-8-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170313214341.172676-1-bmwill@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new switch passes the pathspec to `git submodule update
--init-active` which is called after the actual clone is done.

Additionally this configures the submodule.active option to
be the given pathspec, such that any future invocation of
`git submodule update --init-active` will keep up
with the pathspec.

Based on a patch by Stefan Beller <sbeller@google.com>

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-clone.txt | 23 ++++++++++-----
 builtin/clone.c             | 36 +++++++++++++++++++++--
 t/t7400-submodule-basic.sh  | 70 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 35cc34b2f..9692eab30 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -15,7 +15,8 @@ SYNOPSIS
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
 	  [--recursive | --recurse-submodules] [--[no-]shallow-submodules]
-	  [--jobs <n>] [--] <repository> [<directory>]
+	  [--submodule-spec <pathspec>] [--jobs <n>] [--]
+	  <repository> [<directory>]
 
 DESCRIPTION
 -----------
@@ -217,12 +218,20 @@ objects from the source repository into a pack in the cloned repository.
 
 --recursive::
 --recurse-submodules::
-	After the clone is created, initialize all submodules within,
-	using their default settings. This is equivalent to running
-	`git submodule update --init --recursive` immediately after
-	the clone is finished. This option is ignored if the cloned
-	repository does not have a worktree/checkout (i.e. if any of
-	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
+	After the clone is created, initialize and clone all submodules
+	within, using their default settings. This is equivalent to
+	running `git submodule update --recursive --init` immediately
+	after the clone is finished. This option is ignored if the
+	cloned repository does not have a worktree/checkout (i.e.  if
+	any of `--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
+
+--submodule-spec::
+	After the clone is created, initialize and clone specified
+	submodules within, using their default settings. It is possible
+	to give multiple specifications by giving this argument multiple
+	times. This is equivalent to configuring `submodule.active`
+	and then running `git submodule update --init-active`
+	immediately after the clone is finished.
 
 --[no-]shallow-submodules::
 	All submodules which are cloned will be shallow with a depth of 1.
diff --git a/builtin/clone.c b/builtin/clone.c
index 3f63edbbf..c6731379b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -56,6 +56,16 @@ static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
 static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
+static struct string_list submodule_spec;
+
+static int submodule_spec_cb(const struct option *opt, const char *arg, int unset)
+{
+	if (unset)
+		return -1;
+
+	string_list_append((struct string_list *)opt->value, arg);
+	return 0;
+}
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -112,6 +122,9 @@ static struct option builtin_clone_options[] = {
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
+	OPT_CALLBACK(0, "submodule-spec", &submodule_spec, N_("<pathspec>"),
+			N_("clone specific submodules. Pass multiple times for complex pathspecs"),
+			submodule_spec_cb),
 	OPT_END()
 };
 
@@ -733,13 +746,21 @@ static int checkout(int submodule_progress)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive) {
+	if (!err && (option_recursive || submodule_spec.nr > 0)) {
 		struct argv_array args = ARGV_ARRAY_INIT;
-		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+		argv_array_pushl(&args, "submodule", "update", NULL);
+
+		if (submodule_spec.nr > 0)
+			argv_array_pushf(&args, "--init-active");
+		else
+			argv_array_pushf(&args, "--init");
 
 		if (option_shallow_submodules == 1)
 			argv_array_push(&args, "--depth=1");
 
+		if (option_recursive)
+			argv_array_pushf(&args, "--recursive");
+
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
 
@@ -887,6 +908,17 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (submodule_spec.nr > 0) {
+		struct string_list_item *item;
+		struct strbuf sb = STRBUF_INIT;
+		for_each_string_list_item(item, &submodule_spec) {
+			strbuf_addf(&sb, "submodule.active=%s",
+				    item->string);
+			string_list_append(&option_config,
+					   strbuf_detach(&sb, NULL));
+		}
+	}
+
 	if (!option_origin)
 		option_origin = "origin";
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index cc348b807..c2e198a92 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1189,4 +1189,74 @@ test_expect_success 'submodule init --active and update' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clone --submodule-spec works' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	cat >expected <<-\EOF &&
+	 sub0 (test2)
+	-sub1
+	-sub2
+	-sub3
+	EOF
+
+	git clone --recurse-submodules --submodule-spec="sub0" multisuper multisuper_clone &&
+	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
+	test_cmp actual expected
+'
+
+test_expect_success 'clone with multiple --submodule-spec options' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	cat >expect <<-\EOF &&
+	-sub0
+	 sub1 (test2)
+	-sub2
+	 sub3 (test2)
+	EOF
+
+	git clone --recurse-submodules \
+		  --submodule-spec="." \
+		  --submodule-spec ":(exclude)sub0" \
+		  --submodule-spec ":(exclude)sub2" \
+		  multisuper multisuper_clone &&
+	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone and subsequent updates correctly auto-initialize submodules' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	cat <<-\EOF >expect &&
+	-sub0
+	 sub1 (test2)
+	-sub2
+	 sub3 (test2)
+	EOF
+
+	cat <<-\EOF >expect2 &&
+	-sub0
+	 sub1 (test2)
+	-sub2
+	 sub3 (test2)
+	-sub4
+	 sub5 (test2)
+	EOF
+
+	git clone --recurse-submodules \
+		  --submodule-spec="." \
+		  --submodule-spec ":(exclude)sub0" \
+		  --submodule-spec ":(exclude)sub2" \
+		  --submodule-spec ":(exclude)sub4" \
+		  multisuper multisuper_clone &&
+
+	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
+	test_cmp expect actual &&
+
+	git -C multisuper submodule add ../sub1 sub4 &&
+	git -C multisuper submodule add ../sub1 sub5 &&
+	git -C multisuper commit -m "add more submodules" &&
+	# obtain the new superproject
+	git -C multisuper_clone pull &&
+	git -C multisuper_clone submodule update --init-active &&
+	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
+	test_cmp expect2 actual
+'
+
 test_done
-- 
2.12.0.246.ga2ecc84866-goog

