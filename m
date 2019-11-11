Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 144371F454
	for <e@80x24.org>; Mon, 11 Nov 2019 07:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfKKH3F (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 02:29:05 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:52540 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfKKH3F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 02:29:05 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 8EF0834CB77
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 07:29:03 +0000 (UTC)
Received: (qmail 24614 invoked by uid 10000); 11 Nov 2019 07:28:56 -0000
Date:   Mon, 11 Nov 2019 07:28:55 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Jeff King <peff@peff.net>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] bundle-create: progress output control
Message-ID: <robbat2-20191111T065646-317702456Z@orbis-terrarum.net>
Reply-To: git@vger.kernel.org
References: <1f7f0aa1e8fae54bf967ae83a160be2b30db634f.1573248640.git.gitgitgadget@gmail.com>
 <20191110204126.30553-1-robbat2@gentoo.org>
 <20191110204126.30553-2-robbat2@gentoo.org>
 <20191111040750.GB6379@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XG0jWBK27HhJN4nS"
Content-Disposition: inline
In-Reply-To: <20191111040750.GB6379@sigill.intra.peff.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XG0jWBK27HhJN4nS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2019 at 11:07:50PM -0500, Jeff King wrote:
> On Sun, Nov 10, 2019 at 12:41:25PM -0800, Robin H. Johnson wrote:
>=20
> > Support the progress output options from pack-objects in git-bundle's
> > create subcommand. Most notably, this provides --quiet as requested on
> > the git mailing list per [1]
> >=20
> > Reference: https://www.mail-archive.com/git@vger.kernel.org/msg182844.h=
tml <robbat2-20190806T191156-796782357Z@orbis-terrarum.net>
>=20
> I'm glad you included the message-id here, since "182844" is useless if
> mail-archive.com ever goes away. We usually just cite public-inbox for
> that reason, since its URLs just use the message-id anyway:
>=20
>   https://public-inbox.org/git/robbat2-20190806T191156-796782357Z@orbis-t=
errarum.net
>=20
> > +--progress::
> > +	Progress status is reported on the standard error stream
> > +	by default when it is attached to a terminal, unless -q
> > +	is specified. This flag forces progress status even if
> > +	the standard error stream is not directed to a terminal.
> > +
> > +--all-progress::
> > +	When --stdout is specified then progress report is
> > +	displayed during the object count and compression phases
> > +	but inhibited during the write-out phase. The reason is
> > +	that in some cases the output stream is directly linked
> > +	to another command which may wish to display progress
> > +	status of its own as it processes incoming pack data.
> > +	This flag is like --progress except that it forces progress
> > +	report for the write-out phase as well even if --stdout is
> > +	used.
> > +
> > +--all-progress-implied::
> > +	This is used to imply --all-progress whenever progress display
> > +	is activated.  Unlike --all-progress this flag doesn't actually
> > +	force any progress display by itself.
> > +
> > +-q::
> > +--quiet::
> > +	This flag makes the command not to report its progress
> > +	on the standard error stream.
>=20
> Do we need all four of these?
I copied the exact set of messages from git-pack-objects, and I do think
the same set makes sense specifically to mirror pack-objects for the
moment.

stderr is a tty:
A/(no options) - shorter output
B/--quiet =3D no output
C/--progress - shorter output
D/--all-progress - longer output
E/--all-progress-implied - longer output

stderr is not a tty:
A/(no options) - no output
B/--quiet =3D no output
C/--progress - shorter output
D/--all-progress - longer output
E/--all-progress-implied - no output

Mapping this to a table for a moment:
  1 2
A s n
B n n
C s s
D l l
E l n

1 =3D stderr is a tty
2 =3D stderr is not a tty

s =3D short output
l =3D long output (includes "Delta compression...", "Writing objects: ..")
n =3D no output

I think there is a lot of room to improve the behavior here, but at the
risk of breaking backwards compatibility on the existing options, I
think this older set of options should consistent between this and
pack-objects.

--pack-progress-output=3D[never|short|long]=20
--pack-progress-conditional-on-stderr-tty
(horrible names, but I wanted to convey the intent)

> Just saying "--no-progress" would do what you want right now. I could
> understand the desire for a general "--quiet" flag that implies
> "--no-progress", and shuts off any other non-progress chatter as well.
> There isn't any now, but it could be a future proofing thing (plus
> having a "-q" option is standard). But I think we should document it
> that way from the outset (though I notice you probably just lifted this
> from pack-objects, IMHO it should be more clear, too).
Willing to do later series to add --no-progress to this &
pack-objects as consistency improvement if you'd like for future
proofing (specifically --quiet would be all output whereas --no-progress
would only cut out progress output).

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--XG0jWBK27HhJN4nS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAl3JDbZfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsQkSg/+Na0ce5zmjiyZegj9O2pEPTe7yyI12IzMIr124TYScy5Yfq6dT1fgsY8B
9mUvSgjJAGrw42XEDXHo3Ui+XmlbQVzjidAY1J3aegDAc5Ogr6lK0ZyEmAjEV4+g
WbGH3IIpsox8PGL776/jSSlFw3nw/T7pzaOCXl2CYoEFUR8CbOJNHHiFnz9vG2mu
0fz0Jtxx0qSeULE+oJF9mCll+CSxyKMeSMaAeHrPJzskCHmmmbCFtBUUzF+6b1Fi
LcnQsYkIt29EjKGuv7Ti25UxHTULYUCDG3jRK9q/4bz/vAOEGl9bYhQVryR8+jng
dEoaYXzD9DNERFvFgdLJxi+BlcFIqFmSDcZfF40e7h2GukBVo17JLSHe37Fn1RMg
IcMFaXT1FjojxPHG7TYjCDzjz8/D0jfMZvWq6Cm7Efw4/x3il8sIXPaoszVBS+aM
+e5rpvJYiWFjcgElv5H/i1AIA31x0nqtW0kEDm/YEDV92QxmWCoQQBTZWftkeL/5
kCdbg+YoyWeYtk2W3R/wPAPHWrInyVt27G6NPScf2RMMnLJLGQrma8Yd/xhWv8SE
MSB/JchWbC8UbglKRwK3ekwO6Cg/W3vsGsTr48NW1lv7mM/WHaIGyu8rkYuftkbA
ccPumYWe7lntD5bUj+fjfh1INg+4t0Y07Pn+Y27lEP8sXFuM8C8=
=HNU0
-----END PGP SIGNATURE-----

--XG0jWBK27HhJN4nS--
