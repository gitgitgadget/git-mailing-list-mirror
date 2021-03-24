Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F45AC433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E265661A16
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhCXT0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 15:26:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:47892 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237817AbhCXT0D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 15:26:03 -0400
Received: (qmail 14609 invoked by uid 109); 24 Mar 2021 19:26:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Mar 2021 19:26:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21128 invoked by uid 111); 24 Mar 2021 19:26:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Mar 2021 15:26:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Mar 2021 15:26:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v4 3/4] Makefile/coccicheck: allow for setting xargs
 concurrency
Message-ID: <YFuSSqbAjTmaEMCB@coredump.intra.peff.net>
References: <20210306192525.15197-1-avarab@gmail.com>
 <cover.1616414951.git.avarab@gmail.com>
 <9d5814dacdc281389c4cb163ddbe4b749e6c0852.1616414951.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d5814dacdc281389c4cb163ddbe4b749e6c0852.1616414951.git.avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 22, 2021 at 01:11:49PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Extend the SPATCH_BATCH_SIZE facility added in
> 960154b9c17 (coccicheck: optionally batch spatch invocations,
> 2019-05-06) and bcb4edf7af7 (coccicheck: make batch size of 0 mean
> "unlimited", 2019-05-08) to allow for both setting
> SPATCH_BATCH_SIZE=N, and also to have a more advanced SPATCH_XARGS
> argument.
> 
> The reason to replace the "$$limit" is that now you actually see under
> V=1 what argument your program will get invoked with.
> 
> The reason for the "9999" limit is that if you e.g. try to define an
> "$(XARGS)" which is conditionally an empty string or not depending on
> this setting then e.g.:
> 
>     echo $(FILES) | $(XARGS) $(XARGS_FLAGS) $(SPATCH)
> 
> Over multiple lines with "\" will error out. I think just setting it
> to "xargs -n 9999" as a trivial workaround is the best solution here.

I don't understand this 9999 comment. The original was sometimes setting
$limit to the empty string, and then doing:

 xargs $limit

How is that any different than setting SPATCH_XARGS to just "xargs" for
the unlimited case?

> +# For the 'coccicheck' target; SPATCH_XARGS can be used to manually
> +# tweak the xargs invocation. By default we invoke "xargs -n 1", and
> +# "xargs -n 9999" under SPATCH_BATCH_SIZE=0.
> +#
> +# Setting SPATCH_XARGS overrides SPATCH_BATCH_SIZE. To get concurrency
> +# when targeting a single contrib/coccinelle/%.patch use e.g. "-P" if
> +# your xargs(1) supports it:
> +#
> +#    make contrib/coccinelle/strbuf.cocci.patch SPATCH_XARGS="xargs -P 8 -n 8"
> +#
> +# Or a combination -jN and "xargs -P":
> +#
> +#    make -j4 coccicheck SPATCH_XARGS="xargs -P 2 -n 8"

As I mentioned in the last round, using "-P" is racy. I'm not sure if
it's something we should be recommending to people.

-Peff
