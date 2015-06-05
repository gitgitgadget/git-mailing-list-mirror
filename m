From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Pack files, standards compliance, and efficiency
Date: Fri, 5 Jun 2015 19:59:58 +0000
Message-ID: <20150605195958.GC356121@vauxhall.crustytoothpaste.net>
References: <20150605014120.GE305479@vauxhall.crustytoothpaste.net>
 <20150605094545.GB11855@peff.net>
 <CACsJy8CnWo=s1onqY33K+DwFmB1baQ-uwu9Fbwm+UB30kDTwQw@mail.gmail.com>
 <20150605103639.GB19033@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:00:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0xmj-0001qC-3d
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 22:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbbFEUAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 16:00:04 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34151 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751603AbbFEUAD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2015 16:00:03 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:a919:bb7f:1b0f:9a5b])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8BBD62808F;
	Fri,  5 Jun 2015 20:00:01 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Disposition: inline
In-Reply-To: <20150605103639.GB19033@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270885>


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2015 at 06:36:39AM -0400, Jeff King wrote:
> On Fri, Jun 05, 2015 at 05:14:25PM +0700, Duy Nguyen wrote:
>=20
> > I'm more concerned about breaking object_id abstraction than C
> > standard. Let's think a bit about future. I suppose we need to support
> > both sha-1 and sha-512, at least at the source code level.
>=20
> I think that's going to be a much bigger issue, because we are casting
> out of a defined, on-disk data structure here. So I'd rather defer any
> code changes around this until we see what the new data structure (and
> the new code) look like.

My plan is to change the data as little as possible.  I want to set
core.repositoryformatversion to 1 and create core.hashalgorithm =3D
sha-256 or sha-512 or whatever.  If core.repositoryformatversion is 0,
then core.hashalgorithm is assumed to be sha-1.

Packs will get a version number bump to 5 and acquire a 32-byte
NUL-padded algorithm descriptor after the version field.  The network
protocol will acquire a capability hash=3Dsha-256.  git init will get a
--hash option, without which it will initialize SHA-1.

I don't intend to change the contents of struct object_id any, since I
don't intend to allow mixed hashes in one repository (git fast-import is
your friend).  I plan to read the format version and hash algorithm as
soon as possible after startup and initialize a variable with the hash
length.  The length of the struct's hash member will expand to handle
whatever the maximum supported hash size is, but data will only be
compared and modified up to the hash length of the appropriate
algorithm.

This does lead to the possibility of increased memory usage, which is
why I plan to initially only support SHA-512/256.  It's 32 bytes, like
SHA-256, but it performs much better on 64-bit systems (SHA-1: 291
MiB/s, SHA-256: 144 MiB/s, SHA-512/256: 242 MiB/s) for messages =E2=89=A5 55
bytes, and most systems these days are 64 bit.

That's what I've been thinking, at least, but if people have better
ideas, I'm open to hearing them.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.4 (GNU/Linux)

iQIcBAEBCgAGBQJVcf+9AAoJEL9TXYEfUvaL3uYQAI9h7OaMf4RG2xP6tLr53c0O
XLma0fm5xeyvyH7uSrlIGzftMMZwRzvow2K8TGxemOIw6n6/y1gChM2GEGRJ2ZLs
n4ctdWQHxIn1B1v8ASZTdWmRc6ne+wc5fZKxMthT7L5uuNbC9xLO9VdJs0Egvu9C
rxiFGH3O/zRtZ/edneIuT/OI23q+rPdfO6RuRX9PJISCJIeWxEnuHyIcrGA12zGY
emK/BH2DntX9COmhNdjWSw2GMtlQWCl//w+4oFR08CSzv0p2HM8r5KnoRtmD54jo
WkgOKB00DqLTDurlX328dG84wDr9fbXJRXe141t9ELsjVj6FVARSkAA3/bUqqi4v
oPPqUtRP/fbzyim6B8IWcFYRId3pT+Xpvejseo8wUAoG2neGRopyWNIE6YQlATIy
yd6LWe+0CcL02YxuZdjrVVRH3/sgStWHKkaAp0VBDYIZ+7RvH1uLsN+7qYGYajmA
IFPhNStJl2kGmK7ikYGxLon4WcpGx2mVz4hLKQrJhQIq8UZzTZv/3I/5a+A7d3VB
Y9F2xeDUimToN38oxa7lkGqlnHdtHdMHJ13kysIiO3kmyX153i+9Mvh5RolgZ6It
X+cbbk2Vy3whbvHDN5FRSHKcpVR/ZjyNK4OxMVbkRRM6Dmm0cNIIZwW69POrBLNL
jnrxrOl944QfctHX6p9n
=yyPV
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
