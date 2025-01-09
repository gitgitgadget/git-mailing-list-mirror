Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD6218AC3
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430083; cv=none; b=QVZmpIawcHHdrtozJ7C03I9KDl3ncCVvHlRLCDwrQsY+/vCVdnOAEIE2crxRZ34mhxHyhBPeXorR4RHOkPuOZB/LVdvrxVXXj+17SKf0F0rMHsGb/yEXNTWPluq6FcdUciS9aV0bsKUN3w2ng9jKnn/BOHYliyf36FynK9JbuK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430083; c=relaxed/simple;
	bh=YNqTkFCsihrJbxUdoTCF1X8Ur1RoZ862n4JrurvqRVI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JnrWVgbRKdGmFRrahHi6PvaSoBDQzCyIl2Temt6GbdoSD+kn14LKPs5vqYwbm8FDdLmGLjlDNO8MmlHnUog29FDcknTxGmL3kPpe0Y1crSdQUQfCw4omxlEi0d8GYyhhNH5xkjxDTG6dFnoKSeUWQuQ9XAHiGxgY7HgVW8lbURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=LYJlR9x7; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="LYJlR9x7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736430077; x=1737034877;
	i=johannes.schindelin@gmx.de;
	bh=h0pUusZ58FawFnXPjzVnyUOA506kN9BQrYLY6JH0F7U=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LYJlR9x7IZSX4R0lrVrsr7geo8/pLBwmTCBwqbDzjmi+GXb/lRVv7O+caOc5e59C
	 60pnNlB8Voi2DX4irRaTgzx/LGZc83AMcF3FAuOJQTjfDa4lVWBzTUBrKm4K4M65x
	 DSXJ+64f8POZ52sB6igL09Iq3S5G8XaKfXKg5ThS1sFaNz2YIPD2xlWuNF5EL4Mg4
	 bx0ImYzuaFDgZf/6B31ySreI0g/XxQN89D2TT0azZYUVxwjFd8udf1YmALRsPN/CK
	 QjzXj+k2xAqtEwFew+4Scp2cSrLyOka0VcrGR9bgECnxyj2RZOHdoKZ9XzbO0z81V
	 566IbZb+lx14kXVZOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.7]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE6F-1tBCR40OGB-00Y0Oz; Thu, 09
 Jan 2025 14:41:17 +0100
Date: Thu, 9 Jan 2025 14:41:16 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/blame: fix out-of-bounds read with excessive
 `--abbrev`
