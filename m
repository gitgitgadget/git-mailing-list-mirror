From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 21/22] teach the merge algorithm about cache iterators
Date: Wed, 14 Sep 2005 16:40:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509141622340.23242@iabervon.org>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
 <20050912145629.28120.70337.stgit@dexter.citi.umich.edu>
 <Pine.LNX.4.63.0509121633480.23242@iabervon.org> <43284368.8010004@citi.umich.edu>
 <Pine.LNX.4.63.0509141214490.23242@iabervon.org> <43287ECB.8090308@citi.umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 22:38:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFdzw-00024C-3F
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 22:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbVINUgV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 16:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVINUgV
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 16:36:21 -0400
Received: from iabervon.org ([66.92.72.58]:30732 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964942AbVINUgU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 16:36:20 -0400
Received: (qmail 8206 invoked by uid 1000); 14 Sep 2005 16:40:28 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Sep 2005 16:40:28 -0400
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <43287ECB.8090308@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8561>

On Wed, 14 Sep 2005, Chuck Lever wrote:

> Daniel Barkalow wrote:
> > The really exciting thing to do would be to have different programs use
> > different implementations, by way of linker magic.
> 
> yes, i've been considering that, but i'm not sure it is really worth the
> effort.  see below -- the right data structure should be good for just about
> any git workload.
> 
> > My guess for the ideal is to have a linked list with a hashtable for finding
> > entries by looking up names, because we don't look things up by index. This
> > combination gives O(1) in-order iteration, O(1) lookup by name, O(1) append,
> > O(n) insert, and O(1) remove. This means that git-update-cache --add would
> > be slow, but everything else would be fast. (Except, of course, for the
> > overhead of actually reading and writing the index file, rather than mmaping
> > it.)
> 
> [ i'm not sure why you think insert would be O(n). ]

You need to find the correct location to insert in the sorted list, and 
the hash table won't help you, because it doesn't have the new name. 
Remember that the cursors need to go through the index in order, so the 
list has to stay sorted.

> keeping the linked list for O(1) next/prev and delete, and augmenting it with
> a hash table to allow O(m/n) insert and find would be ideal.  with a fairly
> large hash table, we do better than a tree for any reasonably sized repository
> i can imagine.
> 
> and, i believe simply adding a hash table to my list implementation will be
> easy, and simpler overall than a tree implementation.  famous last words.

I've written a nice hash table which should work well, if you want to make 
the coding style suitable.

> mmapping the index file is still OK.  i haven't changed the cache_entry
> structure at all.

Oh, right, I forgot that the orgnaizational structure isn't the array of 
structs, but an array of pointers.

	-Daniel
*This .sig left intentionally blank*
