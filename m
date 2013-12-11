From: Joey Hess <joey@kitenet.net>
Subject: Re: [Question] Git recovery with HEAD commit broken
Date: Wed, 11 Dec 2013 12:14:07 -0400
Message-ID: <20131211161407.GA15939@kitenet.net>
References: <CAP9B-Q=ARp00Bj5zJ0J=3qv9R16YGu5AZgLpqoO0y+cY1at1Zw@mail.gmail.com>
 <vpqzjo7whwj.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Cc: Shilong Wang <wangshilong1991@gmail.com>, git@vger.kernel.org,
	Wang Shilong <wangsl.fnst@cn.fujitsu.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Dec 11 17:14:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqmQR-0005aU-IS
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 17:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598Ab3LKQOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 11:14:12 -0500
Received: from wren.kitenet.net ([80.68.85.49]:37427 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492Ab3LKQOK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 11:14:10 -0500
Received: by darkstar.kitenet.net (Postfix, from userid 1000)
	id A1372305EF9; Wed, 11 Dec 2013 11:14:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <vpqzjo7whwj.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239206>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Matthieu Moy wrote:
> Not as far as I know. But "git fsck" has a --lost-found option that can
> help recovering unreachable (dangling) commits.
>=20
> You may have a look at http://hackage.haskell.org/package/git-repair but
> I do not think it would solve your particular case.

Well, let's find out.. I corrupted .git/refs/heads/master to refer to a
commit that does not exist. The history has a few prior commits.

joey@darkstar:/tmp/yy>git fsck
Checking object directories: 100% (256/256), done.
error: HEAD: invalid sha1 pointer
10814e97cc8bf5f6f8ce0c0d5302f778c09cac88
error: refs/heads/master does not point to a valid object!
notice: No default references

joey@darkstar:/tmp/yy>~/src/git-repair/git-repair=20
Running git fsck ...
Initialized empty Git repository in /home/joey/tmp/tmprepo.0/.git/
1 missing objects could not be recovered!
To force a recovery to a usable state, retry with the --force parameter.
- exit 1

If there had been a remote that had the missing
10814e97cc8bf5f6f8ce0c0d5302f778c09cac88 commit, it would have cloned
it from there, and this would have succeeded. But with a fully missing
commit, --force is needed to enable more destructive repairs.

joey@darkstar:/tmp/yy>~/src/git-repair/git-repair --force
Running git fsck ...
Initialized empty Git repository in /home/joey/tmp/tmprepo.0/.git/
fatal: bad object refs/heads/master
fatal: bad object refs/heads/master
fatal: bad object refs/heads/master
Deleted these local branches, which could not be recovered due to missing o=
bjects:
	refs/heads/master
You currently have refs/heads/master checked out. You may have staged chang=
es in the index that can be committed to recover the lost state of this bra=
nch!
Successfully recovered repository!
Please carefully check that the changes mentioned above are ok..

Hmm, that could have gone better. While it successfully detected the broken
HEAD, and removed that ref, which is enough to make git fsck pass[1],
it failed to find the old ref in the reflog, despite containing code
that walks up it to find a usable commit.

joey@darkstar:/tmp/yy>git reflog
fatal: bad default revision 'HEAD'

And that's why.. git-reflog requires a valid HEAD to work. Bit of a catch-2=
2.
I could work around this by manually parsing the reflog. It would not be
the first thing git-repair has to re-implement because the git command
isn't robust enough[2].=20

I have made a TODO about this.
OTOH, if a kind git developer would like to make git-reflog work when HEAD
is missing, that seems like a generally useful improvement..

--=20
see shy jo

[1] It will make fsck pass 100% of the time -- its test suite randomly
    corrupts repositories and checks that it can force some repair good
    enough to make git fsck pass.
[2] A particularly annoying one is that git branch -d cannot be used
    to remove a branch that is directly pointing to a corrupted commit!

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUBUqiPTMkQ2SIlEuPHAQhPYxAAmpCs/uDtcaMNJbWVg+vhigrO+U7QZIQz
tVA0rnYyv2lf3/Flxl72vGkkm12omsdJRSSswBSqUy0leYQBax1vOArmAFM6T2Bq
xjpCO+hJRfX2sQEAWP2s9fQRgUgMIrSRFT5X2lnBE//f8JlIBgAIH4dYD0upy0cb
D54nsVqvzZdT7cKkD2qBylX1SVm2lNep0oXEM4BtUh3GSkeIXGCOlbLpEN0+dd1+
FZDUlh89T1ztAHnc7M5yvrEgRAEx26I9mtuJ/90gnioSxGQoR2Vi/HMlTITRUSg9
j9NriWhGV3OigQ/CaIfe5cIC7lNuLpy4pDVVGMEvvA9+jgHefdockrWJgnQWsLPF
cUUZ5t93+z08ywlA0UkyediOsA6mIjDA4g18SpsqSdqw482HvBynJoGK+Uld4d42
EuRt41QobXe1IrUsdCwzLkc0Ri9tayqyiHnBvoUPLDJe5exGs0A6Nh5c6nOZG0d9
1/fcngfLz+/aQamhea5J5UdTXhVdWaCwXWlQ11ndKi3G9VBml7OK6DlcUbtMR1nM
ZZ16+ppfINgtx3nqhmFMlOxPi1tXGMiPmT5ZuYsLObCRdZvW3qdWxTPrCP2s+LDn
VvxEZIu5wgjaC01EvwqXoYhP4v27OB5cv3pGkxrLB9qyBcKF24pMZK2QwuA8fTzU
J5sL4iFOiV8=
=deeN
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
