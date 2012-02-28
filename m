From: Jeff King <peff@peff.net>
Subject: Re: Announcing 3 git docs: Best Practices, fixing mistakes,
 post-production editing
Date: Tue, 28 Feb 2012 17:52:05 -0500
Message-ID: <20120228225205.GA23804@sigill.intra.peff.net>
References: <201202281304.q1SD4U8W018223@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 23:52:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Vu5-0003G2-NK
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 23:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966119Ab2B1WwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 17:52:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60602
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754129Ab2B1WwI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 17:52:08 -0500
Received: (qmail 15658 invoked by uid 107); 28 Feb 2012 22:52:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 Feb 2012 17:52:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2012 17:52:05 -0500
Content-Disposition: inline
In-Reply-To: <201202281304.q1SD4U8W018223@no.baka.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191789>

On Tue, Feb 28, 2012 at 08:04:30AM -0500, Seth Robertson wrote:

> Commit Often, Perfect Later, Publish Once: Git Best Practices
> ----------------------------------------------------------------------
> http://sethrobertson.github.com/GitBestPractices

I have only read the first of the three so far, but it looks very nice.
I did notice a few things which were worth commenting on (I'll quote
directly from the page in question below).

> [section Don't Panic, subsection Lost and Found]
>
> Dangling Commit
>
> These are the most likely candidates for finding lost data. A dangling
> commit is a commit no longer reachable by any branch or tag. This can
> happen due to resets and rebases and are normal. git show SHA will let
> you inspect them.

Resets and rebases record the commits in the reflog (at the very least
in the HEAD reflog), and should generally not be the cause of dangling
commits (the objects should usually expire in the same "git gc" that
expires the reflog entries). I suspect a more common cause is deleting
branches, which leaves no reflog (the commits may be in the HEAD reflog
if they were ever checked out, though).

It's somewhat minor; the overall advice ("do not worry about dangling
commits") holds. But it might be worth pointing out that the method for
recovering an accidentally deleted branch is usually:

  1. look in the HEAD reflog

  2. if you can't find it there, try dangling commits

> [section Do make useful commit messages]

This talks about formatting, but not about content. I have long wanted
to write a nice essay on what should go into a good commit message, but
when I've tried it ends up very specific to the project, the type of
commit, and the individual change. I wonder if anybody knows of
something good you could link to.

> [section On Sausage Making]
>
> Some people like to hide the sausage making, or in other words pretend to
> the outside world that their commits sprung full-formed in utter
> perfection into their git repository. Certain large public projects
> demand this, others demand smushing all work into one large commit, and
> still others do not care.
>
> A good reason to hide the sausage making is if you feel you may be
> cherry-picking commits a lot (though this too is often a sign of bad
> workflow). Having one or a small number of commits to pick is much
> easier than having to find one commit here, one there, and half of this
> other one. The latter approach makes your problem much much harder and
> typically will lead to merge conflicts when the donor branch is finally
> merged in.
>
> Another good reason is to ensure each commit compiles and/or passes
> regression tests, and represents a different easily understood concept
> (important for archeology). The former allows git-bisect to chose any
> commit and have a good chance of that commit doing something useful, and
> the latter allows for easy change review, understanding, and
> cherry-picking.

This is a nice overview of the motivation, but I think it misses one
of the main reasons we clean up patches in git.git: code review. When
you publish patches, you have several audiences. One of those audiences
is the end user who will compile release v1.5. They only care about the
end result of the patches. Another is people bisecting, who care that
everything intermediate builds and is reasonable; you can satisfy that
by checking each commit against a test suite. Another is people reading
the logs later to find out what happened; it's OK for them to see that a
bug was in the initial version, and then fixed 5 minutes later.

But yet another audience is reviewers who will read your changes and
decide they should be applied, rejected, or re-worked. For those people,
it is much harder to review a series that introduces a bug in patch 1,
but fixes it in patch 5. The reviewer may also notice the bug, take time
thinking about and writing an analysis, and then get frustrated to find
that their work was wasted when they get to patch 5.

The alternative is that they stop thinking about individual patches and
consider the whole series (e.g., when they see patch 1 has a bug, stop
reading and look through the other patches for a fix). But that makes
review much harder, because you have to think about a much larger series
of changes.

By cleaning up patches into single, logical changes that build on one
another, and which don't individually regress (i.e., they are always
moving towards some desirable common endpoint), the author is writing a
chronological story not of what happened, but what _should_ happen, with
the intent that the audience (i.e., reviewers) are convinced that the
change is the right thing to do.

