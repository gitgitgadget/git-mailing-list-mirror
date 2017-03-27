Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 865B91FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 22:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbdC0WLO (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 18:11:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:52598 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbdC0WLO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 18:11:14 -0400
Received: (qmail 15045 invoked by uid 109); 27 Mar 2017 22:04:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Mar 2017 22:04:32 +0000
Received: (qmail 2695 invoked by uid 111); 27 Mar 2017 22:04:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Mar 2017 18:04:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Mar 2017 18:04:29 -0400
Date:   Mon, 27 Mar 2017 18:04:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] blame: output porcelain "previous" header for each
 file
Message-ID: <20170327220429.dsfp5ytq2yddfn33@sigill.intra.peff.net>
References: <20170106041541.rjzzofal5hscv6yi@sigill.intra.peff.net>
 <20170106042051.nwjiuyyp7ljhs4sr@sigill.intra.peff.net>
 <CACBZZX5AnG=hpnZCG3qFkLOO0gbgvt79ZYP3-oG5VjE8p284cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX5AnG=hpnZCG3qFkLOO0gbgvt79ZYP3-oG5VjE8p284cQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 27, 2017 at 11:08:08PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Fri, Jan 6, 2017 at 5:20 AM, Jeff King <peff@peff.net> wrote:
> 
> > +for output in porcelain line-porcelain
> > +do
> > +       test_expect_success "generate --$output output" '
> > +               git blame --root -C --$output combined >output
> > +       '
> > +
> 
> The --root option isn't needed here, the tests pass if it's removed.
> 
> Discovered while looking at the sorry state of our blame test suite
> vis-a-vis tests for config, no tests for blame.showroot &
> blame.blankboundary.
> 
> I'll submit that eventually, but meanwhile did you mean to omit --root
> here, or is the test broken in some other way and it /should/ need
> --root but doesn't?

I don't think it's strictly needed, though I think it's worth keeping.

The test is making sure that some lines blame to HEAD and some to HEAD^.
But the latter is a root commit, and so it just becomes a boundary
commit without --root.

You can see the difference if you interrupt the test here and run:

  git blame -C [--root] combined

And that's what I was doing when I developed the test case. If you were
to test the non-porcelain output, you'd need to it (to match the real
sha-1 X, and not the boundary "^X").

When the porcelain outputs are used, though, the boundary commits are
shown as full sha1s, and just get annotated with a "boundary" line. As
the tests just look for subject, filename, and previous lines, they
don't notice whether the boundary marker is there or not. And so --root
could technically go away.

We care mostly about detecting the values for the second commit, so I
don't think it actually matters. But if we wanted to be thorough, we
could confirm that the "boundary" lines are as we expect (or
alternatively, we could add an uninteresting base commit at the bottom
to make the second one non-root).

-Peff
