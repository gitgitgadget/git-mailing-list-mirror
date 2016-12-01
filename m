Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24E661FC96
	for <e@80x24.org>; Thu,  1 Dec 2016 08:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754987AbcLAIgu (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 03:36:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:49657 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbcLAIgt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 03:36:49 -0500
Received: (qmail 2342 invoked by uid 109); 1 Dec 2016 08:30:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 08:30:07 +0000
Received: (qmail 30588 invoked by uid 111); 1 Dec 2016 08:30:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 03:30:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 03:30:05 -0500
Date:   Thu, 1 Dec 2016 03:30:05 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: bw/transport-protocol-policy
Message-ID: <20161201083005.dui572o4jxsqacas@sigill.intra.peff.net>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2016 at 04:15:08PM -0800, Junio C Hamano wrote:

> * bw/transport-protocol-policy (2016-11-09) 2 commits
>   (merged to 'next' on 2016-11-16 at 1391d3eeed)
>  + transport: add protocol policy config option
>  + lib-proto-disable: variable name fix
> 
>  Finer-grained control of what protocols are allowed for transports
>  during clone/fetch/push have been enabled via a new configuration
>  mechanism.
> 
>  Will cook in 'next'.

I was looking at the way the http code feeds protocol restrictions to
CURLOPT_REDIR_PROTOCOLS, and I think this topic is missing two elements:

  1. The new policy config lets you say "only allow this protocol when
     the user specifies it". But when http.c calls is_transport_allowed(),
     the latter has no idea that we are asking it about potential
     redirects (which obviously do _not_ come from the user), and would
     erroneously allow them.

     I think this needs fixed before the topic is merged. It's not a
     regression, as it only comes into play if you use the new policy
     config. But it is a minor security hole in the new feature.

  2. If your curl is too old to support CURLOPT_REDIR_PROTOCOLS, we will
     warn if there is a protocol whitelist in effect. But that check
     only covers the environment whitelist, and we do not warn if you
     restrict other protocols.

     I actually think this should probably just warn indiscriminately.
     Even without a Git protocol whitelist specified, the code serves to
     prevent curl from redirecting to bizarre protocols like smtp. The
     affected curl versions are from 2009 and prior, so I kind of doubt
     it matters much either way (I'm actually tempted to suggest we bump
     the minimum curl version there; there's a ton of #ifdef cruft going
     back to 2002-era versions of libcurl).

-Peff
