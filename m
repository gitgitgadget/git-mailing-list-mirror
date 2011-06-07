From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Tue, 7 Jun 2011 17:45:32 -0400
Message-ID: <20110607214532.GB7663@sigill.intra.peff.net>
References: <20110607200659.GA6177@sigill.intra.peff.net>
 <7vvcwh4ako.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 23:45:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU45x-0003Jl-Gx
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 23:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757765Ab1FGVpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 17:45:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53696
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757709Ab1FGVpg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 17:45:36 -0400
Received: (qmail 21641 invoked by uid 107); 7 Jun 2011 21:45:42 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 17:45:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 17:45:32 -0400
Content-Disposition: inline
In-Reply-To: <7vvcwh4ako.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175270>

On Tue, Jun 07, 2011 at 02:04:55PM -0700, Junio C Hamano wrote:

> > As you can see, this handles only three typoes of locations: the
> Is that a recursive typo, or a typo of type?

It's art; the viewer is free to interpret based on their own
experiences.

> > Some other types I've thought of are:
> >
> >   - stashes; you can already use stashes a source with "stash@{0}". They
> >     could also be a destination, chaining to "git stash".
> 
> No opinion on this.

My initial prototype was going to have stash as a fourth location. But I
backed out a little because it was complex, and the more I think about
it, I'm not sure it's really appropriate. You can already pull _from_ a
stash by naming its commit. And putting into a stash is a bit different
than a put, because it handles both the index and the worktree, and
removes the changes from them afterwards.

So I think a better match is the idea of "git put" to a new commit on a
named branch that I showed elsewhere. And then you can "git put" off of
it later.

> >   - branches as destinations; obviously we can't change an existing
> >     commit, but what about something like:
> >
> >       git put WORKTREE BRANCH:foo
> >
> >     to optionally create a new branch "refs/heads/foo" based on the
> >     current HEAD, push changes into a temporary index that matches its
> >     tip, and then making a new commit based on top.
> 
> Should "git put WORKTREE HEAD" be equivalent to "git commit -A" then?

I'm tempted to say yes, with two reservations:

  1. Making a new commit (or even a new branch) somehow seems more
     heavyweight to me than just picking changes. So I'm reluctant to do
     it for just "git put $from HEAD"; maybe there should be a special
     token that says "yeah, make a new commit". Like:

       git put WORKTREE COMMIT:HEAD

     to commit on top of HEAD, or even

       git put WORKTREE AMEND:HEAD

     to amend HEAD (this would be useful when building up a commit
     piece by piece using "git put").

     But that is getting very magical. I have a vague feeling you could
     actually reimplement a lot of the user-facing portions of git in
     terms of these "put" operations. For example, forget the index as a
     whole and have "NEXT", "BASE", "OURS", and "THEIRS" representing
     trees of the various stages.

     I'm not sure if that's just insane, though. That _isn't_ how the
     index actually works (e.g., resolved paths would have only a NEXT
     entry, so the other trees would actually be partial trees). So
     we're making an abstraction over it, and when that abstraction
     leaks, I fear things will get very confusing for the user.

  2. There is a slight incompatibility between the "git put" mental
     model and what really happens. I already ran into it once with "git
     put HEAD WORKTREE", and it appears here again. The issue is that
     you generally _don't_ put items straight from a commit to the
     worktree and vice versa. They go through the index.

     So I took care with "git put HEAD WORKTREE" that the index was not
     touched. That makes the command very obvious and keeps the sources
     and destinations as orthogonal as possible. But is it really what
     the user wants? In the case of "checkout", I'm not sure. In the
     case of "commit -A", you probably _do_ want to update the index if
     the commit is HEAD, and _don't_ if it is another branch.

     But now we're getting magical again. So the question becomes:
     should git put just be a pure _wrapper_ around these other
     commands to aid in discoverability, and do sensible things for each
     combination, or should it be a purely orthogonal "pick content from
     source to destination" command?

> >   - allow multiple destinations, like
> >
> >      # equivalent to "git checkout --"
> >      git put HEAD INDEX,WORKTREE
> 
> This is close to going overboard, but OK.

Yeah, I'm still kind of brainstorming, but I think you might be right.
But see above for why "git put" should possibly just be doing it for
you automatically.

> >   - subtrees as locations. This allows a form of renaming between old
> >     versions.
> >
> >       git put gitgui-0.10.0: WORKTREE:git-gui
> 
> This is a natural extension of the above "we could rename" theme, right?

Yeah, I think so.

> The only worry about confusion is if people incorrectly think these magic
> tokens are not mere syntax sugars available only in "put", especially,
> they look so similar to "HEAD" which is _not_ syntax sugar and can be used
> elsewhere. Other than that, I think this is a nice approach.

I think it might be worth using the same tokens in "diff", but yeah,
they definitely should not go elsewhere.

I find the all-caps ugly, and it is part of what confuses them with
HEAD. At the same time, we are using the same namespace that ref lookup
uses. So calling it "worktree" might be too ambiguous. I tried to avoid
using "--worktree" because I wanted to make it clear that these were
ordered arguments, not options.

There's also one other complication with the whole idea, which is that
there are two separate things you might want to move: content itself, or
_changes_ in content.

That is, think about the way stashes work. We don't apply the difference
between the stashed content and our working tree. We look at the
difference between the stashed content and its parent, and then apply
those changes to the working tree.

When I do "checkout -p $commit $file", I am often not interested in
seeing all of the differences between where I am now and where $commit
is, but rather in seeing the differences introduced by $commit, and
pulling them selectively into my current version of $file. Sort of a
"cherry-pick -p".

Should "put" support that kind of usage? What would it look like?

  git put commit:v1.7.5 WORKTREE Makefile

? Or even:

  git put v1.7.4..v1.7.5 WORKTREE Makefile

I dunno. Maybe this whole thing is too crazy. I'll think on it some
more, and maybe some other people will comment.

-Peff
