Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D8E41FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 19:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967061AbdCXTcB (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 15:32:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:51322 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967185AbdCXTb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 15:31:56 -0400
Received: (qmail 27214 invoked by uid 109); 24 Mar 2017 19:31:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 19:31:52 +0000
Received: (qmail 32112 invoked by uid 111); 24 Mar 2017 19:32:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 15:32:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 15:31:50 -0400
Date:   Fri, 24 Mar 2017 15:31:50 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCHv2 07/14] completion: don't disambiguate short refs
Message-ID: <20170324193149.pa4lrsodgmgsvidl@sigill.intra.peff.net>
References: <20170323152924.23944-1-szeder.dev@gmail.com>
 <20170323152924.23944-8-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170323152924.23944-8-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 04:29:17PM +0100, SZEDER Gábor wrote:

> However, it's questionable whether ambiguous refs are really that bad
> to justify that much extra cost:

It's not clear to me that the existing completion actually does a good
job with disambiguation anyway.

If I have a tag and a branch named "foo", then in theory doing:

  git log fo<Tab>

should present me with "heads/foo" and "tags/foo" as options. But it
doesn't seem to; it just completes "foo".

But even if it did, those don't _start_ with foo, I have to go to some
work to back up anyway. I think we are better off just completing "foo"
and letting the command complain that it's ambiguous.

So even leaving aside the performance tradeoff, that seems like a more
sensible behavior anyway. And AFAICT, that's the behavior you'd get with
your patch (we'd get two "foo"s, but the completion is presumably smart
enough to handle that.

> This speeds up refs completion considerably.  Uniquely completing a
> branch in a repository with 100k local branches, all packed, best of
> five:
> 
>   On Linux, before:
> 
>     $ time __git_complete_refs --cur=maste
> 
>     real    0m1.662s
>     user    0m1.368s
>     sys     0m0.296s
> 
>   After:
> 
>     real    0m0.831s
>     user    0m0.808s
>     sys     0m0.028s

This is nice, though I think faster ref storage is another way to attack
the problem. This is much simpler, though. :)

-Peff
