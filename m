Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFD1CDB465
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 23:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjJKX1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 19:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjJKX1t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 19:27:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C74EA4
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 16:27:48 -0700 (PDT)
Received: (qmail 20690 invoked by uid 109); 11 Oct 2023 23:27:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Oct 2023 23:27:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11332 invoked by uid 111); 11 Oct 2023 23:27:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Oct 2023 19:27:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Oct 2023 19:27:47 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 17/20] commit-graph: check bounds when accessing BDAT
 chunk
Message-ID: <20231011232747.GM518221@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210550.GQ3282181@coredump.intra.peff.net>
 <ZSbzf0o7r5GWAZFF@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSbzf0o7r5GWAZFF@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 03:11:59PM -0400, Taylor Blau wrote:

> > +	if (check_bloom_offset(g, lex_pos, end_index) < 0 ||
> > +	    check_bloom_offset(g, lex_pos - 1, start_index) < 0)
> 
> Can lex_pos ever be zero? I can't think of any reason that it couldn't,
> and indeed the (elided) diff context shows that immediately preceding
> this if-statement is another that checks "if (lex_pos > 0)".
> 
> So I think we'd want to avoid checking lex_pos - 1 if we know that
> lex_pos is zero. Not that any of this really matters, since the only
> thing we use the computed value for is showing the graph position in the
> warning() message. So seeing a bogus value there isn't the end of the
> world.

If lex_pos is 0, then we set start_index to 0 manually, which we know to
be valid. So we can't trigger a bogus warning(). My thinking was that it
was OK to just let this fall out naturally as it does here, since it
makes the code shorter. But if we want to cover that case separately,
I think you'd want to split the checks like:

diff --git a/bloom.c b/bloom.c
index 1474aa19fa..d9ad69ad82 100644
--- a/bloom.c
+++ b/bloom.c
@@ -65,16 +65,16 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
 	lex_pos = graph_pos - g->num_commits_in_base;
 
 	end_index = get_be32(g->chunk_bloom_indexes + 4 * lex_pos);
+	if (check_bloom_offset(g, lex_pos, end_index) < 0)
+		return 0;
 
-	if (lex_pos > 0)
+	if (lex_pos > 0) {
 		start_index = get_be32(g->chunk_bloom_indexes + 4 * (lex_pos - 1));
-	else
+		if (check_bloom_offset(g, lex_pos - 1, start_index) < 0)
+			return 0;
+	} else
 		start_index = 0;
 
-	if (check_bloom_offset(g, lex_pos, end_index) < 0 ||
-	    check_bloom_offset(g, lex_pos - 1, start_index) < 0)
-		return 0;
-
 	if (end_index < start_index) {
 		warning("ignoring decreasing changed-path index offsets"
 			" (%"PRIuMAX" > %"PRIuMAX") for positions"

-Peff
