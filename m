Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673E2C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 19:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D71C2076D
	for <git@archiver.kernel.org>; Wed,  6 May 2020 19:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgEFTGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 15:06:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:39338 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727884AbgEFTGw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 15:06:52 -0400
Received: (qmail 24120 invoked by uid 109); 6 May 2020 19:06:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 May 2020 19:06:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10598 invoked by uid 111); 6 May 2020 19:06:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 May 2020 15:06:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 May 2020 15:06:51 -0400
From:   Jeff King <peff@peff.net>
To:     clime <clime7@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: :format:%s for date fields seems to be shifted by timezone
Message-ID: <20200506190651.GA2421358@coredump.intra.peff.net>
References: <CAGqZTUu2U6FFXGTXihC64O0gB5Bz_Z3MbD750kMoJWMciAGH6w@mail.gmail.com>
 <20200504154343.GA12842@coredump.intra.peff.net>
 <CAGqZTUs+xCPjQdeQVfU6EWARmZdjcgcHeSNxkKaTf316rX+8pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGqZTUs+xCPjQdeQVfU6EWARmZdjcgcHeSNxkKaTf316rX+8pg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 06, 2020 at 08:03:52PM +0200, clime wrote:

> what about just printing the raw timestamp from either commit or tag,
> i.e. avoiding any conversion for format:%s?

We don't parse the "%s" ourselves at all. We feed everything after the
colon to the system strftime(), and that function only takes a
broken-down "struct tm".

That said, we do already intercept "%z" for similar reasons in
strbuf_addftime(). So it would probably be possible to declare that we
don't respect system "%s" and just handle it ourselves. It would require
either massaging the "tm" back to a time_t, or changing the signature to
take a redundant time_t (and not all callers might have that).

So if somebody wants to work on a patch in that direction, we could see
how ugly it ends up being. But I am reasonably happy with "don't do
that" as a solution in the meantime.

-Peff
