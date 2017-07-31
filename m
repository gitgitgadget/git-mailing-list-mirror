Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5984320899
	for <e@80x24.org>; Mon, 31 Jul 2017 03:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbdGaDec (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 23:34:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:53092 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751746AbdGaDeb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 23:34:31 -0400
Received: (qmail 28151 invoked by uid 109); 31 Jul 2017 03:34:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 31 Jul 2017 03:34:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22905 invoked by uid 111); 31 Jul 2017 03:34:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 30 Jul 2017 23:34:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Jul 2017 23:34:29 -0400
Date:   Sun, 30 Jul 2017 23:34:29 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 05/10] git.c: provide setup_auto_pager()
Message-ID: <20170731033429.dgftfeum6n3ddxua@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com>
 <cover.1500321657.git.martin.agren@gmail.com>
 <b6ab825d3bda4b40201b0aa8e97c9fd721ed8171.1500321658.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6ab825d3bda4b40201b0aa8e97c9fd721ed8171.1500321658.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 17, 2017 at 10:10:47PM +0200, Martin Ågren wrote:

> The previous patch introduced a way for builtins to declare that they
> will take responsibility for handling the `pager.foo`-config item. (See
> the commit message of that patch for why that could be useful.)
> 
> Provide setup_auto_pager(), which builtins can call in order to handle
> `pager.<cmd>`, including possibly starting the pager. Make this function
> don't do anything if a pager has already been started, as indicated by
> use_pager or pager_in_use().
> 
> Whenever this function is called from a builtin, git.c will already have
> called commit_pager_choice(). Since commit_pager_choice() treats the
> special value -1 as "punt" or "not yet decided", it is not a problem
> that we might end up calling commit_pager_choice() once in git.c and
> once (or more) in the builtin. Make the new function use -1 in the same
> way and document it as "punt".

At first I wasn't sure if it would ever make sense to use "-1" here. The
"punt" that happens in earlier calls to commit_pager_choice() is there
because we might adjust our decision later. And this would generally be
the final decision, I would think. So I'd be surprised if we had
anything besides "0" or "1" in the "def" argument.

But thinking on it, the most plausible case is something like:

  setup_auto_pager("foo", -1);
  ...
  /* fallback to some historical compatibility name */
  setup_auto_pager("bar", 0);

And it's important for the "-1" there to be a true punt, and not do
anything in commit_pager_choice(). So it's probably worth documenting
the "-1" behavior as you did here as a possible value for "def".

-Peff
