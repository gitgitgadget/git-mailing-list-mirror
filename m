Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE86B1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 20:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755273AbdBNUbW (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 15:31:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:55275 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754220AbdBNUbU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 15:31:20 -0500
Received: (qmail 18469 invoked by uid 109); 14 Feb 2017 20:31:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 20:31:20 +0000
Received: (qmail 6285 invoked by uid 111); 14 Feb 2017 20:31:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 15:31:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 15:31:17 -0500
Date:   Tue, 14 Feb 2017 15:31:17 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] remote helpers: avoid blind fall-back to ".git" when
 setting GIT_DIR
Message-ID: <20170214203117.xnln6ahb3l32agqb@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
 <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
 <20161122004421.GA12263@google.com>
 <20161122024102.otlnl6jcrb3pejux@sigill.intra.peff.net>
 <20161230001114.GB7883@aiede.mtv.corp.google.com>
 <20161230004845.rknafqsyosmyr6z2@sigill.intra.peff.net>
 <20170214061607.qyucfue335aqgji2@sigill.intra.peff.net>
 <xmqqtw7w8uay.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtw7w8uay.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 11:08:05AM -0800, Junio C Hamano wrote:

> Thanks for prodding.  I'm tempted to just rip out everything other
> than the 5-liner fix to transport.c and apply it, expecting that a
> follow-up patch with updated tests to come sometime not in too
> distant future.

I think we can at least include one basic test. Also, as it turns out
the problem I was seeing _wasn't_ the same one Jonathan fixed. There's
another bug. :)

So here's a patch series that fixes my bug, and then a cut-down version
of Jonathan's patch. I'd be happy to see more tests come on top. I don't
think there's a huge rush on getting any of this into master. There are
bugs in the existing code, but they're very hard to trigger in practice
(e.g., a non-repo which happens to have a bunch of repo-like files). It
only becomes an issue in 'next' when we die("BUG") to flush these cases
out.

  [1/2]: remote: avoid reading $GIT_DIR config in non-repo
  [2/2]: remote helpers: avoid blind fall-back to ".git" when setting GIT_DIR

 remote.c                   | 2 +-
 t/t5512-ls-remote.sh       | 9 +++++++++
 t/t5550-http-fetch-dumb.sh | 9 +++++++++
 transport-helper.c         | 5 +++--
 4 files changed, 22 insertions(+), 3 deletions(-)

-Peff
