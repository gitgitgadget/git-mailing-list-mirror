Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E6BC433E0
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 10:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C731206E9
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 10:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgGOKzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:55:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:58022 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgGOKzX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 06:55:23 -0400
Received: (qmail 10863 invoked by uid 109); 15 Jul 2020 10:55:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Jul 2020 10:55:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8842 invoked by uid 111); 15 Jul 2020 10:55:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jul 2020 06:55:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Jul 2020 06:55:21 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        chriscool@tuxfamily.org
Subject: Re: [PATCH 2/4] upload-pack.c: allow banning certain object filter(s)
Message-ID: <20200715105521.GB3262157@coredump.intra.peff.net>
References: <cover.1593720075.git.me@ttaylorr.com>
 <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
 <20200715100043.GG11341@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715100043.GG11341@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 15, 2020 at 12:00:43PM +0200, SZEDER Gábor wrote:

> Once upon a time I had a PoC patch to deal with 'git upload-pack'
> aborting while 'git fetch' is still send_request()-ing, by catching
> the write error to the closed connection and trying read any pending
> ERR packets; Christian cleaned it up and submitted it with a proper
> commit message in
> 
>   https://public-inbox.org/git/20200422163357.27056-1-chriscool@tuxfamily.org/
> 
> but it haven't been picked up yet.  Disappointingly, that patch
> doesn't solve these issues...  I haven't looked what's going on
> (perhaps 'git clone' does something differently than 'git fetch'?  no
> idea)

I suspect it is that fetch ignores SIGPIPE, but clone does not. So even
when we see a 141 exit code from fetch, it is probably generated
synthetically from exit(141) after we saw EPIPE. And your patch works
there because we have a chance to pump the read-side of the pipe,
whereas in git-clone we die immediately via the signal.

Probably git-clone should ignore SIGPIPE during the network transfer
portion of the process for the same reasons given in 143588949c (fetch:
ignore SIGPIPE during network operation, 2019-03-03).

-Peff
