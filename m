From: Bram Cohen <bram@bitconjurer.org>
Subject: Re: Merge with git-pasky II.
Date: Tue, 26 Apr 2005 11:55:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0504261129500.4678-100000@wax.eds.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Apr 26 20:52:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQV9K-0004FJ-FC
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 20:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVDZS4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 14:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVDZS4N
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 14:56:13 -0400
Received: from wax.eds.org ([64.147.163.246]:63159 "EHLO wax.eds.org")
	by vger.kernel.org with ESMTP id S261719AbVDZSzv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 14:55:51 -0400
Received: by wax.eds.org (Postfix, from userid 1044)
	id 77D6D32408F; Tue, 26 Apr 2005 11:55:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by wax.eds.org (Postfix) with ESMTP id 6E5F0B401A
	for <git@vger.kernel.org>; Tue, 26 Apr 2005 11:55:50 -0700 (PDT)
X-X-Sender: bram@wax.eds.org
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(my apologies for responding to old messages, I only just subscribed to
this list)

Linus Torvalds wrote:
> On Thu, 14 Apr 2005, Junio C Hamano wrote:
> >
> > You say "merge these two trees" above (I take it that you mean
> > "merge these two trees, taking account of this tree as their
> > common ancestor", so actually you are dealing with three trees),
>
> Yes. We're definitely talking three trees.

The LCA for different files might be at different points in the history.
Forcing them to all come from the same point produces very bad merges.

> The fact is, we know how to make tree merges unambiguous, by just
> totally ignoring the history between them.  Ie we know how to merge
> data. I am pretty damn sure that _nobody_ knows how to merge "data over
> time".

You're incorrect. Codeville does exactly that (history-aware merges which
do the right thing even in cases where 3-way merge can't)

> > This however opens up another set of can of worms---it would
> > involve not just three trees but all the trees in the commit
> > chain in between.
>
> Exactly.  I seriously believe that the model is _broken_, simply because
> it gets too complicated. At some point it boils down to "keep it simple,
> stupid".

The Codeville merge algorithm is also quite simple, and is already
implemented and mature.

> I've not even been convinved that renames are worth it. Nobody has
> really given a good reason why.

If one person renames a file and another person modifies it then the
changes should be applied to the moved file.

Also, there's the directory rename case where one person moves a directory
and another person adds a file to it, in which case the file should be
moved to the new directory location on merge. I gather than BK doesn't
support this functionality, but Codeville and Monotone both do.

>    I think you might as well interpret the whole object thing. Git
> _does_ tell you how the objects changed, and I actually believe that a
> diff that works in between objects (ie can show "these lines moved from
> this file X to tjhat file Y") is a _hell_ of a lot more powerful than
> "rename"  is.
>
>    So I'd seriously suggest that instead of worryign about renames,
> people think about global diffs that aren't per-file. Git is good at
> limiting the changes to a set of objects, and it should be entirely
> possible to think of diffs as ways of moving lines _between_ objects and
> not just within objects. It's quite common to move a function from one
> file to another - certainly more so than renaming the whole file.
>
> In other words, I really believe renames are just a meaningless special
> case of a much more interesting problem. Which is just one reason why
> I'm not at all interested in bothering with them other than as a "data
> moved" thing, which git already handles very well indeed.

Nothing, not eveny our beloved BitKeeper, has 'move lines between files'
functionality, and for good reason.

To begin with, it's behaviorally extremely dubious. It would be not
uncommon for the system to erroneously think that some files deleted from
one file were added to another, and then further changes down the line
would cause random unrelated files to get modified in unpredictable ways
when merges happened.

Also, it presents a completely unsolved UI problem. If one person moves
lines 5-15 of file A to file B, and another person concurrently rewrites
lines 10-20 of file A, how on earth is that supposed to be presented to
the user? Codeville can support line moves *within* files just fine, but
doesn't do it because of the UI problem of presenting all the corner
cases. Maybe someday somebody will do a PhD thesis on that topic and we'll
add it, but until then we're sticking with the basic functionality.

Honestly, that you would think of doing whole-tree three-way merges and
even consider moving lines between files shows that you haven't explored
the merge problem very deeply. This is a much harder problem than you
think it is, and one which has already been solved by other systems.

-Bram

