Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBF3C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 17:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0621B61184
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 17:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbhKIRar (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 12:30:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:56026 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234677AbhKIRaq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 12:30:46 -0500
Received: (qmail 24639 invoked by uid 109); 9 Nov 2021 17:28:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Nov 2021 17:28:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3614 invoked by uid 111); 9 Nov 2021 17:28:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Nov 2021 12:28:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Nov 2021 12:27:59 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-jump: pass "merge" arguments to ls-files
Message-ID: <YYqvn1JeZlQbxlJl@coredump.intra.peff.net>
References: <YYqjY/zcBWyqY8/5@coredump.intra.peff.net>
 <YYql4uR39putmHP7@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YYql4uR39putmHP7@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 09, 2021 at 11:46:26AM -0500, Taylor Blau wrote:

> On Tue, Nov 09, 2021 at 11:35:47AM -0500, Jeff King wrote:
> > We currently throw away any arguments given to "git jump merge". We
> > should instead pass them along to ls-files, since they're likely to be
> > pathspecs. This matches the behavior of "git jump diff", etc.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > Just a little wart I noticed while doing a really tricky merge today.
> 
> This is hilarious to me, because I wrote the exact same patch to skip
> some conflicts while resolving what I can only assume is the same merge.

It's possible. :)

> >  mode_merge() {
> > -	git ls-files -u |
> > +	git ls-files -u "$@" |
> 
> It's kind of unfortunate (maybe not?) that a caller could now run:
> 
>     git jump merge --no-unmerged
> 
> and get the same results albeit *much* slower. We could limit ourselves
> to only accepting pathspecs (by writing `git ls-files -u -- "$@"`), but
> that feels overly restrictive. We could also say `"$@" -u`, but that
> breaks if the caller writes `--` or `--end-of-options`.

Yeah. With "git jump diff" and "git jump grep", it's an explicit feature
that we allow extra arguments. That's less likely here, though you could
perhaps do something clever with --recurse-submodules, etc. And while
you could royally screw things up with "--no-unmerged", I think this is
a case of "if it hurts, don't do it".

> Anyway, I know that it's late in the -rc cycle, but I'd be happy to see
> something like this get picked up once Junio tags 2.34 and we have
> stabilized a little bit.

Yeah, obviously no rush at all on this.

-Peff
