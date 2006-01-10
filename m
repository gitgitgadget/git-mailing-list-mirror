From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 11:01:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601101048440.4939@g5.osdl.org>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
 <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org> <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com>
 <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com>
 <252A408D-0B42-49F3-92BC-B80F94F19F40@mac.com> <Pine.LNX.4.64.0601101015260.4939@g5.osdl.org>
 <Pine.LNX.4.63.0601101938420.26999@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	"Brown, Len" <len.brown@intel.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Junio C Hamano <junkio@cox.net>,
	"David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org,
	LKML Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 20:04:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwOmt-0005Sn-7X
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 20:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWAJTEE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 14:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWAJTED
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 14:04:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2957 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751288AbWAJTEA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 14:04:00 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0AJ1XDZ027014
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Jan 2006 11:01:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0AJ1IjC008885;
	Tue, 10 Jan 2006 11:01:22 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601101938420.26999@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14435>



On Tue, 10 Jan 2006, Johannes Schindelin wrote:
> > 
> > Think of it as doing a binary search in a 2-dimensional surface - you 
> > can't linearize the plane, but you can decide to test first one half of 
> > the surface, and then depending on whether it was there, you can halve 
> > that surface etc.. 
> 
> How?
> 
> If you bisect, you test a commit. If the commit is bad, you assume *all* 
> commits before that as bad. If it is good, you assume *all* commits after 
> that as good.

No, that's not how bisect works at all.

It's true that if a commit is bad, then all the commits _reachable_ from 
that commit are considered bad. 

And it's true that if a commit is good, then all commits that _reach_ that 
commit are considered good.

But that doesn't mean that there is an ordering. The commits that fall 
into the camp of being "neither good nor bad" are _not_ ordered. There are 
commits in there that are not directly reachable from the good commit.

> Now, if you have a 2-dimensional surface, you don't have a *point*, but 
> typically a *line* separating good from bad.

Exactly. 

And a git graph is not really a two-dimensional surface, but exactly was 
with a 2-dimensional surface, it is _not_ enough to have a *point* to 
separate the good from bad.

You need to have a _set of points_ to separate the good from the bad. You 
can think of it as a line that bisects the surface: if you were to print 
out the development graph, the set of points literally _do_ form a virtual 
line across the development surface.

(Actually, you can't in general print out the development graph on a 
2-dimensional paper without having development lines that cross each 
other, but you could actually do it in three dimensions, where the 
"boundary" between good and bad is actually a 2-dimensional surface in 
3-dimensional space).

But to describe the surface of "known good", you actually just need a list 
of known good commits, and the "commits reachable from those commits" 
_becomes_ the surface.

> Further, the comparison with 2 dimensions is particularly bad.

No it is not. It's a very good comparison.

In a linearized model (one-dimensional, fully ordered set), the only thing 
you need for bisection is two points: the beginning and the end.

In the git model, you need _many_ points to describe the area being 
bisected. Exactly the same way as if you were to bisect a 2-dimensional 
surface.

Now, the git history is _not_ really a two-dimensional surface, so it's 
just an analogy, not an exact identity. But from a visualization 
standpoint, it's a good way to think of each "git bisect" as adding a 
_line_ on the surface rather than a point on a linear line.

> So, how is bisect supposed to work if you don't have one straight 
> development line from bad to good?

Read the code.

I'm pretty proud of it. It's simple, and it's obvious once you think about 
it, but it is pretty novel as far as I know. BK certainly had nothing 
similar, not have I heard of anythign else that does it. Git _might_ be 
the first thing that has ever done it, although it's simple enough that I 
wouldn't be surprised if others have too.

			Linus
