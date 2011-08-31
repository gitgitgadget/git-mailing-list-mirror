From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add a credential-helper for KDE
Date: Tue, 30 Aug 2011 21:42:37 -0400
Message-ID: <20110831014237.GA2519@sigill.intra.peff.net>
References: <4E594B5A.6070902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 03:44:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyZrC-0004yV-IE
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 03:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab1HaBmj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Aug 2011 21:42:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55103
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754395Ab1HaBmj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 21:42:39 -0400
Received: (qmail 31869 invoked by uid 107); 31 Aug 2011 01:43:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Aug 2011 21:43:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Aug 2011 21:42:37 -0400
Content-Disposition: inline
In-Reply-To: <4E594B5A.6070902@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180452>

On Sat, Aug 27, 2011 at 09:54:02PM +0200, Lukas Sandstr=C3=B6m wrote:

> This Python script plugs into the credentials API
> of Git to ask the user for passwords with a nice
> KDE password dialog.

Thanks for working on this.

>  .../git-kde-credentials-helper.py                  |  122 ++++++++++=
++++++++++

Can we call it git-credential-kdewallet or similar? Then users can just
do:

  git config credential.helper kdewallet

(where "kdewallet" can be whatever you think is most appropriate; the
key is naming it git-credential-*).

>  1 files changed, 122 insertions(+), 0 deletions(-)
>  create mode 100755 contrib/kde-credetials-helper/git-kde-credentials=
-helper.py

Minor typo in directory name.

> +    def check_wallet(self):
> +        (res, data) =3D self.wallet.readMap(self.token)
> +        if res !=3D 0:
> +            return None
> +        try:
> +            self.username =3D data[QString("username")]
> +            self.password =3D data[QString("password")]
> +        except KeyError:
> +            return None
> +        return self.username and self.password

If I am reading this correctly, you look up based purely on the context
token. Which means that if I do something like this:

  $ git push https://host.com/repo.git
  [enter username: user1, password: foo]
  $ git push https://user2@host.com/other-repo.git

We will invoke the helper as:

  git credential-kdewallet --unique=3Dhttps:host.com --username=3Duser2

but the helper will ignore the "user2" bit, and return "user1 / foo".

The "cache" helper I wrote handles this situation better, by indexing
both on the token and the username. I wonder if the username should
become part of the token. Or if the token should really just become a
canonicalized URL, minus the actual path. So the first one would get:

  --unique=3Dhttps://host.com

and the second would get:

  --unique=3Dhttps://user2@host.com

Then helpers wouldn't need to worry about doing anything special.

What do you think? Also, any comments in general on writing a helper?
You are the first one besides me to do so. Did you find anything in the
interface or the documentation confusing? Suggestions are very welcome,
as nothing has been released yet and we're free to tweak as much as we
want.

-Peff
