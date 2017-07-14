Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3209E2027C
	for <e@80x24.org>; Fri, 14 Jul 2017 00:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbdGNAMP (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 20:12:15 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34088 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdGNAMO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 20:12:14 -0400
Received: by mail-vk0-f46.google.com with SMTP id r125so38872219vkf.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 17:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wi4WkOvJqh53U9OzJrXWs5LyVmLMg5GnJPDMKWCkpJc=;
        b=HjPiXLKFKKO96fj7A0djMVJkcWfTiQnR/rQ0jEkb6yqYR3j8kV+mS/sDI7I+6CjK0A
         tBXXNUjCym22vdtKS+AJvtSeR96C6HK9D+zh9tb80JsNlUeAFKMME+8vy+7ZePA7PF4k
         dRE6/arZe8Epdb9/HpUAcmD6RYjKdVg7ETCQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wi4WkOvJqh53U9OzJrXWs5LyVmLMg5GnJPDMKWCkpJc=;
        b=sbStxyssSLdxcpiBvWcECTr1wx8K6rJL3DynLI5vbo2lJIT0nVodhorTkmsMbrlrRM
         N05CMvPmgoXXb3l60JJXuMGmkbV5GnwnXTzqxOwx7TumdeZQhT83OAwf87USbyFuZgLj
         /3roQuHffDDR4gaMO7rplzty5EyE2U8awXXvpK6F83UsL6w9LQgrq1iQpu6IfJYxYzpv
         Yumn9Py/bs785+7JjmI0pruICjKDjePVlMHq0pLY2Kf3L4LLy15nbPzBqzz2iryx1Cci
         a8il+At0wbFkMAVL0wzAnE1tShG0GYUpFbgqfC7+yIwHDGuWsJniKoEXmn3PbuWovlgm
         kU6A==
X-Gm-Message-State: AIVw112YR3t237pciu1pGxTbwKdvpNiYBL5VI46eWypMf9FBmLW/3u4p
        ewY5JEO4DxYQ5vxybRHafmoFH1J9ZuW6fRTF4Q==
X-Received: by 10.31.12.201 with SMTP id 192mr3915469vkm.144.1499991132900;
 Thu, 13 Jul 2017 17:12:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.71.5 with HTTP; Thu, 13 Jul 2017 17:11:52 -0700 (PDT)
In-Reply-To: <20170713193234.fkxf73t6jevj4svg@sigill.intra.peff.net>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <20170713193234.fkxf73t6jevj4svg@sigill.intra.peff.net>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Thu, 13 Jul 2017 17:11:52 -0700
Message-ID: <CAJo=hJts=wY4vBaLsOtoH8+LBFK_drBhHMxPvKoQcqtpOfJOog@mail.gmail.com>
Subject: Re: reftable: new ref storage format
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 12:32 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jul 12, 2017 at 05:17:58PM -0700, Shawn Pearce wrote:
>
>> ### Problem statement
>>
>> Some repositories contain a lot of references (e.g.  android at 866k,
>> rails at 31k).  The existing packed-refs format takes up a lot of
>> space (e.g.  62M), and does not scale with additional references.
>> Lookup of a single reference requires linearly scanning the file.
>
> I think the linear scan is actually an implementation short-coming. Even
> though the records aren't fixed-length, the fact that newlines can only
> appear as end-of-record is sufficient to mmap and binary search a
> packed-refs file (you just have to backtrack a little when you land in
> the middle of a record).
>
> I wrote a proof of concept a while ago, but got stuck on integrating it
> into the ref code, because of some of the assumptions that it made.
> Michael Haggerty has been doing several rounds of refactors to remove
> those assumptions. I think we're pretty close (I've actually seen the
> endgame where packed-refs is fully binary searched, but I think there
> are a few more cleanups necessary to cover all cases).

You are correct, this is possible with the current packed-refs format.
It just hasn't materialized in a shipping implementation yet.


