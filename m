From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/13] format-patch: use default email for generating
 message ids
Date: Mon, 21 May 2012 02:36:43 -0400
Message-ID: <20120521063643.GC2077@sigill.intra.peff.net>
References: <20120518230528.GA30510@sigill.intra.peff.net>
 <20120518231347.GF30031@sigill.intra.peff.net>
 <7vzk928clf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 08:36:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWMEc-0006yG-4r
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 08:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab2EUGgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 02:36:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50629
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab2EUGgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 02:36:45 -0400
Received: (qmail 31135 invoked by uid 107); 21 May 2012 06:37:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 02:37:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 02:36:43 -0400
Content-Disposition: inline
In-Reply-To: <7vzk928clf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198085>

On Sun, May 20, 2012 at 07:58:04PM -0700, Junio C Hamano wrote:

> > Technically this is a regression if you really wanted:
> >
> >   GIT_COMMITTER_EMAIL=some.addr@example.com \
> >   git format-patch --thread=deep
> >
> > to make your environment variable part of the message-ids. I don't think
> > it matters, but I can adjust it if we care.
> 
> Is it because you no longer explicitly ask for "committer" and get generic
> "who am I" bit from the ident infrastructure?

Right. Calling git_committer_info will also check
getenv("GIT_COMMITTER_EMAIL"), but we don't bother to do that here. We
could change the code to:

  const char *email = getenv("GIT_COMMITTER_EMAIL");
  if (!email)
          email = ident_default_email();

if it matters. I don't think it's worth building an alternate version of
git_committer_info that doesn't do the "name" half of the info.

> I wouldn't be surprised if some automated "commit email notification
> reacting to push" bot in post-receive hook is using the environment
> variable to affect the message ID.  I would doubt that would break the
> message as long as the message ID generated from this codepath stays
> valid, though, so I wouldn't worry about complaints along the lines of
> "you started using names different from what you used to use".  As long as
> we don't die due to "Hey bot, you do not seem to have a valid e-mail
> address!", I don't think we need to worry about it.

No, we'll never die as a result. But if you have a poorly configured
machine, you might get "user@host.(none)". Or I suppose you could leak
information about the username of the post-receive process. In both
cases, we do this already, so the only change is if you are trying to
override that with GIT_COMMITTER_EMAIL.

So it's a little far-fetched, which is why I didn't bother. But the code
above is quite simple, so maybe it is better to be conservative.

-Peff
