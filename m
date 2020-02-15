Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF2EC352A4
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 07:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA1E2082F
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 07:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgBOHA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 02:00:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:44162 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725799AbgBOHAz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 02:00:55 -0500
Received: (qmail 25713 invoked by uid 109); 15 Feb 2020 07:00:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 15 Feb 2020 07:00:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26835 invoked by uid 111); 15 Feb 2020 07:09:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 Feb 2020 02:09:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 15 Feb 2020 02:00:54 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/15] t5310: factor out bitmap traversal comparison
Message-ID: <20200215070054.GD1633703@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182225.GH150965@coredump.intra.peff.net>
 <20200215021446.GA16515@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200215021446.GA16515@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 06:14:46PM -0800, Taylor Blau wrote:

> > This is a bit fragile, as not all outputs will differ (e.g., looking at
> > only the commits from a fully-bitmapped pack will end up exactly the
> > same as the normal traversal order, since it also matches the pack
> > order). So we'll provide an escape hatch by which tests can disable this
> > check (which should only be used after manually confirming that bitmaps
> > kicked in).
> 
> Thanks for pointing out the rationale behind this.

I didn't write it this way at first, but the need became quite apparent
when I ran the test from the next patch. :)

I waffled on whether the extra option made the helper too convoluted to
be worthwhile.  Another way to do it would be two separate functions:

  test_for_bitmap_output expect actual &&
  test_bitmap_output_matches expect actual

but as you can see I couldn't come up with good names.

I doubt it matters all that much either way, as long as the docstring is
clear.

> > +test_bitmap_traversal () {
> > +	if test "$1" = "--no-confirm-bitmaps"
> > +	then
> > +		shift
> > +	elif cmp "$1" "$2"
> 
> Any reason to prefer 'cmp' here and then use 'test_cmp' below? I can't
> think of a good reason one way or another, especially in places where
> GIT_TEST_CMP is just 'cmp', but I think the two usages should be
> consistent with one another.

On most platforms GIT_TEST_CMP is "diff -u" (it's only on platforms with
a crappy system diff tool that we replace it with "cmp"). So I thought
it would be confusing for it to dump a diff in the expected case (since
unlike a normal test_cmp, we want the outputs to differ).  "cmp" does
still write a short message to stderr; I thought about redirecting it to
/dev/null, but worried that would make debugging verbose output harder).

> If there *is* a favorable argument for 'test_cmp' (instead of a bare
> 'cmp'), I think that it'd be that the original code a couple of hunks up
> uses it.

Right, but it uses to check that two things are equal (which we also use
it for here).

-Peff
