From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] improve no-op push output
Date: Tue, 5 Jun 2012 06:10:19 -0400
Message-ID: <20120605101019.GA30402@sigill.intra.peff.net>
References: <20120530120804.GA3501@sigill.intra.peff.net>
 <7vr4u1zhcz.fsf@alter.siamese.dyndns.org>
 <20120604125126.GD27676@sigill.intra.peff.net>
 <7vzk8jt4q5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 12:10:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbqig-0000iB-QB
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 12:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761616Ab2FEKKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 06:10:24 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43196
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754457Ab2FEKKW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 06:10:22 -0400
Received: (qmail 16215 invoked by uid 107); 5 Jun 2012 10:10:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 06:10:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 06:10:19 -0400
Content-Disposition: inline
In-Reply-To: <7vzk8jt4q5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199226>

On Mon, Jun 04, 2012 at 09:35:30AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So I think we would really need to break down each potentially confusing
> > case, and come up with a solution for each. I think we can divide the
> > push configuration into three cases: matching, single (which includes
> > "upstream", "simple", and "current"), or custom refspecs. Let's ignore
> > the final one for now. It's relatively rare, and probably the most
> > common use is mirroring (in which case we know we pushed everything,
> > anyway). And then we have a few potential confusing situations:
> 
> Does "single" include "upstream", "simple" and "current", or does it
> consists of these three and nothing else? I think it is the latter,
> and I mean the latter in the remainder of my response. Specifically,
> I would exclude the case where you have remote.$there.push that only
> pushes one ref from "single".

Yes, I think it is just those cases in my analysis (which is different
from my original patch).  We can probably assume that somebody
specifying a refspec on the command line, or one with configured push
refspecs, would know what they are doing.

> >   1. We are on a detached HEAD; the user expects their current work to
> >      be pushed, but it is not. With the "single" cases, we should
> >      already error out.
> 
> All the "single" cases should error out when run on a detached HEAD
> (otherwise they should be fixed).

They do (I just checked). However, "current" only fails because the
right-hand-side HEAD is not fully qualified, and thus the message is
somewhat daunting:

  error: unable to push to unqualified destination: HEAD
  The destination refspec neither matches an existing ref on the remote
  nor begins with refs/, and we are unable to guess a prefix based on
  the source ref.
  error: failed to push some refs to ...

whereas the simple/upstream case says:

  fatal: You are not currently on a branch.
  To push the history leading to the current (detached HEAD)
  state now, use

      git push github HEAD:<name-of-remote-branch>

It might be nicer for "current" to print the same message (the advice
should be identical in both cases).

> >      For the "matching" case, we don't want to error
> >      out, but it might be worth printing a warning to say "by the way,
> >      your HEAD is detached", whether everything is up-to-date or not.
> 
> Both "matching" and "specific remote.$there.push" cases are "it does
> not matter what branch happens to be checked out; I am giving you
> the set of refs I want to push out by default", so even though you
> said you ignore the specific refspec case, they fall into the same
> category here.

Yes, I think they do collapse to the same case. I omitted custom
refspecs out of simplicity in my analysis. But if they fall into the
same slots, then all the better.

> I find the above an unnecessarily roundabout way to help people who
> expect the current branch to always be involved in an unnamed push
> to say "your HEAD is detached"; it requires them to be intelligent
> enough to connect "HEAD detached", "no current branch" and "hence
> nothing pushed".  A more direct way "detached HEAD not pushed" may
> be better.

Agreed. That is what I intended, but I obviously didn't say it very
well.

> >   3. We are on a branch; the user expects some other branch X to be
> >      pushed, but it is not.
> >      ... So I think the right solution is to just
> >      be more specific; say "X is up-to-date", or just show the
> >      single-line status table.
> [...]
> >      For the "matching" case, it's much harder.
> >
> >      If we show them the whole description of what happened and hoping
> >      they notice that their branch is not included.  When something
> >      actually gets pushed, we show the status table already, and they
> >      may or may not look through it to find the branch in question
> >      (indeed, they may not even be trying to push X at the time, but
> >      rather may later say "Hey, I thought I pushed everything; why is X
> >      not here?).
> 
> We can cover both the "here are the list" and the "everything
> up-to-date" cases with "(current branch not pushed)" (or "detached
> HEAD not pushed)".

That helps with only the current branch. The point of this scenario is
that it is some random branch. Like:

  git checkout topic
  hack hack hack
  git checkout master
  hack hack hack
  git -c push.default=matching push

Git really has no way of knowing that it's interesting to you that
"topic" didn't get pushed.

The right answer might be to simply discount this scenario. I think it's
probably less common than the "I thought I was pushing my current HEAD"
confusion which comes up.

> >   1. For a single-ref push, always mention the ref name, even if it is
> >      up-to-date. My previous patch showed the status table, but we could
> >      also just tweak the "Everything up-to-date" to say "Ref X is
> >      up-to-date".
> 
> I think this is a sane thing to do in any case.

Here, do you mean when there is a single ref attempted, or do you really
mean "when we invoked current, simple, or upstream push.default?"

> >   2. Introduce a "push.warnMatch" config option, which can be set to one
> >      of:
> >
> >        - "none"; the current behavior
> >
> >        - "branches"; mention all unmatched refs which are in refs/heads
> 
> Doesn't this assume that among many existing branches, what are not
> pushed are minority (hence it is easier to spot the presense of the
> interesting branch in the output, than to spot the absense of the
> list of updated ones)? I am not convinced if that is the case, and I
> doubt it would be very useful.

Yes, which is why it is configurable. For some workflows, you will push
most of your branches, and hold back only a few as private. In that
case, warning on unmatched branches would be helpful. For somebody like
you, pushing to ko would look awful, because you hold back all of the
topic branches (even though you push them elsewhere, it is not relevant
to the ko "matching" push).

So I would certainly never make "branches" the default. I am somewhat
lukewarm on it as a concept anyway; these possible directions were not
"we should definitely do this" but just "here is an initial sketch of
some ideas I had".

> An alternative might be to show the usual list of refs with [up to date]
> marks even when we currently say "Everything up-to-date", like "push -v"
> does.  I.e. instead of:
> 
>         $ git push ko
>         Everything up-to-date
> 
> we can say
> 
> 	$ git push ko
> 	To: kernel.org:/pub/scm/git/git.git
>         = [up to date]      maint -> maint
>         = [up to date]      master -> master
>         = [up to date]      next -> next
>         = [up to date]      pu -> pu
> 
> omitting "Pushing to $where" at the beginning and "Everything up-to-date"
> at the end of the "push -v" output.

But that has the opposite verbosity problem as above. If you have a lot
of branches, most of which have not been updated, then we will print a
lot of useless noise, hiding the actual interesting ref updates.

If you are proposing to do it only when everything is up-to-date, that
is slightly better. In that case, you are not hiding real ref updates
amidst the noise. But it is still very noisy. And it does not really
accomplish much, if your point is to show the user that the thing they
might have wanted to push was omitted.

> >        - "head"; mention the current HEAD if it is unmatched
> 
> This might be a sane thing to do unconditionally, especially if it
> can be done without taking too much screen real estate.

Yeah. Of the three values, I would probably suggest "head" as the
default. With "none" for people who want to say "shut up git, I am fully
aware of how matching works", and "branches" for people who want to be
verbosely informed.

But if we drop the "branches" setting, and the message is unobtrusive,
it may not be worth having it configurable at all.

-Peff
