Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF7181ABB
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657289; cv=none; b=MiTBBVNiBv3r6QVwJUeqoWCNupPZEZKROy7BTJJ8/7bt9VfnYqVxRzvi8fDBDCqFyIAJTu/sAPk4YPkgX6UhvV/bqZpozs3efyNfoGBBqSGgv70PcVyDkJv/o7ssnAeM7549xKcRTEYP6S+SfU6vsrG+7F1lLpjL7UYf1iNUFUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657289; c=relaxed/simple;
	bh=DxtU+3ympYKgjhnhpIzLxMCpXfpxLdtIGJBzbKdUbw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF6vcaVPwAJsipSQeG6tyNb+afSUeyZMeLa1X9wRRbu8pQH2SBVx/SHaNw0ziFv45miHXdn7KrPGr4vDFSDpewunYO37WMWy4H2vaCF6qwz5zV4pxTyFcBjl2gQb55cd5iOHRP40/dUrTw4qH0AyVoMWA/SZHTFT9IqDObl4Yto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=Q3RXdVbQ; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="Q3RXdVbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1712657276;
	bh=DxtU+3ympYKgjhnhpIzLxMCpXfpxLdtIGJBzbKdUbw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3RXdVbQXgU43USK8FSlJ9QMATiP3pvFYkkqGPP3b/SwPR6PvvN4063Otby33McbO
	 bzlWS1EhjCcfuTaysS2A0A23OsZlyMut/k1qBfDipyN7wWkj07Hqh/WDbTk76XL4/S
	 Y9bPrVJpItiSSQ49NXpvp0PZmJrMHw1TWDjHxtWh4yVfoTI0/aIGdura7tiF9ALrke
	 8Q5JZ01yfYYUPhlE7nqfVJ3mJZ205y/UOjCBNpjJMuqETPL/Y9mX0iOlK84PaOCrMh
	 Ho0ZR456FoXZAh6Ls1F1V7tm5hjToR9EoguGzKrH2FbEUpdE/yNufPqFrg/vps862z
	 VXOsm32bYxiCw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 4BD9B23CC;
	Tue,  9 Apr 2024 12:07:56 +0200 (CEST)
Date: Tue, 9 Apr 2024 12:07:56 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Subject: [PATCH v2] grep: improve errors for unmatched ( and )
Message-ID: <gkoqujwrzxdt2rxpcbhz5zfspnajdko53wlazaymt5lbce5qch@tarta.nabijaczleweli.xyz>
References: <xmqqzfuox1oi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m3sdhqcr3kvub673"
Content-Disposition: inline
In-Reply-To: <xmqqzfuox1oi.fsf@gitster.g>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--m3sdhqcr3kvub673
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Imagine you want to grep for (. Easy:

  $ git grep '('
  fatal: unmatched parenthesis

uhoh. This is plainly wrong. Unless you know specifically that
(a) git grep has expression groups and that
(b) the only way to work around them is by doing -e '('

Similarly,

  $ git grep ')'
  fatal: incomplete pattern expression: )

is somehow worse. ")" is a complete regular expression pattern.
Of course, the error wants to say "group" here.
In this case it's also not "incomplete", it's unmatched.
But whatever.

Make them return

  $ ./git grep '('
  fatal: unmatched ( for expression group
  $ ./git grep ')'
  fatal: incomplete pattern expression group: )

which hopefully are clearer in indicating that it's not the expression
that's wrong (since no pattern had been parsed at all), but rather that
it's been misconstrued as a grouping operator.

Link: https://bugs.debian.org/1051205
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
-- '(' no longer mentioned, otherwise no changes.

 grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 5f23d1a..ac34bfe 100644
--- a/grep.c
+++ b/grep.c
@@ -621,7 +621,7 @@ static struct grep_expr *compile_pattern_atom(struct gr=
ep_pat **list)
 		*list =3D p->next;
 		x =3D compile_pattern_or(list);
 		if (!*list || (*list)->token !=3D GREP_CLOSE_PAREN)
-			die("unmatched parenthesis");
+			die("unmatched ( for expression group");
 		*list =3D (*list)->next;
 		return x;
 	default:
@@ -792,7 +792,7 @@ void compile_grep_patterns(struct grep_opt *opt)
 	if (p)
 		opt->pattern_expression =3D compile_pattern_expr(&p);
 	if (p)
-		die("incomplete pattern expression: %s", p->pattern);
+		die("incomplete pattern expression group: %s", p->pattern);
=20
 	if (opt->no_body_match && opt->pattern_expression)
 		opt->pattern_expression =3D grep_not_expr(opt->pattern_expression);
--=20
2.39.2

--m3sdhqcr3kvub673
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmYVE3sACgkQvP0LAY0m
WPFnpw/9HmQCBBP8RVv+vQVdD5Dhq8ZLk1YzTdV5tyaSPk1KnR4Qj8sq0lvzWv8n
mPeXtZq1hEFgXu9OJK/oejEkOpRkBk9w+WtDK+SIJJ51LlWOZk1ZIJOjaSkD/Q+j
DMenEKgKv60Yqt2TqUhFIP+3faWBGAt4soyVp0tHuSsU45Ht7ajpvSRGik4H09UP
XNz19KKPSlQBTZjQAwt4gWDWd0wkfKf/7+gTX4pWQqh1Pb+bfAR0VQX8ropwzgkY
vIB9oDjmvBGJZJ+x4ulf4judDLqobK5OyUjjZ+jQoD6AIsgSPkJe+huCZJ2pr9cj
c6nRYeZE/xqR+Qt8DEC+8QlII6Rc7bv1Srv03g1QVDf3uMOyK5xsgfOrlQioc8qV
/ozhsoxKWS+X/CyjaRFOIwW61v+opDizXzI0bqS9b6SB511dbvJ7kleqRdbi7Dp7
GeteUkMBRrfrDoOmkfZO8ARB3Qk681Q742ZCaMXSTEFnQBrKgcODIdqdVJffbYxd
Hz3OJWw+GXxU+YP/jr+ayTxtH8Srih/bD7tv/SQaKYowLS+Oi6ut/VOMmKTd8N+7
DRr5Wp0Eun4F40Ah5xvY2MWDOHyj+6l7SnbZNYqj7FhbggbGm1xMcCanpkg2xTSK
9k+5zZelhP9L8y85hO1zUlIaZkAc2Q/nolflQgH3Z835gRLXBPA=
=9v3F
-----END PGP SIGNATURE-----

--m3sdhqcr3kvub673--
