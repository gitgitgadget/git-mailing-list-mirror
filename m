Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240B31F405
	for <e@80x24.org>; Fri, 21 Dec 2018 13:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390733AbeLUNwS (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 08:52:18 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:51820 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbeLUNwR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 08:52:17 -0500
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 1A029335C58;
        Fri, 21 Dec 2018 13:52:14 +0000 (UTC)
Message-ID: <1545400330.811.1.camel@gentoo.org>
Subject: Re: [PATCH 0/4] Expose gpgsig in pretty-print
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     John Passaro <john.a.passaro@gmail.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Alexey Shumkin <alex.crezoff@gmail.com>
Date:   Fri, 21 Dec 2018 14:52:10 +0100
In-Reply-To: <CAJdN7KixEG+VKJAZz281RFEiVPRpRz_fBy6J2dBJiJMYT1mpBg@mail.gmail.com>
References: <20181213212256.48122-1-john.a.passaro@gmail.com>
         <1544760713.970.1.camel@gentoo.org>
         <CAJdN7KjExd6T+H4-wEupO2dg_mMWzeA22oYaskkfhz+GuFbfRQ@mail.gmail.com>
         <20181217202406.GA12122@sigill.intra.peff.net>
         <CAJdN7KixEG+VKJAZz281RFEiVPRpRz_fBy6J2dBJiJMYT1mpBg@mail.gmail.com>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-rL3ipPbdZGDfrWJPO4QR"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-rL3ipPbdZGDfrWJPO4QR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-12-19 at 00:59 -0500, John Passaro wrote:
> On Fri, Dec 14, 2018 at 6:10 PM John Passaro wrote:
> > All seems to work fine when I treat %Gs as a detached signature.
>=20
> In light of this, my best guess as to why the cleartext PGP message
> didn't verify properly is that the commit data normally doesn't end
> with \n, but as far as I can tell there's no way to express that in
> the cleartext format. I don't see a way around this.

You are most likely right.  I've just skimmed through RFC 4880
and indeed it seems to rely on the newline encoding being quite
normalized in the message.

> However, as long
> as the following works, I think we have proof-of-concept that this
> enhancement allows you to play with signature data however you please
> without leaving it to git under the hood:
>=20
> gpg --verify <(git show -s --format=3Dformat:%Gs commit) <(git show -s
> --format=3Dformat:%Gp commit)

That's a nice trick.  Thanks for the effort you're putting into this!

>=20
> On Mon, Dec 17, 2018 at 3:24 PM Jeff King <peff@peff.net> wrote:
> >=20
> > On Fri, Dec 14, 2018 at 11:07:03AM -0500, John Passaro wrote:
> >=20
> > > Then I might rename the other new placeholders too:
> > >=20
> > > %Gs: signed commit signature (blank when unsigned)
> > > %Gp: signed commit payload (i.e. in practice minus the gpgsig header;
> > > also blank when unsigned as well)
> >=20
> > One complication: the pretty-printing code sees the commit data in the
> > i18n.logOutputEncoding charset (utf8 by default). But the signature wil=
l
> > be over the raw commit data. That's also utf8 by default, but there may
> > be an encoding header indicating that it's something else. In that case=
,
> > you couldn't actually verify the signature from the "%Gs%Gp" pair.
> >=20
> > I don't think that's insurmountable in the code. You'll have to jump
> > through a few hoops to make sure you have the _original_ payload, but w=
e
> > obviously do have that data. However, it does feel a little weird to
> > include content from a different encoding in the middle of the log
> > output stream which claims to be i18n.logOutputEncoding.
> >=20
>=20
> Thanks for the feedback! This is an interesting conflict. If the user
> requests %Gp, the payload for the signature, they almost certainly do
> want it in the original encoding; if i18n.logOutputEncoding is
> something incompatible, whether explicitly or by default, that seems
> like an error. Not much we can do to reconcile the two requests
> (commit encoding vs output encoding) so seems reasonable to treat it
> as fatal.
>=20
> Updated patch coming as soon as I work out Peff's aforementioned "few
> hoops" to get properly encoded data -- and also how to test success
> and failure!

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-rL3ipPbdZGDfrWJPO4QR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEXr8g+Zb7PCLMb8pAur8dX/jIEQoFAlwc8ApfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDVF
QkYyMEY5OTZGQjNDMjJDQzZGQ0E0MEJBQkYxRDVGRjhDODExMEEACgkQur8dX/jI
EQq/7w/+KkB/v0RhGUA8UzQpcnOWchvKnYYw+iMRMrNgQzuABmUMWpk/CILwoHVs
H0AoWJewXT0qmr3MCiA/cPMryydcnopLs4CXwTPtjkFFpWUPVHIZ2ybv8GXJg5b6
0qaQ9mnMWIWqcyJrAKtKqDEgd/oWpy3R14ai1n6dAg4fHnCXyBWd1ZM6nqan7wQB
2LkQqyx5Sgb9dVXBPCKfe4mzKEhoox9kFWr1ovH/5tVS9LsHMtysqvK0vgeBxTE2
LOz8+581hzaZN3b8DhSlrnY9pSbRyl7WoCjkJw/mm9DGXxyGlRFSjyki4HGZfyRC
nLeaLTV4Iqz+y/y8BD/+KaQAglrAgcT/IVjilDSqHt2HDT/OI6X1xJkOtSLwbzgY
XI5BiEZ/UtVu0mxX5fgAjT7XEwwOMW+hna7PBy/29TtbthS3gvuidIuQbYWlGUui
vNeZIRbrRt+5/8nzrBzuU6c0ajC1090xMXpUafhuE8VQzytcKZR+GPxHmDmFhh6I
993njM2mBVznJXGw/d8Itk1drRDOx8qJoIymXadegpGlHW0qxzrPtbl3g9zbvVZH
SGgO81livJj3KxelGqYJGOdXkkSMpyUpQsXKRkqAyLZ0bqd1UfH15uweBmYbhXfm
iNDSJVyRXhukS0mupj2R8x0ByMTBe0y5FsHRJ2aiRCNMgEDFSqw=
=ghg9
-----END PGP SIGNATURE-----

--=-rL3ipPbdZGDfrWJPO4QR--

