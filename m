Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11B801F576
	for <e@80x24.org>; Thu, 22 Feb 2018 10:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbeBVKIn (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 05:08:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:60704 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753000AbeBVKIm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 05:08:42 -0500
Received: (qmail 27161 invoked by uid 109); 22 Feb 2018 10:08:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Feb 2018 10:08:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1329 invoked by uid 111); 22 Feb 2018 10:09:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Feb 2018 05:09:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Feb 2018 05:08:40 -0500
Date:   Thu, 22 Feb 2018 05:08:40 -0500
From:   Jeff King <peff@peff.net>
To:     Dorian Taylor <dorian.taylor.lists@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>
Subject: Re: bug in HTTP protocol spec
Message-ID: <20180222100840.GD12442@sigill.intra.peff.net>
References: <4F85B1C3-9B5B-4D7C-8907-B728C18A70CD@gmail.com>
 <20180221221516.GA7944@sigill.intra.peff.net>
 <89E9DF80-F811-4F7A-AA35-0F52F1180BAF@gmail.com>
 <20180222053722.GB133592@aiede.svl.corp.google.com>
 <614A9A36-9DE3-4A85-BFA8-8380C4AC21B8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <614A9A36-9DE3-4A85-BFA8-8380C4AC21B8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 11:23:52PM -0800, Dorian Taylor wrote:

> diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
> index a0e45f2889e6e..19d73f7efb338 100644
> --- a/Documentation/technical/http-protocol.txt
> +++ b/Documentation/technical/http-protocol.txt
> @@ -214,14 +214,17 @@ smart server reply:
>   S: Cache-Control: no-cache
>   S:
>   S: 001e# service=git-upload-pack\n
> +   S: 0000
>   S: 004895dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/heads/maint\0multi_ack\n
>   S: 0042d049f6c27a2244e12041955e262a404c7faba355 refs/heads/master\n
>   S: 003c2cb58b79488a98d2721cea644875a8dd0026b115 refs/tags/v1.0\n
>   S: 003fa3c2e2402b99163d1d59756e5f207ae21cccba4c refs/tags/v1.0^{}\n
> +   S: 0000

This indentation is funny. But I suspect it is because your whole patch
seems to have been whitespace-damaged (see the section on gmail in
"git help git-format-patch").

> The client may send Extra Parameters (see
> Documentation/technical/pack-protocol.txt) as a colon-separated string
> -in the Git-Protocol HTTP header.
> +in the Git-Protocol HTTP header. Note as well that there is *no* newline
> +after the `0000`.

I guess I'm not opposed to calling that out, but this is normal for
pktline (the flush packet has no data; in the other lines the newline is
not a syntactic part of the pktline stream, but is actually data
contained inside each of those pktlines).

> Dumb Server Response
> ^^^^^^^^^^^^^^^^^^^^
> @@ -264,8 +267,8 @@ Servers MUST set $servicename to be the request parameter value.
> Servers SHOULD include an LF at the end of this line.
> Clients MUST ignore an LF at the end of the line.
> 
> -Servers MUST terminate the response with the magic `0000` end
> -pkt-line marker.
> +Servers MUST follow the first pkt-line, as well as terminate the
> +response, with the magic `0000` end pkt-line marker.

In theory there can actually be one or more headers after the "service"
line. But I don't think they've ever been used (and the current client
just throws them away).

> The returned response is a pkt-line stream describing each ref and
> its known value.  The stream SHOULD be sorted by name according to
> @@ -278,6 +281,7 @@ Extra Parameter.
> 
>  smart_reply     =  PKT-LINE("# service=$servicename" LF)
> 		     *1("version 1")
> +		     "0000"
> 		     ref_list
> 		     "0000"

I think Jonathan is right that the version must go after the flush
packet (just looking at the v2 protocol patches elsewhere on the list,
the version tag is really part of the ref_list).

Not related to your patch, but I suspect it should also be
PKT-LINE("version 1").

-Peff
