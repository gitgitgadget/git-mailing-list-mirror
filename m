Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C78020951
	for <e@80x24.org>; Tue, 14 Mar 2017 22:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbdCNWLZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 18:11:25 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34998 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbdCNWLY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 18:11:24 -0400
Received: by mail-pg0-f47.google.com with SMTP id b129so96591551pgc.2
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 15:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vGKFTTNo3f5TKUz8L5/fL2oUGsmOpFVArttcTLC/LAw=;
        b=YDc8LScjhp97DmugF6DiTkb6i5tyoUEqK6ukYXvAg2t541xRi12XHhxFCJ4A7YCnoO
         iWN5oaUiC2zPbuONBKOKElbUoVT3UrDHxDRNO5XMt8jQtNNi9rBgHEE54NvYFNRXBDQI
         B7uT/tlN0qFUvhFHZvEHXhAtTUhRLJ2J/CiVX5RYVbJ0zBmO+RZ2A/Ce0gC7HyThNKBi
         mnDN+1M5euBvLhBjhYa8NqtuPZxG9taOtlIGuBAjkk34OzsVVne+DdZFEgRpOY7MWz+u
         /oiVSDgwL05tc1wSihUfZqLg+klMqXrIIUBe/4uy2+xuzg7TkDVvkh5yYGHishEW7d3M
         1ZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vGKFTTNo3f5TKUz8L5/fL2oUGsmOpFVArttcTLC/LAw=;
        b=VHcWydAz0Xec/F8x6Y11ODZ5DoXliPxazTOAGxKUkdSpZyHBD2K+0a6YtSnaGqRHBX
         JwZ88PpCjvJyzevnCQN1Wrw+FEuhwn1IbM4aC4xCXTk8SZQcHljqQfzDQtERvhjc7YLT
         dAG+aaPVCCADNDiM+8N76TDIf4gpObqtVMm1eAY2gJr3IMgXs7NhZrN/j49W7nESLoA0
         PbuvDKifqqFngm3LTxk1Ty+7pkSGuvphV4olZyn35eixTZHRiCWfq2uP4NLK4YynYPyG
         q9Pqs4Sf9FNlaXNft4xnahEiUBGBE/YwVu1eeHvYnVf/6/BNxqRWMtzkkiut/xhxRb04
         IA8Q==
X-Gm-Message-State: AMke39m2lPxmxF+j3DXXahhKimm8m6KHfV1gZ6P3yCTKdUoA5EcoHJZxYeS2yX2ECCKsSuAW
X-Received: by 10.84.231.133 with SMTP id g5mr58551980plk.59.1489529477733;
        Tue, 14 Mar 2017 15:11:17 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id r12sm40691742pgn.26.2017.03.14.15.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 15:11:16 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, peff@peff.net, johannes.schindelin@gmx.de,
        pclouds@gmail.com
Subject: [PATCH v2 3/4] grep: fix bug when recursing with relative pathspec
Date:   Tue, 14 Mar 2017 15:10:59 -0700
Message-Id: <20170314221100.24856-4-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170314221100.24856-1-bmwill@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
 <20170314221100.24856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the --recurse-submodules flag with a relative pathspec which
includes "..", an error is produced inside the child process spawned for
a submodule.  When creating the pathspec struct in the child, the ".."
is interpreted to mean "go up a directory" which causes an error stating
that the path ".." is outside of the repository.

While it is true that ".." is outside the scope of the submodule, it is
confusing to a user who originally invoked the command where ".." was
indeed still inside the scope of the superproject.  Since the child
process launched for the submodule has some context that it is operating
underneath a superproject, this error could be avoided.

This patch fixes the bug by passing the 'prefix' to the child process.
Now each child process that works on a submodule has two points of
reference to the superproject: (1) the 'super_prefix' which is the path
from the root of the superproject down to root of the submodule and (2)
the 'prefix' which is the path from the root of the superproject down to
the directory where the user invoked the git command.

