Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C791C433FE
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 02:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ACA360F56
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 02:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhIVCbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 22:31:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:52322 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhIVCbj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 22:31:39 -0400
Received: (qmail 7494 invoked by uid 109); 22 Sep 2021 02:30:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Sep 2021 02:30:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8655 invoked by uid 111); 22 Sep 2021 02:30:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Sep 2021 22:30:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Sep 2021 22:30:09 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
Message-ID: <YUqVMbhqiwMFmbqg@coredump.intra.peff.net>
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
 <YUpMreNwBDSygFSf@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUpMreNwBDSygFSf@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 05:20:45PM -0400, Taylor Blau wrote:

> I'd be fine with assuming that the http2 module is available everywhere,
> but only because the tests are optional in the first place. I agree that
> we'd want to run our suite of HTTP-related tests in both HTTP/2 and
> HTTP/1.1 mode.

Yeah, it's really only a problem if we lose some coverage of http on
particular platforms. But I suspect it's relatively rare for people to
run the http tests in the first place.

> But that doesn't mean we have to reconfigure our Apache server midway
> through the test, since HTTP/2 servers should keep the HTTP/1.1
> conversation going if the client doesn't reply with 'Connection:
> upgrade; Upgrade: h2c'. At least, I think that's the case based on my
> fairly rudimentary understanding of HTTP/2 ;).

Right. If we were doing ALPN, curl would automatically do HTTP/2 if the
server supports it. But since we're not, then yes, we can control it
from the client side. I think I'd probably break it into two scripts
anyway, though, like:

  #!/bin/sh

  test_description='variant of t5551 for http2'
  . ./test-lib.sh

  test_expect_success 'turn on http/2' '
	git config --global http.version HTTP/2 &&
	test_set_prereq HTTP2
  '

  # presumably it learns to skip its preamble if test_description is
  # already set. Or we could pull it out to a common lib-t5551 file.
  . t5551-http-fetch-smart.sh

But TBH I'm not sure if it's even worth the effort. We did find one
obscure case here, but AFAICT this would be unlikely to turn up
anything useful. I dunno. And really, you'd want to do it for all
http-related test scripts, not just this one. That's quite a bit more
work.

-Peff
