From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: problem with modification time of packfiles
Date: Mon, 19 Oct 2015 02:57:28 +0000
Message-ID: <20151019025727.GA23404@vauxhall.crustytoothpaste.net>
References: <87io63503w.fsf@msstf091.ucc.ie>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Cc: git@vger.kernel.org
To: Andreas Amann <a.amann@ucc.ie>
X-From: git-owner@vger.kernel.org Mon Oct 19 04:57:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo0dm-0004WN-ES
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 04:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbbJSC5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 22:57:33 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:38815 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752528AbbJSC5c (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Oct 2015 22:57:32 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A2EA028094;
	Mon, 19 Oct 2015 02:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1445223451;
	bh=jV5VxhDEFizSrTslOXca2aCzu62SrSlnsESwoesT3Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=moqFH5kHgcL8IpqW73oU6PT7P4fJqD1hyXl/CHqQYZVGHd1dw68iyS7m34BGPGtuE
	 U9fB4ITFn/XMeJLxEReTLq2C/jxBvIS430udLyNuzDrm0FwNEOKfgCtnMq20a+iwkv
	 SLLgq4nKKb6lZK7v2s9px6hGq4h0VwfGQXSSCay/n5W+PU+lCFVBJPTeRg5MpYCczK
	 MRuzkLnU9VgPwky8rxNFZzVp6gTasZFspQnBn5v10mDX00H6UDuZYVbTaZB6TthvEz
	 IKlcS8OWyIzLSG/RI8kVl921zj4Qv/LHx7/3DYQ6tCCUItJnIo4ovmmgpJfPSWgbMe
	 jspLuDrEUK1GikWSxApIqpQ1ZBrE3+hqw6OqxonE0djFs3fHNmfj4YnRXOcAV8LJpZ
	 mUSUml/0hzN5J8CCLiCIzJ2bYg7yz+Kc78O5BTuf9aE0tDF3V3yoqU4c1Uh1R5ja8/
	 fpt+Pv8v7iRJZIFtx8C6fSjFG3FErdo7WGaZd2ObSQ/Zh6EyvJm
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Andreas Amann <a.amann@ucc.ie>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <87io63503w.fsf@msstf091.ucc.ie>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.2.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279825>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2015 at 10:37:55PM +0100, Andreas Amann wrote:
> git (2.6.1) sometimes updates the modification time of a packfile, even i=
f it
> has not changed at all.
>=20
> On my system this triggers quite expensive an d unnecessary backup
> operations, which I would prefer to avoid.  Is there a simple way to
> keep the mtime of packfiles fixed, once they are created?
>=20
> Apparently the undesired mtime update is done in
> sha1_file.c:freshen_file() which is called (indirectly) by
> write_sha1_file().  However I did not understand, why this is done.
>=20
> Any clarification and pointers, how mtime can be kept constant would be
> appreciated.

This is required to avoid deleting items that might still be needed.
The commit message for the commit that introduced that function is as
follows:

  write_sha1_file: freshen existing objects
 =20
  When we try to write a loose object file, we first check
  whether that object already exists. If so, we skip the
  write as an optimization. However, this can interfere with
  prune's strategy of using mtimes to mark files in progress.
 =20
  For example, if a branch contains a particular tree object
  and is deleted, that tree object may become unreachable, and
  have an old mtime. If a new operation then tries to write
  the same tree, this ends up as a noop; we notice we
  already have the object and do nothing. A prune running
  simultaneously with this operation will see the object as
  old, and may delete it.
 =20
  We can solve this by "freshening" objects that we avoid
  writing by updating their mtime. The algorithm for doing so
  is essentially the same as that of has_sha1_file. Therefore
  we provide a new (static) interface "check_and_freshen",
  which finds and optionally freshens the object. It's trivial
  to implement freshening and simple checking by tweaking a
  single parameter.
 =20
  Signed-off-by: Jeff King <peff@peff.net>
  Signed-off-by: Junio C Hamano <gitster@pobox.com>

Perhaps implementing a backup strategy based on content instead of mtime
would be more successful.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.9 (GNU/Linux)

iQIcBAEBCgAGBQJWJFwXAAoJEL9TXYEfUvaLl6AP+wXsDgGdzEPYq6gm/qZSSBX0
DiESXCnwsxNFSfg4T7w9Z9d8Pb3E7z8ntTFwKrAvZMkaWU63+GMRb8KSlScS9cD8
oGmsjQUO3g7yK0T7S1lRP4HtAKO7x9f200NKiyx6ZRWuVev8G2ZRHRM9SoENiEsA
mu3C4U6JUq1BbUGhm3A6wvnWAX89QqjxJcqs6HJfO91YgvCtlXEw+JbrKMnKOZJi
c3rolkKM9PRSPtBY+4gkVaE4g/VBXohI6ceEJhaxRbqhpdt7HCiscmfsMd5FkJg7
Cg5PuanHOEV8X3dXVd1nwyrJpKgN9JbxIzbTAfX1AOTv3EMiBMCmHJ4Nym3wtmy+
/JB5FqtK+4UZbpGq04Z5NHjpGzsIwpPKU5wxeExqfTy1xlCHIbkY1DryxvQmllTy
1rQiEsd7feoTWnifU9ogePNP1wHxD/VFsGd8dlPxWm6EOYwwws6POIQ4wUvHXgbY
Ts7Vp3rynkKkxkUyh3l1wJiIasums/grceYpMVFwA1AR+tlcx6bE2xVxfBJ3tleH
03AUWxfydca+5O8TTJSMW3QSAOnC256EYL9LhrtwmOaHmAVl7s9J3cdRYqo0Gxew
t2zlf3Oq/IjvYe587znfoJJwkY2Ru8XygMjsxKzJxHx8Alu25Cq1aUFF2/xvCG8V
CQBz9WifejpHRzRL3lb8
=Mh2J
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
