From: Jeff King <peff@peff.net>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Fri, 28 Dec 2012 19:41:05 -0500
Message-ID: <20121229004104.GA24828@sigill.intra.peff.net>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Michael Barr <b@rr-dav.id.au>
X-From: git-owner@vger.kernel.org Sat Dec 29 01:41:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TokUR-0005So-UY
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 01:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755151Ab2L2AlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 19:41:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38283 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755077Ab2L2AlI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 19:41:08 -0500
Received: (qmail 25378 invoked by uid 107); 29 Dec 2012 00:42:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Dec 2012 19:42:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Dec 2012 19:41:05 -0500
Content-Disposition: inline
In-Reply-To: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212278>

On Mon, Nov 26, 2012 at 05:25:54PM +1100, David Michael Barr wrote:

>  The intent is to allow selective recompression of pack data.
>  For small objects/deltas the overhead of deflate is significant.
>  This may improve read performance for the object graph.
> 
>  I ran some unscientific experiments with the chromium repository.
>  With pack.graphcompression = 0, there was a 2.7% increase in pack size.
>  I saw a 35% improvement with cold caches and 43% otherwise on git log --raw.

There wasn't much response to this, but those numbers are encouraging. I
was curious to replicate them, as well as to break it down by trees and
commits. I also wanted to test on more repositories, as well as on both
SSDs and spinning disks (for cold-cache numbers). Maybe that will catch
more people's interest.

As you mentioned in your follow-up, I ran into the "delta size changed"
problem. Not sure if it is related, but I noticed here:

