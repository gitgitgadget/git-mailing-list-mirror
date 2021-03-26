Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205D6C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 06:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D272561A3F
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 06:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhCZG4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 02:56:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:49590 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhCZGzw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 02:55:52 -0400
Received: (qmail 28863 invoked by uid 109); 26 Mar 2021 06:55:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 06:55:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8563 invoked by uid 111); 26 Mar 2021 06:55:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Mar 2021 02:55:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Mar 2021 02:55:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     lilinchao@oschina.cn, git@vger.kernel.org
Subject: Re: [PATCH 2/2] remote-curl.c: handle v1 when check_smart_http
Message-ID: <YF2FdzuQJV5Zb/y1@coredump.intra.peff.net>
References: <20210324053648.25584-1-lilinchao@oschina.cn>
 <006547b28c6311eb93820024e87935e7@oschina.cn>
 <xmqq7dlwxpn3.fsf@gitster.g>
 <YF1+AjgfA6gnAGga@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YF1+AjgfA6gnAGga@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 26, 2021 at 02:24:03AM -0400, Jeff King wrote:

> One curiosity is that for v2, the response from github.com does include
> the "service" line. So it follows the same path as v1, and never hits
> the "version 2" line check here. But http-backend omits the "service"
> line, due to 237ffedd46 (http: eliminate "# service" line when using
> protocol v2, 2018-03-15).
> 
> So it's interesting that GitHub behaves differently than http-backend
> here. It's not surprising, since the HTTP framing is all done by a
> custom server there, which implemented off the spec.  What _is_
> surprising is that the client seems perfectly happy to see either form,
> and nobody has noticed the difference until just now.
> 
> IMHO the spec is very unclear here; it says "client makes a smart
> info/refs request as described in http-protocol.txt", but doesn't call
> out the difference in the response. It's only implied by the example:
> 
>   A v2 server would reply:
> 
>      S: 200 OK
>      S: <Some headers>
>      S: ...
>      S:
>      S: 000eversion 2\n
>      S: <capability-advertisement>
> 
> where it is unclear whether the blank line is separating HTTP headers
> from the body (and thus "..." is some headers), or if it is separating
> the "# service" line and matching flush from the rest of the response
> body.
> 
> I note that gitlab.com also returns the "service" line for v2 (I don't
> know anything about their implementation, but I would not be at all
> surprised if they also use a custom HTTP endpoint; apache+http-backend
> is not very flexible or scalable).

I wondered two things:

  - how other servers behave; jgit is the obvious other one to check. It
    seems to match http-backend in omitting the "service" line. I also
    checked its v1 behavior. It seems to ignore it totally and behave
    like v0 (which again, is OK, since it's not useful). This was based
    on testing against https://android.googlesource.com. In v0, it
    claims agent=JGit/4-google, though curiously in v2 it does not
    advertise an agent at all. :)

  - whether other v2 clients are equally forgiving of either format.
    Again, jgit is probably the most interesting here (libgit2 does not
    speak v2 at all yet). And indeed, it seems to be happy with either
    format (which is not surprising, given how common both types of
    server are).

-Peff
