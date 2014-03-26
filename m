From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 0/6] reuse deltas found by bitmaps
Date: Wed, 26 Mar 2014 03:22:16 -0400
Message-ID: <20140326072215.GA31739@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Maurer <bmaurer@fb.com>, Siddharth Agarwal <sid0@fb.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 08:22:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSiAJ-0004nU-6d
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 08:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbaCZHWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 03:22:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:47378 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751456AbaCZHWS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 03:22:18 -0400
Received: (qmail 14305 invoked by uid 102); 26 Mar 2014 07:22:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 02:22:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 03:22:16 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245161>

[tl;dr the patch is the same as before, but there is a script to measure
       its effects; please try it out on your repos]

This is a continuation of the discussion here:

  http://thread.gmane.org/gmane.comp.version-control.git/239647

I'll summarize the story so far.

Basically, the problem is that while pack bitmaps make the "Counting
objects" phase of a fetch fast (which in turn makes clones very fast),
they do not help as much for an incremental fetch. One, because we have
a lot fewer objects to count, so there is less for us to speed up there.
And two, we spend a lot more effort on delta compression for a fetch,
because we are often throwing out on-disk deltas that we are not sure
that the other side has.

One common case is that the server side is mostly packed and has
bitmaps, and the fetching client has some subset of its objects, but
wants to bring itself up to the tip. Any delta that the server has on
disk is generally eligible for reuse, because the base is either:

  1. An object that the client already has.

  2. An object that we are going to send as part of the new pack.

However, we quite often do not notice case (1), because we only consider
a subset of the client's objects as "preferred bases" for thin-packing.
The reason for this is that traditionally it was expensive to enumerate
all of the objects we know the client has. But with bitmaps, this is
very cheap. So the basic idea is to better notice which objects the
client has and change our delta reuse and preferred-base rules.

There are three basic strategies I can think of for doing this:

  1. Add every object the client has to the packing list as a preferred
     base.

  2. When considering whether a delta can be reused, check the bitmaps
     to see if the client has the base. If so, allow reuse.

  3. Do (2), but also add the object as a preferred base.

I think that option (1) is probably a bad idea; we'll spend a lot of
time generating a large packing list, and the huge number of objects
will probably clog the delta window.

Option (3) might or might not be a good idea. It would hopefully give us
some relevant subset of the objects to use as preferred bases, in case
other objects also need deltas.

The implementation I'm including here is the one I've shown before,
which does (2). Part of the reason that I'm reposting it before looking
further into these options is that I've written a t/perf script that can
help with the analysis.

I've run it against git.git and linux.git. I'd be curious to see the
results on other repositories that might have different delta patterns.

