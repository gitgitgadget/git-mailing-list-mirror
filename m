Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78BD2202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 23:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965958AbdIYXXQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 19:23:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:49884 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965731AbdIYXXP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 19:23:15 -0400
Received: (qmail 10990 invoked by uid 109); 25 Sep 2017 23:23:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 23:23:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30497 invoked by uid 111); 25 Sep 2017 23:23:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 19:23:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 19:23:13 -0400
Date:   Mon, 25 Sep 2017 19:23:13 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925202916.4tqo4gttrsoy7kai@sigill.intra.peff.net>
 <20170925220914.GB27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925220914.GB27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 03:09:14PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > In an ideal world, callers would always distinguish between
> > these cases and give a useful message for each. But as an
> > easy way to make our imperfect world better, let's reset
> > errno to a known value. The best we can do is "0", which
> > will yield something like:
> >
> >   unable to read: Success
> >
> > That's not great, but at least it's deterministic and makes
> > it clear that we didn't see an error from read().
> 
> Yuck.  Can we set errno to something more specific instead?

Yes, but what? You've suggested EILSEQ here, but that feels a
bit...funny. I guess at least it's unlikely that read() would ever set
errno to that itself, so we can be reasonably sure that seeing it is a
sign of a short read. I thought ERANGE might be a possible candidate,
but it doesn't quite fit. Ditto for ENODATA.

I _would_ like to have something meaningful, as it would mean the whole
xread_in_full() nonsense from the final patch would be unnecessary. It
would simply be reasonable to show the errno after read_in_full.

Another question is whether EILSEQ (or the others) is actually defined
everywhere we compile. If it isn't, we'll have to define it ourselves
(but to what? strerror() won't return anything useful for it).

> read(2) also doesn't promise not to clobber errno on success.

Yes, though it's only a problem if you're using something other than 0.

Speaking of funny errno clobbering, with your patch:

> diff --git a/wrapper.c b/wrapper.c
> index 61aba0b5c1..1842a99b87 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -318,8 +318,10 @@ ssize_t read_in_full(int fd, void *buf, size_t count)
>  		ssize_t loaded = xread(fd, p, count);
>  		if (loaded < 0)
>  			return -1;
> -		if (loaded == 0)
> +		if (loaded == 0) {
> +			errno = EILSEQ;
>  			return total;
> +		}

If I do this:

  errno = 0;
  read_in_full(fd, buf, sizeof(buf));
  if (errno)
	die_errno("oops");

then we'll claim an error, even though there was none (remember that
it's only an error for _some_ callers to not read the whole length).

This may be sufficiently odd that we don't need to care about it. There
are some calls (like strtoul) which require this kind of clear-and-check
strategy with errno, but in general we frown on it for calls like
read().

We could also introduce a better helper like this:

  int read_exactly(int fd, void *buf, size_t count)
  {
	ssize_t ret = read_in_full(fd, buf, count);
	if (ret < 0)
		return -1;
	if (ret != count) {
		errno = EILSEQ;
		return -1;
	}
	return 0;
  }

Then we know that touching errno always coincides with an error return.
And it's shorter to check "< 0" compared to "!= count" in the caller.
But of course a caller which wants to distinguish the two cases for its
error messages then has to look at errno:

  if (read_exactly(fd, buf, len) < 0) {
	if (errno == EILSEQ) /* eek, now this abstraction is leaky */
		die("short read");
	else
		die_errno("read error");
  }

I dunno. All options seem pretty gross to me.

-Peff
