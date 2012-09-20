From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] remote-curl: let users turn off smart http
Date: Thu, 20 Sep 2012 16:51:07 -0400
Message-ID: <20120920205107.GB22284@sigill.intra.peff.net>
References: <20120920165938.GB18655@sigill.intra.peff.net>
 <20120920170517.GB18981@sigill.intra.peff.net>
 <7va9wkbmyc.fsf@alter.siamese.dyndns.org>
 <20120920181231.GA19204@sigill.intra.peff.net>
 <7vzk4ka6dp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 22:51:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEniS-000777-N9
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 22:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab2ITUvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 16:51:11 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51881 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516Ab2ITUvK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 16:51:10 -0400
Received: (qmail 23072 invoked by uid 107); 20 Sep 2012 20:51:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Sep 2012 16:51:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Sep 2012 16:51:07 -0400
Content-Disposition: inline
In-Reply-To: <7vzk4ka6dp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206090>

On Thu, Sep 20, 2012 at 11:36:34AM -0700, Junio C Hamano wrote:

> >> What would the user experience be when we introduce "even smarter"
> >> http server protocol extension?  Will we add remote.foo.starterhttp?
> >
> > I would hope that it would actually be negotiated reliably at the
> > protocol level so we do not have to deal with this mess again.
> 
> The original dumb vs smart was supposed to be "negotiated reliably
> at the protocol level", no?  Yet we need this band-aid, so...

I started to write much more in my original response, but deleted it as
being too wordy. I guess I will have to rewrite it now. :)

The difference is that jumping from dumb to smart had to give context
clues at the HTTP layer. That is, by sending a query string, the client
sends a single bit that tells the server "I understand smart http", and
the server responds with output that indicates it also understands. We
had to embed this in the HTTP layer, because the previous iteration
wasn't running any custom git code at all.

Whereas if we were to enhance the protocol again, it would probably
_still_ begin with the same type of initial query, but we would
negotiate more at the git-protocol level. And there we are in charge of
how the implementation responds and handles backwards compatibility.

This has already happened to some degree. We have added new capabilities
at the git-protocol level, and it worked without these problems. It's
not a "new protocol", but it is a backwards-compatible enhancement. And
it's the likely mode for new enhancements in the future.

It's possible we could have something drastically different in the
future that does not even start with the same initial git conversation.
But even then, I think we'd do it with a new "git-upload-pack2" service
tag, or git:// and ssh access would be left behind.

> >> Perhaps
> >> 
> >>     remote.$name.httpvariants = [smart] [dumb]
> >> 
> >> to allow users to say "smart only", "dumb only", or "smart and/or
> >> dumb" might be more code but less burden on the users.
> >
> > I don't mind that format if we are going that direction, but is there
> > anybody who actually wants to say "smart only?"
> 
> With 703e6e7 reverted, we take a failure from the initial smart
> request to mean the server is simply not serving, so "smart only" to
> fail quickly without trying dumb fallback is not needed.  "smart
> only" to say "I wouldn't want to talk to dumb-only server---I do not
> have infinite amount of time, and I'd rather try another server" is
> still a possibility, but likely not worth supporting.

Yes. I do still need to resurrect my fetch-a-bundle-by-http code, which
could also be covered by such a switch. But I guess I am just not sure
if there is any point in spending effort to implement toggles that
nobody has actually asked for.

I'm also a little iffy on it because we would be inventing new config
syntax.  I don't think we want to split the list across multiple config
items (which makes our usual later-config-overwrites-earlier rules
behave badly). So what is the value format? Is it a whitespace-delimited
case-insensitive list completely specifying the transports allowed? What
happens if a new value is added. Do people who have said "smart" not get
the new value, even though all they really wanted to say was "not dumb"?
What about people who write "bundle smart" because their new
version of git understands it, but then have old versions of git barf on
it?

Most of our current config is very toggle-oriented, and I'm not sure
there is precedent for an option exactly like this. We can try to come
up with answers to those questions, but I don't think doing it is as
simple as just changing a few lines of code to support !dumb and !smart
modes.

I'm half-tempted to just drop the config entirely, leave
GIT_SMART_HTTP=false as an escape hatch, and see if anybody even cares.
At least then we're not promising support for a config option that we
may want to change later.

What do you want to do?

-Peff
