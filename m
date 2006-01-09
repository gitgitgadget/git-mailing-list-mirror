From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 00:48:44 +0000
Message-ID: <20060109004844.GG27946@ftp.linux.org.uk>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13489@hdsmsx401.amr.corp.intel.com> <Pine.LNX.4.64.0601081100220.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161263AbWAIAtM@vger.kernel.org Mon Jan 09 01:50:58 2006
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161263AbWAIAtM@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvlFF-0003FU-A6
	for glk-linux-kernel-3@gmane.org; Mon, 09 Jan 2006 01:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161263AbWAIAtM (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 8 Jan 2006 19:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161270AbWAIAs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 19:48:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:26246 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161260AbWAIAsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 19:48:47 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1EvlDI-00043Z-H2; Mon, 09 Jan 2006 00:48:44 +0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601081100220.3169@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14341>

On Sun, Jan 08, 2006 at 11:10:20AM -0800, Linus Torvalds wrote:
> That has absolutely nothing to do with anything. It's not the comment 
> (which admittedly gives absolutely no information - but why should it, 
> since the _commit_ itself has no information in it?)

How do you deal with conflict resolution?  That's a genuine question -
I'm not talking about deliberate misuse to hide an attack, just a normal
situation when you have to resolve something like

A:
	if (foo)
		bar

B:
	if (foo & baz)
		bar

A':
#ifdef X
	if (foo)
		bar
	...
#endif

merge of A' and B: trivial conflict

and have git pull fail.  The obvious way (edit file in question, update-index,
commit) will not only leave zero information about said conflict and actions
needed to deal with it, but will lead to situation when git whatchanged will
not show anything useful.   I.e. if conflict turns out to be non-trivial and
ends up being resolved wrong, everyone will have very nasty time trying to
figure out where the breakage had come from when looking at history 6 months
down the road.

Is there any SOP I'm missing here?

Worse (for my use), format-patch on such tree will not give a useful patchset.
You get a series of patches that won't apply to _any_ tree.  Even if all
conflicts had been resolved correctly, they still remain there for everyone
trying to apply the patch series, unless you manually rebase it before
format-patch.

And that's a fundamental problem behind all that rebase activity, AFAICS.
It definitely is in my case, and yes, it's fscking inconvenient in a lot
of respects.  E.g. I'm using git for resync between build trees on several
boxen.  There's a repository holding patchset, plus one clone per build
box.  Fixes for build breakage, etc., get done in those clones; after they
are committed there, I pull into master and then pull from other clones
to spread them to other build trees.  Works fine, but...  Any rebase in
master => instant hell for all clones.  I've ended up with the following
layout that kinda-sorta avoids mess:
master:origin: matches upstream
master:topic branch: _not_ rebased until there is a conflict, never get
	a pull from anywhere
master:master: gets pulls from topic branches and origin _and_ _nothing_ _else_
master:work: where interaction with build boxen and any edits done in master
	repository go.  Edits, commits, pulls from master:master, pulls from
	build boxen.
buildN:origin == master:work
buildN:work: where work on buildN goes.
When I want to get new stuff (== difference between master:master and
master:work) into the patchset, I cherry-pick from work to topic branches
and re-pull them into master:master until it matches master:work.  Then
I pull master:master into master:work to create a point in work history
that marks beginning of new portion of pending stuff.  New stuff upstream
is pulled to master:origin -> master:master -> master:work -> build trees.

That works, and gives me merge-free topic branches I can safely format-patch
while keeping master in sync with mainline _and_ also safe for format-patch.
The price is in rather convoluted SOP.  And the following piece of fun:
when cherry-pick work->topic, pull topic->master or pull origin->master
gives a conflict, it's time to rebase.  Which I do by renaming topic branches
(direct mv in .git/refs/heads), then starting new ones at current origin
and applying old ones to them (cherry + cherry-pick if possible, format-patch
+ applymbox if things get hairy).  Then master is recreated as branch from
origin that gets pulls from topic branches, work is branched from it and
build trees get killed and cloned from scratch.  It's tolerable since I'm
using ccache on build boxen, so it's _not_ that much of rebuild.

However, that clearly is a killer if any poor sucker (me included) ever
clones from master for any other purpose.  And that, BTW, is the main
reason that stops me from moving master to kernel.org right now.

> And yes, you can always work around it, but there's just no point. And 
> none of the other developers seem to need to do it. They do their 
> development, and then they say "please pull". At that point the two 
> histories are tied together, but now they are tied together for a 
> _reason_. It was an intentional synchronization point.
> 
> An "automated pull" by definition has no reason. If it works automated, 
> then the merge has zero semantic meaning. 

I'm afraid you are missing a part of picture.  There is a bunch of git
uses that handle a heap of foam rather than a long-term branching.  I.e.
the tree is tied to mainline closely and most of the stuff in it is
supposed to get flushed into mainline soon after it appears.  I.e. the
situation when we have a mergepoint for fixes that _has_ to follow
mainline closely.

I wonder what life would be without merge nodes and with equality nodes
instead.  I.e. to merge
O -> A1 -> ..... -> An (=A)
  -> B1 -> ..... -> Bm (=B)
would be to create a new branch (C) at Bm, have entire A1...An replayed there,
have B1...Bm replayed in A and then create a node certifying that new head
of A and head of C refer to the same tree.  Plus have a way to see which
commits are claimed to be replays of each other.  At least that way rebase
would be simply saying that old history is superceded by new one, with
equality node proving that it's OK to do.  We would have
O -> M1 -> ....  ->Mn for mainline
O -> B1 -> ....  -> B for branch post-pull
Mn -> P1 -> ... -> P for merge branch
and B == P as equality node.   Old branch would have a bunch of changesets
of its own plus ones from mainline that got there by pulls (including the
last one).  And new branch would contain the ports of not-yet-merged ones
to new mainline head, with the same tree as the result and all further
development going on there rather than in the old branch.  Oh, well...
