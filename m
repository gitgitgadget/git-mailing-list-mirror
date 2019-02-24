Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11EF520248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfBXKKb (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:10:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:55966 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725956AbfBXKKb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:10:31 -0500
Received: (qmail 27817 invoked by uid 109); 24 Feb 2019 10:10:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 24 Feb 2019 10:10:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9456 invoked by uid 111); 24 Feb 2019 10:10:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 24 Feb 2019 05:10:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Feb 2019 05:10:29 -0500
Date:   Sun, 24 Feb 2019 05:10:29 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        John Keeping <john@keeping.me.uk>,
        Pratik Karki <predatoramigo@gmail.com>
Subject: Re: [PATCH 2/2] rebase: don't rebase linear topology with
 --fork-point
Message-ID: <20190224101029.GA13438@sigill.intra.peff.net>
References: <20190221151009.GA24309@sigill.intra.peff.net>
 <20190221214059.9195-3-avarab@gmail.com>
 <20190222150852.GB5090@sigill.intra.peff.net>
 <871s3z6a4q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871s3z6a4q.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 05:49:57PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Yes. I didn't dig far enough into this and will re-word & re-submit,
> also with the feedback you had on 1/2.
> 
> So here's my current understanding of this.
> 
> It's b6266dc88b ("rebase--am: use --cherry-pick instead of
> --ignore-if-in-upstream", 2014-07-15) that broke this in the general
> case.
> 
> I.e. if you set a tracking branch within the same repo (which I'd
> betnobody does) but *also* if you have an established clone you have a
> reflog for the upstream. Then we'll find the fork point, and we'll
> always redundantly rebase.
> 
> But this hung on by a thread until your 4f21454b55 ("merge-base: handle
> --fork-point without reflog", 2016-10-12). In particular when you:
> 
>  1. Clone some *new* repo
>  2. commit on top
>  3. git pull --rebase
> 
> You'll redundantly rebase on top, even though you have nothing to
> do. Since there's no reflog.
> 
> This is why I ran into this most of the time, because my "patch some
> random thing" is that, and I have pull.rebase=true in my config.
> 
> What had me confused about this being the primary cause was that when
> trying to test this I was re-cloning, so I'd always get this empty
> reflog case.

OK, thanks, that all makes sense to me and matches what I'm seeing. I
think we're on the same page now.

> > Your fix looks plausibly correct to me, but I admit I don't quite grok
> > all the details of that conditional.
> 
> We just consider whether we can fast-forward now, and then don't need to
> rebase (unless "git rebase -i" etc.). I.e. that --fork-point was
> considered for "do we need to do stuff" was a bug introduced in
> b6266dc88b.

Right, that makes sense. But I'm just not clear on the new oidcmp() rule
that's put in place.

When we're not using fork point, in the old code we'd check whether
upstream and onto are the same. Which makes sense; if we're rebuilding
onto the same spot, then it's a noop.

And in the fork-point case, we'd instead want to do something similar
with restrict_revision. But you compare upstream and restrict_revision,
and my understanding is that with --fork-point the latter basically
replaces the former.  Shouldn't we be comparing restrict_revision and
onto?

E.g., if I do:

  git checkout -b foo origin
  echo content >file && git add file && git commit -m foo
  git rebase --onto origin^ --fork-point origin

we should do an actual rebase, but with your patch we get "Current
branch foo is up to date". Whereas dropping --fork-point, it works.

-Peff
