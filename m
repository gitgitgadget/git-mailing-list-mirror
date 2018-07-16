Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FE051F597
	for <e@80x24.org>; Mon, 16 Jul 2018 20:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeGPU6U (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 16:58:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:48384 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728290AbeGPU6T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 16:58:19 -0400
Received: (qmail 13990 invoked by uid 109); 16 Jul 2018 20:29:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 20:29:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15225 invoked by uid 111); 16 Jul 2018 20:29:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 16:29:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 16:29:16 -0400
Date:   Mon, 16 Jul 2018 16:29:16 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716202915.GC25189@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716175103.GB18636@sigill.intra.peff.net>
 <20180716182207.GA11513@aiede.svl.corp.google.com>
 <20180716185255.GC22298@sigill.intra.peff.net>
 <20180716190949.GB11513@aiede.svl.corp.google.com>
 <20180716194136.GA25189@sigill.intra.peff.net>
 <20180716195431.GD11513@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180716195431.GD11513@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 12:54:31PM -0700, Jonathan Nieder wrote:

> Even restricting attention to the warning, not the exit code, I think
> you are saying the current behavior is acceptable.  I do not believe
> it is.

I didn't say that at all. The current situation sucks, and I think the
right solution is to pack the unreachable objects instead of exploding
them.

> I think you are saying Jonathan's patch makes the behavior
> worse, and I'm not seeing it.  Can you describe an example user
> interaction where the current behavior would be better than the
> behavior after Jonathan's patch?  That might help make this discussion
> more concrete.

It makes it worse because there is nothing to throttle a "gc --auto"
that is making no progress.

Try this:

-- >8 --
#!/bin/sh

rm -rf repo

# new mostly-empty repo
git init repo
cd repo
git commit --allow-empty -m base

# make a bunch of unreachable blobs
for i in $(seq 7000); do
  echo "blob"
  echo "data <<EOD"
  echo "cruft $i"
  echo "EOD"
done |
git fast-import

# This gc will explode them (doing a "gc --auto" isn't sufficient here, because
# we don't have enough _other_ material in the repo to trigger a gc. But you
# can imagine that a normal repo would eventually "gc --auto".
git gc

# Now simulate some real work in the repo.
for i in $(seq 50); do
  git commit --allow-empty -m "commit $i"
  sleep 30
done
-- 8< --

With the current code, that produces a bunch of annoying warnings for
every commit ("I couldn't gc because the last gc reported a warning").
But after Jonathan's patch, every single commit will do a full gc of the
repository. In this tiny repository that's relatively quick, but in a
real repo it's a ton of CPU and I/O, all for nothing.

> [...]
> > See the thread I linked earlier on putting unreachable objects into a
> > pack, which I think is the real solution.
> 
> Have you looked over the discussion in "Loose objects and unreachable
> objects" in Documentation/technical/hash-function-transition.txt?  Do
> you have thoughts on it (preferrably in a separate thread)?

It seems to propose putting the unreachable objects into a pack. Which
yes, I absolutely agree with (as I thought I'd been saying in every
single email in this thread).

> > I mean that if you do not write a persistent log, then "gc --auto" will
> > do an unproductive gc every time it is invoked. I.e., it will see "oh,
> > there are too many loose objects", and then waste a bunch of CPU every
> > time you commit.
> 
> If so, then this would already be the behavior in non daemon mode.
> Are you saying this accidental effect of daemon mode is in fact
> intentional?

I'm not sure if I'd call it intentional, since I don't recall ever
seeing this side effect discussed. But since daemonizing is the default,
I think that's the case people have focused on when they hit annoying
cases. E.g., a831c06a2b (gc: ignore old gc.log files, 2017-02-10).

I'd consider the fact that "gc --auto" with gc.autoDetach=false will
repeatedly do useless work to be a minor bug. But I think Jonathan's
patch makes it even worse because we do not even tell people that
useless work is being done (while making them wait for each gc to
finish!). Even if we were going to remove this message to help the
daemonized case, I think we'd want to retain it for the non-daemon case.

> > A daemonized git-gc runs a bunch of sub-commands (e.g., "git prune")
> > with their stderr redirected into the logfile. If you want to have
> > warnings go somewhere else, then either:
> >
> >   - you need some way to tell those sub-commands to send the warnings
> >     elsewhere (i.e., _not_ stderr)
> >
> >     or
> >
> >   - you have to post-process the output they send to separate warnings
> >     from other errors. Right now that means scraping. If you are
> >     proposing a system of machine-readable output, it would need to work
> >     not just for git-gc, but for every sub-command it runs.
> 
>       or
> 
>     - you can simply record and trust the exit code
> 
> A simple way to do that without changing formats is to truncate the
> file when exiting with status 0.

That's a different behavior than what we do now (and what was suggested
earlier), in that it assumes that anything written to stderr is OK for
gc to hide from the user if the process exits with code zero.

That's probably OK in most cases, though I wonder if there are corner
cases. For example, if you have a corrupt ref, we used to say "error:
refs/heads/foo does not point to a valid object!" but otherwise ignore
it. These days git-gc sets REF_PARANOIA=1, so we'll actually barf on a
corrupt ref. But I wonder if there are other cases lurking.

-Peff
