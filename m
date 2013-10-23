From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/2] Update documentation for http.continue option
Date: Wed, 23 Oct 2013 03:00:48 +0000
Message-ID: <20131023030048.GX865149@vauxhall.crustytoothpaste.net>
References: <1381530945-90590-1-git-send-email-sandals@crustytoothpaste.net>
 <1381530945-90590-3-git-send-email-sandals@crustytoothpaste.net>
 <20131011235052.GV9464@google.com>
 <20131012002639.GE79408@vauxhall.crustytoothpaste.net>
 <20131018221535.GM865149@vauxhall.crustytoothpaste.net>
 <xmqqeh7csygy.fsf@gitster.dls.corp.google.com>
 <20131022233257.GA9464@google.com>
 <20131023013400.GB9464@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ON0CT8LY+wgE1XqS"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 05:01:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYogv-0005Rd-0Y
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 05:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410Ab3JWDA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 23:00:56 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33243 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753219Ab3JWDAz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Oct 2013 23:00:55 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:d72:c0a:d498:7594])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 159F92807A;
	Wed, 23 Oct 2013 03:00:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131023013400.GB9464@google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-trunk-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236497>


--ON0CT8LY+wgE1XqS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2013 at 06:34:00PM -0700, Jonathan Nieder wrote:
> Forgive my ignorance: is there a way to do something analagous to that
> patch but for GSS-Negotiate authentication?  In other words, after
> using the first request to figure out what authentication mechanism
> the server prefers, could git prefer it in remaining requests to avoid
> the need to rewind?

We know what authentication mechanisms the server offers, but we don't
know what curl will use, other than the fact that it prefers non-Basic
authentication (this is documented).  So if we see Negotiate only or
Negotiate and Basic, we know it will try to use Negotiate if possible.

So essentially the question is, do we believe that Negotiate and other
authentication are likely to be used together, and are we willing to
take the risk that a user wants to use non-Negotiate on such a server
and has a broken server or proxy?

> I don't see any simple way to do that using the libcurl API.  If
> checking if the server accepts GSS-Negotiate authentication and using
> that to decide whether to 'Expect: 100-Continue' is easier, that would
> be fine, too.

If that's what the consensus is, that's much, much easier to do.  The
only problem is that if we have Negotiate and a non-Basic method, such
as Digest, we might force Expect: 100-continue on when it does not need
to be used.  I think that in practice that's unlikely to be the case, as
most people using GSSAPI authentication probably use Kerberos as their
authentication server, and Digest hashes the password in a different way
that isn't compatible.  I'm the only person I'm aware of, other than
Stanford (and potentially MIT), that uses Kerberos auth over HTTP, and
probably fewer still use it for git push.

I think that this is probably fine to do, because probably most people
who are using Kerberos auth over HTTP are using Apache or nginx, which
support 100-continue, and many of those institutions are universities,
which don't tend to have restrictive (and broken) proxies.  It also is
fine with me because it means that things just work and I don't have to
worry about setting configuration options.

I'll plan to do a revised patch along these lines later this week unless
I hear some loud objections before then.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--ON0CT8LY+wgE1XqS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSZzvgAAoJEL9TXYEfUvaLUg4P/1EZmqMNMwfYCIgZbaQ68XWA
ihJiRj7CuUapvNNv4LxtJylRwttn9e+qOuSs9uOTmdg0GbT9beXlV7zXpWO/B29t
Ecc7MyddRjAEUEAfvYjmils+cGmG1Xj1PK75e0jOQOfstCgH2hLK6EgvsizJaMWd
1WFQHcK5ZCf7G8++V30f4vAQufAemvTO1Yw7Gfacy7zqpBD2n6kJHVsTfByTpzGE
Z+cfFusW0lH7QbgZnh6rRSNVXYhoi783bMBYx1E+myighOcDcAGttcU3VWn1R8yg
bPDfcYybKLUE7bs30wSQV0UFWyvF4SkonSS7QmYduLrGvGHHTIwl5GWPdDnRgzjI
oTr5jRQlGTCBl33lL1xdgJeXS1/RWcUix/GogwPySlRaSE6Hk61DWUKiegrIzTHB
b4Cn3OzpcAfFwZ5K8ODsTi8VRH+XbBQ+eJanO27QOEoMmNFzypUBvkk33wDjT+20
rWBmVtDCkg4i3OjWaO715IYCWiVECKeM++RScSUrSHuGXyGyEoPZciYu4i4iwxq1
CIg63r70u0eLht8z2PpTyxOICtUE3TnxsIzRRoDz4fdJP4LqjlWo94TdjNbMTDGT
Lylej3N/cNY3L+KsBFAQZFen7cZT46KrV8Aj03D16YNNHgUFY5/KAn9kzrxfNz0s
noWFO2gRT6d2jYuq4xQo
=T8ij
-----END PGP SIGNATURE-----

--ON0CT8LY+wgE1XqS--
