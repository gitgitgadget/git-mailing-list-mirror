Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0131F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 05:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfDWFbc (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 01:31:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:37744 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725888AbfDWFbc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 01:31:32 -0400
Received: (qmail 19090 invoked by uid 109); 23 Apr 2019 05:31:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Apr 2019 05:31:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6195 invoked by uid 111); 23 Apr 2019 05:32:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Apr 2019 01:32:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Apr 2019 01:31:30 -0400
Date:   Tue, 23 Apr 2019 01:31:30 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/8] Documentation: add Packfile URIs design doc
Message-ID: <20190423053130.GA13162@sigill.intra.peff.net>
References: <cover.1550963965.git.jonathantanmy@google.com>
 <cover.1552073690.git.jonathantanmy@google.com>
 <5ce56844d3fb740e29d2f3d4be2ade0b2ad5f7fd.1552073690.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ce56844d3fb740e29d2f3d4be2ade0b2ad5f7fd.1552073690.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 08, 2019 at 01:55:17PM -0800, Jonathan Tan wrote:

> +If the 'packfile-uris' feature is advertised, the following argument
> +can be included in the client's request as well as the potential
> +addition of the 'packfile-uris' section in the server's response as
> +explained below.
> +
> +    packfile-uris <comma-separated list of protocols>
> +	Indicates to the server that the client is willing to receive
> +	URIs of any of the given protocols in place of objects in the
> +	sent packfile. Before performing the connectivity check, the
> +	client should download from all given URIs. Currently, the
> +	protocols supported are "http" and "https".

This negotiation seems backwards to me, because it puts too much power
in the hands of the server.

The server says "OK, I support this feature". Then the client says "I
support it, too. But only if you like these protocols". And then the
server dumps a bunch of URIs and expects the client to respect them.

The problem I see is that the client doesn't get to vet the list of
URIs; it only gets to specify a protocol match. But there are many other
reasons it might want to reject a URI: we don't like the protocol, the
domain name is on a blacklist (or not on a whitelist), the domain name
can't resolve, we can't make a TCP connection to the server, we can't
successfully fetch the pack.

You'll note that those rise in complexity and time as you go down the
list. I'm not sure where on that spectrum we'd want our clients to stop
vetting (and it may even depend on config). But I think we ought to
design the protocol to put the decision in the hands of the client so
that it _can_ make those choices itself.

I.e., I think the conversation ought to be more like:

  Server: I support packfile-uris X, Y, Z.

  Client: Great. I'll use URIs X and Z.

  Server: OK, here's your pack, minus any objects I know are in X and Z.
          I'll send you the objects from Y as normal.

And then the client is free to pick and choose. The initial server uri
list can come in the capabilities list, or it can be a separate request
once the client sees the server supports packfile-uris and wants to ask
about them. We may need some way for the server to group the uris so
that the client knows which ones are alternates of each other (and which
ones are needed to make a complete set).

-Peff
