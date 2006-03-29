From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How to switch kernel customizations from 2.6.15.6 to 2.6.16?
Date: Wed, 29 Mar 2006 11:27:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603291102440.15714@g5.osdl.org>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
 <Pine.LNX.4.64.0603281749060.15714@g5.osdl.org> <7vlkutc36w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 21:28:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOgKo-0006Ae-3E
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 21:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWC2T1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 14:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWC2T1v
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 14:27:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22244 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750705AbWC2T1v (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Mar 2006 14:27:51 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2TJRkCo020372
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 29 Mar 2006 11:27:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2TJRkKU011105;
	Wed, 29 Mar 2006 11:27:46 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkutc36w.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18177>



On Tue, 28 Mar 2006, Junio C Hamano wrote:
> 
> Having said that, you have been able to say format-patch A..B
> C..D E..F for quite some time (since November 21, 2005).

Yes, and the documentation still talks only about the old insane format..

> Rebase is even more strange, especially with --onto.  When you do
> 
>     $ rebase --onto his origin mine
> 
> in this picture,
> 
>     *---x---x---o---o---o---o
>      \      ^origin         ^mine
>       .---.---.---.
>                   ^his
> 
> you are discarding two 'x' commits, and lost-found is the only
> thing that would help you to recover them.

.. and this is largely because the whole interface is broken.

The breakage shows up as inflexibility and having a hard time explaining 
what the thing does.  It shows up as confusion about the usage, and about 
the meaning of a simple command line.

For example, in the most trivial format, doing a

	git rebase <branchname>

the _logical_ thing (from just reading the command) to believe the above 
does is to think that it rebases the named branch. I pretty much guarantee 
that that is what any native English speaker would think it does, if they 
thought about it.

The fact that it actually does the _reverse_, and rebases not the named 
branch, but the branch you are on right now.

The fact that when things go south, the old branch has gotten lost (unless 
you remember about ORIG_HEAD) is all related to the same thing. It's just 
a very non-intuitive interface.

That was fine when people weren't supposed to use it, and it was doing 
something very very special, but that has clearly changed over time. Now 
people are encouraged to use it, it's pretty well-known, and even new git 
users seem to want to do it.

I think "git rebase" is a lost cause. It's just fundamentally a very very 
badly designed command, because it does everything the wrong way around.

I personally believe that the _sane_ way of doing rebasing is to 
 - get rid of "git rebase" entirely
 - teach "git cherry-pick" to take a _range_ of commits instead.

Lookie here, let's look at your example a bit more (which in turn comes 
from the original question that started this thread):

    *---x---x---o---o---o---o
     \      ^origin         ^mine
      .---.---.---.
                  ^his

We have three branch points, and we want to move the commits on "mine" 
from "origin" onto "his". How would you do this so that it's _not_ 
confusing, and so that you can explain to a newbie user what he is doing, 
_especially_ if things go wrong in the middle?

Right now, the sequence is:

	git checkout mine			# if required
	git rebase --onto his origin

and if things go south during the rebase, it's immediately total chaos, 
and you really _really_ need to understand what you are doing.

The above just doesn't make any sense. It's hard to explain why you would 
do something like that.

In contrast, here's an alternate workflow that is much easier to explain, 
and doesn't involve "rebase" at all:

	git checkout his
	git cherry-pick origin..mine

Notice what this does? Show these two sequences to anybody who has some 
basic familiarity with git terminology, but has perhaps never actually 
used it, and ask them what the two sequences do. I pretty much guarantee 
that the second sequence will make sense and get people to generally pick 
the right answer, while the first sequence will make people maybe _guess_ 
the right answer, but it's not intuitive.

In particular, what do you think happens when a patch in the series 
doesn't apply under the two circumstances? Which workflow has the 
"intuitive" way of recovering, and which does not?

Right. The second one has a very intuitive way to recover. In fact, it's 
so intuitive that the answer may be "ok, I'll skip that one commit 
entirely because I don't know how to resolve it, and instead cherry-pick 
the rest, and ask the original author to cherry-pick it for me later". And 
doing so is as easy as

	git reset --hard	# undo the mess from the failed one,
				# the same way we always do for all
				# other failed things

	git cherry-pick next..mine	# do the rest

See? That's a very logical thing to do. It's different from "git rebase", 
but it's different in a _good_ way.

In contrast, the "rebase" conflict resolution is pretty damn esoteric, and 
using a simple "gitk --all" when things go wrong won't help you pick 
things up at all.

Now, "git cherry-pick" doesn't actually support the above format, and I'm 
not saying that the "git rebase" name itself is evil. I think we could fix 
"git rebase" to work better, but the semantics - the way they are 
_designed_ right now - are just horrible.

			Linus
