Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594C720986
	for <e@80x24.org>; Fri,  7 Oct 2016 18:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754915AbcJGSTZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 14:19:25 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34147 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754345AbcJGSTW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 14:19:22 -0400
Received: by mail-pf0-f173.google.com with SMTP id e6so26865105pfk.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 11:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tuUgoVpISR4jLOMr8zlXLxpJxFtVpW09ju76MYQnxMs=;
        b=DyQc7XCpVRXZoGdHH4PlD+LKmc7Zbzx08dpZiJO/hjZaqUu0TTDPOLplkAnm+8O5kw
         3vBBHSCX6aTHQpzKZXlbznhRvWHJAsN4aggRRZxhD6eu/Nz8nWy8fX4bNRpWnGr+kjaK
         WHdRoem48kAgQ1IAcODf4ncTb8Ql28gwIyyEolOc0BdZSkjP4F8LpJtV8poA4vltC076
         Iwozli+9RWr6FvT+LM16m+Ec4utJkEshEUKBHz9/nWcnayFMAQ3CoBaTViMSC2fCm0Dj
         e8vT+l2kHkkvImv5zHz55Ws1TnT+FanZ1YKJ8ltp7RvuHFwmn88aBAeftVEqxhzL57db
         Ti/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tuUgoVpISR4jLOMr8zlXLxpJxFtVpW09ju76MYQnxMs=;
        b=g/0wczUenShbTq1Jz7cjVlMbdYE+e46YpQbsn/7XeKRghJlTI/cvWw64DL43lZ+Rvz
         YIUJ1mBt/JYdU63xua8cfhW2A1tx+9YAlTYrxX93Kn3FH2mLJOVwoWQaUX9tQDjQXCJ9
         J8fih1Kmdt8zmCEXXH89T9DW/AakL+yg4RDMa0WItRzS2pmnH8tBbAga1/7slMJVJjuJ
         rrvwfX4RNhnlSUmj9y0xNNV2+O4GDwzxY15S/dHhno5pKSliVyU/OINCxnpmoyjD35Gx
         75Fw76qFzyuzhTXtzdk5z2K/WvILxj7pZiD5S3Ir+PiAtCZOnrC9dU2lIXULsisxiQRY
         F6jw==
X-Gm-Message-State: AA6/9RlHayAEJ6/E+FAZvnW1cy77eqQpT21tj3083KRTfzMjyjUHiApvIQdYMFIpAYTXNjiC
X-Received: by 10.98.37.130 with SMTP id l124mr30268438pfl.60.1475864361074;
        Fri, 07 Oct 2016 11:19:21 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.36.144])
        by smtp.gmail.com with ESMTPSA id s74sm15641281pfk.61.2016.10.07.11.19.19
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 07 Oct 2016 11:19:20 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, gitster@pobox.com
Subject: [PATCH v7 2/4] ls-files: optionally recurse into submodules
Date:   Fri,  7 Oct 2016 11:18:49 -0700
Message-Id: <20161007181851.15063-3-bmwill@google.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161007181851.15063-1-bmwill@google.com>
References: <1475185723-36871-1-git-send-email-bmwill@google.com>
 <20161007181851.15063-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow ls-files to recognize submodules in order to retrieve a list of
files from a repository's submodules.  This is done by forking off a
process to recursively call ls-files on all submodules. Use top-level
--super-prefix option to pass a path to the submodule which it can
use to prepend to output or pathspec matching logic.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-ls-files.txt         |   8 +-
 builtin/ls-files.c                     | 138 ++++++++++++++++++++++++---------
 git.c                                  |   2 +-
 t/t3007-ls-files-recurse-submodules.sh | 100 ++++++++++++++++++++++++
 4 files changed, 208 insertions(+), 40 deletions(-)
 create mode 100755 t/t3007-ls-files-recurse-submodules.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 0d933ac..ea01d45 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -18,7 +18,8 @@ SYNOPSIS
 		[--exclude-per-directory=<file>]
 		[--exclude-standard]
 		[--error-unmatch] [--with-tree=<tree-ish>]
-		[--full-name] [--abbrev] [--] [<file>...]
+		[--full-name] [--recurse-submodules]
+		[--abbrev] [--] [<file>...]
 
 DESCRIPTION
 -----------
@@ -137,6 +138,11 @@ a space) at the start of each line:
 	option forces paths to be output relative to the project
 	top directory.
 
+--recurse-submodules::
+	Recursively calls ls-files on each submodule in the repository.
+	Currently there is only support for the --cached mode without a
+	pathspec.
+
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	lines, show only a partial prefix.
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 00ea91a..63befed 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -14,6 +14,7 @@
 #include "resolve-undo.h"
 #include "string-list.h"
 #include "pathspec.h"
+#include "run-command.h"
 
 static int abbrev;
 static int show_deleted;
@@ -28,8 +29,10 @@ static int show_valid_bit;
 static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
