Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C361C203E2
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965835AbcKJUfW (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:22 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35921 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965794AbcKJUfV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:21 -0500
Received: by mail-pf0-f172.google.com with SMTP id 189so152175708pfz.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=54fLUbw5nW4Dgrs4AX/FHUGvWwZB83JUbVZVj+eXM/8=;
        b=XvTNa/8dL/iQ4hW/N+BdcoCr1j4CmifKgeqKGoDkO+9+PfDSB8QdS3pUTo8B1q8P5T
         tv4gNUqUFd5iz9H6vpAf0fge9n+D9niCVa+8eG+jMm0oAxdA8D9ZQtHjlSJx38qIy9js
         OPd7woSDDfdeV9H/GGjNgNEGVHDAo9gj2lVNWSJY50zpU6dqeLlIiMIjQ44G9JZ2O/iX
         vo9g95RN23yjOeVlbdeGHSobfqn0Xd3t/8cStLfd8k9NfNC13odYxqodFKizTkC0+GHR
         E3zeaInyZcnBh2D4BbTqarCxL5Dw6/LpYdNIO9KN5bgF9QCqQMMV3uyHbuyqolGFljE3
         at+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=54fLUbw5nW4Dgrs4AX/FHUGvWwZB83JUbVZVj+eXM/8=;
        b=kH+YneBVlwTSDqNFPItR92Ps7mG6ZZdxeYQ0LaNylPBRl30X4hktLmDjCBPQi71jZF
         65ExgDTYoF9p0VLAujdSWrh1BxXeQ2gRDTp75yNGvewS7Pl+QvsqMg45wbW1ltIBVVQg
         1ouHlsZtB6zrm64uaYpyN34HV/oI6kRzNuGoepk6DmSnaf5hOxxKShw9wOo+DMjiQZ55
         afKvUsEmeMqT86Ano298v3HDkLskm+/UiK9JYswFFs2fBWJrYFy3NRSW0ra6WYSbo5wt
         rDmAUyaIdZv3z+xTMTG22OKbxHE6120QJ+3aNGuDgPS66dlrEa8jGWhDohJYajPHPToI
         a9fw==
X-Gm-Message-State: ABUngvfjhGDBaGbcdw18Atj+vhQEnBRib73bAn0Blys/XxmCdMf/9HlAhgdct8VZ8v95hFGS
X-Received: by 10.99.1.132 with SMTP id 126mr37946363pgb.129.1478810120275;
        Thu, 10 Nov 2016 12:35:20 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id u23sm9258153pfg.86.2016.11.10.12.35.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:35:19 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 34/35] clone: add --init-submodule=<pathspec> switch
Date:   Thu, 10 Nov 2016 12:34:27 -0800
Message-Id: <20161110203428.30512-35-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new switch passes the pathspec to `git submodule update --init`
which is called after the actual clone is done.

Additionally this configures the submodule.defaultUpdatePath to
be the given pathspec, such that any future invocation of
`git submodule update --init-default-paths` will keep up
with the pathspec.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt    |  2 +-
 Documentation/git-clone.txt | 23 +++++++++----
 builtin/clone.c             | 36 ++++++++++++++++++--
 t/t7400-submodule-basic.sh  | 81 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 290de3b..917904e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2887,7 +2887,7 @@ submodule.alternateErrorStrategy
 
 submodule.defaultUpdatePath::
 	Specifies a set of submodules to initialize when calling
-	`git submodule --init-default-group` by using the pathspec
+	`git submodule --init-default-path` by using the pathspec
 	syntax.
 
 tag.forceSignAnnotated::
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 35cc34b..1089f38 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -15,7 +15,8 @@ SYNOPSIS
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
 	  [--recursive | --recurse-submodules] [--[no-]shallow-submodules]
