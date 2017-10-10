Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16C2E2036B
	for <e@80x24.org>; Tue, 10 Oct 2017 14:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756375AbdJJOBV (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 10:01:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:48354 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756372AbdJJOBU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 10:01:20 -0400
Received: (qmail 13180 invoked by uid 109); 10 Oct 2017 14:01:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 14:01:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26591 invoked by uid 111); 10 Oct 2017 14:01:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 10:01:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Oct 2017 10:01:18 -0400
Date:   Tue, 10 Oct 2017 10:01:18 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Kevin Daudt <me@ikke.info>, Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC] column: show auto columns when pager is active
Message-ID: <20171010140118.quyesljvz44wvfx6@sigill.intra.peff.net>
References: <20171009214543.12986-1-me@ikke.info>
 <CAN0heSoWTpVZXmJkoEQtc_rjFj3PdPWV_37B9LukxxsYy5ox1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSoWTpVZXmJkoEQtc_rjFj3PdPWV_37B9LukxxsYy5ox1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 12:30:49PM +0200, Martin Ågren wrote:

> On 9 October 2017 at 23:45, Kevin Daudt <me@ikke.info> wrote:
> > When columns are set to automatic for git tag and the output is
> > paginated by git, the output is a single column instead of multiple
> > columns.
> >
> > Standard behaviour in git is to honor auto values when the pager is
> > active, which happens for example with commands like git log showing
> > colors when being paged.
> >
> > Since ff1e72483 (tag: change default of `pager.tag` to "on",
> > 2017-08-02), the pager has been enabled by default, exposing this
> > problem to more people.
> 
> Oh. :( I didn't know about "column" to be honest.

Yeah, I didn't think of that with respect to the pager. This is a
regression in v2.14.2, I think.

I agree that anything that is "auto" on stdout probably ought to kick in
when the pager is in effect (since that only kicks in when stdout _was_
a tty before we stuck a pager in front of it).

> I had slightly more success with PAGER="cat >actual", but the test is
> flaky for some reason.

The test in t9002 should be immune to this, but the one you suggest in
t7006 would need to set COLUMNS to get consistent output, I think.

> In any case, it might make sense to test an
> actual use-case also. Of course, the code should be largely the same,
> but in builtin/tag.c, it's quite important that `setup_auto_pager()`
> and `finalize_colopts()` are called in the right order.

I think it might work out either way. If we have started the pager when
we finalize_colopts(), then the pager_in_use() bit will kick in. If we
haven't, then either:

  1. stdout is a tty, and we'll kick in the auto behavior for columns,
     and then later for the pager.

  2. stdout isn't a tty, in which case we also won't kick in the pager.

-Peff
