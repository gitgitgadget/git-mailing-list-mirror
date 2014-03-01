From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] repack: add `repack.honorpackkeep` config var
Date: Sat, 1 Mar 2014 01:05:50 -0500
Message-ID: <20140301060550.GB20397@sigill.intra.peff.net>
References: <20140128060954.GA26401@sigill.intra.peff.net>
 <xmqq8uu0mpg8.fsf@gitster.dls.corp.google.com>
 <20140224082459.GA32594@sigill.intra.peff.net>
 <xmqq1tys9vie.fsf@gitster.dls.corp.google.com>
 <20140226101353.GA25711@sigill.intra.peff.net>
 <xmqqr46p39cj.fsf@gitster.dls.corp.google.com>
 <20140227112734.GC29668@sigill.intra.peff.net>
 <xmqqy50wzb2b.fsf@gitster.dls.corp.google.com>
 <20140228085546.GA11709@sigill.intra.peff.net>
 <2E523500-558A-42CF-A761-618DD2821347@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Siddharth Agarwal <sid0@fb.com>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Nasser Grainawi <nasser@codeaurora.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 07:06:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJd44-00058h-Hp
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 07:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbaCAGFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 01:05:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:59191 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750909AbaCAGFw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 01:05:52 -0500
Received: (qmail 21179 invoked by uid 102); 1 Mar 2014 06:05:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Mar 2014 00:05:52 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Mar 2014 01:05:50 -0500
Content-Disposition: inline
In-Reply-To: <2E523500-558A-42CF-A761-618DD2821347@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243043>

On Fri, Feb 28, 2014 at 10:09:08AM -0700, Nasser Grainawi wrote:

> > Exactly. The two features (bitmaps and .keep) are not compatible with
> > each other, so you have to prioritize one. If you are using static .keep
> > files, you might want them to continue being respected at the expense of
> > using bitmaps for that repo. So I think you want a separate option from
> > --write-bitmap-index to allow the appropriate flexibility.
> 
> Has anyone thought about how to make them compatible?

Yes, but it's complicated and not likely to happen soon.

Having .keep files means that you are not including some objects in the
newly created pack. Each bit in a commit's bitmap corresponds to one
object in the pack, and whether it is reachable from that commit. The
bitmap is only useful if we can calculate the full reachability from it,
and it has no way to specify objects outside of the pack.

To fix this, you would need to change the on-disk format of the bitmaps
to somehow reference objects outside of the pack. Either by having the
bitmaps index a repo-global set of objects, or by permitting a list of
"edge" objects that are referenced from the pack, but not included (and
then when assembling the full reachable list, you would have to recurse
across "edge" objects to find their reachable list in another pack,
etc).

So it's possible, but it would complicate the scheme quite a bit, and
would not be backwards compatible with either JGit or C Git.

> We're using Martin Fick's git-exproll script which makes heavy use of
> keeps to reduce pack file churn. In addition to the on-disk benefits
> we get there, the driving factor behind creating exproll was to
> prevent Gerrit from having two large (30GB+) mostly duplicated pack
> files open in memory at the same time. Repacking in JGit would help in
> a single-master environment, but we'd be back to having this problem
> once we go to a multi-master setup.
> 
> Perhaps the solution here is actually something in JGit where it could
> aggressively try to close references to pack files

In C git we don't worry about this too much, because our programs tend
to be short-lived, and references to the old pack will go away quickly.
Plus it is all mmap'd, so as we simply stop accessing the pages of the
old pack, they should eventually be dropped if there is memory pressure.

I seem to recall that JGit does not mmap its packfiles. Does it pread?
In that case, I'd expect unused bits from the duplicated packfile to get
dropped from the disk cache over time. If it loads whole packfiles into
memory, then yes, it should probably close more aggressively.

> , but that still
> doesn't help the disk churn problem. As Peff says below, we would want
> to repack often to get up-to-date bitmaps, but ideally we could do
> that without writing hundreds of GBs to disk (which is obviously worse
> when "disk" is a NFS mount).

Ultimately I think the solution to the churn problem is a packfile-like
storage that allows true appending of deltas. You can come up with a
scheme to allow deltas between on-disk packs (i.e., "thin" packs on
disk). The trick there is handling the dependencies and cycles. I think
you could get by with a strict ordering of packs and a few rules:

  1. An object in a pack with weight A cannot have as a base an object
     in a pack with weight <= A.

  2. A pack with weight A cannot be deleted if there exists a pack with
     weight > A.

But you'd want to also add in a single update-able index over all the
packfiles, and even then you'd still want to pack occasionally (because
you'd end up with deltas on bases going back in time, but you really
prefer your bases to be near the tip of history).

So I am not volunteering to work on it. :)

At GitHub we mostly deal with the churn by throwing more server
resources at it. But we have the advantage of having a very large number
of small-to-medium repos, which is relatively easy to scale up. A small
number of huge repos is trickier.

-Peff
