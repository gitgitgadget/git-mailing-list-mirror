From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Sun, 27 Jul 2008 22:00:58 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org> <200807260512.40088.zippel@linux-m68k.org> <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 07:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNKv2-0006Zd-Of
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 07:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbYG1FEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 01:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbYG1FEK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 01:04:10 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57693 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751325AbYG1FEJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2008 01:04:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6S53vRo004863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 Jul 2008 22:03:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6S53uQJ021167;
	Sun, 27 Jul 2008 22:03:57 -0700
In-Reply-To: <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.405 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90403>



On Mon, 28 Jul 2008, Roman Zippel wrote:
> 
> Of course I did:
> 
> $ git log --parents --name-only --full-history lib/vsprintf.c | grep -e ^commit | wc -l
> 5929
> 
> This is same amount of commits as for gitk.

OF COURSE it's the same numbr of commits. That's what gitk uses. That's 
what you *have* to use.

You don't actually understand how git works, do you?

> These are the same 20 commits (with parents) from a simple git-log.

So what? The point I tried to make is that _any_ algorithm that gets the 
above case right by actually simplifying the commits "post facto" probably 
gets any case right. You tried to find some more interestign case, but you 
missed the whole point - even the "simple" case is quite hard enough. 

IOW, don't look for anythign more difficult, because if you do, you don't 
understand the problem to begin with!

Do you not understand that the problem is that "post facto" isn't actually 
acceptable? Have you looked at all at the revision reading code? Hmm?

The regular merge simplification does the simplification _before_ it has 
gathered the whole history of commits. And that is really really 
important.

And I realize that you don't even seem to understand the difference. But 
to simplify it for you, let me give you a challenge. Try this:

	time sh -c "git log --parents --full-history lib/vsprintf.c | head"

and if it takes noticeably more than a tenth of a second on my machine, 
you lose.

Because that's roughly what it takes right now, and it's what means that 
effectively the normal log is instantaneous. It's why you can start 
looking at the log without waiting for three seconds, even though the 
_full_ log may take three seconds to compute (ok, on my machine it takes 
2.3s, but whatever).

And it's why gitk can start printing out the history _before_ three 
seconds has passed. And that's really really important.

Try it. Really. Just do "gitk lib/vsprintf.c" and look at how it does 
things incrementally. It doesn't wait for a couple of seconds and then 
show things.

Absolutely EVERYTHING in git would be totally trivial if you did it all 
based on generating first the whole history, and then simplifying it from 
there. But git would be unusably slow in real life, and it would scale 
_horribly_ badly with history size.

So _all_ the normal code actually generates the history INCREMENTALLY, and 
it absolutely _has_ to work that way.

			Linus
