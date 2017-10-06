Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C03B1FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 14:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbdJFOSX (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 10:18:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:35286 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750970AbdJFOSX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 10:18:23 -0400
Received: (qmail 6211 invoked by uid 109); 6 Oct 2017 14:18:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 14:18:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6525 invoked by uid 111); 6 Oct 2017 14:18:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 10:18:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 10:18:20 -0400
Date:   Fri, 6 Oct 2017 10:18:20 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com
Subject: Re: [PATCH] cleanup: fix possible overflow errors in binary search
Message-ID: <20171006141820.6vd3qt6iosxcgebm@sigill.intra.peff.net>
References: <20171005094418.irm6omly67bgyvo7@sigill.intra.peff.net>
 <20171006135231.239232-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171006135231.239232-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 06, 2017 at 09:52:31AM -0400, Derrick Stolee wrote:

> A common mistake when writing binary search is to allow possible
> integer overflow by using the simple average:
> 
> 	mid = (min + max) / 2;
> 
> Instead, use the overflow-safe version:
> 
> 	mid = min + (max - min) / 2;

Great, thank you for picking this up!

> The included changes were found using the following two greps:
> 
> 	grep "/ 2;" *.c
> 	grep "/ 2;" */*.c
> 	grep "/2;" */*.c

You can use[1]:

  git grep '/ 2;' '*.c'

to have Git expand the wildcard. That catches a few extra cases in
compat/regex/*.c.  Even though it's imported code, it might be
nice to cover those, too (since it's a possible bug, and also as a good
example).

[1] I'd actually write:

      git grep '/ *2;' '*.c'

    to do it all in one grep. :)

> ---
>  builtin/index-pack.c     | 4 ++--
>  builtin/pack-objects.c   | 2 +-
>  builtin/unpack-objects.c | 2 +-
>  cache-tree.c             | 2 +-
>  packfile.c               | 2 +-
>  sha1-lookup.c            | 2 +-
>  sha1_name.c              | 2 +-
>  string-list.c            | 2 +-
>  utf8.c                   | 2 +-
>  xdiff/xpatience.c        | 2 +-
>  10 files changed, 11 insertions(+), 11 deletions(-)

These all look good to me (really the only way the conversion could be
bad is if "min" was higher than "max", and each case is just inside a
loop condition which makes sure that is not the case).

-Peff
