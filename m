Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03CA720357
	for <e@80x24.org>; Fri, 14 Jul 2017 20:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbdGNUIe (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 16:08:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:41122 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751012AbdGNUId (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 16:08:33 -0400
Received: (qmail 5127 invoked by uid 109); 14 Jul 2017 20:08:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 20:08:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13993 invoked by uid 111); 14 Jul 2017 20:08:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 16:08:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jul 2017 16:08:31 -0400
Date:   Fri, 14 Jul 2017 16:08:31 -0400
From:   Jeff King <peff@peff.net>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>
Subject: Re: reftable: new ref storage format
Message-ID: <20170714200830.iks5drqu72cypkny@sigill.intra.peff.net>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <20170713193234.fkxf73t6jevj4svg@sigill.intra.peff.net>
 <CAJo=hJts=wY4vBaLsOtoH8+LBFK_drBhHMxPvKoQcqtpOfJOog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJo=hJts=wY4vBaLsOtoH8+LBFK_drBhHMxPvKoQcqtpOfJOog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 05:11:52PM -0700, Shawn Pearce wrote:

> Yes, I was hoping for reader atomicity. But I may OK foregoing that if
> the transaction either all goes through, or all fails. A partially
> stuck transaction because the process died in the middle of the commit
> step creates a mess for an administrator to undo. Does she rename
> "foo.lock" to "foo"? Or delete "foo.lock"?

Agreed, there's no real rollback or recovery process. I do think
shooting for reader atomicity is worth doing. Lack of atomicity can
cause odd things to happen with operations like pruning, for example. If
I'm trying to get a list of all of the reachable objects, for example, I
might have to readdir() a bunch of directories (let's forget even that a
single readdir() is not necessarily atomic). If I try to atomically move
"refs/heads/z/foo" to "refs/heads/a/foo" there is a reasonable chance
that a reader may see only the deletion and not the addition.

I don't have any known cases of this biting anyone, but it's somewhat
scary.

> > But I'm not sure if you meant to contrast here a system where we didn't
> > use packed-refs at all (though of course such a system is very much not
> > atomic by the definition above).
> 
> No, I really did mean the current system. Gerrit Code Review servers
> create a lot of references throughout the day. Its easy to accumulate
> a few thousand new loose references in a 24 hour period. Even if you
> have 600k existing refs in packed-refs, you still have 2k new/modified
> refs since last nightly cron ran git gc.

I do think you'd be better served by just calling pack-refs more
frequently, then. Nightly is too infrequent for a busy repo. And under
something like reftables, you'd end up doing the equivalent of a
pack-refs every N updates anyway.

We actually pack refs quite aggressively at GitHub. Way more than I
would consider reasonable, but it's never been a big bottleneck, so I've
never looked into it. We don't do it for every update, but every update
triggers a "consider syncing objects into shared storage" job, which
will pack the refs. So in a hypothetical repo that's constantly updating
we probably pack refs at least once a minute.

But we're generally on low-latency local disks. It sounds like you
emphatically are not.

> > Good goal.  Just to play devil's advocate, the simplest way to do that
> > with the current code would be to gzip packed-refs (and/or store sha1s
> > as binary). That works against the "mmap and binary search" plan,
> > though. :)
> 
> Yes it does. I tried to cover that later under "Alternatives
> considered > bzip". :)

Yeah, sorry, I read and responded to the document a bit out of order. I
agree it's a dead-end. :)

> >> Reference names should be encoded with UTF-8.
> >
> > Don't we usually treat refnames as byte sequences (subject to a few
> > rules, as in check_ref_format())? It seems like the encoding should be
> > out-of-scope for the storage format.
> 
> True that git-core treats them as byte sequences, but JGit treats them as UTF-8.

I think we can probably stick with that, unless the UTF-8ness is really
important? I guess it might matter if it impacts the sorting order.

> Yes. My "near constant time" claim was because I had my head buried
> thinking about disk IO operations when I wrote this, not the algorithm
> that happens on the CPU. One of the applications for reftable is on a
> slower-than-usual storage system, where reading a block of a file
> costs enough milliseconds that it doesn't matter how good or bad the
> CPU algorithm is.

