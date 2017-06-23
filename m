Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20A1A2082E
	for <e@80x24.org>; Fri, 23 Jun 2017 03:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754091AbdFWDNS (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 23:13:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:49942 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753925AbdFWDNR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 23:13:17 -0400
Received: (qmail 13476 invoked by uid 109); 23 Jun 2017 03:13:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 03:13:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9660 invoked by uid 111); 23 Jun 2017 03:13:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jun 2017 23:13:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jun 2017 23:13:15 -0400
Date:   Thu, 22 Jun 2017 23:13:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kyle Meyer <kyle@kyleam.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: Re: Truncating HEAD reflog on branch move
Message-ID: <20170623031315.7aw5qd7c4wdqlyf6@sigill.intra.peff.net>
References: <xmqqpodxm2t8.fsf@gitster.mtv.corp.google.com>
 <87efud7xjd.fsf@kyleam.com>
 <20170622151603.rrh2j7zsotyt2jxe@sigill.intra.peff.net>
 <xmqqziczkh4k.fsf@gitster.mtv.corp.google.com>
 <20170622184516.kq3y7nxwohm3coq4@sigill.intra.peff.net>
 <xmqqvannkfp8.fsf@gitster.mtv.corp.google.com>
 <20170622202146.cxrkjca636xl4dgk@sigill.intra.peff.net>
 <xmqqd19vix03.fsf@gitster.mtv.corp.google.com>
 <20170622215235.to6yleo3adt5klv2@sigill.intra.peff.net>
 <20170622222545.yewnynklle24ebtf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170622222545.yewnynklle24ebtf@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 06:25:46PM -0400, Jeff King wrote:

> So here's a patch on top of what I posted before that pushes the reflog
> check into the loop (it just decides whether to pull from the reflogs or
> from the commit queue at the top of the loop).
> 
> I was surprised to find, though, that simplify_commit() does not
> actually do the pathspec limiting! It's done by
> try_to_simplify_commit(), which is part of add_parents_to_list(). I
> hacked around it in the later part of the loop by calling
> try_to_simplify myself and checking the TREESAME flag. But I have a
> feeling I'm missing something about how the traversal is supposed to
> work.
> 
> This does behave sensibly with "--no-merges" and "--merges", as well as
> pathspec limiting.

And here's one more patch on top of those that's necessary to get the
tests to pass (I don't expect anybody to necessarily be applying this
slow string of patches; it's just to show the direction I'm looking in).

---
 builtin/log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 998437b23..512538479 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -373,9 +373,9 @@ static int cmd_log_walk(struct rev_info *rev)
 		if (!rev->reflog_info) {
 			/* we allow cycles in reflog ancestry */
 			free_commit_buffer(commit);
+			free_commit_list(commit->parents);
+			commit->parents = NULL;
 		}
-		free_commit_list(commit->parents);
-		commit->parents = NULL;
 		if (saved_nrl < rev->diffopt.needed_rename_limit)
 			saved_nrl = rev->diffopt.needed_rename_limit;
 		if (rev->diffopt.degraded_cc_to_c)
