From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2011, #06; Sun, 27)
Date: Tue, 1 Mar 2011 15:54:24 -0500
Message-ID: <20110301205424.GA18793@sigill.intra.peff.net>
References: <7vy650k62n.fsf@alter.siamese.dyndns.org>
 <AANLkTikW1GVzFoq=zUxvi7MTcUYBLO6fbjJPVZziLUk8@mail.gmail.com>
 <7v7hckje4n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 21:54:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuWaO-0001Dt-2D
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 21:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757390Ab1CAUyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 15:54:18 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:36521 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754116Ab1CAUyR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 15:54:17 -0500
Received: (qmail 10371 invoked by uid 111); 1 Mar 2011 20:54:14 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Mar 2011 20:54:14 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2011 15:54:24 -0500
Content-Disposition: inline
In-Reply-To: <7v7hckje4n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168258>

On Mon, Feb 28, 2011 at 08:52:08AM -0800, Junio C Hamano wrote:

> > On Mon, Feb 28, 2011 at 07:48, Junio C Hamano <gitster@pobox.com> wrote:
> >> * jc/checkout-orphan-warning (2011-02-18) 1 commit
> >>  - commit: give final warning when reattaching HEAD to leave commits behind
> >>
> >> Likes, dislikes?
> >
> > I can't find a message containing this commit title, can you link to
> > the relevant thread?
> 
> This is a re-roll of a fallout from this thread:
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/166595/focus=167133
> 
> I do think the safety net for detached HEAD is a bit too flimsy, and that
> is the motivation behind this.

I've been meaning to look more closely at this for a while. I like it.
There is some small overhead in the revision traversal, but in my
(admittedly not very rigorous) tests it is not noticeable.

I complained before about the possibility of going to the roots, but of
course that doesn't happen here because the regular traversal does
respect commit timestamps as a hint to stop (so it is subject to skew,
but that is nothing new).

> I am not convinced that this patch nailed that balance at exactly the
> right place, even though I think we are getting closer than before.  In
> this sequence:
> 
>     $ git checkout somewhere^0
>     $ git commit
>     $ git reset --hard somewhere_else
>     $ git commit
>     $ git checkout master
> 
> The second commit is protected with the patch, but not the first one,
> which is still protected by the reflog on HEAD (i.e. "git log -g HEAD").
> You have to know the reflog on HEAD if you _intend to_ work on detached
> HEAD anyway, and you don't need this patch if you do---the second commit
> can also be recovered from the reflog on HEAD.

I really wouldn't expect it to help here. The problem isn't that you're
on a detached HEAD. It's that you're using "git reset" at all. If you
did that while on a branch, you would still have to pull the result from
the reflog. Maybe somebody has a clever idea to deal with that, but it
is a separate problem (and personally, I think the answer is "reset is
dangerous; don't use it". That isn't the case with the detached head,
because checkout and commit are usually safe, and it is more about
people being confused about their state when they make commits).

As far as the balance struck in the patch, the decisions I see are:

  1. When to warn. I think "when commit does not match a ref exactly" is
     going to have too many false positives. Reachability seems like the
     best answer, as long as the computation time doesn't turn out to be
     too expensive.

  2. Whether to block the checkout or warn.  You chose warn, and I
     agree. The advice for fixing it is the same whether we go through
     with the checkout or not. Blocking it just makes the "so what, I
     want to throw those away" choice unnecessarily annoying.

So I'm curious what you think is missing in the balance you mentioned
above.

A few other things I noticed are:

  - I like that you show the commits about to be dropped. That helps the
    user make the decision, and it is not expensive to calculate since
    we are in the uncommon "safety valve kicks in" case.

    I did find the " - oneline" format a little off. Maybe just because
    I am so used to regular git output. But I think just using " %h %s",
    e.g.:

       1234abcd commit subject one
       5678defa commit subject two

    would be better. Users are (hopefully) used to seeing commits listed
    in that form, and the sha1s are useful if you are a clueful user and
    your decision isn't to make a branch, but rather to say "Oh, the top
    one is junk but the second is useful". And then you can cherry-pick
    it, look at it in more detail, or whatever.

    In other words, I think this safety valve is not just useful for
    clueless people who make commits without realizing they're on a
    detached HEAD. It is also useful for clueful people as a helpful
    reminder that they may be leaving commits behind, and they can
    ignore or deal with it as appropriate. I tend to ignore the
    "Previous HEAD was..." message because it shows _every time_,
    whether those are my new commits or not.

  - It should probably be wrapped in advice.abandonDetachedCommits or
    something. If turned off, we can omit the check altogether
    (and possibly retain the "Previous HEAD was..." message, though I'm
    not sure). But I can also imagine a "short" version that just shows
    a single-line "warning: you are leaving %d commits behind" and the
    oneline of each, but without the "here's where to go from there"
    advice. I would probably use the short version myself.

  - Nit: you nicely use "%d commit%s" to handle the single/plural case
    in the warning message, but then you "them" later on. It needs
    (1 < lost) ? "them" : "it".

> So this patch is not about helping people who _chose to_ work on detached
> HEAD; instead the patch in its current form is about helping sightseers
> who has become _only_ a bit adventurous.  To help people who accidentally
> started from a detached state (i.e. starting from sightseeing but then got
> very adventurous, forgetting that they are not on any branch) and spent
> significant amount of time committing and resetting, the advice message
> should teach them to use "log -g HEAD" more explicitly, instead of giving
> details of the last state (i.e. "you are leaving %n commits behind...").

Ah, I think this is maybe where your reset example comes in. I remember
in early discussions of detached HEAD you recommending the workflow:

  # sightsee to some tag
  git checkout v1.7.4
  # now sightsee somewhere else
  git reset --hard v1.7.3
  # now go back to a branch
  git checkout master

But isn't that second step much better accomplished with "git checkout
v1.7.3" ? It's conceptually much simpler (you use the same command to
sightsee the first time as the second, and you don't have to know what
in the world --hard means), it's less typing, and it has better safety
valves (even before the valve we are talking about).

So I don't think it is worth thinking too hard about people doing random
resets in the middle of a detached HEAD. We should just not recommend
reset as a command for this (and indeed, I think it already has a bit of
a reputation among newer git users as a dangerous and scary thing to
do. Which is probably fine).

If we do want to teach reset users about reflog, then I think that is a
separate issue from the detached HEAD case (and I would _certainly_ wrap
that in an advice.* config :) ).

-Peff
