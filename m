From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: GSS-Negotiate authentication requires that all data fit into
 postbuffer
Date: Sun, 6 Oct 2013 00:42:36 +0000
Message-ID: <20131006004236.GB3460@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 06 02:42:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VScQp-0008LG-Pu
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 02:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab3JFAmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Oct 2013 20:42:44 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60925 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752494Ab3JFAmn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Oct 2013 20:42:43 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B38B12807C
	for <git@vger.kernel.org>; Sun,  6 Oct 2013 00:42:39 +0000 (UTC)
Content-Disposition: inline
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-trunk-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235734>


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

One thing I just noticed is that if git is using GSS-Negotiate
authentication, the entire POST contents have to fit into however much
memory is specified by http.postbuffer:

  vauxhall ok % git push https://bmc@git.crustytoothpaste.net/git/bmc/test.=
git development
  Counting objects: 37994, done.
  Delta compression using up to 4 threads.
  Compressing objects: 100% (10683/10683), done.
  Writing objects: 100% (37994/37994), 9.15 MiB | 4.45 MiB/s, done.
  Total 37994 (delta 26760), reused 37633 (delta 26467)
  Unable to rewind rpc post data - try increasing http.postBuffer
  Password for 'https://bmc@git.crustytoothpaste.net':=20

GSS-Negotiate authentication always requires a rewind with CURL.

The remote in question only supports Negotiate authentication, so
prompting for a password in this case isn't going to help.  I'm probably
going to look into this over the next couple of days, but two things
need to be done here: 1) do not prompt for a password if only Negotiate
authentication is requested, since it just won't work, and 2) recreate
the data as needed if we have to rewind, since otherwise pushing a fresh
copy of the Linux kernel repo simply isn't going to work as the buffer
will have to be too large.  An alternative is to send a small amount of
data, smaller than the postbuffer, in the first chunk and only fail to
rewind if the second or subsequent chunks need rewinding.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSULH8AAoJEL9TXYEfUvaL65AQAMIt49NPfOGs+QvJpyXS/ynb
DqXATjNyoJ9bK7ePw4fAT0X/sIXRaBM04R+fpkoOgXUYttSlBI1eV2QbO4TAqOpd
Clq8TNiue2L0nlLPQhhqSaglRDtnk0bY9iLPnKl63q+b1GaSMjEKuYHa8RbXH12R
pifG5JNUkKlBu/vJk6DDORChAe9OANlOI3NvnKSn2l7I1jY8WVinZ1V5MnC1vOb7
BhT28yRNusG21tBuNz/ZhK+k/cgx75p4ldFV5P4mlOweB2135IT2xqUv6+BT8M0J
gdkdV6dpW3cgcx5DzikXyHpsYjnqw68tUssObvZ2Zs5kQy3lI00tj5oiDLKAK93U
hH68cmbLcmXtCBDegOUNWO+hudsUDqxIv70NWwM058ZvxZUsRqXY/4YRePySNNKg
lDO+B7JOsrqlTh105xzSAxlnylSI/6yXS+Bxq8cYVzxGQMln/O3bzFTab6ynAGp8
isC6A3kjqBIdD0AecYrJPnX4lIDAmfF9sCXEdZ24vwdl0yoP2Qu3AmEfA0JV0il7
cR4ObEjQvIRb2+xRXPTteOVLfACXOuazm/I/mIfXf8Bsyd3L9u0ebc8EoA7V/qWA
lUCRNIolC1msk7P71xq8XMKHsQwOrW4M0PoPYJC7T77soLlRW4Bu7OChIe0Hi/vq
+wxCFDLJGlGFxv0hKCu7
=xwxe
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
