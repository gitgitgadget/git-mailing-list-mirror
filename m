From: Jeff King <peff@peff.net>
Subject: Re: Push from an SSH Terminal
Date: Sat, 4 Feb 2012 03:09:10 -0500
Message-ID: <20120204080910.GA28317@sigill.intra.peff.net>
References: <CAG94OYxX5foffvaFLQv7=wXguGC2TLgccdDFrC+ERzv_gXZ=ug@mail.gmail.com>
 <21607.38.96.167.131.1328286083.squirrel@mail.lo-cal.org>
 <CAG94OYxbOYCjd5qNBh8EF2gyezHWMqX1-R2MYgk8gkFYcrMjuQ@mail.gmail.com>
 <34592.38.96.167.131.1328289027.squirrel@mail.lo-cal.org>
 <20120203213654.GD1890@sigill.intra.peff.net>
 <7vwr83hwg0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	Neal Groothuis <ngroot@lo-cal.org>,
	Feanil Patel <feanil@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 09:09:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtagQ-0003kH-Br
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 09:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559Ab2BDIJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 03:09:13 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57389
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474Ab2BDIJM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 03:09:12 -0500
Received: (qmail 8214 invoked by uid 107); 4 Feb 2012 08:16:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Feb 2012 03:16:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Feb 2012 03:09:10 -0500
Content-Disposition: inline
In-Reply-To: <7vwr83hwg0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189858>

On Fri, Feb 03, 2012 at 11:47:11PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Feb 03, 2012 at 12:10:27PM -0500, Neal Groothuis wrote:
> > ...
> >> Check to see if the GIT_ASKPASS and/or SSH_ASKPASS environment variables
> >> are set, and if the core.askpass config variable is set.  If any of these
> >> are set, unset them.  Git should fall back to a simple password prompt.
> >
> > Hmm, yeah that is likely the problem. I was thinking git would fall back
> > to asking on the terminal, but it does not. We probably should.
> 
> How well would it mesh with the goal of the ss/git-svn-prompt-sans-terminal
> topic, which is now stalled [*1*]?  I do not mean this change and the other
> topic textually conflict with each other---but the philosophies of this
> topic and the other one seem to conflict.  Not falling back to the terminal
> that is not available and failing the command outright might make more
> sense.

I don't see a conflict in the two series. That one seems to do two
things for perl programs:

  1. respect SSH_ASKPASS along with GIT_ASKPASS

  2. prefer askpass over asking on the terminal

But both of those are already the case in the C code.

If you look into the original complaint mentioned in the commit
messages, though, you will see that the some GUIs will appear to hang
when the terminal is prompted (because the prompt is reading from some
location invisible to the user). So in that sense, my patches could be a
regression for those users, as outright failing is better for them.

But I would argue that the bug is not prompting on the terminal, but
rather that the terminal-prompting code does not recognize when there is
no terminal connection to the user (and AFAICT, this is a Windows
problem). Any solution that doesn't fix that is really just papering
over the problem, and hurting people[1] on sane systems.

So I'd rather see the version of getpass() in compat/mingw.c better
learn to realize when we aren't actually connected to a console.

-Peff

[1] The amount of hurt is relatively small, though. It only hurts people
    who set GIT_ASKPASS but can't use it (e.g., you set it in your
    .bashrc because you connect via "ssh -X", but this time you happen
    to be ssh-ing from a Windows box). And you can generally fix that
    outside of git (e.g., by checking $DISPLAY before setting the
    variable).

    So one one hand, I don't want to make a decision on behavior for
    Unix users because we have to cater to Windows shortcomings. On the
    other hand, while fixing the root problem is preferable, if
    for whatever reason we can't reliably find out whether the user is
    actually going to see and respond to the prompt on Windows, it may
    be practical to just paper over the issue. On the gripping hand,
    after the Sven's series, TortoiseGit users would see the hang
    (instead of a failure) _only_ if their askpass command failed. Which
    is also perhaps not that big a deal.
