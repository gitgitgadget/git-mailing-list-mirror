Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C3961F406
	for <e@80x24.org>; Wed,  3 Jan 2018 21:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeACVrv (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 16:47:51 -0500
Received: from siwi.pair.com ([209.68.5.199]:65525 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751014AbeACVrr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 16:47:47 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D9040844E1;
        Wed,  3 Jan 2018 16:47:46 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6E33A844DC;
        Wed,  3 Jan 2018 16:47:46 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 5/5] status: add status.aheadBehind value for porcelain output
Date:   Wed,  3 Jan 2018 21:47:33 +0000
Message-Id: <20180103214733.797-6-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180103214733.797-1-git@jeffhostetler.com>
References: <20180103214733.797-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add status.aheadBehind=2 value to enable --no-ahead-behind
for all formats (both porcelain and non-porcelain).  The
current boolean values only affect non-porcelain formats.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/config.txt |  5 +++++
 builtin/commit.c         | 31 +++++++++++++++++++++++++------
 remote.h                 |  8 ++++++++
 t/t6040-tracking-info.sh |  9 +++++++++
 t/t7064-wtstatus-pv2.sh  |  6 +++++-
 5 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index affb0d6..eaa1058 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3040,6 +3040,11 @@ status.aheadBehind::
 	--no-ahead-behind by default in linkgit:git-status[1] for
 	non-porcelain formats.  This setting is ignored by porcelain
 	formats for backwards compatibility.
++
+(EXPERIMENTAL) Set to 2 to allow both porcelain and non-porcelain
+formats to inherit --no-ahead-behind.  This may break backward
+compatibility for scripts using porcelain status formats and expecting
+ahead/behind information in the output.
 
 status.displayCommentPrefix::
 	If set to true, linkgit:git-status[1] will insert a comment
diff --git a/builtin/commit.c b/builtin/commit.c
index 416fe2c..194a6eb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1109,13 +1109,32 @@ static const char *read_commit_message(const char *name)
 static struct status_deferred_config {
 	enum wt_status_format status_format;
 	int show_branch;
-	enum ahead_behind_flags ahead_behind;
+	enum ahead_behind_config_flags ahead_behind_config;
 } status_deferred_config = {
 	STATUS_FORMAT_UNSPECIFIED,
 	-1, /* unspecified */
 	AHEAD_BEHIND_UNSPECIFIED,
 };
 
+static inline enum ahead_behind_flags inherit_deferred_ab_flags(
+	int is_porcelain)
+{
+	switch (status_deferred_config.ahead_behind_config) {
+	case AHEAD_BEHIND_CONFIG_UNSPECIFIED:
+	case AHEAD_BEHIND_CONFIG_FULL:
+		return AHEAD_BEHIND_FULL;
+
+	case AHEAD_BEHIND_CONFIG_QUICK2:
+		return AHEAD_BEHIND_QUICK;
+
+	case AHEAD_BEHIND_CONFIG_QUICK:
+		return is_porcelain ? AHEAD_BEHIND_FULL : AHEAD_BEHIND_QUICK;
+
+	default: /* don't complain about bogus config settings */
+		return AHEAD_BEHIND_FULL;
+	}
+}
+
 static void finalize_deferred_config(struct wt_status *s)
 {
 	int use_deferred_config = (status_format != STATUS_FORMAT_PORCELAIN &&
@@ -1140,11 +1159,9 @@ static void finalize_deferred_config(struct wt_status *s)
 	if (s->show_branch < 0)
 		s->show_branch = 0;
 
-	if (use_deferred_config &&
-	    s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
-		s->ahead_behind_flags = status_deferred_config.ahead_behind;
 	if (s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
-		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
+		s->ahead_behind_flags =
+			inherit_deferred_ab_flags(!use_deferred_config);
 }
 
 static int parse_and_validate_options(int argc, const char *argv[],
@@ -1306,7 +1323,9 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 	if (!strcmp(k, "status.aheadbehind")) {
-		status_deferred_config.ahead_behind = git_config_bool(k, v);
+		int is_bool;
+		status_deferred_config.ahead_behind_config =
+			git_config_bool_or_int(k, v, &is_bool);
 		return 0;
 	}
 	if (!strcmp(k, "status.showstash")) {
diff --git a/remote.h b/remote.h
index b2fa5cc..bcf846a 100644
--- a/remote.h
+++ b/remote.h
@@ -262,6 +262,14 @@ enum ahead_behind_flags {
 	AHEAD_BEHIND_FULL        =  1,  /* traditional a/b reporting */
 };
 
+/* Flags for status.aheadBehind values. */
+enum ahead_behind_config_flags {
+	AHEAD_BEHIND_CONFIG_UNSPECIFIED = -1,
+	AHEAD_BEHIND_CONFIG_QUICK       =  0, /* eq/neq for non-porcelain only */
+	AHEAD_BEHIND_CONFIG_FULL        =  1, /* a/b reporting for all formats */
+	AHEAD_BEHIND_CONFIG_QUICK2      =  2, /* eq/neq for all formats */
+};
+
 /* Reporting of tracking info */
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 		       const char **upstream_name, enum ahead_behind_flags abf);
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index febf63f..5003366 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -219,6 +219,15 @@ test_expect_success 'status.aheadbehind=false status --long --branch' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'status.aheadbehind=2 status --long --branch' '
+	(
+		cd test &&
+		git checkout b1 >/dev/null &&
+		git -c status.aheadbehind=false status --long -b | head -2
+	) >actual &&
+	test_i18ncmp expect actual
+'
+
 cat >expect <<\EOF
 ## b5...brokenbase [gone]
 EOF
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 67b90cd..7171a43 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -410,6 +410,10 @@ test_expect_success 'verify --[no-]ahead-behind with V2 format' '
 		git status --no-ahead-behind --porcelain=v2 --branch --untracked-files=all >actual &&
 		test_cmp expect actual &&
 
+		# Confirm that porcelain=v2 format inherits status.aheadBehind value when _QUICK2.
+		git -c status.aheadbehind=2 status --porcelain=v2 --branch --untracked-files=all >actual &&
+		test_cmp expect actual &&
+
 		# Confirm --ahead-behind reports traditional branch.ab with 0/0.
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
@@ -421,7 +425,7 @@ test_expect_success 'verify --[no-]ahead-behind with V2 format' '
 		git status --ahead-behind --porcelain=v2 --branch --untracked-files=all >actual &&
 		test_cmp expect actual &&
 
-		# Confirm that porcelain=v2 format does not inherit status.aheadBehind value.
+		# Confirm that porcelain=v2 format does not inherit status.aheadBehind value when _FULL/_QUICK.
 		git -c status.aheadbehind=false status --porcelain=v2 --branch --untracked-files=all >actual &&
 		test_cmp expect actual &&
 
-- 
2.9.3

