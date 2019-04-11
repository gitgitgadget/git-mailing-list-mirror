Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D8BA20248
	for <e@80x24.org>; Thu, 11 Apr 2019 23:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfDKXtW (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 19:49:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:55782 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726917AbfDKXtW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 19:49:22 -0400
Received: (qmail 21613 invoked by uid 109); 11 Apr 2019 23:49:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Apr 2019 23:49:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1688 invoked by uid 111); 11 Apr 2019 23:49:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Apr 2019 19:49:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2019 19:49:20 -0400
Date:   Thu, 11 Apr 2019 19:49:20 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ls-files: use correct format string
Message-ID: <20190411234920.GA27914@sigill.intra.peff.net>
References: <20190407184751.28027-1-t.gummerer@gmail.com>
 <20190411041823.GA17699@sigill.intra.peff.net>
 <20190411212830.GF32487@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190411212830.GF32487@hank.intra.tgummerer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 11, 2019 at 10:28:30PM +0100, Thomas Gummerer wrote:

> > I didn't see any comment on this, but it seems like it must be obviously
> > correct, since as you note we do define those fields as unsigned. I'm
> > really surprised that -Wformat doesn't catch this, though. I wonder why.
> 
> Good point.  A bit of digging led me to -Wformat-signedness, which
> should catch this.  This turns up a lot of errors in our codebase.  I
> didn't go through to see how many of them are actual errors, and how
> many are false-positives though.

Ah, right, I totally forgot that signedness got its own warning class.
Thanks for enlightening me.

> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65446 describes how the
> option can lead to false positives, e.g.
> 
>     printf ("%u\n", unsigned_short);
> 
> might turn up an error.  From a quick test this seems to work
> correctly with gcc 8.2.1 that I have on my machine though, so the
> issue might be fixed in newer gcc version, even though that bug report
> is still marked as new.

Interesting. Looking at that thread, I actually don't think it would be
so bad to warn there anyway. It's true that due to integer promotion an
unsigned short will work with %u, but I'd be just as happy to switch
such a format to "%hu", which is more correct.

> Maybe it's worth going through the warnings at some point to see if it
> would be possible to turn -Wformat-signedness on.

I skimmed over a few of the results. There are definitely some that
could produce funny output. There are also many that are harmless (e.g.,
printing a constant 0 with "%o", which technically should be "0U"). I
don't think it's high priority, but if anybody wants to chip away at it,
be my guest.

In the meantime, I think your patch here is an obvious improvement.

-Peff
