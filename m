Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39BC91F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 20:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfDVU44 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 16:56:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:37272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726896AbfDVU44 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 16:56:56 -0400
Received: (qmail 5820 invoked by uid 109); 22 Apr 2019 20:56:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Apr 2019 20:56:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2859 invoked by uid 111); 22 Apr 2019 20:57:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 16:57:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 16:56:54 -0400
Date:   Mon, 22 Apr 2019 16:56:54 -0400
From:   Jeff King <peff@peff.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Resolving deltas dominates clone time
Message-ID: <20190422205653.GA30286@sigill.intra.peff.net>
References: <259296914.jpyqiltySj@mfick-lnx>
 <20190420035825.GB3559@sigill.intra.peff.net>
 <16052712.dFCfNLlQnN@mfick-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16052712.dFCfNLlQnN@mfick-lnx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 02:21:40PM -0600, Martin Fick wrote:

> > Try this (with a recent version of git; your v1.8.2.1 won't have
> > --batch-all-objects):
> > 
> >   # count the on-disk size of all objects
> >   git cat-file --batch-all-objects --batch-check='%(objectsize)
> > %(objectsize:disk)' | perl -alne '
> >     $repo += $F[0];
> >     $disk += $F[1];
> >     END { print "$repo / $disk = ", $repo/$disk }
> >   '
> 
> This has been running for a few hours now, I will update you with results when 
> its done.

Hours? I think something might be wrong. It takes 20s to run on
linux.git.

> > 250:1 isn't inconceivable if you have large blobs which have small
> > changes to them (and at 8GB for 8 million objects, you probably do have
> > some larger blobs, since the kernel is about 1/8th the size for the same
> > number of objects).
> 
> I think it's mostly xml files in the 1-10MB range.

Yeah, I could believe that would do it, then. Take a 10MB file with a
hundred 1K updates. That'd be 99*1K + 10MB to store, for almost 100:1
compression.

The key is really having objects where the size of change versus the
file size is small (so the marginal cost of each revision is small), and
then having lots of changes (to give you a big multiplier).

> > So yes, if you really do have to hash 2TB of data, that's going to take
> > a while.
> 
> I was hoping I was wrong. Unfortunately I sense that this is not likely 
> something we can improve with a better algorithm. It seems like the best way 
> to handle this long term is likely to use BUP's rolling hash splitting, it 
> would make this way better (assuming it made objects small enough). I think it 
> is interesting that this approach might end up being effective for more than 
> just large binary file repos. If I could get this repo into bup somehow, it 
> could potentially show us if this would drastically reduce the index-pack 
> time.

It fundamentally can't help without changing Git's object model, since
you need to have complete hashes of all of those files. If you're
proposing to do rolling hashes to split blobs into multiple objects that
would definitely work. But it wouldn't be compatible with Git anymore.

> > If you don't mind losing the collision-detection, using openssl's sha1
> > might help. The delta resolution should be threaded, too. So in _theory_
> > you're using 66 minutes of CPU time, but that should only take 1-2
> > minutes on your 56-core machine. I don't know at what point you'd run
> > into lock contention, though. The locking there is quite coarse.
> 
> I suspect at 3 threads, seems like the default?

Ah, right, I forgot we cap it at 3 (which was determined experimentally,
and which we more or less attributed to lock contention as the
bottleneck). I think you need to use $GIT_FORCE_THREADS to override it.

> I am running some index packs to test the theory, I can tell you already that 
> the 56 thread versions was much slower, it took 397m25.622s. I am running a 
> few other tests also, but it will take a while to get an answer. Since things 
> take hours to test, I made a repo with a single branch (and the tags for that 
> branch) from this bigger repo using a git init/git fetch. The single branch 
> repo takes about 12s to clone, but it takes around 14s with 3 threads to run 
> index-pack, any ideas why it is slower than a clone?

Are you running it in the same repo, or in another newly-created repo?
Or alternatively, in a new repo but repeatedly running index-pack? After
the first run, that repo will have all of the objects. And so for each
object it sees, index-pack will say "woah, we already had that one;
let's double check that they're byte for byte identical" which carries
extra overhead (and probably makes the lock contention way worse, too,
because accessing existing objects just has one big coarse lock).

So definitely do something like:

  for threads in 1 2 3 4 5 12 56; do
	rm -rf repo.git
	git init --bare repo.git
	GIT_FORCE_THREADS=$threads \
	  git -C repo.git index-pack -v --stdin </path/to/pack
  done

to test.

> Perhaps the locking can be improved here to make threading more effective?

Probably, but easier said than done, of course.

> > We also hash non-deltas while we're receiving them over the network.
> > That's accounted for in the "receiving pack" part of the progress meter.
> > If the time looks to be going to "resolving deltas", then that should
> > all be threaded.
> 
> Would it make sense to make the receiving pack time also threaded because I
> believe that time is still longer than the I/O time (2 or 3 times)?

It's a lot harder to thread since we're eating the incoming bytes. And
unless you're just coming from a local disk copy, the network is
generally the bottleneck (and if you are coming from a local disk copy,
then consider doing a local clone which will avoid all of this hashing
in the first place).

-Peff
