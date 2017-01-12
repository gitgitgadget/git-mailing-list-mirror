Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750C91FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 12:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbdALMVm (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 07:21:42 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:50508 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdALMVk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 07:21:40 -0500
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v0CCLaYK003533
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2017 12:21:36 GMT
Received: from t460.home (dhcp-ukc1-twvpn-2-vpnpool-10-175-196-185.vpn.oracle.com [10.175.196.185])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v0CCLYVe020392;
        Thu, 12 Jan 2017 12:21:35 GMT
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v2] diff: add interhunk context config option
Date:   Thu, 12 Jan 2017 13:21:11 +0100
Message-Id: <1484223671-5476-1-git-send-email-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --inter-hunk-context= option was added in commit 6d0e674a5754
("diff: add option to show context between close hunks"). This patch
allows configuring a default for this option.

Cc: René Scharfe <l.s.r@web.de>
Cc: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

---
v2:
 - Update Documentation/diff-config.txt, suggested by Pranit Bauva.
 - Add tests, suggested by Pranit Bauva.
 - Don't initialize BSS variable to 0, suggested by Junio Hamano.
 - Junio: if git_config_int() fails, you will get something like:
   "fatal: bad config variable 'diff.interhunkcontext' in file '/home/vegard/.gitconfig' at line 5"
---
 Documentation/diff-config.txt      |  6 ++++++
 Documentation/diff-options.txt     |  2 ++
 diff.c                             |  8 ++++++++
 t/t4032-diff-inter-hunk-context.sh | 27 ++++++++++++++++++++++++++-
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 58f4bd6..d8cd854 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -60,6 +60,12 @@ diff.context::
 	Generate diffs with <n> lines of context instead of the default
 	of 3. This value is overridden by the -U option.
 
+diff.interHunkContext::
+	Show the context between diff hunks, up to <n> lines, thereby
+	fusing the hunks that are close to each other. The default is 0,
+	meaning no fusing will occur. This value is overridden by the
+	--inter-hunk-context option.
+
 diff.external::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e6215c3..a219aa2 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -511,6 +511,8 @@ endif::git-format-patch[]
 --inter-hunk-context=<lines>::
 	Show the context between diff hunks, up to the specified number
 	of lines, thereby fusing hunks that are close to each other.
+	Defaults to `diff.interHunkContext` or 0 if the config option
+	is unset.
 
 -W::
 --function-context::
diff --git a/diff.c b/diff.c
index 84dba60..a92080c 100644
--- a/diff.c
+++ b/diff.c
@@ -33,6 +33,7 @@ static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
 static int diff_context_default = 3;
+static int diff_interhunk_context_default;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
 static const char *diff_order_file_cfg;
@@ -248,6 +249,12 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 			return -1;
 		return 0;
 	}
+	if (!strcmp(var, "diff.interhunkcontext")) {
+		diff_interhunk_context_default = git_config_int(var, value);
+		if (diff_interhunk_context_default < 0)
+			return -1;
+		return 0;
+	}
 	if (!strcmp(var, "diff.renames")) {
 		diff_detect_rename_default = git_config_rename(var, value);
 		return 0;
@@ -3371,6 +3378,7 @@ void diff_setup(struct diff_options *options)
 	options->rename_limit = -1;
 	options->dirstat_permille = diff_dirstat_permille_default;
 	options->context = diff_context_default;
+	options->interhunkcontext = diff_interhunk_context_default;
 	options->ws_error_highlight = ws_error_highlight_default;
 	DIFF_OPT_SET(options, RENAME_EMPTY);
 
diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
index e4e3e28..d9ac9d1 100755
--- a/t/t4032-diff-inter-hunk-context.sh
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -16,11 +16,15 @@ f() {
 }
 
 t() {
+	use_config=""
+	git config --unset diff.interHunkContext
+
 	case $# in
 	4) hunks=$4; cmd="diff -U$3";;
 	5) hunks=$5; cmd="diff -U$3 --inter-hunk-context=$4";;
+	6) hunks=$5; cmd="diff -U$3"; git config diff.interHunkContext $4; use_config="(diff.interHunkContext=$4) ";;
 	esac
-	label="$cmd, $1 common $2"
+	label="$use_config$cmd, $1 common $2"
 	file=f$1
 	expected=expected.$file.$3.$hunks
 
@@ -89,4 +93,25 @@ t 9 lines	3		2
 t 9 lines	3	2	2
 t 9 lines	3	3	1
 
+#					use diff.interHunkContext?
+t 1 line	0	0	2	config
+t 1 line	0	1	1	config
+t 1 line	0	2	1	config
+t 9 lines	3	3	1	config
+t 2 lines	0	0	2	config
+t 2 lines	0	1	2	config
+t 2 lines	0	2	1	config
+t 3 lines	1	0	2	config
+t 3 lines	1	1	1	config
+t 3 lines	1	2	1	config
+t 9 lines	3	2	2	config
+t 9 lines	3	3	1	config
+
+test_expect_success 'diff.interHunkContext invalid' '
+	git config diff.interHunkContext asdf &&
+	test_must_fail git diff &&
+	git config diff.interHunkContext -1 &&
+	test_must_fail git diff
+'
+
 test_done
-- 
2.7.4

