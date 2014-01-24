From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] repack.c: chmod +w before rename()
Date: Fri, 24 Jan 2014 21:40:23 +0000
Message-ID: <20140124214023.GB58260@vauxhall.crustytoothpaste.net>
References: <201401242205.16313.tboegi@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Cc: git@vger.kernel.org, zwanzig12@googlemail.com,
	stefanbeller@googlemail.com, kusmabite@gmail.com,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jan 24 22:40:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6oUO-0004sT-Pt
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 22:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbaAXVkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 16:40:33 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51368 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752675AbaAXVkc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jan 2014 16:40:32 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [209.118.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8216728074;
	Fri, 24 Jan 2014 21:40:28 +0000 (UTC)
Mail-Followup-To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, zwanzig12@googlemail.com,
	stefanbeller@googlemail.com, kusmabite@gmail.com,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com
Content-Disposition: inline
In-Reply-To: <201401242205.16313.tboegi@web.de>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241045>


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2014 at 10:05:14PM +0100, Torsten B=C3=B6gershausen wrote:
> commit a1bbc6c0 "repack: rewrite the shell script in C" introduced
> a possible regression, when a Git repo is located on a Windows network sh=
are.
>=20
> When git gc is called on an already packed repository, it could fail like=
 this:
> "fatal: renaming '.git/objects/pack/.tmp-xyz.pack' failed: Permission den=
ied"
>=20
> Temporary *.pack and *.idx files remain in .git/objects/pack/
>=20
> In a1bbc6c0 the rename() function replaced the "mv -f" shell command.
>=20
> Obviously the -f option can also override a read-only file but
> rename() can not on a network share.
>=20
> Make the C-code to work similar to the shell script, by making the
> files writable before calling rename().
>=20
> Another solution could be to do the "chmod +x" in mingw_rename().
> This may be done in another commit, because
> a) It improves git gc only when Git for Windows is used
>    on the client machine
> b) Windows refuses to delete a file when the file is read-only.
>    So setting a file to read-only under Windows is a way for a user
>    to protect it from being deleted.
>    Changing the behaviour of rename() globally may not be what we want.
>=20
> Reported-by: Jochen Haag <zwanzig12@googlemail.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  builtin/repack.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/builtin/repack.c b/builtin/repack.c
> index ba66c6e..033b4c2 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -324,6 +324,10 @@ int cmd_repack(int argc, const char **argv, const ch=
ar *prefix)
>  				statbuffer.st_mode &=3D ~(S_IWUSR | S_IWGRP | S_IWOTH);
>  				chmod(fname_old, statbuffer.st_mode);
>  			}
> +			if (!stat(fname, &statbuffer)) {
> +				statbuffer.st_mode |=3D (S_IWUSR | S_IWGRP | S_IWOTH);
> +				chmod(fname, statbuffer.st_mode);
> +			}

Are we sure that the file in question can never be a symlink?  Because
if it is, we'll end up changing the permissions on the wrong file.  In
general, I'm wary of changing permissions on a file to suit Windows's
rename because of the symlink issue and the security issues that can
result.  Hard links probably have the same issue.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS4t3HAAoJEL9TXYEfUvaLZ44P/3o9JJCtUyIDkCU3IVTwVjlT
1Rf7VCtLMFs54bDeV1Q3rZcbkfvoz95R7/PZUW9Q0tktjBuLJZCoYd7tWQa1WrUl
mrVxIvZhx/vqkQEaWtSglz7ygXs0DBY7HUFcChm8Ha5lZPYkczi7G6b455/A/HW8
ZO8nsqJBrdSR9gH1oI+TQrYklxEr5vw2AMoktjhqUbu6f0MtC6mBn5lg1HiEQAYT
EAI+ZwOfYWc4kh5fyvlKh0KzQZ7+pcQk27v/GAVEoiHDcm4lclxR/dNLNEm2vR6C
RNY4b4y32qey37qeGsc82SISncOc2zHthNl63IP2Y+NGZuM0JxMWfbuEZQEGuBIS
Zp199SvBQxL9tuaX9SYLRreL25zMeyTZbMr8a15HNUrPk8bzkKXE1/jbdgm5CySu
OLCLe0NLfYs4PQ3MCGZGySL/jIyhstzXJv/+f+9K+yqY6XDPubtRylGRUjlngVi8
7nFvARtL42N3F5GkJm+V3otCLMh+6o1OcFzjcOawdrfRmRt58KRgoZG87brigSUL
tqbsp90vjhsJhJuDg/CRuNhpCOnyRCw1L40TTppYlgvI8TI1O9xjHH4TwlsyrvT2
LmKgc8tC4bKGdSdHJ2PjAXfPMODSo2udztpfDQN4+sGwPQJ5VPOEovMMYzjDnBPY
rYScLJygU2dV/7eFqT5M
=ZFtR
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
