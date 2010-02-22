From: Zygo Blaxell <zblaxell@gibbs.hungrycats.org>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Mon, 22 Feb 2010 12:31:22 -0500
Message-ID: <20100222173122.GG11733@gibbs.hungrycats.org>
References: <20100214011812.GA2175@dpotapov.dyndns.org> <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org> <20100219082813.GB17952@dpotapov.dyndns.org> <7v635tkta7.fsf@alter.siamese.dyndns.org> <7v8waniue8.fsf@alter.siamese.dyndns.org> <20100221072142.GA5829@dpotapov.dyndns.org> <7vhbpas7ut.fsf@alter.siamese.dyndns.org> <20100222033553.GA10191@dpotapov.dyndns.org> <7vwry5pxg8.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1002221033120.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 18:31:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njc82-00082N-7k
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 18:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab0BVRbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 12:31:25 -0500
Received: from ip-70-38-54-39.static.privatedns.com ([70.38.54.39]:41639 "EHLO
	ginevra.hungrycats.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752471Ab0BVRbY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 12:31:24 -0500
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
Received: from gibbs.hungrycats.org (gibbs.vpn7.hungrycats.org [10.132.226.42])
	by ginevra.hungrycats.org (Postfix) with ESMTP id 11DBB801C;
	Mon, 22 Feb 2010 12:31:23 -0500 (EST)
Received: from zblaxell by gibbs.hungrycats.org with local (Exim 4.69)
	(envelope-from <zblaxell@gibbs.hungrycats.org>)
	id 1Njc7u-0000qS-Uh; Mon, 22 Feb 2010 12:31:22 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002221033120.1946@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140698>

On Mon, Feb 22, 2010 at 10:40:59AM -0500, Nicolas Pitre wrote:
> On Sun, 21 Feb 2010, Junio C Hamano wrote:
> > Dmitry Potapov <dpotapov@gmail.com> writes:
> > > But overall the outcome is clear -- read() is always a winner.
> > 
> > "... a winner, below 128kB; above that the difference is within noise and
> > measurement error"?
> 
> read() is not always a winner.  A read() call will always have the data 
> duplicated in memory.  Especially with large files, it is more efficient 
> on the system as a whole to mmap() a 50 MB file rather than allocating 
> an extra 50 MB of anonymous memory that cannot be paged out (except to 
> the swap file which would be yet another data duplication).  With mmap() 
> when there is memory pressure the read-only mapped memory is simply 
> dropped with no extra IO.

That holds if you're comparing read() and mmap() of the entire file as a
single chunk, instead of in fixed-size chunks at the sweet spot between
syscall overhead and CPU cache size.

If you're read()ing a chunk at a time into a fixed size buffer, and
doing sha1 and deflate in chunks, the data should be copied once into CPU
cache, processed with both algorithms, and replaced with new data from
the next chunk.  The data will be copied from the page cache instead
of directly mapped, which is a small overhead, but setting up the page
map in mmap() also a small overhead, so you have to use benchmarks to
know which of the overheads is smaller.  It might be that there's no
one answer that applies to all CPU configurations.

If you're doing mmap() and sha1 and deflate of a 50MB file in two
separate passes that are the same size as the file, you load 50MB of
data into CPU cache at least twice, you get two sets of associated
things like TLB misses, and if the file is very large, you page it from
disk twice.  So it might make sense to process in chunks regardless
of read() vs mmap() fetching the data.

If you're malloc()ing 50MB, you're wasting memory and CPU bandwidth
making up pages full of zeros before you've even processed the first byte.
I don't see how that could ever be faster for large file cases.