>> Atomic pushes modifying multiple references require copying the
>> entire packed-refs file, which can be a considerable amount of data
>> moved (e.g. 62M in, 62M out) for even small transactions (2 refs
>> modified).
>
> I think your definition of atomic here doesn't match what git.git does.

:-(


> Our atomic push just takes the lock on all of the refs, and then once it
> has all of them, commits all of the locks. So it's atomic in the sense
> that you either get all or none of the writes (modulo a commit failure
> in the middle, which we naturally have no rollback plan for). But it can
> be done without touching the packed-refs file at all.
>
> I imagine that you're looking at atomicity from the perspective of a
> reader. In the git.git scheme, the reader may see a half-committed
> transaction. If you dispense with loose refs entirely and treat the
> packed-refs file as a single poorly-implemented key/value database, then
> you get reader atomicity (but O(size_of_database) write performance).

Yes, I was hoping for reader atomicity. But I may OK foregoing that if
the transaction either all goes through, or all fails. A partially
stuck transaction because the process died in the middle of the commit
step creates a mess for an administrator to undo. Does she rename
"foo.lock" to "foo"? Or delete "foo.lock"?


>> Repositories with many loose references occupy a large number of disk
>> blocks from the local file system, as each reference is its own file
>> storing 41 bytes.  This negatively affects the number of inodes
>> available when a large number of repositories are stored on the same
>> filesystem.  Readers are also penalized due to the larger number of
>> syscalls required to traverse and read the `$GIT_DIR/refs` directory.
>
> In my experience, the syscalls involved in loose refs aren't usually a
> big deal. If you have 800k refs, they're not all changing constantly. So
> a single pack-refs "fixes" performance going forward. What _is_ a big
> deal is that the packing process is complicated, readers have a very
> un-atomic view because of the myriad of files involved, and you get
> annoying lock contention during packing, as well as between deletions
> that have to rewrite packed-refs.
>
> But I'm not sure if you meant to contrast here a system where we didn't
> use packed-refs at all (though of course such a system is very much not
> atomic by the definition above).

No, I really did mean the current system. Gerrit Code Review servers
create a lot of references throughout the day. Its easy to accumulate
a few thousand new loose references in a 24 hour period. Even if you
have 600k existing refs in packed-refs, you still have 2k new/modified
refs since last nightly cron ran git gc.


>> ### Objectives
>>
>> - Near constant time lookup for any single reference, even when the
>>   repository is cold and not in process or kernel cache.
>
> Good goal, though TBH I'd be happy with O(log n).
>
> A related one is being able to traverse a subset of refs in
> O(nr_traversed). E.g., "git tag -l" should not have to do work
> proportional to what is in refs/changes. That falls out of most
> proposals that allow fast lookups, but notably not a straight
> hash-table.

Thanks, I missed that in this list, even though it was an explicit
objective going into this work. I added:

- Efficient lookup of an entire namespace, such as `refs/tags/`.


>> - Occupy less disk space for large repositories.
>
> Good goal.  Just to play devil's advocate, the simplest way to do that
> with the current code would be to gzip packed-refs (and/or store sha1s
> as binary). That works against the "mmap and binary search" plan,
> though. :)

Yes it does. I tried to cover that later under "Alternatives
considered > bzip". :)


>> ### Reference name encoding
>>
>> Reference names should be encoded with UTF-8.
>
> Don't we usually treat refnames as byte sequences (subject to a few
> rules, as in check_ref_format())? It seems like the encoding should be
> out-of-scope for the storage format.

True that git-core treats them as byte sequences, but JGit treats them as UTF-8.


