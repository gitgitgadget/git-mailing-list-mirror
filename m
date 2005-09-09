From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFH] Merge driver
Date: Fri, 9 Sep 2005 12:05:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509091151520.23242@iabervon.org>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
 <7v1x407min.fsf@assigned-by-dhcp.cox.net> <431F34FF.5050301@citi.umich.edu>
 <7vvf1cz64l.fsf@assigned-by-dhcp.cox.net> <4320536D.2010706@citi.umich.edu>
 <7v7jdrwlih.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509081012540.3208@g5.osdl.org>
 <43207FE6.2030108@citi.umich.edu> <Pine.LNX.4.58.0509081131070.5940@g5.osdl.org>
 <432089D8.4060507@citi.umich.edu> <7v3boen0rb.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>, cel@citi.umich.edu,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 18:05:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDlJp-0007y3-PI
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 18:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbVIIQBe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Sep 2005 12:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbVIIQBe
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Sep 2005 12:01:34 -0400
Received: from iabervon.org ([66.92.72.58]:13573 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932569AbVIIQBe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2005 12:01:34 -0400
Received: (qmail 4471 invoked by uid 1000); 9 Sep 2005 12:05:33 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Sep 2005 12:05:33 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3boen0rb.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8242>

On Fri, 9 Sep 2005, Junio C Hamano wrote:

> I have several requests to people who are interested in merges
> and read-tree changes.
> 
> I am pretty much set to use the recent read-tree updates Daniel
> has been working on.  The only reason it has not hit the
> "master" branch yet, except that it still has known leaks that
> have not been plugged, is because read-tree is so fundamental to
> everything we do, and I am trying to be extremely conservative
> here.  I've beaten it myself reasonably well and have not found
> any regressions (except removal of --emu23 which I believe
> nobody uses anyway), but I'd appreciate people to try it out and
> see if it performs well for your dataset.
> 
> If you are planning further surgery on read-tree code, please
> base your changes on Daniel's rewrite to avoid your effort being
> wasted.  This request goes both to Chuck (active_cache
> abstraction) and Fredrik (addition of 'ignore index and working
> tree matching rules' [*1*]).
> 
> A proposed merge driver 'git-merge' is in the proposed updates
> branch.  This is intended to be the top-level user interface to
> the merge machinery which drives multiple merge strategy
> scripts, and I am hoping that I can eventually (1) retire
> 'git-resolve' and 'git-octopus' (they simply become merge
> strategy scripts driven by 'git-merge') and (2) call 'git-merge'
> from 'git-pull'.  What I have in the proposed updates branch has
> been fixed since my earlier message to the list and has a new
> merge strategy script, in addition to 'resolve' and 'octopus',
> called 'git-merge-multibase'.  This uses Daniel's read-tree that
> can use more than one merge bases.  I request Daniel to give OK
> to its name or suggest a better name for this script -- I would
> even accept 'git-merge-barkalow' if you want ;-).

I'd actually been thinking it would just go into the the "resolve" driver, 
with that going back to before it chose among merge-base outputs and just 
sending the whole list to read-tree.

> If you are planning to implement a new merge strategy, please
> use the ones in the proposed updates branch as examples, and
> complain and suggest improvements if you find the interface
> between the strategy scripts and the driver lacking.  This
> request goes primarily to Fredrik.  I'm interested in doing the
> renaming merge that would have helped HPA's klibc-kbuild vs
> klibc case myself but if somebody else is so inclined please go
> wild.
> 
> And finally, a request to everybody; please try out 'git-merge'
> and see how you like it.
> 
> `git-merge` [-n] [-s <strategy>]... <msg> <head> <remote> <remote>...
> 
> -n::
> 	Do not show diffstat at the end of the merge.
> 
> -s <strategy>::
> 	use that merge strategy; can be given more than once to
> 	specify them in the order they should be tried.  If
> 	there is no `-s` option, built-in list of strategies is
> 	used instead.
> 
> <head>::
> 	our branch head commit.
> 
> <remote>::
> 	other branch head merged into our branch.  You need at
> 	least one <remote>.  Specifying more than one <remote>
> 	obviously means you are trying an Octopus.
> 
> Here is a sample transcript from a test resolving one of the
> 'more-than-one-merge-base' commits Fredrik found in the kernel
> repository (": siamese;" is my $PS1; "  " is my $PS2).
> 
>     : siamese; git reset --hard b8112df71cae7d6a86158caeb19d215f56c4f9ab
>     : siamese; git merge -n \
>       'reproduce 0e396ee43e445cb7c215a98da4e76d0ce354d9d7' \
>       HEAD 2089a0d38bc9c2cdd084207ebf7082b18cf4bf58
>     Trying merge strategy resolve...
>     Trying to find the optimum merge base.
>     Trying simple merge.
>     Simple merge failed, trying Automatic merge.
>     Removing drivers/net/fmv18x.c
>     Auto-merging drivers/net/r8169.c.
>     merge: warning: conflicts during merge
>     ERROR: Merge conflict in drivers/net/r8169.c.
>     Removing drivers/net/sk_g16.c
>     Removing drivers/net/sk_g16.h
>     fatal: merge program failed
>     Rewinding the tree to pristine...
>     Trying merge strategy multibase...
>     Trying simple merge.
>     Simple merge failed, trying Automatic merge.
>     Removing drivers/net/fmv18x.c
>     Auto-merging drivers/net/r8169.c.
>     merge: warning: conflicts during merge
>     ERROR: Merge conflict in drivers/net/r8169.c.
>     Removing drivers/net/sk_g16.c
>     Removing drivers/net/sk_g16.h
>     fatal: merge program failed
>     Rewinding the tree to pristine...
>     Trying merge strategy octopus...
>     Rewinding the tree to pristine...
>     Using the multibase to prepare resolving by hand.
>     Trying simple merge.
>     Simple merge failed, trying Automatic merge.
>     Removing drivers/net/fmv18x.c
>     Auto-merging drivers/net/r8169.c.
>     merge: warning: conflicts during merge
>     ERROR: Merge conflict in drivers/net/r8169.c.
>     Removing drivers/net/sk_g16.c
>     Removing drivers/net/sk_g16.h
>     fatal: merge program failed
>     Automatic merge failed; fix up by hand
>     : siamese; git-update-cache --refresh
>     drivers/net/r8169.c: needs update
>     : siamese; echo $?
>     1
>     : siamese; git diff -r 0e396ee43e445cb7c215a98da4e76d0ce354d9d7
>     :100644 100644 ce449fe 0000000 M	drivers/net/r8169.c
>     : siamese; exit
> 
> In the above example, 'resolve', 'multibase' and 'octopus' are
> tried in turn (actually, 'octopus' notices that it is given only
> one <remote> and refuses to do anything without wasting time).
> Since all of these strategies fail to fully auto-merge the given
> heads, and 'multibase' gives the smallest number of conflicts,
> its result is left in the working tree for the user to resolve
> by hand.  You resolve this and commit the same way as you
> currently do with 'git-resolve' that results in conflicts.

This is no good: the current 'resolve' can generate wrong results and 
report that it worked cleanly, while 'multibase' would report a conflict 
because it isn't ignoring a real problem. My primary goal in doing the 
multibase version wasn't to produce more clean merges; it was to produce 
fewer clean-but-wrong merges.

> [Footnote]
> 
> *1* Fredrik, I have been wondering if we can just say that lack
> of '-u' flag implies '-i'.  Is there a good reason that
> 'git-read-tree -m O A B' without '-u' should care if working
> tree is up to date for the paths involved?

It tries to make sure that there is room to put stuff for resolving a 
conflict without messing with modified files in the directory.
