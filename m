Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794FE1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 20:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752974AbeCEUxB (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 15:53:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:47906 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752162AbeCEUxA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 15:53:00 -0500
Received: (qmail 19113 invoked by uid 109); 5 Mar 2018 20:53:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Mar 2018 20:53:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29918 invoked by uid 111); 5 Mar 2018 20:53:50 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Mar 2018 15:53:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Mar 2018 21:52:55 +0100
Date:   Mon, 5 Mar 2018 21:52:55 +0100
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 12/35] serve: introduce git-serve
Message-ID: <20180305205254.GC5953@sigill.intra.peff.net>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-13-bmwill@google.com>
 <20180222093327.GA12442@sigill.intra.peff.net>
 <20180223214557.GF234838@google.com>
 <20180303043338.GC27689@sigill.intra.peff.net>
 <20180305184321.GC72475@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180305184321.GC72475@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 05, 2018 at 10:43:21AM -0800, Brandon Williams wrote:

> In the current protocol http has a lot of additional stuff that's had to
> be done to it to get it to work with a protocol that was designed to be
> stateful first.  What I want is for the protocol to be designed
> stateless first so that http functions essentially the same as ssh or
> file or git transports and we don't have to do any hackery to get it to
> work.  This also makes it very simple to implement a new feature in the
> protocol because you only need to think about implementing it once
> instead of twice like you kind of have to do with v0.  So in the most
> recent series everything is a chain of request/response pairs even in
> the non-http cases.

I agree that would be a lot more pleasant for adding protocol features.
But I just worry that the stateful protocols get a lot less efficient.
I'm having trouble coming up with an easy reproduction, but my
recollection is that http has some nasty corner cases, because each
round of "have" lines sent to the server has to summarize the previous
conversation. So you can get a case where the client's requests keep
getting bigger and bigger during the negotiation (and eventually getting
large enough to cause problems).

If anything, I wish we could push the http protocol in a more stateful
direction with something like websockets. But I suspect that's an
unrealistic dream, just because not everybody's http setup (proxies,
etc) will be able to handle that.

-Peff
