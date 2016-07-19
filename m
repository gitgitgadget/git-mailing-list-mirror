Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273871F744
	for <e@80x24.org>; Tue, 19 Jul 2016 10:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbcGSKHh (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 06:07:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:46831 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751959AbcGSKHf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 06:07:35 -0400
Received: (qmail 2550 invoked by uid 102); 19 Jul 2016 10:07:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jul 2016 06:07:36 -0400
Received: (qmail 10543 invoked by uid 107); 19 Jul 2016 10:07:57 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jul 2016 06:07:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jul 2016 04:07:31 -0600
Date:	Tue, 19 Jul 2016 04:07:31 -0600
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 12/12] receive-pack: send keepalives during quiet periods
Message-ID: <20160719100730.GA5193@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
 <20160715104347.GL19271@sigill.intra.peff.net>
 <CAGZ79kbernZHx9SUG-_vbxy-g77_3ki1uc-21LCviwrH=aXp6w@mail.gmail.com>
 <20160716075621.GA10275@sigill.intra.peff.net>
 <CAGZ79kZPbSTAv6zjJ01PdqBOZrsfhRAte_v-mbBzXuOAWNK+Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZPbSTAv6zjJ01PdqBOZrsfhRAte_v-mbBzXuOAWNK+Tg@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 18, 2016 at 10:28:25PM -0700, Stefan Beller wrote:

> On Sat, Jul 16, 2016 at 12:56 AM, Jeff King <peff@peff.net> wrote:
> >> > +               if (use_keepalive == KEEPALIVE_AFTER_NUL && !keepalive_active) {
> >> > +                       const char *p = memchr(data, '\0', sz);
> >> > +                       if (p) {
> >> > +                               /*
> >> > +                                * The NUL tells us to start sending keepalives. Make
> >> > +                                * sure we send any other data we read along
> >> > +                                * with it.
> >> > +                                */
> >> > +                               keepalive_active = 1;
> >> > +                               send_sideband(1, 2, data, p - data, use_sideband);
> >> > +                               send_sideband(1, 2, p + 1, sz - (p - data + 1), use_sideband);
> >> > +                               continue;
> >>
> >> Oh, I see why the turn_on_keepalive_on_NUL doesn't work as well as I thought.
> >> I wonder if we can use a better read function, that would stop reading at a NUL,
> >> and return early instead?
> >
> > How would you do that, if not by read()ing a byte at a time (which is
> > inefficient)? Otherwise you have to deal with the leftovers (after the
> > NUL) in your buffer. It's one of the reasons I went with a single-byte
> > signal, because otherwise it gets rather complicated to do robustly.
> 
> I do not question the concept of a single NUL byte, but rather the
> implementation, i.e. if we had an xread_until_nul you would not need
> to have a double send_sideband here?

What would xread_until_nul() look like?

The only reasonable implementation I can think of is:

  ssize_t xread_until_nul(int fd, char *out, size_t len)
  {
	ssize_t total = 0;
	while (total < len) {
		ssize_t ret = xread(fd, out + total, 1);
		if (ret < 0) {
			/* Oops, anything in out[0..total] is lost, but
			 * we have no way of signaling both a partial
			 * read and an error at the end; fixable by
			 * changing the interface, but doesn't really
			 * matter in practice for this application. */
			return -1;
		}
		if (ret == 0)
			break; /* EOF, stop reading */
		if (out[total] == '\0')
			break; /* got our NUL, stop reading */
		total++;
	}
	return total;
  }

There are two problems with this function:

  1. Until we see the NUL, we're making an excessive number of read()
     syscalls looking for it. You could make larger reads, but then what
     do you do with the residual bytes (i.e., the ones after the NUL in
     the buffer you read)? You'd have to somehow save it to return at
     the next xread_until_nul(). Which implie some kind of internal
     buffering.

     The reason there are two send_sidebands is to cover the case where
     we have some real data, then the signal byte, then some more data.
     So instead of buffering, we just handle the data immediately.

  2. How does it know when to return?

     We want to send the data as soon as it is available, in as large a
     chunk as possible. Using a single xread() as we do now, we get
     whatever the OS has for us, up to our buffer size.

     But after each 1-byte read above, we would not want to return;
     there might be more data. So it keeps reading until NUL or we fill
     our buffer. But that may mean the xread() blocks, even though we
     have data that _could_ be shipped over the sideband.

     To fix that, you'd have to poll() for each xread(), and return when
     it says nothing's ready.

I know that writing the function myself and then critiquing is the very
definition of a strawman. :) But it's the best I could think of.  Maybe
you had something more clever in mind?

-Peff
