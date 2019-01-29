Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7348D1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 16:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfA2QAd (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 11:00:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:53358 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725794AbfA2QAc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 11:00:32 -0500
Received: (qmail 1267 invoked by uid 109); 29 Jan 2019 16:00:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Jan 2019 16:00:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8284 invoked by uid 111); 29 Jan 2019 16:00:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 Jan 2019 11:00:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2019 11:00:30 -0500
Date:   Tue, 29 Jan 2019 11:00:30 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
Message-ID: <20190129160030.GA7083@sigill.intra.peff.net>
References: <pull.114.git.gitgitgadget@gmail.com>
 <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 06:56:08AM -0800, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When running the test suite for code coverage using
> 'make coverage-test', a single test failure stops the
> test suite from completing. This leads to significant
> undercounting of covered blocks.
> 
> Add two new targets to the Makefile:
> 
> * 'prove' runs the test suite using 'prove'.
> 
> * 'coverage-prove' compiles the source using the
>   coverage flags, then runs the test suite using
>   'prove'.
> 
> These targets are modeled after the 'test' and
> 'coverage-test' targets.

I think these are reasonable to have (and I personally much prefer
"prove" to the raw "make test" output anyway).

For people who don't have "prove" available, I think they could just do
"make -k test" to make sure the full suite runs. Should we perhaps be
doing that automatically in the sub-make run by coverage-test?

> @@ -3077,6 +3080,10 @@ coverage-test: coverage-clean-results coverage-compile
>  	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
>  		DEFAULT_TEST_TARGET=test -j1 test
>  
> +coverage-prove: coverage-clean-results coverage-compile
> +	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
> +		DEFAULT_TEST_TARGET=prove -j1 prove
> +

You probably don't need to override DEFAULT_TEST_TARGET here, since the
"prove" target doesn't look at it. Likewise, "-j1" probably does nothing
here, since prove itself is a single target.

I'm not sure why we want to enforce -j1 for these targets, but if it's
important to do so for the prove case, as well, you'd need to add it to
GIT_PROVE_OPTS.

-Peff