The script simulates a fetch from a fully-packed server by a client who
has not fetched in N days, for several values of N. It measures the time
taken on the server (to run pack-objects), the time taken on the client
(to run index-pack), and the size of the resulting pack. Here are the
results for running it on linux.git (note that the script output has the
tests interleaved, but I've rearranged it here for clarity):

    Test                         origin             HEAD                   
    -----------------------------------------------------------------------
    5311.4: size     (1 days)               1.0M              59.5K -94.1% 
    5311.8: size     (2 days)               1.0M              59.5K -94.1% 
    5311.12: size     (4 days)              1.1M              67.9K -93.5% 
    5311.16: size     (8 days)              1.5M             130.1K -91.4% 
    5311.20: size    (16 days)              3.7M             359.8K -90.3% 
    5311.24: size    (32 days)              8.6M               1.4M -84.3% 
    5311.28: size    (64 days)             68.3M              23.0M -66.3% 
    5311.32: size   (128 days)             83.1M              35.1M -57.7% 

You can see that it produces much smaller packs, because we're getting
better delta reuse (and bitmaps don't generally produce preferred bases
at all, so we were probably failing to make thin packs at all). The
percentage benefit lessens as we go further back, of course, because the
thin objects will be at the "edge" of the pack (and the bigger the pack,
the less of it is edge).

So far so good...here are the server timings:

    Test                         origin             HEAD                   
    -----------------------------------------------------------------------
    5311.3: server   (1 days)    0.29(0.33+0.03)    0.14(0.11+0.02) -51.7% 
    5311.7: server   (2 days)    0.29(0.33+0.04)    0.14(0.11+0.02) -51.7% 
    5311.11: server   (4 days)   0.29(0.32+0.04)    0.14(0.11+0.02) -51.7% 
    5311.15: server   (8 days)   0.36(0.45+0.04)    0.14(0.11+0.02) -61.1% 
    5311.19: server  (16 days)   0.74(1.17+0.05)    0.26(0.23+0.02) -64.9% 
    5311.23: server  (32 days)   1.38(2.53+0.06)    0.29(0.25+0.03) -79.0% 
    5311.27: server  (64 days)   7.12(15.70+0.18)   0.43(0.38+0.07) -94.0% 
    5311.31: server (128 days)   7.60(16.72+0.19)   0.52(0.48+0.07) -93.2% 

Again, looking good. We're cutting out the whole delta-search phase on
the server, because we can reuse all of our deltas. Note that these
measurements represent the optimal case: a fully packed repository with
a client that wants every object we have. So we should get full delta
reuse. That also means that this test probably won't show any advantages
for option (3) above, where we would add more preferred bases. We don't
have any candidates for delta compression, so it doesn't matter how many
preferred bases we have.

And here's the bad(ish) news:

    Test                         origin             HEAD                   
    -----------------------------------------------------------------------
    5311.5: client   (1 days)    0.03(0.04+0.00)    0.08(0.07+0.00) +166.7%
    5311.9: client   (2 days)    0.03(0.04+0.00)    0.09(0.08+0.00) +200.0%
    5311.13: client   (4 days)   0.04(0.03+0.01)    0.09(0.08+0.00) +125.0%
    5311.17: client   (8 days)   0.05(0.06+0.00)    0.12(0.11+0.00) +140.0%
    5311.21: client  (16 days)   0.13(0.14+0.00)    0.29(0.28+0.01) +123.1%
    5311.25: client  (32 days)   0.32(0.37+0.01)    0.67(0.66+0.01) +109.4%
    5311.29: client  (64 days)   3.14(4.52+0.19)    6.27(6.50+0.13) +99.7% 
    5311.33: client (128 days)   4.16(6.06+0.23)    7.17(7.86+0.16) +72.4% 

The client has to spend more effort, because it now has to "fix" the
thin pack it receives. But there's a silver lining. Even though the
percent change looks bad, that's only because the client was already
spending much less time than the server. In absolute numbers, we should
come out ahead.

Let's look at the 128-day case as an example.  Before this series, we
spent 7.6s on the server and 4.2s on the client. We sent an 83M pack. If
we assume a 25MBit connection, that's 26.5s of transfer. The total is
38.3s for the whole fetch (this is slightly inaccurate, because
index-pack does some work while the pack is streaming in from the
network, but most of it does happen afterwards).

After the series, we spend only 0.5s on the server, but 7.2s on the
client. Our pack shrinks to 35M, or 11.2s of transfer time. Our total is
now 18.9s (about half).

The other cases show a similar effect, though sometimes less pronounced
(but the very small fetches are already so fast that they are not really
that interesting). Even without the net win in wall-clock time, I think
the reduced server and network load are worth it, but it's nice that it
ends up faster overall, too.

The other interesting thing is to compare CPU and wall-clock time. In
the 128-day case we only saved 7s of wall-clock time, but we saved
almost 17s of CPU time (this is on a HT quad-core machine). On the
client side, we added 3s of wall-clock time, but we spent only 1.8s of
extra CPU time.

This is because most of index-pack is multi-threaded, but the
thin-object resolution is not. So the more thin objects we send, the
less effectively index-pack can use multiple cores. This might be worth
looking into as a next step.

I'd be curious to see numbers for other repositories. I know that Ben
mentioned in our initial discussion that while they saw a server CPU
time improvement on their repo at Facebook, they didn't see the same
pack-size savings.

If you want to run the test yourself, you can either apply these
patches, or fetch from:

  git://github.com/peff/git.git jk/bitmap-reuse-delta

and then run:

  cd t/perf
  export GIT_PERF_REPO=/path/to/your/repo
  ./run origin HEAD p5311-pack-bitmaps-fetch.sh

If you want to re-show the results without re-running the test, you can
do:

  perl aggregate.perl origin HEAD p5311-pack-bitmaps-fetch.sh

-Peff
