From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git blame-tree
Date: Wed, 2 Mar 2011 16:04:34 -0500
Message-ID: <20110302210434.GB20400@sigill.intra.peff.net>
References: <20110302164031.GA18233@sigill.intra.peff.net>
 <20110302171653.GA18957@sigill.intra.peff.net>
 <7vbp1tcr25.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 22:04:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PutE8-0006bZ-Dw
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 22:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757460Ab1CBVEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 16:04:39 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49350 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756087Ab1CBVEh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 16:04:37 -0500
Received: (qmail 20372 invoked by uid 111); 2 Mar 2011 21:04:36 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 02 Mar 2011 21:04:36 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2011 16:04:34 -0500
Content-Disposition: inline
In-Reply-To: <7vbp1tcr25.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168341>

On Wed, Mar 02, 2011 at 10:31:30AM -0800, Junio C Hamano wrote:

> I agree that rolling it into "blame" will be a good way to conclude this
> feature from the end-user UI point of view, provided if (as you said) this
> proves to be the most reasonable way to give a coarser, file-level blame
> to a history.

OK, then I'll proceed with it as a separate command, and we can decide
on rolling it in later.

> One is merges, which you punted on with --no-merges ;-).  If I were doing
> this, I would probably have traversed without --no-merges, and would blame
> all cases that are not TREESAME to the merge (i.e. regardless of the
> cleanness of the content level merge), as this feature is about file level
> blame.  If the child took the whole content as-is from a parent, it is a
> no-event, but if the child has the resulting content that is different
> from any of its parents, then that child is responsible for the end-result
> content at the file level.

Yeah. I made the initial implementation as absolutely simple as
possible. But after writing my comments, I can't see why I ever thought
anything but what you propose (and what I mentioned in the reply to
myself) would make any sense.

With sensible semantics, we can turn off --no-merges and still get good
results. And anybody who cares for something different can use
--no-merges themselves. Though I expect the opposite to be the case; I
can imagine somebody wanting --first-parent to blame files only to
merges.  I'll have to make sure that works properly in my re-roll.

> > The initial set of interesting files we come up with is gotten by
> > looking at the tree of the first pending object after parsing the rev
> > options (defaulting to HEAD). Which sounds a little flaky to me, but
> > does what you want in practice. I'd be curious if somebody can come up
> > with a counterexample where the ability to manually specify the source
> > tree would be more useful.
> 
> I started writing "In what sense is it flaky?  What corner case do you
> have in mind?" in a few lines above and then moved that here ;-).

I was thinking something like:

  git blame-tree dir branch1 branch2

where branch2 is actually _ahead_ of branch1. We take the file list from
branch1, but may blame commits on branch2. It's probably a little bit of
a crazy thing to ask for, though.

> The second point is "why didn't you use pathspec, but chose to take only
> one path?"  It would be useful if you can say
> 
> 	$ git blame v2.6.24..v2.6.37 -- net include/net
> 
> no?

Thanks for mentioning; it was one of the things I meant to bring up but
forgot to. There was one thing that gave me pause[1].  The paths here
are not about limiting a traversal; they are about limiting the
_initial_ tree that defines which paths we care about.  So in the
traversal above, if 2.6.25 removes net/foo.c, then a regular traversal
will think that's interesting and mention it.  But for blame-tree, we
don't want that. We want to mention net/foo.c only if it existed at the
beginning.

Of course it would be easy enough to parse the revision parameters, then
create our initial path list by combining the initial tree and the
pathspecs. But I wonder if the different semantics implies that we
should be using different syntax. I dunno.

There is also the matter of output. Right now blame-tree takes one path
parameter, we look it up as a tree, and if it's not a tree we complain.
Then we output paths that are relative to the inside of that tree. If I
have _two_ trees, what should the output be? Should all of the entries
in "net" be prefixed with net/? Should there be a "--relative" option?
What should be the default when one pathspec is given. Two pathspecs?

