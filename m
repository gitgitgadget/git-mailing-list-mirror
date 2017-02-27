Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F50C201B0
	for <e@80x24.org>; Mon, 27 Feb 2017 08:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbdB0ICm (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 03:02:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:34576 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751484AbdB0ICB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 03:02:01 -0500
Received: (qmail 13340 invoked by uid 109); 27 Feb 2017 08:02:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 08:02:00 +0000
Received: (qmail 20479 invoked by uid 111); 27 Feb 2017 08:02:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 03:02:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 03:01:59 -0500
Date:   Mon, 27 Feb 2017 03:01:59 -0500
From:   Jeff King <peff@peff.net>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [BUG] branch renamed to 'HEAD'
Message-ID: <20170227080158.de2xarctzscfdsp2@sigill.intra.peff.net>
References: <20170227045257.yazqlrqlnggosi5t@macbook.local>
 <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
 <20170227074915.xljfe5jox756rlyv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170227074915.xljfe5jox756rlyv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 02:49:15AM -0500, Jeff King wrote:

> > >         $ git branch -m -f orig @
> [...]
> 
> Regardless of the original intent, I think it is wrong to convert "@" to
> a branch named "HEAD". I think the bug is in strbuf_check_branch_ref(),
> which blindly sticks "refs/heads/" in front of any value we get from
> interpret_branch_name(), which clearly does not make sense for HEAD.

I do think the bug is in strbuf_check_branch_ref(), but it's hard for it
to do a better job. It needs to feed arbitrary expressions into
interpret_branch_name() to resolve things like "@{upstream}", "@{-1}",
"foo@{upstream}", etc.

The problem is that it expects a branch name to come out of
interpret_branch_name(), which _mostly_ happens. The exception is HEAD,
which is a "special" name. But the returned value doesn't indicate
whether it is special or not.

My first thought was that we might be handling "@" in the wrong place.
But it needs to happen here to make things like "@@{upstream}" work
(which turns "@" into HEAD, and then finds its upstream).

So I think the options are:

  1. Before calling interpret_branch_name(), strbuf_check_branch_ref()
     checks for "@". I don't like this because it's making assumptions
     about how the result will be parsed and interpreted.

  2. interpret_branch_name() returns a flag that says "this isn't
     _really_ a branch name".

  3. After interpret_branch_name() returns, check whether the result is
     "HEAD".

Doing (2) is the "right" thing in the sense that the "is it a branch"
logic remains with the matching parsing code. But we have to surface
that value (maybe across recursion via reinterpret?). Since we're
unlikely to ever grow a return value that matches this case except
"HEAD", it might be simplest to just do (3).

-Peff