-	  [--jobs <n>] [--] <repository> [<directory>]
+	  [--init-submodule <pathspec>] [--jobs <n>] [--]
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
+	running `git submodule update --recursive --init `
+	immediately after the clone is finished. This option is ignored
+	if the cloned repository does not have a worktree/checkout (i.e.
+	if any of `--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
+
+--init-submodule::
+	After the clone is created, initialize and clone specified
+	submodules within, using their default settings. It is possible
+	to give multiple specifications by giving this argument multiple
+	times. This is equivalent to configure `submodule.defaultUpdateGroup`
+	and then running `git submodule update --init-default-path`
+	immediately after the clone is finished.
 
 --[no-]shallow-submodules::
 	All submodules which are cloned will be shallow with a depth of 1.
diff --git a/builtin/clone.c b/builtin/clone.c
index 6c80690..ef924c6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -56,6 +56,16 @@ static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
 static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
+static struct string_list init_submodules;
+
+static int init_submodules_cb(const struct option *opt, const char *arg, int unset)
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
+	OPT_CALLBACK(0, "init-submodule", &init_submodules, N_("<pathspec>"),
+			N_("clone specific submodules. Pass multiple times for complex pathspecs"),
+			init_submodules_cb),
 	OPT_END()
 };
 
@@ -730,13 +743,21 @@ static int checkout(int submodule_progress)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive) {
+	if (!err && (option_recursive || init_submodules.nr > 0)) {
 		struct argv_array args = ARGV_ARRAY_INIT;
-		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+		argv_array_pushl(&args, "submodule", "update", NULL);
+
+		if (init_submodules.nr > 0)
+			argv_array_pushf(&args, "--init-default-path");
+		else
+			argv_array_pushf(&args, "--init");
 
 		if (option_shallow_submodules == 1)
 			argv_array_push(&args, "--depth=1");
 
+		if (option_recursive)
+			argv_array_pushf(&args, "--recursive");
+
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
 
@@ -884,6 +905,17 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (init_submodules.nr > 0) {
+		struct string_list_item *item;
+		struct strbuf sb = STRBUF_INIT;
+		for_each_string_list_item(item, &init_submodules) {
+			strbuf_addf(&sb, "submodule.defaultUpdatePath=%s",
+				    item->string);
+			string_list_append(&option_config,
+					   strbuf_detach(&sb, NULL));
+		}
+	}
+
 	if (!option_origin)
 		option_origin = "origin";
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 4699b1c..90f9030 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1170,4 +1170,85 @@ test_expect_success 'submodule update --init-default-path' '
 	test_cmp expect actual
 '
 
+cat <<EOF > expected
+ sub0 (test2)
+-sub1
+-sub2
+-sub3
+EOF
+
+test_expect_success 'clone --init-submodule works' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	git clone --recurse-submodules --init-submodule="sub0" multisuper multisuper_clone &&
+	(
+		cd multisuper_clone &&
+		git submodule status |cut -c 1,43- >../actual
+	) &&
+	test_cmp actual expected
+'
+
+cat <<EOF > expect
+-sub0
+ sub1 (test2)
+-sub2
+ sub3 (test2)
+EOF
+test_expect_success 'clone with multiple --init-submodule options' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	git clone --recurse-submodules \
+		  --init-submodule="." \
+		  --init-submodule ":(exclude)sub0" \
+		  --init-submodule ":(exclude)sub2" \
+			multisuper multisuper_clone &&
+	(
+		cd multisuper_clone &&
+		git submodule status |cut -c1,43- >../actual
+	) &&
+	test_cmp expect actual
+'
+
+cat <<EOF > expect
+-sub0
+ sub1 (test2)
+-sub2
+ sub3 (test2)
+EOF
+
+cat <<EOF > expect2
+-sub0
+ sub1 (test2)
+-sub2
+ sub3 (test2)
+-sub4
+ sub5 (test2)
+EOF
+
+test_expect_success 'clone and subsequent updates correctly auto-initialize submodules' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	git clone --recurse-submodules --init-submodule="." \
+				       --init-submodule ":(exclude)sub0" \
+				       --init-submodule ":(exclude)sub2" \
+				       --init-submodule ":(exclude)sub4" \
+				       multisuper multisuper_clone &&
+	(
+		cd multisuper_clone &&
+		git submodule status |cut -c1,43- >../actual
+	) &&
+	test_cmp expect actual &&
+	(
+		cd multisuper &&
+		git submodule add ../sub1 sub4 &&
+		git submodule add ../sub1 sub5 &&
+		git commit -m "add more submodules"
+	) &&
+	(
+		cd multisuper_clone &&
+		# obtain the new superproject
+		git pull &&
+		git submodule update --init-default-path &&
+		git submodule status |cut -c1,43- >../actual
+	) &&
+	test_cmp expect2 actual
+'
+
 test_done
-- 
2.10.1.469.g00a8914

