Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146B52018E
	for <e@80x24.org>; Sun, 10 Jul 2016 03:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933262AbcGJDri (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 23:47:38 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50362 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933258AbcGJDrh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 23:47:37 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C925C1FE4E;
	Sun, 10 Jul 2016 03:47:36 +0000 (UTC)
Date:	Sun, 10 Jul 2016 03:47:36 +0000
From:	Eric Wong <e@80x24.org>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2016, #03; Fri, 8)
Message-ID: <20160710034736.GA19151@dcvr.yhbt.net>
References: <xmqq37njlora.fsf@gitster.mtv.corp.google.com>
 <20160709234518.GA3702@dcvr.yhbt.net>
 <20160710025232.GA4666@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160710025232.GA4666@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Sat, Jul 09, 2016 at 11:45:18PM +0000, Eric Wong wrote:
> > Junio C Hamano <gitster@pobox.com> wrote:
> > > * sb/submodule-parallel-fetch (2016-06-27) 2 commits
> > >   (merged to 'next' on 2016-07-06 at de5fd35)
> > >  + xwrite: poll on non-blocking FDs
> > >  + xread: retry after poll on EAGAIN/EWOULDBLOCK

> > Any thoughts on my cleanup 3/2 patch for this series?
> > ("hoist out io_wait function for xread and xwrite")
> > https://public-inbox.org/git/20160627201311.GA7039@dcvr.yhbt.net/raw
> > 
> > Jeff liked it:
> > https://public-inbox.org/git/20160627214947.GA17149@sigill.intra.peff.net/
> 
> I did (and do) like it. I think it may have simply gotten lost in the
> mass of "should we handle EAGAIN from getdelim()" patches I sent (to
> which I concluded "probably not").
> 
> There was one minor improvement I suggested[1] (and which you seemed to
> like), which is to push the errno check into the function. That wasn't
> expressed in patch form, though, so I've included below a version of
> your patch with my suggestion squashed in.

Yes, I'm fine with either, but I'm slightly thrown off by
a function relying on errno being set by the caller, even if it
is errno.  So maybe localizing it is better (see below)

> I didn't include the test I mentioned in [2]. I think the potential for
> portability and raciness problems make it probably not worth the
> trouble.

Agreed.

> ---
> Since both conditionals just call "continue", you could actually fold
> them into a single if() in each caller, but I think it's easier to
> follow as two separate ones.
> 
> You could actually fold the t

Copy-paste error?

> +static int handle_nonblock(int fd, short poll_events)
> +{
> +	struct pollfd pfd;
> +
> +	if (errno != EAGAIN && errno != EWOULDBLOCK)
> +		return 0;
> +

I prefer localizing errno and having the caller pass it
explicitly:

static int handle_nonblock(int fd, short poll_events, int err)
{
	struct pollfd pfd;

	if (err != EAGAIN && err != EWOULDBLOCK)
		return 0;

And the callers would pass errno:

	if (handle_nonblock(fd, POLLIN, errno))
		continue;
