From: Geert Bosch <bosch@adacore.com>
Subject: Re: RFC: New diff-delta.c implementation
Date: Mon, 24 Apr 2006 11:19:01 -0400
Message-ID: <20060424151901.GA2663@adacore.com>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com> <444A2334.3030501@lsrfire.ath.cx> <20060424025741.GA636@adacore.com> <Pine.LNX.4.64.0604232327500.3603@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 24 17:19:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FY2qI-0003ZO-TM
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 17:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWDXPTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 11:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWDXPTK
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 11:19:10 -0400
Received: from nile.gnat.com ([205.232.38.5]:9879 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S1750749AbWDXPTJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Apr 2006 11:19:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 21FD348CED0;
	Mon, 24 Apr 2006 11:19:02 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 24320-01-3; Mon, 24 Apr 2006 11:19:01 -0400 (EDT)
Received: by nile.gnat.com (Postfix, from userid 4190)
	id EDE4048CDC2; Mon, 24 Apr 2006 11:19:01 -0400 (EDT)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604232327500.3603@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19095>

On Mon, Apr 24, 2006 at 01:27:07AM -0400, Nicolas Pitre wrote:
> I took the liberty of reworking the coding style, as well as simplifying 
> some constructs a bit.
> 
> I also fixed all the format encoding and size computations bugs the 
> original code has so it works perfectly now.
Thanks for fixing that! I'll have a more detailed look at your
changes later, as not all changes are immediately obvious since the
formatting is different.
> Note that the GIT encoding is itself different (a bit denser) from the 
> xdiff encoding.
OK, I mostly looked a patch-delta.c to reverse engineer the format,
and mainly looked at libxdiff in the hope to find some format description
there.
> Please just completely drop that word fetch "optimization".  Not only 
> does it produce worse assembly code in the end due to the extra loop 
> counter and extra shifting in turn increasing register pressure, but it 
> also assumes that the target data buffer is always word aligned which is 
> not guaranteed (casting a char pointer to an unsigned and dereferencing 
> it is not portable since on some architecture such misaligned accesses 
> are not allowed).  And it even has worse performance.  For example, with 
> word fetch and shift code, packing the Linux kernel archive on my P4 at 
> 3GHz:

> user    6m33.797s
[vs.]
> user    6m13.911s
> So you must be extremely careful when trying to implement such kind of 
> optimizations.

As a compiler writer, I am more than aware of this. 
Your change results in a 70% slowdown on PowerPC. On many targets
byte-accesses are relatively slow. Indeed, I had expect this to be
mostly neutral on x86, and the 5% slowdown you saw is not unexpected.
Note that in this case aligned accesses are guaranteed, because the
index_step is guaranteed to be a multiple of the word size.

> But here comes the sad part.  Even after simplifying the code as much as 
> I could, performance is still significantly worse than the current 
> diff-delta.c code.  Repacking again the same Linux kernel repository 
> with the current code:
That's unexpected, but I can see how this could be if most files have
very few differences and are relatively small. For such cases, almost
any hash will do, and the more complicated hashing will be more compute
intensive.


I have benchmarked my original diff code on a set of large files with
lots of changes. These are hardest to get right, and hardest to get
good performance with. Just try diffing any two large (uncompressed)
tar files, and you'll see. On many of such large files, the new code
is orders of magnitude faster. On these cases, the resulting deltas
are also much smaller.

The comparison is a bit between a O(n^2) sort that is fast on small
or mostly sorted inputs (but horrible on large ones) and a more
complex O(nlogn) algorithm that is a bit slower for the simple
cases, but far faster for more complex cases.

> In the mean time I'll try replacing the adler32 hashing with your Rabin 
> polynomial hashing into the current code just to see if it helps (and I 
> think it will help quite a bit).  The best solution might be a mix of 
> both approaches.
I think the most interesting part of my code is in process_copies.
This optimization results in elimination of about half the commands
in large test cases, while taking virtually no time at all.
Also, I believe that any form of hash chaining of secondary hashing
is useless. I have done many benchmarks, and in all cases a slight
increase of hash table size was both more effective for pack size and
faster due to less cache misses.
> Of course there is the issue of reversing the object matching window 
> logic in pack-object.c to further improve things, but I consider that an 
> orthogonal improvement at this point which both approaches will benefit 
> from anyway.

Right, this will be the most important one for performance for now.

Thanks again for taking the time to look at my code and fixing the
errors in handling the git file format.

  -Geert

PS. Somehow your code had "double line spacing" :)
