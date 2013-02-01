From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/6] commit caching
Date: Fri, 1 Feb 2013 04:11:30 -0500
Message-ID: <20130201091130.GB30644@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <CAJo=hJtTYZg+1+RZVfEGTgOGzqxQbN1CLYWrvUp+WHKGxGwHMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 01 10:12:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Cf9-0003eB-Mi
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 10:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958Ab3BAJLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 04:11:37 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55313 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755837Ab3BAJLd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 04:11:33 -0500
Received: (qmail 19592 invoked by uid 107); 1 Feb 2013 09:12:57 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 04:12:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 04:11:30 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJtTYZg+1+RZVfEGTgOGzqxQbN1CLYWrvUp+WHKGxGwHMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215221>

On Thu, Jan 31, 2013 at 09:14:26AM -0800, Shawn O. Pearce wrote:

> On Tue, Jan 29, 2013 at 1:14 AM, Jeff King <peff@peff.net> wrote:
> > This is the cleaned-up version of the commit caching patches I mentioned
> > here:
> >
> >   http://article.gmane.org/gmane.comp.version-control.git/212329
> ...
> > The short of it is that for an extra 31M of disk
> > space (~4%), I get a warm-cache speedup for "git rev-list --all" of
> > ~4.2s to ~0.66s.
> 
> I have to admit, this is a nice gain. I don't think users often dig
> through all commits to the root but I can see how this might improve
> git log with a path filter.

It doesn't just help digging to the roots. It should speed up most
traversals. So merge-bases, --contains, etc, would all be better. I
suspect we could also make --topo-order startup a lot faster, too.

It also helps "rev-list --objects --all", though obviously not by as
large a percentage. And since the main use of that is reachability
bitmaps, the improvements aren't as exciting there.

> > Coupled with using compression level 0 for trees (which do not compress
> > well at all, and yield only a 2% increase in size when left
> > uncompressed), my "git rev-list --objects --all" time drops from ~40s to
> > ~25s.
> 
> This uhm.... is nice?
> 
> But consider reachability bitmaps. ~40s to ~80ms. :-)

Yeah, yeah. I'm working my way up to it. :)

I wanted to see first how good we could get with a more generic
approach. I think this work may still have value even with reachability
bitmaps, as it will help regular traversals as well as tree access for
pathspec limiting.

At this point I'm convinced that my 25s is about the best we will do for
reachability analysis with a graph traversal. The repeated hashcmps to
see that we've visited each node are starting to dominate. So the next
obvious step is to try reachability bitmaps. I was hoping to iron out
the "pack metadata goes here" issues with the commit cache stuff,
though, as the actual cache implementation is quite simple (whereas the
bitmap stuff is more on the complex side, but can build on the same
metadata base).

> Yup. I have also futzed with the one in JGit for quite a while now. I
> pull some tricks there like making it a 2 level directory to reduce
> the need to find a contiguous array of 8M entries when processing the
> Linux kernel, and I try to preallocate the first level table based on
> the number of objects in pack-*.idx files. But the bottleneck is
> basically the cache lookups and hits, these happen like 100M times on
> 2M objects, because its every link in nearly every tree.

Right. I tried some multi-level tricks (and even a radix trie), but I
couldn't get anything to beat the simple-and-stupid single hash table
with linear probing.

> If we modified pack-objects' delta compressor for tree objects to only
> generate delta instructions at tree record boundaries, a delta-encoded
> tree can be processed without inflating the full content of that tree.
> Because of the way deltas are created, "most" tree deltas should have
> their delta base scanned by the object traversal before the delta is
> considered. This means the tree delta just needs to consider the much
> smaller records that are inserted into the base. We know these are
> different SHA-1s than what was there before, so they are more likely
> to be new to the lookup_object table.

So sort of a magic shortcut tree diff you get while accessing the
object. Neat idea.

> So the --objects traversal algorithm can change to get the delta base
> SHA-1 and raw tree delta from the pack storage. Perform a
> lookup_object on the base to see if it has been scanned. If it has,
> just scan the delta insert instructions. If the base has not yet been
> scanned, inflate the tree to its normal format and scan the entire
> tree.

This would not perform well if we hit the deltas before the bases. In
general, though, our "use the larger as the base" heuristic should mean
that our traversal hits the bases first.

> This is an approximation of what Nico and I were talking about doing
> for pack v4. But doesn't require a file format change. :-)

Yeah. It just needs to be very careful that the deltas it is looking at
all fall on record boundaries, since we might get deltas generated by
other versions of git. Can we necessarily identify that case for sure,
though?  I imagine a tree delta like that would look something like:

  delete bytes 100-120
  add 20 bytes at offset 100: \x12\x34\x56...

Without looking at the base object, and without knowing whether the
delta was generated by our particular implementation, how can we be sure
this is a sha1 replacement and not the renaming of part of a file? Or
are you proposing some flag in the packfile to indicate "yes, this tree
really was delta'd only at record boundaries"?

It could be a big win, but it does seem quite complex and error-prone.
And it only helps with reachability, not regular traversals, so it's not
very generic. Which makes me think the bitmap route is a much better way
to go.

-Peff
