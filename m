From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Security problem
Date: Thu, 15 Jun 2006 22:00:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606152137410.5498@g5.osdl.org>
References: <200606151709.22752.lan@academsoft.ru> <200606160931.29553.lan@academsoft.ru>
 <Pine.LNX.4.64.0606151948230.5498@g5.osdl.org> <200606161054.46813.lan@academsoft.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 07:01:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr6SD-0003mg-4f
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 07:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWFPFAs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 01:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWFPFAs
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 01:00:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29084 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750781AbWFPFAr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 01:00:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5G50egt010999
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Jun 2006 22:00:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5G50dBb006742;
	Thu, 15 Jun 2006 22:00:39 -0700
To: Alexander Litvinov <lan@academsoft.ru>
In-Reply-To: <200606161054.46813.lan@academsoft.ru>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21929>



On Fri, 16 Jun 2006, Alexander Litvinov wrote:
>
> You are right, I trust my file system. But if our team had central repo with 
> ssh access to that machine, every developer can hack central repo.
> 
> Whould git-clone/git-fetch warn me about this ?

Using the native protocol, yes. Using rsync, unless you explicitly fsck 
the result, no.

> It can't checkout object (3609f20ebd357679b111783e8afaf36ec46427f3 is the 
> original file). It seems packed repos are safe from this point.

Well, they may not be "safe" - you just need to work a _lot_ harder to 
corrupt a pack-file in any interesting manner. And again, git-fsck-objects 
would pick up any such thing going on.

Anyway, what it boils down to is that anybody who has write access to a 
particular repository can certainly change the repo in "interesting" ways. 

However, there are various inherent safety valves in place that make it 
really hard to corrupt on a bigger scale.

The first is that git-fsck-objects will definitely find any repository 
inconsistency, and to get around that, you either have to get around the 
basic properties of SHA-1 (ie break the hash) _or_ you have to actually 
change the repository so that it's still a valid repo, just with different 
content.

So let's take a look at those two cases:

 - if you corrupt the repository, subsequent clones (or even pulls) from 
   the corrupt repository simply won't work if you use the native 
   protocol, because the native protocol doesn't actually trust anything 
   but the actual contents (so if the contents won't match, then neither 
   will the SHA1 names). So the corruption is pretty strictly limited to 
   the _one_ repository that the attacker had write access to.

   So there's a pretty fundamental "corruption containment" part there.

   (Side note: there's no question that we might well be able to do 
   better. A _malicious_ server could actually send a corrupt pack, and 
   it's possible that a properly corrupted remote archive could cause even 
   a "good" git-send-pack to just silently send a corrupt pack, so that 
   you'd need to use "git-fsck-objects" on the receiving side to notice 
   that you are missing objects, for example)

 - if the repository is good (ie fsck is fine), then obviously a "git 
   pull" will also succeed. However, you can't _hide_ the data the way you 
   tried to do: when the receiver checks out the most recent version, it 
   will definitely use the data in the object, there's no way to get the 
   server to serve different data in objects and in the working tree 
   (because the server literally doesn't even send the working tree at 
   all).

   So you can always convince somebody to pull from an "evil repository", 
   and that's no different from committing a bug by mistake. But at least 
   you can't try to hide the bug just in the object store and have it not 
   show up in diffs and in checked-out copies.

The latter case is true even with http and rsync, the actual pull event 
always pulls just the database, never any checked-out state (in fact, 
the common case is obviously to pull from a bare repository that doesn't 
even _have_ checked-out state). So you can't hide things in the index or 
in the checked-out state except in the filesystem that you have direct 
write access to.

But yeah, I actually still personally do a fair number of 
"git-fsck-objects". I've never found anything that way since very early on 
(and back then, the real problem was rsync getting objects that weren't 
reachable), but I still do it. It makes me feel happier.

Of course, bugs always happen. But I can pretty much guarantee that git is 
fundamentally harder to corrupt than most things. We've had git-fsck-cache 
since April 8th last year (or, put another way, literally since "Day 2" in 
git terms - it's the eight commit in the whole git history).

Git also has an almost total lack of redundant information. There's 
basically no "duplicate" information in the repository format itself where 
you could hide something so that it wouldn't be noticed.

In a checked-out project, the checked-out state itself is "duplicate 
information" (and that was where your "attack" tried to hide things), and 
there's the index (which is actually a much better and subtle place to 
hide things ;). But neither of them have any life outside of that 
particular repository.

			Linus
