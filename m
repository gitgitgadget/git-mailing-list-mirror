Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EB4C43460
	for <git@archiver.kernel.org>; Tue, 18 May 2021 07:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB34161350
	for <git@archiver.kernel.org>; Tue, 18 May 2021 07:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346774AbhERHRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 03:17:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:57426 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239586AbhERHRX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 03:17:23 -0400
Received: (qmail 11115 invoked by uid 109); 18 May 2021 07:16:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 07:16:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5325 invoked by uid 111); 18 May 2021 07:16:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 May 2021 03:16:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 May 2021 03:16:04 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Man pages have colors? A deep dive into groff
Message-ID: <YKNptH9DL6pe18Dk@coredump.intra.peff.net>
References: <60a046bd83001_f4b0f20861@natae.notmuch>
 <87tun1qp91.fsf@evledraar.gmail.com>
 <xmqqlf8d6ty5.fsf@gitster.g>
 <60a2f1c4cab0d_13c3702083a@natae.notmuch>
 <xmqqim3g4ys5.fsf@gitster.g>
 <60a3422b9556c_14d1bc2082f@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60a3422b9556c_14d1bc2082f@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 11:27:23PM -0500, Felipe Contreras wrote:

> > So in short, the color.pager is about "is the pager capable of
> > colors?"
> 
> That's not the case.
> 
> Even the documentation says so:
> 
>   color.pager::
>     A boolean to enable/disable colored output when the pager is in
>     use (default is true).

I think that documentation misses the reason you'd want to use it.
Likewise, the commit message introducing it (aa086eb813d) sucks, but the
motivation (from [0]) was:

  When I use a pager that escapes the escape character or highlights the
  content itself the output of git diff without the pager should have
  colors but not with the pager.  For example using git diff with a
  pathspec is quite short most of the time.  For git diff I have to
  enable paging manually and run git diff | $PAGER usually but git log
  uses the pager automatically and should not use colors with it.

For a more concrete example, my pager _does_ understand colors, and I
would not want to set pager.color to "false" (because then "git log",
etc, would not show me any colors). But I don't like the man colors you
are suggesting. I want to be able to turn them off by setting
"color.man" or similar to false, not by disabling color for everything
that is paged.

So color.pager being true is _necessary_ for showing colors in paged
outputs, but by itself is not sufficient. We have other per-context
color options (color.diff, color.branch, and so on).

And so likewise, we would want to avoid turning on colors if the user
has set color.pager=false. Usually this is done automatically because
want_color() checks, which knows if we are using the pager or not. But
if we are going to call out to "man" which will invoke another pager,
that caller would have to check pager_use_color themselves (it's yet
another question of whether "the pager can handle color" applies equally
to the pager that Git will run versus the one that man will run).

-Peff

[0] https://lore.kernel.org/git/E1G6zPH-00062L-Je@moooo.ath.cx/
