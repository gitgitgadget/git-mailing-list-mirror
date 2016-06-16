Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3102F1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 13:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647AbcFPNrq (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 09:47:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:55678 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754614AbcFPNrp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 09:47:45 -0400
Received: (qmail 20745 invoked by uid 102); 16 Jun 2016 13:47:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 09:47:44 -0400
Received: (qmail 17079 invoked by uid 107); 16 Jun 2016 13:47:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 09:47:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 09:47:42 -0400
Date:	Thu, 16 Jun 2016 09:47:42 -0400
From:	Jeff King <peff@peff.net>
To:	Markus Trippelsdorf <markus@trippelsdorf.de>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: final git bisect step leads to: "fatal: you want to use way too
 much memory"
Message-ID: <20160616134742.GA25920@sigill.intra.peff.net>
References: <20160616125326.GA314@x4>
 <20160616132952.GC314@x4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160616132952.GC314@x4>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 03:29:52PM +0200, Markus Trippelsdorf wrote:

> On 2016.06.16 at 14:53 +0200, Markus Trippelsdorf wrote:
> > markus@x4 gcc % git bisect good
> > f216419e5c4c41df70dbe00a6ea1faea46484dc8 is the first bad commit
> > commit f216419e5c4c41df70dbe00a6ea1faea46484dc8
> > fatal: you want to use way too much memory
> > markus@x4 gcc % 
> 
> The issue started with:
> 
> commit fe37a9c586a65943e1bca327a1bbe1ca4a3d3023
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Tue Mar 29 16:05:39 2016 -0700
> 
>     pretty: allow tweaking tabwidth in --expand-tabs

Interesting. But `git show` on the commit in question (f216419e5) does
not have any problems. It looks like bisect's internal "show the commit"
code does not properly call setup_revisions() to finalize the "struct
rev_info". That leaves the expand_tabs_in_log flag as "-1", which then
ends up cast to an unsigned of 2^64 when we use it in a size
computation.

And who knows what other bugs have been lurking there over the years;
there are other flags that should be finalized by setup_revision(), too.

This patch should fix it.

diff --git a/bisect.c b/bisect.c
index 6d93edb..dc13319 100644
--- a/bisect.c
+++ b/bisect.c
@@ -890,6 +890,7 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 	if (!opt.diffopt.output_format)
 		opt.diffopt.output_format = DIFF_FORMAT_RAW;
 
+	setup_revisions(0, NULL, &opt, NULL);
 	log_tree_commit(&opt, commit);
 }
 
