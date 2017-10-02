Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEDFD20281
	for <e@80x24.org>; Mon,  2 Oct 2017 19:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbdJBThe (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 15:37:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:58086 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751252AbdJBThd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 15:37:33 -0400
Received: (qmail 11392 invoked by uid 109); 2 Oct 2017 19:37:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 19:37:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32024 invoked by uid 111); 2 Oct 2017 19:38:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 15:38:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 15:37:31 -0400
Date:   Mon, 2 Oct 2017 15:37:31 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20171002193730.2ig5ceaasha47f2y@sigill.intra.peff.net>
References: <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
 <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1709142037490.4132@virtualbox>
 <20170926170502.GY31762@io.lakedaemon.net>
 <alpine.DEB.2.21.1.1709262356360.40514@virtualbox>
 <20171002140011.GE31762@io.lakedaemon.net>
 <CA+55aFyb=h1V-3tkESY8jkc356k5rcQRmjr6o_8p6ZgKMp=Jag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFyb=h1V-3tkESY8jkc356k5rcQRmjr6o_8p6ZgKMp=Jag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 10:18:02AM -0700, Linus Torvalds wrote:

> On Mon, Oct 2, 2017 at 7:00 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> >
> > Ahhh, so if I understand you correctly, you'd prefer SHA-256 over
> > SHA3-256 because it's more performant for your usecase?  Well, that's a
> > completely different animal that cryptographic suitability.
> 
> In almost all loads I've seen, zlib inflate() cost is a bigger deal
> than the crypto load. The crypto people talk about cycles per byte,
> but the deflate code is what usually takes the page faults and cache
> misses etc, and has bad branch prediction. That ends up easily being
> tens or thousands of cycles, even for small data.

If anyone is interested in the user-visible effects of slower crypto, I
think, there are some numbers in 8325e43b82 (Makefile: add DC_SHA1 knob,
2017-03-16). I don't know how SHA-256 compares to sha1dc exactly, but
certainly the latter is a lot slower than normal sha1.

The only real-world case I found with a noticeable slowdown was
index-pack.  Which in the worst case is roughly the same operation as
"git fsck" (inflate and compute the sha1 on every byte), but people tend
to actually do it a lot more often.

And it really _is_ slower for real-world operations; the CPU for
computing the sha1 of an incoming clone of linux.git jumped from ~3
minutes to ~6 minutes.  But I don't think we've seen a lot of
complaints, probably because that time is lumped in with "time to
transfer a gigabyte of data", so unless you're on a slow machine on fast
connection, you don't even really notice.

For day-to-day operations in a repository, I never came up with a good
example where the speed difference mattered. I think Dscho's giant-index
example is an outlier and the right answer there is not "pick a fast
crypto algorithm" but "stop using a slow crypto algorithm as a
checksum" (and also, stop routinely reading and writing 400MB for
day-to-day operations).

-Peff
