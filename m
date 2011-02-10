From: Jeff King <peff@peff.net>
Subject: Re: Using Origin hashes to improve rebase behavior
Date: Thu, 10 Feb 2011 17:54:28 -0500
Message-ID: <20110210225428.GA21335@sigill.intra.peff.net>
References: <m21v3fvbix.fsf@hermes.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Wiegley <johnw@boostpro.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 23:54:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnfPH-0004O7-2R
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 23:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757218Ab1BJWya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 17:54:30 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41802 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756844Ab1BJWy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 17:54:29 -0500
Received: (qmail 22167 invoked by uid 111); 10 Feb 2011 22:54:28 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 10 Feb 2011 22:54:28 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Feb 2011 17:54:28 -0500
Content-Disposition: inline
In-Reply-To: <m21v3fvbix.fsf@hermes.luannocracy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166511>

On Thu, Feb 10, 2011 at 04:13:10PM -0500, John Wiegley wrote:

> For the purposes of this discussion, I'd like to define the term "aggregate
> identity" (insert better name here) as a set including: a commit's sha, and
> zero or more shas stored in a new field named "Origin-Ids".
> 
> If, when cherry-picking, the originating's commit id is stored in the
> Origin-Ids field of the cherry-picked commit, then rebase could know whether a
> given commit's changes had already been applied.  The logic would look like
> this:
> 
>   1. When rebasing a branch A onto B, find the common ancestor of A and B.
>   2. Examine every commit on B since that common ancestor, collecting a
>      set of their aggregate identities.
>   3. For each commit on A, ignore it if its aggregate identity occurs in
>      that set.
> 
> This would cause commit 3 to be ignored during the rebase above, since 3'
> would have an origin id referring to 3.

This can work in some cases, but there are other cases where it might
not. For example, consider:

   1. I cherry-pick commit X from some branch "topic" onto master as X'.
      We record "Origin-ID: X" in X'.

   2. I rebase "topic" (either onto some other branch, or perhaps I use
      rebase -i to rewrite some earlier commit). X now becomes some X''.

   3. I now rebase "topic" onto master. But we fail to note that X''
      matches X, so we try to rebase it.

Now, in step 2 we could record "X" as an origin ID of X'' and during the
rebase in step 3, calculate the intersection of the origins of X'' and
X', and see that they are both just X. And I think maybe you already
realize that, since you talk about Origin-IDs as sets.

But now you have an interesting question: during which operations does a
commit retain its Origin-ID on a source? I think it is pretty clear that
a cherry-pick that cleanly applies is probably a good candidate. But
what if there is a conflict, and I fix up the conflict? Should I still
skip the original commit during the rebase? Maybe, but there are cases
where you wouldn't want to. For example, consider this sequence:

  1. On my master branch, I have a function foo() which takes one
     argument.

  2. I branch a topic from master. The first commit adds a new caller to
     foo().

  3. The second commit changes foo() to take two arguments. I fix up the
     function itself, any old callers, and the new caller.

  4. I cherry-pick the second commit onto master. There is a conflict,
     since one of the callers it updates doesn't exist in master. So I
     drop that part of the patch.

  5. On master I update the implementation of foo().

  6. Now I try to rebase my topic on top of master. We could get a
     conflict because the second commit from (3) will conflict with the
     updated implementation in (5). This is more or less the case you
     described in your initial email, and we'd like git to automatically
     realize that the conflict is uninteresting.

     So let's imagine we recorded Origin-IDs as you describe, and we
     skip it. But that means we are _also_ skipping the part where we
     update the new caller from the commit in (2), the part that was
     dropped during conflict resolution. So our end result is broken,
     because the new caller is still calling with one argument.

And there are lots of other cases. What about "git cherry-pick -n"? What
about rebasing? If there are no conflicts, is it OK to copy the origin
field? How about if there are conflicts? How about in a "git rebase -i",
where we may stop and the user can arbitrarily split, amend, or add new
commits. How do the old commits map to the new ones with respect to
origin fields?

So there are lots of corner cases where it won't work, because git is
more than happy to give you lots of ways to tweak tree state and
history, and it fundamentally doesn't care as much about process as it
does about the end states that you reach. That's part of what makes git
so flexible, but it also makes niceties like "did I already apply this
commit on this branch" much harder to make sense of.

Now, I don't want to discourage you from working on this. Because while
there are lots of cases where it won't work, there are plenty of cases
where it _will_, and it will save rebasers time and effort. So it is
worth pursuing, but I think it is also worth keeping things simple and
conservative, and not affecting the people who have cases where this
won't help.

>  - Extend commit objects to have an Origin field, which can be zero, one or a
>    list of hashes.

It probably shouldn't be a new header field, but rather a text-style
pseudo-header at the end of the commit.

