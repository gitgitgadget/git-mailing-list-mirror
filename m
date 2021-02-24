Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9BDC433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 18:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E8A864ECF
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 18:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhBXSV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 13:21:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:43270 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231561AbhBXSV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 13:21:26 -0500
Received: (qmail 832 invoked by uid 109); 24 Feb 2021 18:20:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Feb 2021 18:20:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16142 invoked by uid 111); 24 Feb 2021 18:20:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Feb 2021 13:20:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Feb 2021 13:20:44 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Aleksey Kliger <alklig@microsoft.com>
Subject: Re: [PATCH] wrapper: add workaround for open() returning EINTR
Message-ID: <YDaY/M3Rw+6xwZlf@coredump.intra.peff.net>
References: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
 <YDXaJHnZ5LgCj9NX@coredump.intra.peff.net>
 <xmqqzgzuyqli.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgzuyqli.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 09:36:25PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Feb 23, 2021 at 11:43:16PM -0500, Jeff King wrote:
> >
> >> The workaround here is enabled all the time, without a Makefile knob,
> >> since it's a complete noop if open() never returns EINTR. I did push it
> >> into its own compat/ source file, though, since it has to #undef our
> >> macro redirection. Putting it in a file with other code risks confusion
> >> if more code is added after that #undef.
> >
> > Whoops, sorry, I had a last-minute change of heart here and just stuck
> > it in wrapper.c with a bit of preprocessor magic to guard it. It felt
> > weird having compat/open.c, when the rest of compat/ is always
> > conditional on Makefile knobs. But I'm happy to go the other way if
> > anybody feels strongly.
> 
> Hmph, just like other workarounds, shouldn't this be "if your
> platform screws this up, define this knob to work it around"?  That
> would make it fit better with the rest of compat/.

I actually started that way, but then I got stuck deciding which
platforms in config.mak.uname to enable it for. We've seen it on Linux
and on macOS. I don't know how prevalent it is on those platforms (or
whether it is indeed a bug that may even get fixed). Since the check is
basically zero-cost at run-time, it seemed like it was worth just being
on guard for it so that nobody ever had to worry about it again.

But I don't feel that strongly. I'd be happy to do it with a Makefile
knob if you prefer.

> I dunno.  A no-op wrapper makes the code less transparent, which I
> am somewhat unhappy.

Yeah. I think the run-time cost is essentially zero, but it does add a
bit of complexity if you are debugging. And handling the magic mode
vararg definitely makes it uglier.

The other thing that gives me pause is that there may be other syscalls
which need the same treatment. Here's a recent discussion that Big Sur
may also return EINTR from the opendir() family:

  https://github.com/dotnet/runtime/issues/47584

Git is presumably susceptible to that, too; it's just that we call
open() a lot more frequently, so that was the obvious one that came up.

I don't think there is a more general way to address this, though. We'd
have to wrap each suspected syscall (but we could presumably at least
tie them all to a single Makefile knob). I'm not excited at the prospect
of preemptively adding such wrappers when we aren't even 100% sure that
there is a problem.

> But a wrapper that is always used even on
> platforms that do not need might give us a better chance of noticing
> a bug in the wrapper itself, making it less likely for us to leave
> only the users of minority broken platforms behind.  So...

That part I'm less worried about. It sounds like we'd want it on for
recent versions of macOS, which would give us pretty wide coverage to
notice a bug.

-Peff
