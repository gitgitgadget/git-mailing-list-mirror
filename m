Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DC5B2022D
	for <e@80x24.org>; Sun, 26 Feb 2017 21:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbdBZVwY (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 16:52:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:34491 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751292AbdBZVwY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 16:52:24 -0500
Received: (qmail 8369 invoked by uid 109); 26 Feb 2017 21:52:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Feb 2017 21:52:23 +0000
Received: (qmail 4843 invoked by uid 111); 26 Feb 2017 21:52:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Feb 2017 16:52:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Feb 2017 16:52:20 -0500
Date:   Sun, 26 Feb 2017 16:52:20 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jason Cooper <git@lakedaemon.net>,
        ankostis <ankostis@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, David Lang <david@lang.hm>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>
Subject: Re: SHA1 collisions found
Message-ID: <20170226215220.jckz6yzgben4zbyz@sigill.intra.peff.net>
References: <xmqqk28f4fti.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaZWe-8pMZnQv7uZtr8wXWawFeJjUa68-b0oa4yFo-HcA@mail.gmail.com>
 <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com>
 <CA+dhYEVOyACM9ARP2deKVLm1hHOVsTah1WfGoNzGGKO6CGrQpw@mail.gmail.com>
 <xmqqh93j1g9n.fsf@gitster.mtv.corp.google.com>
 <CA+dhYEVwLGNZh-hbcJm+kMR4W45VbwvSVY+7YKt0V9jg_b_M4g@mail.gmail.com>
 <20170226001607.GH11350@io.lakedaemon.net>
 <20170226173810.fp2tqikrm4nzu4uk@genre.crustytoothpaste.net>
 <CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com>
 <CACBZZX6fP_JpL+K3XUnke=4m4gZBLu-Afyz5yJkrRnGXHuhR8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6fP_JpL+K3XUnke=4m4gZBLu-Afyz5yJkrRnGXHuhR8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 26, 2017 at 10:38:35PM +0100, Ævar Arnfjörð Bjarmason wrote:

> On Sun, Feb 26, 2017 at 8:11 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > But yes, SHA3-256 looks like the sane choice. Performance of hashing
> > is important in the sense that it shouldn't _suck_, but is largely
> > secondary. All my profiles on real loads (well, *my* real loads) have
> > shown that zlib performance is actually much more important than SHA1.
> 
> What's the zlib v.s. hash ratio on those profiles? If git is switching
> to another hashing function given the developments in faster
> compression algorithms (gzip v.s. snappy v.s. zstd v.s. lz4)[1] we'll
> probably switch to another compression algorithm sooner than later.
> 
> Would compression still be the bottleneck by far with zstd, how about with lz4?
> 
> 1. https://code.facebook.com/posts/1658392934479273/smaller-and-faster-data-compression-with-zstandard/

zstd does help in normal operations that access lots of blobs. Here are
some timings:

  http://public-inbox.org/git/20161023080552.lma2v6zxmyaiiqz5@sigill.intra.peff.net/

Compression is part of the on-the-wire packfile format, so it introduces
compatibility headaches. Unlike the hash, it _can_ be a local thing
negotiated between the two ends, and a server with zstd data could
convert on-the-fly to zlib. You just wouldn't want to do so on a server
because it's really expensive (or you double your cache footprint to
store both).

If there were a hash flag day, we _could_ make sure all post-flag-day
implementations have zstd, and just start using that (it transparently
handles old zlib data, too). I'm just hesitant to through in the kitchen
sink and make the hash transition harder than it already is.

Hash performance doesn't matter much for normal read operations. If your
implementation is really _slow_ it does matter for a few operations
(notably index-pack receiving a large push or fetch). Some timings:

  http://public-inbox.org/git/20170223230621.43anex65ndoqbgnf@sigill.intra.peff.net/

If the new algorithm is faster than SHA-1, that might be measurable in
those operations, too, but obviously less dramatic, as hashing is just a
percentage of the total operation (so it can balloon the time if it's
slow, but optimizing it can only save so much).

I don't know if the per-hash setup cost of any of the new algorithms is
higher than SHA-1. We care as much about hashing lots of small content
as we do about sustained throughput of a single hash.

-Peff