>> ## File format
>
> OK, let me try to summarize to see if I understand.
>
> The reftable file is a sequence of blocks, each of which contains a
> finite set of heavily-compressed refs. You have to read each block
> sequentially, but since they're a fixed size, that's still a
> constant-time operation (I'm ignoring the "restarts" thing for now). You
> find the right block by reading the index.  So lookup really is more
> like O(block_size * log(n/block_size)), but block_size being a constant,
> it drops out to O(log n).

Yes. My "near constant time" claim was because I had my head buried
thinking about disk IO operations when I wrote this, not the algorithm
that happens on the CPU. One of the applications for reftable is on a
slower-than-usual storage system, where reading a block of a file
costs enough milliseconds that it doesn't matter how good or bad the
CPU algorithm is.


> Linear scans are easy, because everything is in sorted order. So you
> just find the first entry via binary search, and then walk forward.

Yup.


> Updates are where things get dicier. It looks like you just write a new
> partial reftable file with your updates. And then if there are N
> reftables present, readers actually have to do a list-merge of the
> results they get from all of them (where the results from reftable.5
> trump ones from reftable.4).

Correct.


> So basically we're just journaling updates into a directory of atomic
> reftable updates. And then to keep the reader's job from getting too
> painful, a write occasionally has to compact into a single reftable,
> rewriting the entire ref store.

Correct.


> That's what I see as the biggest
> weakness here. If you keep too large a reftable stack, then readers have
> to spend a lot of extra effort on lookups. But if you keep too small a
> stack, then you are frequently rewriting the whole database.

But you say this yourself below, you can do this using a geometric
scheme or something to bound the cost of these rewrites such that you
aren't frequently rewriting the whole database.


> Technically writes are still O(n). Because of the journaling you
> amortize the whole-rewrite cost across several updates, but it's still
> O(n/c). That seems like the biggest weakness of the scheme to me.
>
> I think there's some cleverness you can use with compacting in a
> geometric scheme, though, to amortize up to a certain bound. I didn't
> see any discussion of that, though.

I think I left this as an exercise to the implementer. The
"Transactions > Compaction" section talks about the compaction
algorithm being applied only near the top of the stack, ignoring the
base table(s).


>> Compaction is similar to the update process, but an explicit temporary
>> file must be used:
>>
>> 1. Atomically create `$GIT_DIR/reftable.lock`.
>> 2. `readdir($GIT_DIR)` to determine the highest suffix ordinal, `n`.
>> 3. Compute the update transaction (e.g. compare expected values).
>> 4. Select files from (2) to collapse as part of this transaction.
>> 5. Create temp file by `mktemp("$GIT_DIR/.reftableXXXXXX")`.
>> 6. Write modified and collapsed references to temp file.
>> 7. Rename temp file to `reftable.${n + 1}`.
>> 8. Delete collapsed files `reftable.${n}`, `reftable.${n - 1}`, ...
>> 9. Delete `reftable.lock`.
>
> I had originally assumed you'd just compact back down to the reftable
> file after some N updates (say, 10). But here, it looks like you'd
> always compact 0-9 into 10, and then 10-19 into 20, and so on, and the
> ordinal would go up forever.
>
> I think that's OK, as it would take a long time to get unwieldy. And I
> think you have to do it that way, as you can't atomically replace
> "reftable" and delete .1-.9 at the same time.
>
>> Because `reftable.9` can disappear after `reftable.10` is created,
>> readers receiving ENOENT when opening `reftable.9` must peform
>> another readdir to look for new reftables.
>
> But after compaction, won't having "reftable.10" but no ".9" be the
> steady state?

Yes, it will be. You'd have maybe "reftable" and "reftable.10", and
nothing else.


> As a reader, how can I tell the difference between these
> two cases:
>
>   1. Somebody created .10 and deleted .9 and lower.
>
>   2. Somebody created .11 and deleted .10 and lower, while I was trying
>      to read .9.
>
> Is basically every read going to require:
>
>   1. readdir to find the highest ordinal
>
>   2. keep walking down the stack until you get ENOENT
>
>   3. readdir again to make sure there's not a new ordinal
>
> But in that case, if step 3 turns up a new reftable.11, how do I know
> whether it's a compaction (in which case I need to restart my read from
> .11) or if it's just another update-on-top? In a busy repository, you
> might see a lot of update-on-tops.

I think I was imaging updates are less frequent than reads, and a
reader is going to readdir(), and then immediately open every file in
the stack to setup the merge-join iteration. If the reader retains the
file descriptor, the reader can keep that file in their stack.

