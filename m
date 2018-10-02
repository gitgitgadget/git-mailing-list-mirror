Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EE6E1F454
	for <e@80x24.org>; Tue,  2 Oct 2018 19:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeJCCkW (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 22:40:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:38976 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726194AbeJCCkW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 22:40:22 -0400
Received: (qmail 13291 invoked by uid 109); 2 Oct 2018 19:55:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Oct 2018 19:55:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5636 invoked by uid 111); 2 Oct 2018 19:54:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Oct 2018 15:54:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2018 15:55:19 -0400
Date:   Tue, 2 Oct 2018 15:55:19 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] coccicheck: process every source file at once
Message-ID: <20181002195519.GB2014@sigill.intra.peff.net>
References: <20181002191642.21504-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181002191642.21504-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 02, 2018 at 12:16:42PM -0700, Jacob Keller wrote:

> make coccicheck is used in order to apply coccinelle semantic patches,
> and see if any of the transformations found within contrib/coccinelle/
> can be applied to the current code base.
> 
> Pass every file to a single invocation of spatch, instead of running
> spatch once per source file.
> 
> This reduces the time required to run make coccicheck by a significant
> amount of time:
> 
> Prior timing of make coccicheck
>   real    6m14.090s
>   user    25m2.606s
>   sys     1m22.919s
> 
> New timing of make coccicheck
>   real    1m36.580s
>   user    7m55.933s
>   sys     0m18.219s

Yay! This is a nice result.

It's also one of the things that Julia suggested in an earlier thread.
One thing I wasn't quite sure about after digging into the various
versions (1.0.4 on Debian stable/unstable, 1.0.6 in experimental, and
pre-1.0.7 at the bleeding edge) was whether the old versions would be
similarly helped (or work at all).

I just replicated your results with 1.0.4.deb-3+b2 from Debian stable.
It's possible there are older versions floating around, but for
something developer-only like this, I think "in Debian stable" is a
reasonable enough cutoff.

> This is nearly a 4x decrease in the time required to run make
> coccicheck. This is due to the overhead of restarting spatch for every
> file. By processing all files at once, we can amortize this startup cost
> across the total number of files, rather than paying it once per file.

One minor side effect is that we lose the opportunity to parallelize
quite as much. However, I think the reduction in total CPU makes it well
worth that (and we still have 8 cocci files and growing, which should
keep at least 8 cores busy).

I think recent versions of Coccinelle will actually parallelize
internally, too, but my 1.0.4 doesn't seem to. That's probably what I
was thinking of earlier (but this is still a win even without that).

It looks like this also fixes a problem I ran into when doing the oideq
work, which is that the patch for a header file would get shown multiple
times (once for each file that includes it). So this is faster _and_
more correct. Double-yay.

> diff --git a/Makefile b/Makefile
> index df1df9db78da..b9947f3f51ec 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2715,10 +2715,8 @@ endif
>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
>  	@echo '    ' SPATCH $<; \
>  	ret=0; \
> -	for f in $(COCCI_SOURCES); do \
> -		$(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
> -			{ ret=$$?; break; }; \
> -	done >$@+ 2>$@.log; \
> +	( $(SPATCH) --sp-file $< $(COCCI_SOURCES) $(SPATCH_FLAGS) || \
> +		{ ret=$$?; }; ) >$@+ 2>$@.log; \

This looks pretty straight-forward. I wondered if we could get rid of
the "ret" handling, since we don't need to pass the error back out of
the loop. But it's also used for the "show the log only on error" logic
below:

>  	if test $$ret != 0; \
>  	then \
>  		cat $@.log; \

The subshell could be a {}, though, I think, but it's not that big a
deal either way.

-Peff
