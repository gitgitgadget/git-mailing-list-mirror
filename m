From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout: honor advice.detachedHead when reattaching to
 a branch
Date: Fri, 6 May 2011 21:38:47 -0400
Message-ID: <20110507013847.GA25771@sigill.intra.peff.net>
References: <7vei4bzhwm.fsf@alter.siamese.dyndns.org>
 <20110506223847.GC17848@sigill.intra.peff.net>
 <7vbozfxwon.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 03:38:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIWTw-0004iq-LX
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 03:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381Ab1EGBiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 21:38:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50389
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871Ab1EGBiv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 21:38:51 -0400
Received: (qmail 15341 invoked by uid 107); 7 May 2011 01:40:45 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 May 2011 21:40:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 May 2011 21:38:47 -0400
Content-Disposition: inline
In-Reply-To: <7vbozfxwon.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173030>

On Fri, May 06, 2011 at 03:59:20PM -0700, Junio C Hamano wrote:

> > I'm somewhat negative on this. I think there are actually 5 distinct
> > pieces of information that git currently gives in going to and from a
> > detached HEAD, and the motivations for suppressing them may be
> > different:
> >
> >   1. On detaching, we indicate briefly that the HEAD has been detached
> >      by saying "HEAD is now at ..." instead of "Switched to branch ...".
> >
> >   2. On detaching, we give a large warning on what the detached HEAD
> >      state means, and advise on how to get out of it.
> >
> >   3. On leaving, if there are no orphaned commits, we indicate briefly
> >      where the previous HEAD position was with "Previous HEAD position
> >      was...".
> >
> >   4. On leaving, if there are orphaned commits, we list them.
> >
> >   5. On leaving, if there are orphaned commits, we give advice on how to
> >      make branches out of them.
> >
> > Right now, advice.detachedhead suppresses (2); that is, we leave the
> > short indicator that provides distinct per-use information to the user
> > (1), but suppress the lengthy advice that is not helpful to advanced
> > user.
> >
> > So if you wanted symmetry, I think that would mean suppressing (5), but
> > leaving (4), which contains per-use information, intact.
> 
> The patch does leave per-use information by giving 3. "HEAD was" as you
> noted above, and that is more than sufficient (you can also look at
> HEAD@{0}).  If and only if the list is needed (i.e. the user wants to
> recover), the user can run "git log $that_commit".

I think we're probably in agreement on how to go forward, but I wanted
to note one final thing. It is actually not the list itself which is
that valuable to me. It's merely a convenience; if I know there is
something worth looking at, I am perfectly capable of inspecting the
history graph myself.

The real value in the orphan-check to me is whether it says "hey, there
are orphaned commits" or not. Before we had that check, leaving the
detached state _always_ said "Previous HEAD was...", and I quickly
learned to ignore it as uninteresting noise in 99% of the cases. Whereas
in the orphan warning case, I find that I want to do something about it
in at least 50% of the cases. Thus I actually heed the warning, and it
is effective.

It's possible that some people would find it useful to print only the
"warning: you are leaving orphaned commits" message, but not show the
list of them. I don't think it is worth it, though. Leaving orphaned
commits is the uncommon case, and doing so without wanting to
investigate is probably even less common. So the user is not too likely
to get annoyed by a little extra verbosity in the uncommon false
positive case.

-Peff
