Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44AE20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 11:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeLLLCJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 06:02:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:39330 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726878AbeLLLCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 06:02:09 -0500
Received: (qmail 10225 invoked by uid 109); 12 Dec 2018 11:02:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Dec 2018 11:02:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15159 invoked by uid 111); 12 Dec 2018 11:01:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 12 Dec 2018 06:01:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2018 06:02:07 -0500
Date:   Wed, 12 Dec 2018 06:02:07 -0500
From:   Jeff King <peff@peff.net>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, masayasuzuki@google.com
Subject: Re: [PATCH v3 1/4] pack-protocol.txt: accept error packets in any
 context
Message-ID: <20181212110206.GA30673@sigill.intra.peff.net>
References: <20181116084427.GA31493@sigill.intra.peff.net>
 <cover.1544572142.git.steadmon@google.com>
 <df7d3659ae5f11d163f1e992f3b9403be709ddb7.1544572142.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df7d3659ae5f11d163f1e992f3b9403be709ddb7.1544572142.git.steadmon@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 04:25:15PM -0800, Josh Steadmon wrote:

> From: Masaya Suzuki <masayasuzuki@google.com>
> 
> In the Git pack protocol definition, an error packet may appear only in
> a certain context. However, servers can face a runtime error (e.g. I/O
> error) at an arbitrary timing. This patch changes the protocol to allow
> an error packet to be sent instead of any packet.
> 
> Following this protocol spec change, the error packet handling code is
> moved to pkt-line.c.

This is a change in the spec with an accompanying change in the code,
which raises the question: what do other implementations do with this
change (both older Git, and implementations like JGit, libgit2, etc)?

I think the answer for older Git is "hang up unceremoniously", which is
probably OK given the semantics of the change. And I'd suspect most
other implementations would do the same. I just wonder if anybody tested
it with other implementations.

> +An error packet is a special pkt-line that contains an error string.
> +
> +----
> +  error-line     =  PKT-LINE("ERR" SP explanation-text)
> +----
> +
> +Throughout the protocol, where `PKT-LINE(...)` is expected, an error packet MAY
> +be sent. Once this packet is sent by a client or a server, the data transfer
> +process defined in this protocol is terminated.

The packfile data is typically packetized, too, and contains arbitrary
data (that could have "ERR" in it). It looks like we don't specifically
say PKT-LINE() in that part of the protocol spec, though, so I think
this is OK.

Likewise, in the implementation:

> diff --git a/pkt-line.c b/pkt-line.c
> index 04d10bbd03..ce9e42d10e 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -346,6 +346,10 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
>  		return PACKET_READ_EOF;
>  	}
>  
> +	if (starts_with(buffer, "ERR ")) {
> +		die(_("remote error: %s"), buffer + 4);
> +	}
> +
>  	if ((options & PACKET_READ_CHOMP_NEWLINE) &&
>  	    len && buffer[len-1] == '\n')
>  		len--;

This ERR handling has been moved to a very low level. What happens if
we're passing arbitrary data via the packet_read() code? Could we
erroneously trigger an error if a packfile happens to have the bytes
"ERR " at a packet boundary?

For packfiles via upload-pack, I _think_ we're OK, because we only
packetize it when a sideband is in use. In which case this would never
match, because we'd have "\1" in the first byte slot.

But are there are other cases we need to worry about? Just
brainstorming, I can think of:

  1. We also pass packetized packfiles between git-remote-https and
     the stateless-rpc mode of fetch-pack/send-pack. And I don't think
     we use sidebands there.

  2. The packet code is used for long-lived clean/smudge filters these
     days, which also pass arbitrary data.

So I think it's probably not a good idea to unconditionally have callers
of packet_read_with_status() handle this. We'd need a flag like
PACKET_READ_RESPECT_ERR, and to trigger it from the appropriate callers.

-Peff
