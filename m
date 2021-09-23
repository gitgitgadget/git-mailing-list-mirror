Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97D2C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97BE560F6D
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243244AbhIWVVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 17:21:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:53952 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243241AbhIWVVi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 17:21:38 -0400
Received: (qmail 16016 invoked by uid 109); 23 Sep 2021 21:20:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Sep 2021 21:20:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32488 invoked by uid 111); 23 Sep 2021 21:20:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Sep 2021 17:20:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Sep 2021 17:20:04 -0400
From:   Jeff King <peff@peff.net>
To:     The Grey Wolf <greywolf@starwolf.com>
Cc:     git@vger.kernel.org
Subject: Re: ANSI sequences produced on non-ANSI terminal
Message-ID: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
References: <20210923052122.2F655CE@eddie.starwolf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210923052122.2F655CE@eddie.starwolf.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 10:21:22PM -0700, The Grey Wolf wrote:

> Anything else you want to add:
> 	I searched google and the documentation as best I was able for
> 	this, but I am unable to find anywhere that will let me disable
> 	(or enable) colour for a particular term type.  Sometimes I'm on
> 	an xterm, for which this is GREAT.  Sometimes I'm on a Wyse WY60,
> 	for which this is sub-optimal.  My workaround is to disable colour
> 	completely, which is reluctantly acceptable, but it would be nice
> 	to say "If I'm on an xterm/aterm/urxvt/ansi terminal, enable
> 	colour or cursor-positioning, otherwise shut it off."  If this
> 	seems too much of a one-off to handle, fine, but most things that
> 	talk fancy to screens are kind enough to allow an opt-out based on
> 	terminal type. :)

Git doesn't have any kind of list of terminals, beyond knowing that
"dumb" should disable auto-color. It's possible we could expand that if
there are known terminals that don't understand ANSI colors. I'm a bit
wary of having a laundry list of obscure terminals, though.

If we built against ncurses or some other terminfo-aware library we
could outsource that, but that would be a new dependency. I'm hesitant
to do that even as an optional dependency given the bang-for-the-buck
(and certainly making it require would be right out).

Obviously you can wrap Git with a script to tweak the config based on
the current setting of the $TERM variable. It would be nice if you could
have conditional config for that. E.g., something like:

  [includeIf "env:TERM==xterm"]
  path = gitconfig-color

That doesn't exist, but would fit in reasonably well with our other
conditional config options.

As far as generating non-ANSI codes, that's all Git knows how to do. I'm
not sure what kind of color codes your terminal might support. It
_might_ be possible to support multiple, but from my knowledge of Git's
color code I suspect it would be quite ugly. You'd probably be better
off post-processing the ANSI codes. You can do so automatically-ish with
something like:

  git config pager.log 'convert-ansi-to-whatever | less'

I don't know offhand of anything that would do such conversion out of
the box, but you could probably built it around tput or a terminfo
library.

Note that we do similar post-processing on Windows, albeit internally
by intercepting fprintf, etc (yuck). See compat/winansi.c, which might
give you some logic which would be reused.

-Peff
