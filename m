From: Jeff King <peff@peff.net>
Subject: Re: git commit --amend safety check?
Date: Wed, 11 Mar 2015 04:13:29 -0400
Message-ID: <20150311081329.GA11087@peff.net>
References: <CAJo=hJuwdOzNZSVBRAPDz97Gdoi6JWvYxE0ufY+Hd9K8jjCqfA@mail.gmail.com>
 <xmqq8uf46ru8.fsf@gitster.dls.corp.google.com>
 <CAJo=hJtxeZGyP=VxLSdDzoMOtVZTFNsNTqPpNUTXUOBDZKzY9Q@mail.gmail.com>
 <CAPc5daVMec1okdBW3Wo_gEr7W3FwRwmH5pmiiMaAgGoN7MGa_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 09:13:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVbm2-00076i-Mv
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 09:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbbCKINg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 04:13:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:60106 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751279AbbCKINc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 04:13:32 -0400
Received: (qmail 4013 invoked by uid 102); 11 Mar 2015 08:13:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Mar 2015 03:13:32 -0500
Received: (qmail 25908 invoked by uid 107); 11 Mar 2015 08:13:40 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Mar 2015 04:13:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Mar 2015 04:13:29 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daVMec1okdBW3Wo_gEr7W3FwRwmH5pmiiMaAgGoN7MGa_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265315>

On Tue, Mar 10, 2015 at 11:18:45PM -0700, Junio C Hamano wrote:

> Even though we cannot prevent the user from rewriting what _he_
> already pushed out to refs/for/master (as we do not have the record
> of what the last thing we pushed there and its history via a reflog),
> we could at least detect when he attempts to rewrite what he
> obtained directly from the upstream by noticing where origin/master
> is. If HEAD is _at_ that commit, or its ancestor, then he is trying to
> rewrite what he got from elsewhere.
> 
> It would catch your original "commit --amend -m 'my first'" scenario.
> Run is_ancestor(HEAD, @{upstream}) we can notice. That may be
> better than nothing, but I do not offhand know if that is sufficient.

I think rebase basically suffers the same problem, too. Perhaps it
happens less there because we choose @{upstream} as the default fork
point. But rewriting commits is a potential problem any time they are
referenced somewhere else. For example, if you do this:

  git checkout -b topic origin/master
  ... commit commit commit ...
  git checkout -b subtopic
  ... commit commit commit ...
  git checkout topic
  git rebase ;# or git pull --rebase

you are left with doppelganger commits in "subtopic", which you probably
want to handle by rebasing it (with --fork-point).

I kind of wonder if the check should just be "is the commit you are
rewriting mentioned in _any_ ref except the current HEAD?".

In theory we could even give advice based on the command and the ref we
find that contains the commit (e.g., if it's another local branch,
suggest rebasing that branch. If it's in @{upstream}, suggest "commit"
without "--amend" if that was the command given). But I'm not at all
confident that we could cover all cases thoroughly enough to do more
good than harm.

> > Another way users get into a bind is they pull someone else's branch
> > (so they can build on top of her work), then `git commit --amend -a`
> > by mistake instead of making a new commit.
> 
> One thing we already do is to give an extra "Author: " line in the
> comment when the user edits the log message, so that it is clear
> that what is being edited is not their own work but hers. We obviously
> can add the extra warning, when the is_ancestor() thing triggers, to
> say YOU ARE REWRITING PUBLISHED HISTORY in blinking red
> bold letters there.
> 
> But the symptom indicates that they are not reading these warning
> comment. Perhaps it is necessary to introduce a training wheel mode
> where you cannot use "--amend" and "-m" options from the command
> line until you ask nicely to override it?

It's entirely possible to me that the "Author" line is too subtle, and a
bigger warning might do the trick.

At the very least printing a warning that can be suppressed with
advice.* would match our usual technique for dealing with possible
mistakes like this (as opposed to blocking the action entirely). And we
can always bump the severity of the warning (or introduce blocking) if
it doesn't have an effect.

I dunno. It feels like such a warning would probably trigger as a false
positive way too often and get in people's way. But then, I am not
exactly the target audience for the warning, so my perspective is a bit
skewed. I do think it has a reasonable chance of irritating old-timers,
even with an escape hatch. Were you thinking that training-wheel mode
would have to be turned on explicitly?

-Peff
