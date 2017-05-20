Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51B01201CF
	for <e@80x24.org>; Sat, 20 May 2017 08:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754894AbdETID0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 04:03:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:55142 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753617AbdETIDR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 04:03:17 -0400
Received: (qmail 17060 invoked by uid 109); 20 May 2017 08:03:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 20 May 2017 08:03:14 +0000
Received: (qmail 315 invoked by uid 111); 20 May 2017 08:03:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 20 May 2017 04:03:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 May 2017 04:03:12 -0400
Date:   Sat, 20 May 2017 04:03:12 -0400
From:   Jeff King <peff@peff.net>
To:     Chris West <solo-git-vger@goeswhere.com>
Cc:     git@vger.kernel.org
Subject: Re: die("bad object.. for duplicate tagged tag in remote
Message-ID: <20170520080312.nwb277swvmpq7iq6@sigill.intra.peff.net>
References: <20170519172856.GA14673@blind.goeswhere.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519172856.GA14673@blind.goeswhere.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 19, 2017 at 06:28:56PM +0100, Chris West wrote:

> If you have an annotated tag of an annotated tag, and `remote update`
> elects not to fetch this tag (perhaps because it has a name collision
> locally), then the repo ends up corrupt: you can't gc it, but fsck
> doesn't notice.
> 
> Two repos, named "bad" and "good":
> [...]

What version of git are you using? If I run this script:

-- >8 --
#!/bin/sh

rm -rf good bad

git init bad
cd bad
git commit --allow-empty -m bad
git tag -m 'bad inner' inner
git tag -m 'bad outer' outer inner
outer=$(git -C ../bad rev-parse outer)
inner=$(git -C ../bad rev-parse inner)
git tag -d inner
cd ..

git init good
cd good
git commit --allow-empty -m good
git tag -m 'good outer' outer
git remote add bad ../bad
git fetch bad

echo "===> outer is $outer"
git cat-file tag $outer

echo "===> inner is $inner"
git cat-file tag $inner
-- >8 --

then prior to Git v2.10.1, the final cat-file fails. But after it is
fine. This is due to b773ddea2 (pack-objects: walk tag chains for
--include-tag, 2016-09-05), which dealt with this exact tag-of-tag case.

In the real world, it would depend on which version of Git the server is
running (the fix is on the pack-objects side).

There's another interesting thing going on with the fsck/gc thing,
though. The fetching repo isn't actually corrupt. The guarantee that Git
makes is that we have the complete graph of anything that's reachable
from a ref, not that we might not have stray objects (though it does try
to avoid breaking even unreachable parts of history, as I'll explain in
a moment). And that's what's happening here; the client gets "outer" but
it's not actually reachable.

So what happens in your case in more detail is:

  1. git-fetch sends the include-tag capability to the server, asking it
     to include tags that point to whatever we're fetching (master in
     this case)

  2. The server sees that "outer" eventually points to what the client
     is fetching and adds it. It doesn't do the same for "inner" because
     it no longer has a tag ref pointing at it. And because it is
     pre-v2.10.1, it doesn't walk the full chain of "outer", and so
     never considers "inner" at all.

  3. The next step would normally be for git-fetch to realize that it's
     missing an object and backfill tags with a followup request. But
     since it already has its own unrelated "outer", it knows it doesn't
     need "outer" and doesn't bother looking at it.

     So now we have "outer" in the object store (because the server
     thought we might need it), but we never actually pointed a ref at
     it.

And that explains your fsck result:

> $ git fsck
> ...
> dangling tag 07070...

We have the object, but nobody points to it.

> I actually don't get that on the real repo, but do on this testcase. Hmm.
> `git fsck` exits with success here. This is bad, as the object graph is
> incomplete?

No, that outcome is correct. The interesting thing is that your
real-world case probably _does_ have a ref pointing at it (if it's not
getting a dangling-tag). I don't know how that got there, though. The
original case that motivated the fix in v2.10.1 was cloning with a
single branch, like:

  git clone --single-branch --no-local bad broken

but that results in the clone failing, not a corrupt repo. Is it
possible you or somebody else then ran something like:

  git update-ref refs/tags/other-outer $outer_sha1

after the fetch? That would reference the broken part of the graph, and
the repository is corrupt at that point.

> $ git gc
> fatal: bad object 03030303...
> error: failed to run repack

So this is where I think there might be room for improvement, even with
current versions of git.  Traditionally, we wouldn't try to traverse or
pack that unreferenced part of the object graph. But since v2.2.0, we
traverse any objects that are "recent" (within the 2-week
prune-expiration timestamp) to try to keep whole chunks of the graph
intact (ironically, to prevent problems like the update-ref I showed
above).

We use the "ignore_missing_links" flag to tell the traversal that this
is best-effort (i.e., we try to retain unreachable history if we can,
but if it's already broken there's nothing we can do). So I wouldn't be
surprised to find that we correctly respect that flag when following
parent and tree links, but not in tags.

> diff --git a/revision.c b/revision.c
> index 8a8c178..22b6021 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -232,7 +232,8 @@ static struct commit *handle_commit(struct rev_info *revs,
>  		if (!object) {
>  			if (flags & UNINTERESTING)
>  				return NULL;
> -			die("bad object %s", oid_to_hex(&tag->tagged->oid));
> +			die("bad tagged object %s in %s", oid_to_hex(&tag->tagged->oid),
> +						oid_to_hex(&tag->object.oid));
>  		}

I agree this is an improvement. And that "if" in the context lines is
almost certainly the culprit. It should also trigger when
revs->ignore_missing_links is set.

-Peff
