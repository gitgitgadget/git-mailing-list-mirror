From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb.cgi history not shown
Date: Sun, 11 Jun 2006 09:19:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606110902090.5498@g5.osdl.org>
References: <e5bfff550606102231o756f6d11lc46fecdad29568c0@mail.gmail.com> 
 <Pine.LNX.4.64.0606102248360.5498@g5.osdl.org>
 <e5bfff550606102332v6afb7d51m43ad5d74ba226cf0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 11 18:19:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpSei-0006kA-R0
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 18:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWFKQTO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 12:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWFKQTO
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 12:19:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750802AbWFKQTN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 12:19:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5BGJ7gt020846
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Jun 2006 09:19:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5BGJ6oO025659;
	Sun, 11 Jun 2006 09:19:06 -0700
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550606102332v6afb7d51m43ad5d74ba226cf0@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21659>



On Sun, 11 Jun 2006, Marco Costalba wrote:
> 
> Why I still get empty results if I run git-rev-list from gitweb merge point?

Because the rename happened _inside_ the merge. 

So when you give the revision 0a8f4f00, that really means the state 
_after_ the merge. At that point, the filename doesn't actually exist.

git-rev-list then looks at the parents, one by one, and sees that the 
first parent _matches_ the state as far as your path spec is concerned (in 
this case, it matches "it was empty before, it was empty after"), so it 
will literally _always_ pick the parent that you're not interested in 
(regardless of whether it would have been merged into, or was the one that 
got merged), because that's the one with the minimal history difference.

Going the other way (the way you actually wish it went) would have 
introduced more history changes that aren't needed to explain the final 
state, so git-rev-list - by virtue of trying to generate a _minimal_ 
history - will actively avoid it.

> Is this because path changed: gitweb.cgi -> gitweb/gitweb.cgi

Well, in one sense yes, but in a much more fundamental sense that rename 
really has nothing to do with the real issue.

The real issue is that you asked how the state of a non-existent file came 
to be, and git-rev-list told you the simplest answer: it never existed at 
all.

And that answer is actually _true_. Along one history, that filename never 
existed.

And this really has nothing to do with renames. You can see the exact same 
thing with files that are there. Let's take an example:

	   A	<-- top of tree
	  / \
	 B   C
	 |   |
	 D   E
	  \ /
	   F
	   |
	   .	<-- old history
	   .

Let's say that you have had a file called "file" for all of history, and 
it got changed sligtly differently in _all_ commits B, C, D _and_ E.

Now, despite all the different changes, let's say that the end result was 
identical in B and C - even though the diffs of those two commits were not 
necessarily the same (because they started out from different points: D 
and E respectively). 

In other words, there was a branch, but both branches ended up fixing the 
same bug the same way (and this is less unusual than you'd think, even if 
they are independent, but even more so if the branches "knew of each 
other" some other way, ie the developers talked about the problem and 
perhaps sent patches back-and-forth that both people applied).

What do you think git-rev-list will do when you give it that "file" as a 
path limiter?

What it will do is to notice that merge A has the same state (wrt that 
file) as commit B (it's first parent), SO IT WILL TOTALLY IGNORE THE WHOLE 
HISTORY THAT IS REACHABLE FROM C.

So git-rev-list will first simplify the tree to just A -> B -> D -> F .., 
and then, since A and B were identical in the path (and let's say F was 
identical to it's parents too), it will actually decide that as far as 
those commits were concerned, nothing changed, so the actual end result is 
just "B -> D -> ...", and none of A, C, E and F show up at all, even 
though both C and E really did change something (they just didn't 
_matter_, because all the changes could be explained by just picking B and 
D).

See? No renames. The renames is not what is fundamental here. What is 
fundamental is the _STATE_ of the tree. Remember: that's what git tracks, 
and that is what "git log" shows you.

So when you do

	git log -- gitweb.cgi

you're really asking for: "Please explain the state of the current tree 
with regards to gitweb.cgi that doesn't exist at this point in time". And 
that's _exactly_ what "git log" will do. It will say "hey, I can explain 
it by the file not existing in one of the previous parents either: maybe 
it got removed there", and walk back as far as it possibly can to explain 
that the file doesn't exist.

And it turns out that it can walk all the way back to the root, and the 
file didn't exist there, so the end result is what? The empty set. 

			Linus