There is risk of a reader live-locking; the reader might have done a
readdir, starts opening the stack, sees ENOENT. In which case the
reader starts over. If an updater is performing compactions faster
than a reader can readdir and open paths, its live-lock for the
reader. That certainly is one motivation to not always perform a
compaction.


>> [...specifics...]
>
> I liked a lot of what I saw in the rest of it (e.g., handling symrefs,
> which packed-refs does not). Some bits seemed complicated. E.g., I
> actually wonder how much restarts help in practice if you have
> reasonably-sized blocks, and they complicate things a lot).

My implementation lets me tweak the restart table with a command line
option, so I was able to run a number of experiments for you. A 64k
block doesn't fit more than a few thousand references, so restart 4000
effectively disables restarts.

block  restart  size  lookup
4k     16       29M    90.2 usec
8k     16       29M    76.4 usec

64k    16       29M   147.7 usec
64k    64       28M   134.3 usec
64k    256     27M   143.4 usec

4k     4000     28M   104.0 usec
8k     4000     28M   117.1 usec
64k   4000     27M   288.5 usec

Turning off restarts shrinks the file, and increases lookup time.

For $REASONS, I favor a larger block size in some cases, even though
the lookup times get worse. For example, being able to use 64k/64 may
be a sweet spot for that particular IO system I mentioned above.

Fun fact: gzip packed-refs for this data set is 27M. The 64k/256 is
only 432 KiB larger than gzip (default compression).


> Likewise
> some bits are optional for very small reftable files to reduce overhead.
> But if you have very small reftables, it's going to be fast either way.
> If you waste 4K to store 200 bytes, that's fine

Not really. I store a lot of very small pack files, the 1k idx v2
header is pretty annoying for these. It dwarfs the rest of the
information, in cases it dwarfs the pack file itself. Not being able
to forgo the fanout table when you have a pack of 4 objects of 3 trees
and 1 commit is pretty damn annoying.

> as long as you're still
> wasting only 4K when you store 200 megabytes.

I don't think this is fair. Its better thought of as a ratio.

It depends on the parameters to the writer, but reftable was "wasting"
anywhere between 20K-44K of NUL byte padding for the various
experiments above, and the index was anywhere from 12K-185K, depending
on the block size (smaller block size == larger index).

Wasting 44K on padding, 12K on index, to compress 62M down to 27M...
a penalty of 0.2% of that 27M. That seems acceptable.

5 refs in reftable is ~204 bytes, because of the optional features
being disabled on small files. If reftable was forced to fill out to a
full 4K block, that is a penalty of 1907%. This might seem like
nothing, but for cases where the table has to travel on the network,
or is being stored in a tail-block-optimized filesystem, its a huge
waste to pad the file out.


> I also realize that beggars can't be choosers. If you have a working
> system that performs well, I should consider shutting up. :)

I have it in Java for JGit; I don't yet have a C implementation.


> One thing I didn't see is reflogs. They don't strictly have to be part
> of a ref-storage solution. But they do still consume at least one inode
> per ref in the current system. If you reflog everything, which in my
> opinion you should. Having an audit trail of ref updates is very useful
> for debugging (both bugs in Git, and trying to figure out what went
> wrong when a user goes berserk with "git push --prune").

Yea, I glossed over that and ignored them. Mostly because one system
where I want to use reftable already has a separate database handling
the reflogs. In another (Gerrit Code Review), we disable reflogs for
the insane refs/changes/ namespace, as nearly every reference is
created once, and never modified.

One could abuse the reftable format to store a reflog. If the refname
field is just a sequence of bytes, one could store keys like refname +
'\0' + timestamp, and reuse the symbolic ref value format to store the
old/new/message, as its just a length delimited string.

I'm loath to allocate more bits to denote a reflog entry vs. ref entry
in the same file, but I could see some advantages to that. Commits
would only have to write one new reftable for the combined update +
log record.
