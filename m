Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBC411F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 14:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750949AbdAUOTr (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 09:19:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:42601 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750939AbdAUOTq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 09:19:46 -0500
Received: (qmail 2407 invoked by uid 109); 21 Jan 2017 14:19:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Jan 2017 14:19:45 +0000
Received: (qmail 16881 invoked by uid 111); 21 Jan 2017 14:20:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Jan 2017 09:20:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Jan 2017 09:19:43 -0500
Date:   Sat, 21 Jan 2017 09:19:43 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Localise error headers
Message-ID: <20170121141942.lc4pw3ck3nzxbozv@sigill.intra.peff.net>
References: <cover.1483354746.git.git@drmicha.warpmail.net>
 <20170104070514.pxdthvilw66ierfz@sigill.intra.peff.net>
 <8d0966d0-1ef1-3d1e-95f5-6e6c1ad50536@drmicha.warpmail.net>
 <20170110090418.4egk4oflblshmjon@sigill.intra.peff.net>
 <CAGZ79kYVc0YQ4okrTHGiYQzPqfiVAm_f7orXdkhwgf5kMPXj-w@mail.gmail.com>
 <20170111113725.avl3wetwrfezdni2@sigill.intra.peff.net>
 <xmqq1sw9piz5.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BRdd4f7f7+7XyN8jd69GS6tnkEGhw05F=7c96eViRVQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BRdd4f7f7+7XyN8jd69GS6tnkEGhw05F=7c96eViRVQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 08:08:43PM +0700, Duy Nguyen wrote:

> > In addition, "BUG: " is relatively recent introduction to our
> > codebase.  Perhaps having a separate BUG(<string>) function help the
> > distinction further?
> 
> I was going to write the same thing. On top of that I wonder if have
> enough "if (something) die("BUG:")" to justify stealing BUG_ON() from
> kernel (better than assert since the condition will always be
> evaluated).

I don't mind BUG_ON() as an improvement over assert(). However, one of
the things I really like about our current die("BUG") is that you
actually write a human-readable message. Quite often that serves as a
comment to the reader of the code as to what is going on, or you can
give additional context in the error message (e.g., which sha1 triggered
the bug).

Still, there are many cases where there's not much to say in the
message. Doing:

  if (!foo)
	BUG("foo is NULL in this function");

is just wasting everybody's time. Something like:

  #define BUG_ON(code) do {
	if (code)
		BUG("%s", #code);
  while(0)

is probably fine. One complication is that BUG() would ideally show the
file/line number. That has to happen in a macro, but we don't assume
variadic macros work everywhere, which we need for the printf-like
behavior. So either we have to loosen that restriction[1], or we end up
with two "tiers": a BUG(fmt, ...) for human-readable messages, and a
more boring version for BUG_ON() which just prints "file:line: BUG:
<code>".

-Peff

[1] I think avoiding variadic macros was reasonable in 2005; C99 was
    only 6 years old then. Now it's turning 18. Maybe it's time?
