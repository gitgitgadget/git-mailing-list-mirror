From: Jeff King <peff@peff.net>
Subject: Re: Handle HTTP error 511 Network Authentication Required (standard
 secure proxy authentification/captive portal detection)
Date: Mon, 20 Feb 2012 10:44:52 -0500
Message-ID: <20120220154452.GA27456@sigill.intra.peff.net>
References: <4b8f33ba4c870528a82ab85d6dad68bd.squirrel@arekh.dyndns.org>
 <20120220010617.GB4140@sigill.intra.peff.net>
 <9cd657a3c4960a8c496515a03bbf623e.squirrel@arekh.dyndns.org>
 <20120220135639.GA5131@sigill.intra.peff.net>
 <e1d3ddd965eb32717163aaa87fa71e17.squirrel@arekh.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 16:45:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzVQC-00035z-Ae
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 16:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678Ab2BTPoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 10:44:55 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43901
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263Ab2BTPoz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 10:44:55 -0500
Received: (qmail 2592 invoked by uid 107); 20 Feb 2012 15:44:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Feb 2012 10:44:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2012 10:44:52 -0500
Content-Disposition: inline
In-Reply-To: <e1d3ddd965eb32717163aaa87fa71e17.squirrel@arekh.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191079>

On Mon, Feb 20, 2012 at 04:34:19PM +0100, Nicolas Mailhot wrote:

> >> Actually, the best would be to launch something capable of interpreting html
> >> forms on the url given by the error.
> >
> > Doing that portably is near impossible (keep in mind that git runs on
> > things like antique versions of Solaris).
> 
> Can't the you let the user specify a browser command (firefox, elinks w3m) to
> auto-feed the portal page to when needed ?

Yes, that's why I said "we could add a configuration option" in the part
that you snipped. But doing it out of the box is not going to be
portable.

> The main problem with captive portals is when they shut down the connection
> and the user has no idea how to restore it (and error 511 is intended to fix
> this, but that won't do a lot of good if the user does is not shown the
> captive portal url transmitted with the error)

In my experience, the captive portal process usually goes like this:

  1. Connect to network.

  2. Try some non-browser command. Wonder why in the world it isn't
     working.

  3. Open a browser and say "Ah, I see. A captive portal".

The 511 proposal makes step 2 a lot better if the protocol is http[1].
But it pretty much makes it better even without non-browser client
support, because at least you will get a 511 error instead of having git
complain that the remote repository is corrupted (which happens if the
captive portal returns a redirect to an html page).

We should already be doing that. Adding more support could make step 3 a
little nicer, but like I said, I'd be more interested in seeing a real
case first. It may even be a feature that would be more appropriate to
curl (which git builds on for http access).

-Peff

[1] Of course it doesn't help at all for git:// or ssh:// (which are
    usually even worse off in the first place, as many captive portals
    will simply drop the packets, making it look like the remote server
    is down).
