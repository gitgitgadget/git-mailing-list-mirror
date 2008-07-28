From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Sun, 27 Jul 2008 22:30:59 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807272206480.3486@nehalem.linux-foundation.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org> <200807260512.40088.zippel@linux-m68k.org> <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 07:36:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNLPF-0006l1-1h
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 07:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbYG1FeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 01:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbYG1FeK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 01:34:10 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57810 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750920AbYG1FeJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2008 01:34:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6S5XwEs006293
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 Jul 2008 22:33:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6S5Xwsu022157;
	Sun, 27 Jul 2008 22:33:58 -0700
In-Reply-To: <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.404 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90404>



On Sun, 27 Jul 2008, Linus Torvalds wrote:
> 
> And it's why gitk can start printing out the history _before_ three 
> seconds has passed. And that's really really important.

Btw, the reason it's really really important is that "three seconds" can 
actually easily be "three minutes" - if the project is big, or if you 
simply don't have everything in the cache, so you actually need to do tons 
of IO to generate the whole history.

So every normal operation absolutely _must_ be incremental and not rely on 
any calculation of the whole history in order to then simplify it.

Of course, post-processing is fine for some things. For example, in the 
thread I pointed you to originally (see filter-branch + full-history in 
google, or look in some git archive) I suggested a post-processing of the 
merge history for filter-branch. I suspect it's very acceptable for _that_ 
kind of use to "batch" things up and not do them with partial knowledge.

But this incremental thing is why I for example suggest people should use 
"git gui blame" instead of "git blame" when looking for problems - because 
the latter cannot be done incrementally, and as a result can cause really 
irritating delays (exactly because it basically needs to synchronously 
walk back to the beginning of history).

The kernel repo, btw, is pretty small in this regard. The cases that 
caused much more pain were the insane KDE ones that were something like 
ten times the size. We've optimized things pretty aggressively, but...

Btw, if I sound irritated, it's because we had all these discussions about 
three _years_ ago when git got started. This is not a new issue. It's 
hard.

I've been pushing on people to do things incrementally very hard over the 
last few years because it's such a _huge_ usability issue.

For example, I've pointed you to the incremental nature of "gitk" as an 
example of how things should work, but that's actually fairly recent: it 
wasn't that long ago that "gitk" used to pass in "--topo-order" or 
"--date-order" to the core git revision machinery, and that actually is 
another of those "global" operations that you need the whole history for.

So gitk actually used to pause for three seconds (or ten. or thirty) 
before it would show the results. I'm really happy to report that Paul 
finally did the (trivial) topo-sort in gitk, meaning that he could re-sort 
it as necessary and keep things incremental. It was one of my biggest UI 
gripes for the longest time (and I wasted time adding a special "partial 
output mode" that gitk didn't even then end up using because Paul did 
things the right way).

Btw, from a git log viewer standpoint, the "merge history simplification" 
is all the exact same problem as the "--topo-order" flag is: you could 
use the (incremental and very verbose)

	git log --full-history --parents

output as the base-line, and then you could do the commit simplification 
of things interactively.

But "git log" itself cannot do it by default, since that would mean that 
git log itself would have to wait for the whole history to be generated. 

That's because output to a pipe is fundamentally linear (ie it cannot 
"re-write" the things it has already shown as it finds a simplification: 
there is no incremental way to rewrite things "after the fact").

			Linus
