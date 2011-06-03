From: Jeff King <peff@peff.net>
Subject: Re: git clone (ssh://) skips detached HEAD
Date: Fri, 3 Jun 2011 14:48:22 -0400
Message-ID: <20110603184822.GA20600@sigill.intra.peff.net>
References: <BANLkTi=xK+hmvGTLnKREScABU=7v_SKqPQ@mail.gmail.com>
 <20110601220518.GA32681@sigill.intra.peff.net>
 <7vipspfazy.fsf@alter.siamese.dyndns.org>
 <20110601224754.GA16820@sigill.intra.peff.net>
 <20110603050901.GA883@sigill.intra.peff.net>
 <7vaadyc2u0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 20:48:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSZQ7-0007cf-Nd
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 20:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279Ab1FCSs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 14:48:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49457
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221Ab1FCSsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 14:48:25 -0400
Received: (qmail 11709 invoked by uid 107); 3 Jun 2011 18:48:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Jun 2011 14:48:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2011 14:48:22 -0400
Content-Disposition: inline
In-Reply-To: <7vaadyc2u0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175020>

On Fri, Jun 03, 2011 at 09:11:19AM -0700, Junio C Hamano wrote:

> An alternative would be not to checkout anything when HEAD points at an
> object that does not exist, or point the HEAD at the default "master"
> branch just like in the case when we cannot guess uniquely. That way, we
> do not have to worry about having to fetch the orphaned detached HEAD,
> which is an unlikely thing the publisher wanted to feed to its recipients
> in the first place. I tend to prefer the former (i.e. resulting in no
> paths in the working tree, possibly with a big warning message "the
> repository does not suggest which branch to track---are you sure you
> wanted to clone from there?").

Yeah, I was tempted to go the "check out nothing if we don't have the
object" route. But my thinking was:

  1. We have already been creating local detached HEADs to match a
     remote detached HEAD since at least 8434c2f (Build in clone,
     2008-04-27). Should we keep doing that? If so, I think it
     introduces a somewhat confusing inconsistency from the user's
     perspective. Why is a sight-seeing detached HEAD pointing into
     history OK to checkout, but one with a commit on top is not OK?

  2. Similar to the above, we already do have the object for a local
     clone, which just copies the object db whole. So now there is an
     inconsistency that:

       git clone foo bar

     will checkout out such a HEAD, but neither of:

       git clone file://$PWD/foo bar

       git clone git://host/foo bar

     does.

  3. Fetching and checking it out just seems like the most friendly and
     the least surprising thing for the user. In 99% of cases, people
     are cloning bare repositories whose HEADs likely won't detach
     anyway (and if they did, they certainly wouldn't have made commits
     on them). But in the rare case that I _do_ clone a non-bare repo,
     what am I trying to accomplish?

     Most likely I'm trying to make a new workspace, either to work on
     the identical branch, or some other branch. In the former case,
     making a detached HEAD (whether it points to history or to a new
     commit) is what I would want. In the latter case, it doesn't really
     matter what we put in HEAD, as the user is going to switch it
     anyway. The only downside is that we may have transferred some
     extra objects; in practice, this is probably not a big deal due to
     deltas unless your detached commit is gigantic.

  4. We're guessing at whether the user will want the objects on the
     detached HEAD or not. Which means we're going to be wrong
     sometimes. But I would rather err on the side of copying the extra
     commits than not. The few extra bytes spent are a better downside
     than:

       $ git clone git://host/foo bar
       $ ssh host && rm -rf foo
       [oops, I actually wanted the detached commit!]

     Though to be fair, if we printed a warning about the detached HEAD
     during the first command, the user would hopefully not execute the
     second one.

> We treat the symbolic-ref on the publishing end not as the "current"
> branch at all. It is used as the "suggested primary branch to track".
> So allowing to fetch from a repository with detached HEAD is already a
> weird setup.

By that argument, we should stop checking out any detached HEAD at all.
Which I agree makes sense from the point of view that clone is just
"init + remote add + fetch + checkout". But I think it's probably more
helpful to the user (and doesn't cost us much) to just checkout the
detached HEAD than to refuse to check out anything and print a warning.
If we're right, they're happy. If we're wrong, the solution in both
cases is to "git checkout" what they did want.

Possibly we should warn that the cloned HEAD is detached (maybe even
with the regular detached HEAD warning).

> I am hoping that we are not setting up origin/HEAD to point at
> anything in this case, as the remote is telling us that there is no
> suggested primary branch for the clients to track by having a detached
> HEAD to begin with.

No, we don't set up an origin/HEAD at all in that case; the handling for
that and our local HEAD are separate (and I was careful to maintain this
with my patch by not setting a peer_ref to store the HEAD we fetch; it
stays in core until we write it to our HEAD).

> Even if you are fetching your own (or your pal's) repository with a
> working tree to transfer a work-in-progress, any work on detached HEAD
> that is orphaned is too transitory, and it goes against my taste to
> let people fetch from it.
> 
> But people are free to have bad taste ;-).

They can already fetch from it via "git fetch /your/pal HEAD". So this
is really just about clone. I think it is not even bad taste if your
workflow is:

  1. You're in the middle of a rebase on a detached HEAD. You make an
     amended commit, then continue. You get a conflict which is
     confusing, and inspection causes you to blame your coworker.

  2. You holler over the cubicle wall to your coworker, who runs "git
     clone ~bob/project bobs-project". They inspect your current state
     and try to cherry-pick the failed commit themselves. Either the
     merge conflicts tell them what to tell you to fix your problem, or
     perhaps they even resolve the conflicts themselves and let you
     fetch the state back.

So I think it is not a matter of taste, but of "in some (rare) cases
this is useful, and in many cases it is useless". I just think there is
no reason not to be helpful to the people in the rare cases, as it costs
so little in the other case (and remember that _without_ detached orphan
commits, this is literally a no-op).

-Peff
