Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA99320248
	for <e@80x24.org>; Thu, 18 Apr 2019 21:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbfDRVOK (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 17:14:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:34384 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728264AbfDRVOK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 17:14:10 -0400
Received: (qmail 5450 invoked by uid 109); 18 Apr 2019 21:14:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Apr 2019 21:14:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4564 invoked by uid 111); 18 Apr 2019 21:14:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Apr 2019 17:14:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2019 17:14:08 -0400
Date:   Thu, 18 Apr 2019 17:14:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 0/3] untracked cache parsing fixups
Message-ID: <20190418211408.GA18011@sigill.intra.peff.net>
References: <pull.178.git.gitgitgadget@gmail.com>
 <a7f75cefb682546862be4dd8b48f91c4034c5d5a.1554901006.git.gitgitgadget@gmail.com>
 <20190410162029.GA30818@sigill.intra.peff.net>
 <xmqq7ec00z9t.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7ec00z9t.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc Duy as the master of all things untracked-cache]

On Fri, Apr 12, 2019 at 10:48:30AM +0900, Junio C Hamano wrote:

> > The right thing is probably something like:
> >
> >   eos = memchr(data, '\0', end - data);
> >   if (!eos)
> > 	return error("malformed untracked cache extension");
> >   len = eos - data;
> >
> > I wouldn't be at all surprised if other bits of the index code have the
> > same issue, though. And at any rate, thinking about that should
> > definitely not hold up your fix.
> 
> True, true.  I wonder if folks intereseted in libFuzzer can chime in
> with something useful here, but that is totally independent.

Just so we don't forget about it, I wrote this fix up as a patch. And in
fact it led to a few other cleanups. I think the first one is definitely
worth doing now, even if there are other similar cases lurking in the
rest of the index code.

The other two are optional, though I think they are worth it (and not
too hard to verify that they are doing the right thing).

These are on top of js/untracked-cache-allocfix (though they could
easily be ported to a separate topic if we want).

  [1/3]: untracked-cache: be defensive about missing NULs in index
  [2/3]: untracked-cache: simplify parsing by dropping "next"
  [3/3]: untracked-cache: simplify parsing by dropping "len"

 dir.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

-Peff