I really liked your movie analogy. Patch series are really just
documentaries about a change, arranged for greatest impact on the
viewer. :)

> [Do periodic maintenance]
>
> Compact your repo (git gc --aggressive)
>
> This will removed outdated dangling objects (after the two+ week grace
> period). It will also compress any loose objects git has added since
> your last gc. git will run gc automatically after certain commands, but
> doing a manual --aggressive will save space and speed git operations.

Most people shouldn't be using "--aggressive". Unless you have an
existing pack that is poorly packed (e.g., because you did a
fast-import that did not do much delta searching), you are not going to
see much benefit, and it will take a lot longer. Basically the three
levels of "gc" are:

  1. git gc --auto; if there are too many loose objects, they will all
     go into a new incremental pack. If there are already too many
     packs, all of the existing packs will get re-packed together.

     If we are making an incremental pack, this is by far the fastest,
     because the speed is independent of the existing history. If we
     pack everything together, it should be more or less the same as (2)
     below.

  2. git gc; this packs everything into a single pack. It does not use
     high window and depth parameters, but more importantly, it reuses
     existing deltas. That makes the delta compression phase _much_
     faster, and it often makes the writing phase faster (because for
     older objects, we are primarily streaming them right out of the
     existing pack). On a big repo, though, it does do a lot of I/O,
     because it has to rewrite the whole pack.

  3. git gc --aggressive; this is often way slower than the above
     because we throw out all of the existing deltas and recompute them
     from scratch. The higher window parameter means it will spend a bit
     more time computing, and it may end up with a smaller pack.

In practical applications, I would expect (2) to achieve similar results to (3). If
that isn't the case, then I think we should be tuning up the default
window and depth parameters for non-aggressive "git gc" a bit.

> [section Miscellaneous "don't"s]
>
> create very large repositories (when possible)
>
> Git can be slow in the face of large repositories. There are
> git-config options that can help. pack.threads=1 pack.deltaCacheSize=1
> pack.windowMemory=512m core.packedGitWindowSize=16m
> core.packedGitLimit=128m. Other likely ones exist.

It might help to qualify "big" here. To some people, 10,000 files,
50,000 commits, and a 200M packfile is big. But that's a fraction of
linux-2.6, which most people use. I think big here is probably getting
into 100K-200K files (where the time to stat() files becomes noticeable,
commits are probably not relevant (because git is usually good at only
looking at recent bits of history for most operations), and packfiles
above 1G or so start to get cumbersome (mostly because of the I/O on a
full repack; but then you should consider marking a pack as .keep).

But those numbers are just pulled out of a hat based on the last few
years. Your OS, your hardware, and your expectations make a huge
difference in what seems reasonable.

Your config recommendations seem mostly related to relieving memory
pressure for packing (at the expense of making the pack a lot slower).
Dropping --aggressive from your gc might help a lot with that, too. It
might be worth noting that you should only start twiddling these options
if you are running out of memory during a repack. They will not affect
git performance for day-to-day commands.

I don't think you should need to adjust core.packedGitWindowSize or
core.packedGitLimit at all. Those files are mmap'd, so it is up to the
OS to be reasonable about faulting in or releasing the memory. The main
motivation of pack windows is not memory _usage_, but rather getting a
large contiguous chunk of the address space. mmap-ing a 4G packfile on a
32-bit system just doesn't work. But the defaults are set to reasonable
values for each architecture.

-Peff
