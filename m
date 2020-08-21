Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60471C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 14:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FCB2078B
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 14:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgHUOha (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:37:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:37036 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgHUOh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 10:37:29 -0400
Received: (qmail 17561 invoked by uid 109); 21 Aug 2020 14:37:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 14:37:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28214 invoked by uid 111); 21 Aug 2020 14:37:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 10:37:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 10:37:27 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] refs: remove lookup cache for reference-transaction hook
Message-ID: <20200821143727.GA3241139@coredump.intra.peff.net>
References: <0db8ad8cdb69afb9d6453bf60a808e8b82382a4e.1597998473.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0db8ad8cdb69afb9d6453bf60a808e8b82382a4e.1597998473.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 10:29:18AM +0200, Patrick Steinhardt wrote:

> One case notably absent from those benchmarks is a single executable
> searching for the hook hundreds of times, which is exactly the case for
> which the negative cache was added. p1400.2 will spawn a new update-ref
> for each transaction and p1400.3 only has a single reference-transaction
> for all reference updates. So this commit adds a third benchmark, which
> performs an non-atomic push of a thousand references. This will create a
> new reference transaction per reference. But even for this case, the
> negative cache doesn't consistently improve performance:

Ah, right, I forgot that update-ref would use one single transaction. So
what we were testing in our earlier discussion was not even useful. :)

>  test_expect_success "setup" '
> +	git init --bare target-repo.git &&
>  	test_commit PRE &&
>  	test_commit POST &&
>  	printf "create refs/heads/%d PRE\n" $(test_seq 1000) >create &&
>  	printf "update refs/heads/%d POST PRE\n" $(test_seq 1000) >update &&
> -	printf "delete refs/heads/%d POST\n" $(test_seq 1000) >delete
> +	printf "delete refs/heads/%d POST\n" $(test_seq 1000) >delete &&
> +	printf "create refs/heads/branch-%d PRE\n" $(test_seq 1000) | git update-ref --stdin
>  '

OK, we need these new branches to have something to push into and delete
from the remote. They might impact the timings of the other tests,
though (since we now have 1000 entries in .git/refs/heads/, which might
affect filesystem performance). But it should do so uniformly, so I
don't think it invalidates their results.

However, I wondered...

> +test_perf "nonatomic push" '
> +	git push ./target-repo.git branch-{1..1000} &&
> +	git push --delete ./target-repo.git branch-{1..1000}
> +'

...if it might make the test more consistent (not to mention isolated
from the cost of other parts of the push) if we used update-ref here, as
well. You added the code necessary to control individual transactions,
so I thought that:

  printf 'start\ncreate refs/heads/%d PRE\ncommit\n' \
    $(test_seq 1000) >create-transaction

might work. But it doesn't, because after the first transaction is
closed, we refuse to accept any other commands. That makes sense for
"prepare", etc, but there's no reason we couldn't start a new one.

Is that worth supporting? It would allow a caller to use a single
update-ref to make a series of non-atomic updates, which is something
that can't currently be done. And we're so close.

Even if it is, though, that's definitely outside the scope of this
patch, and I think we should take it as-is with "push".

-Peff
