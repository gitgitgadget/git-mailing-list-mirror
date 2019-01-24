Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B33B1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 12:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfAXMdx (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 07:33:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:47114 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726105AbfAXMdx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 07:33:53 -0500
Received: (qmail 25832 invoked by uid 109); 24 Jan 2019 12:33:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 12:33:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27974 invoked by uid 111); 24 Jan 2019 12:33:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 07:33:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 07:33:51 -0500
Date:   Thu, 24 Jan 2019 07:33:51 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     David Turner <novalis@novalis.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/6] combine-diff: factor out stat-format mask
Message-ID: <20190124123350.GC11354@sigill.intra.peff.net>
References: <20190124122603.GA10415@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124122603.GA10415@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several conditionals in the combine diff code that check if
we're doing --stat or --numstat output. Since these must all remain in
sync, let's pull them out into a separate bit-mask.

Arguably this could go into diff.h along with the other DIFF_FORMAT
macros, but it's not clear that the definition of "which formats are
stat" is universal (e.g., does --dirstat count? --summary?). So let's
keep this local to combine-diff.c, where the meaning is more clearly
"stat formats that combine-diff supports".

Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index a143c00634..b1d259d5a0 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1321,6 +1321,11 @@ static const char *path_path(void *obj)
 	return path->path;
 }
 
+/*
+ * Diff stat formats which we always compute solely against the first parent.
+ */
+#define STAT_FORMAT_MASK (DIFF_FORMAT_NUMSTAT \
+			  | DIFF_FORMAT_DIFFSTAT)
 
 /* find set of paths that every parent touches */
 static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
@@ -1342,8 +1347,7 @@ static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
 		 * show stat against the first parent even when doing
 		 * combined diff.
 		 */
-		int stat_opt = (output_format &
-				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT));
+		int stat_opt = output_format & STAT_FORMAT_MASK;
 		if (i == 0 && stat_opt)
 			opt->output_format = stat_opt;
 		else
@@ -1470,8 +1474,7 @@ void diff_tree_combined(const struct object_id *oid,
 		 * show stat against the first parent even
 		 * when doing combined diff.
 		 */
-		stat_opt = (opt->output_format &
-				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT));
+		stat_opt = opt->output_format & STAT_FORMAT_MASK;
 		if (stat_opt) {
 			diffopts.output_format = stat_opt;
 
@@ -1515,8 +1518,7 @@ void diff_tree_combined(const struct object_id *oid,
 				show_raw_diff(p, num_parent, rev);
 			needsep = 1;
 		}
-		else if (opt->output_format &
-			 (DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT))
+		else if (opt->output_format & STAT_FORMAT_MASK)
 			needsep = 1;
 		else if (opt->output_format & DIFF_FORMAT_CALLBACK)
 			handle_combined_callback(opt, paths, num_parent, num_paths);
-- 
2.20.1.842.g8986705066

