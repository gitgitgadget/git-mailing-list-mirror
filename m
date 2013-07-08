From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] pack-revindex: radix-sort the revindex
Date: Mon, 8 Jul 2013 03:57:12 -0400
Message-ID: <20130708075712.GC25072@sigill.intra.peff.net>
References: <20130707100133.GA18717@sigill.intra.peff.net>
 <20130707101438.GD19143@sigill.intra.peff.net>
 <CAJo=hJugvqBEQwPYcttNH+R8xUKxy1uDm5EjiWaye-wEuTxk-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 08 09:57:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw6Jz-00031p-7e
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 09:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002Ab3GHH5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 03:57:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:55371 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405Ab3GHH5O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 03:57:14 -0400
Received: (qmail 7968 invoked by uid 102); 8 Jul 2013 07:58:29 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Jul 2013 02:58:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jul 2013 03:57:12 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJugvqBEQwPYcttNH+R8xUKxy1uDm5EjiWaye-wEuTxk-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229828>

On Sun, Jul 07, 2013 at 04:52:23PM -0700, Shawn O. Pearce wrote:

> On Sun, Jul 7, 2013 at 3:14 AM, Jeff King <peff@peff.net> wrote:
> > The pack revindex stores the offsets of the objects in the
> > pack in sorted order, allowing us to easily find the on-disk
> > size of each object. To compute it, we populate an array
> > with the offsets from the sha1-sorted idx file, and then use
> > qsort to order it by offsets.
> >
> > That does O(n log n) offset comparisons, and profiling shows
> > that we spend most of our time in cmp_offset. However, since
> > we are sorting on a simple off_t, we can use numeric sorts
> > that perform better. A radix sort can run in O(k*n), where k
> > is the number of "digits" in our number. For a 64-bit off_t,
> > using 16-bit "digits" gives us k=4.
> 
> Did you try the simple bucket sort Colby now uses in JGit?
> 
> The sort is pretty simple:
> 
>   bucket_size = pack_length / object_count;
>   buckets[] = malloc(object_count * sizeof(int));
> 
>   foreach obj in idx:
>     push_chain(buckets[obj.offset / bucket_size], obj.idx_nth);
> 
>   foreach bucket:
>     insertion sort by offset

I did do something similar (though I flattened my buckets into a single
list afterwards), but I ended up closer to 700ms (down from 830ms, but
with the radix sort around 200ms). It's entirely possible I screwed up
something in the implementation (the bucket insertion can be done in a
lot of different ways, many of which are terrible), but I didn't keep a
copy of that attempt. If you try it and have better numbers, I'd be
happy to see them.

> We observed on linux.git that most buckets have an average number of
> objects. IIRC the bucket_size was ~201 bytes and most buckets had very
> few objects each. For lookups we keep the bucket_size parameter and a
> bucket index table. This arrangement uses 8 bytes per object in the
> reverse index, making it very memory efficient. Searches are typically
> below O(log N) time because each bucket has <log N entries.

I didn't measure lookups at all; I was focused on time to build the
index. So if there were benefits there that make up for a longer setup
time, I wouldn't have measured them (of course, we also care about the
case with few lookups, so it would be a tradeoff). You could also leave
each bucket unsorted and only lazily sort it when a lookup hits the
bucket, which might help that case (I didn't look to see if you do that
in JGit).

-Peff
