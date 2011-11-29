From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/13] introduce credentials API
Date: Tue, 29 Nov 2011 16:14:11 -0500
Message-ID: <20111129211411.GC1793@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111124110105.GA8417@sigill.intra.peff.net>
 <7v4nxnvs1w.fsf@alter.siamese.dyndns.org>
 <20111129050425.GA32022@sigill.intra.peff.net>
 <7vmxbeu91d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 22:14:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVV0M-0006nx-Dv
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 22:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756389Ab1K2VOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 16:14:14 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55848
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755822Ab1K2VON (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 16:14:13 -0500
Received: (qmail 2825 invoked by uid 107); 29 Nov 2011 21:20:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Nov 2011 16:20:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2011 16:14:11 -0500
Content-Disposition: inline
In-Reply-To: <7vmxbeu91d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186083>

On Tue, Nov 29, 2011 at 09:34:54AM -0800, Junio C Hamano wrote:

> >> > +`credential_fill`::
> >> > +
> >> > +	Attempt to fill the username and password fields of the passed
> >> > +	credential struct, first consulting storage helpers, then asking
> >> > +	the user. Guarantees that the username and password fields will
> >> > +	be filled afterwards (or die() will be called).

> Immensely, at least to me. From the perspective of a user of the API, a
> call to credential_fill() is to "fill in the credential" in the sense that
> "call the function to fill in the credential" but I find it easier to
> understand if it were explained to me as "ask the API to fill in the
> credential, which may involve helpers to interact with the user--the point
> of the API is that the caller does not care how it is done".  Same for the
> reject/accept calls---the example makes it clear that they are to tell the
> decision to reject/accept made by the application to the credential API,
> and it is up to the API layer what it does using that decision (like
> removing the cached and now stale password).

Ahh, I see your confusion now. It is not that the description is
necessarily lacking any content, but that the tense of the sentences is
misleading. I'll fix that.

> The above example is a bit too simplistic and misleading, though. You
> would call reject only on authentication failure (do not trash stored and
> good password upon network being unreachable temporarily or the server
> being overloaded).

Good point. I'll fix that and add the example to the documentation.

> > So one possible rule would be:
> >
> >   1. If it starts with "!", clip off the "!" and hand it to the shell.
> >
> >   2. Otherwise, if is_absolute_path(), hand it to the shell directly.
> >
> >   3. Otherwise, prepend "git credential-" and hand it to the shell.
> >
> > I think that is slightly less confusing than the "first word is alnum"
> > thing.
> 
> Simpler and easier to explain. Good ;-)

OK, I'll implement that, then.

> > How do you feel about the "values cannot contain a newline" requirement?
> 
> In the context of asking username, password, or passphrase, I think "LF is
> the end of the line and you cannot have that byte in your response" is
> perfectly reasonable. I've yet to find a way to use LF in a passphrase to
> unlock my Gnome keychain ;-).

The potential issue is that other values get that, too. So if you have a
URL with "\n" in the path, it cannot be transmitted verbatim. We can
url-encode, of course, but I didn't want the helpers to have to deal
with quoting issues.

> >> Two style nits.
> >
> > I'm supposed to guess? ;P
> 
> Sorry, but you guessed right.

OK, will fix.

-Peff
