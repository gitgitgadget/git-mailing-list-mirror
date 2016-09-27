Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D84B51F4F8
	for <e@80x24.org>; Tue, 27 Sep 2016 08:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbcI0Ijp (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 04:39:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:48690 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751636AbcI0Ijm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 04:39:42 -0400
Received: (qmail 29212 invoked by uid 109); 27 Sep 2016 08:39:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 08:39:41 +0000
Received: (qmail 13956 invoked by uid 111); 27 Sep 2016 08:39:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 04:39:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 04:39:39 -0400
Date:   Tue, 27 Sep 2016 04:39:39 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v8 06/11] pkt-line: add packet_write_gently()
Message-ID: <20160927083939.par2ea5nqjrtkkjs@sigill.intra.peff.net>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-7-larsxschneider@gmail.com>
 <55c5a86e-4055-f36d-bbf1-e8bae919088a@gmail.com>
 <4CF26590-7B88-4DB6-B6D4-A6CFE0FD6ABF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4CF26590-7B88-4DB6-B6D4-A6CFE0FD6ABF@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 09:21:10PM +0200, Lars Schneider wrote:

> On 25 Sep 2016, at 13:26, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> > W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
> >> From: Lars Schneider <larsxschneider@gmail.com>
> >> ...
> >> 
> >> +static int packet_write_gently(const int fd_out, const char *buf, size_t size)
> > 
> > I'm not sure what naming convention the rest of Git uses, but isn't
> > it more like '*data' rather than '*buf' here?
> 
> pkt-line seems to use 'buf' or 'buffer' for everything else.

I do not think we have definite rules, but I would generally expect to
see "data" as an opaque thing (e.g., passing "void *data" to callbacks).
"buf" or "buffer" makes sense here, but I don't think it really matters
that much either way.

> >> +	static char packet_write_buffer[LARGE_PACKET_MAX];
> > 
> > I think there should be warning (as a comment before function
> > declaration, or before function definition), that packet_write_gently()
> > is not thread-safe (nor reentrant, but the latter does not matter here,
> > I think).
> > 
> > Thread-safe vs reentrant: http://stackoverflow.com/a/33445858/46058
> > 
> > This is not something terribly important; I guess git code has tons
> > of functions not marked as thread-unsafe...
> 
> I agree that the function is not thread-safe. However, I can't find 
> an example in the Git source that marks a function as not thread-safe.
> Unless is it explicitly stated in the coding guidelines I would prefer
> not to start way to mark functions.

I'd agree. A large number of functions in git are not reentrant, and I
would not want to give the impression that those missing a warning are
safe to use.

> >> +	if (size > sizeof(packet_write_buffer) - 4) {
> > 
> > First, wouldn't the following be more readable:
> > 
> >  +	if (size + 4 > LARGE_PACKET_MAX) {
> 
> Peff suggested that here:
> http://public-inbox.org/git/20160810132814.gqnipsdwyzjmuqjy@sigill.intra.peff.net/

There is a good reason to do size checks as a subtraction from a known
quantity: you can be sure that you are not introducing an overflow
(e.g., Jakub's suggestion does the wrong thing when "size" is within 4
bytes of its maximum value). That's unlikely in this case, but then so
is the size exceeding LARGE_PACKET_MAX in the first place (arguably this
should be a die("BUG"), because it is the caller's responsibility to
split their packets.

-Peff