OK, that explains a lot of the decisions better. If you're planning on
evolving this proposal document, I think it would make sense to talk
about that in the objectives section. (I say "if" because I am happy for
the mailing list discussion to serve as a rationale document).

> But you say this yourself below, you can do this using a geometric
> scheme or something to bound the cost of these rewrites such that you
> aren't frequently rewriting the whole database.

Right, but that sounds like math. I wanted you to spoonfeed me the
geometric algorithm (and its bound proof). ;)

> >> Compaction is similar to the update process, but an explicit temporary
> >> file must be used:
> >>
> >> 1. Atomically create `$GIT_DIR/reftable.lock`.
> >> 2. `readdir($GIT_DIR)` to determine the highest suffix ordinal, `n`.
> >> 3. Compute the update transaction (e.g. compare expected values).
> >> 4. Select files from (2) to collapse as part of this transaction.
> >> 5. Create temp file by `mktemp("$GIT_DIR/.reftableXXXXXX")`.
> >> 6. Write modified and collapsed references to temp file.
> >> 7. Rename temp file to `reftable.${n + 1}`.
> >> 8. Delete collapsed files `reftable.${n}`, `reftable.${n - 1}`, ...
> >> 9. Delete `reftable.lock`.

I think the "stack" implementation is what makes me most uncomfortable
with this proposal. Atomicity with filesystem operations and especially
readdir() is one of the things I think is most flaky about the current
system. Here's an idea for an alternative implementation.

  1. Write out reftables to files named after the hash of their content
     (e.g., $GIT_DIR/reftables/1234abcd...).

  2. The first block of the each reftable has a backpointer to the
     previous table.

  3. There's a well-known name (e.g., $GIT_DIR/reftable) that represents
     the current state. We update it with the usual .lock/rename dance.

That gives readers an easy atomic view; once they've called open() on
"reftable", they follow back-pointers instead of computing the names
(n-1, n-2, etc). They may still find that a compaction has removed a
file they need, but:

  - they only have to restart due to an actual compaction. They'll never
    be tricked by a regular update.

  - you can compact without immediately deleting the old reftables. So
    you might compact, and then delete the reftables N seconds later. Any
    reader which completes the read within N seconds wouldn't have to
    restart.

I think I can anticipate your answer, though. If you have a system where
the latency to open and read a file is high, then you've just serialized
the latencies as you walk the chain. Whereas with predictable names, you
can pre-fetch refname.i through refname.j in parallel.

How deep would you anticipate stacks getting? Would it be feasible for
the tip to contain the names of the tables in the entire chain? If we're
talking about 20 (or even 32) bytes per name, you could still fit over a
hundred names in a 4K inode.

It doesn't escape me that I'm basically reinventing RefTree here, with
reftables instead of tree objects. But I think breaking away from using
real Git objects opens up a lot of efficiency tricks (like the prefix
compression, and the parallel-fetch thing above). And it removes a lot
of the gc complexity.

> I think I was imaging updates are less frequent than reads, and a
> reader is going to readdir(), and then immediately open every file in
> the stack to setup the merge-join iteration. If the reader retains the
> file descriptor, the reader can keep that file in their stack.
> 
> There is risk of a reader live-locking; the reader might have done a
> readdir, starts opening the stack, sees ENOENT. In which case the
> reader starts over. If an updater is performing compactions faster
> than a reader can readdir and open paths, its live-lock for the
> reader. That certainly is one motivation to not always perform a
> compaction.

I guess I don't have much faith in the atomicity of readdir(). And it
would be nice if we could tell the difference between "oops, reftable.5
was racily deleted" and "it is not supposed to be there due to a
previous compaction". So I foresee always walking back to 0, stopping at
the first ENOENT, and then doing a final readdir() to see if any new
items appeared. If one has, we can't tell if it's a compaction in
progress or a regular update, and we have to restart.

So I'm worried about live-locking with a regular updater, not even a
compacting one.

