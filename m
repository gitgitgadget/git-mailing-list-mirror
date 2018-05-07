Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31FB1F42E
	for <e@80x24.org>; Mon,  7 May 2018 07:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeEGHsq (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 03:48:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:58472 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751042AbeEGHsp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 03:48:45 -0400
Received: (qmail 30491 invoked by uid 109); 7 May 2018 07:48:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 May 2018 07:48:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24463 invoked by uid 111); 7 May 2018 07:48:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 May 2018 03:48:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2018 03:48:43 -0400
Date:   Mon, 7 May 2018 03:48:43 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
Message-ID: <20180507074843.GC31170@sigill.intra.peff.net>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet>
 <CAPig+cS0pvdg78fGUu8m2xspDDMHxi=uAMCkbLuthy7R4p3fQw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805062155120.77@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1805062155120.77@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 06, 2018 at 10:04:31PM -0400, Johannes Schindelin wrote:

> > Let's, please, not fall into the trap of polluting git-branch with
> > utterly unrelated functionality, as has happened a few times with
> > other Git commands. Let's especially not do so merely for the sake of
> > tab-completion. git-branch is for branch management; it's not for
> > diff'ing.
> 
> I totally disagree. `git branch` is *the* command to work with branches.
> Yes, you can manage branches. But you can also list them. And now you can
> also compare them.

One of the things I don't like about "git branch --diff" is that this
feature is not _just_ about branches at all. E.g., I could do:

  git tbdiff HEAD~10 HEAD~5 foo

Or even:

  git tbdiff v2.16.0 v2.17.0 my-rewritten-v2.17.0

Those arguments really are just commitishes, not necessarily branches.
One of the current interface rules for "git branch" is that the branch
names we hand it are interpreted _exactly_ as branch names. You cannot
"git branch -m v2.16.0", and there is no ambiguity in "git branch -d
foo" if "foo" is both a tag and a branch.

But this new mode does not fit the pattern at all.

If we were to attach this to an existing command, I think it has more to
do with "diff" than "branch". But I'm not sure we want to overload
"diff" either (which has traditionally been about two endpoints, and
does not really traverse at all, though arguably "foo...bar" is a bit of
a cheat :) ).

> > Of the suggestions thus far, Junio's git-topic-diff seems the least
> > worse, and doesn't suffer from tab-completion problems.
> 
> Except that this is too limited a view.

Right, I agree with you. Topic branches are the intended use, but that's
not what it _does_, and obviously it can be applied in other cases. So
since "branch" is too specific, I think "topic branch" is even more so.

It's really "diff-history" or something, I think. That's not very
catchy, but I think the best name would imply that it was diffing a set
of commits (so even "diff-commit" would not be right, because that again
sounds like endpoints).

-Peff
