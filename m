Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6913517EBA9
	for <git@vger.kernel.org>; Tue, 14 May 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701960; cv=none; b=jzBARzKc9o8BojyFnAsQZxNTahR/hNdsXK5QR5k0N8ErG/cPNut2U7Iukaj0Ez3W5UcK6aI57wekr4I8GTSJ1B/VGtbetHvmJVFwUS10RWVU4A1Yg2sIWRScyeu/CWyL1r/yo6DLLLLB9lkgttHbxy6CIdUOiOBxXtJ75Pgzisk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701960; c=relaxed/simple;
	bh=ArJdx6odIeYDm8kMX7eTGJqsv1rwkbVP88TBT2X2wf0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=InMGQg/8pfCELLdukexsRTu7MVB8QY0LinfIuRt21QPbP3/ohJsw1sh2e+TehPrNXzepY1ji3+f6JKUzWVsrhV/0THHtYU3Q2YyMUa9PYtZoBY3J0p0u6JYhD3bQHq69mLRTZTl3Z1J5iq54s+SyCWFMM7JKcloFcRwteggFwk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=maem9J9I; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="maem9J9I"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C54893D714;
	Tue, 14 May 2024 11:52:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ArJdx6odIeYDm8kMX7eTGJqsv1rwkbVP88TBT2
	X2wf0=; b=maem9J9IwITJf9wnzU6VbuAaAJFuo/aiZ4z9COOY6Fe5k9DdfJXP7C
	5VHMWnrgdXLajXTVelwibPoyJzC9IWuPHJm97SV+QQkY/DlrlGPv4ozwX6pRgaWu
	0cCB7iHJ+uHl7rWU+iWCzk+rXDftHr/fsEovi/PWmg1oWDqUfTE3o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BDBF33D713;
	Tue, 14 May 2024 11:52:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 333703D712;
	Tue, 14 May 2024 11:52:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/5] builtin/patch-id: fix uninitialized hash function
In-Reply-To: <ZkLpN6UaI_jj2zDg@tanuki> (Patrick Steinhardt's message of "Tue,
	14 May 2024 06:31:51 +0200")
References: <cover.1715582857.git.ps@pks.im>
	<20240513224127.2042052-1-gitster@pobox.com>
	<20240513224127.2042052-4-gitster@pobox.com>
	<xmqqbk59cnp6.fsf@gitster.g> <ZkLpN6UaI_jj2zDg@tanuki>
Date: Tue, 14 May 2024 08:52:32 -0700
Message-ID: <xmqqcypo5r27.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FAB9B322-1209-11EF-9D0A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Hmph, in other places I did
>> 
>> 	if (!the_hash_algo)
>> 		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
>> 
>> to find the case where we need a reasonable default.
>> 
>> Is there a practical difference?  If there isn't we should
>> standardise one and use the same test consistently everywhere.
>> ...
>
> To the best of my knowledge there isn't. What I prefer about my approach
> is that it explicitly points out that this is conditional on whether or
> not we have a repository. But in the end I don't mind much which of both
> versions we use.

Ah, that makes sense, and it is quite subjective but makes certain
sense.

The reason I prefered to check "the_hash_algo" is very much the
opposite.  In this particular decision to call (or not call)
set_hash_algo(), we only care if the_hash_algo is not yet set, and
that is why the_hash_algo is checked.

Specifically, we do not care *why* it is still unset; in the current
codebase, the most likely reason why we do not have the_hash_algo
set might be that we haven't found the repository yet, but we do not
have to rely on that assumption to hold true.  It would help
maintainability into the future where the_hash_algo is set already
before we come here when outside a repository, or vice versa.