With these two pieces of information a child process can correctly
interpret the pathspecs provided by the user as well as being able to
properly format its output relative to the directory the user invoked
the original command from.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/grep.c                     | 39 ++++++++++++--------
 t/t7814-grep-recurse-submodules.sh | 75 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 15 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 4694e68f3..b5d846393 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -310,10 +310,7 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 {
 	struct strbuf pathbuf = STRBUF_INIT;
 
-	if (opt->relative && opt->prefix_length) {
-		quote_path_relative(filename + tree_name_len, opt->prefix, &pathbuf);
-		strbuf_insert(&pathbuf, 0, filename, tree_name_len);
-	} else if (super_prefix) {
+	if (super_prefix) {
 		strbuf_add(&pathbuf, filename, tree_name_len);
 		strbuf_addstr(&pathbuf, super_prefix);
 		strbuf_addstr(&pathbuf, filename + tree_name_len);
@@ -321,6 +318,13 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 		strbuf_addstr(&pathbuf, filename);
 	}
 
+	if (opt->relative && opt->prefix_length) {
+		char *name = strbuf_detach(&pathbuf, NULL);
+		quote_path_relative(name + tree_name_len, opt->prefix, &pathbuf);
+		strbuf_insert(&pathbuf, 0, name, tree_name_len);
+		free(name);
+	}
+
 #ifndef NO_PTHREADS
 	if (num_threads) {
 		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, path, sha1);
@@ -345,12 +349,14 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
 
+	if (super_prefix)
+		strbuf_addstr(&buf, super_prefix);
+	strbuf_addstr(&buf, filename);
+
 	if (opt->relative && opt->prefix_length) {
-		quote_path_relative(filename, opt->prefix, &buf);
-	} else {
-		if (super_prefix)
-			strbuf_addstr(&buf, super_prefix);
-		strbuf_addstr(&buf, filename);
+		char *name = strbuf_detach(&buf, NULL);
+		quote_path_relative(name, opt->prefix, &buf);
+		free(name);
 	}
 
 #ifndef NO_PTHREADS
@@ -399,13 +405,12 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
 }
 
 static void compile_submodule_options(const struct grep_opt *opt,
-				      const struct pathspec *pathspec,
+				      const char **argv,
 				      int cached, int untracked,
 				      int opt_exclude, int use_index,
 				      int pattern_type_arg)
 {
 	struct grep_pat *pattern;
-	int i;
 
 	if (recurse_submodules)
 		argv_array_push(&submodule_options, "--recurse-submodules");
@@ -523,9 +528,8 @@ static void compile_submodule_options(const struct grep_opt *opt,
 
 	/* Add Pathspecs */
 	argv_array_push(&submodule_options, "--");
-	for (i = 0; i < pathspec->nr; i++)
-		argv_array_push(&submodule_options,
-				pathspec->items[i].original);
+	for (; *argv; argv++)
+		argv_array_push(&submodule_options, *argv);
 }
 
 /*
@@ -549,6 +553,11 @@ static int grep_submodule_launch(struct grep_opt *opt,
 	prepare_submodule_repo_env(&cp.env_array);
 	argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);
 
+	if (opt->relative && opt->prefix_length)
+		argv_array_pushf(&cp.env_array, "%s=%s",
+				 GIT_TOPLEVEL_PREFIX_ENVIRONMENT,
+				 opt->prefix);
+
 	/* Add super prefix */
 	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
 			 super_prefix ? super_prefix : "",
@@ -1236,7 +1245,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	if (recurse_submodules) {
 		gitmodules_config();
-		compile_submodule_options(&opt, &pathspec, cached, untracked,
+		compile_submodule_options(&opt, argv + i, cached, untracked,
 					  opt_exclude, use_index,
 					  pattern_type_arg);
 	}
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 67247a01d..5b6eb3a65 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -227,6 +227,81 @@ test_expect_success 'grep history with moved submoules' '
 	test_cmp expect actual
 '
 
+test_expect_success 'grep using relative path' '
+	test_when_finished "rm -rf parent sub" &&
+	git init sub &&
+	echo "foobar" >sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add file" &&
+
+	git init parent &&
+	echo "foobar" >parent/file &&
+	git -C parent add file &&
+	mkdir parent/src &&
+	echo "foobar" >parent/src/file2 &&
+	git -C parent add src/file2 &&
+	git -C parent submodule add ../sub &&
+	git -C parent commit -m "add files and submodule" &&
+
+	# From top works
+	cat >expect <<-\EOF &&
+	file:foobar
+	src/file2:foobar
+	sub/file:foobar
+	EOF
+	git -C parent grep --recurse-submodules -e "foobar" >actual &&
+	test_cmp expect actual &&
+
+	# Relative path to top
+	cat >expect <<-\EOF &&
+	../file:foobar
+	file2:foobar
+	../sub/file:foobar
+	EOF
+	git -C parent/src grep --recurse-submodules -e "foobar" -- .. >actual &&
+	test_cmp expect actual &&
+
+	# Relative path to submodule
+	cat >expect <<-\EOF &&
+	../sub/file:foobar
+	EOF
+	git -C parent/src grep --recurse-submodules -e "foobar" -- ../sub >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep from a subdir' '
+	test_when_finished "rm -rf parent sub" &&
+	git init sub &&
+	echo "foobar" >sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add file" &&
+
+	git init parent &&
+	mkdir parent/src &&
+	echo "foobar" >parent/src/file &&
+	git -C parent add src/file &&
+	git -C parent submodule add ../sub src/sub &&
+	git -C parent submodule add ../sub sub &&
+	git -C parent commit -m "add files and submodules" &&
+
+	# Verify grep from root works
+	cat >expect <<-\EOF &&
+	src/file:foobar
+	src/sub/file:foobar
+	sub/file:foobar
+	EOF
+	git -C parent grep --recurse-submodules -e "foobar" >actual &&
+	test_cmp expect actual &&
+
+	# Verify grep from a subdir works
+	cat >expect <<-\EOF &&
+	file:foobar
+	sub/file:foobar
+	EOF
+	git -C parent/src grep --recurse-submodules -e "foobar" >actual &&
+	test_cmp expect actual
+'
+
 test_incompatible_with_recurse_submodules ()
 {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
-- 
2.12.0.367.g23dc2f6d3c-goog

