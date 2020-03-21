Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F60C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 07:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A7D20739
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 07:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgCUHDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 03:03:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:46036 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728005AbgCUHDe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 03:03:34 -0400
Received: (qmail 10859 invoked by uid 109); 21 Mar 2020 07:03:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Mar 2020 07:03:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16090 invoked by uid 111); 21 Mar 2020 07:13:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Mar 2020 03:13:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 21 Mar 2020 03:03:33 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200321070333.GB1441446@coredump.intra.peff.net>
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200321061141.GA30636@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 12:11:41AM -0600, Taylor Blau wrote:

> Sure. I'm running best-of-five on the time it takes to re-generate and
> merge a commit-graph based on in-pack commits.
> 
> The script is (in linux.git):
> 
>   $ best-of-five \
>       -p 'rm -rf .git/objects/info/commit-graph{,s/}; git commit-graph write --split=no-merge 2>/dev/null' \
>       git commit-graph write --split=merge-all

If I build Git without your patch and run the "--split=merge-all"
command under a debugger, and then break on parse_object() I find that
all of the commits are already parsed. This happens in
close_reachable().

So we weren't actually reading all of the commits even under the old
code. We were just going into deref_tag(), seeing that the object is
already parsed, and then quickly returning when we see that we already
have an OBJ_COMMIT. I suspect most of your timing differences are mostly
noise.

Perhaps a more interesting case is when you're _not_ adding all of the
existing packed commits as input. There we'd feed only a few objects to
close_reachable(), and it would stop traversing as soon as it hits a
parent that's already in a graph file. So most of the existing objects
would remain unparsed.

I'm not sure how to do that, though. Saying "--input=none" still puts
all of those existing graphed objects into the list of oids to include.
I think you'd need a case where you were legitimately only adding a few
commits, but the merge rules say we need to create one big commit-graph
file.

I guess --input=stdin-commits is a good way to simulate that. Try this
(assuming there's already a split-graph file with all of the commits in
it):

  git rev-parse HEAD >input
  time git commit-graph write --input=stdin-commits --split=merge-all <input

Without your patch on linux.git I get:

  real	0m11.713s
  user	0m11.349s
  sys	0m0.341s

but with it I get:

  real	0m2.305s
  user	0m2.177s
  sys	0m0.100s

A more realistic case would probably be feeding a new small pack to
--input=stdin-packs.

> But, here's where things get... Bizarre. I was trying to come up with a
> way to do fewer things and spend proportionally more time in
> 'merge_commit_graphs', so I did something like:
> 
>   - Generate a pack containing a single, empty commit.
>   - Generate a split commit-graph containing commits in the single large
>     pack containing all of history.
>   - Generate a commit-graph of the small pack, and merge it with the
>     large pack.
> 
> That script is:
> 
>   $ git --version
>   $ git commit -m "empty" --allow-empty
>   $ pack="pack-$(git rev-parse HEAD | git pack-objects .git/objects/pack/pack).idx"
>   $ best-of-five \
>       -p "rm -rf .git/objects/info/commit-graphs && cp -r .git/objects/info/commit-graphs{.bak,}" \
>       sh -c "echo $pack | git commit-graph write --split=merge-all"

I think you'd need --stdin-packs in the actual timed command?

At any rate, I think there is a demonstrable speedup there. But
moreover, I'm pretty sure this existing code is not doing what it
expects:

  /* only add commits if they still exist in the repo */
  result = lookup_commit_reference_gently(ctx->r, &oid, 1);

That won't look at the object database at all if the commit is already
marked as parsed. And that parsing might have come from the commit graph
itself, as our earlier attempts showed. So switching to a real
has_object_file() call is an important _correctness_ fix, even leaving
aside the speed improvements.

-Peff
