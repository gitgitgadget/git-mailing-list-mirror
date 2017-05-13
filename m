Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B94B201A7
	for <e@80x24.org>; Sat, 13 May 2017 03:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbdEMDYU (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 23:24:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:50631 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750734AbdEMDYT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 23:24:19 -0400
Received: (qmail 6254 invoked by uid 109); 13 May 2017 03:24:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 03:24:17 +0000
Received: (qmail 29017 invoked by uid 111); 13 May 2017 03:24:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 23:24:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 23:24:14 -0400
Date:   Fri, 12 May 2017 23:24:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Josh Hagins <hagins.josh@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/3] BUG() and "config --local" outside of repo
Message-ID: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net>
References: <CANuW5x0pBwfQeha50mxN8pVQKm67u_b3UKTCQ8ZbJA6FUGvYbw@mail.gmail.com>
 <20170512203436.fcoqauphzvox2sgv@sigill.intra.peff.net>
 <CACBZZX5rasExB9jN0RmZ9zcSTbc9qOEZ2VoqRFt8C09vW9mkfQ@mail.gmail.com>
 <20170513020346.25ijajgtwffh7g4b@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170513020346.25ijajgtwffh7g4b@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 10:03:46PM -0400, Jeff King wrote:

> On Sat, May 13, 2017 at 12:31:31AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > > +       if (use_local_config && nongit)
> > > +               die(_("--local only be used inside a git repository"));
> > > +
> > 
> > It would be better to have a test for edge cases that are currently
> > only being discovered by users in the wild.
> 
> I actually started on one earlier, but what would it check? We already
> die() in this case. Should we be grepping for the message? It seems more
> likely to me that we would change the message and cause a false positive
> than that there would be an actual regression.
> 
> What I think might be more interesting is if die("BUG") could learn to
> exit with some error code that the test suite considered invalid. Like
> calling abort(), which would kill us with SIGABRT and cause
> test_must_fail to complain.
> 
> On many systems that would also generate a coredump. Which is handy
> sometimes, but I wonder if it would be inconvenient for others. I guess
> that is no different than what a raised assert() would do.
> 
> But if we were to do that, then the test could easily demonstrate that
> we expect a clean die().

So here's a series which does that (and fixes the gramm-o that Jonathan
pointed out). The SIGABRT/coredump thing may seem like overkill, but
it's actually something I've found useful before (while developing this
very same setup_git_env assertion, in fact).

  [1/3]: usage.c: add BUG() function
  [2/3]: setup_git_env: convert die("BUG") to BUG()
  [3/3]: config: complain about --local outside of a git repo

 builtin/config.c       |  3 +++
 environment.c          |  2 +-
 git-compat-util.h      |  9 +++++++++
 t/t1300-repo-config.sh |  6 ++++++
 usage.c                | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 51 insertions(+), 1 deletion(-)
