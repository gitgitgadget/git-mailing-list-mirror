Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D17BE95A82
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 17:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344384AbjJHRdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 13:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344357AbjJHRdg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 13:33:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911F9A3
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 10:33:34 -0700 (PDT)
Received: (qmail 10542 invoked by uid 109); 8 Oct 2023 17:33:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 08 Oct 2023 17:33:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5386 invoked by uid 111); 8 Oct 2023 17:33:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 08 Oct 2023 13:33:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 8 Oct 2023 13:33:29 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@gmail.com>
Subject: Re: [PATCH 7/7] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <20231008173329.GA1557002@coredump.intra.peff.net>
References: <cover.1696629697.git.me@ttaylorr.com>
 <e96921014557edb41dd73d93a8c3cf6cfaf0c719.1696629697.git.me@ttaylorr.com>
 <xmqqil7j751u.fsf@gitster.g>
 <ZSCR7e6KKqFv8mZk@nand.local>
 <CABPp-BE+mJ4e==fWNqUNi5RVkoui_xeZN+axnM6vBykDqAzHiA@mail.gmail.com>
 <ZSLS9G1lHruig48a@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSLS9G1lHruig48a@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 08, 2023 at 12:04:04PM -0400, Taylor Blau wrote:

> > I was interested in the same question as Junio, but from a different
> > angle.  fast-import documentation points out that the packs it creates
> > are suboptimal with poorer delta choices.  Are the packs created by
> > bulk-checkin prone to the same issues?  When I was thinking in terms
> > of having "git merge" use fast-import for pack creation instead of
> > writing loose objects (an idea I never investigated very far), I was
> > wondering if I'd need to mark those packs as "less optimal" and do
> > something to make sure they were more likely to be repacked.
> >
> > I believe geometric repacking didn't exist back when I was thinking
> > about this, and perhaps geometric repacking automatically handles
> > things nicely for us.  Does it, or are we risking retaining
> > sub-optimal deltas from the bulk-checkin code?
> >
> > (I've never really cracked open the pack code, so I have absolutely no
> > idea; I'm just curious.)
> 
> Yes, the bulk-checkin mechanism suffers from an even worse problem which
> is the pack it creates will contain no deltas whatsoever. The contents
> of the pack are just getting written as-is, so there's no fancy
> delta-ficiation going on.

I wonder how big a deal this would be in practice for merges.
pack-objects will look for deltas between any two candidates objects,
but in practice I think most deltas are between objects from multiple
commits (across the "time" dimension, if you will) rather than within a
single tree (the "space" dimension). And a merge operation is generally
creating a single new tree (recursive merging may create intermediate
states which would delta, but we don't actually need to keep those
intermediate ones. I won't be surprised if we do, though).

We should be able to test that theory by looking at existing deltas.
Here's a script which builds an index of blobs and trees to the commits
that introduce them:

  git rev-list HEAD |
  git diff-tree --stdin -r -m -t --raw |
  perl -lne '
    if (/^[0-9a-f]/) {
      $commit = $_;
    } elsif (/^:\S+ \S+ \S+ (\S+)/) {
      $h{$1} = $commit;
    }
    END { print "$_ $h{$_}" for keys(%h) }
  ' >commits.db

And then we can see which deltas come from the same commit:

  git cat-file --batch-all-objects --batch-check='%(objectname) %(deltabase)' |
  perl -alne '
    BEGIN {
      open(my $fh, "<", "commits.db");
      %commit = map { chomp; split } <$fh>;
    }
    next if $F[1] =~ /0{40}/; # not a delta
    next unless defined $commit{$F[0]}; # not in index
    print $commit{$F[0]} eq $commit{$F[1]} ? "inner" : "outer", " ", $_;
  '

In git.git, I see 460 "inner" deltas, and 193,081 "outer" ones. The
inner ones are mostly small single-file test vectors, which makes sense.
It's possible to have a merge result that does conflict resolution in
two such files (that would then delta), but it seems like a fairly
unlikely case. Numbers for linux.git are similar.

So it might just not be a big issue at all for this use case.

> I think Michael Haggerty (?) suggested to me off-list that it might be
> interesting to have a flag that we could mark packs with bad/no deltas
> as such so that we don't implicitly trust their contents as having high
> quality deltas.

I was going to suggest the same thing. ;) Unfortunately it's a bit
tricky to do as we have no room in the file format for an optional flag.
You'd have to add a ".mediocre-delta" file or something.

But here's another approach. I recall discussing a while back the idea
that we should not necessarily trust the quality of deltas in packs that
are pushed (and I think Thomas Gummerer even did some experiments inside
GitHub with those, though I don't remember the results). And one way
around that is during geometric repacking to consider the biggest/oldest
pack as "preferred", reuse its deltas, but always compute from scratch
with the others (neither reusing on-disk deltas, nor skipping
try_delta() when two objects come from the same pack).

That same strategy would work here (and for incremental fast-import
packs, though of course not if your fast-import pack is the "big" one
after you do a from-scratch import).

> > A couple of the comments earlier in the series suggested this was
> > about streaming blobs to a pack in the bulk checkin code.  Are tree
> > and commit objects also put in the pack, or will those continue to be
> > written loosely?
> 
> This covers both blobs and trees, since IIUC that's all we'd need to
> implement support for merge-tree to be able to write any objects it
> creates into a pack. AFAIK merge-tree never generates any commit
> objects. But teaching 'merge' to perform the same bulk-checkin trick
> would just require us implementing index_bulk_commit_checkin_in_core()
> or similar, which is straightforward to do on top of the existing code.

This is a bit of a devil's advocate question, but: would it make sense
to implement this as a general of Git's object-writing code, and not tie
it to a specific command? That is, what if a user could do:

  git --write-to-pack merge ...

but also:

  git --write-to-pack add ...

and the object-writing code would just write to a pack instead of
writing loose objects. That lets the caller decide when it is or is not
a good idea to use this mode. And if making loose objects gives bad
performance for merges, wouldn't the same be true of other operations
which generate many objects?

Possibly it exacerbates the "no deltas" issue from above (though it
would depend on the command).  The bigger question to me is one of
checkpointing. When do we finish off the pack with a .idx and make it
available to other readers? We could do it at program exit, but I
suspect there are some commands that really want to make objects
available sooner (e.g., as soon as "git add" writes an index, we'd want
those objects to already be available). Probably every program that
writes objects would need to be annotated with a checkpoint call (which
would be a noop in loose object mode).

So maybe it's a dumb direction. I dunno.

-Peff
