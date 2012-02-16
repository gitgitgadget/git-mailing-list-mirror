From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: allow overriding smtp-encryption config
 to 'none'
Date: Wed, 15 Feb 2012 19:49:03 -0500
Message-ID: <20120216004903.GA21170@sigill.intra.peff.net>
References: <1329342178-14540-1-git-send-email-computersforpeace@gmail.com>
 <20120215220629.GA17672@sigill.intra.peff.net>
 <CAN8TOE_BnkOcMQRTY-GWrHozYD0+0giWn2LtjB8AVnP_DzA+Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 01:49:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxpX6-0006fl-5I
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 01:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756657Ab2BPAtH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 19:49:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37381
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753584Ab2BPAtG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 19:49:06 -0500
Received: (qmail 24761 invoked by uid 107); 16 Feb 2012 00:56:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Feb 2012 19:56:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2012 19:49:03 -0500
Content-Disposition: inline
In-Reply-To: <CAN8TOE_BnkOcMQRTY-GWrHozYD0+0giWn2LtjB8AVnP_DzA+Sg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190869>

On Wed, Feb 15, 2012 at 03:49:59PM -0800, Brian Norris wrote:

> > Sounds reasonable.
>=20
> An error like
>   Command unknown: 'AUTH' at /usr/local/libexec/git-core/git-send-ema=
il
> is reasonable?

Sorry, no, I meant your goal of allowing overriding config sounds like =
a
reasonable thing to want. But from reading your message below, it seems
that is not actually the problem you are trying to solve.

> > Defaulting everything except "ssl" or "tls" to "none" seems risky t=
o me.
> > If I am understanding your patch correctly, then doing this:
> >
> > =C2=A0git send-email --smtp-encryption=3DSSL
> >
> > will silently treat that as "don't do encryption", which could have
> > surprising security implications for the user. I chose all-caps as =
it is
> > an obvious mistake to make. We probably should treat it the same as
> > lowercase "ssl", but the same argument applies to other typos like
> > "tsl".
>=20
> Well, git-send-email already doesn't handle typos or capitalization
> correctly, AFAICT. So nothing new here.

Hmm. From your description and the patch, I thought that was something
introduced by your patch. But looking at the existing code, it seems
like that is already the case. IOW, I don't understand why
"--smtp-encryption=3Dnone" does not already work looking at the current
code.

So being more careful about typos is an improvement we could make, but
it is not a feature that would need to be part of a bugfix patch.

> > It seems like a much safer default would be to die() on an invalid
> > encryption specifier.
>=20
> Fine. But then we need to define a behavior that means 'no
> encryption.' Like 'none' instead of just saying 'anything but tls or
> ssl.'

Right. I meant that you should introduce "none" as an explicit "no, I
don't want this" and die when the flag is not one of {ssl, tls, none}.

> Now that I look at this again, I think part of the issue I have is
> that there is no way to override *smtp-user* via command-line, in
> order to do unencrypted, unauthenticated email. So the
> *authentication* not the encryption is really my main problem...I'll
> take another look and try a new patch.

Ah, I see. I misunderstood the original problem you were trying to solv=
e
(I thought your example was "see? Encryption is off, so the server won'=
t
do AUTH, demonstrating that the patch works.").

Overriding the smtp user from the config is a separate issue, and I
don't think that is currently possible. The usual way to spell an optio=
n
like that in git is "--no-smtp-user", but it seems that we use perl's
GetOptions, which does not understand that syntax. So you'd have to add
a "--no-smtp-user" by hand.

-Peff
