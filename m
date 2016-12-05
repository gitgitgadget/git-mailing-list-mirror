Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98DFC1FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 06:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbcLEG7G (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 01:59:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:51566 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbcLEG60 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 01:58:26 -0500
Received: (qmail 31125 invoked by uid 109); 5 Dec 2016 06:58:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 06:58:25 +0000
Received: (qmail 2158 invoked by uid 111); 5 Dec 2016 06:59:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 01:59:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2016 01:58:23 -0500
Date:   Mon, 5 Dec 2016 01:58:23 -0500
From:   Jeff King <peff@peff.net>
To:     Jack Bates <bk874k@nottheoilrig.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jack Bates <jack@nottheoilrig.com>
Subject: Re: [PATCH v2] diff: handle --no-abbrev outside of repository
Message-ID: <20161205065823.c7qw6xtc2hqk3xgu@sigill.intra.peff.net>
References: <20161129070637.eult6o3m34r2mima@sigill.intra.peff.net>
 <20161202184840.2158-1-jack@nottheoilrig.com>
 <20161205060116.szy5ojetg3znu4w7@sigill.intra.peff.net>
 <20161205061500.dinyc3juedkpw6o3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161205061500.dinyc3juedkpw6o3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2016 at 01:15:00AM -0500, Jeff King wrote:

> On Mon, Dec 05, 2016 at 01:01:16AM -0500, Jeff King wrote:
> 
> >   Note that setting abbrev to "0" outside of a repository was broken
> >   recently by 4f03666ac (diff: handle sha1 abbreviations outside of
> >   repository, 2016-10-20). It adds a special out-of-repo code path for
> >   handling abbreviations which behaves differently than find_unique_abbrev()
> >   by truly giving a zero-length sha1, rather than taking "0" to mean "do
> >   not abbreviate".
> > 
> >   That bug was not triggerable until now, because there was no way to
> >   set the value to zero (using --abbrev=0 silently bumps it to the
> >   MINIMUM_ABBREV).
> 
> Actually, I take this last paragraph back. You _can_ trigger the bug
> with just:
> 
>   echo one >foo
>   echo two >bar
>   git diff --no-index --raw foo bar
> 
> which prints only "..." for each entry.
> 
> I didn't notice it before because without "--raw", we show the patch
> format. That uses the --full-index option, and does not respect --abbrev
> at all (which seems kind of bizarre, but has been that way forever).
> 
> So I think there _is_ a regression in v2.11, and the second half of your
> change fixes it.

Sorry for the sequence of emails, but as usual with "diff --no-index",
the deeper I dig the more confusion I find. :)

After digging into your related thread in:

  http://public-inbox.org/git/20161205065523.yspqt34p3dp5g5fk@sigill.intra.peff.net/

I'm not convinced that "--no-index --raw" output isn't generally
nonsensical in the first place. So yes, there's a regression there (and
it's not just "oops, we didn't abbreviate correctly", but rather that
the output format is broken). But I'm not sure it's something people are
using. So it should be fixed on the 'maint' track, but I don't think
it's incredibly urgent.

-Peff
