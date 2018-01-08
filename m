Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE451FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 15:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934257AbeAHPsm (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 10:48:42 -0500
Received: from siwi.pair.com ([209.68.5.199]:31668 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934188AbeAHPse (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 10:48:34 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A57AE844D1;
        Mon,  8 Jan 2018 10:48:33 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1AB8D844CB;
        Mon,  8 Jan 2018 10:48:33 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 4/4] status: support --no-ahead-behind in long format
Date:   Mon,  8 Jan 2018 15:48:22 +0000
Message-Id: <20180108154822.54829-5-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180108154822.54829-1-git@jeffhostetler.com>
References: <20180108154822.54829-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach long (normal) status format to respect the --no-ahead-behind
parameter and skip the possibly expensive ahead/behind computation
between the branch and the upstream.

Long status also respects "status.aheadBehind" config setting.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/checkout.c       |  2 +-
 remote.c                 | 18 +++++++++++++-----
 remote.h                 |  3 ++-
 t/t6040-tracking-info.sh | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c              |  2 +-
 5 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index fc4f8fd..655dac2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -605,7 +605,7 @@ static void report_tracking(struct branch_info *new)
 	struct strbuf sb = STRBUF_INIT;
 	struct branch *branch = branch_get(new->name);
 
-	if (!format_tracking_info(branch, &sb))
+	if (!format_tracking_info(branch, &sb, AHEAD_BEHIND_FULL))
 		return;
 	fputs(sb.buf, stdout);
 	strbuf_release(&sb);
diff --git a/remote.c b/remote.c
index 2486afb..e668091 100644
--- a/remote.c
+++ b/remote.c
@@ -2066,15 +2066,16 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 /*
  * Return true when there is anything to report, otherwise false.
  */
-int format_tracking_info(struct branch *branch, struct strbuf *sb)
+int format_tracking_info(struct branch *branch, struct strbuf *sb,
+			 enum ahead_behind_flags abf)
 {
-	int ours, theirs;
+	int ours, theirs, sti;
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
 
-	if (stat_tracking_info(branch, &ours, &theirs, &full_base,
-			       AHEAD_BEHIND_FULL) < 0) {
+	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, abf);
+	if (sti < 0) {
 		if (!full_base)
 			return 0;
 		upstream_is_gone = 1;
@@ -2088,10 +2089,17 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 		if (advice_status_hints)
 			strbuf_addstr(sb,
 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
-	} else if (!ours && !theirs) {
+	} else if (!sti) {
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
 			base);
+	} else if (abf == AHEAD_BEHIND_QUICK) {
+		strbuf_addf(sb,
+			    _("Your branch and '%s' refer to different commits.\n"),
+			    base);
+		if (advice_status_hints)
+			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
+				    "git status --ahead-behind");
 	} else if (!theirs) {
 		strbuf_addf(sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
diff --git a/remote.h b/remote.h
index 27feb63..b2fa5cc 100644
--- a/remote.h
+++ b/remote.h
@@ -265,7 +265,8 @@ enum ahead_behind_flags {
 /* Reporting of tracking info */
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 		       const char **upstream_name, enum ahead_behind_flags abf);
-int format_tracking_info(struct branch *branch, struct strbuf *sb);
+int format_tracking_info(struct branch *branch, struct strbuf *sb,
+			 enum ahead_behind_flags abf);
 
 struct ref *get_local_heads(void);
 /*
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 053dff3..febf63f 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -173,6 +173,53 @@ test_expect_success 'status.aheadbehind=false status -s -b (diverged from upstre
 '
 
 cat >expect <<\EOF
+On branch b1
+Your branch and 'origin/master' have diverged,
+and have 1 and 1 different commits each, respectively.
+EOF
+
+test_expect_success 'status --long --branch' '
+	(
+		cd test &&
+		git checkout b1 >/dev/null &&
+		git status --long -b | head -3
+	) >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'status --long --branch' '
+	(
+		cd test &&
+		git checkout b1 >/dev/null &&
+		git -c status.aheadbehind=true status --long -b | head -3
+	) >actual &&
+	test_i18ncmp expect actual
+'
+
+cat >expect <<\EOF
+On branch b1
+Your branch and 'origin/master' refer to different commits.
+EOF
+
+test_expect_success 'status --long --branch --no-ahead-behind' '
+	(
+		cd test &&
+		git checkout b1 >/dev/null &&
+		git status --long -b --no-ahead-behind | head -2
+	) >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'status.aheadbehind=false status --long --branch' '
+	(
+		cd test &&
+		git checkout b1 >/dev/null &&
+		git -c status.aheadbehind=false status --long -b | head -2
+	) >actual &&
+	test_i18ncmp expect actual
+'
+
+cat >expect <<\EOF
 ## b5...brokenbase [gone]
 EOF
 
diff --git a/wt-status.c b/wt-status.c
index a4d3470..98d0501 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1006,7 +1006,7 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	if (!skip_prefix(s->branch, "refs/heads/", &branch_name))
 		return;
 	branch = branch_get(branch_name);
-	if (!format_tracking_info(branch, &sb))
+	if (!format_tracking_info(branch, &sb, s->ahead_behind_flags))
 		return;
 
 	i = 0;
-- 
2.9.3

