From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Wed, 20 Dec 2006 23:51:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612202317110.3576@woody.osdl.org>
References: <4589F9B1.2020405@garzik.org> <4589FD9E.2010000@bellsouth.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Thu Dec 21 08:51:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxIiQ-000710-4R
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 08:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422826AbWLUHvd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 02:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422827AbWLUHvd
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 02:51:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46697 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422826AbWLUHvc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 02:51:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBL7pM2J003204
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Dec 2006 23:51:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBL7pKAI019176;
	Wed, 20 Dec 2006 23:51:21 -0800
To: Jay Cliburn <jacliburn@bellsouth.net>
In-Reply-To: <4589FD9E.2010000@bellsouth.net>
X-Spam-Status: No, hits=-0.649 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35024>



On Wed, 20 Dec 2006, Jay Cliburn wrote:
> 
> $ git diff $(git merge-base master driver)..driver

Be careful. This ONLY works if you don't have criss-cross merges etc, so 
you need to be somewhat careful about it. If you end up having a complex 
merge history between the origin branch and your development tree, things 
will stop working

So it's actually worth understanding what the above does.

Here's the picture to keep in mind: you started off with something like 
this:

	<- older			newer ->

	..--A---B---C---D

where the top commit was D, and you started doing your own work off there. 
However, the tree you are tracking (doing "git fetch origin" or somethng) 
ALSO continues, so soon enough you'll have a history that looks like

	<- older			newer ->

	..--A---B---C---D---E---F---G---H <-"origin"
	                 \
	                  --X---Y---Z <- your "driver" branch"

where your work is the "X-Y-Z" sequence.

How, the reason you must NOT do

	git diff origin..driver

or something like that, is that it will LITERALLY do a diff between those 
two heads. And while that is a perfectly normal diff, it's not what you 
want: it's the diff between the up-stream work and yours, and it will show 
that a lot of work has _not_ happened in your branch (all the E-F-G-H 
stuff), and then you've added some work (X-Y-Z).

What you obviously WANT to have is the "diff" between "D" (which was the 
point where you started) and "Z" (which is where you are now. That's what 
you want to send up-stream.

Now, the way people used to do this under CVS, was to simply _remember_ D. 
Preferably by doing a tag at the point where they started working. Then 
you can always diff against that tag.

You can do that in git too, of course, but it would just be stupid. 
Because git actually _knows_ the history, so you can just ask git

	"What is the most recent commit that both 'origin' and 'driver'
	 have in common?"

the answer, of course, is the very commit you want: D. And how do you ask 
for that "most recent common commit"? That's right: it's called the "merge 
base", because it's also the thing you'd use as the base in a bog-standard 
three-way merge.

So "git merge-base origin driver" just returns "D", without you having had 
to tag it or remember it at all.

So when you do

	git diff $(git merge-base origin driver)..driver

you're literally asking for the diff between your current top of the 
"driver" branch, and the place where you diverged from "origin".

Now, why do I mention the fact that THIS DOES NOT WORK if you do merges 
and you no longer have a linear tree? Think about it. If you actually ever 
pull on the up-stream and create a merge in your development tree, the 
commit history graph will now look something like this:

	<- older			newer ->

	..--A---B---C---D---E---F---G---H <-"origin"
	                 \        \
	                  --X---Y--M--Z <- your "driver" branch"

where the "M" commit is because you merged some new work from origin.

But see what that did to the most recent commit? Now, the most recent 
commit is no longer "D". In fact, it's not even your "merge" commit, if 
you think about it (even though you might naively think so), because that 
merge commit doesn't even exist in "origin", so clearly it cannot be the 
most recent common commit.

The most recent commit in common is "F". So now,

	git diff $(git merge-base origin driver)..driver

will give the difference between _F_ and your current tip Z.

The thing is, THIS IS STILL THE RIGHT THING TO DO. It's magic. Since you 
did a merge in M, all the things up until F have been merged into Z too, 
so you actually NO LONGER want to diff against D. Nor do you want to diff 
against M (since that would mean that you would not see the work you did 
in X and Y). 

By doing a diff against F (and your own merge having done the right 
thing), you actually end up getting the "union" of work for X-Y-Z when you 
do that magic command line.  If you had done it against D, you'd have seen 
the work in E and F that the merge M brought in - but you don't want that, 
because you want just the work YOU did, not anything in "origin".

So what you want is actually exactly again the most recent common commit.

HOWEVER. While it magically "just works" in things like this, it doesn't 
actually work for the really complex cases. If I've merged an eariler 
version of your work AND you did a merge from me too, you can have a 
criss-cross merge where there simply isn't one "most recent common commit" 
at all any more, but two or more. And then you really do need to do more.

This is one reason why I suggest developers not merge from me very often: 
if your development tree is just a straight line (ie you only had that one 
merge), you can't ever even get in that situation, and perhaps as 
importantly, if/when I pull from you, the result will also tend to look 
more understandable to people who look at the history.

But another way to avoid a criss-cross merge is actually to never let me 
see your tree at all, and then you can merge with me as often as you damn 
well like. And in that case, the magic

	git diff $(git merge-base origin driver)..driver

is always going to give you exactly what you want. You can use merges to 
keep up-to-date, and always see what you want to send off by email 
upstream. The history will look like crap (you'll end up having a ton of 
merges in your tree), but if you aren't going to publicise your history 
anyway (just the diff end result), why would you care?

(And yes, you can actually do "git diff origin...driver" with _three_ 
dots. I'm not even going to explain _why_ that works, because that's a 
whole other kettle of fish, and is actually a magic special case in 
builtin-diff.c. So feel free to use it because it's short and sweet, but 
the long format is actually easier to explain what it actually MEANS).

		Linus
