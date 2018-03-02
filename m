Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 539A91F576
	for <e@80x24.org>; Fri,  2 Mar 2018 10:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424102AbeCBKm7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 05:42:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:44022 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1424139AbeCBKme (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 05:42:34 -0500
Received: (qmail 7124 invoked by uid 109); 2 Mar 2018 10:42:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Mar 2018 10:42:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27155 invoked by uid 111); 2 Mar 2018 10:43:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Mar 2018 05:43:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2018 05:42:32 -0500
Date:   Fri, 2 Mar 2018 05:42:32 -0500
From:   Jeff King <peff@peff.net>
To:     Sam Kuper <sam.kuper@uclmail.net>
Cc:     git@vger.kernel.org
Subject: Re: Bug report: "Use of uninitialized value $_ in print"
Message-ID: <20180302104232.GA11074@sigill.intra.peff.net>
References: <CAD-Jur+6m1SjqHVWBxW5HnTjutSVrkP+dEXdYmFHzoUf0FGdNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD-Jur+6m1SjqHVWBxW5HnTjutSVrkP+dEXdYmFHzoUf0FGdNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 02, 2018 at 01:19:35AM +0000, Sam Kuper wrote:

> The bug is that in the midst of running
> 
> git -c interactive.diffFilter="git diff --word-diff --color" add --patch

That's not how interactive.diffFilter is supposed to work.

It's meant to have the output of an existing diff piped into it.
Generating the diff anew will appear to work for some simple cases, but
fall down for others:

  1. Any of the flavors besides "add -p" will be running the wrong diff
     (e.g., "reset -p" runs a diff between the index and HEAD).

  2. Any pathspec limiters would be ignored (e.g., "add -p file").

  3. Your invocation in particular is a problem because it uses
     --word-diff, which will not have a one-to-one line correspondence
     with the bare diff.

     add--interactive handles pretty-printing by running the diff
     command twice: once with no special options, and once with
     "--color" and piped through the diffFilter. It assumes that the two
     match each other line for line, so it shows you the "DISPLAY"
     variant, but then ultimately applies the "TEXT" variant.

And that last one is the cause of the errors you see:

> Use of uninitialized value $_ in print at
> /usr/lib/git-core/git-add--interactive line 1371, <STDIN> line 74.

The "DISPLAY" run for your case generates fewer lines than the "TEXT"
run, and we complain on trying to show those extra lines.

Unfortunately, I don't think there's an easy way to do what you want
(show word-diffs but apply the full diff).

-Peff
