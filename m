Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639A42050
	for <git@vger.kernel.org>; Sat,  9 May 2026 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330807; cv=none; b=dpaO5rDbuqQJD4wDpNa6bJJvzpckAHkwgfTeuk02MKg/T7QtQMutTr/RDyoK7d8vtUTUfy6qyFOTT9Qa+X2bmV5ZsYY5KAjADQdVn3yBlv+0kuCoTtJBIkf1d+T43rsckfGGEZ28dYbjRjWqSSJi8I+DrNVNLSmPRHK+b5Pkp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330807; c=relaxed/simple;
	bh=pTEHB1wS5PHRzVtgVp8D5acwXwwS710FqeMBiACa/Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLGklo0XqwovWrEe3dulRMTbKeM3+B7MZNBPW8VdxEqijUqwokkudsPLFi7/LWP2BrM/0fJNC750yOFsMC7UoUP/ZuKr2/AJeWfSDCzj1FkHHrMrADkBMF13/YMbaic72arztfs64P4eShFbc31h21846alLOvvxbBG1Gkbuw/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=f0fl28hz; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="f0fl28hz"
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:3d51:7a10:3981:3744])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id CAB14B0055E;
	Sat,  9 May 2026 14:46:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1778330797;
	bh=pTEHB1wS5PHRzVtgVp8D5acwXwwS710FqeMBiACa/Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0fl28hzkEAmyR3X9x9nDpwJle/DGh2/ecrT6gDVYhqUWxXzoqDV0Oo8f3mA2/qjV
	 M6aqTCY2qdkarRaGZm2FYhsrz5ELOycZmAfv2ZiLY/Ztu5lZL9/zATIZMlNxbEa+t5
	 94Rkfz9lQS4v3fAJV1UVhCqjoSZt9NJTmK3JeBfAmabrN/JPO5IiJsNXEifMxJoiLL
	 UBOXs6523MOPlZBwqscQRl2sDrdp4ywJu/GDJQLRqBXlRuKUsvWmarGLzdWuZrgfb+
	 jcOTDiv3UMPakAi0kbZnLJoEJU7wwwLyDJvslJECS+pm1fmn5FfKMhnRL1lA0FvBJO
	 af67oW2z0Sgnw==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Cc: Mirko Faina <mroik@delayed.space>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
 Tian Yuchen <cat@malon.dev>, Ben Knoble <ben.knoble@gmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v6] revision.c: implement --max-count-oldest
Date: Sat, 09 May 2026 14:46:26 +0200
Message-ID: <2409449.ElGaqSPkdT@piment-oiseau>
In-Reply-To:
 <ce8d1ff49ef418ae3720265a124ef53a959d289e.1778017966.git.mroik@delayed.space>
References:
 <2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
 <ce8d1ff49ef418ae3720265a124ef53a959d289e.1778017966.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 5 May 2026 23:54:56 CEST Mirko Faina wrote:
> --max-count is a commit limiting option sets a maximum amount of commits
> to be shown. If a user wants to see only the first N commits of the
> history (the oldest commits) they'd have to do something like
>=20
>     git log $(git rev-list HEAD | tail -n N | head -n 1)
>=20
> This is not very user-friendly.
>=20
> Teach get_revision() the --max-count-oldest option.
>=20
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
> Since v5 I've reworded the commit message and rewrote the docs for
> --max-count-oldest to be clearer on its functionality.
>=20
>  Documentation/rev-list-options.adoc |  5 ++
>  revision.c                          | 77 +++++++++++++++++++++++++++--
>  revision.h                          |  2 +
>  t/t4202-log.sh                      | 14 ++++++
>  4 files changed, 95 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/rev-list-options.adoc
> b/Documentation/rev-list-options.adoc index 2d195a1474..9f857cabcc 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -18,6 +18,11 @@ ordering and formatting options, such as `--reverse`.
>  `--max-count=3D<number>`::
>     Limit the output to _<number>_ commits.
>=20
> +`--max-count-oldest=3D<number>`::
> +   Just like `--max-count=3D<number>`, it limits the output to _<number>_
> +   commits. But instead of limiting to the first _<number>_ commits it
> +   limits to the last _<number>_ commits.
> +

Putting aside the discussion of --max-count=3D<neg-value> vs --max-count-
oldest=3D<value>, I do not think that defining --max-count-old with respect=
 with=20
=2D-max-count is legible. It would be better to refine the definition of --=
max-
count (i.e. "Limit the output to the _<number>_ first commits") and just=20
define --max-count-oldest on its own in the same manner. Referring to anoth=
er=20
entry is only practicable when it avoids repeating a long explanation.=20
Otherwise, each entry's explanation should be as self-contained as possible.

>  `--skip=3D<number>`::
>     Skip _<number>_ commits before starting to show the commit output.
>=20
> diff --git a/revision.c b/revision.c
> index 599b3a66c3..3aaa77ced5 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2339,10 +2339,24 @@ static int handle_revision_opt(struct rev_info=20
*revs, int
> argc, const char **arg }
>=20
>     if ((argcount =3D parse_long_opt("max-count", argv, &optarg))) {
> +       if (revs->max_count_type =3D=3D 1)
> +           die(_("can't use --max-count with --max-count-oldest"));
>         revs->max_count =3D parse_count(optarg);
>         revs->no_walk =3D 0;
> +       revs->max_count_type =3D 0;
>         return argcount;
> +   } else if ((argcount =3D parse_long_opt("max-count-oldest", argv,=20
&optarg))) {
> +       if (revs->max_count_type =3D=3D 0 && revs->max_count !=3D -1)
> +           die(_("can't use --max-count with --max-count-oldest"));
> +       if (revs->skip_count > 0)
> +           die(_("con't use --max-count-oldest with --skip"));

Typo here (con't =E2=86=92 can't). In any case, please prefer=20
die_for_incompatible_opt2, to uniformize the messages and limit the number =
of=20
translation strings.

Adding a test for these incompatibilities would be great too.

> +       revs->max_count =3D parse_count(optarg);
> +       revs->no_walk =3D 0;
> +       revs->max_count_type =3D 1;
> +       revs->max_count_stage =3D 0;
>     } else if ((argcount =3D parse_long_opt("skip", argv, &optarg))) {
> +       if (revs->max_count_type =3D=3D 1)
> +           die(_("con't use --max-count-oldest with --skip"));

ditto

>         revs->skip_count =3D parse_count(optarg);
>         return argcount;
>     } else if ((*arg =3D=3D '-') && isdigit(arg[1])) {
> @@ -4521,15 +4535,68 @@ static struct commit *get_revision_internal(struc=
t=20
rev_info
> *revs) return c;
>  }
>=20



