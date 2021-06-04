Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0080FC47083
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 04:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99F560720
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 04:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhFDEFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 00:05:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:45852 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFDEFd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 00:05:33 -0400
Received: (qmail 8443 invoked by uid 109); 4 Jun 2021 04:03:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Jun 2021 04:03:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32185 invoked by uid 111); 4 Jun 2021 04:03:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Jun 2021 00:03:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Jun 2021 00:03:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Ilias Apostolou <ilias.apostolou.zero@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request feature: =?utf-8?B?4oCTbm8t?= =?utf-8?Q?submodule?=
Message-ID: <YLmmIXy/SITKh/Yw@coredump.intra.peff.net>
References: <c5709df6-c357-56b4-f0e0-673bc8b4e668@gmail.com>
 <YLfqiLbpPXWXHlBi@nand.local>
 <xmqq8s3r7oma.fsf@gitster.g>
 <YLg/dLqYFEqHZJUn@nand.local>
 <xmqq7dja6e46.fsf@gitster.g>
 <YLkr+kLdjmHyPjgl@coredump.intra.peff.net>
 <xmqqo8cm4nst.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8cm4nst.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 04, 2021 at 06:54:10AM +0900, Junio C Hamano wrote:

> > An alternative view is allowing a pathspec that asks about the mode:
> >
> >   git ls-files ':(mode=160000)'
> >
> > That also lets you ask about other things, like:
> >
> >   git ls-files ':(mode=100755)'
> >
> > but it is probably unnecessarily arcane (even I had to look up the
> > correct mode for a gitlink just now :) ).
> 
> The original request, as I understand the clarification posted
> upthread, is not "submodules are uninteresting", but is "we want
> regular files" (and we postprocess further the output), so such a
> "mode" (pseudo-)attribute that is automatically populated would be a
> better fit anyway.  With the current system, they can already do:
> 
>     git ls-files -s ':(exclude)*.png' ':(exclude)*.ico)' |
>     sed -n -e 's/^100[76][54][54] [0-9a-f]* 0       //p' |
>     xargs dos2unix
> 
> (cf. <9cc98ca3-bdc5-61bf-450a-99bb47673d6c@gmail.com>)
> 
> and with such an auto-pseudo-attribute, presumably something along
> this line would work, removing the need for the intermediate filter:
> 
>     git ls-files \
> 	':(attr:mode=100755)' ':(attr:mode=100644)' \
> 	':(exclude)*.png' ':(exclude)*.ico' |
>     xargs dos2unix
> 

Yeah, that makes sense.

By the way, another reason (beyond a simpler pipeline) that the "magic
pathspec that understands modes" is nicer is that it can be applied to a
more dynamic set of paths.

For instance, you could use a pipeline like the one you showed above to
limit the ls-files output, and then you could feed that set of literal
paths to a command like "git add" (perhaps with --literal-pathspecs).
But you would not want to feed it to git-log like:

  git --literal-pathspecs log $(git ls-files -s | sed ...)

because you'd really want to expand the set of paths at each commit, not
once based on the current index (i.e., it would fail to match paths that
were removed or changed modes).

This is kind of a subtle and esoteric point, but it makes me more
convinced that having powerful pathspec selectors is potentially useful.
Or at least solving a problem that's hard to otherwise solve correctly. :)

-Peff
