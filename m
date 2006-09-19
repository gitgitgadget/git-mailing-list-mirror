From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Subversion-style incrementing revision numbers
Date: Tue, 19 Sep 2006 14:51:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609191416500.4388@g5.osdl.org>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 19 23:52:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPnVd-0007fj-Vk
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 23:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbWISVwA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 17:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWISVwA
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 17:52:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47801 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752092AbWISVv7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 17:51:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8JLppnW027667
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Sep 2006 14:51:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8JLpm4K004824;
	Tue, 19 Sep 2006 14:51:48 -0700
To: Joel Dice <dicej@mailsnare.net>
In-Reply-To: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
X-Spam-Status: No, hits=-0.509 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27291>



On Tue, 19 Sep 2006, Joel Dice wrote:
> 
> I'd be happy to put together a patch that implements this, but first I'd like
> to get some feedback.  If something like this has already been proposed,
> please point me to the discussion.  Thanks.

I really don't think you can do it sanely.

The thing is, the reason subversion can do it is simply that SVN is 
terminally broken.

Really. SVN is crap. It may be prettier crap than CVS, but it's literaly 
no different from putting confectioners sugar on top of a cowpatty. It's 
not really "fixing" anything. And the revision numbering is actually very 
much part of the problem.

The thing is, you can limit yourself to a single repository, and once you 
have branches, you _still_ cannot sanely number the commits with anything 
like "r1.3.4.1".

Here's an example. Let's say that you start out with just a regular 
"master" branch, and you number the commits "r1.1", "r1.2" and so on (of 
course, that extra "1." at the beginning doesn't actually make any 
_sense_, but let's keep it just to not confuse CVS/SVN users any more than 
they are already confused).

Now, you've done five commits, and are at "r1.5", and everything looks 
beautiful, and you're getting comfy, so you start and check out a branch 
called "test". What do you call it?

The thing is, you need to call it "r1.5", because the _commit_ is still 
exactly the same as the master one. Creation of a branch in git doesn't 
actually create any new commits, it just creates a new pointer. 

So far so fine. We can ignore that, and make the rules be:

 - when creating a commit, we look at the branch name. If the branch name 
   is "master", we increment the second number, and drop all other 
   numbers.

 - if the branch name is anything else, we look whether the current state 
   is the same any other branch, in which case we just add a ".1" at the 
   end relative to the branch (or a ".2" if a ".1" already exists and so 
   on). Otherwise we increment the last number.

that's not a wonderful set of rules, but it might work. So what happens is 
that when we create the next commit (on the "test" branch), that commit 
will be called "r1.5.1" (which is what you'd expect). Go along a bit, and 
you get "r1.5.2" and "r1.5.3" too. Wonderful.

Now you decide to merge this back into "master". Which, btw, hasn't had 
any actual development happen, so it's stil at 1.5. You check out "master" 
and do a "git pull . test" (or "git pull . r1.5.3", which is obviously the 
same thing), and what happens?

That's right, we now fast-forward master to that revision, since nothing 
happened on master. Which means that your master branch is now comprised 
of revisions "r1.1" .. "r1.5" "r1.5.1" .. "r1.5.3". That makes no sense at 
all, but it works. The next commit would be called "r1.6".

In other words, the SVN numbering is just insane in a git repo, although 
you can "make it work" in a limited sense (but the numbering would jump in 
odd ways. The thing is, all the things that are true in a distributed 
environment are true in a single repository too, so limiting yourself to 
a single repo doesn't really make them go away.

Another thing you CAN do, is to just number them in time in a single repo. 
Every time you do a commit, you can create a "r1.<n+1>" revision, and that 
would work. It wouldn't look like the SVN numbers do, and it would only 
work _within_ that repository, but it would work.

But it would mean that "r1.57" is _not_ necessarily the child of "r1.56". 
It might be that "r1.56" was done on another branch, and is totally 
unrelated to "r1.57" (other than they sharing some common ancestor far 
back).

See? The SVN (and CVS) revision numbering really only makes sense because 
it's fundamentally a non-distributed model.

Git is so _fundamentally_ distributed that even within one single 
repository, each branch is totally independent ("distributed"). In 
CVS/SVN, branches aren't independent of each other, and that's why they 
show up in the revision numbering.

So you can really only number things as long as you never do any branches 
at all, and just do a linear development. In that case, and in that case 
only, does numbering work. Or you'd have to have a very "non-git" approach 
to branches (the above silly rules _can_ be used - possibly with some 
fixes - to give you essentially SVN-like revision numbers, if you _always_ 
generate a commit when you merge).

It doesn't seem to make a whole lot of sense, does it?

Btw, along the same issues, BK actually had RCS/CVS/SVN-like revision 
numbers, but to solve the distributed problem (BK didn't have branches) BK 
had a different approach.

So BK actually _did_ number things as "1.1" and "1.4.6" etc, and was 
obviously distributed, and the revision numbers actually matched the shape 
of the development history the same way CVS/SVN does. But if you do that, 
what happens is that a merge will _change_ the numbers: you may have 
started with two different branches that both were at "r1.2", but at the 
end of it one of them got renamed to "r1.1.1", and the final result was 
called "r1.3".

So if you allow malleable revision numbers, you can definitely do it. That 
ends up being _really_ confusing. I know a number of people who otherwise 
were smart really never understood why "r1.576" might not stay as "r1.576" 
forever, but might suddenly become "1.401.3.55" when merged into another 
repository.

Anyway, what I'm trying to say is that you're probably better off trying 
to get used to the git numbering than trying to force the SVN model. 
You're going to hit a few confusing issues if you really want to call 
things "r1.x.y.z"

			Linus
