Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 449E11F597
	for <e@80x24.org>; Sat, 28 Jul 2018 09:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbeG1Kuf (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 06:50:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:34010 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728213AbeG1Kuf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 06:50:35 -0400
Received: (qmail 9493 invoked by uid 109); 28 Jul 2018 09:24:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 28 Jul 2018 09:24:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2003 invoked by uid 111); 28 Jul 2018 09:24:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 28 Jul 2018 05:24:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jul 2018 05:24:43 -0400
Date:   Sat, 28 Jul 2018 05:24:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 1/4] automatically ban strcpy()
Message-ID: <20180728092443.GB16454@sigill.intra.peff.net>
References: <20180724092329.GA24250@sigill.intra.peff.net>
 <20180724092618.GA3288@sigill.intra.peff.net>
 <CAPig+cRpcUOA5+k7v3Gy3WsLohedEb=j-a_fCGc3g0ktDfsDVA@mail.gmail.com>
 <20180726065840.GA27349@sigill.intra.peff.net>
 <20180726072105.GA6057@sigill.intra.peff.net>
 <xmqqfu05rjfc.fsf@gitster-ct.c.googlers.com>
 <20180727080807.GA11932@sigill.intra.peff.net>
 <xmqq8t5woa5f.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8t5woa5f.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 10:34:20AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >>  $ git rebase --onto HEAD @{-1}~3 @{-1}^0
> >
> > Interesting. I'd have probably done it with an interactive rebase:
> >
> >   $ git rebase -i HEAD~4
> >   [change first "pick" to "edit"; after stopping...]
> >   $ git reset --hard HEAD^ ;# throw away patch 1
> >   $ git am -s mbox         ;# apply single patch
> >   $ git rebase --continue
> >
> > Which is really the same thing,...
> 
> I have unfounded fear for doing anything other than "edit", "commit
> --amend", "rebase --continue", or "rebase --abort" during a "rebase
> -i" session.  
> 
> Especiallly "reset --hard" with anything but HEAD.  I guess that is
> because I do not fully trust/understand how the sequencer machinery
> replays the remainder of todo tasks on top of the HEAD that is
> different from what it left me to futz with when it relinquished the
> control.

I jump around via "reset --hard" all the time during interactive
rebases. I don't recall having any issues, though that does not mean
there isn't a corner case lurking. :)

> Also "am" during "rebase -i" is scary to me, as "am" also tries to
> keep its own sequencing state.  Do you know if "rebase --continue"
> would work correctly in the above sequence if "am" conflicted, I
> gave up, and said "am --abort", for example?  I don't offhand know.

This one is trickier. I _assumed_ it would be fine to "am" during a
rebase, but I didn't actually try it (in fact, I rarely do anything
exotic with "am", since my main use is just test-applying patches on a
detached head).

It _seems_ to work with this example:

-- >8 --
git init repo
cd repo

for i in 1 2 3 4; do
  echo $i >file
  git add file
  git commit -m $i
done
git format-patch --stdout -1 >patch

git reset --hard HEAD^
GIT_EDITOR='perl -i -pe "/2$/ and s/pick/edit/"' git rebase -i HEAD~2
git am patch
git am --abort
-- 8< --

I think because "am" lives in $GIT_DIR/rebase-apply, and "rebase -i"
lives in ".git/rebase-merge". Of course "rebase" can use the
rebase-apply directory, but I think interactive-rebase never will.

So it works, but mostly by luck. :)

In my ideal world, operations like this that can be continued would be
stored in a stack, and each stack element would know its operation type.
So you could do:

  # push a rebase onto the stack
  git rebase foo

  # while stopped, you might do another operation which pushes onto the
  # stack
  git am ~/patch

  # aborting an operation (or finishing it naturally) pops it off the
  # stack; now we just have the rebase on the stack
  git am --abort

  # aborting an operation that's not at the top of the stack would
  # either be an error, or could auto-abort everybody on top
  git am ~/patch
  git rebase --abort ;# aborts the am, too!

  # you could even nest similar operations; by default we find the
  # top-most one in the stack, but you could refer to them by stack
  # position.
  #
  # put us in a rebase that stops at a conflict
  git rebase foo
  # oops, rewrite the last few commits as part of fixing the conflict
  git rebase -i HEAD~3
  # nope, let's abort the whole thing (stack level 0)
  git rebase --abort=0

  # it would also be nice to have generic commands to manipulate the
  # stack
  git op list ;# show the stack
  git op abort ;# abort the top operation, whatever it is
  git op continue ;# continue the top operation, whatever it is

I've hacked something similar to "git op continue" myself and find it
very useful, but:

  - it's intimately aware of all the possible operations, including some
    custom ones that I have. I wouldn't need to if each operation
    touched a well-known directory to push itself on the stack, and
    provided a few commands in the stack directory for things like "run
    this to abort me".

  - it sometimes behaves weirdly, because I "canceled" an operation with
    "reset" or "checkout", and later I expect to continue operation X,
    but find that some other operation Y was waiting. Having a stack
    means it's much easier to see which operations are still hanging
    around (we have this already with the prompt logic that shows things
    like rebases, but again, it has to be intimate with which operations
    are storing data in $GIT_DIR)

Anyway. That's something I've dreamed about for a while, but the thought
of retro-fitting the existing multi-command operations turned me off.
The current systems _usually_ works.

-Peff
