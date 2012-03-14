From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Wed, 14 Mar 2012 09:50:10 -0400
Message-ID: <20120314135009.GA934@sigill.intra.peff.net>
References: <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <1331288715.21444.38.camel@beez.lab.cmartin.tk>
 <4F5A4C45.7070406@xiplink.com>
 <4F5AF1A8.4050604@alum.mit.edu>
 <4F5E12A5.6030701@xiplink.com>
 <vpqzkblixmb.fsf@bauges.imag.fr>
 <20120312183725.GA2187@sigill.intra.peff.net>
 <7vfwddskon.fsf@alter.siamese.dyndns.org>
 <20120313213045.GD27436@sigill.intra.peff.net>
 <7v62e8t8m5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 14:50:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7oaq-0005ab-Je
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 14:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760779Ab2CNNuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 09:50:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49143
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988Ab2CNNuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 09:50:14 -0400
Received: (qmail 9678 invoked by uid 107); 14 Mar 2012 13:50:24 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Mar 2012 09:50:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Mar 2012 09:50:10 -0400
Content-Disposition: inline
In-Reply-To: <7v62e8t8m5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193106>

On Tue, Mar 13, 2012 at 03:54:26PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The branch.*.pushRemote you mentioned would help with that. But for me,
> > I would much rather have simply push.defaultRemote.
> 
> I would think that is a natural way to extend it. Don't we already have
> something similar that is per repository default that can be overriden
> with per branch configuration?

I think branch.*.rebase / pull.rebase is the only current example. But
yeah, having a hierarchy like that makes sense to me.

