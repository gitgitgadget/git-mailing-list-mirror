From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Tue, 14 Feb 2012 17:47:41 -0500
Message-ID: <20120214224741.GH24802@sigill.intra.peff.net>
References: <4EF9ED58.8080205@tu-clausthal.de>
 <20120103184022.GA20926@sigill.intra.peff.net>
 <4F37E2B0.9060007@tu-clausthal.de>
 <201202121711.45920.jnareb@gmail.com>
 <4F37E843.6070107@tu-clausthal.de>
 <20120214222055.GE24802@sigill.intra.peff.net>
 <7v4nut59hw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:47:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxRA6-0005Rj-Ho
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757369Ab2BNWrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 17:47:46 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36029
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755509Ab2BNWrp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:47:45 -0500
Received: (qmail 13648 invoked by uid 107); 14 Feb 2012 22:54:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 17:54:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 17:47:41 -0500
Content-Disposition: inline
In-Reply-To: <7v4nut59hw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190787>

On Tue, Feb 14, 2012 at 02:35:23PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   export SSH_ASKPASS=whatever
> >
> >   # this will try the terminal first, then SSH_ASKPASS, because it is
> >   # ssh doing the asking
> >   git push ssh://example.com/repo.git
> 
> Sorry, you lost me here.  Does "ssh example.com" consult the terminal
> first and then fall back to SSH_ASKPASS environment variable?

Yes. Try:

  SSH_ASKPASS=cat ssh example.com

where cat is any program whose running you could detect (in this case,
because cat will complain to stderr about not being able to open its
argument). And "example.com" must be something that you can actually
make an ssh connection to.

Compare with:

  SSH_ASKPASS=cat setsid ssh example.com

which will realize it has no controlling tty, and fallback to
SSH_ASKPASS.

I actually find the behavior slightly annoying (because sometimes you do
have a controlling terminal, but it is not accessible or obvious to the
user). But I think it's important to be consistent, and provide
GIT_ASKPASS for people who really want to say "no, don't even bother
with the terminal".

> I was under the impression that SSH_ASKPASS was to either give hands-free
> access to the keychain or give GUI experience so that people do not have
> to type from their terminals...

Not exactly. It's useful in two situations (in my experience):

  1. A GUI program spawns an ssh tunnel, and there is no tty on which to
     prompt the user.

  2. Populating an ssh-agent via ssh-add during the user's login
     sequence.

It doesn't work to give a GUI experience to creating a remote terminal
session, since if you have a terminal, it will always prefer to prompt
on the terminal.

-Peff
