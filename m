Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7650C433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3542074B
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgG3A3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:29:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:42134 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbgG3A3p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 20:29:45 -0400
Received: (qmail 10837 invoked by uid 109); 30 Jul 2020 00:29:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Jul 2020 00:29:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13119 invoked by uid 111); 30 Jul 2020 00:29:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 20:29:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 20:29:44 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
Message-ID: <20200730002944.GB2996059@coredump.intra.peff.net>
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com>
 <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
 <20200729205846.GA2992025@coredump.intra.peff.net>
 <CAHk-=wg7r=y_tYpWuRwNFP0JU5D4g=UN1puCzkvQP4bey0-Hmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg7r=y_tYpWuRwNFP0JU5D4g=UN1puCzkvQP4bey0-Hmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 02:20:07PM -0700, Linus Torvalds wrote:

> I use that prepare-commit-msg hook to do that.
> 
> I *could* have done that for branch names too, but that is something
> that git has done right for the last 15+ years, so I never had to
> worry or think about it.

Yeah, I think that "just use a hook" is not the right response here.
Hooks are great for making hard or uncommon things possible, but we
should still be making easy things easy. If tweaking this part of the
merge msg in a standard way is something many people want to do, it's
much friendlier for us to provide a config option that does that.

> But a generic replacement (or generation) machinery for the whole line
> would be lovely. And then perhaps just _default_ that regex to be the
> equivalent of
> 
>    sed 's/ into master$//'
> 
> would work really well not just for the branch name prettification,
> but also for things like that "internal vs external hostnames".

This is an interesting middle ground. I'm a little iffy on it just
because it complicates the very simple case of "should I mention the
destination branch", which is what I'd expect most people to care about.
That it also solves your "tweak the source branch" problem is
interesting, but I'm not sure how many people will care (i.e., enough to
justify the extra complication).

> >   2. Optionally a repository created with "git init" could copy its
> >      init.defaultBranch into merge.suppressDest. And likewise a clone
> >      might copy the remote HEAD into that variable. I'm not sure if that
> >      is worth doing or not, but it would restore the original behavior
> >      for the most part.
> 
> Well, the real objection I have to that commit 489947cee5 is that it
> breaks existing users workflow.

I'm not entirely onboard with the characterization of "breaking
workflows". Yes, the result is _different_, but it's mostly a matter of
aesthetics. I'd be more convinced it was a breakage if we were somehow
leaking information about the workflows. E.g., if you merge on a
detached HEAD and then fast-forward your branch to match and you get an
ugly "into HEAD", that might be bad. But nothing changed there (we do
give you the ugly "into HEAD" ;) ). The case that changed is conveying
the same information as before, just more verbosely (by saying the
branch name instead of implying it by omission).

It may be a matter of perspective / opinion, though. And I don't know
that we even need to come to an agreement on it. Whether we treat it as
a feature to suppress the mention of the destination branch, or a
bug-fix to correct a regression, the end result is the same (and to be
clear, I'm on board with doing it in a way that defaults to handling
"master", which is a key part of those two things being equivalent).

-Peff
