From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [SCRIPT] cg-rpush & locking
Date: Thu, 2 Jun 2005 02:39:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506020223570.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506011951150.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Nicolas Pitre <nico@cam.org>, Tony Lindgren <tony@atomide.com>,
	git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Thu Jun 02 08:39:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdjLp-0008Rl-4q
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 08:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVFBGlL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 02:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVFBGlL
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 02:41:11 -0400
Received: from iabervon.org ([66.92.72.58]:5382 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261591AbVFBGk1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 02:40:27 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DdjMB-0007wU-00; Thu, 2 Jun 2005 02:39:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506011951150.1876@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 1 Jun 2005, Linus Torvalds wrote:

> 
> 
> On Wed, 1 Jun 2005, Thomas Glanzmann wrote:
> > 
> > 	1. acquire remote lock
> > 	2. get remote HEAD
> > 	3. if remote HEAD is ahead (not included in our history) abort
> > 	   and free lock.
> > 	4. push objects
> > 	5. update remote HEAD with local
> > 	6. free remote lock.
> 
> You really need a specialized client at the other end, because regardless 
> of locking, you want to write the objects atomically (ie download them 
> into a temp-file, and then do the "rename" thing to make them show up 
> all-or-nothing).
> 
> Also, I'd suggest a slight modification to avoid keeping the lock for a 
> long time, namely to have the lock protect just a quick "compare and 
> exchange". So the algorithm would become:
> 
> 	1. read remote HEAD
> 	2. if remote HEAD isn't in our history, abort with "remote is 
> 	   ahead"
> 	3. calculate the objects needed to push locally
> 	4. push them (but accept the possibility that the remote may
> 	   already have them, so have the protocol able to say "got that
> 	   one already"). Make this use the atomic write on the other end.
> 	5. do an atomic compare-and-exchange of the remote head with the 
> 	   new one (ie only switch the remote HEAD if it still matches 
> 	   what we were expecting it to be)
> 
> Hmm?

If the lock is only to protect against someone else modifying HEAD after
we've checked that it is our starting point and before we modify it,
there's no reason not to hold the lock while pushing; it wouldn't block
anything other than someone doing a quick push in the middle of our long
one, and thereby causing us to dump a lot of useless objects on the
server (which will become obsolete as we will need to do the merge and
push a different version).

The key is that people can still download the old version until the new
version is there, regardless of the lock; they'll get data about to
go stale, but they would have anyway had they been a few seconds
earlier. The main annoyance would be that you'd be blocked from pushing,
and then have to poll for the other upload to finish before you'd be able
to pull, do the merge, and then push your changes; you want to have the
client watch for the resolution of the other transfer one way or the
other, since you're in the current state precisely because you lost on
getting the lock and now definitely need the next version.

	-Daniel
*This .sig left intentionally blank*

