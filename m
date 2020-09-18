Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEB5C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D3321734
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIRRhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:37:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:33488 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRRhk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 13:37:40 -0400
Received: (qmail 11205 invoked by uid 109); 18 Sep 2020 17:37:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Sep 2020 17:37:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23231 invoked by uid 111); 18 Sep 2020 17:37:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Sep 2020 13:37:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Sep 2020 13:37:39 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Guyot-Sionnest <tguyot@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: Re: [PATCH 1/2] diff: Fix modified lines stats with --stat and
 --numstat
Message-ID: <20200918173739.GE183026@coredump.intra.peff.net>
References: <20200918113256.8699-1-tguyot@gmail.com>
 <20200918113256.8699-2-tguyot@gmail.com>
 <20200918144651.GA1612043@nand.local>
 <CALqVohfQZu=itUyfU7nubJpgBETh2q7W1TVx=c2E32ey2cFZkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALqVohfQZu=itUyfU7nubJpgBETh2q7W1TVx=c2E32ey2cFZkA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 11:10:45AM -0400, Thomas Guyot-Sionnest wrote:

> > So, my last point is the most important of the three. I'd expect
> > something more along the lines of:
> >
> >   1. diff_fill_oid_info resolve the link to the pipe, and
> >   2. index_path handles the resolved fd.
> >
> > ...but it looks like that is already what it's doing? I'm confused why
> > this doesn't work as-is.
> 
> So the idea is to checksum the data and write a valid oid. I'll see if
> I can figure that out. Thanks for the hint though else I would likely
> have gone with a buffer and memcmp. Your solution seems cleaner, and
> there is a few other uses of oideq's that look dubious at best with
> the case of null oids / buffered data so it's definitely a better
> approach.

You're generally better off not to compute the oid just to compare two
buffers:

  - a byte-by-byte comparison can quit early as soon as it sees a
    difference, whereas computing two hashes has to cover each byte

  - even in the worst case that the byte comparison has to go all the
    way to the end, it's way faster than computing a sha1

So generally in the diff code we compare oids if we got them for free
(from the index, or from a tree), but otherwise it's OK to have
filespecs without the oid_valid flag set, and compare them byte-wise
when necessary. And there something like:

  if (one->size == two->size &&
      !memcmp(one->data, two->data, one->size))

is what you'd want.

Note that filespecs may not have their data or size loaded yet, though.
Looking at that part of builtin_diffstat(), I'm pretty sure that is
possible here (see how later code calls diff_populate_filespec() to make
sure it has data). OTOH, I guess if they're from stdin we'd always have
the data (since we'd have no oid to load from), so it might be OK under
that conditional.

-Peff
