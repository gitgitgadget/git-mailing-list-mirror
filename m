Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD69207EC
	for <e@80x24.org>; Sun, 25 Sep 2016 07:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422927AbcIYHlt (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 03:41:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:47678 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422788AbcIYHls (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 03:41:48 -0400
Received: (qmail 22706 invoked by uid 109); 25 Sep 2016 07:41:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 25 Sep 2016 07:41:47 +0000
Received: (qmail 28824 invoked by uid 111); 25 Sep 2016 07:42:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 25 Sep 2016 03:42:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Sep 2016 03:41:44 -0400
Date:   Sun, 25 Sep 2016 03:41:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] add COPY_ARRAY
Message-ID: <20160925074144.44onzv5pub5dxuix@sigill.intra.peff.net>
References: <6f402d35-b483-7552-2fb2-a5350112b8a6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f402d35-b483-7552-2fb2-a5350112b8a6@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 25, 2016 at 09:15:42AM +0200, René Scharfe wrote:

> Add COPY_ARRAY, a safe and convenient helper for copying arrays,
> complementing ALLOC_ARRAY and REALLOC_ARRAY.  Users just specify source,
> destination and the number of elements; the size of an element is
> inferred automatically.

Seems like a fairly readable construct to have.

> It checks if the multiplication of size and element count overflows.
> The inferred size is passed first to st_mult, which allows the division
> there to be done at compilation time.

I wonder if this actually stops any real overflows. My goal with
ALLOC_ARRAY, etc, was to catch these at the malloc stage (which is the
really dangerous part, because we don't want to under-allocate). So the
first hunk of your patch is:

        ALLOC_ARRAY(result, count + 1);
-       memcpy(result, pathspec, count * sizeof(const char *));
+       COPY_ARRAY(result, pathspec, count);

which clearly cannot trigger the st_mult() check, because we would have
done so in the ALLOC_ARRAY call[1].

Other calls are not so obvious, but in general I would expect the
allocation step to be doing this check. If we missed one, then it's
possible that this macro could detect it and prevent a problem. But it
seems like the wrong time to check. The allocation is buggy, and we'd
have to just get lucky to be using COPY_ARRAY(). And I don't even mean
"lucky that we switched to COPY_ARRAY from memcpy for this callsite".
There are lots of sites that allocate and then fill the array one by
one, without ever computing the full size again. So allocation is the
only sensible place to enforce integer overflow.

So I'm not sold on this providing any real integer overflow safety. But
I do otherwise like it, as it drops the extra "sizeof" which has to
repeat either the variable name or the type).

-Peff

[1] Actually, this particular example probably should be using
    st_add(count, 1), though it's likely not a problem in practice
    ("count" is an int, so you cannot easily overflow it back to 0 by
    incrementing 1, though of course overflowing it at all is undefined
    behavior).
