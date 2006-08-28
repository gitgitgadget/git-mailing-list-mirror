From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Starting to think about sha-256?
Date: Mon, 28 Aug 2006 11:46:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608281137530.27779@g5.osdl.org>
References: <44F1DCB7.6020804@garzik.org> <m31wr1exbf.fsf@defiant.localdomain>
 <Pine.LNX.4.64.0608271343120.27779@g5.osdl.org>
 <Pine.LNX.4.63.0608272341330.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0608271522390.27779@g5.osdl.org> <656C30A1EFC89F6B2082D9B6@localhost>
 <Pine.LNX.4.64.0608281034440.27779@g5.osdl.org> <20060828183252.GC2950@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Lang <david.lang@digitalinsight.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 28 20:47:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHm8V-0005hA-1V
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 20:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWH1Sqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 14:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWH1Sqy
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 14:46:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56206 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751329AbWH1Sqw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 14:46:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7SIkenW019380
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 28 Aug 2006 11:46:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7SIkd6v009397;
	Mon, 28 Aug 2006 11:46:39 -0700
To: Jeff King <peff@peff.net>
In-Reply-To: <20060828183252.GC2950@coredump.intra.peff.net>
X-Spam-Status: No, hits=-0.437 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26174>



On Mon, 28 Aug 2006, Jeff King wrote:
>
> On Mon, Aug 28, 2006 at 10:56:01AM -0700, Linus Torvalds wrote:
> 
> > However, the "earlier will override" is very much what you want from a 
> > security standpoint: remember that the git model is that you should 
> > primarily trust only your _own_ repository. So if you do a "git pull", the 
> 
> This concept breaks down somewhat if you are pulling from two
> repositories (one good and one evil). If I pull from the evil repo
> first, that will become my "earlier" object, and I will never get the
> colliding object from the good repo.

Sure. But if you are pulling from an untrusted source, you'd better at 
least check the result.

In fact, that's partly why "git pull" will do a diffstat after the pull. 
Exactly to force people to at least be minimally aware of what they 
pulled. And "gitk ORIG_HEAD.." is a great thing to always run when you 
pull from somebody you don't know and trust really well.

Of course, that all was done mostly not because I don't "trust" the people 
I work with, but more because I didn't always trust that they'd do the 
right thing with git (ie they'd screw up the repo not because they were 
evil, but because they made a mistake).

So even if you pull from an "evil" repo first, and you somehow get a "bad" 
object, the point is, the bad object _should_ be the one that overrides. 

Why? Because once you find out that the evil repo was bad (which you'll 
eventually find simply because it caused some bug - if the evil repo only 
helps you, it's obviously not evil at all), what you need to do is reset 
to _before_ the evil repo happened, do a "git repack -a -d" and finally a 
"git prune" to clean out all the bad cruft, and then pull the good repo 
without pulling the bad one first.

After that, you apologize to everybody for screwing up and pulling from 
somebody you didn't trust, and then ask them to re-clone (or give them the 
appropriate "git reset" + "git repack -a" + "git prune" + "git pull" 
sequence so that they can fix their existing repos).

The point being, a hash attack is really no worse than an attack that 
fools you into applying a really bad diff (regardless of SCM), and it's a 
hell of a lot harder to do. Both a hash attack and a diff attack mean that 
the person merging data should either trust his source or inspect the end 
result.

Anybody who just blindly accepts data from untrusted sources is screwed in 
so many other ways that the hash attack simply isn't even on the radar.

		Linus
