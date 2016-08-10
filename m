Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC391FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 23:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbcHJXTi (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 19:19:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:10309 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbcHJXTh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 19:19:37 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 10 Aug 2016 16:19:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,502,1464678000"; 
   d="scan'208";a="1023347051"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by fmsmga001.fm.intel.com with ESMTP; 10 Aug 2016 16:19:10 -0700
From:	Jacob Keller <jacob.e.keller@intel.com>
To:	git@vger.kernel.org
Cc:	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v4 1/2] diff: add --line-prefix option for passing in a prefix
Date:	Wed, 10 Aug 2016 16:19:07 -0700
Message-Id: <20160810231908.26330-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.9.2.872.g2dc3c84
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

This will be used by a future patch which implements a diff mode for
submodule display. Without this, the diff output would incorrectly
display when using both -p and --graph during a git-log.

Note that the --line-prefix will be displayed first prior to any other
output prefix.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/diff-options.txt |  3 +++
 diff.c                         | 13 ++++++++++++-
 diff.h                         |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

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
index b43d3dd2ecb7..6fa9668b19e5 100644
--- a/diff.c
+++ b/diff.c
@@ -1167,10 +1167,17 @@ const char *diff_get_color(int diff_use_color, enum color_diff ix)
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
+	/* line prefix must be printed before the output_prefix() */
+	if (opt->line_prefix)
+		strbuf_insert(msgbuf, 0, opt->line_prefix, strlen(opt->line_prefix));
 	return msgbuf->buf;
 }
 
@@ -3966,6 +3973,10 @@ int diff_opt_parse(struct diff_options *options,
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
2.9.2.872.g2dc3c84

