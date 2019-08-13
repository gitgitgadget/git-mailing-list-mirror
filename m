Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 309111F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 12:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfHMMRf (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:17:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:41658 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725953AbfHMMRe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 08:17:34 -0400
Received: (qmail 3262 invoked by uid 109); 13 Aug 2019 12:17:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 13 Aug 2019 12:17:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31513 invoked by uid 111); 13 Aug 2019 12:20:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Aug 2019 08:20:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Aug 2019 08:17:33 -0400
From:   Jeff King <peff@peff.net>
To:     nanaya <edho@fastmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git grep -F (fixed string) requires matching parenthesis?
Message-ID: <20190813121733.GA10787@sigill.intra.peff.net>
References: <35477812-7889-4f32-85ac-d3da4e7ff902@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35477812-7889-4f32-85ac-d3da4e7ff902@www.fastmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 13, 2019 at 03:01:04PM +0900, nanaya wrote:

> I observed this today:
> 
> $ git grep -F '('
> fatal: unmatched parenthesis
> 
> Which doesn't make sense and I believe shouldn't happen.

At first glance this looks like we're feeding a fixed-string pattern to
the regex compiler, which would indeed be a bug.

But I think it's actually happening at a level above that. git-grep
supports multiple patterns, which can be joined with --and, --or, --not,
etc. And they can be grouped with parentheses.

What you're seeing is the argument parser thinking your '(' is part of
the construction of a boolean match formula, and complaining about the
lack of closing ')'. You can use "-e" to make it clear that it's a
pattern (just as you'd need to for a pattern that starts with "-"):

  git grep -F -e '('

So I think everything is working as designed, though I admit the
implication was slightly surprising to me (and note that it only happens
with that _specific_ pattern; something like "(foo" would not be matched
by the option parser).

-Peff
