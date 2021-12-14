Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512F0C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 13:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhLNNgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 08:36:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:51420 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234453AbhLNNgb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 08:36:31 -0500
Received: (qmail 13651 invoked by uid 109); 14 Dec 2021 13:36:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Dec 2021 13:36:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24498 invoked by uid 111); 14 Dec 2021 13:36:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Dec 2021 08:36:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Dec 2021 08:36:29 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v2 1/5] range-diff: zero out elements in "cost" first
Message-ID: <Ybid3ajK5/zimo6/@coredump.intra.peff.net>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com>
 <RFC-patch-v2-1.5-068c203adc6-20211210T122901Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RFC-patch-v2-1.5-068c203adc6-20211210T122901Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 01:30:38PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Have the get_correspondences() function use CALLOC_ARRAY instead of
> looping over the newly allocated "cost" to zero out some of its
> elements.
> 
> The for-loop that zero'd out elements in "cost" wasn't the first loop
> in that function, nor did it cover all of its elements, but regardless
> of that this change doesn't affect its end-state. None of the
> for-loops touched the same items in the array, so we could have (and
> an earlier WIP version of this change did) moved the for-loop we're
> deleting to come first in get_correspondences().
> 
> This can be seen from a careful reading of this code added in in
> d9c66f0b5bf (range-diff: first rudimentary implementation,
> 2018-08-13) (as well as adding some printf-debugging) we'll set all
> elements in the in the "n * n" allocated array. That's "n = A+B" where
> "A" and "B" are the number of commits in our respective ranges.

It took me several readings to understand this argument. I think it's
just:

  When setting up the 2-dimensional "cost" array, we first fill in all
  rows 0..a->nr, and then all columns 0..b->nr. After that, we zero the
  rest of the array: slots which are both in rows greater than a->nr
  _and_ columns greater than b->nr.

  We can instead just zero everything from the start with
  CALLOC_ARRAY() and skip the final zero-ing.

I'm not necessarily asking for a re-roll with the message, but just
re-stating it to make sure I understand what's going on.

> So let's just allocate this with CALLOC_ARRAY(), and skip these two
> for-loops.

The first part tells us it's not wrong to do this change. But it doesn't
give us a "why". Is it just simpler code? We think it might be faster to
calloc than hand-rolling?

The "two for-loops" confused me for a minute. Really there are two
separate cases:

  - we can calloc the "cost" array and drop the final zero-ing loop in
    get_correspondences(), per the argument above

  - we can calloc the a2b and b2a arrays, which saves
    compute_assignment() from doing it itself later. Though this is a
    little weird, since it may zero them or it may set all entries to
    -1.

Given the large explanation needed for the first one (above), and then
this totally distinct explanation for the second one:

> Furthermore let's remove the early exit condition from
> compute_assignment() in favor of an assert that it must be called with
> "column_count > 1", then "get_correspondences()" can skip calling it
> when no further filling of the "a2b" and "b2a" arrays is needed.

...it kind of feels like they ought to be separate patches. At the very
least, it would be nice if the two cases were laid out more clearly at
the start of the commit message.

I do find the movement of this column_count check strange. It feels like
it's breaking the encapsulation of compute_assignment(); now its caller
knows more about when it might zero things and when it might do an
actual computation. And it makes things more complicated (we have a
conditional in the sole caller _and_ we have an assert to make sure the
caller checked that conditional).

But maybe this is really important for some later refactor. I'll keep
reading...

-Peff
