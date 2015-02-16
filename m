From: Jeff King <peff@peff.net>
Subject: Re: Multi-threaded 'git clone'
Date: Mon, 16 Feb 2015 10:03:06 -0500
Message-ID: <20150216150305.GA8279@peff.net>
References: <CACSCj9yoso1oLHzySx1F3O+DFAPiz-XEz1YNCEUMu1pj7KmX7w@mail.gmail.com>
 <alpine.DEB.2.02.1502160521030.23770@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Koosha Khajehmoogahi <koosha.khajeh@gmail.com>,
	git <git@vger.kernel.org>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Mon Feb 16 16:03:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNNCd-00054L-2N
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 16:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbbBPPDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 10:03:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:49550 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753194AbbBPPDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 10:03:09 -0500
Received: (qmail 32585 invoked by uid 102); 16 Feb 2015 15:03:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 09:03:08 -0600
Received: (qmail 15444 invoked by uid 107); 16 Feb 2015 15:03:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 10:03:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2015 10:03:06 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1502160521030.23770@nftneq.ynat.uz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263901>

On Mon, Feb 16, 2015 at 05:31:13AM -0800, David Lang wrote:

> I think it's an interesting question to look at, but before you start
> looking at changing the architecture of the current code, I would suggest
> doing a bit more analisys of the problem to see if the bottleneck is really
> where you think it is.
> 
> First measure, then optimize :-)

Yes, very much so. Fortunately some people have already done some of
this work. :)

On the server side of a clone, the things that must be done before
sending any data are:

  1. Count up all of the objects that must be sent by traversing the
     object graph.

  2. Find any pairs for delta compression (this is the "Compressing
     objects" phase of the progress reporting).

Step (1) naively takes 30-45 seconds for a kernel repo. However, with
reachability bitmaps, it's instant-ish. I just did a clone from
kernel.org, and it looks like they've turned on bitmaps.

For step (2), git will reuse deltas that already exist in the on-disk
packfile, and will not consider new deltas between objects that are
already in the same pack (because we would already have considered them
when packing in the first place). So the key for servers is to keep
things pretty packed. My kernel.org clone shows that they could probably
stand to repack torvalds/linux.git, but it's not too terrible.

This part is multithreaded, so what work we do happens in parallel. But
note that some servers may turn pack.threads down to 1 (since their many
CPUs are kept busy by multiple requests, rather than trying to finish a
single one).

Then the server streams the data to the client. It might do some light
work transforming the data as it comes off the disk, but most of it is
just blitted straight from disk, and the network is the bottleneck.

On the client side, the incoming data streams into an index-pack
process. For each full object it sees, it hashes and records the name of
the object as it comes in. For deltas, it queues them for resolution
after the complete pack arrives.

Once the full pack arrives, then it resolves all of the deltas. This
part is also multithreaded. If you check out "top" during the "resolving
deltas" phase of the clone, you should see multiple cores in use.

So I don't think there is any room for "just multithread it" in this
process. The CPU intensive bits are already multithreaded. There may be
room for optimizing that, though (e.g., reducing lock contention or
similar).

It would also be possible to resolve deltas while the pack is streaming
in, rather than waiting until the whole thing arrives. That's not
possible in all cases (an object may be a delta against a base that
comes later in the pack), but in practice git puts bases before their
deltas. However, it's overall less efficient, because you may end up
walking through the same parts of the delta chain more than once. For
example, imagine you see a stream of objects A, B, C, D. You get B and
see that it's a delta against A. So you resolve it, hash the object, and
are good. Now you see C, which is a delta against B. To generate C, you
have to compute B again. Now you get to D, which is another delta
against B. So now we compute B again.

You can get around this somewhat with a cache of intermediate object
contents, but of course there may be hundreds or thousands of chains
like this in use at once, so you're going to end up with some cache
misses.

What index-pack does instead is to wait until it has all of the objects,
then finds A and says "what objects use A as a base?". Then it computes
B, hashes it, and says "what objects use B as a base?". And finds C and
D, after which it nows it can drop the intermediate result B.

So that's less work over all, though in some workloads it may finish
faster if you were to stream it (because your many processors are
sitting idle while we are blocked on network bandwidth). So that's a
potential area of exploration.

-Peff
