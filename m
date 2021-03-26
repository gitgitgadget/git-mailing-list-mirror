Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56DDC433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 06:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2C561A3F
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 06:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhCZGYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 02:24:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:49560 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229768AbhCZGYE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 02:24:04 -0400
Received: (qmail 28646 invoked by uid 109); 26 Mar 2021 06:24:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 06:24:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8298 invoked by uid 111); 26 Mar 2021 06:24:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Mar 2021 02:24:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Mar 2021 02:24:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     lilinchao@oschina.cn, git@vger.kernel.org
Subject: Re: [PATCH 2/2] remote-curl.c: handle v1 when check_smart_http
Message-ID: <YF1+AjgfA6gnAGga@coredump.intra.peff.net>
References: <20210324053648.25584-1-lilinchao@oschina.cn>
 <006547b28c6311eb93820024e87935e7@oschina.cn>
 <xmqq7dlwxpn3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dlwxpn3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 24, 2021 at 01:28:32PM -0700, Junio C Hamano wrote:

> > +	} else if (!strcmp(reader.line, "version 1")) {
> > +		die(_("v1 is just the original protocol with a version string, use v0 or v2 instead."));
> 
> The user may no longer get "invalid response; got 'version 1'", but
> the above does not still explain why v1 is bad and v0 or v2 is
> welcome, either.  IOW, I do not think the patch improves the message
> to achieve what it attempted to do, i.e.
> 
>     ... but the other side just treat it as "invalid response", this
>     can't explain why is not ok.
> 
> I wonder if it is a sensible and better alternative to treat v1
> response as if we got v0 (if v1 is truly the same as v0 except for
> the initial version advertisement).
> 
> Input from those who are familiar with the protocol versions is very
> much appreciated.

Yes, "v1" is supposed to behave just like v0, except with the version
advertisement (it is true that there is no point in normal people using
it, but the purpose was to make sure the version advertisement worked).

I am not sure who is rejecting it, though. Our test suite passes with
GIT_TEST_PROTOCOL_VERSION=1. Running something like:

  $ GIT_TRACE_PACKET=1 git -c protocol.version=1 ls-remote https://github.com/git/git

yields a conversation like (cut down for clarity):

  git< # service=git-upload-pack
  git< 0000
  git< version 1
  git< 1234abcd[...etc, this is a normal v0/v1 advertisement]

So the version string is there, but it does not trigger the problem
described by this patch. That's because check_smart_http(), after seeing
the "# service" line and the flush, takes all the rest of the packetized
data and gives it to parse_git_refs(), which handles the version field
line via discover_version().

  Aside: on gitlab.com, the v1 response looks like a v0 response, with
  no extra header. I guess they did not bother to implement v1, which is
  OK, since it was not useful after the initial experiment.

So everything seems to be working as intended. Is there some particular
server that returns "version 1" in the wrong way, triggering the die()?

One curiosity is that for v2, the response from github.com does include
the "service" line. So it follows the same path as v1, and never hits
the "version 2" line check here. But http-backend omits the "service"
line, due to 237ffedd46 (http: eliminate "# service" line when using
protocol v2, 2018-03-15).

So it's interesting that GitHub behaves differently than http-backend
here. It's not surprising, since the HTTP framing is all done by a
custom server there, which implemented off the spec.  What _is_
surprising is that the client seems perfectly happy to see either form,
and nobody has noticed the difference until just now.

IMHO the spec is very unclear here; it says "client makes a smart
info/refs request as described in http-protocol.txt", but doesn't call
out the difference in the response. It's only implied by the example:

  A v2 server would reply:

     S: 200 OK
     S: <Some headers>
     S: ...
     S:
     S: 000eversion 2\n
     S: <capability-advertisement>

where it is unclear whether the blank line is separating HTTP headers
from the body (and thus "..." is some headers), or if it is separating
the "# service" line and matching flush from the rest of the response
body.

I note that gitlab.com also returns the "service" line for v2 (I don't
know anything about their implementation, but I would not be at all
surprised if they also use a custom HTTP endpoint; apache+http-backend
is not very flexible or scalable).

Anyway, that's all just an interesting side note. The client is happy
with either form (though it might be nice if we had tests for the "#
service" form; I suspect our tests don't cover that because they are all
using http-backend).

Getting back to the patch at hand, if there is a server saying "version
1" without a "service" line, then I think that is a bug in that server.

-Peff
