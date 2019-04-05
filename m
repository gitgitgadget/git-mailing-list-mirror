Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E017F20248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfDESlN (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:41:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:48862 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731183AbfDESlN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:41:13 -0400
Received: (qmail 12329 invoked by uid 109); 5 Apr 2019 18:41:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 18:41:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28642 invoked by uid 111); 5 Apr 2019 18:41:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 14:41:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 14:41:11 -0400
Date:   Fri, 5 Apr 2019 14:41:11 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 6/7] rev-list: let traversal die when --missing is not in
 use
Message-ID: <20190405184111.GE2284@sigill.intra.peff.net>
References: <cover.1554435033.git.me@ttaylorr.com>
 <a3a80b4b2a988eb65d85a5acd54c584d047073c7.1554435033.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3a80b4b2a988eb65d85a5acd54c584d047073c7.1554435033.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 04, 2019 at 08:37:54PM -0700, Taylor Blau wrote:

>  3. have the traversal machinery communicate the failure to the caller,
>     so that it can decide how to proceed without re-evaluting the object
>     itself.
> 
> Of those, I think (3) is probably the best path forward. However, this
> patch does none of them. In the name of expediently fixing the
> regression to a normal "rev-list --objects" that we use for connectivity
> checks, this simply restores the pre-7c0fe330d5 behavior of having the
> traversal die as soon as it fails to load a tree (when --missing is set
> to MA_ERROR, which is the default).

I think this is worth doing, as it restores the earlier behavior. But a
few general thoughts (which I've shared already with you, but for the
benefit of the list):

 - actually doing the "communicate failure to the caller" would probably
   not be too bad as a single-bit PARSE_FAILED flag in obj->flags. But
   it does require the caller understanding which objects the traversal
   would try to parse (i.e., rev-list would have to understand that it
   is on its own to check blobs, even if they don't have a PARSE_FAILED
   flag).

 - speaking of blobs, this series does not help rev-list find a
   mis-typed or bit-rotted blob at all, because it never opens the
   blobs. Does that mean my expectations for rev-list are simply too
   high, and that we should be expecting fsck-like checks to catch
   these? I dunno.

   It would not be too expensive to convert the existing "do we have the
   blob" check in rev-list to "do we have it, and is its type correct?".
   But obviously finding bitrot would be super-expensive. Which leads me
   to...

 - there actually _is_ a --verify-objects option, which would check even
   blobs for bitrot. It was added long ago in 5a48d24012 (rev-list
   --verify-object, 2011-09-01) for use with check_connected(). But it
   was deemed too slow for normal use, and ripped out in d21c463d55
   (fetch/receive: remove over-pessimistic connectivity check,
   2012-03-15).

That last one implies that we're OK relying on the incoming index-pack
to catch these cases (which is going to do a sha1 over each object).

It does seem like we should bother to notice failures when it's _free_
to do so, which is the case with these tree-loading failures. Which is
basically what this patch is doing.

-Peff
