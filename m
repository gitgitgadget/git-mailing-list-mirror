Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7878A1F404
	for <e@80x24.org>; Wed, 20 Dec 2017 14:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755441AbdLTOnH (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 09:43:07 -0500
Received: from siwi.pair.com ([209.68.5.199]:62727 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755301AbdLTOm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 09:42:58 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 709C2845E9;
        Wed, 20 Dec 2017 09:42:57 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 09933845D4;
        Wed, 20 Dec 2017 09:42:56 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 4/4] status: support --no-ahead-behind in long status format.
Date:   Wed, 20 Dec 2017 14:42:45 +0000
Message-Id: <20171220144245.39401-5-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171220144245.39401-1-git@jeffhostetler.com>
References: <20171220144245.39401-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach long (normal) status format to respect the --no-ahead-behind
argument and skip the possibly expensive ahead/behind computation
when printing the branch tracking information.

When --no-ahead-behind is given or status.noaheadbehind is true,
status prints "Your branch is out of date with '<upstream>'."
instead of the various ahead/behind messages.

TODO Should we have an advice hint for this case?

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git-status.txt |  3 +++
 builtin/checkout.c           |  2 +-
 remote.c                     | 18 +++++++++++++++---
 remote.h                     |  4 +++-
 t/t6040-tracking-info.sh     | 29 +++++++++++++++++++++++++++++
 wt-status.c                  |  2 +-
 6 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index ea029ad..9a2f209 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -120,6 +120,9 @@ configuration variable documented in linkgit:git-config[1].
 +
 	In short format with --branch, '[different]' will printed rather
 	than detailed ahead/behind counts.
++
+	In long (normal) format, a simple out of date message will be
+	printed rather than detailed ahead/behind counts.
 
 <pathspec>...::
 	See the 'pathspec' entry in linkgit:gitglossary[7].
diff --git a/builtin/checkout.c b/builtin/checkout.c
index fc4f8fd..a3e7bde 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -605,7 +605,7 @@ static void report_tracking(struct branch_info *new)
 	struct strbuf sb = STRBUF_INIT;
 	struct branch *branch = branch_get(new->name);
 
-	if (!format_tracking_info(branch, &sb))
+	if (!format_tracking_info(branch, 0, &sb))
 		return;
 	fputs(sb.buf, stdout);
 	strbuf_release(&sb);
diff --git a/remote.c b/remote.c
index 0a63ac1..b75e62f 100644
--- a/remote.c
+++ b/remote.c
@@ -2065,14 +2065,20 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 /*
  * Return true when there is anything to report, otherwise false.
  */
-int format_tracking_info(struct branch *branch, struct strbuf *sb)
+int format_tracking_info(struct branch *branch, int no_ahead_behind,
+			 struct strbuf *sb)
 {
 	int ours, theirs;
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
+	int sti;
 
-	if (stat_tracking_info(branch, &ours, &theirs, &full_base) < 0) {
+	if (no_ahead_behind)
+		sti = stat_tracking_info(branch, NULL, NULL, &full_base);
+	else
+		sti = stat_tracking_info(branch, &ours, &theirs, &full_base);
+	if (sti < 0) {
 		if (!full_base)
 			return 0;
 		upstream_is_gone = 1;
@@ -2086,10 +2092,16 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 		if (advice_status_hints)
 			strbuf_addstr(sb,
 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
-	} else if (!ours && !theirs) {
+	} else if (!sti) {
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
 			base);
+	} else if (no_ahead_behind) {
+		strbuf_addf(sb, _("Your branch is out of date with '%s'.\n"),
+			    base);
+
+		/* TODO Do we need a generic hint here? */
+
 	} else if (!theirs) {
 		strbuf_addf(sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
diff --git a/remote.h b/remote.h
index 2ecf4c8..559649d 100644
--- a/remote.h
+++ b/remote.h
@@ -258,7 +258,9 @@ enum match_refs_flags {
 /* Reporting of tracking info */
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 		       const char **upstream_name);
-int format_tracking_info(struct branch *branch, struct strbuf *sb);
+
+int format_tracking_info(struct branch *branch, int no_ahead_behind,
+			 struct strbuf *sb);
 
 struct ref *get_local_heads(void);
 /*
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0190220..00fbd0a 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -160,6 +160,35 @@ test_expect_success 'status -s -b --no-ahead-behind (diverged from upstream)' '
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
+cat >expect <<\EOF
+On branch b1
+Your branch is out of date with 'origin/master'.
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
+cat >expect <<\EOF
 ## b5...brokenbase [gone]
 EOF
 
diff --git a/wt-status.c b/wt-status.c
index 6b4f969..1e7cd57 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1005,7 +1005,7 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	if (!skip_prefix(s->branch, "refs/heads/", &branch_name))
 		return;
 	branch = branch_get(branch_name);
-	if (!format_tracking_info(branch, &sb))
+	if (!format_tracking_info(branch, s->no_ahead_behind, &sb))
 		return;
 
 	i = 0;
-- 
2.9.3

