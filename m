From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 12:39:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606291154510.1213@localhost.localdomain>
References: <20060628223744.GA24421@coredump.intra.peff.net>
 <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
 <20060629035849.GA30749@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 18:39:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvzYG-0006aL-8N
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 18:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWF2Qjd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 12:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWF2Qjd
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 12:39:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63596 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750894AbWF2Qjd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 12:39:33 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J1M00AUHRLVGDH0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Jun 2006 12:39:32 -0400 (EDT)
In-reply-to: <20060629035849.GA30749@coredump.intra.peff.net>
X-X-Sender: nico@localhost.localdomain
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22874>

On Wed, 28 Jun 2006, Jeff King wrote:

> >From repack to repack, we end up trying to delta many of the same object
> pairs, which is computationally expensive.  This patch makes a
> persistent cache, $GIT_DIR/delta-cache, which contains pairs of sha1
> hashes (the presence of a pair indicates that it's not worth trying to
> delta those two objects).

I think this could be done differently to be even more space efficient 
as I suggested earlier.

> Here are some of my thoughts:
> 
>  - speed. The implementation is quite fast. The sha1 pairs are stored
>    sorted, and we mmap and binary search them. Certainly the extra time
>    spent in lookup is justified by avoiding the delta attempts.

You do that lookup for every delta match attempt.  Instead it could be 
done once for the whole window attempt, potentially reducing the cache 
size by a factor of 20, and it might be faster too.

>  - size. The cache is a packed sequence of binary sha1 pairs. I was
>    concerned that it would grow too large (obviously for n blobs you can
>    end up with n^2/2 entries), but it doesn't seem unreasonable for most
>    repos (either you don't have a lot of files, or if you do, they delta
>    reasonably well). My test repo's cache is only 144K. The git cache is
>    about 2.7M. The linux-2.6 cache is 22M.

See my previous email for comments about this.

>    Theoretically, I could bound the cache size and boot old entries.
>    However, that means storing age information, which increases the
>    required size. I think keeping it simple is best.

You could simply recreate the cache on each run.  Or just keep a bitmap 
of referenced cache entries, and a list of new entries.  At the end if 
the new entry list is empty and the bitmap is all set (or clear) then 
you just keep the current cache.  ONce, say, more than 10% of cache 
entries are not used anymore then you regenerate the cache.  But since 
you need to regenerate it when new entries are added then the 10% unused 
entry criteria might not be used that often anyway, unless packs shrink 
with time which might not be the case really often.

>  - correctness. Currently the code uses the output of try_delta for
>    negative caching. Should the cache checking be moved inside try_delta
>    instead? This would give more control over which reasons to mark a
>    delta negative (I believe right now hitting the depth limit will
>    cause a negative mark; we should perhaps only do so if the content
>    itself makes the delta unpalatable).

Like I said earlier I think this should be moved up a bit i.e. outside 
the delta loop.  In find_deltas() right before the ...

		j = window;
		while (--j > 0) {

loop, just insert another loop that compute the sha1 of the current 
target object and window:

		SHA1_Init(&c);
		j = window;
		while (j-- > 0) { /* postdec include the current object as well */
			unsigned int other_idx = idx + j;
			struct unpacked *m;
			if (other_idx >= window)
				other_idx -= window;
			m = array + other_idx;
			if (!m->entry)
				break;
			SHA1_Update(&c, m->entry.sha1, 20);
		}
		SHA1_Final(negative_delta_hash, &c);			

Then you can skip over the whole of the delta loop right away if that 
negative_delta_hash matches one entry in the cache since you already 
know that this object with this window doesn't produce any delta result.

Otherwise, after the delta loop has proceeded, if there is no delta 
found then you can add negative_delta_hash to the cache.

>  - optionalness. Currently the delta-cache is always used. Since it is a
>    space-time tradeoff, maybe it should be optional (it will have
>    negligible performance and horrible size impact on a repo that
>    consists of many very small but unrelated objects).  Possible methods
>    include:
>      - enable cache saves only if .git/delta-cache is present; turn it
>        on initially with 'touch .git/delta-cache'
>      - config variable

First, I think it should be ignored (but still created) when 
--no-reuse-delta is passed.  Then, it should not be created (but still 
looked up if it exists and --no-reuse-delta is not provided) when the 
pack index file is also not created.  I don't think it is worth making 
this further configurable, and given the suggested strategy above the 
cache should remain fairly small.


Nicolas
