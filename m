Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF7D202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 00:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936069AbdIZABV (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 20:01:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:49970 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S935639AbdIZABT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 20:01:19 -0400
Received: (qmail 12883 invoked by uid 109); 26 Sep 2017 00:01:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Sep 2017 00:01:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30847 invoked by uid 111); 26 Sep 2017 00:01:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 20:01:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 20:01:17 -0400
Date:   Mon, 25 Sep 2017 20:01:17 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925202916.4tqo4gttrsoy7kai@sigill.intra.peff.net>
 <20170925220914.GB27425@aiede.mtv.corp.google.com>
 <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
 <20170925233316.GI27425@aiede.mtv.corp.google.com>
 <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
 <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
 <20170925235510.GL27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925235510.GL27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 04:55:10PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> >   [EOVERFLOW]
> >     The file is a regular file, nbyte is greater than 0, the starting
> >     position is before the end-of-file, and the starting position is
> >     greater than or equal to the offset maximum established in the open
> >     file description associated with fildes.
> >
> > That's not _exactly_ what's going on here, but it's pretty close. And is
> > what you would get if you implemented read_exactly() in terms of
> > something like pread().
> 
> All that really matters is the strerror() that the user would see.

Agreed, though I didn't think those were necessarily standardized.

> For EOVERFLOW, that is
> 
> 	Value too large to be stored in data type

Interestingly that does not seem to be a good description for the case
POSIX describes above.

> For EILSEQ, it is
> 
> 	Illegal byte sequence
> 
> Neither is perfect, but the latter seems like a better fit for the kind
> of file format errors we're describing here.

I find that one actively misleading. It's not the bytes we saw, it's the
lack of them.

> Of course, it's even
> better if we fix the callers and don't try to wedge this into errno.

Yes. This patch is just a stop-gap. Perhaps we should abandon it
entirely. But I couldn't find a way to fix all the callers. If you have
a function that just returns "-1" when it sees a read_in_full() error,
how does _its_ caller tell the difference?

I guess the answer is that the interface of the sub-function calling
read_in_full() needs to change.

> If you are okay with the too-long/too-short confusion in EOVERFLOW, then
> there is EMSGSIZE:
> 
> 	Message too long

I don't really like that one either.

I actually prefer "0" of the all of the options discussed. At least it
is immediately clear that it is not a syscall error.

-Peff
