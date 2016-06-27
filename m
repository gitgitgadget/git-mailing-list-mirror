Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC71D1FE4E
	for <e@80x24.org>; Mon, 27 Jun 2016 21:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbcF0Vtv (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 17:49:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:33719 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751639AbcF0Vtv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 17:49:51 -0400
Received: (qmail 9960 invoked by uid 102); 27 Jun 2016 21:49:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 17:49:50 -0400
Received: (qmail 13810 invoked by uid 107); 27 Jun 2016 21:50:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 17:50:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jun 2016 17:49:48 -0400
Date:	Mon, 27 Jun 2016 17:49:48 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] xread: retry after poll on EAGAIN/EWOULDBLOCK
Message-ID: <20160627214947.GA17149@sigill.intra.peff.net>
References: <20160626232112.721-1-e@80x24.org>
 <20160626232112.721-2-e@80x24.org>
 <20160626234251.GA21668@sigill.intra.peff.net>
 <xmqqoa6mdbu3.fsf@gitster.mtv.corp.google.com>
 <20160627143648.GA2618@sigill.intra.peff.net>
 <CAGZ79kZ94PaOfq3GimWiHULbTE7ihMzL9S=Y+npQ4F5gGwFrsA@mail.gmail.com>
 <20160627201311.GA7039@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160627201311.GA7039@dcvr.yhbt.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 08:13:11PM +0000, Eric Wong wrote:

> > Quite a while ago, when I started doing code reviews professionally, I wondered
> > if the code review procedure can be semi-automated, as automation helps keeping
> > the error rate low. By that I mean having a check list which I can
> > check off each point
> 
> Maybe a test case or even a small unit test would've helped.
> I didn't notice the problem in xread until:
> 
> 1) I copied the code into xwrite
> 2) s/POLLIN/POLLOUT/;
> 3) forced EAGAIN using a patched, home-baked HTTP server
> 
> The biggish comment before the poll() obscured the missing
> "continue" for me.  I read xread() before and did not notice
> the missing "continue".

Here's an easier reproduction:

	nonblock () {
		perl -e '
			use Fcntl;
			fcntl(STDIN, F_SETFL, Fcntl::O_NONBLOCK);
			exec @ARGV;
		' "$@"
	}
	{
	  sleep 1
	  git pack-objects --all --stdout </dev/null
	} | nonblock git index-pack --stdin

Or even simpler:

        sleep 1 | nonblock git index-pack --stdin

The first one is nicer because it shows in the working case that we
actually do eventually read the input, as opposed to just getting EOF.
Prior to v2.8.0, or current master with your patch applied, it works
fine.

It turned out to be harder than I thought to find somebody who calls
xread() on stdin.  My first attempt was:

	{
		printf 'HE'
		sleep 1
		printf 'AD\n'
	} |
	nonblock git cat-file --batch-check

but this ends up in strbuf_getwholeline(), which uses getdelim(). Much to
my disappointment, getdelim() does not handle this case transparently;
it will quietly return the first two bytes (though with errno set to
EAGAIN), and we process bogus input.

So in general I would say that handing non-blocking descriptors to git
is not safe. I think it's possible to loop on getdelim() when we see
EAGAIN, but I'm not sure if it's worth it.

> Maybe the following optional patch on top of this series
> improves readability:
> 
> ----------8<--------
> Subject: [PATCH 3/2] hoist out io_wait function for xread and xwrite
> 
> At least for me, this improves the readability of xread and
> xwrite; hopefully allowing missing "continue" statements to
> be spotted more easily.

IMHO the end result is much nicer with this patch.

-Peff
