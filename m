From: martin f krafft <madduck@madduck.net>
Subject: URL substitution and config file precedence
Date: Mon, 2 Aug 2010 17:37:20 +0200
Message-ID: <20100802153720.GA28481@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 02 17:47:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfxEa-00071k-U9
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 17:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349Ab0HBPrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 11:47:19 -0400
Received: from clegg.madduck.net ([193.242.105.96]:51399 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab0HBPrS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 11:47:18 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2010 11:47:18 EDT
Received: from fishbowl.rw.madduck.net (lapse.rw.madduck.net [IPv6:2001:1620:f03::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id E904B1D409A
	for <git@vger.kernel.org>; Mon,  2 Aug 2010 17:37:20 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id 43F9C20066; Mon,  2 Aug 2010 17:37:20 +0200 (CEST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.35-rc6-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96.1 at clegg
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152416>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear Gits,

I expect .git/config to tae precedence over ~/.gitconfig, which in
turn gets favoured over /etc/gitconfig. This works fine, except for
the url.=E2=80=A6.insteadOf settings.

Have a look at the following:

  % grep madduck: .git/config
    url =3D madduck:pub/puppet/modules/git

  % grep -B1 nsteadOf /etc/gitconfig ~/.gitconfig
  /etc/gitconfig-[url "git://git.madduck.net/madduck/"]
  /etc/gitconfig: insteadOf =3D madduck:
  --
  /home/madduck/.gitconfig-[url "ssh://git.madduck.net/madduck/"]
  /home/madduck/.gitconfig:       insteadOf =3D madduck:
  /home/madduck/.gitconfig:       pushInsteadOf =3D git://git.madduck.net/m=
adduck/

  % git push -v
  Pushing to git://git.madduck.net/madduck/pub/puppet/modules/git
  fatal: The remote end hung up unexpectedly

There seem to be two problems:

  1. the value from /etc/gitconfig seems to be preferred over the
     one from ~/.gitconfig. I think this is due to the fact that the
     syntax for URL substitution is a bit whack and the two keys
     different, so the merge is actually a union-merge, and then the
     result is probably just the first match (git:// sorts before
     ssh://).

  2. URL substitution is not recursive, or else the git:// URL would
     eventually be replaced with the ssh:// URL.

I can address both issues by adding a "pushInsteadOf =3D madduck:" to
~/.gitconfig, but =E2=80=A6

=E2=80=A6 that only addresses pushing. I don't see a way to fix fetching,
where the pushInsteadOf trick does not work.

Any ideas how to work around it?

Why was the syntax chosen backwards in this way? Why not have

  [urlsubst "madduck:"]
      replaceWith =3D ssh://git.madduck.net/madduck/

or even better:

  [url_regsubst]
      somefreelychosenname =3D s|madduck:|ssh://git.madduck.net/madduck/|

Thoughts?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"stab it and steer"
                                                             -- sailor
=20
spamtraps: madduck.bogus@madduck.net

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEAREDAAYFAkxW5iwACgkQIgvIgzMMSnXPdgCgti1IdBDhBbDIwY2tRh8YH1yR
PmcAnjH7myUnNttb2Yfdmwf0TtaLGy+k
=SG3o
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
