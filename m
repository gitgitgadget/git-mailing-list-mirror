Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B2A1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 06:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeKBPo1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 11:44:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:37734 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727745AbeKBPo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 11:44:27 -0400
Received: (qmail 29541 invoked by uid 109); 2 Nov 2018 06:38:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Nov 2018 06:38:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1008 invoked by uid 111); 2 Nov 2018 06:37:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Nov 2018 02:37:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2018 02:38:20 -0400
Date:   Fri, 2 Nov 2018 02:38:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/9] combine-diff: use an xdiff hunk callback
Message-ID: <20181102063820.GF31216@sigill.intra.peff.net>
References: <20181102063156.GA30252@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102063156.GA30252@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A combined diff has to line up the hunks for all of the individual
pairwise diffs, and thus needs to know their line numbers and sizes. We
get that now by parsing the hunk header line that xdiff generates.
However, now that xdiff supports a hunk callback, we can just use the
values directly.

Signed-off-by: Jeff King <peff@peff.net>
---
I learned to love --color-moved-ws=allow-indentation-change for this
one.

 combine-diff.c | 67 +++++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 3c479cfc3e..ad7752ea6b 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -345,38 +345,43 @@ struct combine_diff_state {
 	struct sline *lost_bucket;
 };
 
-static void consume_line(void *state_, char *line, unsigned long len)
+static void consume_hunk(void *state_,
+			 long ob, long on,
+			 long nb, long nn,
+			 const char *funcline, long funclen)
 {
 	struct combine_diff_state *state = state_;
-	if (5 < len && !memcmp("@@ -", line, 4)) {
-		if (parse_hunk_header(line, len,
-				      &state->ob, &state->on,
-				      &state->nb, &state->nn))
-			return;
-		state->lno = state->nb;
-		if (state->nn == 0) {
-			/* @@ -X,Y +N,0 @@ removed Y lines
-			 * that would have come *after* line N
-			 * in the result.  Our lost buckets hang
-			 * to the line after the removed lines,
-			 *
-			 * Note that this is correct even when N == 0,
-			 * in which case the hunk removes the first
-			 * line in the file.
-			 */
-			state->lost_bucket = &state->sline[state->nb];
-			if (!state->nb)
-				state->nb = 1;
-		} else {
-			state->lost_bucket = &state->sline[state->nb-1];
-		}
-		if (!state->sline[state->nb-1].p_lno)
-			state->sline[state->nb-1].p_lno =
-				xcalloc(state->num_parent,
-					sizeof(unsigned long));
-		state->sline[state->nb-1].p_lno[state->n] = state->ob;
-		return;
+
+	state->ob = ob;
+	state->on = on;
+	state->nb = nb;
+	state->nn = nn;
+	state->lno = state->nb;
+	if (state->nn == 0) {
+		/* @@ -X,Y +N,0 @@ removed Y lines
+		 * that would have come *after* line N
+		 * in the result.  Our lost buckets hang
+		 * to the line after the removed lines,
+		 *
+		 * Note that this is correct even when N == 0,
+		 * in which case the hunk removes the first
+		 * line in the file.
+		 */
+		state->lost_bucket = &state->sline[state->nb];
+		if (!state->nb)
+			state->nb = 1;
+	} else {
+		state->lost_bucket = &state->sline[state->nb-1];
 	}
+	if (!state->sline[state->nb-1].p_lno)
+		state->sline[state->nb-1].p_lno =
+			xcalloc(state->num_parent, sizeof(unsigned long));
+	state->sline[state->nb-1].p_lno[state->n] = state->ob;
+}
+
+static void consume_line(void *state_, char *line, unsigned long len)
+{
+	struct combine_diff_state *state = state_;
 	if (!state->lost_bucket)
 		return; /* not in any hunk yet */
 	switch (line[0]) {
@@ -421,8 +426,8 @@ static void combine_diff(struct repository *r,
 	state.num_parent = num_parent;
 	state.n = n;
 
-	if (xdi_diff_outf(&parent_file, result_file, NULL, consume_line,
-			  &state, &xpp, &xecfg))
+	if (xdi_diff_outf(&parent_file, result_file, consume_hunk,
+			  consume_line, &state, &xpp, &xecfg))
 		die("unable to generate combined diff for %s",
 		    oid_to_hex(parent));
 	free(parent_file.ptr);
-- 
2.19.1.1336.g081079ac04

