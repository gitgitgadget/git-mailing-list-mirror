From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/02/RFC] implement a stat cache
Date: Sun, 20 Apr 2008 09:03:13 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804200836310.2779@woody.linux-foundation.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org>
 <20080420111346.GA13411@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 18:04:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnc1e-0004kj-CB
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 18:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbYDTQDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 12:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754538AbYDTQDg
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 12:03:36 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54344 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754355AbYDTQDe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Apr 2008 12:03:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3KG3FHg013974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 Apr 2008 09:03:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3KG3DMG004869;
	Sun, 20 Apr 2008 09:03:13 -0700
In-Reply-To: <20080420111346.GA13411@bit.office.eurotux.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.931 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79961>



On Sun, 20 Apr 2008, Luciano Rocha wrote:
> 
> That's a lot. Why not use a stat cache?

Well, the thing is, the OS _does_ a stat cache for us, and the one that 
the OS maintains is a lot better, in that it works across processes and is 
coherent with other processes changing things.

And the thing is, your stat cache makes the *common* cases slower. I 
didn't do a whole lot of testing, but on my machine, doing just a "git 
status" with and without your stat cache shows

	Current git 'master':
		real    0m0.302s
		real    0m0.308s
		real    0m0.314s

	With your patch:
		real    0m0.352s
		real    0m0.354s
		real    0m0.355s

iow, it slowed down the case that I think matters more (the one you're 
*supposed* to use, and people most commonly do) by 15%.

Now, admittedly, I also do think that we should generally optimize the 
slow cases more than we should care about things that are already very 
fast, so I do not think that it's wrong to say "ok, let's make the really 
fast case a bit slower, in order to not be so slow in the bad case", so in 
that sense I do not think the slowdown is disastrous.

BUT. 

I really dislike adding a cache that is there just because we do something 
stupid. We can fix the over-abundance of lstat() calls by just being 
smarter. And the smarter we are, the less the cache will help, and the 
more it will hurt. Which is the real reason why I think the cache is a 
really really bad idea: it optimizes for the wrong kind of behavior.

So we have other caches and hashes we use, like the index itself, or the 
name lookup hash into the index, or the delta cache. Maintaining those 
caches takes some effort too, but those caches aren't there because we're 
doing something stupid, they are there because they allow us to do 
something smart.

For example, the index itself actually has really important semantic 
characteristics. And while the name hashing actually improves on index 
lookup performance, I'd never have implemented it if it wasn't for the 
fact that it was also designed to allow us to do case-insensitive lookups. 
And the delta cache is not hiding stupidity, it's literally avoiding very 
expensive work that we can't avoid by being smarter.

So the stat cache is not horribly bad, but I think it's the wrong path to 
go down. 

> With these changes, my git status . in WebKit changes from 28.215s to
> 15.414s.

Of course, one reason I don't think it's such a great idea is that on 
Linux, your stat cache doesn't even then end up helping _nearly_ as much 
as it does on OS X. You see an almost 50% improvement, so the 15% 
*deprovement* may not sound like much to you. But under Linux, the numbers 
are quite different:

"git status ." with your patch:

	real    0m1.043s
	real    0m1.009s
	real    0m0.972s

With my trivial patch that just removed 2 of the 9 lstat calls:

	real    0m1.116s
	real    0m1.115s
	real    0m1.119s

IOW, it does help the "." case on Linux, but only by a fairly small 
amount. In fact, the improvement seems slightly smaller than the 
peformance degradation (~12% vs ~15%), but that is probably within the 
margin of noise, so...

So another reason to avoid the stat cache is that it's really just working 
around an OS X deficiency.

I'd rather work at avoiding more lstat calls. I know we can do it.

			Linus
