Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985914038C
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709822; cv=none; b=NnQKaezgHQFiSzPsCwMpW9mLT0ARP9Gi2Kd6ZwIphdiwCCguiA36YINjLNsIPDFBKoJwaWnUmBC1M4EdJ3BViEb97qnizDybJakdIm2a2omqX7auKpqdgOCqD74Ica4A+jOQt5b5MT+5gc9B2+gm7kbwnsjPk0EAtrXfaKoFZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709822; c=relaxed/simple;
	bh=KR1iCwPSH7DybW4/k14c0tQIetDbqWzWIsZuFSTl6l4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RWafcywTAEjOtKvXLvpfdrIWEj5EN1OSxtgOyl1oYZDsA0KSMqZQjgWHvZIcsJ39DVNIedT+R/9wcPPIPJaN8iBeJY83exi5m1Ya5LeOumdz+sp6ccTP49fV9/b/Dt2Jy19PTjAxabhm1hYqkHLJWnPq7iFyihJ01B0pkaeMtDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uQxG5NJV; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uQxG5NJV"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AD279228A3;
	Fri, 23 Feb 2024 12:37:00 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KR1iCwPSH7DybW4/k14c0tQIetDbqWzWIsZuFS
	Tl6l4=; b=uQxG5NJVOxYb3/WN6GtV7PmCompcPf8UOBBEbZTSZkZkNOb7V1qWZ8
	L0GppRdqITlPYafK9xabgqxfhChQyHGnIbP09sSeD30RYoY3Zbz2Pmke3OreTHtY
	YGarsW6UvQlE3W1Z4BRpSJw7N2P5X9ea9mUSzwggcjpFAiFjVlj8w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A4961228A1;
	Fri, 23 Feb 2024 12:37:00 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C55202289F;
	Fri, 23 Feb 2024 12:36:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff Hostetler
 <git@jeffhostetler.com>,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 09/16] fsmonitor: move untracked invalidation into
 helper functions
In-Reply-To: <af6f57ab3e6d61036cd969f5fd9256200313aaa9.1708658300.git.gitgitgadget@gmail.com>
	(Jeff Hostetler via GitGitGadget's message of "Fri, 23 Feb 2024
	03:18:13 +0000")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<af6f57ab3e6d61036cd969f5fd9256200313aaa9.1708658300.git.gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 09:36:55 -0800
Message-ID: <xmqqy1bbuloo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2410C6FC-D272-11EE-B144-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Move the call to invalidate the untracked cache for the FSEvent
> pathname into the two helper functions.
>
> In a later commit in this series, we will call these helpers
> from other contexts and it safer to include the UC invalidation
> in the helper than to remember to also add it to each helper
> call-site.
>
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

Thanks.  The steps in this iteration makes this move much less
confusing to me than in the previous one.  We used to call one of
"handle path with/without trailing slash" functions and then called
the invalidation.  Now the invalidation happens in these "handle path"
functions.

The unexplained change in behaviour is that we used to do the rest
of "handle path" and invalidation was done at the end.  Now we do it
upfront.  I think the "rest" works solely based on what is in the
main in-core index array (i.e. the_index.cache[] aka active_cache[])
and affects only what is in the in-core index array, while
untracked_cache_invalidate*() works solely based on what is in the
untracked cache extension (i.e. the_index.untracked) and affects
only what is in there, so the order of these two does not matter.

Am I correct?

Or does it affect correctness or performance or whatever in any way?
IOW, is there a reason why it is better to do the invalidation first
and then doing the "rest" after (hence this patch flips the order of
two to _improve_ something)?

Thanks.
