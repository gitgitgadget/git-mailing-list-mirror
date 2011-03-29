From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git Pack: Improving cache performance (maybe a good GSoC practice)
Date: Tue, 29 Mar 2011 15:45:35 -0700
Message-ID: <AANLkTin6z3hM7nyMqOUPdHrY9TmRVAzpchM+4O=S7KKj@mail.gmail.com>
References: <4D925B63.9040405@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Sebastian Thiel <byronimo@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 00:46:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4hfl-0006iF-UF
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 00:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185Ab1C2Wp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 18:45:56 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37367 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab1C2Wpz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 18:45:55 -0400
Received: by vxi39 with SMTP id 39so588253vxi.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 15:45:55 -0700 (PDT)
Received: by 10.52.169.37 with SMTP id ab5mr510183vdc.283.1301438755132; Tue,
 29 Mar 2011 15:45:55 -0700 (PDT)
Received: by 10.52.166.133 with HTTP; Tue, 29 Mar 2011 15:45:35 -0700 (PDT)
In-Reply-To: <4D925B63.9040405@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170337>

On Tue, Mar 29, 2011 at 15:21, Sebastian Thiel <byronimo@googlemail.com> wrote:
> I am currently working on a c++ implementation of the git core, which for
> now includes reading and writing of loose objects, as well as reading and
> verifying pack files.

Have considered wrapping libgit2 with a C++ binding? Just curious.

> Actually, this is not the first time I do this, as I
> made my first experience in that matter with a pure python implementation of
> the git core (https://github.com/gitpython-developers/gitdb).

I think I saw this the other week... why this project vs. using Dulwich[1]?

[1] http://samba.org/~jelmer/dulwich/

> This time
> though, I wanted to see whether I can achieve better performance, and how I
> can make git more suitable to handle big files.

A noble goal...

> When profiling my initial uncached version of my pack reading
> implementation, I noticed that most of the time was actually spent in zlibs
> inflate method.

Yes. The profile is somewhere in this ballpark if Git is doing
rev-list --objects, aka the "Counting" phase of a git clone:

- 30% in zlib inflate()
- 30% in object map lookup/insertion
- 30% misc. elsewhere

> The major difference turned out to be the way the cache works. Git has a
> small delta cache with only 256 [hardcoded] cache entries and a default
> memory limit of 16mb. There it stores fully decompressed objects. It maps
> objects to entries by hashing their pack offsets into the available range of
> entries.

Right, a very simple cache. FWIW, I've tried to use more complex cache
rules inside of JGit, to no avail. A more complex cache implementation
(e.g. one that supports a limited number of collisions in the hash
buckets and uses a full LRU) runs slow enough relative to this simple
cache that performance actually gets worse.

> When the pack is accessed sequentially, the cache will be filled
> with related uncompressed objects, which can in turn reduce the time
> required to apply the next delta by a huge amount, as only a single delta
> has to be applied instead of a possibly long delta chain.

Yes... mostly.

> As git appears to
> pack deltas of related objects close to each other (regarding their offset
> in the pack),

This isn't true. Git packs object by time, *not* delta ordering.
However objects are delta compressed by commonality on tree path *and*
time. An example repository I like to play with is the linux-2.6
repository; in that repository the pack is around 370 MiB. If you
break the pack up into 1 MiB slices by offset, you will find that an
object at the end of a 50 deep delta chain touches about 50 unique 1
MiB slices in order to build itself up.  :-)

This is caused by things being clustered by both time and path. If a
path is heavily modified within a short time period, sure, those will
be clustered together in the file. But if a path is rarely modified,
its objects will be distributed throughout the file.

> the cache will be hit quite often automatically.

The hit rate happens to work well because most uses access less than
256 distinct similar things at once. I forget what the stats are for
the linux-2.6 repository, but I think there are less than 256 unique
directories. As Git walks through the history sequentially from
most-recent to least-recent, its priming the cache with objects that
have very short delta chains and are thus more likely to be used as
delta bases for objects later in the file. Since each directory or
file acts as a delta base for someone else later, its likely to be in
this cache as the reader walks backwards through time. As bases
switch, the cache is updated at a relatively low penalty, because the
new base was itself recently accessed using the base that is already
in the cache.

The simple % 256 rule the cache uses is effective because objects are
pretty randomly allocated as far as offsets go in the file. We just
damn lucky. :-)

> This cache implementation is clearly suitable for sequential access.

Yes.

> Both cache types are optimized for different kinds of access modes, and both
> are required to efficiently deal with everything git usually has to do.
> Hence I changed my cache to support both modes, and rerun the pack
> verification test.
>
> The result was better than expected, as the my implementation now takes the
> lead by a tiny amount (25.3s vs. 26.0s) with a 16mb cache size. On my way to

This isn't a very significant speed difference given the differences
in implementation. We're not really looking to shave 3% off the
running time for operation X, we're looking to shave >10%.

> make it even faster, I experimented with different cache sizes, amounts of
> entries and of course different packs, which ranged from 20mb to 600mb,
> which helped me fine tune the relations of these variables.
> In the end, with a cache of 27mb, my implementation took 20.6s, whereas the

OK, this is pretty significant. Saving 21% of the running time, at the
expense of an extra 11M of working set.

But the verify pack workload is pretty useless, nobody accesses data
by SHA-1 order. Most uses of Git are going backwards through time. log
and blame are the two notable things that happen *a lot* and that
users complain about being slow. These also aren't random accesses,
there is a definite pattern and the pattern can be exploited. I'm
really only interested in improving these two patterns.

As far as verify-pack improving, Junio improved it by switching to use
index-pack with the new --verify flag. There really isn't a faster way
to scan through a pack than the way index-pack does it.

So, all I'm trying to say is, verify-pack isn't the right thing to
target when you are looking at "how do I make Git faster".

> -- Conclusions --
> * delta cache needs to deal with random and sequential access.

I'm not sure where the random access case is coming from. Who is doing
random access except verify-pack?

> * current implementation deals with sequential access only, which is only
> suitable for pack verification,

Not true. First, pack verification is horrifically random, since its
by SHA-1 order and not sequential order. Second, every other use of
the pack data is generally sequential in time, because every other use
is starting from the current revisions as found from the refs and
walking backwards in time, which is forwards sequentially in the pack.

-- 
Shawn.