> > Speaking of which, I often get annoyed at the per-branch
> > auto-configuration of upstreams. For example, I find myself doing this:
> >
> >   [get an idea, read a bug report on the list, etc]
> >   $ cd git
> >   $ hack hack hack
> >   [oh, this is turning into something real. Let's make a branch]
> >   $ git checkout -b jk/bug-fix
> >   $ git commit -m 'fix bug'
> >
> > but now my bug-fix branch is based off of wherever I was (which is
> > usually some private topic-integration branch I run most of the time).
> 
> What in "checkout -b jk/bug-fix" makes jk/bug-fix a downstream of
> origin/master?  I admit my brain is not working very well today, but I
> would have expected the branch to have either your local private topic
> integration branch as its @{u}, or no @{u} defined for it at all.  Perhaps
> there is a design error of some sort around that code?

Sorry, reading my example again, I was completely unclear. I was trying
to simplify it down to a readable case and ended up omitting the parts
that would have it make any sense.  So let me try again:

I play around with a fix or a feature on top of some random branch.
Eventually, I realize that this is a promising direction, and want to
make a topic branch. I'm in a state where I have some work-in-progress
commits on top of a random point (which yes, means my commits might be
totally bogus when ported to origin/master, but in practice, they are
close enough).

One option would be:

  $ git checkout -b jk/bug-fix origin/master
  $ git cherry-pick @{-1}~2..@{-1}

which sets up the upstream appropriately. But what I often end up doing
is:

  $ git checkout -b jk/bug-fix
  $ git rebase -i --onto origin/master HEAD~2

to tweak the patch ordering. Or even:

  $ git checkout -b jk/bug-fix
  $ hack hack hack
  [oops, this should be based on master, not where I was]
  $ git rebase --onto origin/master HEAD~2

In all three cases, I end up in the same state of history, but only in
the first one is my upstream config even remotely useful. There are
other variants, too, where I use "stash" and "reset" to end up building
on the history I want.

Two caveats before I go further:

  1. You might argue that the real problem is that I'm building the
     tentative change somewhere inappropriate. And that is kind of true,
     and this could all be averted by running "git checkout" in the
     first place to build on the appropriate spot. Though I do sometimes
     do that, too:

       $ git checkout origin/master
       $ test test test
       [ok, bug exists]
       $ fix fix fix
       [ok, this is worth a topic branch]
       $ git checkout -b jk/bug-fix

     and it also does not set up the upstream config. It would if I used
     a local "master" branch, but I do not have one (and I do not want
     one, as it would just be a pain to keep in sync with
     origin/master).

  2. I really just want everything based off of origin/master, because
     that is an implicit part of my workflow for this project. So I am
     not arguing that what "git checkout -b" does is wrong given the
     information I have given git, but that there is no place for me to
     give git that information.

So originally, I had a vague notion in my mind that I wanted some way to
tell "no, really, I always want to think of origin/master as the
upstream unless I explicitly tell you otherwise". Something like:

  $ git config branch.defaultUpstream refs/remotes/origin/master
  $ git config branch.autosetupmerge false

But having just typed out several examples, I think git _could_ figure
this out automatically. My real complaint is that as I use lower-level
tools to adjust the basis of my history, the upstream config is not
similarly updated. So another option would be:

  1. git-rebase could re-adjust the upstream config when using "--onto"
     with a branch parameter.

  2. git-reset could re-adjust the upstream config when moving directly
     to a branch.

  3. When we detach HEAD, remember the original branch name (in
     .git/ORIGINAL_BRANCH or similar); when a branch is created from
     the detached HEAD, set up ORIGINAL_BRANCH as the upstream. You'd
     probably want the "rebase" and "reset" in steps (1) and (2) to
     update ORIGINAL_BRANCH when you're on a detached HEAD.

I think that would perfectly fit my workflow. But I'm not sure if other
people would be confused by these operations changing the upstream
config (e.g., if you expect "jk/bug-fix" to have an upstream of
"origin/jk/bug-fix", when such a change would not be welcome).

> > But I think people also use upstream to mean "this is the definitive
> > version of this branch in some central repo". So they would say that
> > "jk/bug-fix" is based on "origin/jk/bug-fix". And the ahead/behind
> > message is about "do I have any local work that needs pushed, or any
> > remote work that needs pulled?"
> 
> I think that is the more common interpretation.  Earlier you said
> ahead/behind gives "some meaning", but compared to this "how many more do
> I have, how many more do others have while I was looking the other way", I
> am not sure what kind of cue that "some meaning" would give us.

If upstream is "here is where my topic is based from", then the
ahead/behind tells you how big your topic is (ahead), and whether it
might be a candidate for rebasing (behind). If your upstream is "the
central repo version of topic", then it tells you what work you have yet
to share with others (ahead), and what work others have done on the
topic that you could merge (behind).

> >> Because "upstream" is meant to be "For the branch I am on, you know
> >> how the branches map between the remote repository, so you already
> >> know what the right thing to do---do it" mode, the correct "guess"
> >> in your case is to error out and say "Nah, you are not talking with
> >> your upstream, so I do not have any clue what branches you want to
> >> push out and how. As you said that the push.default is upstream, not
> >> matching, I refuse to even do the matching push in your case.  This
> >> is an error. Be more specific".
> >
> > Yeah, I agree that is the only sane thing to do.
> 
> Perhaps this can be a good sample entry for the experimental "tracker"
> thing to keep track of to see how the workflow will evolve around it;
> unless neither of us would get to work on it immediately, it is very
> likely to be forgotten, as this is a tangent in the overall discussion,
> even though the bug is real and solution is clear.

I agree this is a candidate for that. But this is where the concept of
the tracker breaks down. Who is supposed to update it? You or me? Some
volunteer who agrees to migrate email discussion into the tracker?  I
suspect the latter will not work for a point buried so deeply in a
thread.  Which leaves you and me.

I specifically stayed out of the tracker discussion this time around
because all I had to contribute was "please no, web-based tools are an
abomination". But now that we see a potential use-case in practice, I am
realizing that I would not mind at all making a note in a todo file, or
even sending an email. But the thought of filling out a structured
problem report to go into a web-based database makes me not want to
bother.  Perhaps it is just my natural curmudgeonliness, but I think
part of it is that I know I am unlikely to actually visit the page to
ever retrieve the information.

I dunno.

-Peff
