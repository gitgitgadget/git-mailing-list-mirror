Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07D4D1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 06:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfG3Ggh (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 02:36:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:55132 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725911AbfG3Ggh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 02:36:37 -0400
Received: (qmail 2319 invoked by uid 109); 30 Jul 2019 06:36:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Jul 2019 06:36:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5145 invoked by uid 111); 30 Jul 2019 06:38:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jul 2019 02:38:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Jul 2019 02:36:35 -0400
From:   Jeff King <peff@peff.net>
To:     16657101987@163.com
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
        gitster@pobox.com, worldhello.net@gmail.com,
        Sun Chao <sunchao9@huawei.com>
Subject: Re: [PATCH v1 1/1] pack-refs: pack expired loose refs to packed_refs
Message-ID: <20190730063634.GA4901@sigill.intra.peff.net>
References: <20190721181739.81110-1-16657101987@163.com>
 <20190721181739.81110-2-16657101987@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190721181739.81110-2-16657101987@163.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 22, 2019 at 02:17:39AM +0800, 16657101987@163.com wrote:

> From: Sun Chao <sunchao9@huawei.com>
> 
> When a packed ref is deleted, the whole packed-refs file is
> rewrite and omit the ref that no longer exists. However if
> another gc command is running and call `pack-refs --all`
> simultaneously, there is a change that a ref just updated
> will lost the newly commits.
> 
> Through these steps, losting commits of newly updated refs
> could be demonstrated:

Thanks for the report and an easy-to-follow recipe. I was able to
reproduce the problem.

>   # step 4: in another terminal, simultaneously update the
>   # master with update-ref, and create and delete an
>   # unrelated ref also with update-ref
>   cd child &&
>   while true; do
>     git commit --allow-empty -m foo &&
>     us=`git rev-parse master` &&
>     pushd ../parent &&
>       git fetch ../child/.git master &&
>       git update-ref refs/heads/newbranch $us &&
>       git update-ref refs/heads/master $us &&
>       git update-ref -d refs/heads/newbranch &&
>       them=`git rev-parse master` &&
>       if test "$them" != "$us"; then
>         echo >&2 "lost commit: $us"
>         exit 1
>       fi
>     popd
>   done

You can do this step without the fetch, which makes it hit the race more
quickly. :) Try this:

  # prime it with a single commit
  git commit --allow-empty -m foo
  while true; do
    us=$(git commit-tree -m foo -p HEAD HEAD^{tree}) &&
    git update-ref refs/heads/newbranch $us &&
    git update-ref refs/heads/master $us &&
    git update-ref -d refs/heads/newbranch &&
    them=$(git rev-parse master) &&
    if test "$them" != "$us"; then
      echo >&2 "lost commit: $us"
      exit 1
    fi
    # eye candy
    printf .
  done

> Though we have the packed-refs lock file and loose refs lock
> files to avoid updating conflicts, a ref will lost its newly
> commits if the situation which is described as racy-git by
> `Documentation/technical/racy-git.txt` happens, it comes like
> this:

I don't think this is quite the same as racy-git. There we are comparing
stat entries for a file X to the timestamp of the index (and we are
concerned they were written in the same second).

But here we have no on-disk stat information to compare to. It's all
happening in-process. But you're right that it's a racy stat-validity
problem.

>   4. Redo the 1th step, after `pack-refs --all` finished, the
>      oid of master in packe-refs file is OID_B, and the loose
>      refs $GIT_DIR/refs/heads/master is removed. Let's say
>      the `pack-refs --all` is very quickly done and the new
>      packed-refs file's modify time is stille DATE_M.
> 
>   5. 3th step now going on, after checking the newbranch, it
>      begin to rewrite the packed-refs file, after get the lock
>      file of packed-ref file, it checks the timestamp of it's
>      snapshot in memory with the packed-refs file's time,
>      they are both the same DATE_M, so the snapshot is not
>      refreshed.

