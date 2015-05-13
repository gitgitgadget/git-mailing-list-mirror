From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/8] asciidoc fixups
Date: Wed, 13 May 2015 22:41:31 +0000
Message-ID: <20150513224131.GC425227@vauxhall.crustytoothpaste.net>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net>
 <20150513045650.GA6070@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Cc: Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 14 00:41:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsfLT-00065O-Bi
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 00:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965445AbbEMWli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 18:41:38 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:38323 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965319AbbEMWlh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2015 18:41:37 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:307e:6849:ffff:3e6f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4E3782808F;
	Wed, 13 May 2015 22:41:35 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20150513045650.GA6070@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269013>


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 12:56:51AM -0400, Jeff King wrote:
> On Tue, May 12, 2015 at 10:15:56PM -0400, Jeff King wrote:
>=20
> > You can build with asciidoctor on the command-line. I don't know if it
> > would be feasible to diff the asciidoc and asciidoctor output to look
> > for gratuitous differences (or if the output is so different due to
> > trivial stuff that the diff is unreadable).
>=20
> So...it kind of works. I had to do unspeakable things with sed, and even
> then ended up with an 18,000-line "--color-words" diff.
>=20
> Below are some fixes. The early ones are actual bugs in our sources. The
> latter ones are changes we could do to make asciidoctor happier. Each
> patch is independent, so we can take or leave whatever we want.

I've been in contact with Dan Allen, the lead on the Asciidoctor
project.  There are a few things that he pointed out.

> After this series, the remaining problems are:
>=20
>   - asciidoctor does not render {litdd}, which is our invention; locally
>     this may be because I did not have the right incantation, but it is
>     also broken on git-scm.com. I think the right fix is to define that
>     attribute for the site renderer (so not a bug in our sources, and
>     not an asciidoctor bug)

I passed this as a command-line argument when using asciidoctor to
generate the docs: -a litdd=3D--.  For the site, I would recommend just
defining it there, as you suggested.

>   - in the '[verse]' section of the SYNOPSIS of each man page, AsciiDoc
>     renders 'git add' in the usual way (with emphasis). Whereas
>     AsciiDoctor renders it normally, with the literal quotes included.
>=20
>     In the same [verse] section, AsciiDoctor does not convert literal
>     "..." into a fancy ellipsis. So perhaps it treats [verse] as a
>     section in which markup is not expanded? This may be related to the
>     [verseblock] stuff we have in our config file.

What you want here is [verse,subs=3Dnormal].  As of Asciidoctor 1.5.0,
this allows substitutions and markup within verse blocks.  I believe old
versions of AsciiDoc did not render substitutions and markup in verse
blocks, despite claiming to, and Asciidoctor picked up that behavior.

The set of patches I put in for Asciidoctor require at least 1.5.1
anyway in order to build man pages properly.

>   - We use "{attr? foo}" to display "foo" only when "attr" is set.
>     AsciiDoctor does not seem to understand this and renders the whole
>     string.

Yes, currently Asciidoctor doesn't support this.  Outside of
asciidoc.conf, which Asciidoctor doesn't read, it looks like there's
exactly two uses in diff-options.txt.  We could probably rewrite those
using an attribute.

>   - Lots of places where we backslash-escape some syntax for AsciiDoc
>     ends up rendered by AsciiDoctor with the backslashes included. In
>     some cases the quoting is unnecessary and we can drop it (see
>     patches 6 and 7 below). But in others it really is necessary, and
>     AsciiDoc generates bad output without the backslashes. The major
>     ones are "--" surrounded by spaces (which becomes an emdash), and
>     things like @\{HEAD}, which needs quoted to tell AsciiDoc that HEAD
>     isn't an attribute.
>=20
>     I'm not sure of the solution (is AsciiDoctor just broken, or
>     is there some other syntax we could use that would work in both
>     places, or what?).

This is an under-defined area.  AsciiDoc and Asciidoctor both use
regexes instead of real parsers, and apparently there's some
disagreement on how these should be interpreted.  (The real solution is
to use a grammar and parser.) I think in some cases it might be
sufficient to use backticks, as those prevent further interpretation.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVU9MbAAoJEL9TXYEfUvaLVqIP/i+s2eZOqQZEBHABD6Vcyor0
8jxSHENsi+R42Co4Jg3nnBaOd0rzus3ed6fyeCLGCL4b9H6//4iG9sNto1f2+7nS
189DNjrslKl5sT3C5ahZw4r/I3siyX25/ol1y6rCNbJp1rULtjGe6jldLnIchtJ7
nPbrDahmiAiTu5PK80SOINka2lkfwgX2/KcbI5wEX5cUZcoHBw34Ny2bXx91W0OZ
s4Cai4KYsdoY/DiuioVM/vZ0qMAJGu2Mp9e2fPfp/I8JVBbEVMuZeGt9uOJacBi2
yRiQ8P1q99HJYOLJvG5kc/nH0QEpqadbw6tD0kM8y8JlsmXthiJuZ9N5aypMaZko
51UK8TMf8zEjHTh8gm0WyITuwfVWdIrDoeYjZgjcjr72LSoYPqO55OktmqWEQR89
kd/1XrUk1FfdOqVJLXwIXobzAKdd1MF0ksi9B8pbRJEgHH3Wx106IhBbpIZirqQJ
r1LwveTGHl6n2H5d2wlrp40SZnwqRbz/x2vl1zlwhFpHcpftxVLlQWbXTOQTwBtR
Lhe8XsZVtL2SrtvfzlQUrmRtBLQZltIwZgXqxFy/7N0WMu3hokJT7efLKfA2Y11h
ySoMw8YCI1hBFG7NhOd2XKqYfIK+3UaClTgSB8WShqzHvEIuIL4iRM/qf7HU3/Gl
nuIYylhM8kx7fzrYpA6o
=Gill
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
