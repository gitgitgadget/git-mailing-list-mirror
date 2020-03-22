Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACCCC4332D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 05:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB7120722
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 05:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCVFgh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 01:36:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:46782 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725825AbgCVFgh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 01:36:37 -0400
Received: (qmail 23344 invoked by uid 109); 22 Mar 2020 05:36:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Mar 2020 05:36:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29677 invoked by uid 111); 22 Mar 2020 05:46:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Mar 2020 01:46:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Mar 2020 01:36:35 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200322053635.GA578498@coredump.intra.peff.net>
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <20200321172716.GA39461@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200321172716.GA39461@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 11:27:16AM -0600, Taylor Blau wrote:

> > I'm not sure how to do that, though. Saying "--input=none" still puts
> > all of those existing graphed objects into the list of oids to include.
> > I think you'd need a case where you were legitimately only adding a few
> > commits, but the merge rules say we need to create one big commit-graph
> > file.
> 
> You have to be careful, since we're taking the reachability closure over
> any commits that you do give. So, one thing you could do to ensure that
> you have an actually small graph is to take something from the output of
> 'git rev-list --max-parents=0 HEAD'.

I don't think you need to be that careful, though. In split-mode,
close_reachable() will stop traversing when it finds a graphed commit.
That's why using the tip of HEAD in my previous example worked.

> To try and reproduce your results, I used '1da177e4c3', which is the
> kernel's first commit in Git. If my interpretation of your setup is
> faithful, it goes something like:
> 
>   $ graphdir=.git/objects/info/commit-graphs
>   $ git rev-parse 1da177e4c3 |
>     git commit-graph write --split=no-merge --stdin-commits
>   $ cp -r "$graphdir{,.bak}"
> 
>   $ best-of-five -p "rm -rf $graphdir && cp -r $graphdir{.bak,}" \
>     'git commit-graph write --split=merge-all'

My case is the opposite, isn't it? Here it looks like you've made a very
_tiny_ commit-graph file (with one commit), and then you're going to end
up adding in all of the new objects. I don't think it would be improved
much by this patch (which makes me very confused by the numbers you got
below).

I also don't think it's that interesting a real-world case.

The more interesting one is where you do already have a big
commit-graph, and want to add just a bit more to it. In the real world,
that might look something like this:

  # create a fake server repo
  git clone --bare . dst.git

  # imagine the server already has everything in a graph file
  git -C dst.git commit-graph write --split=no-merge --reachable

  # and now do a small push
  git commit --allow-empty -m foo
  git push dst.git

  # the server might do an incremental immediately to cover the new
  # objects; here we'll use --stdin-commits with the new data, but a
  # real server might feed the new packfile. We'd probably just use
  # regular --split here in practice, but let's imagine that we're
  # starting to have a lot of graph files, and that triggers a desire to
  # merge. We'll force that state with --split=merge-all.
  git rev-list HEAD^..HEAD |
  git -C dst.git commit-graph write --split=merge-all --stdin-commits

Without your patch, that takes ~11s for me. With it, it takes ~2s.

Another equally interesting case is if the per-push generation _doesn't_
merge anything, and just creates a new, tiny graph file. And then later
we want to do a real maintenance, merging them all done. I think that
would be something like:

  git -C dst.git commit-graph write --input=none --split=merge-all

But that _isn't_ improved by your patch. For the simple reason that all
of the commits will already have been parsed. The "--input=none" option
isn't "no input"; it's actually "take all existing graphed objects as
input" (i.e., it implies --append). So each of those objects will
already have been examined in an earlier stage.

> Where the last step is taking all commits listed in any pack, which is
> cheap to iterate.

I'm not sure it's all that cheap. It has to find the type of every
object in every pack. And finding types involves walking delta chains.
That's something like 7s on my machine for linux.git (compared to the 2s
in which I can just merge down the existing graph files).

> In the above setup, I get something like:
> 
>   git version 2.26.0.rc2.221.ge327a58236
>   Attempt 1: 16.933
>   Attempt 2: 18.101
>   Attempt 3: 17.603
>   Attempt 4: 20.404
>   Attempt 5: 18.871
> 
>   real	0m16.933s
>   user	0m16.440s
>   sys	0m0.472s
> 
> versus:
> 
>   git version 2.26.0.rc2.222.g295e7905ee
>   Attempt 1: 5.34
>   Attempt 2: 4.623
>   Attempt 3: 5.263
>   Attempt 4: 5.268
>   Attempt 5: 5.606
> 
>   real	0m4.623s
>   user	0m4.428s
>   sys	0m0.176s
> 
> which is a best-case savings of ~72.7%, and a savings of ~71.5%. That
> seems much better.

I'm still puzzled by this. In the setup you showed, hardly anything is
graphed. But the change is only in the graph-merge code.

-Peff