[1] Actually, there was a second thing, but considering it more, I think
I am just being silly. Pathspecs like that imply to me that we are
interested in all paths underneath. But blame-tree (to me, anyway) is
about listing the contents of a single tree, and not recursing. But I
think I am being silly because we _are_ interested in all things
underneath for blame-tree. We just don't necessarily mention the
details. When net/subdir/foo.c changes, we do care, we just say
"net/subdir" changed. So I think it is just a matter of my mental model
matching what is happening. And also we could support both modes (blame
a tree without recursion, or blame recursively all files under a tree).

> > So this is the per-commit processing. Basically we just do a diff for
> > each commit, and see if each path has been claimed.  Note that it
> > depends on the string-list item->util being initialized to zero. Hence
> > my recent patch to string-list, and this needs to go on top of 62b8102
> > (which is in master and maint).
> 
> Once you know who the guilty party is, can't you just remove that element
> from the list, so that later search from the "remaining path" list would
> decrease in cost as you go deeper?

You can, and I considered that, but I don't think it would speed things
up. The lookup is a binary search, so it's already lg(# of paths), and
that number is small (in the hundreds). So there's not much to be saved.
The expensive part is actually looking at the tree and doing even the
raw diff for each commit.

In an ideal world, trees would be random-access, and for each commit, I
would check each unclaimed path to see how it differed in the commit's
tree versus the parent trees. And then I would do O(# of paths) work for
each commit, with that # getting smaller each time. But obviously that
is not the case.

> Also at some point the set of remaining path would become small and it
> might make sense to feed that as diff-tree pathspec.  After all, aren't
> you re-initializing the diff machinery for each commit (which is _not_ a
> bad thing to do--I am just pointing out that there is an opportunity to
> use narrower pathspecs as you go without any additional cost)?  Note that
> I am not suggesting to update the pathspec used for commit traversal in
> the middle; that is a lot trickier.

Is that going to be any cheaper than what I'm doing now? The whole thing
is a single non-recursive tree diff. So now the diff machinery looks at
each entry, shows me the differences, and then I look them up pretty
efficiently against my list.

By feeding diff the pathspec, it still has to traverse the whole tree
looking for interesting entries comparing them against my list, and then
hand me the reduced list. Its examination of the pathspec is going to be
on par with my list lookup, complexity-wise. I guess there is one small
optimization it can do: if the trees and pathspec are sorted, as it gets
to an entry with "t" and sees that the last interesting pathspec is "q",
it knows it can stop comparing entries.

I'm not sure if we do that optimization. Even if we do, I'm not sure how
much practical difference it will make. I expect most of the time is
spent getting the tree out of storage at all, not walking the entries.
But I admit I haven't done any timing; that's just based on previous
experience.


All that being said, I think I may need to restructure diff calls
anyway. Right now I find the relevant trees and call diff_tree_sha1. But
that doesn't leave any room for rename detection, since the diff
machinery never even knows about the other parts of the project ouside
our subtree, which may be rename sources.  So probably I need to be
feeding the whole commit to the diff machinery, getting full pathnames
in my callback, and then picking out the interesting ones.

And then I _will_ need to feed the proper pathspecs to diff. Because it
won't be a matter of looking at a few extra entries in a tree we have
already pulled from storage. We need to tell diff not to delve into
those extra trees at all (unless we need them for rename sources, but we
should avoid it for the case that rename detection is not enabled).

I'll have to look into it.

> > An optimization; we can quit the traversal as soon as everything is
> > claimed. In practice this helps disappointingly little.
> 
> That is somewhat unexpected, but would strongly suggest that the approach
> to use more specific pathspec that cover only the remaining paths would
> give you faster per-commit diff?

I don't think so, for the reasons stated above. But I didn't time.

> > My merge handling is just "which files are different from the parents".
> > Which is reasonable, but I don't actually exercise it since we use
> > --no-merges by default. :)
> 
> I think that is a big mistake and I already said it above.
> 
> > We could try to do something clever here about evil merges.
> 
> Again, I wouldn't even think about it; this is a "file boundary matters"
> tool; you shouldn't care about cleanliness of content-level merges.

Yeah, I am very much in agreement with you on both points now.

-Peff
