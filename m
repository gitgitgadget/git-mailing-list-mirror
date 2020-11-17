Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1596C56202
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 23:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EAD52417E
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 23:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKQXdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 18:33:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:33118 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgKQXdP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 18:33:15 -0500
Received: (qmail 19321 invoked by uid 109); 17 Nov 2020 23:33:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Nov 2020 23:33:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5542 invoked by uid 111); 17 Nov 2020 23:33:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Nov 2020 18:33:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Nov 2020 18:33:13 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/28] Use main as default branch name
Message-ID: <20201117233313.GB642410@coredump.intra.peff.net>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org>
 <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 04:47:56PM -0600, Felipe Contreras wrote:

> On Tue, Nov 17, 2020 at 3:10 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > This is the big one. This changes the default of init.defaultBranch to main,
> > > reflecting what many open source projects already did (which was followed by
> > > GitHub, Azure Repos and others).
> >
> > Can we please not simply replace one hard coded branch name with
> > another?
> 
> I thought precisely the same thing.
> 
> This should be easy to do if we make "origin" be a pseudo ref that
> points to "origin/HEAD" (and we could introduce "origin/@").

Didn't we already do this long ago? refs/remotes/%s/HEAD is special in
the dwim_ref() lookup:

  $ git rev-parse --symbolic-full-name origin
  refs/remotes/origin/master

Or did you have something else in mind?

I think I have occasionally hit spots where saying "origin" instead of
"origin/master" does not work. I can't think of any offhand now, though
(I thought perhaps "git checkout -b foo origin" or "git branch
--set-upstream-to=origin", but both seem to work).

> > I don't look in on the git list very often so perhaps I am missing a
> > conversation where all of the details were thought through.  If so
> > please point me at that conversation.  Otherwise can we please use this
> > opportunity to come up with something that is actually better than
> > naming the default branch main, rather than just something just as
> > awkward whose only advantage is that people don't think it is
> > politically incorrect this week.
> 
> This is the thread:
> 
> https://lore.kernel.org/git/CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com/
> 
> Unfortunately in my opinion the most important topics--like your
> suggestion--were not even mentioned. Everyone focused on the wrong
> thing (e.g. what would be a better name for "master").

There is another thread from the same time that contains quite a lot of
discussion on logistics. This subthread in particular raises the notion
of "let's try to minimize needing a special branch-name at all":

  https://lore.kernel.org/git/875zbrcpgh.fsf@evledraar.gmail.com/

And indeed, it led to some other bug-fixes in improvements in the time
since then:

  - submodule--helper was fixed to use HEAD from the remote as its
    fallback rather than a hard-coded "master"

  - fast-export --anonymize no longer treats "master" as special, but
    instead grew a flexible system for leaving some bits intact

  - fmt-merge-msg gained new options for configuring when it will print
    "into <branch>"

So really all that is left is deciding what to do when:

  git init
  git commit -m foo

is run. Obviously we added a config variable here, but we still fall
back to a hard-coded name. One suggestion was to not use any name, and
either require "git checkout -b some-branch" first, or commit onto a
detached HEAD:

  https://lore.kernel.org/git/B4814F42-7AF8-4D80-93D4-FAF752C72F21@me.com/

The simplicity has some appeal to me, but it's even less
backwards-compatible than falling back to a new different name.

I think Eric's suggestion of using the directory name as a default was
not previously mentioned. I'm not sure I would like that myself (I find
value in having a consistent "this is the main branch" name across
different repositories, at least for my workflows). And it creates all
of the same "every tutorial is now out of date" issues. But it is
neutral. I wouldn't be opposed to seeing it as a configurable option.

-Peff
