Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF44C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC0F20780
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgKDNYa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:24:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:47126 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgKDNY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 08:24:29 -0500
Received: (qmail 9699 invoked by uid 109); 4 Nov 2020 13:24:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 13:24:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10113 invoked by uid 111); 4 Nov 2020 13:24:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 08:24:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 08:24:28 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Postler <johannes.postler@txture.io>
Cc:     git@vger.kernel.org
Subject: Re: [Bug report] Crash when creating patch
Message-ID: <20201104132428.GA2491189@coredump.intra.peff.net>
References: <CAO9fQ5pm2vCGrnj59QZg-fJ8VpnrsNoaVXRqd_Lsuw6rEaN3XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO9fQ5pm2vCGrnj59QZg-fJ8VpnrsNoaVXRqd_Lsuw6rEaN3XQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 04, 2020 at 11:18:10AM +0100, Johannes Postler wrote:

> [josi@localhost typescript]$ git format-patch -1 236a9
> --output=/home/josi/tmp/patches/txt-6117.patch
> 0001-Txture-Core-Implemented-whitelisting-for-groovy-scri.patch
> free(): invalid pointer
> Aborted (core dumped)

Thanks for the report. I was able to reproduce the problem here.

The issue is that "--output" was never supposed to work with
format-patch. But a subtle change in the option parsing a while back
caused it to be respected. And as you noticed, the documentation
mistakenly mentions the option, since format-patch includes the standard
diff-options text.

So one obvious fix would be to forbid it and adjust the documentation.
But because of the way the option parsers interact, it's surprisingly
hard to do so cleanly. It's actually easier to just make it do something
useful (i.e., behave like --stdout but sent to a file). So I did that
instead.

  [1/3]: format-patch: refactor output selection
  [2/3]: format-patch: tie file-opening logic to output_directory
  [3/3]: format-patch: support --output option

 builtin/log.c           | 37 ++++++++++++++++++++++---------------
 t/t4014-format-patch.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 15 deletions(-)

-Peff
