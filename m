Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322CC1118F
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="eNDGkF0Q"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 94E265A38E
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1704656422;
	bh=0IbYGiXjc52B6V/mwi/VhtVG30T86yEDWEnAqebpYzU=;
	h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=eNDGkF0QWcTv7gowL3HHTDD4O0l4pKLhSnbHmfVWrmAKBpmxiVsQlUIMaXPFs759R
	 xd0MErH1BAh9PDnzYPAKRxRBbp5wt63VGfTlmp+llzkRkSqHmnYgdnPuEFzdPEyWng
	 mGJGb8l9WwIP7aPHOjmr1/GCNGJB0jWTIhn2+oA/et2H38fuFLasoGNIcJ3NBr/wPO
	 LG2OEOI5MxaxQcKgl26AvzvBMO8rti97vP+UmoYRUo9Z3xTh/VaPtTr8xwRK+biCmH
	 GhX8XosI/D9bE46jgEKckFTywRHAPfPM+IPLF1gk4xsDGK4EYEZeE3EORdPdjCM8Mj
	 tmTfzbNQNOf9D0gWwGicoXEuokQgqXaZlWW6CbeFDw2rRUJ19J4NtUXLh0o2UGETUp
	 3LfAv611vUaO8oiPtIemreRKqJyE6oAg8PPz4bfr3ObPrfOQQpftXSxzQL21EVuvgH
	 tg5EDHajplTfEKo0U07XLYHrCDiTxWXL2hAEGTR8nxOkNqCjqqq
Date: Sun, 7 Jan 2024 19:40:20 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Subject: Limited operations in unsafe repositories
Message-ID: <ZZr-JLxubCvWe0EU@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CuiSFmfICWrxh9p+"
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)


--CuiSFmfICWrxh9p+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Right now, any time we try to set up a repository in that's owned by
another user, we die.  While good for security, this is inconvenient in
a bunch of ways.

For example, when Git LFS wants to push data locally, it needs to know
where the `.git` directory is because it pushes the objects into
`.git/lfs`.  Thus, we want to do `git rev-parse --absolute-git-dir` to
find the remote Git directory, but we can't do that if the repository is
owned by a different user.

That issue also affects the Git LFS SSH transfer server (Scutiger),
which also needs to read the configuration (to set the umask
appropriately for `core.sharedrepository`).

I had looked at sending a patch to make `git rev-parse` operate in a
special mode where it's impossible to invoke any binaries at all, but
unfortunately, `get_superproject_working_tree` invokes binaries, so
that's not possible.  (If anyone is interested in picking this up, there
is a start on it, failing many tests, in the `rev-parse-safe-directory`
on my GitHub remote.)

I guess I'm looking for us to provide some basic functionality that is
guaranteed to work in this case, including `git rev-parse` and `git
config -l`.  I don't think it's useful for every program that wants to
work with Git to need to implement its own repository discovery and
config parsing, and those are essential needs for tooling that needs to
work with untrusted repositories.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--CuiSFmfICWrxh9p+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZZr+IwAKCRB8DEliiIei
gWMeAP4jWd2wI1uX1uZF+mfQcl2inVM6wnTEqQtAtEuE2xBT3wD/WwBJueATP4jY
UPljV8te7Tk0N7Xnl7SiNDmRDl7G0QQ=
=PwZC
-----END PGP SIGNATURE-----

--CuiSFmfICWrxh9p+--
