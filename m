Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C1D120D12
	for <e@80x24.org>; Thu,  1 Jun 2017 05:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbdFAFfl (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 01:35:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:32930 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbdFAFfk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 01:35:40 -0400
Received: (qmail 17543 invoked by uid 109); 1 Jun 2017 05:35:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Jun 2017 05:35:37 +0000
Received: (qmail 14360 invoked by uid 111); 1 Jun 2017 05:36:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Jun 2017 01:36:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jun 2017 01:35:36 -0400
Date:   Thu, 1 Jun 2017 01:35:36 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t0012: test "-h" with builtins
Message-ID: <20170601053536.zflna2bzclhvbeso@sigill.intra.peff.net>
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
 <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
 <xmqqwp8yc255.fsf@gitster.mtv.corp.google.com>
 <20170530060555.ponbsyp4agdo4yau@sigill.intra.peff.net>
 <xmqqshjmc1wm.fsf@gitster.mtv.corp.google.com>
 <20170530061546.tdpuhvq7yk34rvlj@sigill.intra.peff.net>
 <xmqqo9uabhqt.fsf@gitster.mtv.corp.google.com>
 <20170530152756.vs777v6unaxg6otb@sigill.intra.peff.net>
 <xmqqinkg734c.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqinkg734c.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 01, 2017 at 01:17:55PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Anyway, the problem is sk/dash-is-previous, specifically fc5684b47
> > (revision.c: args starting with "-" might be a revision, 2017-02-25). It
> > looks like the revision parser used to just bail on "-h", because
> > revision.c would say "I don't recognize this" and then cmd_rev_list()
> > would similarly say "I don't recognize this" and call usage(). But now
> > we actually try to read it as a ref, which obviously requires being
> > inside a repository.
> 
> Heh, I found another ;-)  
> 
> 95e98cd9 ("revision.c: use refs_for_each*() instead of
> for_each_*_submodule()", 2017-04-19), which is in the middle of
> Duy's nd/prune-in-worktree series, does this:

Hrm, yeah. The problem is that handle_revision_pseudo_opt() initializes
the ref store at the top of the function, even if we don't see any
arguments that require us to use it (and obviously in the "-h" case, we
don't).

That's an implementation detail that we could fix, but I do think in
general that we should probably just declare it forbidden to call
setup_revisions() when the repo hasn't been discovered.

> I guess anything that calls setup_revisions() from the "git cmd -h"
> bypass need to be prepared with that
> 
>   check_help_option(argc, argv, usage, options);
> 
> thing.  Which is a bit sad, but I tend to agree with you that
> restructuring to make usage[] of everybody available to git.c
> is probably too noisy for the benefit it would give us.

The other options are:

  - reverting the "-h" magic in git.c. It really is the source of most
    of this confusion, I think, because functions which assume RUN_SETUP
    are having that assumption broken. But at the same time I do think
    it makes "-h" a lot friendlier, and I'd prefer to keep it.

  - reverting the BUG() in setup_git_env(); this has been flushing out a
    lot of bugs, and I think is worth keeping

I did look at writing something like check_help_option(). One of the
annoyances is that we have two different usage formats: one that's a
straight string for usage(), and one that's an array-of-strings for
parse_options(). We could probably unify those.

It doesn't actually save that much code, though. The real value is that
it abstracts the "did git.c decide to skip RUN_SETUP?" logic.

-Peff
