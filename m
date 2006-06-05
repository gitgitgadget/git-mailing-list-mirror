From: Linus Torvalds <torvalds@osdl.org>
Subject: Horrible re-packing?
Date: Mon, 5 Jun 2006 10:08:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606050951120.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 05 19:09:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnIZZ-0002dh-HM
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 19:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWFERI7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 13:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWFERI7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 13:08:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42435 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751228AbWFERI6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jun 2006 13:08:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k55H8g2g029042
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Jun 2006 10:08:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k55H8eOC017835;
	Mon, 5 Jun 2006 10:08:41 -0700
To: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21323>


Junio, Nico,
 I just tried doing a "git repack -a -d -f" to because I expected a full 
re-pack to do _better_ than doing occasional incrementals, and verify the 
pack generation, but imagine my shock when IT SUCKS.

I didn't look at where the suckage started, but look at this:

	[torvalds@g5 git]$ git repack -a -d
	Generating pack...
	Done counting 21322 objects.
	Deltifying 21322 objects.
	 100% (21322/21322) done
	Writing 21322 objects.
	 100% (21322/21322) done
	Total 21322, written 21322 (delta 14489), reused 21319 (delta 14486)
	Pack pack-fe4ff117c9959ead3443b826a777423b3062b666 created.

	[torvalds@g5 git]$ ll .git/objects/pack/
	total 7008
	-rw-r--r-- 1 torvalds torvalds  512792 Jun  5 09:41 pack-fe4ff117c9959ead3443b826a777423b3062b666.idx
	-rw-r--r-- 1 torvalds torvalds 6643695 Jun  5 09:41 pack-fe4ff117c9959ead3443b826a777423b3062b666.pack

Ie, we have  anice 6.33MB pack-file.

Now:

	[torvalds@g5 git]$ git repack -a -d -f
	Generating pack...
	Done counting 21322 objects.
	Deltifying 21322 objects.
	 100% (21322/21322) done
	Writing 21322 objects.
	 100% (21322/21322) done
	Total 21322, written 21322 (delta 10187), reused 6777 (delta 0)
	Pack pack-fe4ff117c9959ead3443b826a777423b3062b666 created.

	[torvalds@g5 git]$ ll .git/objects/pack/
	total 15352
	-rw-r--r-- 1 torvalds torvalds   512792 Jun  5 09:41 pack-fe4ff117c9959ead3443b826a777423b3062b666.idx
	-rw-r--r-- 1 torvalds torvalds 15176139 Jun  5 09:41 pack-fe4ff117c9959ead3443b826a777423b3062b666.pack

Whaah! That nice 6.33MB pack-file exploded to 14.5MB!

Doing repeated "git repack -a -d" to try to do incrementals, it stopped 
improving after the sixth one, at which point it was down to 11.7MB, still 
almost twice as big as before.

Re-doing it with 

	git repack -a -d -f --depth=100 --window=100

got me back to 6.94MB, but that's still 10% larger than the pack-file I 
had before.

Interestingly, it's the "window" that matters more. The depth part didn't 
make that huge of a difference, so it looks like it's the sorting 
heuristic that may be broken again.

And it's possibly broken by the fact that we've been renaming things 
lately (ie the "rev-list.c" -> "builtin-rev-list.c" thing ends up not 
finding things)

Nico? Any ideas?

			Linus
