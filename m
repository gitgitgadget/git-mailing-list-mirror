From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Introducing different handling for small/large transactions
Date: Thu, 15 Jan 2015 18:53:10 -0500
Message-ID: <20150115235310.GA25120@peff.net>
References: <1421361371-30221-1-git-send-email-sbeller@google.com>
 <20150115224605.GD19021@peff.net>
 <CAGZ79kbXYm66StsAwHFdTovkYeDVHWV2PdCK0abVXwWiD7sAAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 00:53:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBuE6-0002yL-Ro
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 00:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbbAOXxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 18:53:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:35295 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752290AbbAOXxN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 18:53:13 -0500
Received: (qmail 9097 invoked by uid 102); 15 Jan 2015 23:53:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 17:53:13 -0600
Received: (qmail 18440 invoked by uid 107); 15 Jan 2015 23:53:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 18:53:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 18:53:10 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kbXYm66StsAwHFdTovkYeDVHWV2PdCK0abVXwWiD7sAAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262525>

On Thu, Jan 15, 2015 at 03:24:15PM -0800, Stefan Beller wrote:

> I see the performance problem as well as the contention problem
> you're pointing out. Dealing with loose refs however creates other
> problems such as directory/file conflicts on renaming. I am trying to
> think of a way which moves most of the failures to the transaction_update
> phase, such that the transaction_commit is rather easy and not expected
> to produce many errors.
> 
> So I think dealing with a generic large transaction cannot be really solved
> outside the packed refs file. There could be another special case for mass
> deleting refs however. Or retries for the packed refs file. Or we first check if
> we *really* need to lock the packed refs file (just realized we
> already do that :/)

It sounds like there are certain _types_ of transactions that trigger
problems (and that we can handle better). E.g., renames. Which must
involve a deletion. And we already have to touch the packed-refs file
for a deletion. Once we know that we must do that, we might as well
write the rest of the ref updates into it for "free", right? There is no
extra lock contention (there is contention, but we are not making it
worse than what is already there, and what is necessary for the on-disk
format).

Could the rule be something like:

  if there are deletions in the transaction
    /* to handle potential D/F conflicts */
    update_type = packed
  else if # of transactions / # of packed-refs entries > 0.8
    /*
     * for performance, we are better off just writing the whole file;
     * extra lock contention probably doesn't matter because a
     * simultaneous write would probably conflict with one of our
     * refs anyway.
     */
     update_type = packed
  else
    /*
     * small-ish ref update. Just write out the loose refs.
     */
    update_type = loose

I'm not sure I'm completely comfortable with all of the "probably"'s in
the second comment, though.

> May I ask on which kinds of repository you can see packed-refs.lock contention?

I'm not sure what you mean by "kinds" (i.e., how you want me to
characterize our repos). Busy ones, certainly. :) And this is all
server-side, where the main write operations are client pushes and
running "git gc". And of course mainly ones that are shared between many
users (so many users pushing to a central repo, not each one forking and
making pull requests from their own publishing points).

Some people do a lot of deletions. E.g., they may be constantly pushing
and deleting tags from a CI process that kicks off whenever a "real"
push happens.

A lot of our contention is from the pack-refs process itself. It has to
take a lock on each of the loose refs it prunes. It's smart enough
(since 06839515, anyway) to avoid complaining when a real writer is
holding the lock. But when the race goes the other way, the "real"
writer has no idea that the process holding the lock is "weak". That is,
if it were another push, we would not want to block and wait to acquire
the lock. We would only find out then that the sha1 had moved, and we
have to abort the operation. But for a weak writer like packed-refs, the
ref value is not changing at all, and we could probably succeed if we
retried the lock after a delay.

> I want to improve git atomicity, specially for 'weird' cases as presented in my
> previous mail[1]. Eventually I even want to have cross repository atomicty in
> git, so an example could be:
> (
>     cd API-Provider &&
>     edit files # new changes breaking the API
>     git commit -a -m "..."
> ) &&
> (
>     cd API-consumer
>     edit files # use new and shiny API
>     git commit -a -m "..."
> ) &&
> git multipush --atomic API-Provider:origin:master API-consumer:origin:master

I think that's a reasonable goal, but I am not sure what packed-refs has
to do with it. The client sees only the push interface. So you need:

  1. Atomic push to each remote (which I think you have already
     implemented).

  2. Some kind of 2-phase commit on each remote. To say "take the lock,
     tell me when you have it, but _don't_ update until I ask you to".
     And then when you have confirmation from all remotes, send each one
     the instruction to commit the update.

     Of course that isn't foolproof if the commit step fails (lost
     connection, write error on disk, etc), but it's basically what you
     want (and this kind of commit is well-studied in the literature).

The actions that the remote takes to do (1) are not important, and
either way it needs to take all of the locks for each ref. Using
packed-refs here is just a quality of implementation issue (there are
some transactions we can take as a single atomic change that we
otherwise would not be able to).

Coincidentally, we are looking at something similar at GitHub to (2) for
doing repository replication (where you'd want to make sure that each of
your replicas moves in lockstep). It hasn't been written yet, but we
imagined that the result would be way too gross and too GitHub-specific
to make it into the upstream protocol. But maybe not.

> When having such a goal a reliable and easy to use ref transaction API makes
> life lots more easier. By reliable I mean that there are no sudden problems
> as pointed out in [1], these kinds of rejections make users unhappy. And by
> easy to use I mean there are only a few functions I need to know and no
> proliferation of functions exposed in the API. Internally we can do all we want
> such as special cases for delete-only transactions.

Yeah, I agree with this. But I have a nagging feeling as we deal with
these problems that the right solution is some better ref-store than the
filesystem + packed-refs. It's a great, simple solution, but the scaling
and transactional considerations are really making it not-simple. These
are solved problems in the database world. Moving onto a ready-made
solution has its own problems, and I do not think we would ever
deprecate the filesystem + packed-refs storage format. It works very
well for client repositories, and has no dependencies. But it would be
nice if there was a pluggable option for busy shared server repos.

> As another unrelated thought (400,000 refs is quite a lot)
> Would it make sense to have packed-refs files grouped by topic directory, i.e.
> one packed-ref for
>     topic/1
>     topic/2
>     topic/*
> and another packed ref for
>     feature/a
>     feature/b
>     feature/*
> 
> This would rather help your problems with contention instead of making things
> more atomic though. But that would avoid 400,000 refs in one packed refs file,
> which then may still be easier to handle for larger transactions.

Certainly the thought has occurred to me (and others at GitHub). But if
we are going to break compatibility, I think I'd rather see us move onto
a more mature data-storage backend than invent something even more
complicated (and that does not really solve the problem, just makes them
less bad).

-Peff
