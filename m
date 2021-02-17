Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB69C433E6
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 20:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54FBB64E76
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 20:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhBQU0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 15:26:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:36422 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235001AbhBQUZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 15:25:58 -0500
Received: (qmail 20071 invoked by uid 109); 17 Feb 2021 20:25:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Feb 2021 20:25:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8869 invoked by uid 111); 17 Feb 2021 20:25:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Feb 2021 15:25:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Feb 2021 15:25:17 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 7/8] packfile: add kept-pack cache for
 find_kept_pack_entry()
Message-ID: <YC17rflmxAAdBBCd@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <f1c07324f62cf4d087c41165cefed98f554cfd78.1612411124.git.me@ttaylorr.com>
 <YC1OJDFXPnxGMHPK@coredump.intra.peff.net>
 <YC10eZkpqtzLlJUP@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YC10eZkpqtzLlJUP@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 02:54:33PM -0500, Taylor Blau wrote:

> > OK, so we keep a single cache based on the flags, and then if somebody
> > ever asks for different flags, we throw it away. That's probably OK for
> > our purposes, since we wouldn't expect multiple callers within a single
> > process.
> > [...some alternatives]
> 
> All interesting ideas. In this patch (and by the end of the series)
> callers that use the kept pack cache never ask for the cache with a
> different set of flags. IOW, there isn't a situation where a caller
> would populate the in-core kept pack cache, and then suddenly ask for
> both in-core and on-disk packs to be kept.
> 
> So all of this code is defensive in case that were to change, and
> suddenly we'd be returning subtly wrong results. I could imagine that
> being kind of a nasty bug to track down, so detecting and invalidating
> the cache would make it a non-issue.

Yeah, I agree that the current crop of callers does not care. And I am
glad we are not leaving a booby-trap for later programmers with respect
to correctness (by virtue of the invalidation function). But it does
feel like we are leaving one for performance, which they very well might
not realize the cache is doing worse-than-nothing.

Would just doing:

  if (cache.packs && cache.flags != flags)
	BUG("kept-pack-cache cannot handle multiple queries in a single process");

be a better solution? That is not helping anyone towards a world where
we gracefully handle back-and-forth queries. But it makes it abundantly
clear when such a thing would become necessary.

> > Is there any reason not to just embed the kept_pack_cache struct inside
> > the object_store? It's one less pointer to deal with. I wonder if this
> > is a holdover from an attempt to have multiple caches.
> >
> > (I also think it would be reasonable if we wanted to hide the definition
> > of the cache struct from callers, but we don't seem do to that).
> 
> Not a holdover, just designed to avoid adding too many extra fields to
> the object-store. I don't feel strongly, but I do think hiding the
> definition is a good idea, so I'll inline it.

This response confuses me a bit. Hiding the definition from callers
would mean _keeping_ it as a pointer, but putting the definition into
packfile.c, where nobody outside that file could see it (at least that
is what I meant by hiding).

But inlining it to me implies embedding the struct (not a pointer to it)
in "struct object_store", defining the struct at the point we define the
struct field which uses it.

I am fine with either, to be clear. I'm just confused which you are
proposing to do. :)

-Peff
