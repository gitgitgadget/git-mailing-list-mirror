Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F5FC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 18:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiGASAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 14:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGASAO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 14:00:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDC33DDD5
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 11:00:13 -0700 (PDT)
Received: (qmail 9576 invoked by uid 109); 1 Jul 2022 18:00:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Jul 2022 18:00:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27517 invoked by uid 111); 1 Jul 2022 18:00:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Jul 2022 14:00:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Jul 2022 14:00:12 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stephen Smith <ischis2@cox.net>, git <git@vger.kernel.org>
Subject: Re: SHA-256 transition
Message-ID: <Yr82LITalM8JX753@coredump.intra.peff.net>
References: <12011256.O9o76ZdvQC@thunderbird>
 <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
 <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
 <YrWXdNGZGN7gXL40@coredump.intra.peff.net>
 <YrbNIUnftj+Ooumo@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrbNIUnftj+Ooumo@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 25, 2022 at 08:53:53AM +0000, brian m. carlson wrote:

> > I'm curious if you have numbers on this. I naively converted linux.git
> > to sha256 by doing "fast-export | fast-import" (the latter in a sha256
> > repo, of course, and then both repacked with "-f --window=250" to get
> > reasonable apples-to-apples packs).
> 
> I did the same thing, except I just did a regular gc and not a custom
> repack, and I created both a SHA-1 and SHA-256 repo from the same
> original.

That _might_ influence your timings a bit, just because the fast-import
packs have lousy deltas. I think my linux.git was something like 6GB
from fast-import, packed down to 1.5GB after "repack -f".

But I'm not sure if it would change the direction of the trend of what
you were measuring, only the magnitude. We'll hash the same bytes in
either case, but in the fast-import pack we'd spend more time on zlib
inflating and less time on delta reconstruction. Which one is more
expensive probably depends on a lot of factors, but it's entirely
possible that running your test after a "repack -f" would actually show
a greater change between the two cases.

> Here are my results:
> 
> [sha256]
> time ~/checkouts/git/git index-pack --verify .git/objects/pack/pack-*.pack
> ~/checkouts/git/git index-pack --verify .git/objects/pack/pack-*.pack  2768.42s user 181.00s system 185% cpu 26:31.70 total
> 
> [sha1dc]
> time ~/checkouts/git/git index-pack --verify .git/objects/pack/pack-*.pack
> ~/checkouts/git/git index-pack --verify .git/objects/pack/pack-*.pack  3041.28s user 184.84s system 199% cpu 26:54.74 total
> 
> Note that in my case, I'm using an accelerated hardware-based SHA-256
> implementation (Nettle, which I will send a patch for soon).  This is a
> brand new ThinkPad X1 Carbon Gen 10 with an i7-1280P (with 20 "cores" of
> different sizes).

OK, that probably explains the difference in results we saw. Thanks for
sharing your numbers.  I think that's pretty "apples to apples" since
we'd hope that sha256 will eventually be accelerated, but sha1dc never
will be.

-Peff
