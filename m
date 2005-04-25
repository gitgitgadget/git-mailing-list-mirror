From: Klaus Robert Suetterlin <robert@mpe.mpg.de>
Subject: git I/O performance (was: Performance of various compressors)
Date: Mon, 25 Apr 2005 14:17:22 +0200
Message-ID: <20050425121722.GA63026@xdt04.mpe-garching.mpg.de>
References: <426734DE.3040606@timesys.com> <20050422203801.GE7437@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Taht <mike.taht@timesys.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 14:14:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ2Sc-0000wI-Sa
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 14:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVDYMRz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 08:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVDYMRz
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 08:17:55 -0400
Received: from mpehp1.mpe-garching.mpg.de ([130.183.70.10]:63492 "EHLO
	mpehp1.mpe-garching.mpg.de") by vger.kernel.org with ESMTP
	id S262577AbVDYMR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 08:17:29 -0400
Received: from xdt04.mpe-garching.mpg.de (xdt04.mpe-garching.mpg.de [130.183.136.164])
	by mpehp1.mpe-garching.mpg.de (8.9.3 (PHNE_25183+JAGae58098)/8.9.3) with ESMTP id OAA09270;
	Mon, 25 Apr 2005 14:17:23 +0200 (METDST)
Received: (from krs@localhost)
	by xdt04.mpe-garching.mpg.de (8.13.3/8.13.1/Submit) id j3PCHMqV083576;
	Mon, 25 Apr 2005 14:17:22 +0200 (CEST)
	(envelope-from krs)
To: Aaron Lehmann <aaronl@vitelus.com>
Content-Disposition: inline
In-Reply-To: <20050422203801.GE7437@vitelus.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I did some statistics on the freebsd /usr/src/sys directory, as I
did not have access to the linux kernel sources.

This is 5435 Files, of about 81MB (according to du -sh).  I did

find sys/ -type f -exec gzip -9 {} +
find sys/ -type f -exec gzip -d {} +

and similar calls to get an impression how different compression
levels and compressors will act on the data most likely handled by
git backend storage.

On a 700MHz p3, UDMA33, freebsd 5.3, ffs (soft updates) I get:

compressor | levels (size, time to compress, time to uncompress)
-----------+-------------------------------------------------------------------
gzip       | 9 (28M, 1:19, 30), 6 (28M, 31.7, 30), 3 (30M, 26.1, 28.7)
           | 1 (31M, 23.6, 29.8)
bzip2      | 9 (27M, 2:14, 37.4) 6 (27M, 2:11, 38.8) 3 (27M, 2:10, 38.3)
lzop       | 9 (32M, 2:15, 35.4) 7 (32M, 57.9, 40.3) 3 (39M, 36.0, 44.4)


These speeds are for the case that our work set fits into filesystem
caches.  This will be the most common case --- as normal commits will
not checkin the whole tree.

That is.  We should really use gzip -6.  It results in the best
compression at a reasonable time.  bzip2 can't really compress those
tiny files efficiently. lzop is limited by open/close (see below).

BTW. I also did this for the whole /usr/src of freebsd (which is
35000 files and 350MB, du -sh gives 398MB).  The numbers look best
for gzip -6.

The files we work with seem to have an average uncompressed size
of 10-15kB and seem to compress by about a factor of three.

So I did a test in C: open("file%d"), write(file, buf, 10000),
close(file).  I repeated this for 35000 files as in the freebsd src
case, to get some statistics.  The gprof output tells me, that
open+close take the same ammount of time as the write.  (You should
really try do to rm test[0-9]* on those 35000 files :))  I wrote
the full 10000 bytes, to check for the case when we have no compression
at all.  When compression gets better we will become more and more
open/close limited.

This means we are open/close limited in git.  Even if we compress
the files to zero size, we cannot get faster than by a factor of
two!

Earlier messages in this thread showed that we are also limited by
filesytem cache, so we should use compression and efficient prefetch
to get best performance out of it.  Because even if we cannot get
faster than by a factor of two through compression (even delta
compression won't help!  It would make things worse IMHO) we can
get a lot worse (like ten times slower) for large sets on slow
machines with few memory.

I also tried to get a better ratio by using the standard db.h btree
database, so I wouldn't have to open and close all those files.
Unfortunately the btree is about twice as large as the files, so I
had to write twice as much data to disk(800MB).  Also db->put
is much more complicated than write.  So the test ended up taking
about 10% more time, than the open/write/close case.  Maybe in the
case of a smaller work set (i.e. 1000 files instead of 35000) this
might provide faster backend speeds.  Also one could optimise speed
by tweaking the acccess method parameters.


On Fri, Apr 22, 2005 at 01:38:01PM -0700, Aaron Lehmann wrote:
> On Wed, Apr 20, 2005 at 10:06:38PM -0700, Mike Taht wrote:
> > That doing the compression at a level of 3, rather than the max of 9, 
> > cuts the cpu time required for a big git commit by over half, and that 
> > that actually translates into a win on the I/O to disk. (these tests 
> > were performed on a dual opteron 842)
> 
> If (de)compression is slowing things down, you might want to check out
> lzo (http://www.oberhumer.com/opensource/lzo/). I tested it on the
> 2.6.11 kernel source and found that lzo -7 output is only 2% larger
> than gzip -3, but lzo decompression is almost 3 times faster. The
> downside is that lzo took 5 times longer to perform the compression at
> -7. Compression with lzo -3 is 3.5 times faster than gzip -3, but it
> produces a file that's 37% bigger. Unfortunately, lzo has no settings
> in between -3 and -7. I'd expect git to be more sensitive to
> decompression speeds, though.
> 
> BTW, lzo decompression speed is not affected by the compression level.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Robert Suetterlin (robert@mpe.mpg.de)
phone: (+49)89 / 30000-3546   fax: (+49)89 / 30000-3950
