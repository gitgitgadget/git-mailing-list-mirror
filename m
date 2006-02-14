From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 12:40:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602141224110.3691@g5.osdl.org>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
 <87k6bxvmj6.wl%cworth@cworth.org> <Pine.LNX.4.64.0602141026570.3691@g5.osdl.org>
 <87fymlvgzv.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Nicolas Vilz 'niv'" <niv@iaglans.de>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:41:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F96zC-0001dX-1Z
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 21:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbWBNUkp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 15:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbWBNUkp
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 15:40:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48550 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161058AbWBNUkn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 15:40:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1EKeSDZ030979
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 14 Feb 2006 12:40:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1EKeO92025918;
	Tue, 14 Feb 2006 12:40:26 -0800
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87fymlvgzv.wl%cworth@cworth.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16169>



On Tue, 14 Feb 2006, Carl Worth wrote:
> > 
> > What a strange thing to ask for.
> 
> It's pretty common in other tools.

Well, it's pretty common in git too. But in git, the notion of "branch" 
really has been made so cheap that it's basically a no-op.

The "overhead" of creating a branch is literally the cost of writing one 
(small) file.

> In fact, this is the natural operation for the basis of something like
> git-bisect.

Right. And "git bisect" very much does exactly that. It creates a 
temporary branch for bisection (the branch is called "bisect", one of the 
less confusing naming decisions in git ;)

That's really my point. It all boils down to the same three operations: 
"git branch", "git checkout" and "git reset".

In fact, if you look into git-bisect, you'll notice that it doesn't even 
use "git reset" internally. It _literally_ creates a new branch (which it 
does by hand for some strange reason, but never mind) called "new-bisect", 
and then does "git checkout new-bisect" followed by renaming the branch 
back to "bisect" (which it again does by hand).

So "git bisect" may actually get its hands dirty by knowing a bit too much 
about the internal workings of git branches, but conceptually, it really 
does just

	git checkout -b new-bisect <newrev>

to switch its state around.

> But I'd still like to be able to do this without having to invent a
> fake branch name, without the ability to accidentally commit on the
> fake branch, and without the possibility of accidentally leaving those
> commits dangling the next time I seek somewhere else.

Pasky did this before the "multi-branch" thing was common, and calls it 
"cg-seek". 

I think that does exactly what you ask for, I just don't really see the 
point. The downside of cg-seek is that you're really really limited to 
what you can do with it.

For example, it may be "overhead" to have a dummy branch for bisection, 
but it means (for example) that you can actually do real work on the point 
that "git bisect" points you to.

For example, if you hit a compile error, you can _literally_ fix that 
compile error AND COMMIT that state, and when you then mark that commit 
"good" or "bad" when you continue to bisect, bisection will actually do 
the right thing. Something that would be impossible in a "seek" 
environment, where you don't have a branch that you can do development on.

I realize that when you come from an environment where branches are big 
things, this is kind of strange. But in git, a branch is literally a 
single file that is 41 bytes in size. That's it. No more, no less.

		Linus
