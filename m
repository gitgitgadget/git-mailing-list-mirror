From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/2] Support for packs in HTTP
Date: Sun, 10 Jul 2005 23:22:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507102253270.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0507101731330.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 05:25:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Drouh-0006BT-UD
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 05:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVGKDYw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 23:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVGKDYw
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 23:24:52 -0400
Received: from iabervon.org ([66.92.72.58]:23557 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262204AbVGKDYv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 23:24:51 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DrosW-00035X-00; Sun, 10 Jul 2005 23:22:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507101731330.17536@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 10 Jul 2005, Linus Torvalds wrote:

> 
> 
> On Sun, 10 Jul 2005, Daniel Barkalow wrote:
> 
> > On Sun, 10 Jul 2005, Linus Torvalds wrote:
> > > 
> > > Well, regardless, we want to be able to specify which directory to write 
> > > them to. We don't necessarily want to write them to the current working 
> > > directory, nor do we want to write them to their eventual destination in 
> > > .git/objects/pack.
> > > 
> > > In fact, the main current user ("git repack") really wants to write them 
> > > to a temporary file, and one that isn't even called "pack-xxx", since it 
> > > ends up doing cleanup with 
> > > 
> > > 	rm -f .tmp-pack-*
> > > 
> > > in case a previous re-pack was interrupted (in which case it simply cannor
> > > know what the exact name was supposed to be).
> > > 
> > > So the "basename" ends up being necessary and meaningful regardless. We do 
> > > _not_ want to remove that capability.
> > 
> > Shouldn't we do the same thing we do with object files? I don't see any
> > difference in desired behavior.
> 
> Well, the main difference is that pack-files can be used for many things.
> 
> For example, a web interface for getting a pack-file between two releases: 
> say you knew you had version xyzzy, and you want to get version xyzzy+1, 
> you could do that through webgit some way even with a "stupid" interface. 
> Kay already had some patch to generate pack-files for something.
> 
> The point being that pack-files are _not_ like objects. Pack-files are 
> meant for communication. Having them in .git/objects/pack is just one 
> special case.

Okay, I can see the use for them getting written to arbitrary paths; but I
think that it's worth having a canonical location for a pack that's being
used by the system (either not having been sent anywhere, or after having
been received). Perhaps git-pack-objects should have the base as a
optional argument, with a default of the filename in $GIT_DIR/objects/pack
and an option for sending just the pack file to stdout? I think that
covers everything in order of usefulness, and means that the program deals
with any filename that the user doesn't know in advance.

> > Why not checksum it in a predictable order, either that of the pack file
> > or the index? We do care that it's something verifiable, so that people
> > can't cause intentional collisions (for a DoS) just by naming their packs
> > after existing packs that users might not have downloaded yet.
> 
> We could sha1-sum the "sorted by SHA1" list, I guess.

That'd be good; then git-http-pull can validate the hash on the index and
be sure that a matching pack file from a different location still has the
same contents.

	-Daniel
*This .sig left intentionally blank*
