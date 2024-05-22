Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE608062B
	for <git@vger.kernel.org>; Wed, 22 May 2024 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375497; cv=none; b=pKSFk7anbQmfKdwWIAiklrMEh1/NHjXKRsRLkDcm7qUNq1e0VidkoGPHY4VZzUJUQSbqJk+Trbie/k+xq4eG3s4kuSalJc5wEQsD3lsXTlpC6E+y0DcVnfFnAsjGXvSzv5+Yta80jwDR/NQHUtb7wSvBdHVWxqni/wFAHP9SW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375497; c=relaxed/simple;
	bh=U6Baw+E5AiC0JLrabxVvJomm/93vT5z5UDorS5Tz1fk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xsj/ijMu4HopJ5Ye/XQRNsugFwvW4YctCUjUaByWA5kkhdUCOOrKtNCLIdUmU2Zv8bC5F1ryx9b8A8sz79KpcyBYWiWDxfTChC481iKZi+EKCB5rIYyk8nvbPa6R8+qKghp0kTysGRHVhrPZEz0aJbq2/cUJSwckt9Okm7jg1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=icMvTOSi; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="icMvTOSi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1716375493; x=1716634693;
	bh=08F3jr9LbP75QFlUQufJS1HFrf5kUGqS50xSJHc/hpI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=icMvTOSiPKEckhAjmV80k5LymW2vqcI2+H0WipjnHVyVKOtAH8AQNubYUIgPwEW+b
	 AHOtIhSd9xmBP7C1nqW+FP5f/9ewae0098WNhNQ1qB2RxLDHfAnckSQ79FP5Q7fHN2
	 2SAD4TpfSOnx9XJ3aR8It8+nVgp2h9WTY8nL+aed11zqLOYxSrm/1fTu80Y2rqpxIO
	 xsH621+AALVdLr5x027LbVuMcNM4l7gTerrNJBw7YyzZrXg7wPp4OT3KYsK7j4+t+4
	 Al/hGwBRXl4zX1eqt9HZkVSqf7V3SESZ9fBT9vlw7zPdPfE2T7x0QDUgu93s/tBSL0
	 KpEo3YLPBl8Lw==
Date: Wed, 22 May 2024 10:58:08 +0000
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
From: Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setup: fix bug with "includeIf.onbranch" when initializing dir
Message-ID: <D1G4BWOMJD3E.2CNXHMRZQ12FW@protonmail.com>
In-Reply-To: <cf182bb9ee7d4a7eb46e5dbf4f3ef5deb198d823.1716374321.git.ps@pks.im>
References: <D1F5SJ52H4Z0.1NR7M8APRFTOB@protonmail.com> <cf182bb9ee7d4a7eb46e5dbf4f3ef5deb198d823.1716374321.git.ps@pks.im>
Feedback-ID: 1233518:user:proton
X-Pm-Message-ID: 0fe8fb57ad83e90c9aa86a0b70e6198db79b35e4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed May 22, 2024 at 1:38 PM EEST, Patrick Steinhardt wrote:
> It was reported that git-init(1) can fail when initializing an existing
> directory in case the config contains an "includeIf.onbranch:"
> condition:
>
> ```shell
> $ mkdir repo
> $ git -c includeIf.onbranch:main.path=3Dnonexistent init repo
> BUG: refs.c:2056: reference backend is unknown
> ```
>
> The same error can also be triggered when re-initializing an already
> existing repository.
>
> The bug has been introduced in 173761e21b (setup: start tracking ref
> storage format, 2023-12-29), which wired up the ref storage format. The
> root cause is in `init_db()`, which tries to read the config before we
> have initialized `the_repository` and most importantly its ref storage
> format. We eventually end up calling `include_by_branch()` and execute
> `refs_resolve_ref_unsafe()`, but because we have not initialized the ref
> storage format yet this will trigger the above bug.
>
> Interestingly, `include_by_branch()` has a mechanism that will only
> cause us to resolve the ref when `the_repository->gitdir` is set. This
> is also the reason why this only happens when we initialize an already
> existing directory or repository: `gitdir` is set in those cases, but
> not when creating a new directory.
>
> Now there are two ways to address the issue:
>
>   - We can adapt `include_by_branch()` to also make the code conditional
>     on whether `the_repository->ref_storage_format` is set.
>
>   - We can shift around code such that we initialize the repository
>     format before we read the config.
>
> While the first approach would be safe, it may also cause us to paper
> over issues where a ref store should have been set up. In our case for
> example, it may be reasonable to expect that re-initializing the repo
> will cause the "onbranch:" condition to trigger, but we would not do
> that if the ref storage format was not set up yet. This also used to
> work before the above commit that introduced this bug.
>
> Rearrange the code such that we set up the repository format before
> reading the config. This fixes the bug and ensures that "onbranch:"
> conditions can trigger.
>
> Reported-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

I can confirm it's fixing the issue. Feel free to add:

Tested-by: Heghedus Razvan <heghedus.razvan@protonmail.com>

