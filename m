Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D28CC3DA7A
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 13:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjAFNKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 08:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjAFNKO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 08:10:14 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C393745A5
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 05:10:12 -0800 (PST)
Received: (qmail 14564 invoked by uid 109); 6 Jan 2023 13:10:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Jan 2023 13:10:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14464 invoked by uid 111); 6 Jan 2023 13:10:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Jan 2023 08:10:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Jan 2023 08:10:11 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carl Baldwin <carl@ecbaldwin.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] diff: use filespec path to set up tempfiles for
 ext-diff
Message-ID: <Y7gdsxNT2TM/5M17@coredump.intra.peff.net>
References: <Y7f/YiVu1TgbucDI@coredump.intra.peff.net>
 <Y7gAHenwmIo4gXTb@coredump.intra.peff.net>
 <xmqqbknbsu9y.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbknbsu9y.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 06, 2023 at 09:48:57PM +0900, Junio C Hamano wrote:

> > The breakage seems to go all the way back to cd676a5136 (diff
> > --relative: output paths as relative to the current subdirectory,
> > 2008-02-12).
> 
> Not surprising.  When I wrote all the rest of "diff", I didn't
> plan to do "--relative" ;-)

:) Commit cd676a5136 mentions that "diff --relative" does not interact
well with "--no-index", and that was one of the things I tested while
poking (to make sure I did not make anything worse). And indeed, it
seems that --relative is mostly ignored there. We could follow through
on the plan from the end of the commit message to forbid combining the
two, but it may not be that important given how long it has been an
issue (and that I think people may set diff.relative in their config
these days).

> Thanks for a clear description.  The fix looks trivially obvious and
> correct.
> [...]
> > -	struct diff_tempfile *temp = prepare_temp_file(r, name, df);
> > +	struct diff_tempfile *temp = prepare_temp_file(r, df->path, df);

One nagging concern I had is whether "df->path" might ever point to
something unexpected (or even be NULL). The fact that textconv
unconditionally passes it made me feel a lot better. But I also ended up
walking back to the source of the "name" and "other" fields, which is
this code in run_diff():

	name  = one->path;
	other = (strcmp(name, two->path) ? two->path : NULL);
	attr_path = name;
	if (o->prefix_length)
		strip_prefix(o->prefix_length, &name, &other);

So those values really are just aliases for one->path and two->path,
modulo the prefix stripping (which as you might guess, came from
cd676a5136 itself). And using them directly instead of the stripped
versions is definitely the right thing to do.

-Peff
