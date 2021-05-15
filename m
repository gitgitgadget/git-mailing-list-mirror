Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE4BC433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 10:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5586128A
	for <git@archiver.kernel.org>; Sat, 15 May 2021 10:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbhEOKN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 06:13:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:55476 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231432AbhEOKNy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 06:13:54 -0400
Received: (qmail 23573 invoked by uid 109); 15 May 2021 10:12:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 15 May 2021 10:12:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8945 invoked by uid 111); 15 May 2021 10:12:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 May 2021 06:12:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 15 May 2021 06:12:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] prompt.h: clarify the non-use of git_prompt
Message-ID: <YJ+elwq2OkvSgvJc@coredump.intra.peff.net>
References: <20210513214152.34792-1-firminmartin24@gmail.com>
 <20210513214152.34792-2-firminmartin24@gmail.com>
 <xmqqv97m8dnw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv97m8dnw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 14, 2021 at 07:36:03AM +0900, Junio C Hamano wrote:

> Firmin Martin <firminmartin24@gmail.com> writes:
> 
> > +/*
> > + * This function should not be used for regular prompts (i.e., asking user for
> > + * confirmation or picking an option from an interactive menu) as it only
> > + * accepts input from /dev/tty, thus making it impossible to test with the
> > + * current test suite.  Please instead use git_read_line_interactively for that
> > + * purpose.  See 97387c8bdd (am: read interactive input from stdin, 2019-05-20)
> > + * for historical context.
> > + *
> > + */
> 
> I have a strong objection against the above phrasing.
> 
> If we are asking user for interactive input, this SHOULD be used,
> especially if we might be reading the data to work on from the
> standard input and we may need to ask the user to interactively
> instruct us what to do to that data.  The only plausible reason that
> we may want to avoid it and instead prefer the (misnamed)
> read_line_interactively() to read whatever from the standard input
> (which may not be "interactive" at all, which is why I said
> "misnamed") is because our test framework does not use setsid (and
> setsid(1) may not be universally available) with pty to emulate tty
> input, isn't it?

I'm not sure I agree with your "should". Sometimes it's convenient to
access the controlling terminal directly, but sometimes it's convenient
to be able to drive the interaction of programs over stdin. Obviously
our tests are more interested in doing that than most users would be,
but it can still be handy (e.g., driving them from another non-terminal
program). Arguably nobody should be doing that as these are porcelains,
but I wouldn't be at all surprised if it happens (especially for
something like add--interactive).

In such a case, switching from stdin to /dev/tty may be considered a
regression (I know that the patches here are switching bisect away from
using the tty, but I think it is just reversing what happened with the
recent switch from git-bisect.sh to the builtin, though I think it
insisted on "test -t 0" in the old code, so the distinction may be
moot).

I dunno. I guess I don't feel all that strongly, but I just generally
find stdin more convenient than accessing the tty directly (because it's
easy to do "</dev/tty", but hard to set up a controlling terminal). But
I admit that I am a lot more likely to drive our programs via script for
testing or debugging than normal users would.

-Peff
