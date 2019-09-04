Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CEF71F461
	for <e@80x24.org>; Wed,  4 Sep 2019 05:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfIDFEn (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 01:04:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:38694 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725877AbfIDFEn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 01:04:43 -0400
Received: (qmail 18639 invoked by uid 109); 4 Sep 2019 05:04:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Sep 2019 05:04:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11674 invoked by uid 111); 4 Sep 2019 05:06:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Sep 2019 01:06:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Sep 2019 01:04:42 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] upload-pack: fix race condition in error messages
Message-ID: <20190904050441.GB6488@sigill.intra.peff.net>
References: <20190828145412.GB14432@sigill.intra.peff.net>
 <20190828153944.GA29715@sigill.intra.peff.net>
 <20190828161552.GE8571@szeder.dev>
 <4d5773f9-4637-d8a3-d683-82624950f319@gmail.com>
 <20190829141307.GE1797@sigill.intra.peff.net>
 <131dfa37-0f65-f0c3-6f30-5b6eca12d9c0@gmail.com>
 <20190829143805.GB1746@sigill.intra.peff.net>
 <20190829215818.GG8571@szeder.dev>
 <20190829220630.GH8571@szeder.dev>
 <20190830121005.GI8571@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190830121005.GI8571@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 30, 2019 at 02:10:05PM +0200, SZEDER Gábor wrote:

> On Fri, Aug 30, 2019 at 12:06:30AM +0200, SZEDER Gábor wrote:
> > On Thu, Aug 29, 2019 at 11:58:18PM +0200, SZEDER Gábor wrote:
> > > On Thu, Aug 29, 2019 at 10:38:05AM -0400, Jeff King wrote:
> > > > So any fixes there have to happen on the client side. I am still
> > > > confused about why the client is writing in this case, per the argument
> > > > in 014ade7484 (upload-pack: send ERR packet for non-tip objects,
> > > > 2019-04-13). It would be nice to use GIT_TRACE_PACKET to see what it's
> > > > trying to write, but I still haven't been able to reproduce the issue.
> > > 
> > > It's the "done" line:
> > > 
> > >   + cat trace-packet
> [...]
> > >   packet:  upload-pack> 0000
> > >   packet:        fetch> done
> > > 
> > > In the avarage successful run that "fetch> done" pkt-line is
> > > immediately after the "fetch> 0000".

Thanks for all of your persistent digging on this. I had forgotten about
the "done" packet, but it explains all of the symptoms we've seen.

> So instead of immediately die()int after write_in_full() returned an
> error, fetch should first try to read all incoming packets in the hope
> that the remote did send an ERR packet before it died, and then die
> with the error in that packet, or fall back to the current generic
> error message if there is no ERR packet (e.g. remote segfaulted or
> something similarly horrible).  This fixes the test failure with that
> strategically-placed sleep() in 'fetch-pack.c'.
> 
>   https://travis-ci.org/szeder/git/jobs/578778749#L2689
> 
> Alas, passing a 'reader' to a function called send_request() doesn't
> look quite right, does it...  And I'm not sure about the stateless
> communication, it still uses write_or_die().

And thank you for putting this patch together. I had taken a stab at it
a while ago, but got discouraged by figuring out at which layer to add
the "reader" info (I had envisioned it much lower in packet_write(), but
it is clear from your patch that fetch-pack does most of its own
writing).

I agree passing around the reader is a bit weird; I wonder if we should
be representing the full-duplex connection more clearly as a single
struct. But I suspect that creates other headaches, and what you have
here doesn't look _too_ bad. As you note, it probably doesn't cover all
code paths, but it at least fixes some of them, and gives us a template
for addressing the others.

>  	} else {
> -		if (write_in_full(fd, buf->buf, buf->len) < 0)
> +		if (write_in_full(fd, buf->buf, buf->len) < 0) {
> +			int save_errno = errno;
> +			/*
> +			 * Read everything the remote has sent to us.
> +			 * If there is an ERR packet, then the loop die()s
> +			 * with the received error message.
> +			 * If we reach EOF without seeing an ERR, then die()
> +			 * with a generic error message, most likely "Broken
> +			 * pipe".
> +			 */
> +			while (packet_reader_read(reader) != PACKET_READ_EOF);
> +			errno = save_errno;
>  			die_errno(_("unable to write to remote"));
> +		}

One unfortunate thing here is that we could block indefinitely in
packet_reader_read(). That shouldn't happen, I don't think, but since
this is an error case where we've been cutoff, anything's possible.

We maybe could get away with using non-blocking I/O. We're looking for
an ERR packet the other side sent us _before_ it hung up, so in theory
we've have received the data before any FIN packet (or EOF on a pipe).
But I'm wary of introducing new races there.

It might be enough to put in an actual timer, waiting for an ERR packet,
EOF, or something like 5 seconds. Or maybe I'm just being overly
paranoid.

-Peff
