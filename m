Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2659EC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E9061352
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhELAp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 20:45:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:51620 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhELAp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 20:45:27 -0400
Received: (qmail 25227 invoked by uid 109); 12 May 2021 00:44:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 May 2021 00:44:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30663 invoked by uid 111); 12 May 2021 00:44:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 20:44:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 20:44:19 -0400
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Andrew Ottaviano <andrew_o1995@live.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Rebase Question
Message-ID: <YJsk49WBd27NrCAA@coredump.intra.peff.net>
References: <MN2PR07MB59526F40B255183931649AD19C529@MN2PR07MB5952.namprd07.prod.outlook.com>
 <CAGyf7-GEA0mtxUxqEjYsfqM4Te-5JO5_nW0S6Vitdmywz1J7mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGyf7-GEA0mtxUxqEjYsfqM4Te-5JO5_nW0S6Vitdmywz1J7mg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 05:29:03PM -0700, Bryan Turner wrote:

> On Tue, May 11, 2021 at 5:07 PM Andrew Ottaviano <andrew_o1995@live.com> wrote:
> >
> > Hello all!
> >
> > I’ve used git for a few years now and I
> > think it is an amazing tool! Thank you for your hard work in
> > developing/maintaining it! I really appreciate it!
> >
> > I have a question. Let’s say that my
> > colleague and I branch off of master and are working. Let’s say I’m 5 commits
> > ahead of master and my colleague merges in ahead of me. The logical thing in my
> > mind is to rebase off of master. The difficulty with this is that if I have
> > merge conflicts that show up on my first commit, I have to resolve that stupid
> > thing for every subsequent commit. I could squash, but then I loose branch
> > history, so I don’t really want to do that. I could rebase in interactive mode,
> > but if I recall, I still need to resolve all the conflicts on every commit
> > before it squashes.
> 
> Have you investigated git rerere[1] at all? Documentation indicates it
> works for rebase as well as merge, so it might be possible to train
> that to resolve the conflicts.

I don't think rerere helps here. In a rebase like this, the problem is
that it _isn't_ the same conflict.

Imagine a case like this:

-- >8 --
git init repo
cd repo

# both branches start with just the line "base"
echo base >file
git add file
git commit -m base

# one side adds a new line
git checkout -b newline
echo another >>file
git commit -am 'add a line'

# and the other modifies the first line
git checkout -b other HEAD^
echo one >file
git commit -am one
echo two >file
git commit -am two

# and now we rebase on top of the newline branch
git rebase newline
-- >8 --

Applying the first commit gets this conflict (in diff3 form)

  <<<<<<< ours
  base
  another
  ||||||| base
  base
  =======
  one
  >>>>>>> theirs

After we fix that up to "one\nanother", the second conflict is:

  <<<<<<< ours
  one
  another
  ||||||| base
  one
  =======
  two
  >>>>>>> theirs

Likewise, even if you had done the original merge between branch tips,
you'd have seen yet another conflict:

  <<<<<<< ours
  two
  ||||||| base
  base
  =======
  base
  another
  >>>>>>> theirs

The actual lines changed are the same, but as the nearby context is
continually shifting, we don't consider these to be the "same" conflict.

-Peff