> > I liked a lot of what I saw in the rest of it (e.g., handling symrefs,
> > which packed-refs does not). Some bits seemed complicated. E.g., I
> > actually wonder how much restarts help in practice if you have
> > reasonably-sized blocks, and they complicate things a lot).
> 
> My implementation lets me tweak the restart table with a command line
> option, so I was able to run a number of experiments for you. A 64k
> block doesn't fit more than a few thousand references, so restart 4000
> effectively disables restarts.
> 
> block  restart  size  lookup
> 4k     16       29M    90.2 usec
> 8k     16       29M    76.4 usec
> 
> 64k    16       29M   147.7 usec
> 64k    64       28M   134.3 usec
> 64k    256     27M   143.4 usec
> 
> 4k     4000     28M   104.0 usec
> 8k     4000     28M   117.1 usec
> 64k   4000     27M   288.5 usec

Thanks for these numbers. I was really thinking that blocks would be on
the order of 4K (where you can see that the restarts help very little).
For local disk that's a pretty reasonable size. For high-latency fetches
to a specialized database, maybe not.

> For $REASONS, I favor a larger block size in some cases, even though
> the lookup times get worse. For example, being able to use 64k/64 may
> be a sweet spot for that particular IO system I mentioned above.

Right, that makes a lot more sense.

> > as long as you're still
> > wasting only 4K when you store 200 megabytes.
> 
> I don't think this is fair. Its better thought of as a ratio.
> [...]
> 5 refs in reftable is ~204 bytes, because of the optional features
> being disabled on small files. If reftable was forced to fill out to a
> full 4K block, that is a penalty of 1907%. This might seem like
> nothing, but for cases where the table has to travel on the network,
> or is being stored in a tail-block-optimized filesystem, its a huge
> waste to pad the file out.

Yeah, my assumption was that anything under 4K is basically going to
take 4K. But I agree it's very dependent on the underlying storage
mechanism.

> > I also realize that beggars can't be choosers. If you have a working
> > system that performs well, I should consider shutting up. :)
> 
> I have it in Java for JGit; I don't yet have a C implementation.

I'm a beggar; I'll take even a well-developed plan. :)

The implementation on this doesn't seem overly complex. My main concerns
are what we're asking from the filesystem in terms of atomicity, and
what possible races there are.

> > One thing I didn't see is reflogs. They don't strictly have to be part
> > of a ref-storage solution. But they do still consume at least one inode
> > per ref in the current system. If you reflog everything, which in my
> > opinion you should. Having an audit trail of ref updates is very useful
> > for debugging (both bugs in Git, and trying to figure out what went
> > wrong when a user goes berserk with "git push --prune").
> 
> Yea, I glossed over that and ignored them. Mostly because one system
> where I want to use reftable already has a separate database handling
> the reflogs. In another (Gerrit Code Review), we disable reflogs for
> the insane refs/changes/ namespace, as nearly every reference is
> created once, and never modified.

Even for created-once refs, I've found an audit trail of created when,
by whom, using what program to be quite valuable. Long ago we tried to
use reflogs for that, but these days we literally just write the refname
and its reflog entry to an "audit_log" file. It's not used for
reachability and it's never pruned. It just grows forever without bound.

I think some variant of that could work for reflog storage (with
reachability and whole-file-rewrite expiration, obviously). The biggest
drawback is that traversing the reflogs for one ref requires walking
over the entries for all refs. But I'm not sure how much that would hurt
in practice. Many reflog operations look at all the reflogs anyway
(e.g., reachability, expiration). And finding the entry for a single ref
(e.g., ref@{1.day.ago}) is bounded in far back it has to walk.

> One could abuse the reftable format to store a reflog. If the refname
> field is just a sequence of bytes, one could store keys like refname +
> '\0' + timestamp, and reuse the symbolic ref value format to store the
> old/new/message, as its just a length delimited string.

Gross, but it could work. I actually think David's LMDB proposal did
something similar (encoding the entries in the keyname), but I'd have to
double-check.

> I'm loath to allocate more bits to denote a reflog entry vs. ref entry
> in the same file, but I could see some advantages to that. Commits
> would only have to write one new reftable for the combined update +
> log record.

Yes, but I'd worry that the reflog entries (which would have to hang
around in the reftable until being expired) would slow performance for
normal ref lookups. In my experience ref lookups are very frequent, and
reflog lookups are not. It's OK to segment them and have worse
performance for the reflogs.

-Peff
