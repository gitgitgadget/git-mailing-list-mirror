From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Proof-of-concept streamed hashing, demoed in `git
	hash-object`
Date: Tue, 17 Feb 2009 12:33:03 -0500
Message-ID: <20090217173302.GC31297@sigill.intra.peff.net>
References: <0984029E-57D0-4EFA-A060-E0B6FFA77D58@hoskings.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ben Hoskings <ben@hoskings.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:34:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZTqA-0007JG-MO
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 18:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbZBQRdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 12:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752692AbZBQRdJ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 12:33:09 -0500
Received: from peff.net ([208.65.91.99]:52788 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbZBQRdI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 12:33:08 -0500
Received: (qmail 30473 invoked by uid 107); 17 Feb 2009 17:33:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 17 Feb 2009 12:33:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Feb 2009 12:33:03 -0500
Content-Disposition: inline
In-Reply-To: <0984029E-57D0-4EFA-A060-E0B6FFA77D58@hoskings.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110419>

On Wed, Feb 18, 2009 at 12:31:35AM +1000, Ben Hoskings wrote:

> This patch adds a proof-of-concept implementation of streaming SHA1  
> calculation in sha1_file.c, as demoed with `git hash-object <large input 
> file>`. Instead of the command's memory footprint being equal to the input 
> file's size, this caps it at SHA1_CHUNK_SIZE (currently 64MB).

This might be nice to reduce the memory footprint for _some_ operations
that only need to look at the data once, but...

> Capping memory use this easily seems like a win, but then all this code 
> does is stream-calculate a SHA1 and print it to stdout. There seem to be a 
> lot of disparate places throughout the codebase where objects have their 
> SHA1 calculated.

...as you noticed, there are a lot of other places where we need the
whole object. So you are not suddenly making git not suck with a 700MB
file on a 512MB system.

But more importantly, hash-object (via index_fd) already mmaps the input
when it is possible to do so. So on memory-tight systems, won't the OS
already release memory when appropriate (i.e., your virtual size is
large, but the OS is free to optimize what is actually paged in as
appropriate).

I suppose this is an extra hint to the OS that we don't care about past
chunks. On systems which support it, perhaps using madvise with
MADV_SEQUENTIAL would be another useful hint.

> Then again, I presume most of these are working with blobs and not entire 
> files, and hence wouldn't require streaming anyway. (I'm assuming blobs 
> don't grow large enough to warrant it - is that necessarily true?)

Either I don't understand what you are saying here, or you are missing
something fundamental about hwo git works: blobs _are_ entire files.

> On my machine, the original implementation hashed a 700MB file in 5.8sec. 
> My patch does it in 6.2sec with SHA1_CHUNK_SIZE set to 64MB.

Hmph. So it's slower? I'm not sure what the advantage is, then. On a
low-memory machine, the OS's paging strategy should be reasonable,
especially with MADV_SEQUENTIAL (though I haven't tested it). And on a
machine with enough memory, it's slower.

I guess you are evicting fewer pages from other processes on the system
in the meantime.

> +inline void write_sha1_fd_process_chunk(int fd, unsigned long len,
> +                                        unsigned long offset,  
> git_SHA_CTX *c,
> +                                        void *buf)
> +{
> +  buf = xmmap(NULL, len, PROT_READ, MAP_PRIVATE, fd, offset);
> +  git_SHA1_Update(c, buf, len);
> +  munmap(buf, len);
> +}

What is the point of the buf input parameter, which is promptly
overwritten?

> +int hash_sha1_fd(int fd, unsigned long len, const char *type,
> +                 unsigned char *sha1)
> +{
> +	char hdr[32];
> +	int hdrlen;
> +	write_sha1_fd_prepare(fd, len, type, sha1, hdr, &hdrlen);
> +	return 0;
> +}

What is the point of the hdr and hdrlen variables being passed in to
receive values, when we never actually look at them? I would think you
are conforming to an existing interface except that you just added the
function earlier in the patch.

-Peff
