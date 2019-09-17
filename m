Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DFA21F463
	for <e@80x24.org>; Tue, 17 Sep 2019 13:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfIQNjt (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 09:39:49 -0400
Received: from smtp.soverin.net ([159.69.232.142]:42893 "EHLO smtp.soverin.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbfIQNjt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 09:39:49 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Sep 2019 09:39:47 EDT
Received: from soverin.net by soverin.net
From:   Zeger-Jan van de Weg <git@zjvandeweg.nl>
To:     git@vger.kernel.org
Cc:     Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: [PATCH 1/1] Git config allows value setting from stdin
Date:   Tue, 17 Sep 2019 15:31:35 +0200
Message-Id: <20190917133135.190145-2-git@zjvandeweg.nl>
In-Reply-To: <20190917133135.190145-1-git@zjvandeweg.nl>
References: <20190917133135.190145-1-git@zjvandeweg.nl>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.3 at c03mi01
X-Virus-Status: Clean
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When setting values in the git config, the value is part of the
arguments for execution. This potentially leaks the value through
logging, or other programs like `ps`.

Prior to this change, there was no option to do this. This change adds
the `--stdin` to be combined with `--add`. When passed, the value cannot
be passed and is read through stdin.

Signed-off-by: Zeger-Jan van de Weg <git@zjvandeweg.nl>
---
 Documentation/git-config.txt |  5 ++++-
 builtin/config.c             | 23 +++++++++++++++++++++--
 t/t1300-config.sh            | 11 +++++++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index ff9310f958..e6e7f6b60b 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] name [value [value_regex]]
-'git config' [<file-option>] [--type=<type>] --add name value
+'git config' [<file-option>] [--type=<type>] --add [--stdin] name [value]
 'git config' [<file-option>] [--type=<type>] --replace-all name value [value_regex]
 'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get name [value_regex]
 'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get-all name [value_regex]
@@ -212,6 +212,9 @@ Valid `<type>`'s include:
 	output without getting confused e.g. by values that
 	contain line breaks.
 
+--stdin::
+	Instead passing in the value as argument, read the value from stdin.
+
 --name-only::
 	Output only the names of config variables for `--list` or
 	`--get-regexp`.
diff --git a/builtin/config.c b/builtin/config.c
index 98d65bc0ad..ea6fb0168c 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -30,6 +30,7 @@ static struct git_config_source given_config_source;
 static int actions, type;
 static char *default_value;
 static int end_null;
+static int stdin_input;
 static int respect_includes_opt = -1;
 static struct config_options config_options;
 static int show_origin;
@@ -152,6 +153,7 @@ static struct option builtin_config_options[] = {
 	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
+	OPT_BOOL(0, "stdin", &stdin_input, N_("allow input from stdin when setting a value")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
@@ -719,6 +721,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_builtin_config();
 	}
 
+	if (actions != ACTION_ADD && stdin_input)
+		die(_("--stdin has to be combined with --add"));
+
 	if (actions & PAGING_ACTIONS)
 		setup_auto_pager("config", 1);
 
@@ -784,8 +789,22 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 	else if (actions == ACTION_ADD) {
 		check_write();
-		check_argc(argc, 2, 2);
-		value = normalize_value(argv[0], argv[1]);
+
+		if (stdin_input) {
+			struct strbuf input = STRBUF_INIT;
+			check_argc(argc, 1, 1);
+			if (strbuf_read_once(&input, 0, 1000) < 0)
+				die_errno("could not read from stdin");
+
+			strbuf_trim_trailing_newline(&input);
+			value = normalize_value(argv[0], input.buf);
+			strbuf_release(&input);
+		}
+		else {
+			check_argc(argc, 2, 2);
+			value = normalize_value(argv[0], argv[1]);
+		}
+
 		UNLEAK(value);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], value,
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 428177c390..d78abf85ee 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -380,6 +380,17 @@ test_expect_success '--add' '
 	test_cmp expect output
 '
 
+test_expect_success '--add with --stdin' '
+	echo true | git config --add --stdin foo.mepmep &&
+	git config --get foo.mepmep >output &&
+	echo true >expect &&
+	test_cmp expect output
+'
+
+test_expect_success '--stdin without --add' '
+	test_expect_code 128 git config --stdin foo.mepmep
+'
+
 cat > .git/config << EOF
 [novalue]
 	variable
-- 
2.23.0

