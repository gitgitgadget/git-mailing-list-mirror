Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D90A20248
	for <e@80x24.org>; Thu, 28 Feb 2019 21:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbfB1VlP (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 16:41:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:33514 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727858AbfB1VlO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 16:41:14 -0500
Received: (qmail 31369 invoked by uid 109); 28 Feb 2019 21:41:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Feb 2019 21:41:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23994 invoked by uid 111); 28 Feb 2019 21:41:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Feb 2019 16:41:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Feb 2019 16:41:12 -0500
Date:   Thu, 28 Feb 2019 16:41:12 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH RFC 0/20] cat-file: start using formatting logic from
 ref-filter
Message-ID: <20190228214112.GK12723@sigill.intra.peff.net>
References: <CAL21BmnVkKtYWa1cRL1EJAwtchGcVUzhu0136AuV8uXAi5Kuew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL21BmnVkKtYWa1cRL1EJAwtchGcVUzhu0136AuV8uXAi5Kuew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 06:50:06PM +0300, Olga Telezhnaya wrote:

> It was a long way for me, I got older (by 1 year) and smarter
> (hopefully), and maybe I will finish my Outreachy Internship task for
> now. (I am doing it just for one year and a half, that's OK)

Welcome back!

Sorry to be a bit slow on the review. I've read through and commented on
patch 10. Some of my comments were "I'll have to see how this plays out
later in the series", so you may want to hold off on responding until I
read the rest. :)

> If serious:
> In this patch we remove cat-file formatting logic and reuse ref-filter
> logic there. As a positive side effect, cat-file now has many new
> formatting tokens (all from ref-filter formatting), including deref
> (like %(*objectsize:disk)). I have already tried to do this task one
> year ago, and it was bad attempt. I feel that today's patch is much
> better.

I'm still concerned that this is going to regress the performance of
cat-file noticeably without some big cleanups in ref-filter. Here are
timings on linux.git before and after your patches:

  [before]
  $ time git cat-file --unordered --batch-all-objects --batch-check >/dev/null
  real	0m16.602s
  user	0m15.545s
  sys	0m0.495s

  [after]
  $ time git cat-file --unordered --batch-all-objects --batch-check >/dev/null
  real	0m27.301s
  user	0m24.549s
  sys	0m2.752s

I don't think that's anything particularly wrong with your patches. It's
the existing strategy of ref-filter (in particular how it is very eager
to allocate lots of separate strings). And it may be too early to switch
cat-file over to it.

> I also have a question about site https://git-scm.com/docs/
> I thought it is updated automatically based on Documentation folder in
> the project, but it is not true. I edited docs for for-each-ref in
> December, I still see my patch in master, but for-each-ref docs in
> git-csm is outdated. Is it OK?

Yeah, as Eric noted, we only build docs for the tagged releases. In
theory it would be easy to just build the tip of master nightly, but the
data model for the site would need quite a bit of adjustment.

-Peff
