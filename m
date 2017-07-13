Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C86E202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbdGMTci (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:32:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:39780 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752545AbdGMTch (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:32:37 -0400
Received: (qmail 3070 invoked by uid 109); 13 Jul 2017 19:32:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 19:32:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4154 invoked by uid 111); 13 Jul 2017 19:32:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 15:32:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 15:32:34 -0400
Date:   Thu, 13 Jul 2017 15:32:34 -0400
From:   Jeff King <peff@peff.net>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>
Subject: Re: reftable: new ref storage format
Message-ID: <20170713193234.fkxf73t6jevj4svg@sigill.intra.peff.net>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 05:17:58PM -0700, Shawn Pearce wrote:

> We've been having scaling problems with insane number of references
> (>866k), so I started thinking a lot about improving ref storage.
> 
> I've written a simple approach, and implemented it in JGit.
> Performance is promising:
> 
>   - 62M packed-refs compresses to 27M
>   - 42.3 usec lookup

Exciting. I'd love for us to have a simple-ish on-disk structure that
scales well and doesn't involve a dependency on a third-party database
structure.

Let me see what holes I can poke in your proposal, though. :)

> ### Problem statement
> 
> Some repositories contain a lot of references (e.g.  android at 866k,
> rails at 31k).  The existing packed-refs format takes up a lot of
> space (e.g.  62M), and does not scale with additional references.
> Lookup of a single reference requires linearly scanning the file.

I think the linear scan is actually an implementation short-coming. Even
though the records aren't fixed-length, the fact that newlines can only
appear as end-of-record is sufficient to mmap and binary search a
packed-refs file (you just have to backtrack a little when you land in
the middle of a record).

I wrote a proof of concept a while ago, but got stuck on integrating it
into the ref code, because of some of the assumptions that it made.
Michael Haggerty has been doing several rounds of refactors to remove
those assumptions. I think we're pretty close (I've actually seen the
endgame where packed-refs is fully binary searched, but I think there
are a few more cleanups necessary to cover all cases).

> Atomic pushes modifying multiple references require copying the
> entire packed-refs file, which can be a considerable amount of data
> moved (e.g. 62M in, 62M out) for even small transactions (2 refs
> modified).

I think your definition of atomic here doesn't match what git.git does.

Our atomic push just takes the lock on all of the refs, and then once it
has all of them, commits all of the locks. So it's atomic in the sense
that you either get all or none of the writes (modulo a commit failure
in the middle, which we naturally have no rollback plan for). But it can
be done without touching the packed-refs file at all.

I imagine that you're looking at atomicity from the perspective of a
reader. In the git.git scheme, the reader may see a half-committed
transaction. If you dispense with loose refs entirely and treat the
packed-refs file as a single poorly-implemented key/value database, then
you get reader atomicity (but O(size_of_database) write performance).

> Repositories with many loose references occupy a large number of disk
> blocks from the local file system, as each reference is its own file
> storing 41 bytes.  This negatively affects the number of inodes
> available when a large number of repositories are stored on the same
> filesystem.  Readers are also penalized due to the larger number of
> syscalls required to traverse and read the `$GIT_DIR/refs` directory.

In my experience, the syscalls involved in loose refs aren't usually a
big deal. If you have 800k refs, they're not all changing constantly. So
a single pack-refs "fixes" performance going forward. What _is_ a big
deal is that the packing process is complicated, readers have a very
un-atomic view because of the myriad of files involved, and you get
annoying lock contention during packing, as well as between deletions
that have to rewrite packed-refs.

But I'm not sure if you meant to contrast here a system where we didn't
use packed-refs at all (though of course such a system is very much not
atomic by the definition above).


> ### Objectives
> 
> - Near constant time lookup for any single reference, even when the
>   repository is cold and not in process or kernel cache.

Good goal, though TBH I'd be happy with O(log n).

A related one is being able to traverse a subset of refs in
O(nr_traversed). E.g., "git tag -l" should not have to do work
proportional to what is in refs/changes. That falls out of most
proposals that allow fast lookups, but notably not a straight
hash-table.

> - Occupy less disk space for large repositories.

Good goal.  Just to play devil's advocate, the simplest way to do that
with the current code would be to gzip packed-refs (and/or store sha1s
as binary). That works against the "mmap and binary search" plan,
though. :)

> - Support atomic pushes with lower copying penalities.

"Lower" is vague. I'd hope we could do updates with effort linear to the
number of updated refs (it's OK if there's a constant factor, like
writing extra blocks, as long as a single-ref update is about as
expensive in a 10-ref repo as in a 10K-ref repo).

> Scan (read 866k refs) and lookup (single ref from 866k refs):
> 
> format      | scan    | lookup
> ------------|--------:|---------------:
> packed-refs |  380 ms | 375420.0 usec
> reftable    |  125 ms |     42.3 usec

Don't forget in git.git that the memory usage for packed-refs is
atrocious (because we parse the whole thing into RAM).

