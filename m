Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88210C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 18:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjCUSW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCUSWz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 14:22:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1576E509B6
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:22:53 -0700 (PDT)
Received: (qmail 28506 invoked by uid 109); 21 Mar 2023 18:22:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Mar 2023 18:22:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2725 invoked by uid 111); 21 Mar 2023 18:22:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Mar 2023 14:22:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Mar 2023 14:22:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Paul Eggert <eggert@cs.ucla.edu>,
        Eric Wong <e@80x24.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] git-compat-util: use gettimeofday(2) for time(2)
Message-ID: <20230321182252.GJ3119834@coredump.intra.peff.net>
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
 <20230320230507.3932018-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230320230507.3932018-1-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 04:05:07PM -0700, Junio C Hamano wrote:

> +#ifdef time
> +#undef time
> +#endif
> +static inline time_t git_time(time_t *tloc)
> +{
> +	struct timeval tv;
> +
> +	/*
> +	 * Avoid time(NULL), which can disagree with gettimeofday(2)
> +	 * and filesystem timestamps.
> +	 */
> +	gettimeofday(&tv, NULL);
> +
> +	if (tloc)
> +		*tloc = tv.tv_sec;
> +	return tv.tv_sec;
> +}
> +#define time(x) git_time(x)

This looks good to me, but I wanted to mention one alternative. If we
are declaring that time() sucks and gettimeofday() is how to do it, then
we could just use gettimeofday() everywhere, and add time() to banned.h
to catch stragglers.

It has two mild advantages:

  1. gettimeofday() gives the callers extra resolution if they want it
     (though in practice I guess none of them really do)

  2. It more directly describes what's going on, and we'd play fewer
     games with macros (though we may end up with a git_gettimeofday()
     wrapper if somebody doesn't support it; I really wonder about
     Windows here).

The disadvantage is that it's longer to type, and that you have to
declare a timeval in the caller. So maybe it's a dumb idea.

-Peff
