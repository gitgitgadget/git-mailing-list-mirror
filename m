Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258CAC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 04:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D7F610A0
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 04:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhIUEnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 00:43:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:51458 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhIUEne (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 00:43:34 -0400
Received: (qmail 3498 invoked by uid 109); 21 Sep 2021 04:42:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 04:42:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28252 invoked by uid 111); 21 Sep 2021 04:42:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Sep 2021 00:42:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Sep 2021 00:42:05 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH 2/5] grep: stop modifying buffer in show_line()
Message-ID: <YUlinQ7hPokFLgfm@coredump.intra.peff.net>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
 <YUlV+RPMHGGfk25d@coredump.intra.peff.net>
 <YUleFU4QrKb28bDz@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUleFU4QrKb28bDz@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 12:22:45AM -0400, Taylor Blau wrote:

> On Mon, Sep 20, 2021 at 11:48:09PM -0400, Jeff King wrote:
> > When showing lines via grep (or looking for funcnames), we call
> > show_line() on a multi-line buffer. It finds the end of line and marks
> > it with a NUL. However, we don't need to do so, as the resulting line is
> > only used along with its "eol" marker:
> >
> >  - we pass both to next_match(), which takes care to look at only the
> >    bytes we specified
> 
> Thinking aloud, next_match() calls match_next_pattern() which takes eol
> as non-const and passes it to match_one_pattern(). And that calls
> strip_timestamp(), which would be non-const, were it not the previous
> patch. So I think this conversion is safe.

To be a little nit-picky: this move would be OK even without the change
to strip_timestamp(). The question is whether any of those sub-calls
actually looks past the "eol" pointer we give it.

I didn't dig all the way down through the complete call-stack in an
exhaustive way. But after having looked at the related functions when
changing their const-ness elsewhere in the series, they'd have to be
ignoring the "eol" parameter for it to be a problem. The irony, of
course, is that they did ignore this parameter at one point! Because
they'd all eventually end in regexec(), which would happily read past
our "eol".

So really, all of this is predicated on those sub-functions behaving
sensibly. I think they do. But if we found that they didn't, I'd much
rather know that and fix them than live with this "this NUL may or may
not be important" state forever.

> >  - we pass the line to output_color() without its matching eol marker.
> >    However, we do use the "match" struct we got from next_match() to
> >    tell it how many bytes to look at (which can never exceed the string
> >    we passed it
> 
> Yep, makes sense. The patch looks good and matches your description
> here.

Thanks for looking it over (my nitpick aside). :)

-Peff
