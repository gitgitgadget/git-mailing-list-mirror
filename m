Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09BC44064F
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291218; cv=none; b=Q2l2Ff/wz76QD5NS53HQDu01Ke3HYvFHvuvxkkkZCST40ikZO8b9nYZpmz6Sl2DA1WIFpBgavkwKPbvFBVm55wpu3WoNw5lF1b0OZp0w81zekXENN7T1Ykz3YAAoiwhiR3VS+xyOsydywo9lyf845bMa1xITFdBvqHB7eRcVTgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291218; c=relaxed/simple;
	bh=/m6bgmaft4DogM1cLvfotP9S8ObbHYbUbQiCuJP9UHY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BYTjncYQX2PuVXDLUqVC3kQijiqu0jZd8n7eLwdbJESUqYqvXKznnjJOaav+CJpdThNbsjldx9vllF6fGw0auRQ+/JFvU3Hvlvox5rYxHsC2xR2+J+Q3TTJ5ZKH4LmZnvMTlOraN/RT+UCSjQnMbtjvuTi6Lb4yeb3mEolX02uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI6acAzu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI6acAzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EF61F000FF
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791291215;
	bh=/6YP2bJzMBGOKqHyRPai6gAlxHguYSWDKK3RFyfd9dA=;
	h=Date:From:To:Subject;
	b=BI6acAzudgCfPGwIe65GBSOU2UXkwJeUO9lo8r7QMsWIFvRUOdB0L2Jd4MYtx4VlB
	 pZv+mztrFoHSTVTlW0id9XuHdBn4dKXuS7eFi2GgtxawuhPMdXNozyJQPJx0OEPX5F
	 n1GsNYpABv4y+McGEeXjcTIhLmngMyNTexb4OBQWuTambl4Ys/Qqvw38kscKU+gvJi
	 qIdymBaE2oWkyRFTefLnEKPSXgxgMy4SW1pqgPsTuNdewie9dkjnVH5ShwEiFsBVUK
	 l5wMVHVhd01ld0t1akpzDWDYEi2sL49tPEiCkOnDsoD/CpYVjshqPmI2LH0lXbIhIK
	 S19O2ShWUxwhg==
Date: Tue, 6 Oct 2026 14:53:30 +0200
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: git-rev-parse(1): not printing HEAD
Message-ID: <asTtplhokqqZ3FFg@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uycb43cfv63t54x7"
Content-Disposition: inline


--uycb43cfv63t54x7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: git-rev-parse(1): not printing HEAD
Message-ID: <asTtplhokqqZ3FFg@debian>
MIME-Version: 1.0

Hi!

I'm imitating the argument-parsing of git-rebase(1) in a shell script.
For the <branch> argument, if the user specifies a branch name, we
should use the name; if it specifies something else, we should use that
*as a detached HEAD*; and if it doesn't specify anything, we should
use the active branch (if there's one), or the detached HEAD (else).

I've implemented it this way:

	if test $# -lt 1; then
		git rev-parse --abbrev-ref HEAD;
		git rev-parse HEAD;
	else
		git rev-parse --verify --symbolic "$1";
		git rev-parse --verify "$1";
	fi \
	| sed '/^HEAD$/d' \
	| sed '1!d' \
	>"$dir/head-name";

I wonder if I'm overthinking and maybe there's a simpler way.
Or maybe this is the way.

The script above works by defaulting to HEAD if not specified, or using
the commit ID in $1 (I've shifted, so it's just the last parameter) if
specified.  In the case where HEAD is explicitly specified, the user
wants a detached HEAD, while if we've done it, we want to try the active
branch if any.

The sed(1) part (together with the second commmand in each branch) makes
sure we never keep the literal HEAD, but rather a reference or a hash.

Is this the simplest way to do it, or is there a better way to do it?


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--uycb43cfv63t54x7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrE70QACgkQ64mZXMKQ
wqlWZRAAufxHJimLJez0JnfFKpA8074tqSu6K2TZkc0wPIr9hyQI5cPyZ0a2/HyF
cB8pMIjas+BKtTlV5ib1IyK+GfRPSHecbzHGQssAS5e5LUyY+qaat3XB202p0H/l
fnXdmUg4KqV8IE2GjuFwrENDCfiN88FbxaA4joFAUEWOlDBeWrDjqbIhLDZr6V4q
eLIiHSq+ABCBLJrPdPc0gpcF4eDXqRjrbK35iXO2rLQKSk4Ga4ZJ4CO4TSMcjPq/
mYZ9HtsekAaRomcbCIz9rZSjy822MyARmX8QuzN2CGEhSBzHMyACHbgIyRofkrsa
vDhwLMG+FAufVCp3wzeWtYbflrtrPv2qotWmLetp0/P46AKLcfV7CQCDX4jPtFbm
ZneYUN+GgrYhMGVgYpc9eZQWwyG5ZN0Z+7h2qWvwReWGuUKmvXkUA6Eerd6hR56T
hAMujayhIBBpavW4uJICt2G26HTdPylLbTiKwf25oR6DPpQCXKh/M009695V0onf
2XzqRqbN/wOkxqFEdDDP7qM69Va83+LUL8quN4RoKnksIfYUXBr3FFAAh7pAaugZ
gm8p+Syl52u+svLhEQLNXi5X/ogNwllwf+9D7gMffxF3VqqbvlJZHeTbXthIEg8g
RZCoKqNc+HIufnKk7AedwjdnQcdveScm+NWJX5gzn2IoGcx7AJk=
=eGLd
-----END PGP SIGNATURE-----

--uycb43cfv63t54x7--