> ### Peeling
> 
> References in a reftable are always peeled.

Good. This is a very important optimization to retain.

> ### Reference name encoding
> 
> Reference names should be encoded with UTF-8.

Don't we usually treat refnames as byte sequences (subject to a few
rules, as in check_ref_format())? It seems like the encoding should be
out-of-scope for the storage format.

> ## File format

OK, let me try to summarize to see if I understand.

The reftable file is a sequence of blocks, each of which contains a
finite set of heavily-compressed refs. You have to read each block
sequentially, but since they're a fixed size, that's still a
constant-time operation (I'm ignoring the "restarts" thing for now). You
find the right block by reading the index.  So lookup really is more
like O(block_size * log(n/block_size)), but block_size being a constant,
it drops out to O(log n).

Linear scans are easy, because everything is in sorted order. So you
just find the first entry via binary search, and then walk forward.

Updates are where things get dicier. It looks like you just write a new
partial reftable file with your updates. And then if there are N
reftables present, readers actually have to do a list-merge of the
results they get from all of them (where the results from reftable.5
trump ones from reftable.4).

So basically we're just journaling updates into a directory of atomic
reftable updates. And then to keep the reader's job from getting too
painful, a write occasionally has to compact into a single reftable,
rewriting the entire ref store. That's what I see as the biggest
weakness here. If you keep too large a reftable stack, then readers have
to spend a lot of extra effort on lookups. But if you keep too small a
stack, then you are frequently rewriting the whole database.

Technically writes are still O(n). Because of the journaling you
amortize the whole-rewrite cost across several updates, but it's still
O(n/c). That seems like the biggest weakness of the scheme to me.

I think there's some cleverness you can use with compacting in a
geometric scheme, though, to amortize up to a certain bound. I didn't
see any discussion of that, though.

It's also possible I'm misunderstanding the writes. See below.

> Compaction is similar to the update process, but an explicit temporary
> file must be used:
> 
> 1. Atomically create `$GIT_DIR/reftable.lock`.
> 2. `readdir($GIT_DIR)` to determine the highest suffix ordinal, `n`.
> 3. Compute the update transaction (e.g. compare expected values).
> 4. Select files from (2) to collapse as part of this transaction.
> 5. Create temp file by `mktemp("$GIT_DIR/.reftableXXXXXX")`.
> 6. Write modified and collapsed references to temp file.
> 7. Rename temp file to `reftable.${n + 1}`.
> 8. Delete collapsed files `reftable.${n}`, `reftable.${n - 1}`, ...
> 9. Delete `reftable.lock`.

I had originally assumed you'd just compact back down to the reftable
file after some N updates (say, 10). But here, it looks like you'd
always compact 0-9 into 10, and then 10-19 into 20, and so on, and the
ordinal would go up forever.

I think that's OK, as it would take a long time to get unwieldy. And I
think you have to do it that way, as you can't atomically replace
"reftable" and delete .1-.9 at the same time.

> Because `reftable.9` can disappear after `reftable.10` is created,
> readers receiving ENOENT when opening `reftable.9` must peform
> another readdir to look for new reftables.

But after compaction, won't having "reftable.10" but no ".9" be the
steady state? As a reader, how can I tell the difference between these
two cases:

  1. Somebody created .10 and deleted .9 and lower.

  2. Somebody created .11 and deleted .10 and lower, while I was trying
     to read .9.

Is basically every read going to require:

  1. readdir to find the highest ordinal

  2. keep walking down the stack until you get ENOENT

  3. readdir again to make sure there's not a new ordinal

But in that case, if step 3 turns up a new reftable.11, how do I know
whether it's a compaction (in which case I need to restart my read from
.11) or if it's just another update-on-top? In a busy repository, you
might see a lot of update-on-tops.

> [...specifics...]

I liked a lot of what I saw in the rest of it (e.g., handling symrefs,
which packed-refs does not). Some bits seemed complicated. E.g., I
actually wonder how much restarts help in practice if you have
reasonably-sized blocks, and they complicate things a lot). Likewise
some bits are optional for very small reftable files to reduce overhead.
But if you have very small reftables, it's going to be fast either way.
If you waste 4K to store 200 bytes, that's fine as long as you're still
wasting only 4K when you store 200 megabytes.

That's all hand-waving, of course. But all things being equal, I'd
prefer to focus on algorithmic speedups, focusing on the simplest thing
that could work, and then seeing real experimental numbers from
additions.

I also realize that beggars can't be choosers. If you have a working
system that performs well, I should consider shutting up. :)

One thing I didn't see is reflogs. They don't strictly have to be part
of a ref-storage solution. But they do still consume at least one inode
per ref in the current system. If you reflog everything, which in my
opinion you should. Having an audit trail of ref updates is very useful
for debugging (both bugs in Git, and trying to figure out what went
wrong when a user goes berserk with "git push --prune").

-Peff
