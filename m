Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8BE1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 21:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbeGRWOK (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 18:14:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:51852 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728304AbeGRWOK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 18:14:10 -0400
Received: (qmail 20550 invoked by uid 109); 18 Jul 2018 21:34:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Jul 2018 21:34:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4132 invoked by uid 111); 18 Jul 2018 21:34:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 18 Jul 2018 17:34:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2018 17:34:20 -0400
Date:   Wed, 18 Jul 2018 17:34:20 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase,
 etc)
Message-ID: <20180718213420.GA17291@sigill.intra.peff.net>
References: <20180718204458.20936-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180718204458.20936-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 08:45:14PM +0000, Ben Peart wrote:

> When working directories get big, checkout times start to suffer.  Even with
> GVFS virtualization (which limits git to only having to update those files
> that have been changed locally) we�re seeing P50 times for checkout of 31
> seconds and the P80 time is 43 seconds.

Funny aside: all of your apostrophes look like the unicode question
mark. Looking at raw bytes of your mail, they're actually u+fffd
(unicode "replacement character"). Your headers correctly claim to be
utf8. So presumably they got munged by whatever converted to unicode and
didn't have the original character in its translation table. I wonder if
this was send-email (so really perl's encode module), or if your smtp
server tried to do an on-the-fly conversion (I know many servers will
switch the content-transfer-encoding, but I haven't seen a charset
conversion before).

Anyway, on to the actual discussion:

> Here is a checkout command with tracing turned on to demonstrate where the
> time is spent.  Note, this is somewhat of a �best case� as I�m simply
> checking out the current commit:
> 
> benpeart@gvfs-perf MINGW64 /f/os/src (official/rs_es_debug_dev)
> $ /usr/src/git/git.exe checkout
> 12:31:50.419016 read-cache.c:2006       performance: 1.180966800 s: read cache .git/index
> 12:31:51.184636 name-hash.c:605         performance: 0.664575200 s: initialize name hash
> 12:31:51.200280 preload-index.c:111     performance: 0.019811600 s: preload index
> 12:31:51.294012 read-cache.c:1543       performance: 0.094515600 s: refresh index
> 12:32:29.731344 unpack-trees.c:1358     performance: 33.889840200 s: traverse_trees
> 12:32:37.512555 read-cache.c:2541       performance: 1.564438300 s: write index, changed mask = 28
> 12:32:44.918730 unpack-trees.c:1358     performance: 7.243155600 s: traverse_trees
> 12:32:44.965611 diff-lib.c:527          performance: 7.374729200 s: diff-index
> Waiting for GVFS to parse index and update placeholder files...Succeeded
> 12:32:46.824986 trace.c:420             performance: 57.715656000 s: git command: 'C:\git-sdk-64\usr\src\git\git.exe' checkout

What's the current state of the index before this checkout? I don't
recall offhand how aggressively we prune the tree walk based on the diff
between the index and the tree we're loading. If we're starting from
scratch, then obviously we do have to walk the whole thing. But in most
cases we should be able to avoid walking into sub-trees where the index
has a matching cache_tree record.

If we're not doing that, it seems like that's going to be the big
obvious win, because it reduces the number of trees we have to consider
in the first place.

> ODB cache
> =========
> Since traverse_trees() hits the ODB for each tree object (of which there are
> over 500K in this repo) I wrote and tested having an in-memory ODB cache
> that cached all tree objects.  This resulted in a > 50% hit ratio (largely
> due to the fact we traverse the tree twice during checkout) but resulted in
> only a minimal savings (1.3 seconds).

In my experience, one major cost of object access is decompression, both
delta and zlib. Trees in particular tend to delta very well across
versions. We have a cache to try to reuse intermediate delta results,
but the default size is probably woefully undersized for your repository
(I know from past tests it's undersized a bit even for the linux
kernel).

Try bumping core.deltaBaseCacheLimit to see if that has any impact. It's
96MB by default.

There may also be some possible work in making it more aggressive about
storing the intermediate results. I seem to recall from past
explorations that it doesn't keep everything, and I don't know if its
heuristics have ever been proven sane.

For zlib compression, I don't have numbers handy, but previous
experiments showed that trees don't actually benefit all that much from
zlib (presumably because they're mostly random-looking hashes). So one
option would be to try repacking _just_ the trees with
"pack.compression" set to 0, and see how the result behaves. I suspect
that will be pretty painful with your giant multi-pack repo.

It might be slightly easier if we had an option to set the compression
level on a per-type basis (both to experiment, and then of course if it
works to actually tune your repo).

The numbers above aren't specific enough to know how much time was spent
doing zlib stuff, though. And even with more specific probes, it's
generally still hard to tell the difference between what's specific to
the compression level, and what's a result of the fact that zlib is
essentially copying all the bytes from the filesystem into memory.
Still, my timings with zstd[1] showed something like 10-20% improvement
on object access, so we should be able to get something at least as good
by moving to no compression.

[1] https://public-inbox.org/git/20161023080552.lma2v6zxmyaiiqz5@sigill.intra.peff.net/

> Tree Graph File
> ===============
> I also considered storing the commit tree in an alternate structure that is
> faster to load/parse (ala the Commit graph) but the cache results along with
> the negligible impact of running checkout back to back (thus ensuring the
> objects were cached in my file system cache) made me believe this would not
> result in much savings. MIDX has already helped out here given we end up
> with a lot of pack files of commits and trees.

I don't think this will help. Tree objects are actually reasonably
compact on disk relative to the information you're getting out of them.
As opposed to commit objects, where you expand a kilobyte to get the 40
bytes of parent pointer.

So there's probably benefit from storing tree _relationships_ (like the
diff between a commit and its parent) if it lets you avoid opening the
tree, but for a checkout you really are walking the tree entries.
Possibly with a diff to your current state (as above), but that
relationship is much less predictable (your current state is arbitrary,
not necessarily the commit parent).

> Sparse tree traversal
> =====================
> We�ve sped up other parts of git by taking advantage of the existing
> sparse-checkout/excludes logic to limit what files git has to consider to
> those that have been modified by the user locally.  I haven�t been able to
> think of a way to take advantage of that with unpack-trees() as when you are
> merging n commits, a change/conflict can occur in any tree object so they
> must all be traversed.  If I�m missing something here and there _is_ a way
> to entirely skip large parts of the tree, please let me know!  Please note
> that we�re already limiting the files that git needs to update in the
> working directory via sparse-checkout/excludes but the other/merge logic
> still executes for the entire tree whether there are files to update or not.

For narrow/partial clones, it seems like we'd ultimately have to
consider a merge of unavailable trees to be a conflict anyway. I.e., it
seems reasonable to me that if we're sparse in path "subdir", then in a
merge, either:

  1. Neither side touched "subdir", and we can ignore it without
     descending. 

  2. One side touched "subdir", in which we can take the trivial
     merge. This would be the common case when you pull somebody else's
     branch that touched code you have marked as sparse.

  3. Both sides touched it, in which case we must report a conflict.
     This might happen if you pulled two topics which both touched the
     same code (even if you didn't). It might even resolve cleanly if we
     had the actual trees and blobs to look at, but that just means
     _you_ can't resolve it in your sparse clone.

I'd expect (1) and (2) to be the common cases. I won't be at all
surprised if unpack_trees() isn't particularly smart about that, though.

> Multi-threading unpack_trees()
> ==============================
> The current model of unpack_trees() is that a single thread recursively
> traverses each tree object as it comes across it.  One thought I had was to
> multi-thread the traversal so that each tree object could be processed in
> parallel.  To test this idea out, I wrote an unbounded
> Multi-Product-Multi-Consumer queue and then wrote a
> traverse_trees_parallel() function that would add any new tree objects into
> the queue where they can be processed by a pool of worker threads.  Each
> thread will wake up when there is work in the queue, remove a tree object,
> process it adding any additional tree objects it finds.

I'm generally terrified of multi-threading anything in the core parts of
Git. There are so many latent bits of non-reentrant or racy code.

I think your queue suggestion may be the sanest approach, though,
because it makes it keeps the responsibilities of the worker threads
pretty clear.

> When I brought up this idea with some other git contributors they mentioned
> that multi threading unpack_trees() had been discussed a few years ago on
> the list but that the idea was discarded.  They couldn�t remember exactly
> why it was discarded and none of us have been able to find the email threads
> from that earlier discussion. As a result, I decided to write up this RFC
> and see if the greater git community has ideas, suggestions, or more
> background/history on whether this is a reasonable path to pursue or if
> there are other/better ideas on how to speed up checkout especially on large
> repos.

I don't remember any specific discussion, and didn't dig anything up
after a few minutes. But I'd be willing to bet that the primary reason
it would not be pursued is the general lack of thread safety in the
current codebase.

-Peff
