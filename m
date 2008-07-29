From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Tue, 29 Jul 2008 10:25:35 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807291006070.3334@nehalem.linux-foundation.org>
References: <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
 <20080729053108.GH26997@sigill.intra.peff.net> <Pine.LNX.4.64.0807291339580.6791@localhost.localdomain> <20080729125247.GC12069@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 19:30:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNt1N-00032v-Gq
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 19:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbYG2R3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 13:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752703AbYG2R3A
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 13:29:00 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47158 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752495AbYG2R27 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 13:28:59 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6THSZ6t004202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2008 10:28:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6THSYNN012223;
	Tue, 29 Jul 2008 10:28:34 -0700
In-Reply-To: <20080729125247.GC12069@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.408 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90659>



On Tue, 29 Jul 2008, Jeff King wrote:
> 
> I glanced briefly over "gitk kernel/printk.c" and it looks pretty sane.

Jeff, it _is_ sane. When Roman says it's "incorrect", he is just wrong.

But it's true that "gitk kernel/printk.c" does simplify the history, and 
does so very aggressively. It does so very much by design, and has done it 
since pretty much day one. And it's a good thing - and it is "correct" - 
but it does mean that you may literally be missing things that are part of 
"history" but that didn't matter much.

The most trivial way to show this is actually by making such a simple case 
that it's obvious what is going on. Do this:

	mkdir test-simplification
	cd test-simplification
	git init
	echo "Hi there" > file
	git add file
	git commit -m"Initial file"

	git branch other-branch

	echo "Hello" > file
	git add file
	git commit -m"Modified file"

	git checkout other-branch

	echo "Hello" > file
	git add file
	git commit -m"Another person modified the file identically"

	echo "This is a stupid example" > another-file
	git add another-file
	git commit -m"Add another file"

	git merge master

Now, do these three things

	gitk
	gitk file
	gitk --full-history file

and compare them. They all show _different_ histories.

Which one is "correct"? They all are. It just depends on what you want to 
see.

The "gitk file" history is the simplest one BY FAR, because it has very 
aggressively simplified history to the point where it tried to find the 
_simplest_ history that explains the current contents of 'file'[*]

>From a practical standpoint, and from having used this a long time, I'd 
argue that the simple history is the one that you want 99.9% of all time. 
But not _always_. Sometimes, the things that got simplified away actually 
matter. It's rare, but it happens.

For example, maybe you had a bug-fix that you _know_ you did, and it it 
doesn't show up in the simplified history. That really pisses you off, and 
it apparently really pisses Roman off that it can happen. But the fact is, 
that still doesn't mean that the simple history is "wrong" or even 
"incomplete".

No, it's actually meaningful data in itself. If the bug-fix doesn't show 
in the simplified history, then that simply means that the bug-fix was not 
on a branch that could _possibly_ have mattered for the current contents. 

So once you are _aware_ of history simplification and are mentally able to 
accept it, the fact that history got simplified is actually just another 
tool.

And that's why "-full-history" and "git whatchanged" exist. They are ways 
to start delving deeper - they shouldn't be the _default_ mode, but they 
are ways to show more information when the initial default simple mode 
turns out to show that something didn't even matter for the end result.

And yes, there is a mid-way point between "aggressive simplification" 
(default) and "no simplification at all" (--full-history). It's more 
complex than either, and I do think it would be useful to have. It's what 
Roman wants, but as long as he thinks it's the _only_ correct answer, and 
refuses to face the performance issues, the discussion with Roman is kind 
of pointless.

			Linus

[*] when I say "_simplest_ history", I do want to point out that the 
history simplification is always a "local optimization", and it doesn't 
try to check all possible paths: there can be other histories that are 
even simpler on a global scale.

But in practice it is _one_ history of the file, and it's a history that 
is not "unnecessarily complicated" considering the simple heurstics for 
finding it.

So think "local minima" instead of "global minima", and in practice the 
local one is pretty close to the global one, although there are obviously 
always extreme cases where the two can differ by a whole lot.
