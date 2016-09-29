Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E620E207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 13:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754734AbcI2ND2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 09:03:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:49894 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753336AbcI2ND0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 09:03:26 -0400
Received: (qmail 25940 invoked by uid 109); 29 Sep 2016 13:03:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 13:03:25 +0000
Received: (qmail 1367 invoked by uid 111); 29 Sep 2016 13:03:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 09:03:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 09:03:22 -0400
Date:   Thu, 29 Sep 2016 09:03:22 -0400
From:   Jeff King <peff@peff.net>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 10/10] get_short_sha1: list ambiguous objects on error
Message-ID: <20160929130322.562ng4t2ktk6qzok@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
 <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net>
 <2242637D-4C3B-4AF2-8BE4-823B3E1745D5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2242637D-4C3B-4AF2-8BE4-823B3E1745D5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 04:46:19AM -0700, Kyle J. McKay wrote:

> This hint: information is excellent.  There needs to be a way to show it on
> demand.
> 
> $ git rev-parse --disambiguate=b2e1
> b2e11962c5e6a9c81aa712c751c83a743fd4f384
> b2e11d1bb40c5f81a2f4e37b9f9a60ec7474eeab
> b2e163272c01aca4aee4684f5c683ba341c1953d
> b2e18954c03ff502053cb74d142faab7d2a8dacb
> b2e1895ca92ec2037349d88b945ba64ebf16d62d
> 
> Not nearly so helpful, but the operation of --disambiguate cannot be changed
> without breaking current scripts.
> 
> Can your excellent "hint:" output above be attached to the --disambiguate
> option somehow, please.  Something like this perhaps:
> 
> $ git rev-parse --disambiguate-list=b2e1
> b2e1196 tag v2.8.0-rc1
> b2e11d1 tree
> b2e1632 commit 2007-11-14 - Merge branch 'bs/maint-commit-options'
> b2e1759 blob
> b2e18954 blob
> b2e1895c blob

I think the "right" way to do this is pipe the list of sha1s into
another git commit which can format them however you want.
Unfortunately, there isn't a single command that does a great job:

  - "cat-file --batch-check" can show you the sha1 and type, but it
    won't abbreviate sha1s, and it won't show you commit/tag information

  - "log --stdin --no-walk" will format the commit however you like, but
    skips the trees and blobs entirely, and the tag can only be seen via
    "%d"

  - "for-each-ref" has flexible formatting, too, but wants to format
    refs, not objects (and doesn't read from stdin).

IMHO that is a sign that our formatting tools aren't as good as they
could be (I think the right tool is cat-file, but it should be able to
do all of the formatting that the other commands can do).

Of course if you really just want human-readable output, then:

  $ git cat-file -e b2e1
  error: short SHA1 b2e1 is ambiguous
  hint: The candidates are:
  hint:   b2e1196 tag v2.8.0-rc1
  hint:   b2e11d1 tree
  hint:   b2e1632 commit 2007-11-14 - Merge branch 'bs/maint-commit-options'
  hint:   b2e1759 blob
  hint:   b2e18954 blob
  hint:   b2e1895c blob
  fatal: Not a valid object name b2e1

is pretty easy.

That being said, I don't mind if somebody wanted to do a rev-parse
option on top of my series. The formatting code is already split into
its own function.

-Peff
