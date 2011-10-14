From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] pack-objects: protect against disappearing packs
Date: Thu, 13 Oct 2011 22:42:28 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110132234210.17040@xanadu.home>
References: <20111014012320.GA4395@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, git-dev@github.com,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 04:42:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REXjN-0007mr-1w
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 04:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225Ab1JNCma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 22:42:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50497 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab1JNCm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 22:42:29 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LT100G4NB8X58C0@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 13 Oct 2011 22:36:33 -0400 (EDT)
In-reply-to: <20111014012320.GA4395@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183535>

On Thu, 13 Oct 2011, Jeff King wrote:

> It's possible that while pack-objects is running, a
> simultaneously running prune process might delete a pack
> that we are interested in. Because we load the pack indices
> early on, we know that the pack contains our item, but by
> the time we try to open and map it, it is gone.
> 
> Since c715f78, we already protect against this in the normal
> object access code path, but pack-objects accesses the packs
> at a lower level.  In the normal access path, we call
> find_pack_entry, which will call find_pack_entry_one on each
> pack index, which does the actual lookup. If it gets a hit,
> we will actually open and verify the validity of the
> matching packfile (using c715f78's is_pack_valid). If we
> can't open it, we'll issue a warning and pretend that we
> didn't find it, causing us to go on to the next pack (or on
> to loose objects).
> 
> Furthermore, we will cache the descriptor to the opened
> packfile. Which means that later, when we actually try to
> access the object, we are likely to still have that packfile
> opened, and won't care if it has been unlinked from the
> filesystem.
> 
> Notice the "likely" above. If there is another pack access
> in the interim, and we run out of descriptors, we could
> close the pack. And then a later attempt to access the
> closed pack could fail (we'll try to re-open it, of course,
> but it may have been deleted). In practice, this doesn't
> happen because we tend to look up items and then access them
> immediately.
> 
> Pack-objects does not follow this code path. Instead, it
> accesses the packs at a much lower level, using
> find_pack_entry_one directly. This means we skip the
> is_pack_valid check, and may end up with the name of a
> packfile, but no open descriptor.
> 
> We can add the same is_pack_valid check here. Unfortunately,
> the access patterns of pack-objects are not quite as nice
> for keeping lookup and object access together. We look up
> each object as we find out about it, and the only later when
> writing the packfile do we necessarily access it. Which
> means that the opened packfile may be closed in the interim.
> 
> In practice, however, adding this check still has value, for
> three reasons.
> 
>   1. If you have a reasonable number of packs and/or a
>      reasonable file descriptor limit, you can keep all of
>      your packs open simultaneously. If this is the case,
>      then the race is impossible to trigger.
> 
>   2. Even if you can't keep all packs open at once, you
>      may end up keeping the deleted one open (i.e., you may
>      get lucky).
> 
>   3. The race window is shortened. You may notice early that
>      the pack is gone, and not try to access it. Triggering
>      the problem without this check means deleting the pack
>      any time after we read the list of index files, but
>      before we access the looked-up objects.  Triggering it
>      with this check means deleting the pack means deleting
>      the pack after we do a lookup (and successfully access
>      the packfile), but before we access the object. Which
>      is a smaller window.
> ---

you should put your SOB above that line I would think.

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> We're seeing this at GitHub because we prune pretty
> aggressively. We let pushes go into individual repositories,
> but then we kick off a job to move the resulting objects
> into the repository's "network" repo, which is basically a
> big alternates repository for related repos.

While this patch certainly has value, it doesn't provide 100% 
reliability for that use case.  Maybe the github infrastructure should 
simply skip any auto-repack on push if some other object maintenance 
operation is ongoing, possibly via the pre-auto-gc hook.


Nicolas
