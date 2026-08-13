Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAA943F0B4
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609536; cv=none; b=LgCqdWVhXsg4npTsISiWj4qzJ3eqadMrdJg5xURV/X/LqlCykmpwGr9CTF3BuXbhzzifxJ5vXSs5bEMPxi4RMDhRd1jly0RVjXbhvxgeYrIzfKpvl3MBaGs3RjqKNFXOJrxI4ySwsWrpvXbYj37PawZ4TIsFWRNb4BdOSvHjSUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609536; c=relaxed/simple;
	bh=AaNcimAS6SeLXGEV1UB3ekaAZwJQtjZfzsrp1/Yn4SE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZfgunPKphd8jI0YV2XZALen3eUg+nyt8uXuaQ86BIZPQAC7yD0BHQzorI2dELqv+wTnP6CTwcMU5zcj7HuBbfEMiRqgqus/pgxb0Erejua69b42ISKg6ms02LNmjZuCdDhSI3ysqBPCObGouSNt5dk76efQSyB3itYIV+LZwvkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=EhMDpbjK; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="EhMDpbjK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786609529; x=1787214329;
	i=johannes.schindelin@gmx.de;
	bh=/kVFn3FdXRZ/u+B51kFJrbrLrfn3icEj7pdbW98IpDA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EhMDpbjKlIlNt0eFUL5fIOZ5PQFiEFUHmh6rbuxgAkJKdfOUWCk5K0vsYY9/lFxB
	 YiFAkCvXE3dgrWuKMTGSxlzYoWg3+WlhirP+YZpV/CYE95jZQjmfY5pVB24Z6xWiQ
	 oBYBTxd4Pv/ZdoGgXgb2R0mQPr+vDj+gZEOj4j30RpPwDnldMojrcxGNYENUc+U4h
	 Goc/w7NV/oP6Rcv3K2BXiqSvioyqMd10Lr8jrCNIdgbGQL0HnygfOzMIvnoljgvi7
	 yNwvTV6manKsA2JrL5TYrNwDNFyPzBVuy9Ba0TaaMLw0Kk/pUjtcmPW2+YRPnxwiT
	 eWEBpZjrUXMyPhGU5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59C2-1wtKI82J7M-007ViS; Thu, 13
 Aug 2026 10:25:28 +0200
Date: Thu, 13 Aug 2026 10:25:25 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
cc: Junio C Hamano <gitster@pobox.com>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] packfile: fix perf regression with many packs
In-Reply-To: <20260812212955.GA152730@coredump.intra.peff.net>
Message-ID: <ed5c651f-648f-f58c-bbd3-3db295515913@gmx.de>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com> <xmqqfr0jw20t.fsf@gitster.g> <20260812212955.GA152730@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:1xWsT8KEegCNycGInozbKME5NB5vF+KYmqMipy6kQY7MX8kpz1T
 T8/VYlyjcrDeYZ4r3UIGLi1SRLaIEOv2C6CDcuN5F5fWLLkB154XtMPoxhInunDSI2/V9I6
 qWp4kKwLONu2ya+2pEZtESfdnp3qAqw1s8aqkThoHoDnEFoVrAOA4zUIxW+c5V4vuuP2Cwp
 bIS/6Rvv1r9V5pEE5382g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rZOe0Kc3Ois=;RN34MY1xaNPA71yUzoYwvghT4W9
 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
 265aL1OqxsMxwFaVU3R/wItuX3XZlsegUBts0=
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Wed, 12 Aug 2026, Jeff King wrote:

> On Wed, Aug 12, 2026 at 12:51:30PM -0700, Junio C Hamano wrote:
>=20
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> [...]
> but...
>=20
> > > --- a/t/perf/p5303-many-packs.sh
> > > +++ b/t/perf/p5303-many-packs.sh
> > > @@ -141,4 +141,8 @@ test_perf "load 10,000 packs" '
> > >  	git rev-parse --verify "HEAD^{commit}"
> > >  '
> > > =20
> > > +test_perf "abbreviate with 10,000 packs" '
> > > +	git rev-parse --short HEAD
> > > +'
>=20
> ...I wonder what value this is adding. It shows the same slowdown as the
> existing test you can see in the context (and whose results I showed
> above).

I do think that there is value in adding this. It not only directly
reflects what GIT_PS1 runs, but it also exercises a subtly different path:
`--short` has to look for the unique abbreviation, whereas `--verify` can
stop as soon as it found the OID already.

Ciao,
Johannes
