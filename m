Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DECC71F404
	for <e@80x24.org>; Tue, 20 Mar 2018 05:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbeCTF2a (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 01:28:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:35504 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750941AbeCTF23 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 01:28:29 -0400
Received: (qmail 538 invoked by uid 109); 20 Mar 2018 05:28:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Mar 2018 05:28:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29356 invoked by uid 111); 20 Mar 2018 05:29:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Mar 2018 01:29:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Mar 2018 01:28:27 -0400
Date:   Tue, 20 Mar 2018 01:28:27 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: Why does pack-objects use so much memory on incremental packing?
Message-ID: <20180320052827.GA15813@sigill.intra.peff.net>
References: <20180228092722.GA25627@ash>
 <87fu4ycq7s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fu4ycq7s.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 11:05:59PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Splitting this off into its own thread. Aside from the improvements in
> your repack memory reduction (20180317141033.21545-1-pclouds@gmail.com)
> and gc config (20180316192745.19557-1-pclouds@gmail.com) series's I'm
> wondering why repack takes so much memory to incrementally repack new
> stuff when you leave out the base pack.

I think it's a combination of a few issues:

 1. We do a complete history traversal, and then cull out objects which
    our filters reject (e.g., things in a .keep pack). So you pay for
    all of the "struct object", along with the obj_hash table to look
    them up.

    In my measurements of just "git rev-list --objects --all", that's
    about 25MB for git.git. Plus a few misc things (pending object
    structs for the traversal, etc).

 2. The delta-base cache used for the traversal is a fixed size. So
    that's going to be 96MB regardless of your repo size.

I measured a total heap usage of 130MB for "rev-list --objects --all".
That's not 230, but I'm not sure what you're measuring. If it's RSS,
keep in mind that includes the mmap'd packfiles, too.

Doing a separate "rev-list | pack-objects" should be minorly cheaper
(although it will still have a similar peak cost, since that memory will
just be moved to the rev-list process).

If you _just_ want to pack the loose objects, you could probably do
something like:

  find .git/objects/?? -type f |
  tr -d / |
  git pack-objects .git/objects/pack/pack
  git prune-packed

But you'd get pretty crappy deltas out of that, since the heuristics
rely on knowing the filenames of trees and blobs (which you can only get
by walking the graph).

So you'd do better with something like:

  git rev-list --objects $new_tips --not $old_tips |
  git pack-objects .git/objects/pack/pack

but it's hard to know what "$old_tips" should be, unless you recorded it
last time you did a full repack.

> But no, it takes around 230MB. But thinking about it a bit further:
> 
>  * This builds on top of existing history, so that needs to be
>    read/consulted

Right, I think this is the main thing.

>  * We might be reusing (if not directly, skipping re-comuting) deltas
>    from the existing pack.

I don't think that should matter. We'll reuse deltas if the base is
going into our pack, but otherwise recompute. The delta computation
itself takes some memory, but it should be fairly constant even for a
large repo (it's really average_blob_size * window_size).

So I think most of your memory is just going to the traversal stuff.
Running:

  valgrind --tool=massif git pack-objects --all foo </dev/null
  ms_print massif.out.*

shows 223MB at peak, with 43% of the memory to the delta cache, about
10% to traversal (object structs and hash), 6% to pack revindexes, and
34% for the big packlist array. So for anything focusing on the
packlist, you can at best reclaim 75MB.

I suspect a bigger repository would be more interesting, though, since
the delta cache would remain the same size.

> But I get the same result if after cloning I make an orphan branch, and
> pass all the "do this as cheaply as possible" branches I can find down
> to git-repack:
> 
>     (
>         rm -rf /tmp/git &&
>         git clone git@github.com:git/git.git /tmp/git &&
>         cd /tmp/git &&
>         touch $(ls .git/objects/pack/*pack | sed 's/\.pack$/.keep/') &&
>         git checkout --orphan new &&
>         git reset --hard &&
>         for i in {1..10}
>         do
>             touch $i &&
>             git add $i &&
>             git commit -m$i
>         done &&
>         git tag -d $(git tag -l) &&
>         /usr/bin/time -f %M git repack -A -d -f -F --window=1 --depth=1
>     )
> 
> But the memory use barely changes, my first example used 227924 kb, but
> this one uses 226788.

I think you still had to do the whole history traversal there, because
you have existing refs (the "master" branch, along with refs/remotes) as
well as reflogs.

Try:

  git branch -d master
  git remote rm origin
  rm -rf .git/logs

After that, the repack uses about 5MB.

> Jeff: Is this something ref islands[1] could be (ab)used to do, or have
> I misunderstood that concept?
> 
> 1. https://public-inbox.org/git/20130626051117.GB26755@sigill.intra.peff.net/
>    https://public-inbox.org/git/20160304153359.GA16300@sigill.intra.peff.net/
>    https://public-inbox.org/git/20160809174528.2ydgkhd7ayclat3t@sigill.intra.peff.net/

I think you misunderstood the concept. :)

They are about disallowing deltas between unrelated islands. They
actually require _more_ memory, because you have to storage an island
bitmap for each object (though with some copy-on-write magic, it's not
too bad). But they can never save you memory, since reused deltas are
always cheaper than re-finding new ones.

-Peff
