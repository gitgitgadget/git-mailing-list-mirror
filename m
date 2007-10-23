From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: unmerging feature branches
Date: Tue, 23 Oct 2007 12:38:26 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710231221530.30120@woody.linux-foundation.org>
References: <20071023152445.GA10070@piper.oerlikon.madduck.net>
 <alpine.LFD.0.999.0710230922240.30120@woody.linux-foundation.org>
 <20071023171611.GA18783@piper.oerlikon.madduck.net>
 <alpine.LFD.0.999.0710231026011.30120@woody.linux-foundation.org>
 <20071023180825.GA20343@piper.oerlikon.madduck.net>
 <alpine.LFD.0.999.0710231115060.30120@woody.linux-foundation.org>
 <20071023191738.GA24575@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 21:39:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkPbE-0001k3-9r
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 21:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbXJWTjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 15:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753010AbXJWTjX
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 15:39:23 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59653 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752302AbXJWTjW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2007 15:39:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NJcRgt002650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Oct 2007 12:38:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NJcQBn003091;
	Tue, 23 Oct 2007 12:38:26 -0700
In-Reply-To: <20071023191738.GA24575@piper.oerlikon.madduck.net>
X-Spam-Status: No, hits=-2.72 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62152>



On Tue, 23 Oct 2007, martin f krafft wrote:
> 
> I don't follow what you mean with "shape". The following is
> a history:
> 
>  o - x - o - o - o - m - o - A* - o - m2 - o - master
>       \             /                /
>        `o - A - L -' - F - o - o - T' - branch

Right. And you can do two things when merging:

 - the wrong and insane thing: look at the *contents* of each commit, to 
   decide if a commit does a certain thing.

 - the git thing: never look at individual commits at all, except to find 
   the global history, what I called the "shape".

So git obviously very much *does* look at history,  but it does so only to 
find the common point. So in when you create "m2", it looked at the 
history to see that the common point of the two branches was "L". And once 
it has found that, all the other stuff is totally irrelevant. It doesn't 
matter if there are a million commits between 'm' and 'm2', the only thing 
that mattered was the "topology" aka "shape" of the history.

See?

So git never actually cares about the individual commits A*, F, and T (or 
anything else) when it merges those two histories and created "m2".

It did *traverse* those commits, in order to find that "Oh, the last 
common state was 'L'", but it never looked at them in any other sense. 
They were all individually uninteresting, and the only sense in which they 
mattered at all was as the incidental building blocks of the history.

That's what I mean by the "shape" of the history: when merging git does 
walk the commits to see how it all holds together, but git doesn't then 
care in any way what the commits *do* apart from how they connected up 
the history of the two branches.

And once git has found the common commit, it then just merges purely based 
on the contents of the common commit and the two (or more, in the case of 
octopus merges) endpoints. So again, at that point it never looks at any 
of the individual commits, it only looks at what the *state* was.

(This is all a bit more complex when thers is more than one "common 
commit", but that's just a detail, and doesn't change the argument).

And git-rebase is obviously totally different: git-rebase also finds the 
common points, but uses that to just discard all the shared history that 
cannot matter, and then it walks all the *unshared* commits to match them 
up and see which ones already look like they exist (as another commit, but 
one that has the equivalent diff!), and which ones are worthy of trying to 
add.

> A is a commit, A* is the commit which reverts (the data change by)
> A. L and F are to mark the last and first commits before and after
> the first merge m. T is the tip of 'branch'
> 
> After merge point m2, the change introduced by A will *not* be in
> master. This much makes sense.

Yes.

> What did not make sense is how Git determines to leave it out. But
> I think that after drawing the above, it's now clear:
> 
> by shape you mean the actual graph, and when 'branch' is merged into
> master at m2, Git goes back in time to conclude that master...L must
> already be present in master due to the intersection of the two
> lines at m, and thus finds commit F as the "oldest direct
> descendant" of m2. L is an older descendant of m2, but it's not
> direct in the sense that there are multiple paths from m2 to L. Thus
> Git will only merge F..T at m2.

Exactly.

> Or as you put it:
> 
> > If Foo has had *new* commits in the meantime, those new commits
> > will show up, of course, but the old commits have absolutely zero
> > effect, because they will be part of the common history.
> 
> I think I am (moderately) clear again on the inner working of Git.
> Sorry for the confusion.

Hey, I think these things are good to clarify, maybe somebody else didn't 
quite understand it. And the more "graphical" and concrete some problem 
is, the more likely people are to "get it". 

What is interesting is how the actual rules that git follows are *really* 
simple. But they result in all this fairly complex, almost "emergent" 
behaviour. It's like the basic data structures: in many ways, git really 
only has those four basic object types, and you can really descibe 
everything git does in terms of those very simple core data structures: 
but a *repository* is certainly not something simple.

But the final "behaviour" really all comes from the interactions of 
things. The rules are all really really simple, the data structures are 
all totally trivial, but the possibility for interactions causes all the 
excitement.

			Linus
