Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734831FBB
	for <git@vger.kernel.org>; Tue, 21 May 2024 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310000; cv=none; b=se6NEyClZWi+7Z0hjz5Hj/1p21vKKnndDzRh9k2QTVXtwG0cob8r5gT1MoYd8KCLsE4Yny2zeBxVntZT/aEJm2xaxz+xd0iV8p9almUXxQCRr5vAG9cB/4eriMpk0VPDpu6D6o8PLj3memqnYhnfHd43B7sl0zlT1SLW5owkZ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310000; c=relaxed/simple;
	bh=ytguX1Ped2mimmgYz3hRiiu7k7nmzNIrhj4Ez0DZ0F0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BazWqvis/xxaNH69mDTtibDn36ojDSKt8J+z9yQkDe/XomD9aIiNMmG36ICzfNcYJfr7aq8fhJZbUbVasdO6y4f0ldKiapraJ5gT9MCdrNvO6EPVTP5Lm/8ZAKtWKf7AJfLyFeEsDC28uwY/NgdP1murOTcQpKyw+++6uKNpZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=mnpC6PQs; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="mnpC6PQs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1716309990; x=1716569190;
	bh=oe2XSMau/ahln/O43c2PnvSoKAUPcs1wSRYKSSuG2XI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mnpC6PQsTZLlaxoJ3UUp38AcAXbrpnK+P061UQp5blKRw9gZnyppMX/Gb27NC4Mna
	 5vCv8xnZBOx7pZGRWari7tbweJe7s/dZcZcITR0u8jb0qYqKRkhNixdshBA9mSY74w
	 sfflXO/s8D2Hx9PPRGY0kwgIils1CfdszFpJiUY9GUhvZrHzpQHSWcIMHWbWn1EthA
	 lpL9Rv/UCE1kBPqcCUkTZO93xygYq7f6qTagD7PgjHwjlXPNsEfTIic59dJOP1RAQR
	 8+3xAU9yJKs0kAVGavAyGOzYshGGqf491dP3ASlVGE6JLIGdPXYLwSAQAKTcXa73VK
	 8oGICEfiUrl9w==
Date: Tue, 21 May 2024 16:46:23 +0000
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
From: Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc: git@vger.kernel.org
Subject: Re: git init BUG when gitconfig has includeIf
Message-ID: <D1FH40J6URHF.186U29CMRJ0N3@protonmail.com>
In-Reply-To: <xmqqbk4zazqd.fsf@gitster.g>
References: <D1F5SJ52H4Z0.1NR7M8APRFTOB@protonmail.com> <xmqqbk4zazqd.fsf@gitster.g>
Feedback-ID: 1233518:user:proton
X-Pm-Message-ID: 34e0f1dda639e8e22338465f3b20f2720157ed95
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue May 21, 2024 at 7:36 PM EEST, Junio C Hamano wrote:
> Heghedus Razvan <heghedus.razvan@protonmail.com> writes:
>
> > Yesterday I stumble upon a bug when doing git init. I didn't
> > find any references to it, so I don't know if is a known problem
> > or not.
> >
> > Steps to reproduce:
> > # git init .
> > BUG: refs.c:2123: reference backend is unknown
>
> Patrick, this looks similar to an earlier one during "git clone"
> that was discussed at
>
> https://lore.kernel.org/git/72771da0-a0ef-4fd9-8071-6467cd7b6a6b@kernel-s=
pace.org/
>
> that was fixed with 199f44cb (builtin/clone: allow remote helpers to
> detect repo, 2024-02-27)?  The fix was about "git clone", but the
> crux of the fix went to setup.c:initialize_repository_version()
> which is also called by setup.c:init_db() that is the workhorse of
> "git init", so it may already have been fixed (I didn't try).

I guess I forgot to mention, but I tested the current master 4365c6fcf9
and the issue is still present.

>
> Even if it is already fixed in the current version by the same
> 199f44cb, we may want to follow up 0eab85b9 (t5601: exercise clones
> with "includeIf.*.onbranch", 2024-03-12) with an additional test to
> cover "git init".
>
> Thanks.


