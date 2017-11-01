Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF681202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 19:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbdKATzd (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 15:55:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:43068 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933035AbdKATzc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 15:55:32 -0400
Received: (qmail 24800 invoked by uid 109); 1 Nov 2017 19:55:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 19:55:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14815 invoked by uid 111); 1 Nov 2017 19:55:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 15:55:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Nov 2017 15:55:30 -0400
Date:   Wed, 1 Nov 2017 15:55:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 2/3] http-push: use hex_to_bytes()
Message-ID: <20171101195530.odscytks7jvgukbs@sigill.intra.peff.net>
References: <508b1b3f-6b55-eee8-110a-c17d572ec27a@web.de>
 <31ce5c1c-cab3-80aa-623b-43f91ddd2162@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31ce5c1c-cab3-80aa-623b-43f91ddd2162@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 02:49:56PM +0100, René Scharfe wrote:

> The path of a loose object contains its hash value encoded into two
> substrings of hexadecimal digits, separated by a slash.  The current
> code copies the pieces into a temporary buffer to get rid of the slash
> and then uses get_oid_hex() to decode the hash value.
> 
> Avoid the copy by using hex_to_bytes() directly on the substrings.
> That's shorter and easier.
> 
> While at it correct the length of the second substring in a comment.

I think the patch is correct, but I wonder if this approach will bite us
later on when we start dealing with multiple lengths of hashes.

The hex_to_bytes() function requires that the caller make sure they have
the right number of bytes. But for many callers, I think they'd want to
say "parse this oid, which might be truncated; I can't tell what the
length is supposed to be".

I.e., I wonder if the right primitive is really something like
parse_oid_hex(), but with a flag to say "skip over interior slashes".

We don't need to deal with that eventuality yet, but I'm on the fence on
whether this patch is making that harder down the road or not. The
current strategy of "stuff it into a buffer without slashes" would be
easier to convert, I think.

-Peff
