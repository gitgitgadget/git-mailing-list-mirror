From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git prune pig slow
Date: Sat, 29 Jul 2006 13:03:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607291245230.4168@g5.osdl.org>
References: <20060729090250.GC26956@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0607291110180.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 29 22:03:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6v2I-0000AS-Dr
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 22:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWG2UDn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 16:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWG2UDn
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 16:03:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932184AbWG2UDm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jul 2006 16:03:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6TK3YnW029867
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 29 Jul 2006 13:03:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6TK3Xc8018533;
	Sat, 29 Jul 2006 13:03:34 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.64.0607291110180.4168@g5.osdl.org>
X-Spam-Status: No, hits=-0.509 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24431>



On Sat, 29 Jul 2006, Linus Torvalds wrote:
> 
> It's also very dangerous.
> 
> If you have partial packing (which you can get if you fetch data using 
> rsync or http, for example), not havign the "--full" means that 
> git-fsck-objects will report on objects being "unreachable" if they are 
> only reachable from another object that is packed.
> 
> Now, in practice, if you only use the git native protocol, this should 
> never happen, and you're fine.

Side note: in _practice_, it probably doesn't happen even with rsync and 
http, so in that sense, it's true that "--full" is almost always likely to 
just be a waste of time, and I can't come up with a schenario where you 
really need "--full" for pruning unless you did something strange. All the 
normal workflows means that if you have an object that is in a pack, 
everything it points to will _also_ be in a pack, and as such, "git prune" 
would never remove anything that wasn't safe to remove, even without the 
"--full".

But just to get an example of how a _strange_ schenario could happen, 
let's say that

 - you're tracking a upstreams repository using rsync or http (ie you will 
   get the objects in the same format that upstream tracks them, either as 
   individual objects, or as "packs")

 - that upstreams repository does _incremental_ repacks every once in a 
   while. 

 - the last time you fetched was _just_ before upstream did an incremental 
   pack, we call this "State A".

	As a result, you now have his old state A all as individual 
	objects in your object database.

 - you fetch again, now after upstream has done _two_ incremntal packs 
   (one to pack all the loose objects that you already had, and one to 
   pack the new state). Upstream is now at "State B"

	As a result, you get all of his _new_ objects as one nice pack: 
	you do not get his other pack, because you already have all 
	_those_ objects (which are "state A") as individual objects.

 - so now, since you're only tracking the other ends state, and have no 
   objects of your own (in particular, the last fetch/pull did _not_ 
   generate a merge object of your own to connect the new pack with the 
   old objects), what has happened is that all your heads point into the 
   new incremental pack you just fetched, and that pack itself will have 
   pointers to the individual objects that you fetched last time, because 
   it was an incremental pack to "state A".

 - what happens now is that if you run "git-fsck-objects" without the 
   "--full", it will claim that _all_ of your unpacked objects are 
   unreachable, because they really are reachable only though that new 
   pack.

So in this (very very unusual) circumstance, "git prune" without the 
"--full" would literally prune away objects that you very much need.

I hope this explains why that "unnecessary" (and admittedly much more 
expensive) --full is there. It really is unnecessary in practice: partly 
because Junio has made "git repack -a -d" so efficient that doing 
incremental packs isn't even worth it for most people, and partly because 
you probably use the native git protocol and repack yourself, and thus 
never use another persons pack directly (which also avoids this problem).

But yeah, the olf "git prune" was really very expensive. It's much better 
in the current git branch, although it's still not _cheap_ (because it 
does do the whole reachability analysis, though all pack-files, because it 
wants to get the above special case right).

If we really wanted to, we could add a "core.fullpacks" flag that you 
could set, and that would cause the non-native protocols to not work (or 
alternatively force a re-pack after they have fetched a pack), and that 
would disallow incremental repacking locally, and then we could optimize 
the hell out of "git prune" and say that it never needs to look at any 
reachability for an object that is already packed.

That would make "git prune" basically instantaneous, the way "git 
fsck-objects" is by default. But to be safe, it really needs to have some 
per-repository flag that is honored by the other git commands.

			Linus
