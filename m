Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB78C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33DD86124B
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhDOJ3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:29:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:53166 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231843AbhDOJ3C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 05:29:02 -0400
Received: (qmail 9894 invoked by uid 109); 15 Apr 2021 09:28:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Apr 2021 09:28:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14428 invoked by uid 111); 15 Apr 2021 09:28:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Apr 2021 05:28:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Apr 2021 05:28:38 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Chris Torek <chris.torek@gmail.com>,
        Sam Bostock <sam.bostock@shopify.com>,
        Git List <git@vger.kernel.org>
Subject: Re: `git fetch` not updating 'origin/HEAD' after branch rename
Message-ID: <YHgHRpNDecY/d5UF@coredump.intra.peff.net>
References: <CAHwnEogvmTZ-VS5GksoGEiyo3EHO+At+xeWa3frXUESD3HicnQ@mail.gmail.com>
 <CAPx1GvdeNEyPEZ7GdRKeAevnvjyLmoXHjQP0W6iToDsJPAqDHA@mail.gmail.com>
 <87sg3t16ec.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sg3t16ec.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 14, 2021 at 12:56:27PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Now, what people *do actually* legitimately use this information is a
> convenient local cache of "what's the main upstream branch?".
> 
> I myself have written local scripts that used that, and been bitten by
> this information being stale / not there (in the case of
> init/config/fetch).
> 
> But why does anyone need that? Well, I don't think they actually
> do. What they actually do want is to push or fetch the "main"
> branch. The "what was HEAD that one time I talked to this remote" is
> just a roundabout way of getting that.
> 
> So isn't this whole thing just wart that we should fix in the protocol?
> Wouldn't the use-case for this be satisfied with something like:
> 
>     [branch "master"]
>             remote = origin
>             merge = HEAD ; does not work as you might expect
> 
> Right now that will just push to refs/heads/HEAD, but what if we had a
> protocol extension to intercept it (or rather, some merge = <a name
> incompatible with a current push, maybe "$HEAD">, as an aside setting it
> to ":HEAD" has some very funny results) wouldn't that satisfy the
> use-case?

Keep in mind that if we do not have a cache, then finding out the remote
HEAD involves a network trip. But we use branch.*.merge in lots of
places that aren't fetch/push. E.g., how would "git rev-parse
@{upstream}" work with the config you gave above?

> After all, who's really interested in what the remote's idea of their
> HEAD when they last fetched is?
> 
> Don't those users actually want the *current* idea of what HEAD is for
> the purposes of fetching or pushing?

IMHO the cache of the remote HEAD in refs/remotes/origin/HEAD is the
same as the cache of the remote refs in refs/remotes/origin/*. We only
talk to the network during fetch/push operations, but it is convenient
to have a local cache that names the things we saw there.

As others mentioned, "git rev-parse origin" is another local command
that works without touching the network.

So I find the local cache of the remote HEAD quite useful. I think the
only issue with it is that it is not kept up to date like the rest of
the branches in refs/remotes/origin/*. That was an intentional decision,
because you may want to define your own view of what is considered the
default for the remote.

But that is a much rarer case than people who do want to auto-update it
on fetch (and for many years nobody cared too much, because people
rarely updated HEAD anyway; but these days there's quite a lot of
renaming going on). So it makes sense to at least provide a configurable
option to allow updating it on each fetch.

-Peff
