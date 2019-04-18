Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42EF220248
	for <e@80x24.org>; Thu, 18 Apr 2019 19:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390117AbfDRTuA (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 15:50:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:34284 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2389853AbfDRTuA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 15:50:00 -0400
Received: (qmail 3318 invoked by uid 109); 18 Apr 2019 19:50:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Apr 2019 19:50:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3878 invoked by uid 111); 18 Apr 2019 19:50:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Apr 2019 15:50:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2019 15:49:53 -0400
Date:   Thu, 18 Apr 2019 15:49:53 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] prune: use bitmaps for reachability traversal
Message-ID: <20190418194953.GA15249@sigill.intra.peff.net>
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043743.GB19183@sigill.intra.peff.net>
 <49e2aa9b-ff22-a8d1-ba72-1c881ff5fab4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49e2aa9b-ff22-a8d1-ba72-1c881ff5fab4@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 15, 2019 at 11:00:45AM -0400, Derrick Stolee wrote:

> >  void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
> >  			    timestamp_t mark_recent, struct progress *progress)
> [...]
> >  	cp.progress = progress;
> >  	cp.count = 0;
> >  
> > +	bitmap_git = prepare_bitmap_walk(revs);
> > +	if (bitmap_git) {
> > +		traverse_bitmap_commit_list(bitmap_git, mark_object_seen);
> > +		free_bitmap_index(bitmap_git);
> > +		return;
> > +	}
> > +
> 
> This block after "if (bitmap_git)" is not exercised by the (non-performance)
> test suite, so the rest of the code above is not tested, either. Could a test
> of this "prune" capability be added to the regression tests around the bitmaps?

I have somewhat mixed feelings here.  We can add a test with a trivial
bitmap to get code coverage here. But as with many optimizations
(bitmaps, but also your commit graph work), we get a much more thorough
correctness test by re-running the whole test suite (though we do not
yet have one for running with bitmaps on), and a better test that the
optimization is kicking in and working via the t/perf tests.

I dunno. I guess it does not hurt to at least to at least make sure this
code is running in the normal suite. I don't think that will find the
more interesting regressions, but at least saves us the from the most
egregious ones ("oops, the whole thing segfaults because somebody
changed the API" kinds of things).

-Peff
