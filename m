Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B73162047F
	for <e@80x24.org>; Wed, 26 Jul 2017 13:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750982AbdGZNXZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 09:23:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:49444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750921AbdGZNXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 09:23:25 -0400
Received: (qmail 29239 invoked by uid 109); 26 Jul 2017 13:23:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Jul 2017 13:23:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25860 invoked by uid 111); 26 Jul 2017 13:23:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Jul 2017 09:23:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jul 2017 09:23:23 -0400
Date:   Wed, 26 Jul 2017 09:23:23 -0400
From:   Jeff King <peff@peff.net>
To:     Stas Sergeev <stsp@list.ru>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: git gc seems to break --symbolic-full-name
Message-ID: <20170726132322.4cfj73tynrko264o@sigill.intra.peff.net>
References: <234492d7-7fd6-f847-8b85-010732ff43b6@list.ru>
 <xmqqbmodhb5h.fsf@gitster.mtv.corp.google.com>
 <223fa7c7-196d-e4fe-85b5-7d7cc576aa52@list.ru>
 <CA+P7+xrhLf9eS_KkxTmWZgQ+Ho8VN83GS-OvxmboZ=_iY4dY0g@mail.gmail.com>
 <ed1ddfec-5782-d14b-6717-a1532efc0138@list.ru>
 <CA+P7+xock9gpYVtxj2n6L5Y9dO1VV01OEOT5i0MR7ay68yS+WQ@mail.gmail.com>
 <a6738cae-ad8d-cf51-0fbb-428cf0f88703@list.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6738cae-ad8d-cf51-0fbb-428cf0f88703@list.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 26, 2017 at 11:40:46AM +0300, Stas Sergeev wrote:

> 26.07.2017 03:36, Jacob Keller пишет:
> > If your goal is to make it so users filling out bug reports have a
> > version, then using git descrsibe and making that be part of your
> > version (based off your tags, and commits) is how pretty much every
> > other project I've worked on does this.
> > 
> > I really don't think that's your goal here, given you're doing things
> > in make with timestamps and builds, so I guess I misunderstood your
> > answer?
> There are 2 different things:
> 1. put git describe output into some header file
> 2. make things to rebuild with every new commit
> 
> So I actually stuck at solving 2, because 1 is trivial.
> My original solution for 2 was to "depend" on
> refs/heads/*. This worked besides git gc, but had
> a lot of troubles with worktrees. And this time I
> switched to the "touch tmpfile" trick with the date
> taken from git log. This requires .LOW_RESOLUTION_TIME
> in makefile, so probably not the best solution again,
> but should hopefully be more future-proof than the
> previous one.

In git.git we do something like:

-- >8 --
other: version
	cat $< >$@

.PHONY: FORCE
version: FORCE
	@git rev-parse HEAD >$@+
	@if cmp $@+ $@ >/dev/null 2>&1; then rm $@+; else mv $@+ $@; fi
-- >8 --

The "version" commands run always, but they only update the file if
there's a change. At least GNU make is smart enough to know that if
"version" was not updated, then "other" does not need to be re-built.
I don't know if all makes would so, though.

-Peff
