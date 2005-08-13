From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC][PATCH] Rewriting revs in place in push target repository
Date: Sat, 13 Aug 2005 15:20:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508131507260.3553@g5.osdl.org>
References: <20050813214725.GM5608@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 14 00:22:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E44Mx-0002l5-OY
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 00:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVHMWUp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 18:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVHMWUp
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 18:20:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29827 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932360AbVHMWUo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 18:20:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7DMKbjA002905
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 13 Aug 2005 15:20:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7DMKabi030711;
	Sat, 13 Aug 2005 15:20:37 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050813214725.GM5608@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 13 Aug 2005, Petr Baudis wrote:
> 
> * Does this break atomicity?
> 
> 	I think it does not in real setups, since thanks to O_RDWR the
> 	file should be overwritten only when the write() happens.
> 	Can a 41-byte write() be non-atomic in any real conditions?

That's not the problem.

The problem is that your change means that there is no locking, and you 
now can have two writers that both update the same file, and they _both_ 
think that they succeed. They'll both read the old contents, decide that 
it still is the one from before the push, and then they'll both do the 
write.

And yes, in most (all?) sane filesystems, the end result is that one of 
them "wins", and the end result is a nice 41-byte file. But the problem is 
that the other write just totally got lost, and the person doing the push 
_thought_ he had updated the thing, but never did.

To make things worse, with NFS and client-side caching, different clients 
that look at the tree at around that time can literally see _different_ 
heads winning the race. One of the writers wrote "first", and that client 
(and other NFS clients doing a read at that time) will see it succeed. But 
then the other pusher writes, and now people will see _that_ one succeed.

Confusion reigns.

In contrast, with the "create lock-file and rename" thing, if there is a
race, somebody will win, and the loser will hopefully know they lost.

> * Does this break with full disk/quota?
> 
> 	I'm not sure - we are substituting 41 bytes by another 41
> 	bytes; will the system ever be evil enough to truncate the
> 	file, then decide the user is over his quota and not write
> 	the new contents?

Probably not.

But how about you just try to copy the permission/group of the original
file before you do the rename? I assume that if you're depending on 
permissions, it's either a shared group or by having the thing writable by 
others, so doing a 

	if (!fstat(oldfd, &st)) {
		fchown(fd, (uid_t) -1, st.st_gid);
		fchmod(fd, st.st_mode & ALLPERMS);
	}
	.. do rename here ..

which should get you where you want, no?

		Linus
