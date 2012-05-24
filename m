From: Jeff King <peff@peff.net>
Subject: Re: t4014 broken by 43ae9f47ab: format-patch: use default email for
 generating message ids
Date: Thu, 24 May 2012 17:02:27 -0400
Message-ID: <20120524210227.GB21329@sigill.intra.peff.net>
References: <4FBE2335.2090903@jpk.com>
 <20120524171640.GB3161@sigill.intra.peff.net>
 <4FBE9EF3.9020902@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu May 24 23:02:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXfB4-0003f9-VN
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 23:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932921Ab2EXVCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 17:02:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54270
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755382Ab2EXVC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 17:02:29 -0400
Received: (qmail 510 invoked by uid 107); 24 May 2012 21:02:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 17:02:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 17:02:27 -0400
Content-Disposition: inline
In-Reply-To: <4FBE9EF3.9020902@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198430>

On Thu, May 24, 2012 at 10:49:55PM +0200, Michael Haggerty wrote:

> >Nobody should care, because either:
> >
> >   1. The defaults set up a reasonable hostname for your machine.
> >
> >   2. They do not, but you adjust it by setting user.email. Otherwise,
> >      your author ident would have this bogus email in it.
> 
> I'm trying hard not to get sucked into this topic (I just want the
> test suite to work again!) but I infer that the reason for the
> failure in my setup is that I have a global user.name but no global
> user.email configured.

No, not at all. The problem is that the test suite does not look in your
.gitconfig at all (nor should it), but rather than providing its own
sensible gitconfig, it relies on the environment variables. Your
personal setup should not be relevant; only the fact that your machine
happens to not have a fully qualified hostname.

> I want git to remind me to configure user.email at the repository
> level so that I can set my work email address for proprietary projects
> and my personal email for open-source projects.

What you're doing is sane. However, I suspect that format-patch silently
generates bogus message-ids when you do not have your user.email set
(and it always has). I wonder if it is worth having it barf when
"(none)" is in the email.

For that matter, I really wonder if the "(none)" fallback even makes
sense these days. We encourage people to set up user.*. But I guess it
helps people on remote servers which write reflogs during a push; it is
better to write junk into the reflog than to fail the push.

> Ignorant idea: since this test is executed in a test repo, would it
> help to set a dummy user.name and user.email at the test repository
> level using "git config", perhaps as part of the standard test repo
> setup?

Yes, that would solve your test failure. On the other hand, not having
it has spurred more discussion of this situation, so maybe there is some
good in having it that way.

At any rate, there is a slight complication, because tests sometimes
make their own sub-repositories. A more sensible solution would be to
put it in $HOME/.gitconfig, but that is also complicated. The tests have
$HOME set to the repository directory, so the extra cruft there would
cause some tests to fail (and splitting them into two directories would
likewise cause other tests to fail). That can be remedied, of course,
but it is definitely not a one-line fix.

I think at this point I favor just fixing your bug, either with the
patch I just posted, or a slightly nicer series refactoring fmt_ident to
handle this situation better (which I am working up right now).

-Peff
