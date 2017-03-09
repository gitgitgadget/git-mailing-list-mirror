Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04C7B20135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754339AbdCIBdq (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:33:46 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35874 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdCIBdp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 20:33:45 -0500
Received: by mail-pf0-f178.google.com with SMTP id o126so21879397pfb.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 17:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7gGeviWinuV+bPkkApOg3DUsL5QZa50BOZd0TGyO3+Y=;
        b=gqKZL5aDkguBlJCLDNXiMctY24a8MqKJddt6ExN36NC4WbM2hsZDLF+7wnMSUNJVVh
         np4ZFkqYoeXnOFjfbZDVEH5idWn/XLCeFtBYtr1Mns5DRrGTJuxGavFtXfhHMl/vYgED
         J/VTtiFoqjD2wKypTj37pGxcarpoYEI3dzDb78sSh0HZ2VG2WWstZechcJ2BGSW7Eabg
         isGl9azeKAMyXkNhGR2mDn5YadrOAsAsDxWYX1M3+MN5Bkgz/zK9deONxysQtW/J0DTv
         2bLsRopQFnDl3JyMCUAuEYKgFJnPrCcJ/PoE6kJarjcKUilcoS5rgyBSqJYXSPORwSXn
         vtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7gGeviWinuV+bPkkApOg3DUsL5QZa50BOZd0TGyO3+Y=;
        b=L/nkcyOvhtxXx2NAbAaN43nwSnm7eCDHLy+++05TOMHlRv/TGAJ29rVKkNZzL8BaEv
         62hbSs1gWaG6bTqRH3Po1D+Iv01B0Fbq8Rur/MwBhpbtxoE4VOMYUlLlAxEPboG+sox0
         hUrb0Mgr3wKwqAoNL0qxNu6Frmol3j5+DARiIHi1nIIsxqACMXYdWoaJgPcvr8rjxFsl
         YnEU8GeQMvBOjHsQVEiHZI7sLGAGRVMXbcgotFOJIgoKoKwhaifWhBAFDH+d/EqsYvRr
         O+tUg2CHflmIO+ptrzzW67/I59Gm47A7jBJlfAqCW9YeqxWUst+VR95374WvSKqd13rC
         mixw==
X-Gm-Message-State: AMke39llznm96btNifCT7dTdCZMLVCqOURolrtj6mGf3XKIF/XHY6duFOkb/m2U6/nVMbS1W
X-Received: by 10.99.127.14 with SMTP id a14mr10723479pgd.64.1489022645955;
        Wed, 08 Mar 2017 17:24:05 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id l71sm8479948pga.7.2017.03.08.17.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 17:24:04 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v2 08/11] clone: add --submodule-spec=<pathspec> switch
Date:   Wed,  8 Mar 2017 17:23:42 -0800
Message-Id: <20170309012345.180702-9-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170309012345.180702-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170309012345.180702-1-bmwill@google.com>
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
index 5ef81927a..15a8d3ef0 100644
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
index f5df0a5b4..39364ef68 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1156,4 +1156,74 @@ test_expect_success 'submodule update --init-active' '
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

