From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] improve no-op push output
Date: Mon, 4 Jun 2012 08:51:26 -0400
Message-ID: <20120604125126.GD27676@sigill.intra.peff.net>
References: <20120530120804.GA3501@sigill.intra.peff.net>
 <7vr4u1zhcz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 14:51:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbWkw-0001jT-FB
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 14:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076Ab2FDMva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 08:51:30 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:42483
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225Ab2FDMv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 08:51:29 -0400
Received: (qmail 2395 invoked by uid 107); 4 Jun 2012 12:51:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Jun 2012 08:51:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jun 2012 08:51:26 -0400
Content-Disposition: inline
In-Reply-To: <7vr4u1zhcz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199134>

On Wed, May 30, 2012 at 10:52:28AM -0700, Junio C Hamano wrote:

> > So before, running:
> >
> >   git init -q --bare parent &&
> >   git clone -q parent child 2>/dev/null &&
> >   cd child &&
> >   echo one >one && git add one && git commit -q -m one &&
> >   git branch other &&
> >   git -c push.default=simple push
> >
> > would just print:
> >
> >   Everything up-to-date
> >
> > and now you get:
> >
> >   To /tmp/push-message/parent
> >    = [up to date]      master -> master
> >
> > which is much more informative.
> 
> I think a more interesting case is to do this in the child:
> 
> 	git checkout other
>         git -c push.default=matching push
> 
> after the above sequence.  It will try to push master to master (and
> the most important part is 'other' is not involved in this push at
> all) and would give you the same updated message, which would make
> it more clear that 'other' is not involved.

Thanks for a good example. Part of the reason my patch was RFC was that
I had a feeling there was a more general problem to be solved, and I
couldn't quite put my finger on it.

Taking a step back, the real issue is not that "everything up to date"
is not accurate for single-branch pushes. It is that users sometimes
expect a thing to have been pushed, and it is not (because the
configuration is different than they expect, or because they are on a
different branch than they expect). Sometimes that is masked by saying
"Everything up-to-date" (because the user thinks "everything" included
what they wanted, even though it did not). But sometimes it is because
things _do_ get pushed, but they fail to notice that the thing they
expected was not in the list.

So I think in general, the solution is for "git push" to be more
specific about what happened. But there are some complications, as I'll
get to below.

> Although it by itself is good, but unless you are paying attention,
> you may not catch that your current branch is *not* listed in the
> output, so it might not help people that much, even if they weren't on
> a detached HEAD.
> 
> Somebody who is unaware that she has been working on detached HEAD is
> by definition very unlikely to notice that the 'master' in the output
> is different from her current branch, as she is not paying attention
> to what branch she is working on.
> 
> It might be a better approach to check if the set of pushed refs
> include the current branch and rephrase the message only in that case,
> perhaps
> 
> 	Everything up-to-date (the current branch not pushed)
> 
> or something.

Hmm. I like that approach, because it is directly responding to a
specific thing that might be confusing the user.  But I'm not sure it is
complete.

For one thing, it only helps for the case of "push.default is matching,
and my HEAD was not pushed" (detached or not). Another one I'd expect is
"push.default is not matching, and I expected all of my work to be
pushed". And you mentioned above "push.default is matching, and I
expected 'foo' to be pushed, but forgot that upstream does not yet have
it).

Secondly, it helps the detached HEAD case for "matching", but should do
nothing for the other cases, all of which should error out (because
there is by definition no defined upstream for "upstream" or "simple",
nor would we know what to call the remote side for "current").

So I think we would really need to break down each potentially confusing
case, and come up with a solution for each. I think we can divide the
push configuration into three cases: matching, single (which includes
"upstream", "simple", and "current"), or custom refspecs. Let's ignore
the final one for now. It's relatively rare, and probably the most
common use is mirroring (in which case we know we pushed everything,
anyway). And then we have a few potential confusing situations:

  1. We are on a detached HEAD; the user expects their current work to
     be pushed, but it is not. With the "single" cases, we should
     already error out. For the "matching" case, we don't want to error
     out, but it might be worth printing a warning to say "by the way,
     your HEAD is detached", whether everything is up-to-date or not.

     Maybe that would be annoying, though. I guess it could be
     configurable with an advice.*. Or maybe it's not worth caring
     about, since we are pushing new people towards the "single" case
     anyway.

  2. We are on a branch; the user expects it to be pushed, but it is
     not. This can't happen with the "single" cases, since they always
     push HEAD (or fail). For matching, again, a solution might be "by
     the way, your HEAD was not pushed", with the same caveats as above.

  3. We are on a branch; the user expects some other branch X to be
     pushed, but it is not.

     For the "single" cases, they will either get a single-line status
     table (mentioning HEAD), or they will get "Everything up-to-date".
     In the former case, it is hopefully obvious that their branch is
     not mentioned. In the latter case, I think the "everything" is
     potentially misleading (and the fact that we never say _which_
     branch is pushed. So if they thought they were on X, but were on Y,
     they might be confused). So I think the right solution is to just
     be more specific; say "X is up-to-date", or just show the
     single-line status table.

     For the "matching" case, it's much harder.

     If we show them the whole description of what happened and hoping
     they notice that their branch is not included.  When something
     actually gets pushed, we show the status table already, and they
     may or may not look through it to find the branch in question
     (indeed, they may not even be trying to push X at the time, but
     rather may later say "Hey, I thought I pushed everything; why is X
     not here?).

     If nothing gets pushed (i.e., "Everything up-to-date"), we are not
     much better off. We don't currently show the list of what we
     attempted (without "-v"), but showing it would not be much better.
     It is potentially long, and the user has no reason to scan through
     it checking to make sure each branch is there.

     So it would really depend on us noting that the branch is
     exceptional for some reason in not being pushed. In case (2) above,
     we noted that the branch is HEAD, which makes us think maybe they
     wanted to push it, and we should give it special mention. We could
     also potentially show the list of branches that _weren't_ pushed.
     Depending on your workflow, that may be a small list, and an
     exceptional circumstance. But it may also be quite large.

Sorry, that explanation ended up long. As you can see, I'm still talking
out what the actual problem is. By the analysis above, there are
basically two features I'd consider:

  1. For a single-ref push, always mention the ref name, even if it is
     up-to-date. My previous patch showed the status table, but we could
     also just tweak the "Everything up-to-date" to say "Ref X is
     up-to-date".

     We could also consider doing it not just in the single-ref case,
     but when there are fewer than N refs. The single-ref one is the
     most interesting, though, because it hits the newer push.default
     settings.

  2. Introduce a "push.warnMatch" config option, which can be set to one
     of:

       - "none"; the current behavior

       - "branches"; mention all unmatched refs which are in refs/heads

       - "head"; mention the current HEAD if it is unmatched

-Peff
