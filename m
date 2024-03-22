Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552AC38FBC
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096492; cv=none; b=lkAWTAvfEBG+T6/FVTVc7YeEZhOmwxCqxLPwrvybMQuIibRKjjNwmnf/4zh3x7Y9BL9++oqO4sOU1n5OM9KybM1lN25FQO+cqBft3Tuw1Pvd4BTFscOCLtkZr3bgJgjMThQIVtk1vXT2tmGyGC/LCpgUIojkCB6PFsAZ0pEcNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096492; c=relaxed/simple;
	bh=cguqibnfwj+XpwPDZ8BUFshHzej5lIVDW1FC3pb69GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=La4bkHVoNpvw3YWa29x7EYg7+Gxveb5tXLnZYDisabj9CDMZjwyeeqvZeBevN467QWh9/ods8CP7wjQEza/Sos+cTagQ/xoNI0FAai56Qah+yJwWn04N2YnOxF8zPRJ99Ou84gVT/oUOTwB5FkJXefRp+o+CZGG1+5LwmTI2FiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=pVh7+G+y; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="pVh7+G+y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1711096478;
	bh=cguqibnfwj+XpwPDZ8BUFshHzej5lIVDW1FC3pb69GQ=;
	h=Date:From:To:Cc:Subject:From;
	b=pVh7+G+yGOd7vpzjgV+KOwBbrKibjkvRRdp/Yj8pIGOpTyrCqg7xp3rDL33JE6mv4
	 srWiilcb+KWJ9hW44y5n/ZM+I0X9Co6oK9WaiFnd+YvrKM9WZfZmJPBcjJP+5vh7JI
	 N/n+0Wx4eSt80cMnDVI+Ex/gtidAb3Zhl05YKOrOqinT2KodWfC75FuCF3Vbdi2Y91
	 WLpR4Hwg9iVrdIIO9HZhXrd+OwyVQCbVzb9t3LzdDokqQ81Wab5z7d79ZFKZXNX4mt
	 loISMCxaNQPIYVytZzZpkKYoUsMan2p3QLZi4xGV32nF1JePkdFpqL7TSpRzHG7IfR
	 6gKMxaQUIMmJw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id CAF9D165A;
	Fri, 22 Mar 2024 09:34:38 +0100 (CET)
Date: Fri, 22 Mar 2024 09:34:38 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
	Josh Steadmon <steadmon@google.com>
Subject: [PATCH] grep: improve errors for unmatched ( and )
Message-ID: <petpdy3bs6wpfd3ilrg6xrjsbj5y7ql4geps6y22ozdqw7vi4k@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="34a3eb3c4sahyay7"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--34a3eb3c4sahyay7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Imagine you want to grep for (. Easy:
  $ git grep '('
  fatal: unmatched parenthesis
uhoh. This is plainly wrong. Unless you know specifically that
(a) git grep has expression groups and that
(b) the only way to work around them is by doing -- '(' or -e '('

Similarly,
  $ git grep ')'
  fatal: incomplete pattern expression: )
is somehow worse. ")" is a complete regular expression pattern.
Of course, the error wants to say "group" here.
In this case it's also not "incomplete", it's unmatched.
But whatever.

These now return
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

--34a3eb3c4sahyay7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmX9Qp4ACgkQvP0LAY0m
WPH08Q/8CEjOHGlCbe0eCzREO01enPTuVyMhu6OnxdocoDT1rEum2Q1erpurbosd
htX6ahOlzC/Is5KRIJQOobRTPEDlsC6uiP1Cy9VMawNYskK58R9IhPPkiX0CNpPB
h+w6cfTviWTYmA/sQM+kuhhQZKa+CXkF0AmxUnkR6kNfaWudvSOg8EbF1beilnOo
ukOlk2tzFZ+L2Ghz4G8TJfJOh7uT8aBPPKnhVS5WiEGtCttx4L8r/uix7/DT5SNy
bTo7Rd+zISg84DVWsRdrIZ8zrkJRZMnwDv8ZDkzfhOjH1NnXPiqrcCiVKYRnM7ql
DZINY+9ZjK1C8RrPaicjJjkw8XhqwvWctpKgfoKgS4Ex1fvEI7DrAa2cpCmLQJQt
n3lCvhZ6L0C+F8yZm+2gMT/1ngaD3sdDOQOBWkia9vh84UAvHUq9LES0n8goMApT
IWpedK+gNPTYqL6Dlg6pQrz7Rjizvw4H7R2V4IJeCoO1zVClBY0g3KJMBDrPMAia
34mtxxb7aU3U27zRhaGMTZkdPKshHO5mUYyJdtF4JH0e5E2xmZWsKXNkosUfEcTq
mH+8n4MMNwHA1WBgAsAUjkqwbtwRQ+Jr9Hcc9eSX5gC5PDaI1tlORKv82hg0jpOL
V2jdf0okWiCiHbaw9afibGFhDojkIKuAidu8g21/cm5MOoapTX8=
=CZHn
-----END PGP SIGNATURE-----

--34a3eb3c4sahyay7--
