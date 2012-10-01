From: Jeff King <peff@peff.net>
Subject: Re: git smart-http do not authent to allow git ls-remote to be
 called anonymously
Date: Sun, 30 Sep 2012 21:09:35 -0400
Message-ID: <20121001010935.GA18987@sigill.intra.peff.net>
References: <CAHtLG6Q+XO=LhnKw4hhwtOe2ROeDN1Kg=JN5GTQqdvYjk-Sv4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 03:09:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIUW3-0001Kp-FE
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 03:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab2JABJi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Sep 2012 21:09:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36591 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413Ab2JABJh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 21:09:37 -0400
Received: (qmail 14716 invoked by uid 107); 1 Oct 2012 01:10:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 30 Sep 2012 21:10:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Sep 2012 21:09:35 -0400
Content-Disposition: inline
In-Reply-To: <CAHtLG6Q+XO=LhnKw4hhwtOe2ROeDN1Kg=JN5GTQqdvYjk-Sv4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206703>

On Sun, Sep 30, 2012 at 10:35:35PM +0800, =E4=B9=99=E9=85=B8=E9=8B=B0 w=
rote:

> I use smart-http on Apache.
> If nothing to be pushed / pulled, I do not want password to be
> supplied. And allow git ls-remote to run without password
>=20
> *.git/info/refs?service=3Dgit-upload-pack
> *.git/info/refs?service=3Dgit-receive-pack
>=20
> I only need authentication on
>=20
> *.git/git-upload-pack
> *.git/git-receive-pack
>=20
> /etc/apache/httpd.conf
>=20
> <LocationMatch "^/git/.*/git-(upload|receive)-pack$">
>     AuthType Basic
>     AuthName "staff only"
>     AuthUserFile /etc/apache/apache.pwd
>     Require valid-user
> </LocationMatch>
>=20
> However this does not work. It does not ask for password at all.

What is "it" in the final sentence? Does the server not tell the git
client that authorization is required, and actually serve the request?
If so, then that is a bug in your apache config.

Or is it that the server tells git that it needs authorization, but git
does not prompt, and instead just fails with "Authentication failed". I=
n
that case, the issue is that you need a newer git client. Traditionally
the client expected to handle authentication during the initial
"info/refs" request. I added support for handling authentication during
later requests in commit b81401c, which is in git v1.7.11.7 and
v1.7.12.1.

You should reconsider whether this is what you really want, though. Wit=
h
the configuration you showed, anyone will be able to get a list of all
refs and their sha1s. So they would know all your branch names, and the=
y
could even potentially find out what's in your branches by making
offline guesses and comparing them to your branch sha1s (the feasibilit=
y
of this would depend on exactly what you're storing).

-Peff
