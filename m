Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C26CB202AC
	for <e@80x24.org>; Mon, 10 Jul 2017 11:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753834AbdGJLUE (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 07:20:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:35310 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753703AbdGJLUD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 07:20:03 -0400
Received: (qmail 13052 invoked by uid 109); 10 Jul 2017 11:20:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 11:20:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4691 invoked by uid 111); 10 Jul 2017 11:20:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 07:20:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jul 2017 07:20:00 -0400
Date:   Mon, 10 Jul 2017 07:20:00 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 6/6] reflog-walk: stop using fake parents
Message-ID: <20170710112000.vmxscs7fpop3c6pq@sigill.intra.peff.net>
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
 <20170705080904.idlpm6ecslzfbm75@sigill.intra.peff.net>
 <20170707003239.GA13431@untitled>
 <20170707030224.4iubuzsz2qwdhgiw@sigill.intra.peff.net>
 <20170710094255.GA8170@untitled>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170710094255.GA8170@untitled>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 09:42:55AM +0000, Eric Wong wrote:

> > Thanks, I was able to reproduce with CFLAGS=-m32.
> 
> No problem and thanks for the quick response!  Latest pu is
> fine for me.
> 
> To notice similar errors sooner, I wonder if we should have a
> test target for 64-bit users to test with -m32 enabled, somehow.

It's "just"

  make CFLAGS=-m32 test

once you are setup for building 32-bit binaries. But that setup can be a
bit tricky.  On Debian, I have multi-arch set up, and then I have to
"apt-get install zlib1g-dev:i386" etc for all the dependencies. Which
isn't _too_ bad except that libcurl4-openssl-dev conflicts between the
amd64 and i386 versions due to /usr/bin/curl-config. So I have to
install the i386 package, do the -m32 build, and then reinstall the
amd64 one to go back to my regular builds.

At any rate, the 32-bit thing in this instance[1] mostly just tickled
the bug in a different way. Testing with either ASan or valgrind also
detected the problem on 64-bit machines, and people (including me) do
run those periodically. In this case the bug was years old. The reason
it wasn't caught earlier is that there wasn't test coverage, and my
series added it for other reasons. So you really _did_ catch it as soon
as it hit pu, which seems pretty reasonable.

-Peff

[1] There are bugs that really are 32-bit-only, of course, and
    instrumenting tools wouldn't catch those. I think we had a bug a
    while back where the code mistook sizeof(uint64_t*) for
    sizeof(uint64_t). They're the same on 64-bit platforms, but not on
    32-bit ones. I do think such bugs are relatively rare, though.
