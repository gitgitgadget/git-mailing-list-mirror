Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB47D20985
	for <e@80x24.org>; Tue, 13 Sep 2016 03:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754803AbcIMDYB (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:24:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:42311 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750975AbcIMDYA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:24:00 -0400
Received: (qmail 20368 invoked by uid 109); 13 Sep 2016 03:24:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 03:24:00 +0000
Received: (qmail 18566 invoked by uid 111); 13 Sep 2016 03:24:09 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 23:24:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 20:23:56 -0700
Date:   Mon, 12 Sep 2016 20:23:56 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 11/16] pager: handle early config
Message-ID: <20160913032356.mj6q5qv6kllbcdfb@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pager code is often run early in the git.c startup,
before we have actually found the repository. When we ask
git_config() to look for values like core.pager, it doesn't
know where to find the repo-level config, and will blindly
examine ".git/config" if it exists. That's why t7006 shows
that many pager-related features happen to work from the
top-level of a repository, but not from a subdirectory.

This patch pulls that ".git/config" hack explicitly into the
pager code. There are two reasons for this:

  1. We'd like to clean up the git_config() behavior, as
     looking at ".git/config" when we do not have a
     configured repository is often the wrong thing to do.
     But we'd prefer not to break the pager config any worse
     than it already is.

  2. It's one very tiny step on the road to ultimately
     making the pager config work consistently. If we
     eventually get an equivalent of setup_git_directory()
     that _just_ finds the directory and doesn't chdir() or
     set up any global state, we could plug it in here
     (instead of blindly looking at ".git/config").

Signed-off-by: Jeff King <peff@peff.net>
---
 pager.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/pager.c b/pager.c
index 46cc411..ae79643 100644
--- a/pager.c
+++ b/pager.c
@@ -43,6 +43,37 @@ static int core_pager_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
+static void read_early_config(config_fn_t cb, void *data)
+{
+	git_config_with_options(cb, data, NULL, 1);
+
+	/*
+	 * Note that this is a really dirty hack that does the wrong thing in
+	 * many cases. The crux of the problem is that we cannot run
+	 * setup_git_directory() early on in git's setup, so we have no idea if
+	 * we are in a repository or not, and therefore are not sure whether
+	 * and how to read repository-local config.
+	 *
+	 * So if we _aren't_ in a repository (or we are but we would reject its
+	 * core.repositoryformatversion), we'll read whatever is in .git/config
+	 * blindly. Similarly, if we _are_ in a repository, but not at the
+	 * root, we'll fail to find .git/config (because it's really
+	 * ../.git/config, etc). See t7006 for a complete set of failures.
+	 *
+	 * However, we have historically provided this hack because it does
+	 * work some of the time (namely when you are at the top-level of a
+	 * valid repository), and would rarely make things worse (i.e., you do
+	 * not generally have a .git/config file sitting around).
+	 */
+	if (!startup_info->have_repository) {
+		struct git_config_source repo_config;
+
+		memset(&repo_config, 0, sizeof(repo_config));
+		repo_config.file = ".git/config";
+		git_config_with_options(cb, data, &repo_config, 1);
+	}
+}
+
 const char *git_pager(int stdout_is_tty)
 {
 	const char *pager;
@@ -53,7 +84,7 @@ const char *git_pager(int stdout_is_tty)
 	pager = getenv("GIT_PAGER");
 	if (!pager) {
 		if (!pager_program)
-			git_config(core_pager_config, NULL);
+			read_early_config(core_pager_config, NULL);
 		pager = pager_program;
 	}
 	if (!pager)
@@ -216,7 +247,7 @@ int check_pager_config(const char *cmd)
 	data.want = -1;
 	data.value = NULL;
 
-	git_config(pager_command_config, &data);
+	read_early_config(pager_command_config, &data);
 
 	if (data.value)
 		pager_program = data.value;
-- 
2.10.0.230.g6f8d04b

