Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38CC11F576
	for <e@80x24.org>; Thu, 22 Feb 2018 09:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753035AbeBVJda (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 04:33:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:60636 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752991AbeBVJda (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 04:33:30 -0500
Received: (qmail 25162 invoked by uid 109); 22 Feb 2018 09:33:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Feb 2018 09:33:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1162 invoked by uid 111); 22 Feb 2018 09:34:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Feb 2018 04:34:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Feb 2018 04:33:27 -0500
Date:   Thu, 22 Feb 2018 04:33:27 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 12/35] serve: introduce git-serve
Message-ID: <20180222093327.GA12442@sigill.intra.peff.net>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-13-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180207011312.189834-13-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 06, 2018 at 05:12:49PM -0800, Brandon Williams wrote:

> +In protocol v2 communication is command oriented.  When first contacting a
> +server a list of capabilities will advertised.  Some of these capabilities
> +will be commands which a client can request be executed.  Once a command
> +has completed, a client can reuse the connection and request that other
> +commands be executed.

If I understand this correctly, we'll potentially have a lot more
round-trips between the client and server (one per "command"). And for
git-over-http, each one will be its own HTTP request?

We've traditionally tried to minimize HTTP requests, but I guess it's
not too bad if we can keep the connection open in most cases. Then we
just suffer some extra framing bytes, but we don't have to re-establish
the TCP connection each time.

I do wonder if the extra round trips will be noticeable in high-latency
conditions. E.g., if I'm 200ms away, converting the current
ref-advertisement spew to "capabilities, then the client asks for refs,
then we spew the refs" is going to cost an extra 200ms, even if the
fetch just ends up being a noop. I'm not sure how bad that is in the
grand scheme of things (after all, the TCP handshake involves some
round-trips, too).

> + Capability Advertisement
> +--------------------------
> +
> +A server which decides to communicate (based on a request from a client)
> +using protocol version 2, notifies the client by sending a version string
> +in its initial response followed by an advertisement of its capabilities.
> +Each capability is a key with an optional value.  Clients must ignore all
> +unknown keys.  Semantics of unknown values are left to the definition of
> +each key.  Some capabilities will describe commands which can be requested
> +to be executed by the client.
> +
> +    capability-advertisement = protocol-version
> +			       capability-list
> +			       flush-pkt
> +
> +    protocol-version = PKT-LINE("version 2" LF)
> +    capability-list = *capability
> +    capability = PKT-LINE(key[=value] LF)
> +
> +    key = 1*CHAR
> +    value = 1*CHAR
> +    CHAR = 1*(ALPHA / DIGIT / "-" / "_")
> +
> +A client then responds to select the command it wants with any particular
> +capabilities or arguments.  There is then an optional section where the
> +client can provide any command specific parameters or queries.
> +
> +    command-request = command
> +		      capability-list
> +		      (command-args)
> +		      flush-pkt
> +    command = PKT-LINE("command=" key LF)
> +    command-args = delim-pkt
> +		   *arg
> +    arg = 1*CHAR

For a single stateful TCP connection like git:// or git-over-ssh, the
client would get the capabilities once and then issue a series of
commands. For git-over-http, how does it work?

The client speaks first in HTTP, so we'd first make a request to get
just the capabilities from the server? And then proceed from there with
a series of requests, assuming that the capabilities for each server we
subsequently contact are the same? That's probably reasonable (and
certainly the existing http protocol makes that capabilities
assumption).

I don't see any documentation on how this all works with http. But
reading patch 34, it looks like we just do the usual
service=git-upload-pack request (with the magic request for v2), and
then the server would send us capabilities. Which follows my line of
thinking in the paragraph above.

-Peff
