Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D3AC433E1
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D552071C
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgEYV6D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 17:58:03 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:64145 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgEYV6C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 17:58:02 -0400
Received: from localhost.localdomain ([89.243.191.101])
        by smtp.talktalk.net with SMTP
        id dL6djC8oOIndsdL6ejhPZn; Mon, 25 May 2020 22:58:00 +0100
X-Originating-IP: [89.243.191.101]
X-Spam: 0
X-OAuthority: v=2.3 cv=QYIYQfTv c=1 sm=1 tr=0 a=5KGm1Kp77X3djDixdaHiLg==:117
 a=5KGm1Kp77X3djDixdaHiLg==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=ZCRl24wqHeiA8RQ32E4A:9
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
From:   Philip Oakley <philipoakley@iee.email>
To:     git@vger.kernel.org
Subject: [PATCH 2/4] blame: add option to show only blamed commits `--blame-only`
Date:   Mon, 25 May 2020 22:57:49 +0100
Message-Id: <20200525215751.1735-3-philipoakley@iee.email>
X-Mailer: git-send-email 2.26.2.windows.1.13.g9dddff6983
In-Reply-To: <20200525215751.1735-1-philipoakley@iee.email>
References: <20200525215751.1735-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIegZ2fgzUsizcTil/8DQ9rxdXgn30ulXqPed8sdVaX5AGlnLCLsAxoyfzuPPPTlx0QnZ+VfjWe06qkWsio26m2cwdRq1DFDY9hya0+lP8KkZP5uZlJY
 cYpzWw5KCkMFrT+6RxZhFdYX3Cv3+fQj0KgwR48YoedDizgTnUZhy6rbrMeqAJhVR6vKAdQDCEb9EA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For large files the will be many lines which are not blamed with the
revision range or date period which clutter the output.

Add an option to suppress the display of boundary commits lines, not
just the object id (`-b` option).

This is non-functional at this stage. The next commit will add
functionality, tests, and documenation.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/blame-options.txt | 4 ++++
 Documentation/git-blame.txt     | 2 +-
 builtin/blame.c                 | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 5d122db6e9..b4b27033a6 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -2,6 +2,10 @@
 	Show blank SHA-1 for boundary commits.  This can also
 	be controlled via the `blame.blankboundary` config option.
 
+--blame-only::
+	Do not show any boundary commit lines created by revision range
+	specifiers. Only show blamed lines.
+
 --root::
 	Do not treat root commits as boundaries.  This can also be
 	controlled via the `blame.showRoot` config option.
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 02f9ad6fe9..74b6344c7b 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
-	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
+	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>] [--blame-only]
 	    [--ignore-rev <rev>] [--ignore-revs-file <file>]
 	    [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>..<rev>]
 	    [--] <file>
diff --git a/builtin/blame.c b/builtin/blame.c
index bf1cecdf3f..b699c777c4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -45,6 +45,7 @@ static int max_score_digits;
 static int show_root;
 static int reverse;
 static int blank_boundary;
+static int blame_only;
 static int incremental;
 static int xdl_opts;
 static int abbrev = -1;
@@ -843,6 +844,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	const struct option options[] = {
 		OPT_BOOL(0, "incremental", &incremental, N_("Show blame entries as we find them, incrementally")),
 		OPT_BOOL('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: off)")),
+		OPT_BOOL(0, "blame-only", &blame_only, N_("Only show blamed commits (Default: off)")),
 		OPT_BOOL(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
 		OPT_BOOL(0, "show-stats", &show_stats, N_("Show work cost statistics")),
 		OPT_BOOL(0, "progress", &show_progress, N_("Force progress reporting")),
-- 
2.26.2.windows.1.13.g9dddff6983

