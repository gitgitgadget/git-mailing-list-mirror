From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] fast-import: use hashcmp() for SHA1 hash comparison
Date: Sat, 19 Jul 2014 16:43:25 +0000
Message-ID: <20140719164324.GA5616@vauxhall.crustytoothpaste.net>
References: <53C944B3.5080106@web.de>
 <20140718184246.GS12427@google.com>
 <53C971FD.6040500@web.de>
 <20140718235706.GA11192@peff.net>
 <53CA6072.8000009@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Jul 19 18:43:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8XjS-0004dT-4n
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 18:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbaGSQna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 12:43:30 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48966 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932080AbaGSQn3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jul 2014 12:43:29 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:c1ea:6730:f7e1:6379])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B74562808E;
	Sat, 19 Jul 2014 16:43:28 +0000 (UTC)
Mail-Followup-To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <53CA6072.8000009@web.de>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253897>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2014 at 02:11:30PM +0200, Ren=C3=A9 Scharfe wrote:
> I'd say if a platform doesn't bother optimizing memcmp() then they
> deserve the resulting performance.  And it's probably not too bad a
> penalty because such comparisons probably won't make up a significant
> part of most applications.

I tend to agree with this.  On many modern versions of GCC, the compiler
can generate an appropriately optimized inline version when it sees a
memcmp call, so it's more of a compiler issue then, since no actual call
to the function will be emitted.

>  static inline int hashcmp(const unsigned char *sha1, const unsigned char=
 *sha2)
>  {
> +	const uint32_t *p1 =3D (const uint32_t *)sha1;
> +	const uint32_t *p2 =3D (const uint32_t *)sha2;

You can't make this cast.  The guaranteed alignment for sha1 and sha2 is
1, and for p1 and p2, it's 4.  If sha1 and sha2 are not suitably
aligned, this will get a SIGBUS on sparc and possibly a wrong value on
ARM[0].

[0] http://www.aleph1.co.uk/chapter-10-arm-structured-alignment-faq

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTyqAsAAoJEL9TXYEfUvaLrdwQAM+CYqEauLk8BZv2FeumGh6i
VbQp6/Ljtn7IewL56d76ytSvPJi3s1ou84e8y01crS6mHn5TEcuMFbpypBg0D7to
ADWSR4r3AjdiVlRTNp9f1xKneloz/Pn5KU0grUgg1MZ3WJUz3IXPnMJzll25Zhzv
5wC2wd7lMtgzmUdi1o9gWd9PDGC82JxDstyk5zCgz7jYdag/khiXSxoNyWdpSeli
/6JbHtiwL0sFeYF83+YUtAAVjIoVmHSR8BV2ZIUauVUuQATqncujTUgtEPEl2QNQ
7KzTOY6IsHkXjN8bHHksismKG+RP5UZ+S/dYPzJ/UezhNDpTICfgOQrS6pa1A+wP
W+79/k67ud4WGfX2LQ2Y9++Krz976UO+yyvz2sEhXI8Pw8PzfiCgMGX8QwS4zntV
iETjEiWiiilkFQTDeGa58fx73EedGRCRd/I/obp3wbhaMM16q3i8X3Tox751sZCe
9sLTzY2UHboL6C6ZR7hwi5yULbpLM45MMtD1XA17yjZg+MNpSFjE0aSIFXhcfiN5
nrQ/E0z6w/5jOfVyXqI2XlOYUlLGjxK6/Q5czHX2FOq2rVQaJNrJkw5ByHaXkoXS
PrfBev9Nh8VDSkqtL3ts25174VZF0RUn9ywILimABaj4gMMamuY3nPlkIOKzIdfk
cmzFH+UeA/OApCY5Pib5
=f72Q
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
