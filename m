Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531B1202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 23:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966404AbdIYXhg (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 19:37:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:49922 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966206AbdIYXhf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 19:37:35 -0400
Received: (qmail 11699 invoked by uid 109); 25 Sep 2017 23:37:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 23:37:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30631 invoked by uid 111); 25 Sep 2017 23:38:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 19:38:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 19:37:33 -0400
Date:   Mon, 25 Sep 2017 19:37:33 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925202916.4tqo4gttrsoy7kai@sigill.intra.peff.net>
 <20170925220914.GB27425@aiede.mtv.corp.google.com>
 <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
 <20170925233316.GI27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925233316.GI27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 04:33:16PM -0700, Jonathan Nieder wrote:

> > If I do this:
> >
> >   errno = 0;
> >   read_in_full(fd, buf, sizeof(buf));
> >   if (errno)
> > 	die_errno("oops");
> >
> > then we'll claim an error, even though there was none (remember that
> > it's only an error for _some_ callers to not read the whole length).
> >
> > This may be sufficiently odd that we don't need to care about it. There
> > are some calls (like strtoul) which require this kind of clear-and-check
> > strategy with errno, but in general we frown on it for calls like
> > read().
> 
> Correct.  Actually more than "frown on": except for with the few calls
> like strtoul that are advertised to work this way, POSIX does not make
> the guarantee the above code would rely on, at all.
> 
> So it's not just frowned upon: it's so unportable that the standard
> calls it out as something that won't work.

Is it unportable? Certainly read() is free reset errno to zero on
success. But is it allowed to set it to another random value?

I think we're getting pretty academic here, but I'm curious if you have
a good reference.

> > We could also introduce a better helper like this:
> >
> >   int read_exactly(int fd, void *buf, size_t count)
> >   {
> > 	ssize_t ret = read_in_full(fd, buf, count);
> > 	if (ret < 0)
> > 		return -1;
> > 	if (ret != count) {
> > 		errno = EILSEQ;
> > 		return -1;
> > 	}
> > 	return 0;
> >   }
> >
> > Then we know that touching errno always coincides with an error return.
> > And it's shorter to check "< 0" compared to "!= count" in the caller.
> > But of course a caller which wants to distinguish the two cases for its
> > error messages then has to look at errno:
> 
> That sounds nice, but it doesn't solve the original problem of callers
> using read_in_full that way.

Right. None of the options discussed in this patch can do so. They can
only take a caller which doesn't distinguish between the cases, and give
it a deterministic value in errno for the short-read case.

IMHO as long as it _is_ deterministic and recognize as not an error from
read(), that's the best we can do. Which is why I went with "0" in the
first place. Seeing "read error: success" is a common-ish idiom (to me
anyway) for "read didn't fail, but some user-space logic did", if only
because it often happens accidentally.

-Peff
