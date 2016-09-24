Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6C4207EC
	for <e@80x24.org>; Sat, 24 Sep 2016 00:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbcIXAOA (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 20:14:00 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33058 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752993AbcIXAN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 20:13:58 -0400
Received: by mail-pa0-f48.google.com with SMTP id hm5so44636344pac.0
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 17:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7g62/4oQ5afXi1dzY4SMR0clLMxfb6BCRWCtXW829sc=;
        b=dt3ozc12uuG555XlCzItEebTKipYsYPf0THV6WsBwr4jmI+4JaVnzfG9d7cVfa56xp
         xjoNaje0E/okT0ItFopP65Xn0F9KQvD3QyqAjHhPMlz4870x3EtWwRsK8gjgLkVtnG7l
         pnOU/L2Gpa/baZZVyhFOY62A8dxJdLige9x4hhZP+tZTfwwjMtQuFL94Q8vkiw4G0iWg
         AOQDoC6vIkh5sHuEfXUOl1aRDNbj3e6A0OASqVVy6MCkmcO/eZr1fcK24gNzvH2LsbnC
         M173p8Z2kG+qrqliehxphacZLgv1+Q1w+ul9r/2OvBusfRmaM2J7RWbINpRjGRl2/4vO
         GS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7g62/4oQ5afXi1dzY4SMR0clLMxfb6BCRWCtXW829sc=;
        b=YXJ0OPglj4bCjjjbz99zLzjdLHBMYTc7NC9xDisVhN7jIJHzbHI4lGq2McidLXaeyZ
         B46t3jGH/vUQ/AW2ynOl9MJO/+pCRxbKOLIr4cD5pZzFA4q9MVHsgr9tmo1SujZPBvVF
         9trBOsxym84+y+Wf3IcMdg6lTLrghik3nanuy2HiNnTWhJ4v6Kdgx6jKSGqepg6Dn99M
         Ptp8C9fjZhv5twC+Sfa1WJVF59TmBTVucHc559kUZn6/oR6xTgeOMiN0oEdgUW8IC/2d
         Cn18ZR6wLVtmLUUQtLWyqBeqx9zWKBY57FfLu7Viq8wb81iaVBSKIZ2Qnil6kf92z60t
         pL2Q==
X-Gm-Message-State: AE9vXwNHGu71AAtQ5GclCuPhbK8PAV/wrcYw45uPnjHeAMqtCrgCcWISxJQJgfzspZpA/oej
X-Received: by 10.66.155.166 with SMTP id vx6mr16942749pab.35.1474676037679;
        Fri, 23 Sep 2016 17:13:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:4836:46ae:fc5e:2de9])
        by smtp.gmail.com with ESMTPSA id d190sm13929072pfd.59.2016.09.23.17.13.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Sep 2016 17:13:56 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 2/3 v3] ls-files: optionally recurse into submodules
Date:   Fri, 23 Sep 2016 17:13:33 -0700
Message-Id: <1474676014-134568-3-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1474676014-134568-1-git-send-email-bmwill@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow ls-files to recognize submodules in order to retrieve a list of
files from a repository's submodules.  This is done by forking off a
process to recursively call ls-files on all submodules. Use environment
variable `GIT_INTERNAL_SUBMODULE_PREFIX` to pass a path to the submodule
which it can use to prepend to output or pathspec matching logic.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-ls-files.txt         |  7 ++-
 builtin/ls-files.c                     | 63 ++++++++++++++++++++++
 t/t3007-ls-files-recurse-submodules.sh | 99 ++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100755 t/t3007-ls-files-recurse-submodules.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 0d933ac..446209e 100644
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
@@ -137,6 +138,10 @@ a space) at the start of each line:
 	option forces paths to be output relative to the project
 	top directory.
 
