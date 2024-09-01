Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AEB1DFD1
	for <git@vger.kernel.org>; Sun,  1 Sep 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725205377; cv=none; b=JiP+0ueZfBAHxOduFjqq7SZu2P7K7f982IOUZNtGbikMKtflPGODTmmnovwh9PoXvQDZld7+okociO05r4Wd85tRQqGDMV33eoc/pcg51dfKjofevp5VNeoLFIxx7g1HzRc47oeqGt3Z5Jc/12Y8c6CDKKvfYcRMWhRormQrQyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725205377; c=relaxed/simple;
	bh=NZsGXz7hszfoYYtZpOO/FremDDtxNvBefYc4Ns+ThGE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JK3oa4zXPZhSHuki4VbDcTsaSKbly9oIyLdejwLOVDa/39YZYxVns+bG3yIG5A7tjeau5F/3aVTR1ka7hQlETudaqN3YQtWPexg51uej37AHjfQwmJAsT/1Fijt/B00K15V9hyJ+/Bf03UoLtBrU8zjwa5cKaSAOfDEVr5DxRrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xtbXE8Wk; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xtbXE8Wk"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BAC0181FA;
	Sun,  1 Sep 2024 11:42:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NZsGXz7hszfoYYtZpOO/FremDDtxNvBefYc4Ns
	+ThGE=; b=xtbXE8WkaMN269aJXWKOpA44VEYgJS022z62ITL8FVkhJTK7QeSLCT
	S+E4RsCB5NfMmA3I1B4G4QzFrV6bHB8TUbPrHN2hgnK/Y+PUSEFZNs0zc83rKlp2
	A/ieUBosVp2F8O9H9MYYSSLUTWECpbN/KnIxj19R+Qfozfh4N4hS0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 64039181F9;
	Sun,  1 Sep 2024 11:42:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C8074181F8;
	Sun,  1 Sep 2024 11:42:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Han Jiang <jhcarl0814@gmail.com>,  git@vger.kernel.org
Subject: Re: `git rebase (--no-fork-point) --onto=<newbase> [<upstream>
 [<branch>]]` leaves HEAD detached and *HEAD not moved when <branch> is
 exactly `HEAD`
In-Reply-To: <61a4fcc1-1dd8-48a4-a1d4-0201232c9b26@gmail.com> (Phillip Wood's
	message of "Sun, 1 Sep 2024 16:26:27 +0100")
References: <CANrWfmSY1F4UB2QSjN8XKY7Kwx6FL8SOrz_OadZ4u8XYDpZfBg@mail.gmail.com>
	<61a4fcc1-1dd8-48a4-a1d4-0201232c9b26@gmail.com>
Date: Sun, 01 Sep 2024 08:42:52 -0700
Message-ID: <xmqq1q23pegz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DA398670-6878-11EF-A5E7-9B0F950A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> "git rebase <upstream> <branch>" is designed to switch to a different
> branch before rebasing it. If you do not want to switch branches you
> should use "git rebase <upstream>".

Correct.

> "<branch>" is expected to be a
> branch name, not a symbolic ref to the branch like "HEAD".

I question the correctness of this, though.  The "what to rebase"
argument can be any arbitrary commit-ish, and if it is a name of a
local branch, that branch is rebased.  If it is not, the HEAD is
detached and that detached HEAD state is rebased.  The latter is
handy when you are unsure if you want to really touch the branch.
i.e. "git rebase master topic^0"---this way you'd end up on a
detached HEAD that shows what would happen if you really rebased
"topic" branch, but if you do not like the result, you can just
discard the state by e.g., checking out some branch, and you do not
even contaminate the reflog of the "topic" branch with the record of
this failed exeriment.

I have a mild suspicion that the "rebase" command might have changed
its behaviour since the days back when it was implemented as a shell
script, when the "what to rebase" argument is HEAD, as the most
natural implementation to do this "optionally first switch to it
when the argument is given" in the scripted Porcelain is to actually
run "git checkout HEAD", which should be a somewhat noisy no-op.
Apparently today's "git rebase" does not work that way and seems to
detach HEAD instead and then rebases it.  As you said, that is the
behaviour most users are familiar with and it is probably too late
to change, even if (I didn't check) an ancient version of "rebase"
did not work that way and instead rebased the current branch.

Thanks.

