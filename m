Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CC7E1FBB0
	for <e@80x24.org>; Fri,  2 Dec 2016 00:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758152AbcLBAUi (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 19:20:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:50436 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757793AbcLBAUg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 19:20:36 -0500
Received: (qmail 28532 invoked by uid 109); 2 Dec 2016 00:13:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Dec 2016 00:13:55 +0000
Received: (qmail 6927 invoked by uid 111); 2 Dec 2016 00:14:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 19:14:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 19:13:53 -0500
Date:   Thu, 1 Dec 2016 19:13:53 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v7 4/4] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161202001353.jiw4hjqg75dr6psw@sigill.intra.peff.net>
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480623959-126129-1-git-send-email-bmwill@google.com>
 <1480623959-126129-5-git-send-email-bmwill@google.com>
 <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
 <20161201230738.GJ54082@google.com>
 <20161201232656.GK54082@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161201232656.GK54082@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 03:26:56PM -0800, Brandon Williams wrote:

> > I started taking a look at your http redirect series (I really should
> > have taking a look at it sooner) and I see exactly what you're talking
> > about.  We can easily move this logic into a function to make it easier
> > to generate the two whitelists.
> 
> Thinking about this some more...I was told that having http redirect to
> file:// could be scary.  The way the new protocol configuration is setup
> we have file:// as a default known-safe protocol.  Do we need to worry
> about this or can we leave this be since this can be overridden by the
> user?

Hmm. I'm not sure if file:// should actually be USER_ONLY. The submodule
code allows it, and it's certainly a convenience, but I guess you could
do tricky things by probing somebody's filesystem with submodules URLs.
On the other hand, if you are recursively cloning untrusted repos and
have sensitive contents on disk, you really _should_ be setting up a
protocol whitelist.

For HTTP redirects within curl, I think it's a non-issue; curl
automatically disallows file:// for redirects, even without us telling
it so.

For redirects via http-alternates, it's a bit more tricky, as we feed
the URL to curl ourselves, so it can't tell the difference between
trusted and untrusted input. The main protection provided by my series
is "don't follow http-alternates at all". But assuming you did want to
use them (by setting http.followRedirects to "true", at least for the
server in question), we could then feed file:// directly to curl. But I
think we are still OK, because the restricted CURLOPT_PROTOCOL setting
would prevent that from working. I.e., git _never_ wants curl to handle
file://, because it handles it without calling into remote-curl.c at
all.

So arguably file:// should be USER_ONLY, but I'm not sure how much it
matters in practice.

-Peff
