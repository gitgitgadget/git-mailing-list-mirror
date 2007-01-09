From: Jeff King <peff@peff.net>
Subject: Re: confusion over the new branch and merge config
Date: Tue, 9 Jan 2007 10:05:24 -0500
Message-ID: <20070109150524.GB10633@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <7vd56cam66.fsf@assigned-by-dhcp.cox.net> <20061223051210.GA29814@segfault.peff.net> <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net> <7vbqlvrldk.fsf@assigned-by-dhcp.cox.net> <20070102144940.GA23932@coredump.intra.peff.net> <7vps9xwd01.fsf@assigned-by-dhcp.cox.net> <20070102173410.GA25325@coredump.intra.peff.net> <7v1wmdure6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 16:05:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4IXa-00037y-3V
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 16:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbXAIPF1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 10:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbXAIPF1
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 10:05:27 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2123 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932130AbXAIPF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 10:05:26 -0500
Received: (qmail 3164 invoked from network); 9 Jan 2007 10:05:37 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 9 Jan 2007 10:05:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jan 2007 10:05:24 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wmdure6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36367>

[sorry this is old, but hopefully you remember what we were talking
about. :)]

On Tue, Jan 02, 2007 at 12:04:33PM -0800, Junio C Hamano wrote:

> I might have misread what you meant by mergeLocal, and you might
> be trying to introduce a default for "git merge" so that without
> anything on the command line "git merge" would merge something
> locally available depending on which branch you are on.

No, I think you read me right: I wanted a way of saying "this is the
local branch from which merges should happen if no other branch is
specified".

> But I did not think of that, and thought you were saying "look
> at branch.*.mergelocal (if exists) in the same place we look at
> branch.*.merge in the current code, and just like the latter is
> used to match up with the remote refname we just fetched, use
> the former to match the local tracking branches, to decide what
> to merge".  And if that is what you meant by mergelocal, I do
> not see much advantage in that approach -- that is what I meant
> in the response.  The remote name is available whether you use
> tracking branches locally or not, so using that to specify the
> merge operation that happens after a 'pull' is more consistent,
> less confusing, and matches the long-hand "git pull $URL
> remote-branch" a lot better than having another configuration
> that can be used only half the time.

Let me say right now that I'm not _that_ interested in this concept, so
I'm going to stop pushing for it. However, I do want to respond to a few
points in this mail; feel free to ignore. :)

There are two advantages I see to putting local branches in branch.*.merge:

  1. there seems to be some newbie confusion over using the remote name.
    Pull is conceptually (to me anyway), two steps:
      1. Fetch from a remote into my local tracking branches
      2. Merge from some tracking branch into my current branch.
    whereas I have seen you explain pull as:
      1. Fetch into FETCH_HEAD, selecting some branches for merge
      2. Merge any branches marked for merge
    I know that your model is more flexible, since it supports skipping
    the tracking branches. But for newbies looking at the config, I
    think the first makes much more sense.
      1. Newbies always have tracking branches, since that's now the
         default layout.
      2. Newbies don't know about FETCH_HEAD, since we don't talk about
         it in tutorials (and really, with tracking branches, what's the
         point?).
      3. Out of the two steps (fetching and merging), I would expect the
         .merge config option to be dealth with in the latter. But
         actually, it is an intimate part of fetching. This doesn't
         matter if you're pulling, but my workflow (and many others, it
         seems, especially those who rebase regularly) is:
           git fetch
           gitk master...origin
           git rebase ;# or git-pull

  2. There has been a requested feature (which I think makes sense) to
     create an automatic "upstream" for local branches. I.e.,
       git checkout -b new old
       hack hack hack
       git pull ;# should pull from 'old'
     This should be trivial to implement as
       git-repo-config branch.$new.mergeLocal $old
     but instead is requiring some magic to treat '.' as a noop remote.

[This ends the productive portion of this mail, but read on for more
philosophical wanderings.]

> Some people repeatedly argued that remote branch names do not
> matter.  I think they are wrong and are missing the point of
> distributedness of git.  You are fetching from there, so you

I think the opposite. :)

To me, the distributed part of git (and one of its strengths over other
systems) is that we are all working on a giant digraph of the history,
and git is very efficient at adding to, examining, and communicating
about parts of that graph.

Refs are just pointers into the graph, and so the names we give them are
mostly just local matters (unless we're publishing those names). For
example, before I started using separate remotes, I had what by many
would be considered a funny setup. I was used to working with master and
origin, but I wanted to start tracking next instead. So I made my origin
track your next, and I called my master what you call next (plus local
commits). As a result, I called your master 'stable' so I could still
access it.  So the history was distributed, but the names were
completely local.

Another oft-mentioned example from the big bzr debate is a fork: what if
I stop pulling from you, and start pulling from somebody else? The
pointers have changed, but the underlying history is inherently the
same. There's no penalty for me to switch names.

That isn't to say the names of the pointers are without value. Talking
about 'master' and 'next' is very useful for humans. But what we
_really_ mean is "Junio's master" and "Junio's next", because you are
publishing those pointers.  I don't know (or care) what's on Linus'
master, so he can call it whatever he wants. Or if I do care, I don't
necessarily care how it relates to your master. So to me, getting hung
up on remote names (that is, treating them as anything besides
publishing points) misses the point of git's distributedness.

Which isn't to say branch.*.merge looking at remote refs is _wrong_, but
that using local names is at least as right (conceptually). :)

> the same place.  Now how would you discuss what that common
> repository recently placed on that branch?  You would not use
> the local tracking branch name which _is_ meaningless to the
> other person.  You use the remote name.

Sure, you would. Because you're talking about that other repo. But my
mental model is that all git operations are local operations, except for
fetching and pushing. I really think of pull as a shorthand "git-fetch;
git-merge". So to me, git-merge is a local operation that should deal
with local names.

> As you can see from the above, my 'ko' is the local tracking
> branch, and 'master' in that repository is what is known as
> 'todo' to the public.  But when I talk about what I have in that
> branch, I would never say 'master' nor 'ko' -- people would not
> care how I call that branch locally in my private repository.
> What's private is private and does not matter to others.
> Instead I would say something like "my 'todo' branch has drafts
> for v1.5.0 release notes these days".

Exactly. Only published names matter to other people. However, I contend
that published names stop mattering once you have a mapping to local
names.

> What does this all mean?  It means that remote branch names
> matter more when you are talking about external communication.
> And "git pull" (more so for "git fetch") is all about external
> communication.

I think this is where we really disagree. As I said, git-pull is really
just "fetch+merge" to me. And merge isn't about external communication.

> Obviously, the local names should matter more when you are doing
> local operations.  So if you are using mergeLocal to give a
> shorthand to "git merge" that does not explicitly say what to
> merge, the above discussion does not apply.  But if that is the

What I'm suggesting is that it can be used for either (local merges or
pulls, since both are git-merge.

> case, mergeLocal should also not affect the selection of
> branches to be merged when "git pull" happens from a remote
> either.

I think I am fundamentally denying the way "for-merge" branch selection
works in git-pull. That is, it isn't the way I think of it conceptually,
perhaps because I don't actually 'pull' very often. I _always_ fetch
first.

-Peff
