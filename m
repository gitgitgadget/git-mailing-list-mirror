Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21FD01F516
	for <e@80x24.org>; Thu, 21 Jun 2018 18:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933253AbeFUSvO (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 14:51:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:50978 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933237AbeFUSvN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 14:51:13 -0400
Received: (qmail 1927 invoked by uid 109); 21 Jun 2018 18:51:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Jun 2018 18:51:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9228 invoked by uid 111); 21 Jun 2018 18:51:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Jun 2018 14:51:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jun 2018 14:51:11 -0400
Date:   Thu, 21 Jun 2018 14:51:11 -0400
From:   Jeff King <peff@peff.net>
To:     Sebastian Kisela <skisela@redhat.com>, git@vger.kernel.org,
        nico@fluxnic.net, larsxschneider@gmail.com, lfleischer@lfos.de
Subject: Re: [PATCH] Sanitize escape char sequences coming from server
Message-ID: <20180621185111.GA1046@sigill.intra.peff.net>
References: <20180621121030.1721-1-sebastian.kisela@gmail.com>
 <20180621174122.GA30249@sigill.intra.peff.net>
 <20180621180942.GA32506@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180621180942.GA32506@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 21, 2018 at 08:09:43PM +0200, Pavel Cahyna wrote:

> > > +	int len = mbstowcs(wcstring, outbuf->buf, outbuf->len);
> > 
> > I don't think mbstowcs() is always going to do the right thing there.
> > We're looking at a string that was sent from the remote server. What
> > encoding is it in? Using mbstowcs() is going to use whatever is in
> > LC_CTYPE on the local machine.
> 
> Exactly. The point is, everything should continue to work if the local
> machine and the server agreed on the encoding. Imagine a
> non-English-speaking site where the administrators configured the Git
> server to output non-ASCII messages and the clients are configured with
> a matching locale which allows the users to see them. We should ensure
> everything keeps working in this case.

What if they don't agree on the encoding? Right now you might get some
mojibake. After this patch, we'd return an error.

I thought at first we'd stop showing the message, which would be a
regression. But looking at the caller, it does not actually break on
seeing the error. Which means that the whole sanitizing process can be
skipped simply by the attacker including a bogus multibyte sequence.

> > Using isprint() here probably doesn't do what you expect, because Git
> > uses its own locale-agnostic ctype replacements. I didn't check, but I
> > suspect any non-ascii characters will be marked as non-printable, making
> > the whole wchar thing pointless.
> 
> isw*() was probably intended instead of is*()

Yes, we don't override the isw* functions, so that would work (I still
think that assuming the server messages are in our local charset is
somewhat questionable).

> > > +
> > > +				if (sanitize_server_message(&outbuf))
> > > +					retval = SIDEBAND_REMOTE_ERROR;
> > 
> > "outbuf" may contain partially-received lines at various points, meaning
> > multi-byte characters could be cut off. I _think_ it's OK to look at it
> > here, as we'd always be breaking on a "\r" or "\n" at this point.
> 
> Maybe sanitize_server_message should return a mbstate_t to keep state
> between invocations?

I think this site is OK because of the CR/LF breaking. For the "final"
one where it's not OK, there's no point in keeping state since we know
we hit EOF already.

-Peff
