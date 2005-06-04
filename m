From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 3 Jun 2005 20:06:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506031927000.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506031450190.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jason McMullan <jason.mcmullan@timesys.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 02:10:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeMEQ-00029t-20
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 02:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVFDAMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 20:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVFDAL4
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 20:11:56 -0400
Received: from iabervon.org ([66.92.72.58]:55813 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261186AbVFDAH4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 20:07:56 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DeMBf-00080k-00; Fri, 3 Jun 2005 20:06:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506031450190.1876@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 3 Jun 2005, Linus Torvalds wrote:

> 
> 
> On Fri, 3 Jun 2005, Daniel Barkalow wrote:
> > 
> > Is this somehow different from rpush/rpull aside from using an
> > externally-provided socket and having the proper locking for writing refs
> > (which I posted a while ago, but which hasn't been included anywhere yet)?
> 
> Deathmatch! 
> 
> Anyway, I have to admit that at least as far as I'm concerned, the 
> rpull/rpush thing has the same issues as Jason's code - I've not seen the 
> usage documented anywhere, and that's the only real reason I don't use it 
> myself.

See below. I'd foolishly explained http-pull and rpull, but neglected to
mention that rpush is actually useful in its own right. It is used in
essentially the same way, but on the other computer. (And I need to fix
the Documentation/ file, since other people seem to have missed it, too)

> Also, just out of interest, do either or both of these things pipeline the
> transfer?

Mine doesn't currently. The protocol supports a low level of pipelining
(you can request all the objects you know you want, and the sending side
doesn't care that you're sending requests before the previous ones are
satisfied), but I haven't figured out (or found out from Matt, more
likely) a good way to negotiate something more clever.

> Me, I want to have a fairly simple script that does the equivalent of what
> I do now for pushing:
> 
> 	rsync -av --delete --exclude-from=.exclude .git/ master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> except I'd want it to do the locking and the "only accept trivial pushes" 
> stuff (ie no merging, just a pure update).

With patches I have (but have to rebase and such), you could do:

git-rpush -a -w heads/master heads/master //master.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

This would only send the heads/master file and all of the object files it
references. It would be easy to write a "--old heads/linus" which would
require that the remote value was the local value of heads/linus (I.e.,
the public value of your head that you'd been working from).

> Maybe git-rpush does this already, and I just never realized.

It currently does all the objects, but doesn't write the refs file on the
remote end. That is:

  git-rpush -a heads/master //master.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Will cause the public tree to contain all the objects reachable from the
local value of heads/master. Then you need to write the new head by hand
if you don't have the newer stuff.

	-Daniel
*This .sig left intentionally blank*

