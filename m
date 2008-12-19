From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: Git Notes idea.
Date: Fri, 19 Dec 2008 11:38:55 -0600
Message-ID: <5d46db230812190938r4e8ff994gfcb616c750be0f22@mail.gmail.com>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com>
	 <20081216085108.GA3031@coredump.intra.peff.net>
	 <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com>
	 <alpine.DEB.1.00.0812170003540.14632@racer>
	 <5d46db230812161815s1c48af9dwc96a4701fb2a669b@mail.gmail.com>
	 <alpine.DEB.1.00.0812170420560.14632@racer>
	 <20081217101110.GC18265@coredump.intra.peff.net>
	 <5d46db230812190918qf22b874n8d8aeea557083df8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 19 18:40:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDjKi-0005wI-35
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 18:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbYLSRi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 12:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbYLSRi5
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 12:38:57 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:43469 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbYLSRi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 12:38:56 -0500
Received: by yw-out-2324.google.com with SMTP id 9so399827ywe.1
        for <git@vger.kernel.org>; Fri, 19 Dec 2008 09:38:55 -0800 (PST)
Received: by 10.150.145.20 with SMTP id s20mr6013740ybd.121.1229708335371;
        Fri, 19 Dec 2008 09:38:55 -0800 (PST)
Received: by 10.151.135.7 with HTTP; Fri, 19 Dec 2008 09:38:55 -0800 (PST)
In-Reply-To: <5d46db230812190918qf22b874n8d8aeea557083df8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103571>

Sorry, hit the send key accidentally.

On Wed, Dec 17, 2008 at 4:11 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Dec 17, 2008 at 04:43:57AM +0100, Johannes Schindelin wrote:
>
> > I agree, I haven't thought of any fix along these lines other than to
> > make gc do the clean up.
>
> I have, and IIRC I briefly mentioned it back then.  Basically, you will
>> have to add a "git notes gc" or some such, which basically reads in the
>> whole notes, traverses all reachable commits, marking the corresponding
>> notes, and then writes out all marked notes (leaving the other notes
>> behind).
>
> I was thinking something similar, but I think it is even easier. Make
> the rule "if we still have the object, then we still have the note".
> That has three benefits:
>
>  - implementation is simple: for each note $n, delete it unless
>   has_sha1_file($n).
>
>  - it handles notes on non-commit objects
>
>  - it kills off notes when an object is _pruned_, not when it stops
>   being _reachable_. So if I delete a branch with a commit found
>   nowhere else, its notes will hang around until it is actually pruned.
>   If I pull it from lost+found, I still keep the notes.
>
> Note that all of this garbage collection of notes is really just
> removing them from the most current notes _tree_. If the notes structure
> is actually composed of commits, then old notes that are "deleted" will
> still be available historically.
>

This is my concern with keeping a history of the notes pseudo-branch.  Let
me restate what you are saying with an example

1) on branch A commit a
2) add note a`
3) on branch B commit b
4) add note b`
5) on branch B commit c
6) add note c`
7) delete branch A
8) gc after a time such that a is pruned

Now either I will always have a note a` as an object forever even though
the only commit that points to it is gone or I have to re-write the history of
the notes branch from the point that it was added.

Given this problem, is it really such a good idea to keep the history?

Of course the other side of this conversation is that the merge operation
will be more complex since the following can also happen

9) push notes
10) user 2 pulls notes but still has commit a and note a`

On the other, other hand, pushing and pulling notes if a history is kept
will have to involve a lot of rebasing/merging.

Just to throw an idea out...

A possible solution is that notes are per-branch,

refs/notes/heads/master
refs/notes/heads/foo/bar
refs/notes/remotes/baz/bang

and then it is easier to deal with.  A published branch's notes are isolated
from the changes in unpublished branches.  And since published branches
aren't *supposed* to change, then the notes should also always be fast
forwards.  Similarly, if a branch is not considered stable, like pu or even
next, then the associated notes branch could be forced in the same way.

Rebase, cherry-pick and merge (and possibly branch/checkout) would have
to be updated to handle notes, which is the down side.  It also doesn't solve
the issue of a history causing us to keep notes after the aren't useful anymore.

So perhaps we could use the above layout with no history?

Thanks,
Govind.
