From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Mon, 22 Feb 2010 13:01:13 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002221238110.1946@xanadu.home>
References: <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <20100219082813.GB17952@dpotapov.dyndns.org>
 <7v635tkta7.fsf@alter.siamese.dyndns.org>
 <7v8waniue8.fsf@alter.siamese.dyndns.org>
 <20100221072142.GA5829@dpotapov.dyndns.org>
 <7vhbpas7ut.fsf@alter.siamese.dyndns.org>
 <20100222033553.GA10191@dpotapov.dyndns.org>
 <7vwry5pxg8.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002221033120.1946@xanadu.home>
 <20100222173122.GG11733@gibbs.hungrycats.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Zygo Blaxell <zblaxell@gibbs.hungrycats.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 19:01:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njcav-0004Ln-JI
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 19:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342Ab0BVSBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 13:01:15 -0500
Received: from relais.videotron.ca ([24.201.245.36]:35605 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972Ab0BVSBO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 13:01:14 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KY90075E8Q1VS70@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 22 Feb 2010 13:01:14 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100222173122.GG11733@gibbs.hungrycats.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140700>

On Mon, 22 Feb 2010, Zygo Blaxell wrote:

> On Mon, Feb 22, 2010 at 10:40:59AM -0500, Nicolas Pitre wrote:
> > On Sun, 21 Feb 2010, Junio C Hamano wrote:
> > > Dmitry Potapov <dpotapov@gmail.com> writes:
> > > > But overall the outcome is clear -- read() is always a winner.
> > > 
> > > "... a winner, below 128kB; above that the difference is within noise and
> > > measurement error"?
> > 
> > read() is not always a winner.  A read() call will always have the data 
> > duplicated in memory.  Especially with large files, it is more efficient 
> > on the system as a whole to mmap() a 50 MB file rather than allocating 
> > an extra 50 MB of anonymous memory that cannot be paged out (except to 
> > the swap file which would be yet another data duplication).  With mmap() 
> > when there is memory pressure the read-only mapped memory is simply 
> > dropped with no extra IO.
> 
> That holds if you're comparing read() and mmap() of the entire file as a
> single chunk, instead of in fixed-size chunks at the sweet spot between
> syscall overhead and CPU cache size.

Obviously.  But we currently don't have the infrastructure to do chunked 
read of the input data.  I think we should do that eventually, by 
applying the pack windowing code to input files as well.  That would 
make memory usage constant even for huge files, but this is much more 
complicated to support especially for data fed through stdin.

> If you're read()ing a chunk at a time into a fixed size buffer, and
> doing sha1 and deflate in chunks, the data should be copied once into CPU
> cache, processed with both algorithms, and replaced with new data from
> the next chunk.  The data will be copied from the page cache instead
> of directly mapped, which is a small overhead, but setting up the page
> map in mmap() also a small overhead, so you have to use benchmarks to
> know which of the overheads is smaller.  It might be that there's no
> one answer that applies to all CPU configurations.

Normally mmap() has more overhead than read().  However mmap() provides 
much nicer properties than read() by simplifying the code a lot, and by 
letting the OS manage memory pressure much more gracefully.

> If you're doing mmap() and sha1 and deflate of a 50MB file in two
> separate passes that are the same size as the file, you load 50MB of
> data into CPU cache at least twice, you get two sets of associated
> things like TLB misses, and if the file is very large, you page it from
> disk twice.  So it might make sense to process in chunks regardless
> of read() vs mmap() fetching the data.

We do have to make two separate passes anyway.  The first pass is to 
hash the data only, and if that hash already exists in the object store 
then we call it done and skip over the deflate process which is still 
the dominant cost.  And that happens quite often.

However, with a really large file, then it becomes advantageous to 
simply do the hash and deflate in parallel one chunk at a time, and 
simply discard the newly created objects if it happens to already 
exists.  That's the whole idea behind the newly introduced 
core.bigFileThreshold config variable (but the code to honor it in 
sha1_file.c doesn't exist yet).

> If you're malloc()ing 50MB, you're wasting memory and CPU bandwidth
> making up pages full of zeros before you've even processed the first byte.
> I don't see how that could ever be faster for large file cases.

It can't.  This is why read() is not much better than mmap() in those 
cases.


Nicolas
