Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A274C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 23:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6247B6113A
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 23:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhKEXzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 19:55:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:54132 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232115AbhKEXzl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 19:55:41 -0400
Received: (qmail 12857 invoked by uid 109); 5 Nov 2021 23:53:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Nov 2021 23:53:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23887 invoked by uid 111); 5 Nov 2021 23:53:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Nov 2021 19:53:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Nov 2021 19:53:00 -0400
From:   Jeff King <peff@peff.net>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
Message-ID: <YYXD3NESdiDI4B6G@coredump.intra.peff.net>
References: <20211104192533.2520-1-adam@dinwoodie.org>
 <xmqq7ddn3dlt.fsf@gitster.g>
 <20211105112525.GA25887@dinwoodie.org>
 <YYUeKt0xQm/6QT+w@coredump.intra.peff.net>
 <xmqqk0hmxyw0.fsf@gitster.g>
 <CA+kUOa=vqFNXe2QKc8K31OLL0zkEsK7wAk6hPMxjQJNVM7PsGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+kUOa=vqFNXe2QKc8K31OLL0zkEsK7wAk6hPMxjQJNVM7PsGQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 05, 2021 at 06:49:14PM +0000, Adam Dinwoodie wrote:

> This is probably a much broader conversation. I remember when I first
> started packaging Git for Cygwin, I produced a release that didn't
> have support for HTTPS URLs due to a missing dependency in my build
> environment. The build and test suite all passed -- it assumed I just
> wanted to build a release that didn't have HTTPS support -- so some
> relatively critical function was silently skipped. I don't know how to
> avoid that sort of issue other than relying on (a) user bug (or at
> least missing function) reports and (b) folk building Git for
> themselves/others periodically going through the output of the
> configure scripts and the skipped subtests to make sure only expected
> things get missed; neither of those options seem great to me.

The HTTP tests in particular have a knob for this, as I was worried
about this kind of situation when we introduced auto-enabling of network
tests back in 83d842dc8c (tests: turn on network daemon tests by
default, 2014-02-10). The solution there was to make the knob a
tri-state: the default is "auto", which will try to probe whether we
have a working apache setup, but setting it to "true" will complain if
that setup fails.

Now that's not a perfect solution:

  - you have to know to flip the switch to "true". For an old switch
    like HTTP, that's easy. But somebody packaging Git might not even
    realize GPGSSH was a new thing.

  - The "true" knob only covers probing of the environment. If you
    accidentally build with NO_CURL, we'd still quietly skip the tests.
    It might be reasonable to change this.

  - In your particular case, it probably would not have helped anyway
    because we don't have any specific HTTPS tests (there is an option
    to set up the default server with SSL, but I didn't even realize
    that until just now; I wonder if it actually works).

So I dunno. I guess because of point 1, having an allow-known-skips list
would be more helpful. That gives you the opportunity to examine new
prereqs and decide if they ought to be skipped or not in your setup.

-Peff
