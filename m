From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Wed, 9 May 2007 08:52:09 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705090825090.4062@woody.linux-foundation.org>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
 <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
 <vpqbqgxak1i.fsf@bauges.imag.fr> <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com>
 <alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org>
 <20070509134151.GT4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 09 17:53:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HloTS-0001aC-FG
	for gcvg-git@gmane.org; Wed, 09 May 2007 17:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955AbXEIPwy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 11:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756403AbXEIPwy
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 11:52:54 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:52510 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755955AbXEIPww (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2007 11:52:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l49FqAvx024835
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 May 2007 08:52:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l49Fq9TH026943;
	Wed, 9 May 2007 08:52:10 -0700
In-Reply-To: <20070509134151.GT4489@pasky.or.cz>
X-Spam-Status: No, hits=-3.482 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46733>



On Wed, 9 May 2007, Petr Baudis wrote:

> On Tue, May 08, 2007 at 06:45:32AM CEST, Linus Torvalds wrote:
> > 
> > Or other things like that - I have small test-patches in my tree that I 
> > want to build, but that I don't want to commit, and I end up doing big 
> > merges and whole patch-application sequences with such a dirty tree 
> > (obviously if the patch or merge wants to change that file, I then need to 
> > do something about that dirty state, but it happens surprisingly seldom).
> 
> Hmm, does this really work so well for you guys? Because thanks to Mr.
> Murphy, in my case, when I have some custom Makefile tweak, I always
> need to commit some unrelated changes involving Makefile more often than
> usual, and so on; so in general case, file-level changes exclusion
> doesn't really work so well for me.

Well, one thing is that I obviously mainly work on a relatively large 
project, and one that has been carefully de-centralized over a long long 
time, so the source code I work with - the kernel - may be more amenable 
to my workflow than most.

For example, we have long long since tried to avoid having central files 
that everybody changes - because it's such a pain to manage, even with 
good automated merging (and even more with central people still using just 
series of patches).

In other words, in well-maintained larger projects, you simply don't see 
those kinds of conflicts very often: people don't work on the same files 
very much. I regularly go for days, and easily merging hundreds of 
thousands of lines of changes, with a dirty tree, and the merges don't 
affect it at all.

And if I happen to hit a dirty file, the pull will just say "cannot 
merge", and I can stash away my changes, and just re-do. So the cost of a 
conflict in a dirty tree is very low when it *does* happen.

> So this use of index seems to me really as a workaround for more
> fine-grained change control (in a similar way that rename following
> would be a workaround for lack of more fine-grained content moves
> tracking). I will have to look into git-gui's hunk-level control and
> maybe reimplement it in tig.

Many people seem to enjoy per-hunk commits, but I seldom do that. Maybe 
it's just because I'm *so* comfortable with diffs, that when I clean up an 
ugly sequence of commits, what I do is literally:

 - I make sure that my ugly sequence of commits is on some temporary 
   branch, but that the _end_result_ is good and clean (ie I will have 
   tested the end result fairly well, and made sure that there are no 
   debug statements etc crud left).

   I would call this branch something like "target", because the end 
   result of that branch is what I'm looking for - even if the commits in 
   the sequence that gets me there are individually ugly!

 - I just switch back to my starting point (and now I'm usually on 
   "master"), and do

	git diff -R target > diff

   to create a diff of my current tree (which is initially the starting 
   point) to the good result.

 - I actually edit the "diff" file by hand, and edit it down to the part I 
   actually want to commit as the first in the series. And then I just do 
   a "git-apply diff" to actually apply that part to my working tree.

 - I then edit any missing parts in the actual working tree (for example, 
   if there were mixed hunks that I want to get to in later commits, and I 
   edited out above, or that I need to partially undo), to do any 
   finishing touches.

 - I now have a tree I can compile and test, and has the "first part" of 
   the journey towards the final "target" state. If compiling/testing 
   shows that I missed something, I can still fix things, and/or go back 
   to doing another "git diff -R target" to see if I missed something).

 - I commit that first case, and repeat the sequence from step 2 (and 
   at every step, the "diff" file ends up shrinking and shrinking).

The above sounds like it's a complicated sequence, but it really isn't. 
Partly because I just am very comfortable with diffs indeed (probably more 
than most people), but partly because at all times "git diff" works fine 
to see what I've done, and what the diff to "target" is.

And unlike the "simpler" model of committing individual hunks with "git 
add -i" or something like that, my model is actually much superior! It 
means that I can actually test each stage individually, and make sure that 
the intermediate commits are good. It also allows me to edit up places 
where the diff mixes up two different things, and the intermediate result 
needs to be different from the final one.

Do I do this very often? No. Most of the time, the changes are separate 
enough that I can just commit one file at a time, and in fact, I can mix 
and match (ie I can do the above thing in the "big picture", but actually 
end up doing one substep where I do just one "diff and edit" phase, but 
then actually commit that as two things by just committing individual 
files separately when they are obviously independent changes).

But the above is literally what I did for the superproject support and for 
some other things where I want to send out the end result in a nice 
sequence of 5-6 patches, but when I was actually *developing* it I ended 
up making more mistakes, and I started out with 10 patches with some total 
braino's that I had to fix, or cleanups that I didn't do in the right 
sequence.

And I actually mix-and-match other ways of working too. For example, if 
some commit in my otherwise ugly "target" sequence was fine, I'll just 
cherry-pick it instead, and re-order things that way. 

The point of this all is that the "git way" is actually very flexible. You 
can keep the tree dirty and not worry about it, and if you always think 
twice before you do "git commit -a" you won't be committing dirty state 
that you didn't intend to commit by mistake.

Of course, if you get so used to doing "git commit -a" that you just do it 
in your sleep, then the dirty tree model won't work for you, because 
you'll simply start committing stuff you didn't intend to commit when 
you're on auto-pilot. But the way I work, I basically always do

	git diff

to see what's in my tree, and I will only use the "-a" flag when I 
*consciously* think "ok, that's all one thing". 

Btw, what goes hand-in-hand with this workflow is the nice ability to 
specify a subtree. So I'll have a dirty tree with two different 
test-things, but since one of them was a filesystem fix, and the other one 
was in the kernel, rather than give all the paths explicitly, I'd do

	git commit fs/

and it will automatically do the right thing (actually, I often end up 
using the two-stage "git add" + "git commit" thing, because one of the 
more common cases for me is that I'm going to commit a merge that I fixed 
up a conflict in, and then you have to do it that way).

			Linus
