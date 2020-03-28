Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1512EC43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 12:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D1120723
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 12:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgC1MZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:25:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:54382 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726225AbgC1MZf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 08:25:35 -0400
Received: (qmail 23797 invoked by uid 109); 28 Mar 2020 12:25:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 28 Mar 2020 12:25:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 960 invoked by uid 111); 28 Mar 2020 12:35:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Mar 2020 08:35:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 28 Mar 2020 08:25:34 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] test-lib-functions: make packetize() more efficient
Message-ID: <20200328122534.GA642919@coredump.intra.peff.net>
References: <20200327080210.GA604725@coredump.intra.peff.net>
 <20200327080300.GA605934@coredump.intra.peff.net>
 <20200327151607.GA30419@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200327151607.GA30419@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 27, 2020 at 09:16:07AM -0600, Taylor Blau wrote:

> >  packetize() {
> > -	cat >packetize.tmp &&
> > -	len=$(wc -c <packetize.tmp) &&
> > -	printf '%04x%s' "$(($len + 4))" &&
> > -	cat packetize.tmp &&
> > -	rm -f packetize.tmp
> > +	if test $# -gt 0
> > +	then
> > +		packet="$*"
> 
> Mentioned off-list in a discussion already, but: though I find this
> behavior of joining multiple arguments by a whitespace character a
> little confusing (i.e., what would callers thing this function does if
> they hadn't read the documentation?) I think that this is probably the
> most sane thing that you could do here.
> 
> On the other hand, nowhere in this patch do we currently call packetize
> with multiple arguments, so perhaps it would be made simpler if we
> instead wrote "$1" anywhere there was "$packet".

Of all the options, I like that the least because somebody doing:

  packetize foo bar

would have the "bar" silently ignored. And it's more lines of code to
check and complain about that than it is to just do something sensible.

-Peff
