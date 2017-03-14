Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF41620951
	for <e@80x24.org>; Tue, 14 Mar 2017 22:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbdCNWL1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 18:11:27 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33995 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbdCNWL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 18:11:26 -0400
Received: by mail-pg0-f54.google.com with SMTP id 141so860906pgd.1
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ewrp4BtXk1577eRJRMSUW+K6x5WstyqwGdqZFNeI4nA=;
        b=jqZcA5ebgpruOM1em4zEscWvcXolB3Kx26epsI60iIpjcRGLFRehO0ngNkOrL+qvwF
         pDsU3DxyeXAPFS4QYCgxwSJfqGaElturd4fQZGSf/WqPbrp6YbB39e3hBODGdx/uskYW
         05JXd6ze6GCzP/WlfXSPqfyFOPXFaBXF1mv3frvse359NHYaU7yxP6ebgR/smMRGl3WM
         u7NZTkLa77Kkz10UGtYWRrjI80+WR2hbCKy8c6IjYStMbfr0eAM1aTJ4g79Uu/ltZviF
         z95Il3viFfTwgyFtYGk78laZvJMt5GDaIfDu4AZCs3Z48jCJLVEGd9Miq3AhrDRgmdp8
         FIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ewrp4BtXk1577eRJRMSUW+K6x5WstyqwGdqZFNeI4nA=;
        b=dAVJUtbUQuUjISAYGvPohmCUFoCYXwkhVLligq1qGRnH+Ab/u8hCdNJGQaPIfVRcUk
         CXpFyMFTeohliR7GkAF2/qkKsGBi5O/95ASNBQAsj7peg3LMYtRWYU11HiZbEfc1xodh
         zJqUwQD8blqyyAOHnhZW2wGkKx9/1g6qYlXF+ehSx10g+QyKZ7UinYAM9I3iAAjKDGsL
         B9eC2k4gIA5CX5vVKsf9mCtDy4KKdg9q/O7f4BeahCdUPcyW4TYscWyCUXESAM+Jc4Q6
         OqCLAsrM9pThV1U7Gk1u4rGzHlgMPjjZbFb8JPYtc6bnzRg9wbt1gwTf0Dp+h9WOSzoK
         z91w==
X-Gm-Message-State: AMke39kXnGk41x/nJBi2XpBCrMvgamt0GOKpLs18UBr6z1FAD5shh2wC6oxEjm9bjS6wVkyG
X-Received: by 10.99.3.16 with SMTP id 16mr46851572pgd.150.1489529479618;
        Tue, 14 Mar 2017 15:11:19 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id r12sm40691742pgn.26.2017.03.14.15.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 15:11:18 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, peff@peff.net, johannes.schindelin@gmx.de,
        pclouds@gmail.com
Subject: [PATCH v2 4/4] ls-files: fix bug when recursing with relative pathspec
Date:   Tue, 14 Mar 2017 15:11:00 -0700
Message-Id: <20170314221100.24856-5-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170314221100.24856-1-bmwill@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
 <20170314221100.24856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the --recurse-submodules flag with a relative pathspec which
includes "..", an error is produced inside the child process spawned for a
submodule.  When creating the pathspec struct in the child, the ".." is
interpreted to mean "go up a directory" which causes an error stating that the
path ".." is outside of the repository.

While it is true that ".." is outside the scope of the submodule, it is
confusing to a user who originally invoked the command where ".." was indeed
still inside the scope of the superproject.  Since the child process launched
for the submodule has some context that it is operating underneath a
superproject, this error could be avoided.

This patch fixes the bug by passing the 'prefix' to the child process.  Now
each child process that works on a submodule has two points of reference to the
superproject: (1) the 'super_prefix' which is the path from the root of the
superproject down to root of the submodule and (2) the 'prefix' which is the
path from the root of the superproject down to the directory where the user
invoked the git command.

With these two pieces of information a child process can correctly interpret
the pathspecs provided by the user as well as being able to properly format its
output relative to the directory the user invoked the original command from.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c                     | 41 +++++++++++++++++-----------------
 t/t3007-ls-files-recurse-submodules.sh | 39 ++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 1c0f057d0..d449e46db 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -30,7 +30,7 @@ static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
 static int recurse_submodules;
-static struct argv_array submodules_options = ARGV_ARRAY_INIT;
+static struct argv_array submodule_options = ARGV_ARRAY_INIT;
 
 static const char *prefix;
 static const char *super_prefix;