In-Reply-To: <Z3-vpLHvxoQCTjY1@pks.im>
Message-ID: <02ab59c0-a495-9f96-6323-af73cb483f38@gmx.de>
References: <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im> <c439fcaf-11af-7862-9c3c-18dc0842b57d@gmx.de> <Z3-vpLHvxoQCTjY1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:01guhTJDrx3ivk4sYdE/6EIkxTsyuKVtQyKK1mZJXXEoQ9Idm3u
 X/GmYK5O4BxlZLQUg/TjAl0/ROj9lXQWR8qA9vm8u//AppzNA+OOF7xrIs2U4VaA1iEthg9
 3qra4qzM8Gx4KfQv9QcjlTbZQRhpfur+0V0sxSY6fHImfK5tGJCa8q37xUPqiBzvTXFjeTJ
 g9YzlOt68/Aytxx8kp4iQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I/GDOUi38+s=;wGABU/+t+8va4f1axE5f9kTzjLM
 7GCqv/F3HWyVsKhHAvNDxopz3/mBuSF02Xm69T20CMHEgtRcHUlGRoKMqvEaVq/yfmDJZL5s4
 vUsyspnzpyDwOY+UktOQCPfS+Q1b4AdCL3tD3pERaEIGByIwvavLk/WqmI96dCgb5Wu16ANVi
 qI2Dn6b0pZQrZBcghE4gjWS6r0i317D4cU9I2MfUCqxc2+Xy2Un8SCeeVjQEfiV2ojqZNV1LZ
 10LLtJbnuUDAK+Y4ztnF8uxehBqM+Bv5P6Q4KNqW3stKtAPca4jJY0dxh1aL5a/Y5v4wfIYP/
 ty45qUiSzrSIozWDplIAZPt9ohzy874j2wLgFOtguqHtF3UERyZC36MoOPJl1m0WzkoZyoTmq
 LJ7ABXYDX/S2tuRIpNiLwjhP8n+8qQ6z12cCtSsamsvIACiizD21eT/BQETsQ5fsCCTkdwrJK
 5hEAf/WTQBs59pWILt3vUuSlkKYHZyfsc59k7jLyAgg56LR4Uh5UzE9dGJ4rc+ORUkWO/6aQz
 X2oE1PsyQ6Z3IDUFRndQBfwatxeggKBGAJJi2+LiWI1hevbawb7qPBmz/tmUqnxQlSWK2j/kg
 5pZo9Vs1ChJ8wKPClmdOVoxC/UsUKJbhFCcKxmrVj39ogAnR9gJ53N77459/UXwuIzbd7RVcQ
 9fKrDAN7fr1nF9b+a9Edp1MSr7RwtNQotD8vztqBZZCTiT7RTv3KDT0cYQpbzU6cRONoFQghT
 QJUZkMm/ZVXkic1ms0xy5+5pvMKtvrU92B09JJDk9ZQBGDM8JyPDsIW4uRRvsxklnlGHH0gYQ
 orY2dtjce6XInnMNYAT/4Qu7M74eaMzL/QvyDuwW04yZgQyHpVjZzO4akWwkBQdxvta7/VANH
 aI6qwI41OxifyZKTW2PoJPs2pF8PXaSFOmBPP62KskqCV7e9RCxbZ1Xf5zKueN7oL8dPgUMGj
 u2hdg4XB8v7q/DTGkUX+O2JWn6YKCMwtOLUifSl0kn+NcsucyinaZaJzeygp9B2G0FtwUgXsB
 N2jBEgdZTFvczevUHJIOfRS9FkQRJ/jrvgDvwiAi46rJTpfRTmziZgMvoYQBmxrTkU4FOI34r
 evdbJJwcbZ1FforpDy+W5D3KATALAp
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 9 Jan 2025, Patrick Steinhardt wrote:

