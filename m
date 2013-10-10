From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] http: add option to enable 100 Continue responses
Date: Thu, 10 Oct 2013 01:35:47 +0000
Message-ID: <20131010013547.GA62549@vauxhall.crustytoothpaste.net>
References: <1381265287-39331-1-git-send-email-sandals@crustytoothpaste.net>
 <1381265287-39331-2-git-send-email-sandals@crustytoothpaste.net>
 <20131009193054.GA3767@sigill.intra.peff.net>
 <CAJo=hJvyorMjFYZnVwz4iZr88ewor6LuqOE-mpt4LsPyoddBqg@mail.gmail.com>
 <20131009213742.GA8362@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 10 03:36:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VU5AW-0006Yg-5U
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 03:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352Ab3JJBf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 21:35:56 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:32782 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752050Ab3JJBfz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Oct 2013 21:35:55 -0400
Received: from vauxhall.crustytoothpaste.net (ng1.cptxoffice.net [208.74.121.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5260560001;
	Thu, 10 Oct 2013 01:35:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131009213742.GA8362@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-trunk-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235848>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2013 at 05:37:42PM -0400, Jeff King wrote:
> On Wed, Oct 09, 2013 at 02:19:36PM -0700, Shawn O. Pearce wrote:
> > 206b099 was written because the Google web servers for
> > android.googlesource.com and code.google.com do not support
> > 100-continue semantics. This caused the client to stall a full 1
> > second before each POST exchange. If ancestor negotiation required
> > O(128) have lines to be advertised I think this was 2 or 4 POSTs,
> > resulting in 2-4 second stalls above the other latency of the network
> > and the server.
>=20
> Yuck.

Shame on Google.  Of all people, they should be able to implement HTTP
1.1 properly.

> Part of the problem is that curl is the one handling the negotiation.
> When we get a 401, I think we can ask curl_easy_getinfo to tell us which
> auth methods are available (via CURLINFO_HTTPAUTH_AVAIL). But I don't
> know how we decide that GSS is what's going to be used. I guess if it is
> the only option, and there is no basic-auth offered?
>=20
> And then in that case turn on "Expect" (or more accurately, stop
> disabling it).
>=20
> I don't have a GSS-enabled server to test on. Brian, can you try the
> patch at the end of this message on your non-working server and see what
> it outputs?

It doesn't trigger.  My server only requires authentication for the
actual push operation, and it looks like your code doesn't trigger in
that case.

> > >> +     headers =3D curl_slist_append(headers, http_use_100_continue ?
> > >> +             "Expect: 100-continue" : "Expect:");
> > >
> > > Is there any point in sending the Expect: header in cases where curl
> > > would not send it, though? It seems like we should assume curl does t=
he
> > > right thing most of the time, and have our option only be to override
> > > curl in the negative direction.

I think curl expects that data in the POSTFIELDS option in order to
trigger.  I wasn't able to get it to trigger on its own.

> > Adding a header of "Expect:" causes curl to disable the header and
> > never use it. Always supplying the header with no value prevents
> > libcurl from using 100-continue on its own, which is what I fixed in
> > 959dfcf.
>=20
> Right. What I meant is that we do not want to unconditionally send the
> "Expect: 100-continue" in the other case. IOW, we would just want:
>=20
>   if (!http_use_100_continue)
>           headers =3D curl_slist_append(headers, "Expect:");

I tried that.  It doesn't work, since it never sends the Expect:
100-continue.  I made libcurl dump all the headers it sends, and it
doesn't send them in that case.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSVgRzAAoJEL9TXYEfUvaLTV4QAJB5JrLsrC6k9tbaqzNM0ijL
dfI1fzFcCPgN1rvwl6DA5YjpNhalOsUwgDYEFf+0SQd0i9h6GNP/visUwcpS/vyi
bxo7xxwAdJ0xeAPj6cpfGs47BGOcPnoYZ/17ISmokLz3zyv6WCkx66rf14yv0Xs3
X1zlhe6Abnapr92tbGoPHaK+g5ZMPZpGDCUBN/AwpD7/EjftWa68IUBh1rNiDFhZ
GITof9AYrm1f4sKIShTgMktRRvDPK5Dr4kesPxeCetaGPh86V413keQTVk2LlLzg
0p3KLSm+sJRrdJla8l0SgmdirPJNPrp8FCkM0YGU0ykbWf1Ex1fp8847TEZaL6pz
PZ6IgB0I1p/cu8qs+fsKQQ7YeSb0S4WBIgsuqYZATMWRMbtSzMbcfd+FIaLd1qGn
AdUKhmFdhXYkkHF6PjK652wyayfVXcyLVn7S26wNRiIMZufhqE8MGKco4gafLzq5
GW43QPy5Bd17TvnxNNfP8pz9/STaKjyASphQdhUvlqibhXUOuRk1hKVfikdSE5nP
kagkC9S5SLKfVnpgsXzzdUdUsSlHH9S7A0xDNySa9O0RYiS/4d+iCYSeNLMubVJj
6nlPQETuMc6/IcUe0Go3JcO7TaCmj4RL+nY4cMbH/SEm7RcAFSaRtJsMZiduMTep
MkNtOR3g6pfD9I2k2Q9W
=7qKk
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
