Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DDE82035F
	for <e@80x24.org>; Wed, 31 Aug 2016 23:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933166AbcHaXbR (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 19:31:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:22370 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754571AbcHaX3j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 19:29:39 -0400
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP; 31 Aug 2016 16:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,264,1470726000"; 
   d="scan'208";a="3559538"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by orsmga004.jf.intel.com with ESMTP; 31 Aug 2016 16:27:29 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v12 2/8] diff.c: remove output_prefix_length field
Date:   Wed, 31 Aug 2016 16:27:19 -0700
Message-Id: <20160831232725.28205-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc2.311.g2bd286e
In-Reply-To: <20160831232725.28205-1-jacob.e.keller@intel.com>
References: <20160831232725.28205-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

"diff/log --stat" has a logic that determines the display columns
available for the diffstat part of the output and apportions it for
pathnames and diffstat graph automatically.

5e71a84a (Add output_prefix_length to diff_options, 2012-04-16)
added the output_prefix_length field to diff_options structure to
allow this logic to subtract the display columns used for the
history graph part from the total "terminal width"; this matters
when the "git log --graph -p" option is in use.

The field must be set to the number of display columns needed to
show the output from the output_prefix() callback, which is error
prone.  As there is only one user of the field, and the user has the
actual value of the prefix string, let's get rid of the field and
have the user count the display width itself.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c  | 2 +-
 diff.h  | 1 -
 graph.c | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index b43d3dd2ecb7..ae069c303077 100644
--- a/diff.c
+++ b/diff.c
@@ -1625,7 +1625,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 */
 
 	if (options->stat_width == -1)
-		width = term_columns() - options->output_prefix_length;
+		width = term_columns() - strlen(line_prefix);
 	else
 		width = options->stat_width ? options->stat_width : 80;
 	number_width = decimal_width(max_change) > number_width ?
diff --git a/diff.h b/diff.h
index 125447be09eb..49e4aaafb2da 100644
--- a/diff.h
+++ b/diff.h
@@ -174,7 +174,6 @@ struct diff_options {
 	diff_format_fn_t format_callback;
 	void *format_callback_data;
 	diff_prefix_fn_t output_prefix;
-	int output_prefix_length;
 	void *output_prefix_data;
 
 	int diff_path_counter;
diff --git a/graph.c b/graph.c
index dd1720148dc5..a46803840511 100644
--- a/graph.c
+++ b/graph.c
@@ -197,7 +197,6 @@ static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void
 	assert(opt);
 	assert(graph);
 
-	opt->output_prefix_length = graph->width;
 	strbuf_reset(&msgbuf);
 	graph_padding_line(graph, &msgbuf);
 	return &msgbuf;
@@ -245,7 +244,6 @@ struct git_graph *graph_init(struct rev_info *opt)
 	 */
 	opt->diffopt.output_prefix = diff_output_prefix_callback;
 	opt->diffopt.output_prefix_data = graph;
-	opt->diffopt.output_prefix_length = 0;
 
 	return graph;
 }
-- 
2.10.0.rc2.311.g2bd286e

