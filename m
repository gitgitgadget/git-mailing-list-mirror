Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B0CC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54B964E76
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhBQVoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:44:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:36542 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231286AbhBQVoL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:44:11 -0500
Received: (qmail 20373 invoked by uid 109); 17 Feb 2021 21:43:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Feb 2021 21:43:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9551 invoked by uid 111); 17 Feb 2021 21:43:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Feb 2021 16:43:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Feb 2021 16:43:27 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 7/8] packfile: add kept-pack cache for
 find_kept_pack_entry()
Message-ID: <YC2N///TCMK65XNr@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <f1c07324f62cf4d087c41165cefed98f554cfd78.1612411124.git.me@ttaylorr.com>
 <YC1OJDFXPnxGMHPK@coredump.intra.peff.net>
 <YC10eZkpqtzLlJUP@nand.local>
 <YC17rflmxAAdBBCd@coredump.intra.peff.net>
 <YC18vmTYKo/lEaB7@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YC18vmTYKo/lEaB7@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 03:29:50PM -0500, Taylor Blau wrote:

> On Wed, Feb 17, 2021 at 03:25:17PM -0500, Jeff King wrote:
> > Would just doing:
> >
> >   if (cache.packs && cache.flags != flags)
> > 	BUG("kept-pack-cache cannot handle multiple queries in a single process");
> >
> > be a better solution? That is not helping anyone towards a world where
> > we gracefully handle back-and-forth queries. But it makes it abundantly
> > clear when such a thing would become necessary.
> 
> I dunno. I can certainly see its merits, but I have to imagine that
> anybody who cares enough about the performance will be able to find our
> conversation here. Assuming that's the case, I would rather have the
> kept-pack cache handle multiple queries before BUG()-ing.

OK. I am on the fence, and you are the author, so I'm happy to go with
your preference.

I'm not quite as optimistic that somebody would find this conversation,
if only because they have to know to look for it. I could easily see
somebody adding a find_kept_in_pack() without thinking too hard about
it. OTOH, I find it quite unlikely that anybody would use a different
set of flags within the same process, so it would probably Just Work for
them regardless. :)

> > This response confuses me a bit. Hiding the definition from callers
> > would mean _keeping_ it as a pointer, but putting the definition into
> > packfile.c, where nobody outside that file could see it (at least that
> > is what I meant by hiding).
> >
> > But inlining it to me implies embedding the struct (not a pointer to it)
> > in "struct object_store", defining the struct at the point we define the
> > struct field which uses it.
> >
> > I am fine with either, to be clear. I'm just confused which you are
> > proposing to do. :)
> 
> Probably because I changed my mind in the middle of writing it ;). I'm
> proposing embedding the definition of the struct into the definition of
> object_store, and then operating on its fields (from within packfile.c).

OK, that sounds great to me (and arguably produces more efficient code,
since we avoid a pointer dereference, though I doubt it matters in
practice). Thanks for clarifying.

-Peff
