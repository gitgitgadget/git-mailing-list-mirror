From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 14:52:37 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808231440530.3363@nehalem.linux-foundation.org>
References: <20080822174655.GP23334@one.firstfloor.org>  <m37ia8sv49.fsf@localhost.localdomain>  <20080823071552.GU23334@one.firstfloor.org>  <200808231121.41694.jnareb@gmail.com>  <20080823165350.GY23334@one.firstfloor.org>
 <4d8e3fd30808231404y7293eb56g4fbed5565ab2aa9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andi Kleen <andi@firstfloor.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 23:53:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX13N-0007zu-Qi
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 23:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbYHWVwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 17:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752882AbYHWVwp
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 17:52:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55763 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752289AbYHWVwo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Aug 2008 17:52:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7NLqcWc024501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 23 Aug 2008 14:52:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7NLqbYL002821;
	Sat, 23 Aug 2008 14:52:37 -0700
In-Reply-To: <4d8e3fd30808231404y7293eb56g4fbed5565ab2aa9a@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.429 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93492>



On Sat, 23 Aug 2008, Paolo Ciarrocchi wrote:
>
> you got nice and detailed answers,  for example you can track a
> rebased tree in your working directory using git pull --rebase.
> What's wrong with that?

No, you really really cannot do that.

If the _tree_ you are tracking is itself rebasing (not just your own 
tree), then you cannot and absolutely SHOULD NOT use rebase (not directly, 
and not with "git pull --rebase".

Why?

Let's look at what happens. Let's say that your history looks like

	... -> A -> B -> C -> a -> b -> c

where the upper-case letters are from the tree you track, and the 
lower-case letters are the commits you added yourself.

Now, let's say that the tree you track gets rebased, and in the process 
'B' is removed (because it turns out it was buggy), and A and C get 
modified. What happens?

You now have

	... -> A -> B -> C -> a -> b -> c     <- your branch
	  \
	    other stuff -> A' -> C'     <- newly rebased branch

(where "other stuff" is whatever the remote branch was rebased on top 
of) and when you now try to rebase your stuff on top of the newly rebased 
branch, you are going to end up trying to rebase all the _old_ commits 
that weren't even yours (ie it's going to try to rebase A, B and C too!)

And that's not what you want! It will potentially not only generate lots 
of conflicts (because A' and A aren't the same, and C' and C aren't the 
same), and it will actually re-insert B - which was buggy - before it 
finally gets to the commits _you_ actually did (a, b and c).

So no, you canno even sanely rebase on top of another persons rebased 
tree, because the _other_ person threw away his history, and since you 
remember their _old_ history, it's basically now you who are in charge of 
it.

What you can do is to basically do

	git fetch nasty-tree
	git rebase C.. --onto nasty-tree

ie you can explicitly _tell_ rebase which commits you want to rebase. 
Obviously, "git rebase --interactive" can help you do this (ie you can get 
the whole list and edit out all the crud that you know isn't yours).

But this is why working on top of somebody elses tree that gets rebased is 
so hard. You lose all the history, because the other person basically 
threw it away and started over.

Don't get me wrong - it's _possible_ to do. See above about how you can 
pick-and-choose the parts you decide you want to keep (your "own" stuff). 

In fact, we could even do a form of "rebase" that only picks commits that 
you committed yourself, and call it "git rebase --my-commits nasty-tree", 
and that would often do the right thing (assuming the source tree only 
ever rebases its own commits, of course! If it rebases other peoples 
commits, it's so terminally broken that you should just refuse to work 
with that tree, and shoot the maintainer)

So we could do more helper functions for this, but the fact is, it's a 
really broken model. The real fix is to teach people not to rebase.

			Linus
