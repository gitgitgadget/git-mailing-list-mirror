Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222631DFFE
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708392168; cv=none; b=qtsjW0v+1+tu9Lu/ErlMlZSjGRupFD1X6jbiHFi5UYyYs9bWE7n2IFikRQ7VHnF1yOJ1HmXTm1W/Ye9ffb0CZGkkGO5SnrvLSRo5v5RyTQ+dcPjoS1qiiba63vPfRbNWRg+a5iHQjpg5g+NG1y1Vpy1Wd6qWmBFbvPfTbeV8TY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708392168; c=relaxed/simple;
	bh=48Crpw3giws8JL/Iwp97Gsn4y+wgdt1fbIsBiUA5jL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K5kCgORC1GsJFpa03PSJkWCyGa6yIqUSyoGZ1lP1umOX5dAInvQnTRW/9T/VVsoI+HZCYqNUhCy1XPFGSlrB3t9tZ2i21+2gevwUdVzNUkUbq9buT/8RvtHitDAdlOcExCLmTtnOwwzmzPPj7RxD2TSRIb8KsCawf9MmuNgnkI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y/qhSVNR; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y/qhSVNR"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EE3B41D4806;
	Mon, 19 Feb 2024 20:22:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=48Crpw3giws8
	JL/Iwp97Gsn4y+wgdt1fbIsBiUA5jL0=; b=Y/qhSVNR91iT9g0wh7fQt2IsNDrf
	HDWroOmMY0vlBoEb4IrJHVAL5O2kt1A1oauxlx2hRI4f9OGdSCKJp9Z8ZHVr/rSQ
	tz/7kePUtLUv5SHzawvnVJM2hlTEuoSWBxKqd62vL+K6PUk0Xo7VElXoBr9CO2oO
	dwwZQHB8/8ht8N0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E71421D4804;
	Mon, 19 Feb 2024 20:22:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 57B9B1D4803;
	Mon, 19 Feb 2024 20:22:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marcel =?utf-8?Q?R=C3=B6thke?= <marcel@roethke.info>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] rerere: fix crash during clear
In-Reply-To: <20240218194603.1210895-1-marcel@roethke.info> ("Marcel
 =?utf-8?Q?R=C3=B6thke=22's?=
	message of "Sun, 18 Feb 2024 20:46:03 +0100")
References: <20240218114936.1121077-1-marcel@roethke.info>
	<20240218194603.1210895-1-marcel@roethke.info>
Date: Mon, 19 Feb 2024 17:22:43 -0800
Message-ID: <xmqqplwsx730.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8C734FDA-CF8E-11EE-96BE-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Marcel R=C3=B6thke <marcel@roethke.info> writes:

> When rerere_clear is called, for instance when aborting a rebase, and
> the current conflict does not have a pre or postimage recorded git
> crashes with a SEGFAULT in has_rerere_resolution when accessing the
> status member of struct rerere_dir.

I had to read this twice before realizing the reason why I found it
hard to grok was because of a missing comma between "recorded" and
"git".

> This happens because scan_rerere_dir
> only allocates the status field in struct rerere_dir when a post or
> preimage was found.

But that is not really the root cause, no?  Readers following the
above text are probably wondering why the preimage was not recorded,
when a conflict resulted in stopping a mergy-command and invoking
rerere machinery, before rerere_clear() got called.  Is that
something that usually happen?  How?  Do we have a reproduction
sequence of such a state that we can make it into a new test in
t4200 where we already have tests for "git rerere clear" and its
friends?

> In some cases a segfault may happen even if a post
> or preimage was recorded if it was not for the variant of interest and
> the number of the variant that is present is lower than the variant of
> interest.

Ditto.  What sequence of events would lead to such a state?

The answer *can* be ".git/rr-cache being a normal directory, the
user can poke around, removing files randomly, which can create such
a problematic situation", and the reproduction test *can* also be to
simulate such an end-user action, but I am asking primarily because
I want to make sure that we are *not* losing or failing to create
necessary preimage files, causing this problem to users who do not
muck with files in .git/rr-cache themselves.

Thanks.
