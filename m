Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B02AC433E6
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41FB206A4
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbhAZWFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:05:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:39770 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbhAZVoT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 16:44:19 -0500
Received: (qmail 27017 invoked by uid 109); 26 Jan 2021 21:43:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Jan 2021 21:43:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3889 invoked by uid 111); 26 Jan 2021 21:43:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Jan 2021 16:43:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Jan 2021 16:43:25 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 2/8] pack-write.c: prepare to write 'pack-*.rev' files
Message-ID: <YBCM/fdZZwoPVsrI@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <8648c87fa71aec427dc11afcba6548fb66a1413b.1610576805.git.me@ttaylorr.com>
 <YAtey9krU32mgEBV@coredump.intra.peff.net>
 <YA8YxtUUwE0lLxQt@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YA8YxtUUwE0lLxQt@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 02:15:18PM -0500, Taylor Blau wrote:

> On Fri, Jan 22, 2021 at 06:24:59PM -0500, Jeff King wrote:
> > On Wed, Jan 13, 2021 at 05:28:11PM -0500, Taylor Blau wrote:
> >
> > [...]
> >
> > qsort? Don't we have a perfectly good radix sort for this exact purpose? :)
> 
> Yeah, I think your argument against it (which I agree with is
> basically):
> 
>   We could, and it would be faster, but it would (1) require allocating
>   twice as much data, and (2) the speed increase is a drop in the bucket
>   on any repository with enough objects to even notice it.
> 
> I'll add something to that effect to the commit message.

Yep, that's accurate.

It might make more of a difference when we eventually have a revindex
cache for a midx (because there we're mostly doing things linear in the
number of objects, and not actually traversing). But I'm quite happy to
punt it until then (or later; even there I'd guess it might shave one
second off a 10-15 second operation. That's not nothing, but if nobody
ever cares enough to implement it, I won't be sad).

> > I forgot to comment on this in patch 1, but: I think the format is
> > really independent of the hash size. The contents are identical for a
> > sha-1 versus sha-256 file.
> 
> Right; the format is identical. That is, the fields are the same, but
> the hashes are longer.

Hmm. Actually, I wasn't thinking it through completely. I thought the
file would literally have the exact same bytes in it, but the packfile
hash as well as the hashfd() trailing hash would both be different
sizes. So even if it doesn't match the packfile (which obviously is a
bug), it would hard to even be able to figure that out without knowing
the hash identifier.

> > That said, I don't overly mind having a hash identifier if it might help
> > debug things (OTOH, how the heck do you end up with one that matches the
> > trailer's packfile but  _doesn't_ match the trailer's contents?).
> >
> > If we do have it, should we also be checking it in the loading function?
> 
> I'm not opposed to it, but I imagined that this field would be primarily
> for debugging purposes. I was surprised to learn that we _don't_ verify
> the checksum for .idx files. So, I'm reluctant to start doing so here,
> honestly.

I think we're talking about two different things. I just meant that if
we see a .rev file that says "I'm sha256", we should make sure we are in
a sha256 repo (since that is what we'd be assuming for the .idx and
.pack files!).

We can't do that same check for .idx files, because they don't have a
hash identifier field in them.

Checking that the pack hash matches the trailer from the packfile is a
separate matter. I also think that's worth doing, but am likewise
surprised that we don't check it for the .idx. I'm OK leaving it out
since we don't do it there, either.

> > I wonder if we could factor out some of this repeated logic, but I
> > suspect it is mostly diminishing returns. Maybe this "open a pack file
> > for writing" could become a helper function, though.
> 
> Yeah. I tried factoring it out before replying, and it's a little gross.
> Most of my discomfort with it lies in the complexity of the parameters.
> 
> Consider extracting the code in write_idx_file():
> 
>   - There would need to be a double pointer for 'index_name' (which is
>     sometimes read, and sometimes written to).
> 
>   - There would be an unsigned bit for "verify" (i.e., "open with
>     hashfd_check() or not").
> 
>   - There would be a "pattern" variable if we were creating a new
>     temporary file with odb_mkstemp().
> 
> Having the caller be forced to juggle the combinations of passing
> NULL/0 or not for each of those three makes me leery that this is worth
> doing, so I tend to agree with your judgement that this provides a
> diminishing return.

Thanks for taking a look. I'm not too surprised it turned out ugly.

-Peff
