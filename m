Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C201F661
	for <e@80x24.org>; Wed, 12 Jul 2017 20:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbdGLUnL (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 16:43:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:38432 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751974AbdGLUnK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 16:43:10 -0400
Received: (qmail 9441 invoked by uid 109); 12 Jul 2017 20:43:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 20:43:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27123 invoked by uid 111); 12 Jul 2017 20:43:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 16:43:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jul 2017 16:43:08 -0400
Date:   Wed, 12 Jul 2017 16:43:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git gc --auto aquires *.lock files that make a subsequent
 git-fetch error out
Message-ID: <20170712204308.2emzv5y3rndflmpg@sigill.intra.peff.net>
References: <20130126224038.GA20849@sigill.intra.peff.net>
 <87bmopzbqx.fsf@gmail.com>
 <20170712200054.mxcabiyttijpbkbb@sigill.intra.peff.net>
 <87a849z9cu.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a849z9cu.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 10:30:25PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Is it really "in a row" that's a problem? The second fetch should not
> > begin until the first one is done, including until its auto-gc exits.
> > And even with background gc, we do the ref-locking operations first, due
> > to 62aad1849 (gc --auto: do not lock refs in the background,
> > 2014-05-25).
> >
> >> I happen to run into this on a git.git which has a lot of remotes (most
> >> people on-list whose remotes I know about) and fetch them in parallel:
> >>
> >>     $ git config alias.pfetch
> >>     !parallel 'git fetch {}' ::: $(git remote)
> >
> > Ah, so it's not in a row. It's parallel. Then yes, you may run into
> > problems with the gc locks conflicting with real operations. This isn't
> > really unique to fetch. Any simultaneous operation can run into problems
> > (e.g., on a busy server repo you may see conflicts between pack-refs and
> > regular pushes).
> 
> This is what I thought at first, and I've only encountered the issue in
> this parallel mode (mainly because it's tedious to reproduce). But I
> think the traces below show that it would happen with "git fetch --all"
> & "git remote update" as well, so the parallel invocations didn't
> matter.
> 
> I.e. I'd just update my first remote, then git-gc would start in the
> background and lock refs for my other remotes, which I'd then fail to
> update.

No, it should be OK because of the commit I mentioned at the top of the
quoted section. Each one runs sequentially.

-Peff
