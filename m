From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-bisect failed me again
Date: Fri, 12 May 2006 08:45:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605120823170.3866@g5.osdl.org>
References: <20060512000249.71933599.akpm@osdl.org> <Pine.LNX.4.64.0605120738190.3866@g5.osdl.org>
 <20060512081207.6cd701f9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 12 17:45:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeZpZ-0003Wl-45
	for gcvg-git@gmane.org; Fri, 12 May 2006 17:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWELPp0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 May 2006 11:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWELPp0
	(ORCPT <rfc822;git-outgoing>); Fri, 12 May 2006 11:45:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38843 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751210AbWELPpZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 May 2006 11:45:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4CFjLtH014094
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 May 2006 08:45:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4CFjKFV017982;
	Fri, 12 May 2006 08:45:21 -0700
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060512081207.6cd701f9.akpm@osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19917>



On Fri, 12 May 2006, Andrew Morton wrote:
>
> Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> >  Anyway, my first guess would be that you might have marked something good 
> >  or bad that wasn't. How sure are you about that initial "git bisect bad" 
> >  you did?
> 
> Am pretty confident.

And I'm pretty damn sure it ain't.

Andrew, git is _not_ linear. You can't just list the commits, take the 
last and the first, and say "the last must be bad, the first must be 
good". Which seems to be what you did.

> 
> 
> bix:/usr/src/25> grep '^commit ' patches/git-acpi.patch 
> commit 9011bff4bdc0fef1f9a782d7415c306ee61826c9		<- This was my `bad'
> commit 5d882e684aafea30c508d86d235327d94e1d38ae
> commit 14394600cdfe0c952ce662a32a68c5c5524d32ac
> commit da95181baf3cf6a2bd81c0c8af1d4c6790703e4f
> commit b128440ed11d108c375772b7fe9ad46d2ac07084		<- This was the bug

That "b128440e.." commit wasn't even among the collection of commits that 
you tested with "git bisect" in the first place. 

You've apparently created a "list of commits" that doesn't include any 
merges, and then you decided that the "most recent of those commits was 
obviously bad".

WHICH IS NOT TRUE.

You never actually even TESTED that 9011bff commit, did you? In fact, I'm 
100% sure you didn't. You just said "it's bad", without any confidence 
what-so-ever except that it happened to be first on your list.

Right?

The fact is, it seems that the way you generated the list of commits was 
basically:

 - pick every commit that is not a merge and doesn't exist in linus tree.

   (ie you basically did the equivalent of "git-rev-list --no-merges 
   linus..acpi", although it's possible that you used "git whatchanged" or 
   something else that will not show merges because they don't generate 
   diffs)

And then you believed that you had a linear series of commits, and that 
the most recent commit must thus be the buggy one.

But git isn't linear. Never has been. The fact that commits get (roughtly) 
sorted by date (modified by their ancestry relationships either subtly or 
grossly depending on whether --topo-sort is off or on) does not make 
anything linear.

The commit you mark as "this was the bug" is on a totally different 
development branch from the one you marked "bad". That development branch 
was merged with the branch that your "bad" commit came from with commit 
7378614.. (which is not on your list at all):

	"Pull bugzilla-5737 into test branch"

but there are actually a few other merges there too (and ACPI-only commits 
that aren't reachable from your "top" bad commit).

> and git-bisect claimed that 9011bff4bdc0fef1f9a782d7415c306ee61826c9
> introduced the bug.  

Hell no. Git bisect did no such thing at all. YOU DID.

Go back and look at what your sequence of instructions was (from your 
original email):

 ->> Trying to find a recently-merged box-killer in Len's tree:
 ->> 
 ->> bix:/usr/src/git26> cat .git/branches/git-acpi 
 ->> git+ssh://master.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git#test
 ->> 
 ->> git-checkout git-acpi
 ->> git-bisect reset
 ->> git-bisect start
 ->> git-bisect good ff2fc3e9e3edb918b6c6b288485c6cb267bc865e
 ->> git-bisect bad 9011bff4bdc0fef1f9a782d7415c306ee61826c9
 ->> 
 ->> And it led me to

and notice how YOU claimed that "9011bff4.." was bad at the very
beginning of the "git bisect" run.  Not "git bisect". YOU. You started off 
by claiming that 9011bff4 was bad, apparently without having ever even 
tested it.

The way "git bisect" works is that if you give it garbage information, it 
_will_ give you a garbage result. That's pretty much guaranteed. But if 
you actually give it tested and correct information, it will very 
efficiently zero in on what the problem really was.

And the whole _point_ about "git bisect" is that the git history isn't 
linear. If it was linear, you wouldn't need a tool to bisect it at all: 
you'd just pick the middle entry from the history list, and use it. It 
would be so trivial to bisect by hand, that using a tool is just 
unnecessary.

So really, take a look at "git bisect visualize". In this case, you should 
have noticed that you had a list of 50+ commits, but when you did

	git bisect good ff2fc3e
	git bisect bad 9011bff
	git bisect visualize

you had cut your list of commits down to just six (none of which was the 
bug).

This is why I integrated "gitk" immediately when it became available. It's 
really important to see the non-linear history, because if you don't 
visualize it (either mentally or with a tool like "gitk"), you'll never 
understand what is going on. 

		Linus
