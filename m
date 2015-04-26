From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/2] connect: improve check for plink to reduce false
 positives
Date: Sun, 26 Apr 2015 18:52:16 +0000
Message-ID: <20150426185216.GE322887@vauxhall.crustytoothpaste.net>
References: <20150423231403.GC274681@vauxhall.crustytoothpaste.net>
 <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
 <1429914505-325708-2-git-send-email-sandals@crustytoothpaste.net>
 <553BBACA.70704@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	jakanapes@gmail.com
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 26 20:52:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmRfH-0007VU-MR
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 20:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbbDZSwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 14:52:23 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48809 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751080AbbDZSwW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2015 14:52:22 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:9ca7:a34c:b2b:c286])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5E3442808D;
	Sun, 26 Apr 2015 18:52:20 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	jakanapes@gmail.com
Content-Disposition: inline
In-Reply-To: <553BBACA.70704@web.de>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267833>


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 06:03:22PM +0200, Torsten B=C3=B6gershausen wrote:
> (I'm not sute if the commit message describes the problem deep enough
> for readers which are not familar with all the details of the original
> report):
> A feature implemented for Windows may break things for e.g. Linux users)
> The following may read exaggerated, so please read it as a suggestion.
>=20
> The git_connect function has code to handle plink and tortoiseplink
> specially, as they require different command line arguments compared to
> OpenSSH (-P instead of -p, tortoiseplink uses -batch), commit 36ad53ffee6=
ed.
> The special handling is only needed for Windows, and a sloppy
> case-insensitve search for "plink" will trigger that an the extra
> parameter "-batch" is added to the command line.
>=20
> This was observed on a Linux system where a command line including
> "/uplink_deploy/" was used.
>=20
> There are different ways to improve the situation:
> (The following mentions only plink, but assumes that tortoiseplink is han=
dled
>  similar)
> a) Disable the plink/tortoiseplink special handling on non-Windows systems
> b) Tighten the search for plink:
>    Allow basename() =3D=3D plink || !!strcasestr(ssh, "plink.exe")
> c) Tighten the search for plink:
>    Allow basename() =3D=3D plink || !!strcasestr(ssh, "plink.exe")
> d) Tighten the check for tortoiseplink.
>    Today we set "int putty" to true when plink is found, and -batch
>    is set when tortoiseplink is not found.
>    This fixes the reported bug, but still has the -P problem.
> e) Unix users typically use shell scripts and could use GIT_SSH_COMMAND.
>    Declare the GIT_SSH as not-well-documented (and to obsolete ?) for non=
-Windows systems,
>=20
> This patch implements c):
> Extract the basename and compare it to plink, plink.exe respective
> tortoiseplink/tortoiseplink.exe
>=20
> Note that there is a slight risk of breakage for Windows users:
> Strings like "myplink" or "plink-0.83" are no longer accepted.

I can certainly expand the commit message when I reroll.

> -------------
> I would probably vote for a), as Unix/Linux/Mac OS users don't use plink/=
tortoiseplink
> at all.

I have putty on my system:

vauxhall ok % uname -a && which plink
Linux vauxhall 3.16.0-4-amd64 #1 SMP Debian 3.16.7-ckt7-1 (2015-03-01) x86_=
64 GNU/Linux
/usr/bin/plink

While it's clearly not very common to use putty on Unix systems, it
certainly is possible and it would need to work the same way.

> -------------
> What about adding test-cases in t5601,
> this will ease the documentation later.
> f:/util/plink
> /c/util/plink.exe
> f:/util/tortoiseplink
> /c/util/tortoiseplink.exe
> /usr/local/uplink/sshwrapper.sh

It looks like there's already a framework for that, so sure, I can add
some tests.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVPTPgAAoJEL9TXYEfUvaL2I4P/j+99HnHWhN61DPCW/vjcT7O
xG6Rp3UwJRPj5Q7ZXJwUcEELHuf1K0tHiT3csGdp3Qd6fMBE/CRgp6cmcudcOELM
KwwLQaObJyaFMtXvhMVljP2H8OavU6I3HLfNOx3Bmk3suO9U3M7ZlXVdg81cA3KF
P0sFfk/GpaG3sXJBXWtJgjUlkuy+NVPSEcOjj4Ly1au5XE3w5VeD9LsYA7P9XgpY
+7uNkSU8Xnqqv2eslXUO6KzIRTD9BFKdr2PPPXYzkmhzCpTRvmRQymSjt8SyR/c2
uNptbp9AYst+qchbe7t46wK3xNIOTTq8HSpPy4gC1zlQlQ1C3ijBmXh078Ixm2Ms
u+69vfeutD8vVYdGu1B/dm4f55GiockQ8IY8MwogOaMO1JmC/uDagl5lN/GGJAGi
1aKA5ZEadsUu3QPClrMWeOBpEjTHAr8eeD5mmLtVN0doDMQtw/vLLx8HPtmBgIgh
N/ASSjI7hAe1+7nRY6VHKJb1eiMkG5nUbfFH4Z0r/azdA4Ay7dhZLe1sRsM8Q7Kh
n4bgnvNOkNv3zPvqeutRYDAU1kp7Sd9NrSzQnraRXqVD/nDkstBcnLqzwpeOhklb
Wh4Dl+4h/ktcEpxIQ8EXYkJ5+may+agteK2MOQOdpXPQiq6sttGCZWNi3M3QNZB7
xTh4E0XS28muus2PDhLj
=BucJ
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--
