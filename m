Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E519D1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 16:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbcHPQMg (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 12:12:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:56309 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752367AbcHPQMU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 12:12:20 -0400
Received: (qmail 16691 invoked by uid 109); 16 Aug 2016 16:12:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 16:12:20 +0000
Received: (qmail 27561 invoked by uid 111); 16 Aug 2016 16:12:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 12:12:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2016 12:12:17 -0400
Date:	Tue, 16 Aug 2016 12:12:17 -0400
From:	Jeff King <peff@peff.net>
To:	Dmitry Neverov <dmitry.neverov@gmail.com>
Cc:	Git List <git@vger.kernel.org>
Subject: Re: Credential helpers processing order
Message-ID: <20160816161216.xva2f2lp53u57bo4@sigill.intra.peff.net>
References: <CAC+L6n0j0=6haBprM2ip75=orEi_5oBedHV1iPBTgi-N8Y6=4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC+L6n0j0=6haBprM2ip75=orEi_5oBedHV1iPBTgi-N8Y6=4A@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 05:13:55PM +0200, Dmitry Neverov wrote:

> I wonder why credential helpers are called in the order: system,
> global, local, command-line and not in the reverse order? This make it
> impossible to provide a custom helper and disable default ones via
> command-line parameter. My use-case is to clone a repository in a
> non-interactive environment where a system-level GUI helper is
> configured: clone hangs since system-level helper called first and
> there is no input from the user. Also if a system-level helper sets
> quit=true, then lower-level helpers won't be called at all. Is it by
> design?

I agree that it's not really a sensible order. But reversing them isn't
quite right either. The problem is that the config code just gives the
credential code a sequence of items, with no indication which file they
came from, with what priority, etc.

For config keys with a single value, "last one wins" makes sense; we
just keep overwriting the previous value.

But for lists (like credential.helper, but also other things like
remote.*.fetch), we just build up the list. And we can't tell the
difference between two items next to each in the same file, or two in
different files with differing priorities.

Fixing that would be tricky. But I think for your case (and most similar
cases), you'd be happy to just be able to "reset" the list to empty. As
of git v2.9.0, you can do that, like so:

  [credential]
  helper = "!echo >&2 should not run;:"
  helper =
  helper = "!echo >&2 should run;:"

-Peff
