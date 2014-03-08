From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] builtin/mv: fix out of bounds write
Date: Sat, 8 Mar 2014 19:15:42 +0000
Message-ID: <20140308191542.GB32213@vauxhall.crustytoothpaste.net>
References: <CAPn4x+oTTzYMSFzqUmJ8tOO0DdqR+HJJdoeXFZxhABu6B=QmBQ@mail.gmail.com>
 <20140308164651.GA32213@vauxhall.crustytoothpaste.net>
 <20140308181218.GG18371@serenity.lan>
 <20140308183501.GH18371@serenity.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Cc: Junio C Hamano <gitster@pobox.com>,
	Guillaume Gelin <contact@ramnes.eu>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Mar 08 20:15:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMMiu-0004AS-8p
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 20:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbaCHTPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2014 14:15:48 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:52416 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751969AbaCHTPr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2014 14:15:47 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:fdce:ca83:d79c:2d90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E3EC728088;
	Sat,  8 Mar 2014 19:15:45 +0000 (UTC)
Mail-Followup-To: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Guillaume Gelin <contact@ramnes.eu>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
Content-Disposition: inline
In-Reply-To: <20140308183501.GH18371@serenity.lan>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243680>


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 08, 2014 at 06:35:01PM +0000, John Keeping wrote:
> When commit a88c915 (mv: move submodules using a gitfile, 2013-07-30)
> added the submodule_gitfile array, it was not added to the block that
> enlarges the arrays when we are moving a directory so that we do not
> have to worry about it being a directory when we perform the actual
> move.  After this, the loop continues over the enlarged set of sources.
>=20
> Since we assume that submodule_gitfile has size argc, if any of the
> items in the source directory are submodules we are guaranteed to write
> beyond the end of submodule_gitfile.
>=20
> Fix this by realloc'ing submodule_gitfile at the same time as the other
> arrays.
>=20
> Reported-by: Guillaume Gelin <contact@ramnes.eu>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> On Sat, Mar 08, 2014 at 06:12:18PM +0000, John Keeping wrote:
> > This fixes it for me:
>=20
> Here it is as a proper patch.
>=20
>  builtin/mv.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 21c46d1..f99c91e 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -179,6 +179,9 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
>  						modes =3D xrealloc(modes,
>  								(argc + last - first)
>  								* sizeof(enum update_mode));
> +						submodule_gitfile =3D xrealloc(submodule_gitfile,
> +								(argc + last - first)
> +								* sizeof(char *));
>  					}
> =20
>  					dst =3D add_slash(dst);

Yup, that's the same conclusion I came to.  There are also two cases
where we don't shrink the array properly.  I'll rebase my patch on top
of this one and send it.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTG2xeAAoJEL9TXYEfUvaLAwoP/3ST4v9mxLgMBEEaalWPAj5z
NfRqZ+HB8IgWiMvi6MRP6g7jVf5zsQV+CUrwoPV2TyEkieHbZG68gwypSTDSOSYE
dQovB76PUPF4TFgv6JdacmHoKNO95pwhrdF2UChr6kvQ+hgmz4HWBJLxfMGZvI2V
KXgs+8QKOg4N1fOG+DRQWXQyta8InFpoPogNYerdl/ysPtTpFdqTK9fgbgql6Zp5
qrNBpjtBcs/BxpE3/Hc1HSh4wgqCO0IEj7+2rT5t16rn6BCQRYLVzOo8eStlkkQx
O3bY2fZbfKma1xcey0EwqEu3JhzJ1nyniQFPwjR0UbvLRPuMCZyE/VBlSlWn9Ebk
lGYZzyMMuwMIQu4LP/k0HMnuFcLRdf27abmAfpim5ptGAeY5RmYGsXdk8DevQoyv
QwiK65V+di3sNNHCvvsF1Xeph43peypfHMiJhWD/dDdqkhvB27dK2yQBQzLuelQ+
171aP5AEizb1WZEwclX35HIdSwnPHouko2dsp5uMFx0MuXHnOGUQ1gZ6CVe0YGKr
Mu6/wj/HrHOq39+a7R9Rl0kcfBndy283Pc1jp9FJ3Ie3nIQN7VNZjQ9SRcYktvvE
h8jJ5hnuzwGYIiwXu+qT/mfPieYT1fcQwnHC3cObzYNTTw/f1ZYrAO4r6a0juizb
GEr+I55ji8r/3UzPP+Ke
=87H+
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
