Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C43813BAEE
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732922029; cv=none; b=KhTZFo4zTLyWx6aRVB5SKpoS18nnxtJRCtc0HeD6yIM5YbIT7dANp+deDFNdjLI9ni1QIs897P1UxSs9FMxmshQ7Ybx7ZuI9xJW481wFz1J/edcnrOQDKtCxZGbxWzmK1nSYd9KJuYEqJSXoPpBW7kTufobaNUkjQsQYHOqo7w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732922029; c=relaxed/simple;
	bh=GEuyYiSR5jMlv69NCEvOsFZK4RYP6+7LCZsdycdiEbw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4MM/WydGJWLM2l+MRaqWhLkeZgDN0OyZ4DKTWScLI7o9hKTx9wDbhZbWIUHgVWjssa8c2xe6Ot64tFvsI2zqU446Zw/gwU51x8V78wNC/uxyf0GkPoRgvdJ5W43oCIgATwFeRxcEZsqJakMW70CcjeB49wRqXsFbj5x6SEk5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=BRCcM4rt; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="BRCcM4rt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732922025; x=1733181225;
	bh=GEuyYiSR5jMlv69NCEvOsFZK4RYP6+7LCZsdycdiEbw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=BRCcM4rtNSo7FbbKHtJ2WybjTm7fxYUY2XRV+Xf/EKf3pKTvx5hVLK/PYTQ8y3zh7
	 m/QSegYAo5tcPuw4taqjBew7fLF8uCw0Y9w04KxXAkMz6VYfI/PRYSXjUg6SzGsv8M
	 JX9DYlXg/hVOLPsD8dpyN9IZD080sQfBbre3j2Zc7p5Ciwd6mocAf5zkm07KgeMogq
	 AU6g5Lbog5LixA6R6Bjs8s135Kz3BnjqLv8ar7+6XDlYESwWQHA/MNsWOcC+n3AECG
	 4e8+S+k8rlgN6HldJoSiVTfXidv8Lctvp/VOlM6HzwvLywzcAsLjlAr8HPu74xkwQc
	 WOMwUSGRjUnOg==
Date: Fri, 29 Nov 2024 23:13:41 +0000
To: rsbecker@nexbridge.com, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: 'shejialuo' <shejialuo@gmail.com>, 'Junio C Hamano' <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Ensure unique worktree ids across repositories
Message-ID: <D5Z1L479JERN.80KZ7NA9BWNJ@pm.me>
In-Reply-To: <00c401db42b1$99c4d5a0$cd4e80e0$@nexbridge.com>
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me> <00c401db42b1$99c4d5a0$cd4e80e0$@nexbridge.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 6d59d42e0cea75558f31f8edd3b60f4365691263
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Nov 29, 2024 at 4:54 PM CST, rsbecker wrote:
> General comment on this series: Is there a mechanism of preserving existi=
ng
> functionality for those of us who have existing scripts that depend on th=
e
> existing branch and worktree naming?

Existing worktrees will continue to work as they do now. The only change
is the worktree id for new worktrees. However, there's not an option to
preserve the existing behavior for new worktrees (nor do I think there
should be).

As stated in the v1 threads, the worktree id is already not guaranteed
to be equal to the worktree/branch name (there's several ways that this
can occur), so it's buggy behavior for scripts to make this assumption.
Any script that needs the worktree id should be parsing it from the=20
`.git` file, `git rev-parse --git-dir`, or (with the changes in this
series) `git worktree list`.

Best,

Caleb

