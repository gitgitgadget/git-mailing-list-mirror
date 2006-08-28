From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Starting to think about sha-256?
Date: Mon, 28 Aug 2006 11:06:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608281059380.27779@g5.osdl.org>
References: <44F1DCB7.6020804@garzik.org>  <m31wr1exbf.fsf@defiant.localdomain>
 <Pine.LNX.4.64.0608271343120.27779@g5.o sdl.org>
 <Pine.LNX.4.63.0608272341330.28360@wbgn013.biozentrum.uni-wuerzburg .de>
 <Pine.LNX.4.64.0608271522390.27779@g5.osdl.org> <656C30A1EFC89F6B2082D9B6@localhost>
 <Pine.LNX.4.64.0608281034440.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 28 20:07:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHlWF-0007HF-9T
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 20:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWH1SGk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 14:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWH1SGk
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 14:06:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18413 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750786AbWH1SGj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 14:06:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7SI6SnW017216
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 28 Aug 2006 11:06:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7SI6R7f007858;
	Mon, 28 Aug 2006 11:06:27 -0700
To: David Lang <david.lang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.64.0608281034440.27779@g5.osdl.org>
X-Spam-Status: No, hits=-0.438 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26171>



On Mon, 28 Aug 2006, Linus Torvalds wrote:
> 
>  - The attacker kind of collision because somebody broke (or brute-forced) 
>    SHA1.
> 
>    This one is clearly a _lot_ more likely than the inadvertent kind, but 
>    by definition it's always a "remote" repository. If the attacker had 
>    access to the local repository, he'd have much easier ways to screw you 
>    up.
> 
>    So in this case, the collision is entirely a non-issue: you'll get a 
>    "bad" repository that is different from what the attacker intended, but 
>    since you'll never actually use his colliding object, it's _literally_ 
>    no different from the attacker just not having found a collision at 
>    all, but just using the object you already had (ie it's 100% equivalent 
>    to the "trivial" collision of the identical file generating the same 
>    SHA1).

Btw, this is obviously only true for the native git protocol itself.

If the attacker can fool you into generating the new file _yourself_, he 
can cause your checked-out copy to not match the git object database any 
more.

In other words, one "interesting" attack vector is to feed you the 
colliding SHA1 not through a git-to-git transfer, but by generating a 
_patch_ that when applied will generate the collision, so that when you 
then commit that patch, you get something else than you expected.

And _this_ is where it's important that the hash that git uses be a 
non-trivial one - ie we don't want people to be able to generate two files 
that look superficially "ok".

So here's the rule: If you ever get a patch that looks like line-noise, 
especially from somebody you don't trust, DON'T APPLY IT!

Now, that is obviously something you should never do _regardless_ of any 
git issues, so I don't think this is really a problem either. If you apply 
patches from people you don't have a good reason to trust without 
sanity-checking them, you deserve whatever you get, and quite frankly, a 
SHA1 hash collision is the _least_ of your problems ;)

(This ends up boiling down to one common issue: it's generally _much_ 
easier to attack a project through _other_ means than through a hash 
collision. And I pretty much guarantee that that is the case even if we 
were to use a much weaker hash, like MD5. Hash collisions fundamentally 
just aren't good attack vectors, and it's a hell of a lot easier to try 
to insert bad code by other means)

			Linus
