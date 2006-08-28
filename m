From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Starting to think about sha-256?
Date: Mon, 28 Aug 2006 10:56:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608281034440.27779@g5.osdl.org>
References: <44F1DCB7.6020804@garzik.org>  <m31wr1exbf.fsf@defiant.localdomain>
 <Pine.LNX.4.64.0608271343120.27779@g5.o sdl.org>
 <Pine.LNX.4.63.0608272341330.28360@wbgn013.biozentrum.uni-wuerzburg .de>
 <Pine.LNX.4.64.0608271522390.27779@g5.osdl.org> <656C30A1EFC89F6B2082D9B6@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 28 19:56:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHlLY-0005BA-7D
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 19:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWH1R4P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 13:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWH1R4P
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 13:56:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17897 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750875AbWH1R4O (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 13:56:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7SHu2nW016518
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 28 Aug 2006 10:56:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7SHu1eK007475;
	Mon, 28 Aug 2006 10:56:01 -0700
To: David Lang <david.lang@digitalinsight.com>
In-Reply-To: <656C30A1EFC89F6B2082D9B6@localhost>
X-Spam-Status: No, hits=-0.439 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26170>



On Mon, 28 Aug 2006, David Lang wrote:
> 
> just to double check.
> 
> if you already have a file A in git with hash X is there any condition where a
> remote file with hash X (but different contents) would overwrite the local
> version?

Nope. If it has the same SHA1, it means that when we receive the object 
from the other end, we will _not_ overwrite the object we already have.

So what happens is that if we ever see a collision, the "earlier" object 
in any particular repository will always end up overriding. But note that 
"earlier" is obviously per-repository, in the sense that the git object 
network generates a DAG that is not fully ordered, so while different 
repositories will agree about what is "earlier" in the case of direct 
ancestry, if the object came through separate and not directly related 
branches, two different repos may obviously have gotten the two objects in 
different order.

However, the "earlier will override" is very much what you want from a 
security standpoint: remember that the git model is that you should 
primarily trust only your _own_ repository. So if you do a "git pull", the 
new incoming objects are by definition less trustworthy than the objects 
you already have, and as such it would be wrong to allow a new object to 
replace an old one.

So you have two cases of collision:

 - the inadvertent kind, where you somehow are very very unlucky, and two 
   files end up having the same SHA1. At that point, what happens is that 
   when you commit that file (or do a "git-update-index" to move it into 
   the index, but not committed yet), the SHA1 of the new contents will be 
   computed, but since it matches an old object, a new object won't be 
   created, and the commit-or-index ends up pointing to the _old_ object.

   You won't notice immediately (since the index will match the old object 
   SHA1, and that means that something like "git diff" will use the 
   checked-out copy), but if you ever do a tree-level diff (or you 
   do a clone or pull, or force a checkout) you'll suddenly notice that 
   that file has changed to something _completely_ different than what you 
   expected. So you would generally notice this kind of collision fairly 
   quickly.

   In related news, the question is what to do about the inadvertent 
   collision.. First off, let me remind people that the inadvertent kind 
   of collision is really really _really_ damn unlikely, so we'll quite 
   likely never ever see it in the full history of the universe. But _if_ 
   it happens, it's not the end of the world: what you'd most likely have 
   to do is just change the file that collided slightly, and just force a 
   new commit with the changed contents (add a comment saying "/* This 
   line added to avoid collision */") and then teach git about the magic 
   SHA1 that has been shown to be dangerous.

   So over a couple of million years, maybe we'll have to add one or two 
   "poisoned" SHA1 values to git. It's very unlikely to be a maintenance 
   problem ;)

 - The attacker kind of collision because somebody broke (or brute-forced) 
   SHA1.

   This one is clearly a _lot_ more likely than the inadvertent kind, but 
   by definition it's always a "remote" repository. If the attacker had 
   access to the local repository, he'd have much easier ways to screw you 
   up.

   So in this case, the collision is entirely a non-issue: you'll get a 
   "bad" repository that is different from what the attacker intended, but 
   since you'll never actually use his colliding object, it's _literally_ 
   no different from the attacker just not having found a collision at 
   all, but just using the object you already had (ie it's 100% equivalent 
   to the "trivial" collision of the identical file generating the same 
   SHA1).

> what would happen if you ended up with two packs that both contained a file
> with hash X but with different contents and then did a repack on them? (either
> packs from different sources, or packs downloaded through some mechanism other
> then the git protocol are two ways this could happen that I can think of)

See above. The only _dangerous_ kind of collision is the inadvertent kind, 
but that's obviously also the very very unlikely kind.

			Linus
