Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A80320248
	for <e@80x24.org>; Sat, 20 Apr 2019 03:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfDTD62 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 23:58:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:35726 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725911AbfDTD62 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 23:58:28 -0400
Received: (qmail 10346 invoked by uid 109); 20 Apr 2019 03:58:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 20 Apr 2019 03:58:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15066 invoked by uid 111); 20 Apr 2019 03:58:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Apr 2019 23:58:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Apr 2019 23:58:25 -0400
Date:   Fri, 19 Apr 2019 23:58:25 -0400
From:   Jeff King <peff@peff.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Resolving deltas dominates clone time
Message-ID: <20190420035825.GB3559@sigill.intra.peff.net>
References: <259296914.jpyqiltySj@mfick-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <259296914.jpyqiltySj@mfick-lnx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 19, 2019 at 03:47:22PM -0600, Martin Fick wrote:

> I have been thinking about this problem, and I suspect that this compute time 
> is actually spent doing SHA1 calculations, is that possible? Some basic back 
> of the envelope math and scripting seems to show that the repo may actually 
> contain about 2TB of data if you add up the size of all the objects in the 
> repo. Some quick research on the net seems to indicate that we might be able 
> to expect something around 500MB/s throughput on computing SHA1s, does that 
> seem reasonable? If I really have 2TB of data, should it then take around 
> 66mins to get the SHA1s for all that data? Could my repo clone time really be 
> dominated by SHA1 math?

That sounds about right, actually. 8GB to 2TB is a compression ratio of
250:1. That's bigger than I've seen, but I get 51:1 in the kernel.

Try this (with a recent version of git; your v1.8.2.1 won't have
--batch-all-objects):

  # count the on-disk size of all objects
  git cat-file --batch-all-objects --batch-check='%(objectsize) %(objectsize:disk)' |
  perl -alne '
    $repo += $F[0];
    $disk += $F[1];
    END { print "$repo / $disk = ", $repo/$disk }
  '

250:1 isn't inconceivable if you have large blobs which have small
changes to them (and at 8GB for 8 million objects, you probably do have
some larger blobs, since the kernel is about 1/8th the size for the same
number of objects).

So yes, if you really do have to hash 2TB of data, that's going to take
a while. "openssl speed" on my machine gives per-second speeds of:

type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes  16384 bytes
sha1            135340.73k   337086.10k   677821.10k   909513.73k  1007528.62k  1016916.65k

So it's faster on bigger chunks, but yeah 500-1000MB/s seems like about
the best you're going to do. And...

> I mention 1.8.2.1 because we have many old machines which need this. However, 
> I also tested this with git v2.18 and it actually is much slower even 
> (~140mins).

I think v2.18 will have the collision-detecting sha1 on by default,
which is slower. Building with OPENSSL_SHA1 should be the fastest (and
are those numbers above). Git's internal (but not collision detecting)
BLK_SHA1 is somewhere in the middle.

> Any advice on how to speed up cloning this repo, or what to pursue more 
> in my investigation?

If you don't mind losing the collision-detection, using openssl's sha1
might help. The delta resolution should be threaded, too. So in _theory_
you're using 66 minutes of CPU time, but that should only take 1-2
minutes on your 56-core machine. I don't know at what point you'd run
into lock contention, though. The locking there is quite coarse.

We also hash non-deltas while we're receiving them over the network.
That's accounted for in the "receiving pack" part of the progress meter.
If the time looks to be going to "resolving deltas", then that should
all be threaded.

If you want to replay the slow part, it should just be index-pack. So
something like (with $old as a fresh clone of the repo):

  git init --bare new-repo.git
  cd new-repo.git
  perf record git index-pack -v --stdin <$old/.git/objects/pack/pack-*.pack
  perf report

should show you where the time is going (substitute perf with whatever
profiling tool you like).

As far as avoiding that work altogether, there aren't a lot of options.
Git clients do not trust the server, so the server sends only the raw
data, and the client is responsible for computing the object ids. The
only exception is a local filesystem clone, which will blindly copy or
hardlink the .pack and .idx files from the source.

In theory there could be a protocol extension to let the client say "I
trust you, please send me the matching .idx that goes with this pack,
and I'll assume there was no bitrot nor trickery on your part". I
don't recall anybody ever discussing such a patch in the past, but I
think Microsoft's VFS for Git project that backs development on Windows
might do similar trickery under the hood.

-Peff
