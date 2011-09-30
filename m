From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Add a credential-helper for KDE
Date: Fri, 30 Sep 2011 06:21:11 -0400
Message-ID: <20110930102111.GA24507@sigill.intra.peff.net>
References: <4E594B5A.6070902@gmail.com>
 <20110831014237.GA2519@sigill.intra.peff.net>
 <4E7605CA.7020204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 12:21:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9aDd-0004mU-GC
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 12:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396Ab1I3KVT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 06:21:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50207
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab1I3KVR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 06:21:17 -0400
Received: (qmail 32668 invoked by uid 107); 30 Sep 2011 10:26:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Sep 2011 06:26:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2011 06:21:11 -0400
Content-Disposition: inline
In-Reply-To: <4E7605CA.7020204@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182474>

On Sun, Sep 18, 2011 at 04:52:58PM +0200, Lukas Sandstr=C3=B6m wrote:

> This Python script plugs into the credentials API
> of Git to ask the user for passwords with a nice
> KDE password dialog.
>=20
> The password is saved in the KWallet.

So I managed to play with this a bit tonight. Overall, it seems pretty
nice.

Initially, it seemed somewhat clumsy. It asked me to open the wallet
(using a password) each time git ran. Which is about as annoying as jus=
t
typing my git password each time. :)

The magic trick was to configure kwallet to "keep the wallet open for 1=
0
minutes after the last use" instead of "close when no applications have
the wallet open". Since git runs as many small programs, kwallet has no
real idea of how long a git session is.

This is totally not a kwallet thing, and nothing to do with your helper=
=2E
But since the helper is so annoyingly useless without that config, it
might be worth mentioning it in a README.

> Right. Multiple usernames per "unique" context is supported in this v=
ersion.
> I looked at the git-credential-storage helper when I wrote the first =
patch,
> which didn't have obvious support for multiple usernames per unique c=
ontext.

This part passed my tests just fine. Very nice.

> +class CredentialHelper(KApplication):
> +    def __init__(self, token, username =3D None, desc =3D None, reje=
ct =3D False):
> +        super(CredentialHelper, self).__init__()
> +        self.password =3D None
> +        self.username =3D username
> +        self.save_password =3D False
> +        self.token =3D token
> +        self.desc =3D desc
> +
> +        if not self.token:
> +            return

My tests complained about doing nothing when there is no token. As I've
mentioned elsewhere, this doesn't matter now (as git never invokes the
helper that way), but it would be nice to future-proof the helper by
just ignoring the wallet, but still doing the nice password dialog.

> +    def open_wallet(self):
> +        self.wallet =3D KWallet.Wallet.openWallet(
> +            KWallet.Wallet.LocalWallet(), 0, KWallet.Wallet.Synchron=
ous)
> +        if not self.wallet.isOpen():
> +            return None
> +        if not self.wallet.hasFolder("GitCredentials"):
> +            self.wallet.createFolder("GitCredentials")
> +        self.wallet.setFolder("GitCredentials")

I peeked around the KWallet manager. There's a "passwords" folder in th=
e
wallet, and I was surprised that the passwords didn't go there. But whe=
n
I tried using konqueror to store a password, I found that it also made
its own folder, and then stored a map within it for each URL.

So I'm not really sure if you're following kwallet best practices or
not, as I'm clearly confused about what the "passwords" folder is for.
;)

> +    def check_wallet(self):
> +        (res, data) =3D self.wallet.readMap(self.token)

So you're just using the token as a big blob. Which is how I
anticipated, but is the complete opposite of what OS X Keychain wants.
Which is leading me to think we should really just hand helpers both
forms: the information broken down by item (e.g., --host=3Dgithub.com),
and a full URL (e.g., --url=3Dhttps://github.com/). And then the helper=
s
can use whatever they like (where you would use "url" instead of the
current "unique").

-Peff
