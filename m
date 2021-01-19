Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773A4C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532B722DD3
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbhASXWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:22:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:60428 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729505AbhASXKi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:10:38 -0500
Received: (qmail 15560 invoked by uid 109); 19 Jan 2021 23:09:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Jan 2021 23:09:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13733 invoked by uid 111); 19 Jan 2021 23:09:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Jan 2021 18:09:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Jan 2021 18:09:42 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@gitlab.com
Subject: Re: [PATCH 2/2] ls-refs.c: traverse longest common ref prefix
Message-ID: <YAdmtgUPiGUaXiRX@coredump.intra.peff.net>
References: <CADMWQoPREhirr+RJPkJJV2U+8VG=DFotvTBCDSXFhn-3pn2X-A@mail.gmail.com>
 <cover.1611080326.git.me@ttaylorr.com>
 <fb8681d12864d724108c524834f9498d91e270e6.1611080326.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb8681d12864d724108c524834f9498d91e270e6.1611080326.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 01:19:17PM -0500, Taylor Blau wrote:

> To attempt to reduce the difference between the number of refs
> traversed, and the number of refs sent, only traverse references which
> are in the longest common prefix of the given prefixes. This is very
> reminiscent of the approach taken in b31e2680c4 (ref-filter.c: find
> disjoint pattern prefixes, 2019-06-26) which does an analogous thing for
> multi-patterned 'git for-each-ref' invocations.
> 
> The only difference here is that we are operating on ref prefixes, which
> do not necessarily point to a single reference. That is just fine, since
> all we care about is finding the longest common prefix among prefixes
> which can be thought of as refspecs for our purposes here.

This second paragraph confused me. Aren't the inputs to for-each-ref
also prefixes?

I guess they require an explicit '*', but fundamentally it's the same
concept (and certainly they are not just single references).

> Similarly, for_each_fullref_in_prefixes may return more results than the
> caller asked for (since the longest common prefix might match something
> that a longer prefix in the same set wouldn't match) but
> ls-refs.c:send_ref() discards such results.

Based on my other poking, I'm not entirely sure that we can return too
many results. But I do think it's worth keeping the caller more careful.

> The code introduced in b31e2680c4 is resilient to stop early (and
> return a shorter prefix) when it encounters a metacharacter (as
> mentioned in that patch, there is some opportunity to improve this, but
> nobody has done it).

I agree that is how b31e2680c4 works, but we don't care about that
behavior here, since we have strict prefixes. Isn't the argument we need
to make the other way? I.e., that stopping early on a metacharacter will
not hurt us. Because at worst we return too many results (hey, there's a
case!) and because we would not expect metacharacters in the prefixes
anyway, as they are illegal in refnames.

> There are two remaining small items in this patch:
> 
>   - If no prefixes were provided, then implicitly add the empty string
>     (which will match all references).

I wonder if for_each_fullref_in_prefixes() should do that, since that is
exactly what the other caller does, too. OTOH, maybe it is better to
make the callers be more explicit. In which case should it maybe BUG()
on an empty set of prefixes, rather than letting the caller assume some
behavior?

>   - Since we are manually munging the prefixes, make sure that we
>     initialize it ourselves (previously this wasn't necessary since the
>     first strvec_push would do so).

I think this was an existing bug (that we were just lucky it was
impossible to trigger, because nobody looked for the NULL sentinel), and
would make more sense as a separate fix.

-Peff
