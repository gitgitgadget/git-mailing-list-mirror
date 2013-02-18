From: Jeff King <peff@peff.net>
Subject: Re: feature request
Date: Mon, 18 Feb 2013 15:45:11 -0500
Message-ID: <20130218204511.GA27308@sigill.intra.peff.net>
References: <BLU0-SMTP2753D5BFC50D7334EDDE278E1F40@phx.gbl>
 <CABVa4NgsbeNGS2F2jQJ5d9bDcFb4=oEVrBg_-n2eYjwnfQzMqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jay Townsend <townsend891@hotmail.com>, git@vger.kernel.org
To: James Nylen <jnylen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:45:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Xat-0007fR-Ek
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 21:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755686Ab3BRUpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 15:45:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52242 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753494Ab3BRUpO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 15:45:14 -0500
Received: (qmail 24283 invoked by uid 107); 18 Feb 2013 20:46:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 15:46:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 15:45:11 -0500
Content-Disposition: inline
In-Reply-To: <CABVa4NgsbeNGS2F2jQJ5d9bDcFb4=oEVrBg_-n2eYjwnfQzMqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216516>

On Mon, Feb 18, 2013 at 02:54:30PM -0500, James Nylen wrote:

> > Just would like to request a security feature to help secure peoples github
> > accounts more by supporting 2 factor authentication like the yubikey more
> > information can be found from this link www.yubico.com/develop/ and googles
> > 2 factor authentication. Hope it gets implemented as I think it would make a
> > great feature
> 
> This would most likely be something that users would set up with their
> SSH client, and GitHub would have to provide support for it on their
> servers as well.  It shouldn't require any changes to git.  Here is an
> example of how this could be done:
> 
> http://www.howtogeek.com/121650/how-to-secure-ssh-with-google-authenticators-two-factor-authentication/
> 
> I like the idea, and I would probably use it if it were available.
> Jeff, what do you think?

When you are talking about something like GitHub, there are a lot of
times and methods to authenticate: logging into the web service, using
an ssh key for git-over-ssh, using a password for git-over-http, tokens
for API access, and probably more that I can't think of right now.

Logging into the web page can add 2-factor auth pretty easily, since
it's a web form.

Git over ssh can also do so without changes to git, because we rely on
ssh to do all of the interactive authentication.  However, I wonder how
many people would be that interested in it, as key auth already provides
some degree of two factor protection, assuming you protect your key with
a passphrase (the threat model is different, of course, because the two
factors are happening on the client, and do not involve the server at
all).

Git over http _would_ need git client support, since it asks the user
for the password directly. Or at the very least some clever encoding
scheme where your password becomes "<real_password>:<2FA_pass>" or
something. But I'm not sure that people want raw two-factor
authentication for pushes. It's a giant pain, and people were recently
happy to move to password-less pushes via credential helpers; this would
move in the opposite direction.

The thing that makes 2FA usable in the web browser setting is that you
authenticate only occasionally, and get a token (i.e., a cookie) from
the server that lets you have a longer session without re-authenticating.
I suspect a usable 2FA scheme for http pushes would involve a special
credential helper that did the 2FA auth to receive a cookie on the first
use, cached the cookie, and then provided it for subsequent auth
requests. That would not necessarily involve changing git, but it would
mean writing the appropriate helper (and the server side to match). I
seem to recall Shawn mentioning that Google does something like this
internally, but I don't know the details[1].

So yes. It's an interesting direction to go, but I think there's a fair
bit of work, and it needs to be broken down into how specific services
will interact with it. The first step would probably be securing the web
login with it, since that is the easiest one to do, and also the most
powerful interface (the other ones just let you push or fetch code; the
web interface lets you delete repos, change passwords, access billing,
etc).

But that first step is something that would happen entirely at GitHub,
with no client support necessary. We don't have schedules or plans, and
we don't promise features. So I can neither confirm nor deny that people
are working on it right now.

-Peff

[1] I don't know if Google's system is based on the Google Authenticator
    system. But it would be great if there could be an open,
    standards-based system for doing 2FA+cookie authentication like
    this. I'd hate to have "the GitHub credential helper" and "the
    Google credential helper". I'm not well-versed enough in the area to
    know what's feasible and what the standards are.
