From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How to pull only a few files from one branch to another?
Date: Wed, 24 Jan 2007 13:30:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701241251030.3606@woody.linux-foundation.org>
References: <17846.53626.895660.762096@lisa.zopyra.com>
 <Pine.LNX.4.64.0701231937310.3606@woody.linux-foundation.org>
 <20070124203913.GD4083@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 22:30:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9phi-0000VB-Sh
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 22:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbXAXVaq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 16:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbXAXVaq
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 16:30:46 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59100 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbXAXVap (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 16:30:45 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0OLUXpa026207
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 Jan 2007 13:30:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0OLUVgV028805;
	Wed, 24 Jan 2007 13:30:32 -0800
In-Reply-To: <20070124203913.GD4083@nan92-1-81-57-214-146.fbx.proxad.net>
X-Spam-Status: No, hits=-0.679 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.171 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37683>



On Wed, 24 Jan 2007, Yann Dirson wrote:
> 
> What was particular about this tree, is that we are several people
> working on it, namely developpers taking care of the app, and me as
> build manager taking care of the build mechanics as well as kernel+OS.
> So the task was logically divided: one dev would merge the app, and I
> would merge everything else.  As you see, it's far from one-file
> merges, but the problem is quite similar.

Yes, it's basically the same thing.

And the sad part is that you can easily come up with tons of examples of 
where this makes sense, and indeed there are no fundamental problems at 
all as long as the "per-file" (or "file group" - the thing doesn't really 
change) history is strictly a perfect subset of the "whole project" 
history topology.

The reason it fundamentally doesn't work in the long run is that people 
invariably will then do things that do _not_ have the same "history 
topology". You'll have one file that has some of its history mixed in two 
different branches that _globally_ share none of that per-file history, so 
then the global history no longer matches the history of that file, and 
the "topology" of the history cannot be mapped from one to the other.

So what do I mean by that?

What git does is to track the history as it is shared by ALL files in the 
whole project (or, the way I prefer to think about it: it's not about 
independent files at all, it's _always_ about the whole collection).

This makes sense, because what does "history" actually mean? Forget about 
what it means as a word in English, and concentrate on what its meaning is 
strictly from a technical standpoint. Why does history matter? Why don't 
we just have a set of commits in date order?

>From a technical standpoint, the thing that makes history matter (and why 
"set of commits in date order" is useless) is because it gives us a COMMON 
ANCESTOR! And *that* is the only thing that matters.

Now, what is fundamentally wrong with doing per-file history? 

Now, if you've followed this argument, you should go "Aaahh! Obvious!".

The thing that is _fundamentally_ wrong with per-file history is that it 
breaks the one AND ONLY point of having history in the first place. There 
is no well-defined "common ancestor" notion on a repository level any 
more. You've made the history meaningless on a repo level, and it's now 
only meaningful on a file level.

So whats' wrong with that? You could still do merges, file by file, and 
just do the common ancestry that way, couldn't you?

Yes you can. It's just that if you do, you're a total moron, and you're 
back to the dark ages and playing with CVS (and possibly SVN - it's too 
early to say yet, since SVN can't do merges and history AT ALL right now 
as far as I know - it has the same merge logic as CVS has, I think, 
which is to say that it doesn't really understand the point of having 
history in the first place).

Which gets me back to where I started: you could (at least in in theory)
allow a situation where you allowed file-level merges AS LONG AS THEY 
NEVER CLASH WITH THE GLOBAL HISTORY.

In other words, I could imagine starting a branch for a particular file 
(and when I say "file", it can be any arbitrary subset of the full state), 
and having file-level history at that level, but you must NEVER then merge 
that file across into _another_ global branch, because if you do, then the 
"global history" has lost all value, since it's no longer actually global 
history any more.

So you have to choose: do you want to track things file by file, or do you 
want to track the whole project. You literally can't say "I want to do 
both!". Because tracking history file by file breaks the whole concept of 
tracking global history, the moment you start merging individual files 
across branch boundaries.

> The idea which I came up with was inspired by the "partial merge"
> feature in PRCS, which I had never used or even understood the purpose
> before that date.

I really don't think that people understand how fundamentally broken the 
whole concept is.

I think git should help you combine partial state between different 
branches, but you should always realize that IT IS NOT A MERGE! It's more 
like a "cherry-pick" - except you cherry-pick multiple commits "in space" 
instead of cherry-picking one commit "in time".

(The way I personally view git, "space" is the workspace - aka contents - 
while "time" is the history, aka the relationship of commits")

So it's perfectly ok to take data from other branches and include them in 
your current one. Nobody doubts that, and indeed, some forms of it we 
already have nice tools to help you do that ("cherry-pick" in particular).

And yes, doing a simple

	git diff commit..othercommit filename | 
		git-apply --index && git commit

is really just a way to "cherry-pick" the data when it's located in 
"space" instead of in "time" (ie we restrict it to a particular region of 
the workspace, and cherry-pick the work we did over a long time: this is 
100% equivalent to "git cherry-pick", which does it the other way around: 
it cherry-picks the work restricted "in time", but unstrstricted "in 
space").

But when you do this YOU MUST NOT CALL IT A MERGE!

Because you _by_definition_ don't actually do the ONE thing that is the 
whole point of a merge: the result does not become a common ancestor of 
the result.

So when you cherry-pick, you don't merge: you just create a bug-standard 
commit. It may contain data from another branch, but it is NOT a merge of 
the other branch.

> How would you handle such a situation ?

See above. Just create them as individual commits, and perhaps point to 
where the data came from in the commit comment, but don't try to think 
they are merges.

Btw, to explain my point perhaps even more fully, let me give an example 
of the "reverse" situation:

	git merge -s ours

This actually IS a merge, even though we don't actually make ANY CHANGES 
AT ALL to the tree, and we don't take any actual data at all from the 
other branch, and just state: "the result of the merge is always the 
current branch contents".

So why is it a merge? Exactly for the same reason that a partial-file 
"merge" is NOT a merge. It's a merge because the whole point of the "ours" 
strategy is to say "This is now going to be the common ancestor for these 
two states going forward". And that is the _definition_ of a merge, since 
that's the whole (and ONLY) point of having history in the first place.

So it all really boils down to a simple question: "What is the meaning of 
'history'?"

Once you understand what history is all about, you understand why a 
"merge" of a few files isn't actually a merge at all, but just a 
cherry-pick.

(And btw, that doesn't mean that we wouldn't use the "merge" program to do 
it. The way we actually implement "cherry-pick" is to physically do a 
"merge" of the contents, because passing patches forwards and backwards is 
just stupid. So the issue is somewhat confused by the different "levels" 
of meaning of the word "merge". There's the pure "content merge", which is 
a purely technical method of combining data, and which is usually just a 
three-way RCS-merge. And then there is the "merge commit", which tells you 
something about HISTORY, which is a lot more fundamental and a lot more 
important).

You can often do the "data merge" by hand. It's the least of your 
problems, and it's not even very interesting. The _interesting_ part of a 
git merge is what it means for history!

Doing cherry-picking (whichever kind you want to) is fine, but you have to 
realize that it also means that you will have a potentially harder time to 
do a "true merge" of the two branches later. Once your per-file history 
doesn't match the whole-project history, you end up losing a lot of the 
automatic goodness of simple merges, and you get back to the old CVS merge 
hell.

But the good news is that at least it won't be any _worse_ than what a lot 
of people have long since learnt about CVS merging. It will be "hell" only 
when compared to what you can do when you don't play games, and when you 
merge nicely.

			Linus
