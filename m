Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB24F2D2388
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765410623; cv=none; b=K5UC2QiFh0BYnEzLAU6LrLEaZWTR64RBWVC9TZGfCY+VqFdTCdOTPZPCVADjbwTrjqX/B2pOc5FqGy/MmEZmeak7jnmKnQc2ufd2zEvvoTMQw5+Y/9kpXdT8qF3tTo5yQjw0oSLXEAiIuxbu+ZPD8aBtOnXIMan0uR+wMuibBnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765410623; c=relaxed/simple;
	bh=HGyx/pMyf5WHtnbNBWRD4ud/MOREWaOnZccVZOKWUmM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BtvynUjzEPcIU76yV/cuqyCmr/kUSJrSM5yFOn0zufLwHa4Rfc2FeLRCDviGBxjJdIE6iy0zWQz79TkeyssRwf4iWcuf2e7T6Go7DcBZYClGaalbVzSVQrh0qQUxYtF8YB8b4AuUzakxZzd6fbkEZwgUq6DM86YfwkGOk+MT2b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=h11PKdm5; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="h11PKdm5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1765410608;
	bh=HGyx/pMyf5WHtnbNBWRD4ud/MOREWaOnZccVZOKWUmM=;
	h=Date:From:To:Cc:Subject:From;
	b=h11PKdm5eCi9DOe04kntmWmzWIE1+iSbB66yjUV3bqWsIdYJ9aKqdzDWTxfL9suJp
	 XRwVHZ9j3diHA37NVXst63I7v5CCtlgfToi9jAGwYHRs4cnyZVkibQdHW9+6qpkmyp
	 RutiaiEDMlucJ0fpVFiQKVRRMPk7YxyWKQDQMwwMhmK9ynFGk64D1I1ZhvK+xdhwEz
	 bhfpnhwdPmiyIf+26SzTIsUE4PISZBLEEyFuHv55xtxAcF9lA7j5mGADSuzNrabrA8
	 5s1sO100KjlviO7/nPEgP2GE7kHDkceYQw11GB4B8Ub+Y5SVRuIPcU/YhTsi6s6UYc
	 K1fK/YpDs21Qg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 24433EE6A;
	Thu, 11 Dec 2025 00:50:08 +0100 (CET)
Date: Thu, 11 Dec 2025 00:50:07 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] add-patch: stop getting confused by deletions of binary files
Message-ID: <lfh7rez2sgajamk632sea2s6sm65vbllxuvi6shihdgmtwvdmh@tarta.nabijaczleweli.xyz>
User-Agent: NeoMutt/20231221-2-4202cf-dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fqumngcy2ogfos37"
Content-Disposition: inline


--fqumngcy2ogfos37
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

git add -p can't handle binary files and ignores them:
  $ git init
  $ printf 'a\0' > a
  $ printf 'b\0' > b
  $ git add .
  $ git commit -m a
  $ printf 'A\0' > a
  $ rm b
  $ git add -p
  diff --git a/b b/b
  deleted file mode 100644
  index 28eacf2..0000000
  Binary files a/b and /dev/null differ
  (1/1) Stage deletion [y,n,q,a,d,?]? y
  error: cannot apply binary patch to 'b' without full index line
  error: b: patch does not apply
  error: 'git apply' failed
but didn't do this for deletions of binary files.

The parsed diff looks like
  diff --git a/a b/a
  index 90802fe..e2b43e3 100644
  Binary files a/a and b/a differ
  diff --git a/b b/b
  deleted file mode 100644
  index 28eacf2..0000000
  Binary files a/b and /dev/null differ
which ended up with
  a: binary=3D1 deleted=3D0 hunk_nr=3D0
  b: binary=3D0 deleted=3D1 hunk_nr=3D1

Seeing "deleted file" inserts a hunk and prevented detecting
the "Binary files" header, so detect it even in this case:
  b: binary=3D1 deleted=3D1 hunk_nr=3D1

We can't do anything useful to binary files anyway,
so skip them regardless of how many hunks they seem to have.

This makes the final add -p in the scenario above exit with
"Only binary files changed.".

Closes: https://bugs.debian.org/1122502
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 add-patch.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git add-patch.c add-patch.c
index 173a53241e..2e1ea2cb33 100644
--- add-patch.c
+++ add-patch.c
@@ -518,9 +518,11 @@ static int parse_diff(struct add_p_state *s, const str=
uct pathspec *ps)
 		} else if (p =3D=3D plain->buf)
 			BUG("diff starts with unexpected line:\n"
 			    "%.*s\n", (int)(eol - p), p);
-		else if (file_diff->deleted)
-			; /* keep the rest of the file in a single "hunk" */
-		else if (starts_with(p, "@@ ") ||
+		else if (file_diff->deleted) {
+			/* keep the rest of the file in a single "hunk" */
+			if (starts_with(p, "Binary files "))
+				file_diff->binary =3D 1;
+		} else if (starts_with(p, "@@ ") ||
 			 (hunk =3D=3D &file_diff->head &&
 			  (skip_prefix(p, "deleted file", &deleted)))) {
 			if (marker =3D=3D '-' || marker =3D=3D '+')
@@ -1853,7 +1855,7 @@ int run_add_p(struct repository *r, enum add_p_mode m=
ode,
 	}
=20
 	for (i =3D 0; i < s.file_diff_nr; i++)
-		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
+		if (s.file_diff[i].binary)
 			binary_count++;
 		else if (patch_update_file(&s, s.file_diff + i))
 			break;
--=20
2.39.5

--fqumngcy2ogfos37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmk6By8ACgkQvP0LAY0m
WPGTdxAAoCvmHd2J2j6asG1wqOFGe55Ja1zdx/p14HBeZV53OU+hBjjWq4UtCEkz
7jj1gJAEBy1BIh9tAUkEzlm6npMJqW1BIz/MrX4d5UvcrAj1gxmDBaNoozmMGTAc
EdAARjauCaXbHoGao0x5cipOUMxtDADVN506w8WWSezms9V0Sumdqatn523aLhnr
W0IOXqKMmZV/ZjzjHZEbZ6tumPTcJa8qrNea3xVplUzqvCabX5XdtML33BB+DRdh
RxBvcjxDs/XXU0AmD6SBN+uzexmx5XedZuFanHaaK32OmGQVuG/YuLnXfUIDwXsE
/L7AtqQ/hfw+ez9wEPqDbJFQMC3vL6jISjawPLjc6/o02JfbRGH6pMptVqb/T8Ax
NK1nnqt0TnZb9xw8AO6H1xzEdlGAqd8XeKwxNBw4qgEaZ3V1DxaeMrnwhN65ErHx
mYGl+kkuwreEdbLuRmo2nhD7y5PV5f3OWPBT2OTge0ZYgfeapS66op6FQ9WqChhD
tWvVQRL+RMNE1B70wy4awX1AZ+hJZY3D8Ss8oR7i3w4TQS2bBw42ZV0u7YOvLGcc
vWzvUuWxOvEJ6/tufdqeUtjwzfhR38FpsQN8QxoTw93A+6Z+6kTbWkvjLz9/CJsv
bdHjLHL269iOr6pBqGAbH6p2cNrkfiJ5O4WTNzFCKHjle/eLpfo=
=vd2n
-----END PGP SIGNATURE-----

--fqumngcy2ogfos37--
