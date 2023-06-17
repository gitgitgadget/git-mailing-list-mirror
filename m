Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D347EB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 05:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjFQFpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 01:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQFpW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 01:45:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ED51FDD
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 22:45:21 -0700 (PDT)
Received: (qmail 13293 invoked by uid 109); 17 Jun 2023 05:45:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jun 2023 05:45:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6875 invoked by uid 111); 17 Jun 2023 05:45:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Jun 2023 01:45:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Jun 2023 01:45:19 -0400
From:   Jeff King <peff@peff.net>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] http: handle both "h2" and "h2h3" in curl info lines
Message-ID: <20230617054519.GF562686@coredump.intra.peff.net>
References: <kl6lilbnrrl1.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20230617044232.GC562686@coredump.intra.peff.net>
 <20230617051559.GD562686@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230617051559.GD562686@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 17, 2023 at 01:15:59AM -0400, Jeff King wrote:

> So here's that patch with a commit message, though note that t5559.30
> seems to reliably fail with a timeout for me on the new version of curl. :(

OK, looks like the timeout problem is due to another change in curl, but
it has since been fixed. Here are my notes in case anyone else runs into
it (or has to investigate something similar).

My bisection recipe in curl.git is:

  git clean -dx
  autoreconf -fi &&
  ./configure --disable-shared --prefix=/tmp/foo --with-openssl --with-nghttp2 &&
  make install &&
  (cd /path/to/git.git &&
   make CURL_CONFIG=/tmp/foo/bin/curl-config &&
   cd t &&
   ./t5559-http-fetch-smart-http2.sh -v)

You'll need apache with mod_h2 installed so that t5559 can run the
server side of the test.

That bisects to 744dcf22f (http2: flow control and buffer improvements,
2023-03-30), which seems like a plausible candidate. Before that commit,
t5559 runs to completion. After, t5559.30, which tries to send a
large-ish input to the server, hangs for a while and then we eventually
get a 408 timeout error.

Reverse-bisecting from 744dcf22f up to the current tip of "master", it
looks like the problem goes away in 5c58cb021 (http2: fix EOF handling
on uploads with auth negotiation, 2023-05-24), which likewise makes
sense. :)

So I think we can ignore that from the git side, and the patch I posted
earlier is what we'd want to fix the h2/h2h3 confusion.

-Peff
