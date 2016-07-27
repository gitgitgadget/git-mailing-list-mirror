Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F82A203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 18:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757900AbcG0SR3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 14:17:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:49990 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757850AbcG0SR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 14:17:29 -0400
Received: (qmail 1195 invoked by uid 102); 27 Jul 2016 18:17:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 14:17:29 -0400
Received: (qmail 19160 invoked by uid 107); 27 Jul 2016 18:17:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 14:17:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 14:17:26 -0400
Date:	Wed, 27 Jul 2016 14:17:26 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Phil Pennock <phil@pennock-tech.com>,
	Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pretty format string support for reflog times
Message-ID: <20160727181725.GD32219@sigill.intra.peff.net>
References: <20160727081414.GA21451@breadbox>
 <20160727135820.GC14928@sigill.intra.peff.net>
 <xmqqwpk7vw30.fsf@gitster.mtv.corp.google.com>
 <20160727173915.GA32219@sigill.intra.peff.net>
 <xmqqfuqvvtph.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuqvvtph.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 11:09:30AM -0700, Junio C Hamano wrote:

> I am still in favor of this suggestion you earlier made:
> 
> > So the final solution is more like:
> > 
> >   - a formatter for just the reflog time, respecting date
> > 
> >   - a formatter for just the reflog index (the "0" in HEAD@{0})
> > 
> >   - a formatter for the ref name (just the "HEAD" in HEAD@{0})
> 
> though.  After all we only need three short ones while we migrate
> away to a longer %(reflog:<what>) format, right?

Yes, I think those three would be sufficient to allow something like:

  HEAD@{0} (1 month ago) ...

where the relative time would come from "%gT" mixed with
"--date=relative". What that doesn't allow is showing the time in
multiple formats with different placeholders, like:

  HEAD@{0} (2016-06-25T01:23:45 -- 1 month ago) ...

For that you need either format-specific placeholders, or a generic date
placeholder which can specify the format, like:

  %(reflog-date:relative)

So if you mean doing those on _top_ of what Phil and Ted are proposing,
I think it is pretty flexible, but just a bit ugly. But doing it
_instead_ would not allow the format Ted wanted.

> As to the unfortunate %gd that squats on the "date" other specifiers
> use, I do not see a good/quick approach to migrate it.  If our ideal
> short-term endgame before the longer format were to use %gd, %g# and
> %gg for the above three, we first start warning people who use %gd
> for the historical mistaken "reflog selector", while telling people
> to use "%gg@{%g#}" instead if they truly want "reflog selector", and
> then switch its meaning to "reflog date".  That would take a long
> time.

I don't think it's worth the deprecation effort and confusion.

> As %r prefix is not taken, we can immediately deprecate %g-anything
> format as a historical mistake and make sure we do not repeat the
> mistake of giving "d" to "reflog selector", perhaps?

Moving to "%r" as a more sensible prefix for "reflog", while cleaning up
historical mistakes, is more appealing. But if we really are planning to
move to "%(reflog-*)", then I think we can just forget about "%r"
entirely.

I just don't think anybody has volunteered to work on %(reflog).

-Peff
