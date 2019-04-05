Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC07F20248
	for <e@80x24.org>; Fri,  5 Apr 2019 13:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfDENaq (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 09:30:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:48116 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730492AbfDENaq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 09:30:46 -0400
Received: (qmail 7587 invoked by uid 109); 5 Apr 2019 13:30:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 13:30:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25028 invoked by uid 111); 5 Apr 2019 13:31:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 09:31:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 09:30:44 -0400
Date:   Fri, 5 Apr 2019 09:30:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/12] packfile: check midx coverage with .idx rather
 than .pack
Message-ID: <20190405133044.GB1460@sigill.intra.peff.net>
References: <20190404232104.GA27770@sigill.intra.peff.net>
 <20190404232546.GD21839@sigill.intra.peff.net>
 <726ad2d6-ab39-8f5e-1b2d-f991c8765a08@web.de>
 <20190405132125.GA1460@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405132125.GA1460@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 09:21:25AM -0400, Jeff King wrote:

> > ... which also means this open_pack_index() call isn't done anymore if
> > there's no .midx file at all.  You don't mention this change in the
> > commit message; is it intended?
> 
> Doh, thank you for catching that. I made that switch at the last minute
> because I didn't want to pay the malloc/free cost when we had no list to
> compare to. I'm surprised it works at all. :-/
> 
> I guess it doesn't, from the other message in the thread.

Hmm, no, that's a different problem. I think we'd generally already have
the pack open unless there _is_ a midx, so this conditional probably
never kicks in unless we have a midx anyway. Meaning my malloc-avoidance
was over-thought. So we could just get rid of it. Or do it like this:

diff --git a/packfile.c b/packfile.c
index e7ca135ed5..ef0f959311 100644
--- a/packfile.c
+++ b/packfile.c
@@ -496,17 +496,22 @@ static int open_packed_git_1(struct packed_git *p)
 	ssize_t read_result;
 	const unsigned hashsz = the_hash_algo->rawsz;
 
-	if (!p->index_data && the_repository->objects->multi_pack_index) {
-		struct multi_pack_index *m;
-		char *idx_name = pack_name_to_idx(pack_basename(p));
+	if (!p->index_data) {
+		struct multi_pack_index *m =
+			the_repository->objects->multi_pack_index;
 
-		for (m = the_repository->objects->multi_pack_index;
-		     m; m = m->next) {
-			if (midx_contains_pack(m, idx_name))
-				break;
+		if (m) {
+			char *idx_name = pack_name_to_idx(pack_basename(p));
+
+			for (; m; m = m->next) {
+				if (midx_contains_pack(m, idx_name))
+					break;
+			}
+			free(idx_name);
 		}
-		free(idx_name);
 
+		if (!m)
+			warning("opening anyway");
 		if (!m && open_pack_index(p))
 			return error("packfile %s index unavailable", p->pack_name);
 	}

I'll have to re-roll to address the other problem, though, so I'll give
it some thought.

-Peff
