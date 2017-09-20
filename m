Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9C420A28
	for <e@80x24.org>; Wed, 20 Sep 2017 18:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbdITSlB (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 14:41:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:44880 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751387AbdITSlB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 14:41:01 -0400
Received: (qmail 7362 invoked by uid 109); 20 Sep 2017 18:41:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 18:41:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15058 invoked by uid 111); 20 Sep 2017 18:41:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 14:41:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Sep 2017 14:40:58 -0400
Date:   Wed, 20 Sep 2017 14:40:58 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 13/21] packed_ref_cache: keep the `packed-refs` file
 mmapped if possible
Message-ID: <20170920184058.w3tipgsz54ig7dm5@sigill.intra.peff.net>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
 <b32234e07a1bd1e60442a13d97d7c4e51edf3336.1505799700.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b32234e07a1bd1e60442a13d97d7c4e51edf3336.1505799700.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2017 at 08:22:21AM +0200, Michael Haggerty wrote:

> Keep a copy of the `packed-refs` file contents in memory for as long
> as a `packed_ref_cache` object is in use:
> 
> * If the system allows it, keep the `packed-refs` file mmapped.
> 
> * If not (either because the system doesn't support `mmap()` at all,
>   or because a file that is currently mmapped cannot be replaced via
>   `rename()`), then make a copy of the file's contents in
>   heap-allocated space, and keep that around instead.
> 
> We base the choice of behavior on a new build-time switch,
> `MMAP_PREVENTS_DELETE`. By default, this switch is set for Windows
> variants.
> 
> This whole change is still pointless, because we only read the
> `packed-refs` file contents immediately after instantiating the
> `packed_ref_cache`. But that will soon change.

The overall strategy for this compile-time knob makes sense, but one
thing confused me:

> +ifdef MMAP_PREVENTS_DELETE
> +	BASIC_CFLAGS += -DMMAP_PREVENTS_DELETE
> +else
> +	ifdef USE_WIN32_MMAP
> +		BASIC_CFLAGS += -DMMAP_PREVENTS_DELETE
> +	endif
> +endif

So setting the knob does what you'd expect. But if you don't set it,
then we still auto-tweak it based on the USE_WIN32_MMAP knob. Do we need
that? It seems like we set our new knob in config.mak.uname any time
we'd set USE_WIN32_MMAP. So this only has an effect in two cases:

 1. You aren't on Windows, but you set USE_WIN32_MMAP yourself.

 2. You are on Windows, but you manually unset MMAP_PREVENTS_DELETE.

I expect both cases are rare (and would probably involve somebody
actively debugging these knobs). Probably it's a minor convenience in
case 1, but in case 2 it would be actively confusing, I'd think.

> +enum mmap_strategy {
> +	/*
> +	 * Don't use mmap() at all for reading `packed-refs`.
> +	 */
> +	MMAP_NONE,
> +
> +	/*
> +	 * Can use mmap() for reading `packed-refs`, but the file must
> +	 * not remain mmapped. This is the usual option on Windows,
> +	 * where you cannot rename a new version of a file onto a file
> +	 * that is currently mmapped.
> +	 */
> +	MMAP_TEMPORARY,

I suspect you originally distinguished these cases so that NO_MMAP does
not read into a fake-mmap buffer, followed by us copying it into another
buffer. But AFAICT we handle the "NONE" and "TEMPORARY" cases exactly
the same (by just doing a read_in_full() into our own buffer). Do we
actually need separate strategies?

-Peff
