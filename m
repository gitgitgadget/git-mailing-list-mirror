Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15DB71F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 14:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388391AbeKPAsx (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 19:48:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:40608 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729034AbeKPAsw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 19:48:52 -0500
Received: (qmail 3125 invoked by uid 109); 15 Nov 2018 14:40:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Nov 2018 14:40:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16302 invoked by uid 111); 15 Nov 2018 14:40:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Nov 2018 09:40:07 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2018 09:40:44 -0500
Date:   Thu, 15 Nov 2018 09:40:44 -0500
From:   Jeff King <peff@peff.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     git@vger.kernel.org, Junio C Hamano <jch2355@gmail.com>,
        kernel-team@fb.com
Subject: Re: [RFC] cherry-pick notes to find out cherry-picks from the origin
Message-ID: <20181115144044.GA16450@sigill.intra.peff.net>
References: <20181017143921.GR270328@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181017143921.GR270328@devbig004.ftw2.facebook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 07:39:21AM -0700, Tejun Heo wrote:

> A while ago, I proposed changes to name-rev and describe so that they
> can identify the commits cherry-picked from the one which is being
> shown.
> 
>   https://public-inbox.org/git/20180726153714.GX1934745@devbig577.frc2.facebook.com/T/
> 
> While the use-cases - e.g. tracking down which release / stable
> branches a given commit ended up in - weren't controversial, it was
> suggested that it'd make more sense to use notes to link cherry-picks
> instead of building the feature into name-rev.

Sorry for the slow reply. This was on my to-look-at pile, but for
some reason I accidentally put in my done pile.

> The patch appended to this message implements most of it (sans tests
> and documentation).  It's composed of the following two parts.
> 
> * A new built-in command note-cherry-picks, which walks the specified
>   commits and if they're marked with the cherry-pick trailer, adds the
>   backlink to the origin commit using Cherry-picked-to tag in a
>   cherry-picks note.

That makes sense. I think this could also be an option to cherry-pick,
to instruct it to create the note when the cherry-pick is made.

But you may still want a command to backfill older cherry-picks, or
those done by other people who do not care themselves about maintaining
the notes tree.

It _feels_ like this is something that should be do-able by plugging a
few commands together, rather than writing a new C program. I.e.,
something like:

  git rev-list --format='%(trailers)' HEAD |
  perl -lne '
	/^commit ([0-9]+)/ and $commit = $1;
	/^\(cherry picked from commit ([0-9]+)/
		and print "$commit $1";
  ' |
  while read from to; do
	# One process per note isn't very efficient. Ideally there would
	# be an "append --stdin" mode. Double points if it understands
	# how to avoid adding existing lines.
	git notes append -m "Cherry-picked-to: $to" $from
  done

which is roughly what your program is doing.  Not that I'm entirely
opposed to doing something in C (we've been moving away from shell
scripts anyway). But mostly I am wondering if we can leverage existing
tools, and fill in their gaps in a way that lets people easily do
similar things.

And on that note...

> * When formatting a cherry-picks note for display, nested cherry-picks
>   are followed from each Cherry-picked-to tag and printed out with
>   matching indentations.

That makes sense to me, but does this have to be strictly related to
cherry-picks? I.e., in the more generic form, could we have a way of
marking a note as "transitive" for display, and the notes-display code
would automatically recognize and walk hashes?

That would serve your purpose, but would also allow similar things to
easily be done in the future.

> Combined with name-rev --stdin, it can produce outputs like the following.
> [...]

Yeah, that looks pretty good.

> Locally, the notes can be kept up-to-date with a trivial post-commit
> hook which invokes note-cherry-picks on the new commit; however, I'm
> having a bit of trouble figuring out a way to keep it up-to-date when
> multiple trees are involved.  AFAICS, there are two options.
> 
> 1. Ensuring that the notes are always generated on local commits and
>    whenever new commits are received through fetch/pulls.
> 
> 2. Ensuring that the notes are always generated on local commits and
>    transported with push/pulls.
> 
> 3. A hybrid approach - also generate notes on the receiving end and
>    ensure that fetch/pulls receives the notes together (ie. similar to
>    --tags option to git-fetch).
> 
> #1 seems simpler and more robust to me.  Unfortunately, I can't see a
> way to implement any of the three options with the existing hooks.
> For #1, there's no post-fetch hook.  For #2 and #3, there doesn't seem
> to be a fool-proof way to make sure that the notes are transported
> together.  Any suggestions would be greatly appreciated.

Yeah, I think (1) is the simplest: it becomes a purely local thing that
you've generated these annotations. Unfortunately, no, I don't think
there's anything like a post-fetch hook. This might be a good reason to
have one. One can always do "git fetch && update-notes" of course, but
having fetch feed the script the set of updated ref tips would be very
helpful (so you know you can traverse from $old..$new looking for
cherry-picks).

For (2) and (3), you can push/pull a notes tree, but setting up the
refspecs and config is fairly manual. Using the cherry-pick option I
suggested above would most locally-made picks, but you'd probably still
need to backfill sometimes anyway.

I don't think you'd need to be (nor am I sure you _could_ be) as fancy
as fetching notes and their respective commits together. The notes are
bound together in a single tree, so you cannot say "I don't have commit
1234abcd, I don't need the note for it". You get the whole tree. And
that is not such a bad thing. The big reason _not_ to fetch tags that
point to commits we don't have is that the tag fetch implies
reachability, which may mean sucking in a big chunk of history. Whereas
you can happily have a note pointing to a commit you don't have (though
I suppose you should avoid running "git notes prune" in that case).

> ---
>  Makefile                    |    1 
>  builtin.h                   |    1 
>  builtin/note-cherry-picks.c |  197 ++++++++++++++++++++++++++++++++++++++++++++
>  builtin/notes.c             |   17 ++-
>  git.c                       |    1 
>  notes.c                     |   95 +++++++++++++++++++++
>  notes.h                     |    7 +
>  object.c                    |    4 
>  object.h                    |    6 +
>  9 files changed, 320 insertions(+), 9 deletions(-)

I only looked briefly over your implementation, but didn't see anything
obviously wrong. I do think it would be nice to make it more generic, as
much as possible. I think the most generic form is really:

  traverse-and-show-trailers | invert-trailers | add-notes

In theory I should be able to do the same inversion step on any trailer
which mentions another commit.

If it is going to stay in C and be cherry-pick-specific, one obvious
improvement would be to use the notes API directly, rather than spawning
subprocesses. That should be much more efficient if you have a lot of
notes to write.

-Peff
