Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE192C433F5
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 00:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhKTAHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 19:07:01 -0500
Received: from woodpecker.gentoo.org ([140.211.166.183]:33594 "EHLO
        smtp.gentoo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbhKTAGo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:44 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 544753430E7
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 00:03:36 +0000 (UTC)
Received: (qmail 32323 invoked by uid 10000); 20 Nov 2021 00:03:36 -0000
Date:   Sat, 20 Nov 2021 00:03:36 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     git@vger.kernel.org, robbat2@gentoo.org
Subject: [RFC] single-level refs vs push --all/--mirror
Message-ID: <robbat2-20211119T234158-903098822Z@orbis-terrarum.net>
Reply-To: git@vger.kernel.org
References: <robbat2-20211115T063838-612792475Z@orbis-terrarum.net>
 <YZLLUtPVQt2XtgQX@coredump.intra.peff.net>
 <robbat2-20211116T061554-223495439Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6crayufdsMLpW486"
Content-Disposition: inline
In-Reply-To: <robbat2-20211116T061554-223495439Z@orbis-terrarum.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6crayufdsMLpW486
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 16, 2021 at 06:28:28AM +0000, Robin H. Johnson wrote:
> > Perhaps there's a bug, but it is meant to and does push all refs in a
> > simple case:
> ...
> > There I used an explicit refspec naming it. But if I used "refs/*"
> > (which is what --mirror is doing under the hood), then it doesn't even
> > try sending it, as the client filters it out from the wildcard
> > (otherwise, everyone would get server-side errors from refs/stash).
> >=20
> > So you probably want to choose a different refname to store your data.
> >=20
> > I do think the status of these single-level refs is not well documented.
> > The rules in git-check-ref-format(1) imply that they are not valid:
=2E.
> >   They must contain at least one /. This enforces the presence of a
> >   category like heads/, tags/ etc. but the actual names are not
> >   restricted.
> >=20
> > but that rule is not enforced internally, as "refs/" is sufficient for
> > the internal check_refname_format() to allow it. But receive-pack has,
> > since 1a7141ff28 (Ignore funny refname sent from remote, 2005-10-13),
> > implemented the format check after stripping refs/. And then the client
> > side followed that lead in 30affa1e9a (send-pack: do not send out
> > single-level refs such as refs/stash, 2008-10-29).
>=20
> And the format of the ref wasn't noticed in the hook was previously
> posted back in 2014 :-(.
> https://www.spinics.net/lists/git/msg244053.html
> https://groups.google.com/forum/#!topic/gitolite/7cSrU6JorEY

Hi,

I didn't see response from Jeff King, so I'm wondering good next steps
here.

I'm esp. surprised that git-stash ends up using single-level refs when
git-check-ref-format(1) says they aren't valid.

I think Git should change git-stash and start issuing warnings to users
for single-level refs.

Therein leads a question:
What should be done with refs/stash?

Being able to work on stashes between multiple systems MIGHT be useful
to some users, so maybe they do want it pushed with --mirror/--all.

Choices (not mutually exclusive):
1. Push the refs anyway
2. Make a configurable way to exclude refs from being pushed w/ --mirror/--=
all
   e.g. move refs/stash to the exclude list, then push everything not
   that is not excluded.
3. Change the rules to accept single-level refs?
4. Cleanup phases of warnings before errors and good migration
   mechanisms?
5. Something else?

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--6crayufdsMLpW486
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAmGYO1ZfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsTW/Q/+IUFaUzuA/XMjXElvdFoI+532eUt4WzVhTudBWtgjrJrdlay9Rpu5nokG
j8+Ca/pvdDFWODYNH/NZCdoPmA9DTDfquShpjZhkTjdZ7OiTnnw6OS+OhtbGYres
R2br4Ji1t6Yfk9HBZUMQDsxtxxWoYPbEzEubVU5fMTzwTCxVLhkMU3SIHeBzcFST
F/rJPfJ5IkxWZ2Ah16sCc+JHk5vzP6IXiaQPGtKdPNUtVtXMKCaPiuHf60+V7ejV
aK7oozrOe5R86MVCBjntezXdoTImmHZAezovQlfjgi+ui4QSRWYKzxK38XiyQ9Z9
ajNfs7L8NAS6wziH5xVnos1AKCMrwdOMJ25eYpQDhxbqZAfEV4QbCGUZZMx/JKEF
nuYoG3u0CAibyNj2gVGokciNVELrt5uo2hgyky3E1nHsEpsNhIM1czf0Y3o99Xd0
0nGTIv//WwQmU4ygpB6DYaIpNlfDAVepCCZ7MjmWvG8EwjR7pjvpRqFSoV0/QpAu
w1ly04voYA89hYnfhw4sfSejfRDwK/PS8ZDUBjpob5y37FGsIbyljZOPj5i8NnwR
fvn1GENtdw0V59Rco+StLEStNwtARzF8r0b0lorpkwY3XHbvCBwtoIfVjrrXZg5s
rdmzwNhvacr0sbLnhZLn3iC4942potDQyvaGnouioY/cnj+wNhM=
=/s76
-----END PGP SIGNATURE-----

--6crayufdsMLpW486--
