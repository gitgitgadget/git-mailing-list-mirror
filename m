Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474CF1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 20:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbdGYU6q (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 16:58:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:48848 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752423AbdGYU6p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 16:58:45 -0400
Received: (qmail 13686 invoked by uid 109); 25 Jul 2017 20:58:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 25 Jul 2017 20:58:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21289 invoked by uid 111); 25 Jul 2017 20:59:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 25 Jul 2017 16:59:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Jul 2017 16:58:43 -0400
Date:   Tue, 25 Jul 2017 16:58:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Raman Gupta <rocketraman@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC] Git rerere and non-conflicting changes during conflict
 resolution
Message-ID: <20170725205843.bi6kyqjlzyodmxuq@sigill.intra.peff.net>
References: <17c46229-3b64-34f1-30fa-d40b77e1c054@gmail.com>
 <20170725175202.ar4ykqoadbihwb2w@sigill.intra.peff.net>
 <xmqqo9s8uuth.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9s8uuth.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2017 at 01:26:34PM -0700, Junio C Hamano wrote:

> This is not even a limitation but is outside the scope of rerere.
> Let's understand that first.
> [...]
> If we wanted to port the "merge-fix" logic, and I do wish it would
> happen some day, the update belongs to "git merge".

Looks like this crossed with my latest email. Overall I agree with you.

I almost said the same thing about scope initially, but I decided it
doesn't really matter. From the user's perspective there may be a tool X
that replays bits of a previous merge result. And that task can be
subdivided into replaying conflict resolution and replaying merge-fixes.

From the user's perspective, calling X "rerere" would probably be OK[1].
But from an implementation perspective (and to keep the existing
plumbing available and unchanged), it probably makes sense to call it
something else, and have it run both rerere and a new plumbing command
to do the merge-fix work (or call it nothing, and assume that users will
either touch the plumbing directly or will use "git merge" to trigger
both).

So if you want to shut down immediately the idea that this would be
bolted onto rerere, I can support that. There are ways of doing it that
would make sense to combine with rerere (like the "tying fixups to
conflict resolution" sketch I gave in the other email), but I agree they
will end up fundamentally hacky (because of the exact "you may not even
have textual conflicts" I mentioned).

The only part I'd disagree with above is that this belongs to git-merge.
I think it should be its own plumbing tool that merge calls alongside
rerere. ;)

>    - Then, it looks up the database to find the keys <A, B> where
>      A is in X but not in Y, and B is not in X but in Y.
>      These commits are cherry-picked and squashed into the result of
>      the above.

I think this is the crux of it. I mentioned in my other email that what
we really want is some way to say "this is roughly the same merge".
The Reintegrate script does it with the topic branch name and an
implicit "merging up to an integration branch".

Not having thought too hard about it yet, this containing relationship
seems like the right direction. I guess you'd do the lookup by computing
the merge-base M of <X,Y> (which we already know anyway), walking M..X
and looking for any entries which mention those commits (in either A or
B slots of the entry), and then similarly narrowing it according to
M..Y.

Hrm. That doesn't quite work, though. Because if your <A,B> are the
merge, then merging a topic to next will get an "A" that is a merge
commit from next. But that commit will never end up in master. What's
causing the conflict is really some "A" that is in the history between
the merge base and "A" (but we don't know which).

So you'd almost have to do an intersection of the left side of "$(git
merge-base A B)..A" with what's in X and Y (with respect to their merge
base). Err, maybe vice versa. But the point is that we're looking for
overlapping set unions, I think, not the presence of particular tips.

> I said A and B in the above are branch names, but in the ideal
> world, they can be commit object names (possibly in the middle of a
> branch), as long as we can reliable update the database's keys every
> time "git rebase" etc. rewrites commits.

What if instead of commit hashes we used patch ids?

There's one trick there, which is that merges don't have a well-defined
commit id. We could use its actual commit id in that case. That would
work OK in practice for a workflow like git.git's, because the merge
commits are never rewritten. But it would fall down if people do mixed
rebases and merges on their topic branches.

> To populate the database, we'd need a reverse.
> 
>  * When merging branch B into branch A (or the other way around) for
>    the first time, "git merge" would do what it currently does.
> 
>  * The user then concludes the merge to resolve *ONLY* the textual
>    conflict, and commit the result.  It is important that no
>    additional evil merge to correct for semantic conflicts is done
>    in this step.  Note that if the auto-merge cleanly succeeds, this
>    step may not even exist.
> 
>  * Then the user makes another commit to correct for semantic
>    conflicts (aka "merge-fix").

I think it's asking a lot for users to handle the textual conflicts and
semantic ones separately. It would be nice if we could tell them apart
automatically (and I think we can based on what isn't part of the
conflict resolution).

That still ends up with one giant "fixup" commit. But I don't know how
else you'd do it. I could make several commits, but we still don't know
how to attribute them to anything but the mass <A,B> merge. We don't
know which commits were responsible for which fixups (and I wouldn't
want to ask the user to figure it out), so the best we can do is apply
them all.

-Peff
