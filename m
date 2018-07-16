Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E42E1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbeGPViv (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:38:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:48492 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728300AbeGPViv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:38:51 -0400
Received: (qmail 15872 invoked by uid 109); 16 Jul 2018 21:09:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 21:09:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15682 invoked by uid 111); 16 Jul 2018 21:09:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 17:09:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 17:09:38 -0400
Date:   Mon, 16 Jul 2018 17:09:38 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716210938.GF25189@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716175103.GB18636@sigill.intra.peff.net>
 <20180716182207.GA11513@aiede.svl.corp.google.com>
 <20180716185255.GC22298@sigill.intra.peff.net>
 <20180716190949.GB11513@aiede.svl.corp.google.com>
 <20180716194136.GA25189@sigill.intra.peff.net>
 <20180716195431.GD11513@aiede.svl.corp.google.com>
 <20180716202915.GC25189@sigill.intra.peff.net>
 <20180716203753.GE11513@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180716203753.GE11513@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 01:37:53PM -0700, Jonathan Nieder wrote:

> >                                                        and I think the
> > right solution is to pack the unreachable objects instead of exploding
> > them.
> 
> That seems like a huge widening in scope relative to what this
> original patch tackled.

I'm not at all saying that Jonathan needs to work on that. It's a big
topic that we've been putting off for years. I _am_ saying that I don't
think his patch as-is should be merged, as it makes the daemonized
behavior here worse.

> I'm not aware of a way to do this without
> breaking compatibility with the current (broken) race prevention.  If
> you're saying that breaking compatibility in that way is okay with
> you, then great!

It depends what you're trying to fix. If you're trying to fix auto-gc
outputting an annoying message (or repeatedly doing useless invocations
of pack-objects), you don't have to break compatibility at all. You just
have to put the objects into a pack instead of exploding them loose.
Worst case if you use an old implementation to run "git gc", it may
accidentally freshen a cruft pack's timestamp.

If you want to improve the raciness, then yes, I think you need stronger
rules around marking packs as cruft/garbage, and making operations that
want to use those objects copy them out to a non-cruft location (like
you describe in the hash transition document). There you risk corruption
if an old implementation fails to make the non-cruft copy. But that's
really no worse than we are today.

So I don't even really see it as a backwards-compatibility break. But
even if it were, I'd probably still be fine with it. This is a
local-repo thing, and in the absolute worst case we could bump
core.repositoryformatversion (though again, I don't even think that
would be necessary since it would degrade to behaving just as the
current code does).

> > With the current code, that produces a bunch of annoying warnings for
> > every commit ("I couldn't gc because the last gc reported a warning").
> > But after Jonathan's patch, every single commit will do a full gc of the
> > repository. In this tiny repository that's relatively quick, but in a
> > real repo it's a ton of CPU and I/O, all for nothing.
> 
> I see.  Do I understand correctly that if we find a way to print the
> warning but not error out, that would be good enough for you?

Yes. I thought that's what I proposed originally. ;)

The key thing is that the presence of the warning/log still suppress
the actual gc for the gc.logExpiry period.

> >> Have you looked over the discussion in "Loose objects and unreachable
> >> objects" in Documentation/technical/hash-function-transition.txt?  Do
> >> you have thoughts on it (preferrably in a separate thread)?
> >
> > It seems to propose putting the unreachable objects into a pack. Which
> > yes, I absolutely agree with (as I thought I'd been saying in every
> > single email in this thread).
> 
> I figured you were proposing something like
> https://public-inbox.org/git/20180113100734.GA30698@sigill.intra.peff.net/,
> which is still racy (because it does not handle the freshening in a safe
> way).

That message is just me telling somebody that their idea _won't_ work. ;)

But I assume you mean the general idea of putting things in a cruft
pack[1]. Yes, I was only suggesting going that far as a solution to the
auto-gc woes. Solving races is another issue entirely (though obviously
it may make sense to build on the single-pack work, if it exists).

[1] The best message discussion on that is I think:

      https://public-inbox.org/git/20170610080626.sjujpmgkli4muh7h@sigill.intra.peff.net/

    which I think I linked earlier, so possibly that is even what you
    meant. :)

> What decides it for me is that the user did not invoke "git gc --auto"
> explicitly, so anything "git gc --auto" prints is tangential to what
> the user was trying to do.  If the gc failed, that is worth telling
> them, but if e.g. it encountered a disk I/O error reading and
> succeeded on retry (to make up a fake example), then that's likely
> worth logging to syslog but it's not something the user asked to be
> directly informed about.

I'm not sure I agree. If a repack discovered that you had a bit
corruption on disk, but you happened to have another copy of the object
available that made the repack succeed, I'd like to know that I'm
getting bit corruptions, and earlier is better. I think we need to
surface that information to the user eventually, and I don't think we
can count on syslog being universally available.

By definition we're daemonized here, so we can't count on even having
access to the user's terminal. But it would make more sense to me if the
logic were:

  - at the end of a "gc --auto" run, gc should write a machine-readable
    indication of its exit code (either as a final line in the log file,
    or to a gc.exitcode file). The warnings/errors remain intermingled
    in the logfile.

  - on the _next_ run, if:

    - the exit code was non-zero, dump the log output to stderr and exit
      with the same code. This is the same as the current behavior (with
      the exception that we propagate the code instead of returning -1,
      which is a minor bonus).

    - the exit code was zero, report to the user synchronously that the
      last run found some oddities, and dump the log. Proceed with the
      rest of auto-gc (either exiting 0 if nothing to be done, or doing
      useful work).

      Optionally, delete the log after showing it so the user is not
      spammed with the warning on every commit. Though for the warning
      under discussion, this does mean that if they don't take any
      action, they'll end up running a useless gc every _other_ commit.
      So I'd probably keep the log and let it expire naturally after the
      1-day gc.logExpiry period.

-Peff
