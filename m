From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 11:42:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
References: <20060628223744.GA24421@coredump.intra.peff.net>
 <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 17:42:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvyep-00041y-3n
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 17:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWF2PmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 11:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWF2PmQ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 11:42:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17801 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750811AbWF2PmP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 11:42:15 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J1M009EDOYE1AB0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Jun 2006 11:42:14 -0400 (EDT)
In-reply-to: <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22869>

On Wed, 28 Jun 2006, Junio C Hamano wrote:

> Interesting idea.  I think this matters more because for a
> repository with many unrelated undeltifiable files, we do the
> computation for objects that results in _no_ delta.  For normal
> nearly fully packed repositories, once an object is deltified
> against something else, subsequent repacking of the same set of
> objects (or a superset thereof) will very likely reuse the delta
> without recomputation, so as long as each object _can_ be
> deltified with at least _one_ other object, you should not see
> improvement on them.
> 
> So I am curious where the speed-up comes from for "normal" repos
> in your experiments.

My GIT repo currently has 23622 objects and 7610 of them are currently 
undeltified.  Those objects are of course candidates for delta matching 
each time git-repack is run.

> If it turns out that in "normal" repos the
> objects that hit your negative cache are stored undeltified,
> then that suggests that it might be worthwhile to consider using
> a cache of "inherently undeltifiable objects", In other words, a
> negative cache of O(N) entries, instead of O(N^2) entries,

Actually... I'm not so sure.  Those objects are not "inherently 
undeltifiable".  They just happen to not have other objects to easily 
delta against in the given set of objects.  Think of a file with only 
one revision for example.  As soon as there is a second revision of that 
file added to the set of objects then the former revision would have a 
high probability of being deltifiable.

So the negative cache should not be O(N^2) either.  It just has to be 
O(N*window).

> Another interpretation of your result is that we may be using a
> delta window that is unnecessarily too deep, and your negative
> cache is collecting less optimum candidates that we attempt to
> deltify against "just in case".  Can you easily instrument your
> code to see where in the sorted delta candidate list the pairs
> that hit your the negative cache are?  That is, in find_deltas()
> function, we have "while (--j > 0)" loop that attempts to delta
> with the entry that is j (modulo window size) entries away from
> the current one, then j-1, j-2, ...; I am interested in the
> distribution of "j" value for the pair "n,m" that hits your
> negative cache for normal repositories, and I am speculating
> that the value would probably be small relative to the delta
> window size.

My past experiments showed that the best window size for compression is 
a bit larger than the current default of 10.  It was rather around 15 
for the kernel repository, with higher values than 15 not providing 
significant improvements anymore.  But that is clearly a function of the 
repository nature (the average number of revisions for each file).  But 
the window size is directly connected to the computational cost.

> Another idea is to have a cache of "paths at which inherently
> undeltifiable objects live in".  For example, we currently do
> not delta OpenOffice documents (*.odt, *.odp, etc) very well.
> If one has a repository that tracks the history of "file.odp",
> we know each revision of "file.odp" would not delta against any
> other version anyway, and could skip attempting to deltify them.

I'm afraid this could lead to bad behavior eventually.  Better to just 
attempt a delta once, and when an object has not found any delta 
base candidate then just write its sha1 and corresponding window to the 
cache.  This would imply an initial cost to create the cache the first 
time, but after that the created cache could be relied upon as hard 
information and not just as guess heuristics.

> >  - size. The cache is a packed sequence of binary sha1 pairs. I was
> >    concerned that it would grow too large (obviously for n blobs you can
> >    end up with n^2/2 entries), but it doesn't seem unreasonable for most
> >    repos (either you don't have a lot of files, or if you do, they delta
> >    reasonably well). My test repo's cache is only 144K. The git cache is
> >    about 2.7M. The linux-2.6 cache is 22M.

This is way suboptimal.  First there is no reason for the cache to ever 
grow to N^2.  At worst it should be N*10 where 10 is the current window 
size.

Next I think this can be made just N*2.  Consider that the criteria for 
skipping over delta matching for a given object is the fact 
that we already know that such object doesn't delta against 
none of the objects found in a given window.  Therefore we only have to 
compute a hash for the object names found in that window and store that 
in the cache.  So the cache entries would then be a pair of sha1: first 
the sha1 of the victim object, and the sha1 of all sha1 names for the 
objects against which the victim object was found not to delta well 
against.

And this can be pushed even further by just including the sha1 of the 
victim object inside the list of objects therefore computing a hash of 
all objects (the victim and the window) for which no delta results. The 
cache is therefore a list of hash values corresponding to bad 
victim+window combinations.

So given my GIT repository such a cache would be 7610 * 40 = 304400 
bytes if we stick to the full 40 bytes of sha1 to hash bad combinations.


Nicolas
