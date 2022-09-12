Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9287ECAAA1
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 05:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiILFwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 01:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiILFwb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 01:52:31 -0400
X-Greylist: delayed 424 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Sep 2022 22:52:29 PDT
Received: from mailproxy04.manitu.net (mailproxy04.manitu.net [IPv6:2a00:1828:1000:1109::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C5E252A3
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 22:52:29 -0700 (PDT)
Received: from localhost (p200300ef4f07e90026418cfffe37d02a.dip0.t-ipconnect.de [IPv6:2003:ef:4f07:e900:2641:8cff:fe37:d02a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: u16723@rkita.de)
        by mailproxy04.manitu.net (Postfix) with ESMTPSA id 9813A804E2;
        Mon, 12 Sep 2022 07:45:21 +0200 (CEST)
From:   Rene Kita <mail@rkta.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH 1/2] blame: Make --show-name negatable
Date:   Mon, 12 Sep 2022 07:45:14 +0200
Message-Id: <20220912054515.29559-2-mail@rkta.de>
X-Mailer: git-send-email 2.37.3.544.g5c9b9c0a4e
In-Reply-To: <20220912054515.29559-1-mail@rkta.de>
References: <20220912054515.29559-1-mail@rkta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Øystein Walle <oystwa@gmail.com>

Signed-off-by: Øystein Walle <oystwa@gmail.com>
---
 builtin/blame.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index a9fe8cf7a6..cbaae91a8f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -49,6 +49,7 @@ static int blank_boundary;
 static int incremental;
 static int xdl_opts;
 static int abbrev = -1;
+static int show_name = -1;
 static int no_whole_file_rename;
 static int show_progress;
 static char repeated_meta_color[COLOR_MAXLEN];
@@ -621,7 +622,8 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
 		if (compute_auto_abbrev)
 			auto_abbrev = update_auto_abbrev(auto_abbrev, suspect);
 		if (strcmp(suspect->path, sb->path))
-			*option |= OUTPUT_SHOW_NAME;
+			if (show_name == -1)
+				*option |= OUTPUT_SHOW_NAME;
 		num = strlen(suspect->path);
 		if (longest_file < num)
 			longest_file = num;
@@ -867,7 +869,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "show-stats", &show_stats, N_("show work cost statistics")),
 		OPT_BOOL(0, "progress", &show_progress, N_("force progress reporting")),
 		OPT_BIT(0, "score-debug", &output_option, N_("show output score for blame entries"), OUTPUT_SHOW_SCORE),
-		OPT_BIT('f', "show-name", &output_option, N_("show original filename (Default: auto)"), OUTPUT_SHOW_NAME),
+		OPT_BOOL('f', "show-name", &show_name, N_("show original filename (Default: auto)")),
 		OPT_BIT('n', "show-number", &output_option, N_("show original linenumber (Default: off)"), OUTPUT_SHOW_NUMBER),
 		OPT_BIT('p', "porcelain", &output_option, N_("show in a format designed for machine consumption"), OUTPUT_PORCELAIN),
 		OPT_BIT(0, "line-porcelain", &output_option, N_("show porcelain format with per-line commit information"), OUTPUT_PORCELAIN|OUTPUT_LINE_PORCELAIN),
@@ -943,6 +945,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	revs.diffopt.flags.follow_renames = 0;
 	argc = parse_options_end(&ctx);
 
+	if (show_name == 1)
+		output_option |= OUTPUT_SHOW_NAME;
+
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-- 
2.37.3.544.g5c9b9c0a4e

