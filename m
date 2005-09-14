From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 21/22] teach the merge algorithm about cache iterators
Date: Wed, 14 Sep 2005 12:41:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509141214490.23242@iabervon.org>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
 <20050912145629.28120.70337.stgit@dexter.citi.umich.edu>
 <Pine.LNX.4.63.0509121633480.23242@iabervon.org> <43284368.8010004@citi.umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 18:39:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFaGJ-0004Ez-Sa
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 18:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbVINQh3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 12:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbVINQh2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 12:37:28 -0400
Received: from iabervon.org ([66.92.72.58]:50182 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030263AbVINQh2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 12:37:28 -0400
Received: (qmail 6713 invoked by uid 1000); 14 Sep 2005 12:41:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Sep 2005 12:41:36 -0400
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <43284368.8010004@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8539>

On Wed, 14 Sep 2005, Chuck Lever wrote:

> Daniel Barkalow wrote:
> > On Mon, 12 Sep 2005, Chuck Lever wrote:
> > 
> > 
> > >For now, we simply replace indpos with a cache cursor.  Likely more
> > >changes will be needed after we successfully replace the cache array
> > >with an abstract data type.
> > 
> > 
> > The right order is probably to add the concept of a cache that isn't the one
> > that normal functions deal with, have read_cache_unmerged return such a
> > thing, call cc_init with that, and rip out all of the removal and position
> > adjustment code. Then read_tree won't care at all about the internal
> > structure of the cache type, and it can be replaced without any problem.
> 
> ok, i've done this.  read_cache_unmerged now reads into a separate cache, and
> read-tree.c does the merge by moving the appropriate cache entries into the
> active cache.
> 
> the linked list prototype is done, and works correctly.  this validates the
> new cache cursor API.  unfortunately because finding a name is now O(n), many
> things are slower than before (but i expected this would be the case for
> lists).

The really exciting thing to do would be to have different programs use 
different implementations, by way of linker magic.

My guess for the ideal is to have a linked list with a hashtable for 
finding entries by looking up names, because we don't look things up by 
index. This combination gives O(1) in-order iteration, O(1) lookup by 
name, O(1) append, O(n) insert, and O(1) remove. This means that 
git-update-cache --add would be slow, but everything else would be fast. 
(Except, of course, for the overhead of actually reading and writing the 
index file, rather than mmaping it.)

Another thing to try would be the original dynamic table implementation, 
plus a hashtable for name lookups, generated the first time a lookup is 
attempted (since some programs don't do any lookups by name). This has the 
advantage of skipping the O(n) startup.

	-Daniel
*This .sig left intentionally blank*
