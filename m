Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F1191F5FB
	for <e@80x24.org>; Tue, 28 Feb 2017 00:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbdB1AmZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 19:42:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:35296 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751783AbdB1AmY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 19:42:24 -0500
Received: (qmail 10869 invoked by uid 109); 28 Feb 2017 00:42:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 00:42:23 +0000
Received: (qmail 21916 invoked by uid 111); 28 Feb 2017 00:42:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 19:42:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 19:42:21 -0500
Date:   Mon, 27 Feb 2017 19:42:21 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [BUG] branch renamed to 'HEAD'
Message-ID: <20170228004220.66fq567am7chjxfe@sigill.intra.peff.net>
References: <20170227045257.yazqlrqlnggosi5t@macbook.local>
 <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
 <20170227074915.xljfe5jox756rlyv@sigill.intra.peff.net>
 <20170227080158.de2xarctzscfdsp2@sigill.intra.peff.net>
 <20170227090233.uk7dfruggytgmuw2@sigill.intra.peff.net>
 <xmqq60jvnu9y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60jvnu9y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 02:28:09PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I guess something like the patch below works, but I wonder if there is a
> > less-horrible way to accomplish the same thing.
> 
> I suspect that a less-horrible would be a lot more intrusive.  It
> would go like "interpret-branch-name only gives local branch name,
> and when it does not show it, the callers that know they do not
> necessarily need local branch name would call other at-mark things".
> As you pointed out with the @{upstream} that potentially point at a
> local branch, it will quickly get more involved, I would think, and
> I tend to think that this patch of yours is probably the least evil
> one among possible solutions.  
> 
> Perhaps with s/not_in_refs_heads/not_a_branch_name/ (or swapping
> polarity, "is_a_branch_name"), the resulting code may not be too
> hard to read?

I actually started with not_a_branch_name, but I wanted specifically to
talk about refs_heads, because we sometimes refer to remote-tracking
branches as "branches" (and the function is called interpret_branch_name(),
after all).

I agree it would be easier to read if the logic were flipped, but I'm
not sure that would be correct. The function knows when it has done a
replacement that takes us outside of a normal branch name. But when it
hasn't, it doesn't really know how the result should be interpreted.

For our purposes in this caller it is enough to say that "foo" should be
treated as "refs/heads/foo", but I don't think that is generally true of
interpret_branch_name(), which might be called as part of get_sha1().

So one alternative is to leave the logic the same way but try to give it
a better name. E.g., call it something like "replaced_with_non_branch"
or something. But there, another negation snuck in. The correct
non-negated thing is really "replaced_with_HEAD_or_refs_remotes" but
that is rather awkward.

-Peff
