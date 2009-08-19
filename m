From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 0/6] {checkout,reset,stash} --patch
Date: Wed, 19 Aug 2009 06:11:34 -0400
Message-ID: <20090819101134.GB28920@sigill.intra.peff.net>
References: <200908101136.34660.trast@student.ethz.ch>
 <200908151204.36709.trast@student.ethz.ch>
 <20090818164826.GA27377@coredump.intra.peff.net>
 <200908191140.22235.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Pierre Habouzit <madcoder@debian.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 19 12:11:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdi8y-0003vX-0g
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 12:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbZHSKLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 06:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbZHSKLh
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 06:11:37 -0400
Received: from peff.net ([208.65.91.99]:55962 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbZHSKLf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 06:11:35 -0400
Received: (qmail 18630 invoked by uid 107); 19 Aug 2009 10:11:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 19 Aug 2009 06:11:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Aug 2009 06:11:34 -0400
Content-Disposition: inline
In-Reply-To: <200908191140.22235.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126530>

On Wed, Aug 19, 2009 at 11:40:20AM +0200, Thomas Rast wrote:

> > I took a look at this today.
> Heh, now *my* procrastination is paying off :-)

Curses, I fell into your trap!

> I think that is the correct way to go about it from the user's POV.
> He would be confused if the patch applied to WT/index were different
> (because of a later merge) from the hunks he chose in the -p loop.
> 
> However, there's the issue of merge conflicts.  Some options I can
> think of are
> 
> 1) refuse to work in the face of merge problems

I had assumed we would do (1), just to keep things simple. Otherwise
stash becomes a multi-invocation command (with a --continue feature),
which really has a lot of complexity and corner cases.

> 2) stash requires a clean WT, so we can move the user's index out of
>    the way and use temporary index + WT to let the user resolve the
>    conflicts
> 
> 3) require both clean WT and index so we can simply use the repo to
>    resolve

Actually, we currently require that the index and WT match, so
these two are equivalent. But I think they add a lot of complexity
because of the continuation.

> (The first one isn't quite as restrictive as it sounds; the user can
> always apply on top of a clean HEAD, fix conflicts and re-stash, thus
> doing a "stash rebase".)

Which is really a nice way of dodging the continuation bullet, since the
results after each step are well-defined in terms of currently existing
steps. That is, the user could "git stash apply" and never invoke "git
stash apply -p" if munging the conflicts led to the result they wanted.

OTOH, it may have been simpler for them to edit the stash beforehand to
avoid the conflicts.

Hmm. Maybe we are really talking about two different commands:

  1. edit the hunks that will be applied to the working tree from the
     stash (apply -p)

  2. edit the _stash itself_, taking or leaving hunks to create a new
     stash

What was in my patch was basically (2), but then always followed by
applying. By splitting them, you can use whichever makes sense for your
situation.

> >   1. For --index mode, it actually invokes add--interactive twice. It
> >      would be nice to do both passes at the same time, but I don't think
> >      it is possible with the current add--interactive infrastructure.
> 
> Note that the 'git stash -p' in next always stashes the index whole,
> so the "easy" way might simply be to also unstash the index whole (if
> requested).

That might be worthwhile. It is less flexible, but I really wonder if
people actually keep stash randomly different changes in their index and
worktree and want to pick through them individually. I guess we could
also add a --patch-index for people who really wanted it.

-Peff
