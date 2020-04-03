Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CFAC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 14:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EC420721
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 14:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390966AbgDCOEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:04:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:60506 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726087AbgDCOEs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 10:04:48 -0400
Received: (qmail 27827 invoked by uid 109); 3 Apr 2020 14:04:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Apr 2020 14:04:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19131 invoked by uid 111); 3 Apr 2020 14:15:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Apr 2020 10:15:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Apr 2020 10:04:47 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Fix -Wmaybe-uninitialized warnings under -O0
Message-ID: <20200403140447.GA639586@coredump.intra.peff.net>
References: <33984eeaabbfbcfd4b9d3903549d8b7d6c4ced7e.1585726172.git.liu.denton@gmail.com>
 <20200401095255.GA60227@coredump.intra.peff.net>
 <20200401140643.GA880372@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200401140643.GA880372@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 01, 2020 at 10:06:43AM -0400, Denton Liu wrote:

> > So why does your version behave differently? And if this is a temporary
> > state for a buggy version of gcc (that may be fixed in the next point
> > release), is it worth changing our source code to appease it?
> 
> A correction to the earlier message... It seems like I wasn't reporting
> the correct settings. I was actually compiling with -Og, not -O0
> (whoops!).
> 
> I tested it with gcc-8 and it seems like it also reports the same
> problem. Also, -O1 reports warnings as well.

Ah, OK, I can reproduce easily with -Og (up through gcc-10). Most of
them don't trigger with -O1; just the one in ref-filter.c.

That one's interesting. We have:

  int ret = 0;
  ...
  if (...)
         ...
  else
         ret = for_each_fullref_in_pattern(...);
  ...
  return ret;

So we'd either have 0 or an assigned return. But the bug is actually in
for_each_fullref_in_pattern(), which does this:

  int ret; /* uninitialized! */

  /* a bunch of early return conditionals */
  if (...)
    return ...;

  for_each_string_list_item(...) {
    ret = for_each_fullref_in(...);
  }

  return ret;

but that will return an uninitialized value when there are no patterns.
I doubt we have such a case, but that may explain why -O0 does not
complain (it assumes "in_pattern" will return a useful value) and -O2
does not (it is able to figure out that it always does), but -O1 only
inlines part of it.

Curiously, -Og _does_ find the correct function.

Your patch silences it, but is it doing the right thing? It sets "ret =
0", but we haven't actually iterated anything. Should it be an error
instead?

-Peff
