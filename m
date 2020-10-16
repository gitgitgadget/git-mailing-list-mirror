Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D362C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2971920878
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393605AbgJPUZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:25:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:34822 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393591AbgJPUZV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 16:25:21 -0400
Received: (qmail 31702 invoked by uid 109); 16 Oct 2020 20:25:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Oct 2020 20:25:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12567 invoked by uid 111); 16 Oct 2020 20:25:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Oct 2020 16:25:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Oct 2020 16:25:20 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] fast-import: fix over-allocation of marks storage
Message-ID: <20201016202520.GB3356073@coredump.intra.peff.net>
References: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
 <20201015012636.GA387901@coredump.intra.peff.net>
 <72a4d4d8dff95351122bd192976dd6b1@sebres.de>
 <20201015153849.GA551964@coredump.intra.peff.net>
 <xmqqzh4nfldw.fsf@gitster.c.googlers.com>
 <xmqqv9fbfl68.fsf@gitster.c.googlers.com>
 <f3e4f7ccc36dc214201c1838acce4aff@sebres.de>
 <xmqqo8l3fibz.fsf@gitster.c.googlers.com>
 <20201015190532.GB1108210@coredump.intra.peff.net>
 <20201016031834.GE490427@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201016031834.GE490427@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 16, 2020 at 03:18:34AM +0000, brian m. carlson wrote:

> > Personally I make a branch for almost every patch/series I submit, no
> > matter how trivial[1]. And then part of my daily ritual is seeing which
> > ones have been merged, and dropping them. You can use git-cherry for
> > that, though it's not 100% perfect (sometimes patches are munged as they
> > are applied). I use a combination of that and aggressively rebasing
> > patches forward (and eventually they rebase down into nothing when
> > they've been fully merged).
> 
> I'm really terrible at deleting data, so I have (exactly) 256 branches
> in my local repository.  Some of them are merged, and some are not.
> This would be a viable approach if I were better about deleting old
> series (and completing and sending in the prototypes I've built), or if
> I sent in series that were smaller so rebasing them were not so big of a
> time commitment.

That's pretty good. I only have about 80. :)

I hesitate to point anybody at my mass of it-works-for-me scripts for
fear of making their lives worse, but certainly you (or anybody) is
welcome to adopt them if you want to do the aggressive-rebase thing. You
can see them at:

  https://github.com/peff/git/tree/meta

I generally do:

  git clone --single-branch -b meta https://github.com/peff/git Meta

in my git.git checkout. And then:

  Meta/merged

shows what has been merged to master or next. Running:

  Meta/rebase

will try to rebase everything on its upstream (I almost always point
branch upstreams to origin/master, though the script also handles the
case that branch X's upstream is a local branch Y). That catches cases
where the patch-ids changed enough that git-cherry can't recognize them.

Ideally that shrinks merged series down to nothing through a combination
of automatic and manual skipping.  Of course that will often yield
conflicts if later already-merged patches in the series touched the same
lines of code. You can either "git rebase --skip" past such commits, or
if you realize the whole giant series is merged, just "rebase --abort"
and delete the branch manually.

Perhaps either those scripts or at least the techniques within them
might help with your cleanup.

Sort-of orthogonal, I also use:

  Meta/private

to create a branch "private" that is a merge of all of my topics on top
of next (minus ones that have "-wip" in the name). That's what I use for
my daily-driver version of Git.

That actually helps somewhat with the rebase process because rerere
learns about conflicts early during this step, and then later the rebase
can reuse the results. It's not perfect though (it merges in
alphabetical order, but the order in which topics graduate might be
different, meaning we see a conflict in reverse order. Junio's Meta
scripts take a specific order from a topics file; but he has the luxury
of knowing that the same topics file is what will be used to actually
graduate the topics for real).

Anyway. I hope that might perhaps help a little, but don't feel
compelled to jump down the rabbit hole if you're happy with your own
workflows. ;)

-Peff
