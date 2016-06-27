Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8634B1FE4E
	for <e@80x24.org>; Mon, 27 Jun 2016 23:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbcF0XTw (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 19:19:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44014 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874AbcF0XTv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 19:19:51 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB1061FE4E;
	Mon, 27 Jun 2016 23:19:49 +0000 (UTC)
Date:	Mon, 27 Jun 2016 23:19:49 +0000
From:	Eric Wong <e@80x24.org>
To:	Jeff King <peff@peff.net>
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] xread: retry after poll on EAGAIN/EWOULDBLOCK
Message-ID: <20160627231949.GA23661@dcvr.yhbt.net>
References: <20160626232112.721-1-e@80x24.org>
 <20160626232112.721-2-e@80x24.org>
 <20160626234251.GA21668@sigill.intra.peff.net>
 <xmqqoa6mdbu3.fsf@gitster.mtv.corp.google.com>
 <20160627143648.GA2618@sigill.intra.peff.net>
 <CAGZ79kZ94PaOfq3GimWiHULbTE7ihMzL9S=Y+npQ4F5gGwFrsA@mail.gmail.com>
 <20160627201311.GA7039@dcvr.yhbt.net>
 <20160627214947.GA17149@sigill.intra.peff.net>
 <20160627222238.GA23645@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160627222238.GA23645@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Mon, Jun 27, 2016 at 05:49:48PM -0400, Jeff King wrote:
> 
> > So in general I would say that handing non-blocking descriptors to git
> > is not safe.

Indeed.  This also makes me wonder if our output to stdout/stderr
suffer from the same theoretical problems if given non-blocking
outputs; I suspect they do.

>>  I think it's possible to loop on getdelim() when we see
>> EAGAIN, but I'm not sure if it's worth it.

> The patch for that is below, for the curious. It works with even this:
> 
>   {
>     for i in H E A D; do
>       sleep 1
>       printf $i
>     done
>     printf "\n"
>   } | nonblock git cat-file --batch-check
> 
> Note that I folded the "did we see EAGAIN" check into my sub-function
> (which is the equivalent of your io_wait). You might want to do that in
> the xread() code path, too, as it makes the resulting code there a very
> nice:
> 
>   if (errno == EINTR)
> 	continue;
>   if (handle_nonblock(fd, POLLIN))
> 	continue;

Yes :)

> +int handle_nonblock(FILE *fp, short poll_events)
> +{
> +	if (ferror(fp) && (errno == EAGAIN || errno == EWOULDBLOCK)) {

<snip>

> +		clearerr(fp);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +static int getline_stdio_loop(struct strbuf *sb, FILE *fp, int term)
> +{
> +	int ch;
> +	do {
> +		errno = 0;
> +		flockfile(fp);
> +		while ((ch = getc_unlocked(fp)) != EOF) {

<snip>

> +		}
> +		funlockfile(fp);
> +	} while (handle_nonblock(fp, POLLIN));

I haven't used stdio in a while and I'm glad :)
Error handling with ferror + clearerr + errno checking is
difficult and error-prone.

Linus said this back in 2006, too:
http://mid.gmane.org/Pine.LNX.4.64.0609141023130.4388@g5.osdl.org

So I wonder if we're better off relying entirely on xread/xwrite
+ strbuf for all our buffering.
