From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Wed, 3 Jan 2007 17:59:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 02:59:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2HtO-0007ui-8u
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 02:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbXADB7j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 20:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbXADB7j
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 20:59:39 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:40001 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbXADB7i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 20:59:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l041xTJi022213
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 Jan 2007 17:59:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l041xSGU006363;
	Wed, 3 Jan 2007 17:59:28 -0800
To: Chris Lee <chris133@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Shawn Pearce <spearce@spearce.org>,
	Sasha Khapyorsky <sashak@voltaire.com>
In-Reply-To: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
X-Spam-Status: No, hits=-0.674 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.166 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35901>



On Wed, 3 Jan 2007, Chris Lee wrote:
>
> So I'm using git 1.4.1, and I have been experimenting with importing
> the KDE sources from Subversion using git-svnimport.

As one single _huge_ import? All the sub-projects together? I have to say, 
that sounds pretty horrid.

> First issue I ran into: On a machine with 4GB of RAM, when I tried to
> do a full import, git-svnimport died after 309906 revisions, saying
> that it couldn't fork.
> 
> Checking `top` and `ps` revealed that there were no git-svnimport
> processes doing anything, but all of my 4G of RAM was still marked as
> used by the kernel. I had to do sysctl -w vm.drop_caches=3 to get it
> to free all the RAM that the svn import had used up.

I think that was just all cached, and all ok. The reason you didn't see 
any git-svnimport was that it had died off already, and all your memory 
was just caches. You could just have left it alone, and the kernel would 
have started re-using the memory for other things even without any 
"drop_caches". 

But what you did there didn't make anything worse, it was just likely had 
no real impact.

However, it does sound like git-svnimport probably acts like git-cvsimport 
used to, and just keeps too much in memory - so it's never going to act 
really nicely..

It also looks like git-svnimport never repacks the repo, which is 
absolutely horrible for performance on all levels. The CVS importer 
repacks every one thousand commits or something like that.

> Now, after that, I tried doing `git-repack -a` because I wanted to see
> how small the packed archive would be (before trying to continue
> importing the rest of the revisions. There are at least another 100k
> revisions that I should be able to import, eventually.)

I suspect you'd have been better off just re-starting, and using something 
like

	while :
	do
		git svnimport -l 1000 <...>
		.. figure out some way to decide if it's all done ..
		git repack -d
	done

which would make svnimport act a bit  more sanely, and repack 
incrementally. That should make both the import much faster, _and_ avoid 
any insane big repack at the end (well, you'd still want to do a "git 
repack -a -d" at the end to turn the many smaller packs into a bigger one, 
but it would be nicer).

However, I don't know what the proper magic is for svnimport to do that 
sane "do it in chunks and tell when you're all done". Or even better - to 
just make it repack properly and not keep everything in memory.

> The repack finished after about nine hours, but when I try to do a
> git-verify-pack on it, it dies with this error message:
> 
> error: Packfile
> .git/objects/pack/pack-540263fe66ab9398cc796f000d52531a5c6f3df3.pack
> SHA1 mismatch with itself

That sounds suspiciously like the bug we had in out POWER sha1 
implementation that would generate the wrong SHA1 for any pack-file that 
was over 512MB in size, due to an overflow in 32 bits (SHA1 does some 
counting in _bits_, so 512MB is 4G _bits_),

Now, I assume you're not on POWER (and we fixed that bug anyway - and I 
think long before 1.4.1 too), but I could easily imagine the same bug in 
some other SHA1 implementation (or perhaps _another_ overflow at the 1GB 
or 2GB mark..). I assume that the pack-file you had was something horrid..

I hope this is with a 64-bit kernel and a 64-bit user space? That should 
limit _some_ of the issues. But I would still not be surprised if your 
SHA1 libraries had some 32-bit ("unsigned int") or 31-bit ("int") limits 
in them somewhere - very few people do SHA1's over huge areas, and even 
when you do SHA1 on something like a DVD image (which is easily over any 
4GB limit), that tends to be done as many smaller calls to the SHA1 
library routines.

Junio - I suspect "pack-check.c" really shouldn't try to do it as one 
single humungous "SHA1_Update()" call. It showed one bug on PPC, I 
wouldn't be surprised if it's implicated now on some other architecture. 

Shawn - does the pack-file-windowing thing already change that? I'm too 
lazy to check..

As to who knows how to fix git-svnimport to do something saner, I have no 
clue.. Sasha seems to have touched it last. Sasha?

		Linus
