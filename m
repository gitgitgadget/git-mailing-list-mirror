Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D57CC388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 19:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4E420728
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 19:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbgKETe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 14:34:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:49138 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgKETe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 14:34:56 -0500
Received: (qmail 17324 invoked by uid 109); 5 Nov 2020 19:34:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Nov 2020 19:34:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25867 invoked by uid 111); 5 Nov 2020 19:34:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Nov 2020 14:34:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Nov 2020 14:34:55 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] p1400: Use `git-update-ref --stdin` to test multiple
 transactions
Message-ID: <20201105193455.GB121650@coredump.intra.peff.net>
References: <cover.1604501265.git.ps@pks.im>
 <bfaac619112b04aa6545f229ea60433cbf8da73a.1604501265.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfaac619112b04aa6545f229ea60433cbf8da73a.1604501265.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 04, 2020 at 03:57:22PM +0100, Patrick Steinhardt wrote:

> In commit 0a0fbbe3ff (refs: remove lookup cache for
> reference-transaction hook, 2020-08-25), a new benchmark was added to
> p1400 which has the intention to exercise creation of multiple
> transactions in a single process. As git-update-ref wasn't yet able to
> create multiple transactions with a single run we instead used git-push.
> As its non-atomic version creates a transaction per reference update,
> this was the best approximation we could make at that point in time.
> 
> Now that `git-update-ref --stdin` supports creation of multiple
> transactions, let's convert the benchmark to use that instead. It has
> less overhead and it's also a lot clearer what the actual intention is.

Good direction. The diff confused me for a moment...

> @@ -26,14 +27,7 @@ test_perf "update-ref" '
>  '
>  
>  test_perf "update-ref --stdin" '
> -	git update-ref --stdin <update &&
> -	git update-ref --stdin <delete &&
> -	git update-ref --stdin <create
> -'
> -
> -test_perf "nonatomic push" '
> -	git push ./target-repo.git $(test_seq 1000) &&
> -	git push --delete ./target-repo.git $(test_seq 1000)
> +	git update-ref --stdin <instructions >/dev/null
>  '

...because we're dropping _two_ tests here. But I think they were
testing the same thing, just with varying degrees of quality.

It could possibly be useful to have perf results broken down by
operation type (create vs delete vs update), but the original certainly
didn't do that. And it's not clear to me it would actually produce
interesting results; certainly not related to the hook, but possibly
related to benchmarking ref updates in general. So I don't think it's
worth worrying about.

-Peff
