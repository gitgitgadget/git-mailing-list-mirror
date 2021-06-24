Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78001C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 15:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E14C613EB
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 15:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhFXPnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 11:43:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:59488 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhFXPna (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 11:43:30 -0400
Received: (qmail 12232 invoked by uid 109); 24 Jun 2021 15:41:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jun 2021 15:41:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13536 invoked by uid 111); 24 Jun 2021 15:41:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Jun 2021 11:41:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Jun 2021 11:41:10 -0400
From:   Jeff King <peff@peff.net>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: git add --interactive patch improvement for split hunks
Message-ID: <YNSnlhbE30xDfVMY@coredump.intra.peff.net>
References: <60D45FE4020000A100041FCE@gwsmtp.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60D45FE4020000A100041FCE@gwsmtp.uni-regensburg.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 24, 2021 at 12:35:16PM +0200, Ulrich Windl wrote:

> I noticed that git add -interactive's patch displays the function
> context for the diffs, but that function context is lost when the
> hunks are split.
>
> It would help the user (especially for hunks covering multiple
> functioins) if function context were still provided for split hunks.

This was discussed a while ago (and there is even a patch) in this
thread:

  https://lore.kernel.org/git/20201117020522.GD19433@coredump.intra.peff.net/

The short of it is that the upcoming builtin-in-C version of the code
will preserve the function header when splitting. The patch in that
message adds it to the existing perl version, but I didn't really bother
moving it forward, since that code is all supposed to eventually go
away[0].

One thing you may not like, though: both the builtin version and that
patch only put the funcname context in the _first_ hunk of the split.
Doing it for subsequent hunks is much trickier, since there can be a
funcname in the split context itself. E.g.:

  @@ ... @@ void foo()
           int x;
  -        int y = 1;
  +        int y = 2;
   
  -        x = 3;
  +        x = 4;
   }

could split into two hunks, both annotated with "void foo()". But:

  @@ ... @@ void foo()
           int x;
  -        x = 3;
  +        x = 4;
   }
   void bar()
   {
  -        int y = 1;
  +        int y = 2;
   }

would be wrong to say "void foo()" for the second hunk. We'd have to
re-scan the interior context lines for a funcname to find it. That's
all-but-impossible in the perl version, but might be do-able in the C
version (since it has easy access to the funcname-matching patterns and
machinery).

-Peff

[0] I'm not sure what the timetable is for switching to the C version of
    add--interactive. If it's going to be a while, I don't mind moving
    forward the other patch I showed. But maybe the time is here to
    think about switching the default of add.interactive.useBuiltin, and
    ironing out any final bugs?
