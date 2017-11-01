Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457FC202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 22:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933416AbdKAWPp (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 18:15:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:43298 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933294AbdKAWPo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 18:15:44 -0400
Received: (qmail 29806 invoked by uid 109); 1 Nov 2017 22:15:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 22:15:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16004 invoked by uid 111); 1 Nov 2017 22:15:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 18:15:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Nov 2017 18:15:42 -0400
Date:   Wed, 1 Nov 2017 18:15:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 2/3] http-push: use hex_to_bytes()
Message-ID: <20171101221541.6dwezd4t4hweuis2@sigill.intra.peff.net>
References: <508b1b3f-6b55-eee8-110a-c17d572ec27a@web.de>
 <31ce5c1c-cab3-80aa-623b-43f91ddd2162@web.de>
 <20171101195530.odscytks7jvgukbs@sigill.intra.peff.net>
 <0e7f821a-94ae-3946-fb99-c508a06a6847@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e7f821a-94ae-3946-fb99-c508a06a6847@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 01, 2017 at 10:59:49PM +0100, René Scharfe wrote:

> > The hex_to_bytes() function requires that the caller make sure they have
> > the right number of bytes. But for many callers, I think they'd want to
> > say "parse this oid, which might be truncated; I can't tell what the
> > length is supposed to be".
> 
> I'm confused by the word "many".  After this series there are three
> callers of hex_to_bytes() and I don't expect that number to grow.

I meant only that most callers that parse oids, both in-file and not,
would want to stop knowing about the length ahead of time. I think
parse_oid_hex() solves that problem for most callers.

> Would loose objects be stored at paths containing only a subset of their
> new hash value?  If they won't then there will be two acceptable lengths
> instead of the one we have today, which should be easy to handle.

I don't know. TBH, I'm not sure anyone has much interest in making
http-push work with new hashes. I'd be OK if it simply doesn't until
somebody interested shows up to change that.

> > We don't need to deal with that eventuality yet, but I'm on the fence on
> > whether this patch is making that harder down the road or not. The
> > current strategy of "stuff it into a buffer without slashes" would be
> > easier to convert, I think.
> 
> How so?  If you have a buffer then you need to know the size of the
> data to copy into it as well, or you'll learn it in the process.
> 
> The call sites of hex_to_bytes() have to be modified along with the
> functions in hex.c to support longer hashes, with or without this
> series.

You have to know how big the data you have is, but you don't necessarily
know whether that makes a complete hash or not. With a "remove slashes
and then parse" strategy, you can do the removing without worrying about
how big things are _supposed_ to be, and then the parser can tell you if
you have a valid oid or not. The logic for what a hash looks like _and_
how big it must be are both in the parser.

With the new code you have here, we have to be a bit more intimate with
SHA1_HEXSZ in the calling code. It knows that the hash consists of a
certain number of hex bytes.

I'm perfectly willing to punt on it for now. I'm not sure we know 100%
yet what "new"-style hashes will look like, nor how their loose-object
filenames would look.

-Peff