But consider for a moment whether you actually want this field in the
resulting commit at all, or whether it should be an external annotation.
For example, let's say I cherry-pick from a private branch that is going
to end up rebased anyway. Now the history for all time will have a
commit that refers to some totally useless sha1 that nobody even knows
about.

We already went through this with cherry-pick. It used to always put
"cherry-picked from X..." in the commit message. And then we realized
that in many cases, that information is not interesting, because X is
not something people actually know about. So now we don't do it by
default, but for cases where you are cherry-picking from one
long-running branch to another, you can use "cherry-pick -x".

So consider instead putting this information into a commit-note for the
new commit. Possibly even reversing the direction of the mapping (so
that the old commit says "I was cherry-picked to X"). And then when the
old, rebased commit goes away, the note will automagically get pruned by
the notes-pruning mechanism.

There may be reasons why that isn't a good idea, and I haven't thought
it through. But I think you should consider it as an alternate
implementation and tell me why I'm dumb in that case. ;)

>  - Add an option to git commit so that one or more origin ids can be specified
>    at the time any commit is made.  There may be occasions when it's useful to
>    explicitly state that a new commit should somehow 'override' the contents
>    of another during a rebase.
> 
>  - git cherry-pick and git am should add this Origin field, showing the commit
>    their contents originated from.

We already have this to some degree, in the form of "cherry-pick -x".
You could do it with "git am", but you would need "git format-patch" to
actually generate the information (well, technically speaking it is in
the mbox "From " header, but that usually doesn't make it through mail
transports for obvious reasons).

So I wonder if your proposal can be restructured as:

  1. Change rebase to look for cherry-picked-from headers on the --onto
     side, and skip source commits that appear to exist already. That
     will start helping people immediately using existing history.

     You can also deal with uncertainty by leaving this decision to the
     last minute, or even leaving it up to the user. The usual patch-id
     detection works in a lot of cases. Let it work when it does. When
     it fails, check if the conflicted commit exists in a
     cherry-picked-from line. If it does, either do the skip then, or
     when we barf with the "there was a conflict; fix it up and rebase
     --continue" message, mention the cherry-picked-from line and let
     the user inspect the commits themselves and make a decision.

     They can always do "git rebase --skip" even now, so all we are
     really doing is saying "By the way, you might want the extra
     information that this was cherry-picked earlier". And that makes
     this a very low-risk change, since we are just giving the user
     extra information for a decision they are already making.

  2. (Optional) Start adding the "Cherry picked from" message in a more
     machine-readable format, like an "Origin-ID: ..." header. This has
     already been discussed before. People were generally positive, but
     it didn't seem especially useful. This is a use.

     And obviously make the corresponding change in rebase to also parse
     these kinds of headers (but don't drop parsing the original format,
     obviously, for compatibility).

  3. For people who don't want the "cherry picked from" (or "origin-id")
     in their commit, because they are cherry-picking from a private
     source, start recording "cherry picked from" in a git-note. You
     could even do this by default, since you are not impacting the
     commits themselves in any way.

     And then make the corresponding change in rebase to start using
     these notes as a source.

  4. We already have some functionality to copy notes about commit A to
     commit B during certain operations (like rebasing and
     cherry-picking). Check out how these interact with the notes
     introduced in (3) to see if transitive stuff works (like
     cherry-picking A to A', and then A' to A''; you should still be
     able to figure out that A'' came from A).

And I think at that point we have more or less the functionality you
were asking for, though we arrived in several non-controversial steps.
And there are lots of enhancements you could add on top, like skipping
without bothering the user about it, or better heuristics for when to
record an origin-id or not to. But we can do those once we see how the
basic dumb part performs. I.e., how useful it is in practice, and how
often it is wrong about when to skip.

>  - git merge --squash would store the commit ids, and the origin ids, of every
>    commit involved in the merge into the resulting commit's Origin field.

I hadn't thought about merge --squash as a commit copying operation, but
I think it is. I wonder if squash merges (or squash rebases) should also
be copying notes (or if they do already, I haven't checked).

>  - git log could be extended to show the "parentage" (really, the aunt/uncle)
>    of commits with origin info, assuming those origin commits are not dangling
>    (which is OK, and likely to occur after the originating branch is deleted,
>    or if the originating branch is in another repository).

If you do it with a combination of text in the commit message and
git-notes, then this is all done for you. The commit message you
obviously see by default, and you could explicitly ask for it to show
the refs/notes/origin-id notes tree.


Whew, that turned out long. I hope it's helpful. I think the problem
you're trying to solve is a real one, and I think your approach is the
right direction. I just think we can leverage existing git features to
do most of it, and because it is sort of a heuristic, we should be
conservative in how it's introduced.

-Peff