> @@ -379,6 +396,13 @@ static unsigned long write_reuse_object(struct sha1file *f, struct object_entry
>  	offset += entry->in_pack_header_size;
>  	datalen -= entry->in_pack_header_size;
>  
> +	if (!pack_to_stdout &&
> +	    pack_graph_compression_seen &&
> +	    check_pack_compressed(p, &w_curs, offset) != !!compression_level(entry->actual_type)) {
> +		unuse_pack(&w_curs);
> +		return write_no_reuse_object(f, entry, limit, usable_delta);
> +	}
> +

...that we seem to re-compress more than necessary. If I instrument that
block with a message to stderr and run "git repack -ad" repeatedly
without changing the config in between, runs after the first should
never re-compress, right? But they seem to. I'm not sure if your
check_pack_compressed heuristic is off or something else. It may or may
not be related to the "delta sized change" failure.

But we can leave this side a bit for a moment. Conceptually there are
two interesting things going on in your patch:

  1. Per-object-type compression levels

  2. Auto-recompression when levels change.

We can figure out (2) later. The meat of the idea is (1), and the patch
for that is much simpler. In fact, we can test it out with entirely
stock git by creating separate tree, commit, and blob packs, each with
different compression. So that's what I did for my timing, just to keep
things simple.

I timed git.git, linux-2.6.git, and WebKit.git. For each repo, I tested
it with four pack compression scenarios:

  1. all objects at -1 (zlib default)

  2. commits at 0, everything else at -1

  3. trees at 0, everything else at -1

  4. commits and trees at 0, everything else at -1

For each scenario, I timed "git rev-list --count --all" to traverse all
commits (which roughly models things like merge-base, ahead/behind
counts, etc), and then the same thing with "--objects" to traverse all
objects (which would roughly match what "git prune" or the "counting
objects" phase of packing would do). For each command, I timed both warm
and cold disk cache (the latter via "echo 3 >/proc/sys/vm/drop_caches").
Each timing is a best-of-five.  The timings were done on a machine with
an SSD (which probably matters for cold-cache; I have some spinning disk
numbers later).

Here are the git.git numbers:

 Pack  | Size          |  Cold Revs  |  Warm Revs  | Cold Objects | Warm Objects
-------+---------------+-------------+-------------+--------------+--------------
  none |  41.48        | 0.78        | 0.33        |  2.35        |  1.94       
commit |  49.34 (+18%) | 0.57 (-26%) | 0.09 (-74%) |  2.48  (+5%) |  1.70 (-12%)
  tree |  45.43  (+9%) | 0.80  (+3%) | 0.33   (0%) |  2.11  (-9%) |  1.74 (-10%)
  both |  53.31 (+28%) | 0.79  (+1%) | 0.08 (-75%) |  2.27  (-3%) |  1.49 (-23%)

The pack column specifies which scenario (i.e., what was left
uncompressed).  The size column is the size of the object-dir (in
megabytes). The other columns are times to run each command in
wall-clock seconds. Percentages are comparisons to the baseline "none"
case (i.e., the status quo).

So you can see that it's a big win for warm-cache pure-commit
traversals. As a sanity check, we can see that the tree-only case is not
helped at all there (because we do not look at trees at all). The
cold-cache case is helped, too, but that benefit goes away (and even
hurts slightly, but that is probably within the noise) when we also
leave the trees uncompressed.

The full-objects traversal doesn't fare quite as well, though there's
still some improvement. I think it argues for leaving both uncompressed,
as the warm case really benefits when both are uncompressed. You lose
the cold-cache benefits in the revs-only case, though.

Here are the numbers for linux-2.6.git:

 Pack  | Size          |  Cold Revs  |  Warm Revs  | Cold Objects | Warm Objects
-------+---------------+-------------+-------------+--------------+--------------
  none | 864.61        | 8.66        | 4.07        | 42.76        | 36.32       
commit | 970.46 (+12%) | 8.87  (+2%) | 1.02 (-74%) | 42.94   (0%) | 33.43  (-7%)
  tree | 895.37  (+3%) | 9.08  (+4%) | 4.07   (0%) | 36.01 (-15%) | 29.62 (-18%)
  both | 1001.25 (+15%) | 8.90  (+2%) | 1.03 (-74%) | 35.57 (-16%) | 26.25 (-27%)

Similar warm-cache numbers, but the cold cache for the revs-only case is
hurt a little bit more.

And here's WebKit.git (sizes are in gigabytes this time):

 Pack  | Size          |  Cold Revs  |  Warm Revs  | Cold Objects | Warm Objects
-------+---------------+-------------+-------------+--------------+--------------
  none |   3.46        | 1.61        | 1.38        | 20.46        | 18.72       
commit |   3.54  (+2%) | 1.42 (-11%) | 0.34 (-75%) | 20.42   (0%) | 17.57  (-6%)
  tree |   3.59  (+3%) | 1.61   (0%) | 1.39   (0%) | 16.01 (-21%) | 14.00 (-25%)
  both |   3.67  (+6%) | 1.45 (-10%) | 0.34 (-75%) | 15.94 (-22%) | 12.91 (-31%)

Pretty similar again (slightly better on the full object traversal).

And finally, for comparison, here are the numbers from a (much slower)
machine that has spinning disks (albeit in a mirrored raid, which should
improve read times) on git.git:

 Pack  | Size          |  Cold Revs  |  Warm Revs  | Cold Objects | Warm Objects
-------+---------------+-------------+-------------+--------------+--------------
  none |  41.35        | 1.85        | 0.64        |  5.58        |  3.91       
commit |  49.23 (+19%) | 1.94  (+4%) | 0.14 (-77%) |  5.51  (-1%) |  3.40 (-12%)
  tree |  45.27  (+9%) | 1.78  (-3%) | 0.64   (0%) |  5.13  (-8%) |  3.53  (-9%)
  both |  53.16 (+28%) | 1.83  (-1%) | 0.14 (-77%) |  4.96 (-11%) |  3.32 (-14%)

Surprisingly not all that different than the SSD times. Which may mean I
screwed something up. I'm happy to make my test harness available if
anybody else feels like timing on their repos or machines. But it does
point to potentially leaving commits uncompressed, and possibly trees.

I wonder if we could do even better, though. For a traversal, we only
need to look at the commit header. We could potentially do a progressive
inflate and stop before getting to the commit message (which is the bulk
of the data, and the part that is most likely to benefit from
compression).

-Peff
