Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843A4C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 20:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6872361220
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 20:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhFXUDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 16:03:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:60060 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232370AbhFXUDG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 16:03:06 -0400
Received: (qmail 13353 invoked by uid 109); 24 Jun 2021 20:00:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jun 2021 20:00:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16183 invoked by uid 111); 24 Jun 2021 20:00:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Jun 2021 16:00:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Jun 2021 16:00:46 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 3/4] midx: don't reuse corrupt MIDXs when writing
Message-ID: <YNTkbk4eUu3LYVhs@coredump.intra.peff.net>
References: <cover.1624473543.git.me@ttaylorr.com>
 <a216c0c5a3ed5060ffc4d768fc10a663ac0af96d.1624473543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a216c0c5a3ed5060ffc4d768fc10a663ac0af96d.1624473543.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 02:39:12PM -0400, Taylor Blau wrote:

> Suppose we experience a memory corruption while writing a MIDX such that
> we write an incorrect object offset (or alternatively, the disk corrupts
> the data after being written, but before being reused). Then when we go
> to write a new MIDX, we'll reuse the bad object offset without checking
> its validity. This means that the MIDX we just wrote is broken, but its
> trailing checksum is in-tact, since we never bothered to look at the
> values before writing.
> 
> In the above, a "git multi-pack-index verify" would have caught the
> problem before writing, but writing a new MIDX wouldn't have noticed
> anything wrong, blindly carrying forward the corrupt offset.
> 
> Individual pack indexes check their validity by verifying the crc32
> attached to each entry when carrying data forward during a repack.
> We could solve this problem for MIDXs in the same way, but individual
> crc32's don't make much sense, since their entries are so small.
> Likewise, checking the whole file on every read may be prohibitively
> expensive if a repository has a lot of objects, packs, or both.
> 
> But we can check the trailing checksum when reusing an existing MIDX
> when writing a new one. And a corrupt MIDX need not stop us from writing
> a new one, since we can just avoid reusing the existing one at all and
> pretend as if we are writing a new MIDX from scratch.

Nicely explained. This is not saving us from any corruption, but it is
noticing it sooner and helping us better diagnose the root problem
(e.g., in our real-world case it is still only a guess that the data was
corrupted after write, though there was strong correlating evidence).

I wondered what the performance implications might be.

In my fully-packed clone of linux.git with no midx, I get (before your
patch):

  $ time git multi-pack-index write
  real	0m1.358s
  user	0m1.119s
  sys	0m0.185s

Running again immediately is much faster, because we realize there's
nothing new to pack:

  $ time git multi-pack-index write
  real	0m0.007s
  user	0m0.000s
  sys	0m0.007s

If we create a dummy pack, then we do real work, which seems to take
about the same amount of time as generating from scratch:

  $ git pack-objects .git/objects/pack/pack </dev/null
  029d08823bd8a8eab510ad6ac75c823cfd3ed31e
  Total 0 (delta 0), reused 0 (delta 0), pack-reused 0

  $ time git multi-pack-index write
  real	0m1.399s
  user	0m1.126s
  sys	0m0.209s

which makes sense. Even if we are reusing the midx, there is no speedup
to be gained versus the original single-pack (whereas with many packs,
it would be an improvement to use the midx rather than going back to
each pack idx).

Running the same sequence (after deleting the midx and the dummy pack)
using your patch, the initial write is the same (unsurprising, since
there is no midx to check). The final case (with the dummy pack)
becomes:

  $ time git multi-pack-index write
  real	0m1.947s
  user	0m1.668s
  sys	0m0.216s

So we really do pay a 500-600ms penalty to to look at the checksum. IMHO
that is worth it, given the overall cost of the write operation, but I
was surprised how big it was as a relative cost.

There is one more interesting thing, though. The 7ms "noop" version
where we don't write anything also gets more expensive:

  $ time git multi-pack-index write
  real	0m0.550s
  user	0m0.537s
  sys	0m0.013s

I suspect we could avoid that by pushing our checksum validation down a
bit further in the function, but I'm not sure if that creates further
problems (i.e., if we'd already have started trusting some of the midx's
data by then).

I'm not sure if this "noop" midx write is common enough to worry too
much about. Presumably whatever triggers "multi-pack-index write" is
doing so because it just created or removed some packs. If it knows that
what it did was a noop, it's probably better off skipping the call to
git-multi-pack-index entirely.

All of which is to say this looks just fine to me. But I think we should
make a conscious decision on the performance implications (and seeing
the real numbers, it is quite clear that checking the trailer checksum
on normal reads is _way_ too expensive).

-Peff
