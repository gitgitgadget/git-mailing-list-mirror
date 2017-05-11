Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F086E201A0
	for <e@80x24.org>; Thu, 11 May 2017 23:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756398AbdEKXgr (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 19:36:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:49979 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756021AbdEKXgq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 19:36:46 -0400
Received: (qmail 28623 invoked by uid 109); 11 May 2017 23:36:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 23:36:43 +0000
Received: (qmail 19936 invoked by uid 111); 11 May 2017 23:37:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 19:37:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 19:36:41 -0400
Date:   Thu, 11 May 2017 19:36:41 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Best "triangle" workflow setup?
Message-ID: <20170511233640.ylf4to3hotngh6xe@sigill.intra.peff.net>
References: <CAHd499DjBHsWCf8h+i4EstR7qs-9hkO4En5-B-WA17DoPZQNoQ@mail.gmail.com>
 <20170511201707.aobrdiompzg6wu5k@sigill.intra.peff.net>
 <CAHd499AvDRH-KZ7piOE=QsVXSpMt0u5jVXUC=7UPnRVLYo-U5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499AvDRH-KZ7piOE=QsVXSpMt0u5jVXUC=7UPnRVLYo-U5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 04:23:03PM -0500, Robert Dailey wrote:

> On Thu, May 11, 2017 at 3:17 PM, Jeff King <peff@peff.net> wrote:
> > I think you want:
> >
> >   [push]
> >   default = current
> >   [remote]
> >   pushDefault = myfork
> >
> > to make "git push" do what you want. And then generally have branches
> > mark their counterparts on "origin" (which you can do either at creation
> > time, or probably by using "git push -u origin my-topic" when you push
> > them).
> 
> So without the `pushDefault` setting, `current` will default to a
> remote named `origin` if there is no tracking branch set, correct? So
> `pushDefault` is effectively overriding this built-in default? In
> addition, it seems like since this overrides `branch.name.remote`,
> that this effectively makes the remote tracking branch *only* for
> `pull`. Is this a correct understanding?

Right. The general idea of a triangular workflow is that where you pull
from is not the same as where you push to. We have branch.*.pushremote
if you really wanted to do it on a per-branch basis, but in my
experience you almost always want to use "myfork", because you can't
push to "origin" in the first place. :)

> > This is similar to what I do for my git.git workflow, though I usually
> > have origin/master as the branch's upstream. I.e., I'd create them with:
> >
> >   git checkout -b my-topic origin
> 
> I'm looking through the `git checkout` and `git branch` documentation,
> but I don't see any mention of it being valid to use a remote name as
> the <start-point> parameter (you're using `origin` in the above
> example). Am I misunderstanding? Did you mean origin/my-topic?

Using "origin" there will resolve to "origin/HEAD", i.e., origin/master.
So basically I am saying that all of my topic branches are based on
master, and if I were to rebase them (for example), I'd want to rebase
the whole thing.

If I were to "git pull", they'd also pull from master, which may or may
not be what you want (though with pull.rebase, perhaps). I don't
generally use "git pull" at all for my git.git workflow.

> > And then rebasing always happens on top of master (because "origin"
> > doesn't even have my topic branch at all). If I want to compare with
> > what I've pushed to my fork, I'd use "@{push}".
> 
> Can you explain more about how your rebase chooses master instead of
> your same-named remote tracking branch? Maybe provide some examples of
> your rebase command and respective configuration (unless what you've
> already provided is sufficient). As for @{push}, I haven't used this
> before, so I'll dig in the docs and learn about it.

The default for "git rebase" (if you don't specify a base) is the
configured upstream, which in my case is origin/master. Most of my
rebasing is "rebase -i" to rewrite bits, so it automatically picks all
the commits on my topic branch.

Maybe it would help to set up a trivial example:

  # just a helper to make dummy commits
  commit() { echo "$1" >"$1" && git add "$1" && git commit -m "$1"; }

  # some parent repo
  git init parent
  (cd parent && commit one)

  # and imagine you have a public fork, too
  git clone --bare parent myfork.git

  # and then you have your local clone; in real life this is obviously
  # the only one that would actually be on your machine, but this is a
  # toy example
  git clone parent local
  cd local

  # set up our triangular config
  git remote add myfork ../myfork.git
  git config remote.pushdefault myfork
  git config push.default current

  # now let's try a topic branch
  git checkout -b topic origin
  commit two
  commit three

  # config will show our topic based on origin/master:
  #  [branch "topic"]
  #	remote = origin
  #	merge = refs/heads/master
  less .git/config

  # this should default to all the commits in our topic (i.e., two, three)
  git rebase -i

  # let's imagine upstream makes more commits on master. We can "pull
  # --rebase" to put our work on top
  (cd ../parent && commit four)
  git pull --rebase

  # pushes go to the matching branch on myfork
  git push

  # if you want to see what you haven't pushed yet, you can use @{push}
  commit five
  git log @{push}..

  # likewise, if you wanted to rebase only commits that you've been
  # working on since your last push:
  git rebase -i @{push}

  # Now imagine "origin" picks up your branch...
  (cd ../parent && git fetch ../myfork.git topic:topic)

  # Depending on your project's workflow, you may want to consider that
  # the new base for further development (and never rebase or rewrite
  # any commits that origin has). You do that by re-pointing your
  # @{upstream} config.
  git fetch
  git branch --set-upstream-to=origin/topic topic

  # now a "rebase -i" would show only the commits origin doesn't have
  # (five and six in this case)
  commit six
  git rebase -i


Hopefully that shows off some of the ways you can use the upstream and
push config in practice.  Some people may not be as excited about the
"rebase" default as I am. I spend quite a lot of time at the end of a
series sifting through the commits via "rebase -i" and polishing them
up. I also test with "git rebase -x 'make test'".

-Peff
