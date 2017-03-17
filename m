Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40BAB20951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751049AbdCQRXN (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:23:13 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32818 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdCQRXL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:23:11 -0400
Received: by mail-pg0-f46.google.com with SMTP id n190so46312763pga.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=50nyPlaYeilj130YYpRQLVD5NrIWiADI+WGg7TbK1Gw=;
        b=Gw+T0HrUBSd3AsK8gmm0sIq8bOBdo844MuWW0NcO+QHf9wSzf4bFL9dmLE7VKdSdzT
         i7YgRBxAMdBrkDEr5gSyC1dmRe1FXt8MWYYC5CE1aCaPiD1dO3ifSMcWmJfT9gk9Anl3
         bPJ9qZxG2qDsaiBMs/QZHISYSp7tU8oYmQ2CSq1m2Y6RvovT5NeEQHpEo6cU0zr0vya0
         n8FgcP3eD5nvASzeiA2HTPi9TUyzuWjVsIdYGyk9rHnAweJrnv/C92HzyDcab0Dwq/tg
         WMnhQs9COADjF0Tb51YgR0ydWv8sA9mwKNppJgNehH8gRhAcUspE3XXaCpiszvb5QeO9
         6pFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=50nyPlaYeilj130YYpRQLVD5NrIWiADI+WGg7TbK1Gw=;
        b=OdBTsok/oNOQWZ5LrcAbMkhlBT0fEEbvrfFlSk80oR+aLhyANDPvl2Y8K6woWcF0qQ
         8sbUGkeHAmj8TJAhmiVnVN1o/i4NrxREReqOLpoAevC2jVZtcD8Mfpaec7cJ6tHGsI7a
         A9Kn2g4i27Jvpv6+S927cFqiRfJKhcmGczsem74VbRQ31wolW4AuqjAgPuFOKPp3RCUo
         n85AVZTeXQ6FWibPgaAfBVg1pxP2VHsN+/4oHFnTIevznqoq6GSmWlFfnhMAgt/YX16v
         w/34Qn4b7933coPgVE94vSgF+satxDEPiLJNBXUeCmauxSBV/nZ+ejLO7rfHxOwsDR5r
         +Leg==
X-Gm-Message-State: AFeK/H3/rNfIHToLtYRk9pDaHgPTaxNmDjk6tYEgHMjcoOXfLfQYZXdQeLI+c6dC7aCX/KnI
X-Received: by 10.84.132.34 with SMTP id 31mr21356314ple.86.1489771389807;
        Fri, 17 Mar 2017 10:23:09 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 197sm17978861pfv.19.2017.03.17.10.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 10:23:08 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, peff@peff.net, johannes.schindelin@gmx.de,
        pclouds@gmail.com
Subject: [PATCH v3 5/5] ls-files: fix bug when recursing with relative pathspec
Date:   Fri, 17 Mar 2017 10:22:57 -0700
Message-Id: <20170317172257.4690-6-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170317172257.4690-1-bmwill@google.com>
References: <20170314221100.24856-1-bmwill@google.com>
 <20170317172257.4690-1-bmwill@google.com>
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
 builtin/ls-files.c                     | 25 +++++++++++-----------
 t/t3007-ls-files-recurse-submodules.sh | 39 ++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index ca5b48db0..d449e46db 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -172,7 +172,9 @@ static void show_killed_files(struct dir_struct *dir)
 /*
  * Compile an argv_array with all of the options supported by --recurse_submodules
  */
-static void compile_submodule_options(const struct dir_struct *dir, int show_tag)
+static void compile_submodule_options(const char **argv,
+				      const struct dir_struct *dir,
+				      int show_tag)
 {
 	if (line_terminator == '\0')
 		argv_array_push(&submodule_options, "-z");
@@ -186,6 +188,11 @@ static void compile_submodule_options(const struct dir_struct *dir, int show_tag
 		argv_array_push(&submodule_options, "--eol");
 	if (debug_mode)
 		argv_array_push(&submodule_options, "--debug");
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
@@ -206,15 +216,6 @@ static void show_gitlink(const struct cache_entry *ce)
 	/* add supported options */
 	argv_array_pushv(&cp.args, submodule_options.argv);
 
-	/*
-	 * Pass in the original pathspec args.  The submodule will be
-	 * responsible for prepending the 'submodule_prefix' prior to comparing
-	 * against the pathspec for matches.
-	 */
-	argv_array_push(&cp.args, "--");
-	for (i = 0; i < pathspec.nr; i++)
-		argv_array_push(&cp.args, pathspec.items[i].original);
-
 	cp.git_cmd = 1;
 	cp.dir = ce->name;
 	status = run_command(&cp);
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

