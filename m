Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C19D6202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 23:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936505AbdIYXpo (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 19:45:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:49942 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933685AbdIYXpn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 19:45:43 -0400
Received: (qmail 12098 invoked by uid 109); 25 Sep 2017 23:45:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 23:45:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30684 invoked by uid 111); 25 Sep 2017 23:46:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 19:46:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 19:45:41 -0400
Date:   Mon, 25 Sep 2017 19:45:41 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925202916.4tqo4gttrsoy7kai@sigill.intra.peff.net>
 <20170925220914.GB27425@aiede.mtv.corp.google.com>
 <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
 <20170925233316.GI27425@aiede.mtv.corp.google.com>
 <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 07:37:32PM -0400, Jeff King wrote:

> > Correct.  Actually more than "frown on": except for with the few calls
> > like strtoul that are advertised to work this way, POSIX does not make
> > the guarantee the above code would rely on, at all.
> > 
> > So it's not just frowned upon: it's so unportable that the standard
> > calls it out as something that won't work.
> 
> Is it unportable? Certainly read() is free reset errno to zero on
> success. But is it allowed to set it to another random value?
> 
> I think we're getting pretty academic here, but I'm curious if you have
> a good reference.

Answering my own question. POSIX says:

  No function in this volume of IEEE Std 1003.1-2001 shall set errno to
  0. The setting of errno after a successful call to a function is
  unspecified unless the description of that function specifies that
  errno shall not be modified.

So that does seem to outlaw errno-only checks for most functions.

It makes me wonder if the recent getdelim() fix is technically violating
this. It should instead be explicitly checking for feof().

> IMHO as long as it _is_ deterministic and recognize as not an error from
> read(), that's the best we can do. Which is why I went with "0" in the
> first place. Seeing "read error: success" is a common-ish idiom (to me
> anyway) for "read didn't fail, but some user-space logic did", if only
> because it often happens accidentally.

Another option I ran across from POSIX:

  [EOVERFLOW]
    The file is a regular file, nbyte is greater than 0, the starting
    position is before the end-of-file, and the starting position is
    greater than or equal to the offset maximum established in the open
    file description associated with fildes.

That's not _exactly_ what's going on here, but it's pretty close. And is
what you would get if you implemented read_exactly() in terms of
something like pread().

-Peff
