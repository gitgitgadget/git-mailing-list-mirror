Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64C7C433DB
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 10:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD146501A
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 10:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhCFKvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 05:51:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:54400 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhCFKvv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 05:51:51 -0500
Received: (qmail 12153 invoked by uid 109); 6 Mar 2021 10:51:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Mar 2021 10:51:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29406 invoked by uid 111); 6 Mar 2021 10:51:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Mar 2021 05:51:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 6 Mar 2021 05:51:50 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2 3/4] Makefile/coccicheck: allow for setting xargs
 concurrency
Message-ID: <YENexlKkGa2btuBO@coredump.intra.peff.net>
References: <20210302205103.12230-1-avarab@gmail.com>
 <20210305170724.23859-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210305170724.23859-4-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 05, 2021 at 06:07:23PM +0100, Ævar Arnfjörð Bjarmason wrote:

> +# Setting SPATCH_XARGS overrides SPATCH_BATCH_SIZE. To get concurrency
> +# when targeting a single contrib/coccinelle/%.patch use e.g. "-P" if
> +# your xargs(1) supports it:
> +#
> +#    make contrib/coccinelle/strbuf.cocci.patch SPATCH_XARGS="xargs -P 8 -n 8"
> +#
> +# Or a combination -jN and "xargs -P":
> +#
> +#    make -j4 coccicheck SPATCH_XARGS="xargs -P 2 -n 8"

I don't think this is actually safe to do. At least not if you care
about the output patch. All of the parallel processes will go to the
same output file:

> -	if test $(SPATCH_BATCH_SIZE) = 0; then \
> -		limit=; \
> -	else \
> -		limit='-n $(SPATCH_BATCH_SIZE)'; \
> -	fi; \
> -	if ! echo $(COCCI_SOURCES) | xargs $$limit \
> +	if ! echo $(COCCI_SOURCES) | $(SPATCH_XARGS) \
>  		$(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
>  		>$@+ 2>$@.log; \
>  	then \

which means they run the risk of getting jumbled racily. It might work
OK in practice if the patches are smaller than spatch puts into a single
write() call, and what the OS will treat as an atomic file-write (which
is really under-specified in POSIX for regular files).

-Peff
