Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FB2F1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 21:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933675AbcHJVRQ (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 17:17:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:7585 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933659AbcHJVRN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 17:17:13 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP; 10 Aug 2016 14:17:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,501,1464678000"; 
   d="scan'208";a="153862801"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by fmsmga004.fm.intel.com with ESMTP; 10 Aug 2016 14:17:12 -0700
From:	Jacob Keller <jacob.e.keller@intel.com>
To:	git@vger.kernel.org
Cc:	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 1/2] diff: add --line-prefix option for passing in a prefix
Date:	Wed, 10 Aug 2016 14:17:09 -0700
Message-Id: <20160810211710.23173-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.9.2.872.g0b694e0.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

This will be used by a future patch which implements a diff mode for
submodule display. Without this, the diff output would incorrectly
display when using both -p and --graph during a git-log.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
As suggested by Junio, I implemented --line-prefix to enable the graph
display correctly. This works by a neat trick of adding to the msgbuf,
so no code needs to be altered. I presumed that the line prefix should
go *after* the graphs own prefix.

 Documentation/diff-options.txt |  3 +++
 diff.c                         | 12 +++++++++++-
 diff.h                         |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 705a87394200..e7b729f3644f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -569,5 +569,8 @@ endif::git-format-patch[]
 --no-prefix::
 	Do not show any source or destination prefix.
 
+--line-prefix=<prefix>::
+	Prepend an additional prefix to every diff output line.
+
 For more detailed explanation on these common options, see also
 linkgit:gitdiffcore[7].
diff --git a/diff.c b/diff.c
index b43d3dd2ecb7..6fe5c6d084a3 100644
--- a/diff.c
+++ b/diff.c
@@ -1167,10 +1167,16 @@ const char *diff_get_color(int diff_use_color, enum color_diff ix)
 const char *diff_line_prefix(struct diff_options *opt)
 {
 	struct strbuf *msgbuf;
+
 	if (!opt->output_prefix)
-		return "";
+		if (opt->line_prefix)
+			return opt->line_prefix;
+		else
+			return "";
 
 	msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
+	if (opt->line_prefix)
+		strbuf_addstr(msgbuf, opt->line_prefix);
 	return msgbuf->buf;
 }
 
@@ -3966,6 +3972,10 @@ int diff_opt_parse(struct diff_options *options,
 		options->a_prefix = optarg;
 		return argcount;
 	}
+	else if ((argcount = parse_long_opt("line-prefix", av, &optarg))) {
+		options->line_prefix = optarg;
+		return argcount;
+	}
 	else if ((argcount = parse_long_opt("dst-prefix", av, &optarg))) {
 		options->b_prefix = optarg;
 		return argcount;
diff --git a/diff.h b/diff.h
index 125447be09eb..6a91a1139686 100644
--- a/diff.h
+++ b/diff.h
@@ -115,6 +115,7 @@ struct diff_options {
 	const char *pickaxe;
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
+	const char *line_prefix;
 	unsigned flags;
 	unsigned touched_flags;
 
-- 
2.9.2.872.g0b694e0.dirty

