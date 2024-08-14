Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCC91B9B2B
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656455; cv=none; b=puM7xaN4HnNRgQoTaW/AjWcA7NHoY70K6/7XSxuciOhCGOc4FThpXmUQPBmLPzZD+AP1OmxzDZOo7za8RFFBNfDKH8KM+y5LYSgcW5MrZzcUZtA2If6zbgR3OWacZ5dMWaKwqBwWX21NkRodC4qeOhGjDJUwFffBXekT48hU+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656455; c=relaxed/simple;
	bh=sTyhPdryp1kLkXtDQfVRmBBqxl4sOS/CWeHoDUibKBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RcqZZQJR3f33N2AyQj1+4phBM2z1sBWBj+FXFyuZo4G7yxUOaL9jSxANI1M6937QObPvPR7O77nBbygOSRu3/s0i7SEW+hFHotuRp64WN7rXZ5S6AeHv8yd3hTam7xV39PuP8QD9ODtaGbtEdg3mL0bFCMGsHbImHzz/EmPrtwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x82NZtHq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x82NZtHq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9196E18D27;
	Wed, 14 Aug 2024 13:27:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sTyhPdryp1kLkXtDQfVRmBBqxl4sOS/CWeHoDU
	ibKBE=; b=x82NZtHq21loBbd9aQiptnyXGFxQq7UmgegmW83NNYyobzj5kPy5XP
	sC1AleQt3NMDqg9XwKOTT8bGecfJhcF4E3IwWwOI/r+lk0XZqF7GIy20tJp55yVi
	wCzPw8F0hwiULnNCo254NHW/aAAD/1cegQV5OUPYCm4r5GHxf9PHw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8945518D26;
	Wed, 14 Aug 2024 13:27:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EDEAA18D25;
	Wed, 14 Aug 2024 13:27:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Phillip Wood via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Brian Lyles
 <brianmlyles@gmail.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase: apply and cleanup autostash when rebase fails
 to start
In-Reply-To: <b676bd17-1cc8-4639-acb7-675dde32a1ae@gmail.com> (Phillip Wood's
	message of "Wed, 14 Aug 2024 16:59:32 +0100")
References: <pull.1772.git.1723641747309.gitgitgadget@gmail.com>
	<ZrzA0yp45w9NuTp2@tanuki>
	<b676bd17-1cc8-4639-acb7-675dde32a1ae@gmail.com>
Date: Wed, 14 Aug 2024 10:27:29 -0700
Message-ID: <xmqq8qwzypz2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7C4495D8-5A62-11EF-B968-9B0F950A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Applying the stash should not fail because the rebase has not started
> and so HEAD, the index and the worktree are unchanged since the stash
> was created. If it does fail for some reason then apply_autostash()
> creates a new entry under refs/stash. We definitely do want to remove
> the directory otherwise we're left with the inconsistent state we're
> tying to fix.

If it is not expected to fail 99% of times, it feels more prudent to
abort loudly without making further damage to lose information and
ask the user to check what happened in the working tree, rather than
blindly removing the clue to understand what went wrong.  For
example, could the reason why applying the stash failed be because
the user forgot that the working tree was being used for rebasing
and mucked with its contents from say another terminal?

Thanks.