+--recurse-submodules::
+	Recursively calls ls-files on each submodule in the repository.
+	Currently there is only support for the --cached mode.
+
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	lines, show only a partial prefix.
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 00ea91a..54ab765 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -14,6 +14,7 @@
 #include "resolve-undo.h"
 #include "string-list.h"
 #include "pathspec.h"
+#include "run-command.h"
 
 static int abbrev;
 static int show_deleted;
@@ -28,6 +29,8 @@ static int show_valid_bit;
 static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
+static int recurse_submodules;
+static const char *submodule_prefix;
 
 static const char *prefix;
 static int max_prefix_len;
@@ -68,6 +71,21 @@ static void write_eolinfo(const struct cache_entry *ce, const char *path)
 static void write_name(const char *name)
 {
 	/*
+	 * NEEDSWORK: To make this thread-safe, full_name would have to be owned
+	 * by the caller.
+	 *
+	 * full_name get reused across output lines to minimize the allocation
+	 * churn.
+	 */
+	static struct strbuf full_name = STRBUF_INIT;
+	if (submodule_prefix && *submodule_prefix) {
+		strbuf_reset(&full_name);
+		strbuf_addstr(&full_name, submodule_prefix);
+		strbuf_addstr(&full_name, name);
+		name = full_name.buf;
+	}
+
+	/*
 	 * With "--full-name", prefix_len=0; this caller needs to pass
 	 * an empty string in that case (a NULL is good for "").
 	 */
@@ -152,6 +170,27 @@ static void show_killed_files(struct dir_struct *dir)
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
+	argv_array_push(&cp.args, "ls-files");
+	argv_array_push(&cp.args, "--recurse-submodules");
+	argv_array_pushf(&cp.env_array, "%s=%s%s/",
+			 GIT_SUBMODULE_PREFIX_ENVIRONMENT,
+			 submodule_prefix ? submodule_prefix : "",
+			 ce->name);
+	cp.git_cmd = 1;
+	cp.dir = ce->name;
+	status = run_command(&cp);
+	if (status)
+		exit(status);
+}
+
 static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 {
 	int len = max_prefix_len;
@@ -163,6 +202,10 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 			    len, ps_matched,
 			    S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode)))
 		return;
+	if (recurse_submodules && S_ISGITLINK(ce->ce_mode)) {
+		show_gitlink(ce);
+		return;
+	}
 
 	if (tag && *tag && show_valid_bit &&
 	    (ce->ce_flags & CE_VALID)) {
@@ -468,6 +511,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		{ OPTION_SET_INT, 0, "full-name", &prefix_len, NULL,
 			N_("make the output relative to the project top directory"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL },
+		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
+			N_("recurse through submodules")),
 		OPT_BOOL(0, "error-unmatch", &error_unmatch,
 			N_("if any <file> is not in the index, treat this as an error")),
 		OPT_STRING(0, "with-tree", &with_tree, N_("tree-ish"),
@@ -519,6 +564,24 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
+	if (recurse_submodules)
+		submodule_prefix = getenv(GIT_SUBMODULE_PREFIX_ENVIRONMENT);
+
+	if (recurse_submodules &&
+	    (show_stage || show_deleted || show_others || show_unmerged ||
+	     show_killed || show_modified || show_resolve_undo ||
+	     show_valid_bit || show_tag || show_eol))
+		die("ls-files --recurse-submodules can only be used in "
+		    "--cached mode");
+
+	if (recurse_submodules && error_unmatch)
+		die("ls-files --recurse-submodules does not support "
+		    "--error-unmatch");
+
+	if (recurse_submodules && argc)
+		die("ls-files --recurse-submodules does not support path "
+		    "arguments");
+
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
new file mode 100755
index 0000000..caf3815
--- /dev/null
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -0,0 +1,99 @@
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
+	test_i18ngrep "does not support path arguments" actual
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
+		test_i18ngrep 'can only be used in --cached mode' actual
+	"
+}
+
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
2.8.0.rc3.226.g39d4020