+static int recurse_submodules;
 
 static const char *prefix;
+static const char *super_prefix;
 static int max_prefix_len;
 static int prefix_len;
 static struct pathspec pathspec;
@@ -68,11 +71,24 @@ static void write_eolinfo(const struct cache_entry *ce, const char *path)
 static void write_name(const char *name)
 {
 	/*
+	 * Prepend the super_prefix to name to construct the full_name to be
+	 * written.
+	 */
+	struct strbuf full_name = STRBUF_INIT;
+	if (super_prefix) {
+		strbuf_addstr(&full_name, super_prefix);
+		strbuf_addstr(&full_name, name);
+		name = full_name.buf;
+	}
+
+	/*
 	 * With "--full-name", prefix_len=0; this caller needs to pass
 	 * an empty string in that case (a NULL is good for "").
 	 */
 	write_name_quoted_relative(name, prefix_len ? prefix : NULL,
 				   stdout, line_terminator);
+
+	strbuf_release(&full_name);
 }
 
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
@@ -152,55 +168,84 @@ static void show_killed_files(struct dir_struct *dir)
 	}
 }
 
+/**
+ * Recursively call ls-files on a submodule
+ */
+static void show_gitlink(const struct cache_entry *ce)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int status;
+
+	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
+			 super_prefix ? super_prefix : "",
+			 ce->name);
+	argv_array_push(&cp.args, "ls-files");
+	argv_array_push(&cp.args, "--recurse-submodules");
+
+	cp.git_cmd = 1;
+	cp.dir = ce->name;
+	status = run_command(&cp);
+	if (status)
+		exit(status);
+}
+
 static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 {
+	struct strbuf name = STRBUF_INIT;
 	int len = max_prefix_len;
+	if (super_prefix)
+		strbuf_addstr(&name, super_prefix);
+	strbuf_addstr(&name, ce->name);
 
 	if (len >= ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of prefix");
 
-	if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
-			    len, ps_matched,
-			    S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode)))
-		return;
+	if (recurse_submodules && S_ISGITLINK(ce->ce_mode)) {
+		show_gitlink(ce);
+	} else if (match_pathspec(&pathspec, name.buf, name.len,
+				  len, ps_matched,
+				  S_ISDIR(ce->ce_mode) ||
+				  S_ISGITLINK(ce->ce_mode))) {
+		if (tag && *tag && show_valid_bit &&
+		    (ce->ce_flags & CE_VALID)) {
+			static char alttag[4];
+			memcpy(alttag, tag, 3);
+			if (isalpha(tag[0]))
+				alttag[0] = tolower(tag[0]);
+			else if (tag[0] == '?')
+				alttag[0] = '!';
+			else {
+				alttag[0] = 'v';
+				alttag[1] = tag[0];
+				alttag[2] = ' ';
+				alttag[3] = 0;
+			}
+			tag = alttag;
+		}
 
-	if (tag && *tag && show_valid_bit &&
-	    (ce->ce_flags & CE_VALID)) {
-		static char alttag[4];
-		memcpy(alttag, tag, 3);
-		if (isalpha(tag[0]))
-			alttag[0] = tolower(tag[0]);
-		else if (tag[0] == '?')
-			alttag[0] = '!';
-		else {
-			alttag[0] = 'v';
-			alttag[1] = tag[0];
-			alttag[2] = ' ';
-			alttag[3] = 0;
+		if (!show_stage) {
+			fputs(tag, stdout);
+		} else {
+			printf("%s%06o %s %d\t",
+			       tag,
+			       ce->ce_mode,
+			       find_unique_abbrev(ce->sha1,abbrev),
+			       ce_stage(ce));
+		}
+		write_eolinfo(ce, ce->name);
+		write_name(ce->name);
+		if (debug_mode) {
+			const struct stat_data *sd = &ce->ce_stat_data;
+
+			printf("  ctime: %d:%d\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
+			printf("  mtime: %d:%d\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
+			printf("  dev: %d\tino: %d\n", sd->sd_dev, sd->sd_ino);
+			printf("  uid: %d\tgid: %d\n", sd->sd_uid, sd->sd_gid);
+			printf("  size: %d\tflags: %x\n", sd->sd_size, ce->ce_flags);
 		}
-		tag = alttag;
 	}
 
-	if (!show_stage) {
-		fputs(tag, stdout);
-	} else {
-		printf("%s%06o %s %d\t",
-		       tag,
-		       ce->ce_mode,
-		       find_unique_abbrev(ce->sha1,abbrev),
-		       ce_stage(ce));
-	}
-	write_eolinfo(ce, ce->name);
-	write_name(ce->name);
-	if (debug_mode) {
-		const struct stat_data *sd = &ce->ce_stat_data;
-
-		printf("  ctime: %d:%d\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
-		printf("  mtime: %d:%d\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
-		printf("  dev: %d\tino: %d\n", sd->sd_dev, sd->sd_ino);
-		printf("  uid: %d\tgid: %d\n", sd->sd_uid, sd->sd_gid);
-		printf("  size: %d\tflags: %x\n", sd->sd_size, ce->ce_flags);
-	}
+	strbuf_release(&name);
 }
 
 static void show_ru_info(void)
@@ -468,6 +513,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		{ OPTION_SET_INT, 0, "full-name", &prefix_len, NULL,
 			N_("make the output relative to the project top directory"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL },
+		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
+			N_("recurse through submodules")),
 		OPT_BOOL(0, "error-unmatch", &error_unmatch,
 			N_("if any <file> is not in the index, treat this as an error")),
 		OPT_STRING(0, "with-tree", &with_tree, N_("tree-ish"),
@@ -484,6 +531,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	prefix = cmd_prefix;
 	if (prefix)
 		prefix_len = strlen(prefix);
+	super_prefix = get_super_prefix();
 	git_config(git_default_config, NULL);
 
 	if (read_cache() < 0)
@@ -519,6 +567,20 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
+	if (recurse_submodules &&
+	    (show_stage || show_deleted || show_others || show_unmerged ||
+	     show_killed || show_modified || show_resolve_undo ||
+	     show_valid_bit || show_tag || show_eol || with_tree ||
+	     (line_terminator == '\0')))
+		die("ls-files --recurse-submodules unsupported mode");
+
+	if (recurse_submodules && error_unmatch)
+		die("ls-files --recurse-submodules does not support "
+		    "--error-unmatch");
+
+	if (recurse_submodules && argc)
+		die("ls-files --recurse-submodules does not support pathspec");
+
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
diff --git a/git.c b/git.c
index 469a83f..df73768 100644
--- a/git.c
+++ b/git.c
@@ -443,7 +443,7 @@ static struct cmd_struct commands[] = {
 	{ "init-db", cmd_init_db },
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
 	{ "log", cmd_log, RUN_SETUP },
-	{ "ls-files", cmd_ls_files, RUN_SETUP },
+	{ "ls-files", cmd_ls_files, RUN_SETUP | SUPPORT_SUPER_PREFIX },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 	{ "mailinfo", cmd_mailinfo },
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
new file mode 100755
index 0000000..b5a53c3
--- /dev/null
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -0,0 +1,100 @@
+#!/bin/sh
+
+test_description='Test ls-files recurse-submodules feature
+
+This test verifies the recurse-submodules feature correctly lists files from
+submodules.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup directory structure and submodules' '
+	echo a >a &&
+	mkdir b &&
+	echo b >b/b &&
+	git add a b &&
+	git commit -m "add a and b" &&
+	git init submodule &&
+	echo c >submodule/c &&
+	git -C submodule add c &&
+	git -C submodule commit -m "add c" &&
+	git submodule add ./submodule &&
+	git commit -m "added submodule"
+'
+
+test_expect_success 'ls-files correctly outputs files in submodule' '
+	cat >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	submodule/c
+	EOF
+
+	git ls-files --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-files does not output files not added to a repo' '
+	cat >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	submodule/c
+	EOF
+
+	echo a >not_added &&
+	echo b >b/not_added &&
+	echo c >submodule/not_added &&
+	git ls-files --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-files recurses more than 1 level' '
+	cat >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	submodule/.gitmodules
+	submodule/c
+	submodule/subsub/d
+	EOF
+
+	git init submodule/subsub &&
+	echo d >submodule/subsub/d &&
+	git -C submodule/subsub add d &&
+	git -C submodule/subsub commit -m "add d" &&
+	git -C submodule submodule add ./subsub &&
+	git -C submodule commit -m "added subsub" &&
+	git ls-files --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--recurse-submodules does not support using path arguments' '
+	test_must_fail git ls-files --recurse-submodules b 2>actual &&
+	test_i18ngrep "does not support pathspec" actual
+'
+
+test_expect_success '--recurse-submodules does not support --error-unmatch' '
+	test_must_fail git ls-files --recurse-submodules --error-unmatch 2>actual &&
+	test_i18ngrep "does not support --error-unmatch" actual
+'
+
+test_incompatible_with_recurse_submodules () {
+	test_expect_success "--recurse-submodules and $1 are incompatible" "
+		test_must_fail git ls-files --recurse-submodules $1 2>actual &&
+		test_i18ngrep 'unsupported mode' actual
+	"
+}
+
+test_incompatible_with_recurse_submodules -z
+test_incompatible_with_recurse_submodules -v
+test_incompatible_with_recurse_submodules -t
+test_incompatible_with_recurse_submodules --deleted
+test_incompatible_with_recurse_submodules --modified
+test_incompatible_with_recurse_submodules --others
+test_incompatible_with_recurse_submodules --stage
+test_incompatible_with_recurse_submodules --killed
+test_incompatible_with_recurse_submodules --unmerged
+test_incompatible_with_recurse_submodules --eol
+
+test_done
-- 
2.10.0

