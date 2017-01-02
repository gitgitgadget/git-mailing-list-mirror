Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C80205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 23:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755926AbdABXcQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 18:32:16 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:22491 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753711AbdABXb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 18:31:26 -0500
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v02NVNUr016110
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jan 2017 23:31:24 GMT
Received: from lenuta.oracle.com (dhcp-ukc1-twvpn-2-vpnpool-10-175-218-77.vpn.oracle.com [10.175.218.77])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v02NVLVJ032176;
        Mon, 2 Jan 2017 23:31:22 GMT
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH] diff: add interhunk context config option
Date:   Tue,  3 Jan 2017 00:31:14 +0100
Message-Id: <20170102233114.20778-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.11.0.1.gaa10c3f
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
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/diff-options.txt | 2 ++
 diff.c                         | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e6215c372..163b65444 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -511,6 +511,8 @@ endif::git-format-patch[]
 --inter-hunk-context=<lines>::
 	Show the context between diff hunks, up to the specified number
 	of lines, thereby fusing hunks that are close to each other.
+	Defaults to `diff.interhunkcontext` or 0 if the config option
+	is unset.
 
 -W::
 --function-context::
diff --git a/diff.c b/diff.c
index 84dba60c4..40b4e6afe 100644
--- a/diff.c
+++ b/diff.c
@@ -33,6 +33,7 @@ static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
 static int diff_context_default = 3;
+static int diff_interhunk_context_default = 0;
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
 
-- 
2.11.0.1.gaa10c3f