> On Thu, Jan 09, 2025 at 11:49:43AM +0100, Johannes Schindelin wrote:
> > > diff --git a/builtin/blame.c b/builtin/blame.c
> > > index 867032e4c16878ffd56df8a73162b89ca4bd2694..ad91fe9e97f90625dd27=
08fbd44bf2dd24a337a6 100644
> > > --- a/builtin/blame.c
> > > +++ b/builtin/blame.c
> > > @@ -475,6 +475,8 @@ static void emit_other(struct blame_scoreboard *=
sb, struct blame_entry *ent, int
> > >  		char ch;
> > >  		size_t length =3D (opt & OUTPUT_LONG_OBJECT_NAME) ?
> > >  			the_hash_algo->hexsz : (size_t) abbrev;
> > > +		if (length > GIT_MAX_HEXSZ)
> > > +			length =3D GIT_MAX_HEXSZ;
> >
> > This causes a subtle change of behavior because there are a couple of
> > conditional code blocks between this change and the `printf()` call
> > decrease `length`, i.e. specifying values larger than the maximal hex =
size
> > causes potentially-desirable, different behavior (and think about
> > https://www.hyrumslaw.com/).
>
> Alternatively we can move this until after we have done the
> subtractions. Then we don't have to do weird gymnastics.

Or we can even avoid assiging a maximum altogether:

		if (length < GIT_MAX_HEXSZ)
			printf("%.*s", (int)length, hex);
		else
			printf("%s", hex);

Or be more consistent with Git's source code style which often prefers
ternaries, favoring succinctness over readability:

		printf("%.*s", (int)(length < GIT_MAX_HEXSZ ? length : GIT_MAX_HEXSZ), h=
ex);

> > >  		if (opt & OUTPUT_COLOR_LINE) {
> > >  			if (cnt > 0) {
> > > @@ -505,7 +507,7 @@ static void emit_other(struct blame_scoreboard *=
sb, struct blame_entry *ent, int
> > >  			length--;
> > >  			putchar('?');
> > >  		}
> > > -		fwrite(hex, 1, length, stdout);
> > > +		printf("%.*s", (int)length, hex);
> > >  		if (opt & OUTPUT_ANNOTATE_COMPAT) {
> > >  			const char *name;
> > >  			if (opt & OUTPUT_SHOW_EMAIL)
> > > diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> > > index 0147de304b4d104cc7f05ea1f8d68f1a07ceb80d..fcaba8c11f7ede084e06=
9eefd292f337e8396cb4 100755
> > > --- a/t/t8002-blame.sh
> > > +++ b/t/t8002-blame.sh
> > > @@ -126,6 +126,10 @@ test_expect_success '--no-abbrev works like --a=
bbrev with full length' '
> > >  	check_abbrev $hexsz --no-abbrev
> > >  '
> > >
> > > +test_expect_success 'blame --abbrev gets truncated' '
> > > +	check_abbrev 9000 --abbrev=3D$hexsz HEAD
> >
> > This is actually incorrect: it passes `--abbrev=3D$hexsz` instead of a=
 value
> > that needs to be truncated.
>
> Oh dear. The test did manage to catch the bug, but thinking more about
> it that was only because my initial fix was broken.
>
> > diff --git a/builtin/blame.c b/builtin/blame.c
> > index ad91fe9e97f9..5b4976835066 100644
> > --- a/builtin/blame.c
> > +++ b/builtin/blame.c
> > @@ -475,8 +475,13 @@ static void emit_other(struct blame_scoreboard *s=
b, struct blame_entry *ent, int
> >  		char ch;
> >  		size_t length =3D (opt & OUTPUT_LONG_OBJECT_NAME) ?
> >  			the_hash_algo->hexsz : (size_t) abbrev;
> > -		if (length > GIT_MAX_HEXSZ)
> > -			length =3D GIT_MAX_HEXSZ;
> > +
> > +		/*
> > +		 * Leave enough space for ^, * and ? indicators (boundary,
> > +		 * unblamable, ignored).
> > +		 */
> > +		if (length > GIT_MAX_HEXSZ + 3)
> > +			length =3D GIT_MAX_HEXSZ + 3;
> >
> >  		if (opt & OUTPUT_COLOR_LINE) {
> >  			if (cnt > 0) {
>
> How about this instead?
>
>     diff --git a/builtin/blame.c b/builtin/blame.c
>     index ad91fe9e97..f92e487bed 100644
>     --- a/builtin/blame.c
>     +++ b/builtin/blame.c
>     @@ -475,8 +475,6 @@ static void emit_other(struct blame_scoreboard *=
sb, struct blame_entry *ent, int
>             char ch;
>             size_t length =3D (opt & OUTPUT_LONG_OBJECT_NAME) ?
>                 the_hash_algo->hexsz : (size_t) abbrev;
>     -		if (length > GIT_MAX_HEXSZ)
>     -			length =3D GIT_MAX_HEXSZ;
>
>             if (opt & OUTPUT_COLOR_LINE) {
>                 if (cnt > 0) {
>     @@ -507,6 +505,9 @@ static void emit_other(struct blame_scoreboard *=
sb, struct blame_entry *ent, int
>                 length--;
>                 putchar('?');
>             }
>     +
>     +		if (length > GIT_MAX_HEXSZ)
>     +			length =3D GIT_MAX_HEXSZ;
>             printf("%.*s", (int)length, hex);
>             if (opt & OUTPUT_ANNOTATE_COMPAT) {
>                 const char *name;
>
> In that case there's no need to juggle with the magic indicators, which
> makes it a bit easier to reason about.
>
> > diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> > index fcaba8c11f7e..71fa70a64679 100755
> > --- a/t/t8002-blame.sh
> > +++ b/t/t8002-blame.sh
> > @@ -127,7 +127,7 @@ test_expect_success '--no-abbrev works like --abbr=
ev with full length' '
> >  '
> >
> >  test_expect_success 'blame --abbrev gets truncated' '
> > -	check_abbrev 9000 --abbrev=3D$hexsz HEAD
> > +	check_abbrev 9000 --abbrev=3D9000 HEAD..
> >  '
>
> This should be `check_abbrev $hexsz --abbrev=3D9000`, shouldn't it?

I kind of liked the idea to keep the same cut-off threshold for the
validation. But I won't insist. The construct is obtuse in either case ;-)
(Not your fault, of course, you merely imitated existing code, which is
the correct thing to do).

Ciao,
Johannes
