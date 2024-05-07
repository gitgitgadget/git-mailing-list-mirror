Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D0D5026A
	for <git@vger.kernel.org>; Tue,  7 May 2024 05:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715060317; cv=none; b=tf9NR+3AC5eMCIqfaQRk3IOXMNmbBv/qLXLT+QS1CVJm1n0119kpfkinTHCIKEZ+BgQjkkoMFoSwni7iRiwzif9OgCevkzO8DgW/pTV22XkMUFSzFMBpFFTP6/D/+5GziULtE3IloO/XOGE7he++NEfY9CAxgQ2PCnS8xBVHVIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715060317; c=relaxed/simple;
	bh=DArMcW/oFMmE8HsmeNpxxeOqvJyujNeXT1j4YsGNplY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdjWcKQ8JNWVlu5qP+nItAoNUkDxKLJAaCM6pDCLXr/Mxs1NYGxpNJzsTlZX06nzncOyfvr14bow0lUMFaWWemjPPo2sCShqhjismcfJNpGXM0oMdlGG8r7oIT9WLYZxaY6QZbeBFBZDl0uK1PrJ3Dfjhxfz93orqMioGhp/OUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id BFFD934311A
	for <git@vger.kernel.org>; Tue,  7 May 2024 05:38:35 +0000 (UTC)
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	by grubbs.orbis-terrarum.net (Postfix) with ESMTP id EBCCA260320
	for <git@vger.kernel.org>; Tue,  7 May 2024 05:38:34 +0000 (UTC)
Received: (qmail 16677 invoked by uid 10000); 7 May 2024 05:38:34 -0000
Date: Tue, 7 May 2024 05:38:34 +0000
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>, Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
  "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Feature request: secondary index by path fragment
Message-ID: <robbat2-20240507T053331-859497691Z@orbis-terrarum.net>
References: <robbat2-20240506T225759-090424131Z@orbis-terrarum.net>
 <xmqqttjawmos.fsf@gitster.g>
 <ZjmtJFF7rv7B8Nhj@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TwPkolQPsYw8vzno"
Content-Disposition: inline
In-Reply-To: <ZjmtJFF7rv7B8Nhj@tanuki>


--TwPkolQPsYw8vzno
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 06:25:08AM +0200, Patrick Steinhardt wrote:
> On Mon, May 06, 2024 at 04:22:11PM -0700, Junio C Hamano wrote:
> > "Robin H. Johnson" <robbat2@gentoo.org> writes:
> >=20
> > > Gentoo has some tooling that boils down to repeated runs of 'git log =
-- somepath/'
> > > via cgit as well as other shell tooling.
> > > ...
> > > I was wondering if Git could gain a secondary index of commits, based=
 on
> > > path prefixes, that would speed up the 'git log' run.
> >=20
> > Perhaps the bloom filters are good fit for the use case?
>=20
> Yes, Bloom filters are the first thing that pop into my mind here as
> they are exactly designed to solve this problem. So if you rewrite your
> commit graphs with `git commit-graph write --changed-paths --reachable`
> you should hopefully see a significant speedup.

Good news & bad news.
"git log -- sys-apps/pv >/dev/null" as my testcase from before:
The fast system (2.45.0) went from 11 seconds to ~1 second!
The slow system (2.44.0) went from 45 seconds to 49 seconds :-(.

I'll try to trace down why one system slowed down.

commit-graph command:
fast: 1m10s
slow: 3m43s

> It makes me wonder whether we can maybe enable generation of Bloom
> filters by default. The biggest downside is of course that writing
> commit graphs becomes slower. But that should happen in the background
> for normal users anyway, and most forges probably hand-roll maintenance
> and thus wouldn't care.
Most repos are also MUCH smaller than this, so it should be safe to
enable.


--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation President & Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--TwPkolQPsYw8vzno
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAmY5vllfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsTIZQ/5AQWafd9puA6LnD0lc6kjawNmqSSg9Zj8mNFMiJswBGhUg+JkQOToqPDG
smxlJAOiP1XsJexmdXxAx2ZqIX2im/EWhxPqdd7cLP6j+PLhzsnoyue0NkfOzhlS
rbMumGnllhCQzie2IiULm82A0J7XAN+ZigSf3fOkT2H+Zj5MYmwaDbZxk4ODxMr/
yP/0dOyXr8REAAMdjDQGK20mvALqItJXJOo4Zpn850q34ow6BHoWqjj7/35nxCFO
oM9X1DrsktbbXwYhmY55OdwBnnSUD+WYp9D2vQIlfgsdYTlAeP2ARh7KP6+KqSvZ
RHWTTnwTBCGm4uSI1NI2e4tGTz3pPhfU0MTRUDpEQXg7OJxKR2RGbOX5cmHvfR32
Tzd5H/azegPOg2NFA3qrADjHC93Ce0YSRYwdrPazfVhlQMhcqbuHdR3CDCuidWlS
M3ZQ0SiyZjTws39+sSRXUBtIAU5AXiBXDTTTXWzKnx1LqowEPeQ+4Awsp1E5mrdC
mBRhgvhiVNrIdo889JV+8nyP3pIvuOIaHZKn/IPsWuk9IaeFukbgjtkanXrxWdtS
ESPpqhACh8L5aZQhre1UGCAtCD7xCdWShvcR9TDoyk7h13A4swLf9yrorY/6hyva
pGkeBoVTMWTrjXth/C6DkPy7jTWUvAd7dMrXHVVSIyJvLVPZQEg=
=uiXw
-----END PGP SIGNATURE-----

--TwPkolQPsYw8vzno--
