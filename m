Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B9420281
	for <e@80x24.org>; Wed, 27 Sep 2017 04:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753865AbdI0EHZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 00:07:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:51424 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753489AbdI0EHY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 00:07:24 -0400
Received: (qmail 21205 invoked by uid 109); 27 Sep 2017 04:07:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 04:07:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10501 invoked by uid 111); 27 Sep 2017 04:08:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 00:08:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 00:07:22 -0400
Date:   Wed, 27 Sep 2017 00:07:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170927040721.6av4o7cjrrkzizzo@sigill.intra.peff.net>
References: <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
 <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
 <20170925235510.GL27425@aiede.mtv.corp.google.com>
 <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
 <CAGZ79kZwc8bNWJfH_36soy75EpyHAMbJGhQd4rV5f-0RMjiwHQ@mail.gmail.com>
 <20170926000913.6x7qhj2vw73tldxe@sigill.intra.peff.net>
 <20170926001602.GO27425@aiede.mtv.corp.google.com>
 <20170926001732.GP27425@aiede.mtv.corp.google.com>
 <20170926001956.hgtdeklogvkirdxa@sigill.intra.peff.net>
 <xmqqvak6ayk0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvak6ayk0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 26, 2017 at 01:11:59PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> #ifndef EUNDERFLOW
> >> # ifdef ENODATA
> >> #  define EUNDERFLOW ENODATA
> >> # else
> >> #  define EUNDERFLOW ESPIPE
> >> # endif
> >> #endif
> >
> > Right, I think our mails just crossed but I'm leaning in this direction.
> 
> Hmph, I may be slow (or may be skimming the exchanges too fast), but
> what exactly is wrong with "0"?  As long as we do not have to tell
> two or more "not exactly an error from syscall in errno" cases, I
> would think "0" is the best value to use.

The main reason to avoid "0" is just that the "read error: Success"
message is a bit funny.

> If the syserror message _is_ the issue, then we'd need to either
> pick an existing errno that is available everywhere (with possibly
> suboptimal message), or pick something and prepare a fallback for
> platforms that lack the errno, so picking "0" as the value and use
> whatever logic we would have used for the "fallback" would not sound
> too bad.  I.e.
> 
> 	if (read_in_full(..., size) != size)
> 		if (errno)
> 			die_errno("oops");
> 		else
> 			die("short read");
> 
> If the callsite were too numerous,

You actually don't need errno for that. You can write:

  ret = read_in_full(..., size);
  if (ret < 0)
	die_errno("oops");
  else if (ret != size)
	die("short read");

So I think using errno as a sentinel value to tell between the two cases
doesn't have much value.

> #define die_errno_or(msg1, msg2) if (errno) die_errno(msg1); else die(msg2)
> 
> perhaps?

If you just care about dying, you can wrap the whole read_in_full() in a
helper (which is what my original patch 7 did). But I found there were
cases that didn't want to die. Of course _most_ of those don't bother
looking at errno in the first place. I think the only one that does is
index_core(), which calls error_errno().

So with two helpers (one for die and one for error), I think we could
cover the existing cases. Or we could convert the single error() case to
just handle the logic inline.

One of the reasons I dislike the helper I showed earlier is that it
involves assembling a lego sentence. But the alternative is requiring
the caller to write both sentences from scratch (and writing a good
sentence for the short read really is long: you expected X bytes but got
Y).

I guess just tweaking the errno value does not really give a good "short
read" error either. You get "unable to read foo: No data available",
without the X/Y information.

Sometimes a custom "short read" message can be better, if it's "could
not read enough bytes for packfile header" or similar. You don't need to
know the exact number then.

So I dunno. Maybe I have just talked myself into actually just fixing
all of the read_in_full() call sites manually.

-Peff
