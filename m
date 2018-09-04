Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 883391F404
	for <e@80x24.org>; Tue,  4 Sep 2018 20:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeIEAh6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 20:37:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:38850 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726749AbeIEAh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 20:37:58 -0400
Received: (qmail 27705 invoked by uid 109); 4 Sep 2018 20:11:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Sep 2018 20:11:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9676 invoked by uid 111); 4 Sep 2018 20:11:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Sep 2018 16:11:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Sep 2018 16:11:16 -0400
Date:   Tue, 4 Sep 2018 16:11:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tim Schumacher <timschumi@gmx.de>, git@vger.kernel.org
Subject: Re: [RFC PATCH] Allow aliases that include other aliases
Message-ID: <20180904201115.GD17481@sigill.intra.peff.net>
References: <20180904173915.2393-1-timschumi@gmx.de>
 <xmqqsh2p9mg8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsh2p9mg8.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 04, 2018 at 10:55:35AM -0700, Junio C Hamano wrote:

> Tim Schumacher <timschumi@gmx.de> writes:
> 
> > I submitted this as RFC because I'm not sure whether disallowing
> > nested aliases was an intentional design choice. The done_alias
> > check implies that disallowing is intended, but the direct
> > recursion check for aliases that call themselves opposes that.
> 
> "direct recursion check for aliases"?  I am not sure what you mean
> by that, but anyway.
> 
> If I recall correctly, it is intended that we disallow run_argv()
> doing handle_alias() twice (or more).  But the ultimate objective is
> to forbid infinite loops, "git foo" expanding to "git bar" which in
> turn expanding back to "git foo", and the current "do not expand
> alias to another" is a simple but too strict implementation.  As
> long as a replacement implementation still forbids infinite loops
> with reasonable cost and complexity, I do not think we would mind
> such an improvement to allow alias expanding to another alias.

I agree that this could be looser, if all we care about is infinite
loops. But given the issues we've had with aliases and the startup
sequence, I also would not be surprised if there is some weird hidden
effect if we call handle_alias() more than once.

That's not a reason not to pursue this, but just one more thing to look
out for.

As an aside, you can still do this:

  $ git config alias.foo '!git bar'
  $ git config alias.bar '!git foo'
  $ git foo
  [boy, my CPU fan is really spinning]

I don't know how much effort we actually need to put into people not
shooting themselves in the foot, since we can't cover all of the cases
anyway (and in a non-infinite configuration, that's another solution for
Tim's original problem).

-Peff
