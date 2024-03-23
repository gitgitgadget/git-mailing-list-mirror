Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E13282FB
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711199903; cv=none; b=nXMs+TrPz3tIUn8EJ+sBINVy/X1ly6j4xVXlJaDR1sjTrIjqMjy9C4VHpk4I4oHTFsJVNhvC34nFcPFn2n7fxRTJhCf/tEE98l9WYoAhlwKPODnvuN1aalpViSd/vxzQ7Axzt2139jkd2OczCqqdXHH4jSOYP/4hgEs5/IClZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711199903; c=relaxed/simple;
	bh=gney06a10qR/JjKWakCdKn10oEu9qZ0POfiFRCmqV2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhjxh5b8H9oUOMBDKcCNNX3zkh5QhBR83H6dGzj8cj4PTMS9/BA7Bm9S7usbq8owt1B+RzVxlapPsTfD/9X6Kn/pkufwqkyGocvq7b35MrSWnT5NVdH8lvTrQC+tmX+t1h9CfI2M06eyGEx7D8Z+j2w2souYelIpG5fWoIc72JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=hXB4qQbD; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="hXB4qQbD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1711199889;
	bh=gney06a10qR/JjKWakCdKn10oEu9qZ0POfiFRCmqV2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXB4qQbDAuBBSyCO5+NCHHg7gEw1JGtyjs0wpt06DyTNY0CGmSjw3Ry0WE5lFSf+Y
	 esG7yHfw2/QtCqzrGOLj05oBgnmHQvHuHaKWDDAaB8mhWt2A8iTcbdqdijnc5KFCi/
	 6sOaNLtlpEbPyYCASnR5isCBk14SDu7oR3FcdHXkbzcKCikr/fW7fgKpEypJcY2gMa
	 AqJMeg0tYp3K+wrgBSdCf2sF/i9DtOmu8L9MFBhnFnb6TNUcgSN3YRJ4wgzjhR0/IS
	 /WleDdT3+Htjc99Cddv1k0dF33QAHt4d4WVO4u7b+KL2TGwKZVDoduIc9Au3K+wyCl
	 kWqzOKpwPM9Hg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 3CFE5145E;
	Sat, 23 Mar 2024 14:18:09 +0100 (CET)
Date: Sat, 23 Mar 2024 14:18:08 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
	Josh Steadmon <steadmon@google.com>
Subject: [PATCH v2] grep: improve errors for unmatched ( and )
Message-ID: <tkz3a5jkalcz5ajemx4b4x42pe6kv45sfmgpin4zeai3moq42o@tarta.nabijaczleweli.xyz>
References: <xmqq34si2p8b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qmouig7i3omh2ess"
Content-Disposition: inline
In-Reply-To: <xmqq34si2p8b.fsf@gitster.g>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--qmouig7i3omh2ess
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
On Fri, Mar 22, 2024 at 09:41:40AM -0700, Junio C Hamano wrote:
> Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz> writes:
> > uhoh. This is plainly wrong. Unless you know specifically that
> > (a) git grep has expression groups and that
> > (b) the only way to work around them is by doing -- '(' or -e '('
> I do not think "--" (end of options and beginning of pathspec)
> marker would work for that purpose, UNLESS you are talking about a
> file whose name is an open parenthesis.
False. -- turns all subsequent parameters into arguments, and if
there is no -e, the first argument is the pattern, and all the
subsequent ones are paths. This is normal [git] grep behaviour.

> Just keep "-e '('" in the
> description and drop the double-dash there.
Disagree. This is one of the two methodologies I've devised to work
around this in the past, and it's one of the two methodologies that
work.

All else applied.

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

--qmouig7i3omh2ess
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmX+1pAACgkQvP0LAY0m
WPG1GQ/9FSR4hEBgFAmn5dzXZIp2aOpsfFhME4UXgHNZZLleexGdvTLYWVPsih40
9wqWU+E+HzsJUujjAoY+RMdkzDa0DBAyrWIlnyCGbcWpSpF/EfgbiRglECfJLXpm
3I1zPtjwKr5ZLOMab3lymlcK4/KEdhV2clKjxXEY3JJEPav7HIgw9+BzXmkfedOk
XsrVqnkSspFPMAkDzioNI3R4vggf9SupeEvtEu5PckDHkRJZe8ZuvUSWAe1VoVbE
8Hk+u1WF8NfAMI2EkxdTDa4ITunDsqMhBIobgNkEv546lYEXzxUW22u6CWk3+y3M
WxMYWSh4i92YdRpCZeojTFstxI08+K884aBRinpYS8e3z1A2oGFZb06xazwHgwd+
6kBpwvdtduRpFfix3DJ2ACNvmHZZXtUQuTGXtXoEtpnUcedN6az0y70xXvKtdxNI
LVoaZcecvjtcN/sX6fA9hpD7C5FFCG8mw1wGDKSBV+wiCk6bMmTA48TJ8NTMfKfB
GCm7qpRX8eyy3+7sPN1WhVjcUUlHtZsDbh/HqLcmK61uIoIxGK1NWYXav6Npc2uB
mKtJAaramZ2/x6rCXppS+9C4JIewWJSnyl1dzzk1K6YpRRN/8mi2BqXOo6yvC9uE
praRdYaFDp5kyIbKXnhe/3nIUne09VfJX1VFTyrFrHaAHCSKHF8=
=N3rS
-----END PGP SIGNATURE-----

--qmouig7i3omh2ess--