The stat-validity check here is actually more than the timestamp.
Specifically it's checking the inode and size. But because of the
specific set of operations you're performing, this ends up correlating
quite often:

  - because our operations involve updating a single ref or
    adding/deleting another ref, we'll oscillate between two sizes
    (either one ref or two)

  - likewise if nothing else is happening on the filesystem, pack-refs
    may flip back and forth between two inodes (not the same one,
    because our tempfile-and-rename strategy means we're still using the
    old one while we write the new packed-refs file).

So I actually find this to be a fairly unlikely case in the real world,
but as your script demonstrates, it's not that hard to trigger it if
you're trying.

> There are two valid methods to avoid losting commit of ref:
>   - force `update-ref -d` to update the snapshot before
>     rewrite packed-refs.
>   - do not pack a recently updated ref, where *recently*
>     could be set by *pack.looserefsexpire* option.

I'm not sure the second one actually fixes things entirely. What if I
have an older refs/heads/foo, and I do this:

  git pack-refs
  git pack-refs --all --prune

We still might hit the race here. The first pack-refs does not pack foo
(because we didn't say --all), then a simultaneous "update-ref -d" opens
`packed-refs`, then the second pack-refs packs it all in the same
second. Now "update-ref -d" uses the old packed-refs file, and we lose
the ref.

Admittedly this is even more unlikely than your original case, because
it involves quickly running pack-refs in two different modes.

But I think if we want the same solution as racy-git, the timestamp we
want to compare to is not the ref itself, but rather for the
stat-validity code to see if packed-refs has the same timestamp as the
moment when we called stat().

Unfortunately that's hard to do robustly, because the filesystem time
and the OS clock time do not necessarily match up. I don't know of a way
to record the current filesystem time without modifying a file.

I do agree that simply removing the stat-validity check and _always_
re-opening the packed-refs file when we take the lock would work.
Traditionally we avoided that because refreshing it implied parsing the
whole file. But these days we mmap it, so it really is just an extra
open()/mmap() and a quick read of the header. That doesn't seem like an
outrageous cost to pay when we're already taking the lock.

Another option would be to put an increasing counter into the file
header itself. We could then record the old counter instead of the
stat-validity info, and always re-open(), mmap(), and parse the header.
But at that point I don't think it saves anything over just refreshing
the file as above.

So I actually think the best path forward is just always refreshing when
we take the lock, something like:

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index c01c7f5901..0c8fdce7be 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1019,7 +1019,7 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	 * is still valid. We've just locked the file, but it might
 	 * have changed the moment *before* we locked it.
 	 */
-	validate_snapshot(refs);
+	clear_snapshot(refs);
 
 	/*
 	 * Now make sure that the packed-refs file as it exists in the

We could still see an old packed-refs file on reading (somebody packs a
ref and then deletes it, but we still see the old packed-refs), but
that's an inherent race (we can't know that somebody didn't update
packed-refs after we checked its stat, because we're not holding the
lock). It's also just one of many ways that the filesystem ref storage
is not atomic (e.g., renaming X to Y, a reader might see neither ref!).

Ultimately the best solution there is to move to a better format (like
the reftables proposal).

> I prefer **do not pack a recently updated ref**, here is the
> reasons:
> 
>   1. It could avoid losting the newly commit of a ref which I
>      described upon.
> 
>   2. Sometime, the git server will do `pack-refs --all` and
>      `update-ref` the same time, and the two commands have
>      chances to trying lock the same ref such as master, if
>      this happends one command will fail with such error:
> 
>      **cannot lock ref 'refs/heads/master'**
> 
>      This could happen if a ref is updated frequently, and
>      avoid pack the ref which is update recently could avoid
>      this error most of the time.

It can also happen if you simply get unlucky with a ref that isn't
updated frequently. We may pack an older ref, but then collide with
somebody updating the ref when we take the lock to delete the loose
version.

-Peff
