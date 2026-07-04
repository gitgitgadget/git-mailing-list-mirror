Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14809390204
	for <git@vger.kernel.org>; Sat,  4 Jul 2026 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783155527; cv=none; b=r0ksR0uUkSJY/tBn4fLqh3REQMjRhfxo/of2Kstzy9CpuUQpHxaL2Iiuw5UadoKsgNd5Mz0JYCeyqKTX69x9Xp1sOk6Nku4u2gfMcQ20dGywsDkxIskru8aOP4iyj/8yXknkEZn0F1YxMpHZFBOQWD3NmOO0Fcu0cBfT3iTTAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783155527; c=relaxed/simple;
	bh=ZxX1VkVIhjDW42jJ4rv5L+4GDU9+Nzvr5Whrc6olDKc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IJKz5BBcChgOwYYsqfik1xm1jYvYbjvipEFRLgkWYggohd50QKLZJ8JhVP37FCNlwVYS/dxiwzLI3M0SQfEYSHQUnkcM6OhrR9bGCuHtX+nsgf1Al+LLekjyKv7rWSECKydtRKwFMHG7CUrSW/6/P+NUGK0n6gUFglvJhV2j15o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=uSaDxbLY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="uSaDxbLY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783155524; x=1783760324;
	i=johannes.schindelin@gmx.de;
	bh=A03UCu4TcRzo3zT7fwtVVBXxWnhNWrZ5GBH8697N5SI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uSaDxbLYGk/X3VSlfSbaNApUrGsbi4JNf03Ofk5PQ9c1xKvyWpKUKUSA9hp041Ec
	 Zbyg3cXcWGTL3DFZGXNNYhkJBKdOBZBAk3tnV+Z+8yU3HOP/BMnl2LQAEQYc3hohW
	 tHJ4bfVEcMQfCzoDxwhNLI2KB872/xx7PrfgqRJ/snkH66BcpMMgOgCMQAbZps9Z8
	 pqhVI/sz7MHgBnKn+VaYBpI5YGQZDo0Je6njWBTy2L4hQ6C9/dnq3d8QwIpZDlvEV
	 nVdJMwYtwsmER+0fDyKuOxTE7i6LyYnAoj2r8kevZpUrl0WTUWUDiH3491oVd4hnU
	 g4HP9LRg0mq28BsvGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1xAa7n3Zxo-015Lvs; Sat, 04
 Jul 2026 10:58:43 +0200
Date: Sat, 4 Jul 2026 10:58:45 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 01/13] load_one_loose_object_map(): fix resource leak
In-Reply-To: <xmqqcxx6pths.fsf@gitster.g>
Message-ID: <9dd7e482-5a4d-b75d-56a4-2c422cbd8812@gmx.de>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com> <17242c249f0beb387fd30634663f13ce42d34f79.1782889472.git.gitgitgadget@gmail.com> <xmqqcxx6pths.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:vwCnOIcozJg3gNCupLbfosblJUSiIFcmKCJK9c8rPsw0fpJ80MV
 HUOa1Kock2DI1MiPKUCDCTceDhDGepAh9oQcv/GUGVFtAbyKe1hB+1UOpTYt6DJaLd74oO4
 0k9MKort4V4qFlYH4KPDMfjdTFDuz78owOd0ZeSXnv2kqlbKXmoMXS0T00vIZTIWzDu41ut
 7wRhL1ZtPX9x3W0a4cszA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3SaZTYdbiRI=;c4nkbyUl9pP748OOSPptS848a3B
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 1 Jul 2026, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > +	ret =3D 0;
>=20
> Or we can do
>=20
> 	ret =3D ferror(fp) ? -1 : 0;
>=20
> if we want to be sure that we have caught all the errors.

Agreed; that is what v2 will use.

To corroborate the diagnosis: `strbuf_getline_lf()` ultimately calls
`getdelim()`, which returns -1 on both EOF and I/O error, so `ferror(fp)`
on the underlying stream is the only reliable way to distinguish the two.
That also makes the `errno =3D 0;` I had added at the top of the loop dead=
,
so it goes away in v2.

Ciao,
Johannes