@@ -172,20 +172,27 @@ static void show_killed_files(struct dir_struct *dir)
 /*
  * Compile an argv_array with all of the options supported by --recurse_submodules
  */
-static void compile_submodule_options(const struct dir_struct *dir, int show_tag)
+static void compile_submodule_options(const char **argv,
+				      const struct dir_struct *dir,
+				      int show_tag)
 {
 	if (line_terminator == '\0')
-		argv_array_push(&submodules_options, "-z");
+		argv_array_push(&submodule_options, "-z");
 	if (show_tag)
-		argv_array_push(&submodules_options, "-t");
+		argv_array_push(&submodule_options, "-t");
 	if (show_valid_bit)
-		argv_array_push(&submodules_options, "-v");
+		argv_array_push(&submodule_options, "-v");
 	if (show_cached)
-		argv_array_push(&submodules_options, "--cached");
+		argv_array_push(&submodule_options, "--cached");
 	if (show_eol)
-		argv_array_push(&submodules_options, "--eol");
+		argv_array_push(&submodule_options, "--eol");
 	if (debug_mode)
-		argv_array_push(&submodules_options, "--debug");
+		argv_array_push(&submodule_options, "--debug");
+
+	/* Add Pathspecs */
+	argv_array_push(&submodule_options, "--");
+	for (; *argv; argv++)
+		argv_array_push(&submodule_options, *argv);
 }
 
 /**
@@ -195,8 +202,11 @@ static void show_gitlink(const struct cache_entry *ce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int status;
-	int i;
 
+	if (prefix_len)
+		argv_array_pushf(&cp.env_array, "%s=%s",
+				 GIT_TOPLEVEL_PREFIX_ENVIRONMENT,
+				 prefix);
 	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
 			 super_prefix ? super_prefix : "",
 			 ce->name);
@@ -204,16 +214,7 @@ static void show_gitlink(const struct cache_entry *ce)
 	argv_array_push(&cp.args, "--recurse-submodules");
 
 	/* add supported options */
-	argv_array_pushv(&cp.args, submodules_options.argv);
-
-	/*
-	 * Pass in the original pathspec args.  The submodule will be
-	 * responsible for prepending the 'submodule_prefix' prior to comparing
-	 * against the pathspec for matches.
-	 */
-	argv_array_push(&cp.args, "--");
-	for (i = 0; i < pathspec.nr; i++)
-		argv_array_push(&cp.args, pathspec.items[i].original);
+	argv_array_pushv(&cp.args, submodule_options.argv);
 
 	cp.git_cmd = 1;
 	cp.dir = ce->name;
@@ -604,7 +605,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		setup_work_tree();
 
 	if (recurse_submodules)
-		compile_submodule_options(&dir, show_tag);
+		compile_submodule_options(argv, &dir, show_tag);
 
 	if (recurse_submodules &&
 	    (show_stage || show_deleted || show_others || show_unmerged ||
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index a5426171d..4cf6ccf5a 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -188,6 +188,45 @@ test_expect_success '--recurse-submodules and pathspecs' '
 	test_cmp expect actual
 '
 
+test_expect_success '--recurse-submodules and relative paths' '
+	# From subdir
+	cat >expect <<-\EOF &&
+	b
+	EOF
+	git -C b ls-files --recurse-submodules >actual &&
+	test_cmp expect actual &&
+
+	# Relative path to top
+	cat >expect <<-\EOF &&
+	../.gitmodules
+	../a
+	b
+	../h.txt
+	../sib/file
+	../sub/file
+	../submodule/.gitmodules
+	../submodule/c
+	../submodule/f.TXT
+	../submodule/g.txt
+	../submodule/subsub/d
+	../submodule/subsub/e.txt
+	EOF
+	git -C b ls-files --recurse-submodules -- .. >actual &&
+	test_cmp expect actual &&
+
+	# Relative path to submodule
+	cat >expect <<-\EOF &&
+	../submodule/.gitmodules
+	../submodule/c
+	../submodule/f.TXT
+	../submodule/g.txt
+	../submodule/subsub/d
+	../submodule/subsub/e.txt
+	EOF
+	git -C b ls-files --recurse-submodules -- ../submodule >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--recurse-submodules does not support --error-unmatch' '
 	test_must_fail git ls-files --recurse-submodules --error-unmatch 2>actual &&
 	test_i18ngrep "does not support --error-unmatch" actual
-- 
2.12.0.367.g23dc2f6d3c-goog

