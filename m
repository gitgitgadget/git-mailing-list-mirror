From: Jeff King <peff@peff.net>
Subject: Re: Handle HTTP error 511 Network Authentication Required (standard
 secure proxy authentification/captive portal detection)
Date: Mon, 20 Feb 2012 08:56:39 -0500
Message-ID: <20120220135639.GA5131@sigill.intra.peff.net>
References: <4b8f33ba4c870528a82ab85d6dad68bd.squirrel@arekh.dyndns.org>
 <20120220010617.GB4140@sigill.intra.peff.net>
 <9cd657a3c4960a8c496515a03bbf623e.squirrel@arekh.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 14:56:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzTjX-00071n-OC
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 14:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733Ab2BTN4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 08:56:47 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43782
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab2BTN4q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 08:56:46 -0500
Received: (qmail 796 invoked by uid 107); 20 Feb 2012 13:56:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Feb 2012 08:56:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2012 08:56:39 -0500
Content-Disposition: inline
In-Reply-To: <9cd657a3c4960a8c496515a03bbf623e.squirrel@arekh.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191068>

On Mon, Feb 20, 2012 at 06:38:54AM +0100, Nicolas Mailhot wrote:

> > As a non-browser client, what should git do? We can't make sense of the
> > content at http://login.corporatenetwork, which is most likely an HTML
> > form asking for credentials (or even money, if the captive portal is
> > something like a public wireless provider). The best we can probably do
> > is die and say "apparently you need to go http://login.corporatenetwork
> > in a browser before making your request".
> 
> Actually, the best would be to launch something capable of interpreting html
> forms on the url given by the error.

Doing that portably is near impossible (keep in mind that git runs on
things like antique versions of Solaris). Not to mention that git is
often running without a user present, or on a remote system connected
to the user only by ssh. So our best bet would probably be a
configuration option to tell git how to run a browser. Distributions
which ship binary packages could ship a sane default for their system.

> But short of that, that depends on how good git is at resuming work
> later. Error 511 can occur at any time, not just on initial connection
> (because credentials can expire at any time). So pausing may be better
> than dying.

It can, but I doubt it is a big problem with smart-http. We will make a
handful of quick negotiation requests at the beginning, and then the
bulk of the data will come over a single http request.

> However without going there: the portal page will usually be pretty simple, a
> standard basic auth form, can't git handle this? If simple web clients such as
> git have specific constrains on what can appear or not on this page, can you
> not define them and send them ietf-side so they can document them in a later
> rfc revision?

Git handles http basic auth. But my experience has been that captive
portals almost _never_ do basic auth. Instead, they give you an html
page with a bunch of form fields. And possibly some javascript required
to submit it. Git does not understand either of those things, and nor
should it; spawning a browser is the right thing to do there.

I don't think the IETF can or should mandate what goes on such a page.
Some portals will want login/password. Some will want billing
information. Some will even want other things (at some airports, I have
seen captive portals offer the option to take a short survey in return
for net access for a day). So it is not a matter of what git wants, but
what the captive portals want.

> The main impetus from my point of view is that captive portal/proxy auth is a
> mess, because they try to trick web clients into displaying something they are
> not prepared to and don't want to do, and this spec is replacing trick with
> explicit request, which is nice.

Yeah, and I think it is an improvement over the current state. Right now
git will properly fail with a 511 (which is what the designers
intended). I'd rather hold off on something more advanced until somebody
comes forward with a concrete case and says "hey, my network gives a 511
in this instance, and here's what would be the best thing for git to
do". Preferably with patches, of course. :)

-Peff
