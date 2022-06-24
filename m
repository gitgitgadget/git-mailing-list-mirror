Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6A6C43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 10:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiFXKwk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 06:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiFXKwj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 06:52:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7057C844
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 03:52:38 -0700 (PDT)
Received: (qmail 8786 invoked by uid 109); 24 Jun 2022 10:52:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Jun 2022 10:52:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18165 invoked by uid 111); 24 Jun 2022 10:52:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Jun 2022 06:52:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Jun 2022 06:52:36 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stephen Smith <ischis2@cox.net>, git <git@vger.kernel.org>
Subject: Re: SHA-256 transition
Message-ID: <YrWXdNGZGN7gXL40@coredump.intra.peff.net>
References: <12011256.O9o76ZdvQC@thunderbird>
 <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
 <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 22, 2022 at 12:29:59AM +0000, brian m. carlson wrote:

> > We've since migrated our default hash function from SHA-1 to SHA-1DC
> > (except on vanilla OSX, see [2]). It's a variant SHA-1 that detects the
> > SHAttered attack implemented by the same researchers. I'm not aware of a
> > current viable SHA-1 collision against the variant of SHA-1 that we
> > actually use these days.
> 
> That's true, but that still doesn't let you store the data.  There is
> some data that you can't store in a SHA-1 repository, and SHA-1DC is
> extremely slow.  Using SHA-256 can make things like indexing packs
> substantially faster.

I'm curious if you have numbers on this. I naively converted linux.git
to sha256 by doing "fast-export | fast-import" (the latter in a sha256
repo, of course, and then both repacked with "-f --window=250" to get
reasonable apples-to-apples packs).

Running "index-pack --verify" on the result takes about the same time
(this is on an 8-core system, hence the real/user differences):

  [sha1dc]
  real	2m43.754s
  user	10m52.452s
  sys	0m36.745s

  [sha256]
  real	2m41.884s
  user	12m23.344s
  sys	0m35.222s

The sha256 repo actually has about 10% fewer objects (I didn't
investigate, but this is perhaps due to cutting out tags and a few other
things to convince fast-export to finish running). I'm not sure about
the extra user time (multicore timings here are funny because of
frequency scaling, so I think the "real" line is more interesting). So
sha256 actually comes out a bit worse here. On the other hand, this is
just using our blk_SHA256 implementation. There may be faster
alternatives (including ones with hardware support).

I wouldn't be at all surprised if the difference isn't substantial in
the long run, though. The repo is on the order of 100GB of object data.
That's a lot to hash, but it's also just a lot to deal with at all (zlib
inflating, applying deltas, etc).

Anyway, this is a pretty rough cut at an experiment. I was mostly
curious if you had done something more advanced, and/or gotten different
results.

-Peff
