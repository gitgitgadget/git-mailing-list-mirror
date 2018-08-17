Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324311F954
	for <e@80x24.org>; Fri, 17 Aug 2018 09:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeHQMnC (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 08:43:02 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:42938 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbeHQMnC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 08:43:02 -0400
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 0F0F7335CF4;
        Fri, 17 Aug 2018 09:40:17 +0000 (UTC)
Message-ID: <1534498806.1262.8.camel@gentoo.org>
Subject: Re: [PATCH] gpg-interface.c: Fix potentially freeing NULL values
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Date:   Fri, 17 Aug 2018 11:40:06 +0200
In-Reply-To: <CAPig+cQVWY3+2aarYw=uXti0=1SW8boMPoYj1zatw1KKKVOqnQ@mail.gmail.com>
References: <20180817091710.1767-1-mgorny@gentoo.org>
         <CAPig+cQVWY3+2aarYw=uXti0=1SW8boMPoYj1zatw1KKKVOqnQ@mail.gmail.com>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-TvZVOJTuhbJVYGvhsw/6"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-TvZVOJTuhbJVYGvhsw/6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-08-17 at 05:28 -0400, Eric Sunshine wrote:
> On Fri, Aug 17, 2018 at 5:17 AM Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org=
> wrote:
> > Fix signature_check_clear() to free only values that are non-NULL.  Thi=
s
> > especially applies to 'key' and 'signer' members that can be NULL durin=
g
> > normal operations, depending on exact GnuPG output.  While at it, also
> > allow other members to be NULL to make the function easier to use,
> > even if there is no real need to account for that right now.
>=20
> free(NULL) is valid behavior[1] and much of the Git codebase relies upon =
it.
>=20
> Did you run into a case where it misbehaved?

Nope.  I was actually wondering if it's expected, so I did a quick grep
to check whether git is checking pointers for non-NULL before free()ing,
and found at least one:

blame.c-static void drop_origin_blob(struct blame_origin *o)
blame.c-{
blame.c-        if (o->file.ptr) {
blame.c:                FREE_AND_NULL(o->file.ptr);
blame.c-        }
blame.c-}

So I wrongly presumed it might be desirable.  If it's not, that's fine
by me.

>=20
> [1]: http://pubs.opengroup.org/onlinepubs/9699919799/functions/free.html
>=20
> > Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
> > ---
> > diff --git a/gpg-interface.c b/gpg-interface.c
> > index 35c25106a..9aedaf464 100644
> > --- a/gpg-interface.c
> > +++ b/gpg-interface.c
> > @@ -15,9 +15,14 @@ static const char *gpg_program =3D "gpg";
> >  void signature_check_clear(struct signature_check *sigc)
> >  {
> > -       FREE_AND_NULL(sigc->payload);
> > -       FREE_AND_NULL(sigc->gpg_output);
> > -       FREE_AND_NULL(sigc->gpg_status);
> > -       FREE_AND_NULL(sigc->signer);
> > -       FREE_AND_NULL(sigc->key);
> > +       if (sigc->payload)
> > +               FREE_AND_NULL(sigc->payload);
> > +       if (sigc->gpg_output)
> > +               FREE_AND_NULL(sigc->gpg_output);
> > +       if (sigc->gpg_status)
> > +               FREE_AND_NULL(sigc->gpg_status);
> > +       if (sigc->signer)
> > +               FREE_AND_NULL(sigc->signer);
> > +       if (sigc->key)
> > +               FREE_AND_NULL(sigc->key);
> >  }

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-TvZVOJTuhbJVYGvhsw/6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEXr8g+Zb7PCLMb8pAur8dX/jIEQoFAlt2l/ZfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDVF
QkYyMEY5OTZGQjNDMjJDQzZGQ0E0MEJBQkYxRDVGRjhDODExMEEACgkQur8dX/jI
EQomCxAAi6vjZwmqYTCmuM60qNXviEniSZ7ftRcGW13qA23rPn4R6IFLXVEAQFLA
P0KyJXyIxsWuw0lPsRVkQmwbo1kyZmmC4+TmIYKFRZ01RzPGQ+oyPo3+jd2MxroJ
rg5SO9zFfi//qEi+VlfJ4waKSgZMBN3rK5R4pU8mwTEYkUQNIPwzIl5eUltTDpTS
5US3sgD4jG0F02k25TWnNDHfNN4HQwzZrz+4WHjgwgyYTvKE3t/pzx96k6A0Ggn+
wKZfaF/YiAhTXA/kSQfpjik3N+BUuM3TyjoKZKTmZ8Ri+ZqbOG4LOjtC9z9fU1Xf
GmT+xMLybCUvjcHTm930a2x4Ckiukotm94ie9H0jBwRSfOUhOhLHXNXb5sMvIPKY
mX9PNC7q0u9NNwsRbBx86EbFIYoHDFoRxTYWIQiaNSaPar2oWzKP7jSb3Om4Q1da
VTInBAORcCG4uGiMVAaD/xjfFojhLR0ZkjLaKutKS9H1F3/EMx2dF5R8Lfcd0GgK
pxrDSKRW9slrULzJK7fhmZSjWTkQ8NCQElQjKqUpuCZWxTltUEz+7mHPD1T1cYZ5
t9iIH0lY3c3bZY0DxPRvHXewfs/19ewZ1HotdHCa10teAfU/pN1lor/ln1gXbAds
gansK6jQgBTS+Rgyp0egOCdgD6cJ1+YsnD+EIUPJpgAIc53jd8o=
=ahkg
-----END PGP SIGNATURE-----

--=-TvZVOJTuhbJVYGvhsw/6--

