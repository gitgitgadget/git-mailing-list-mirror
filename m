Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B769917BB25
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006129; cv=none; b=U0ldqYpsGAWyK1UoNhbiBIScICfFkOMJn2Cd3LauzlQPSuW+iq/NJzI3p8UeafzizbACx1NgcNw0+xBVjxEE9JpqfSH2YBwq74szhU65GoWda2+ZcWQvb3xL4GTe/nNSqlCSmyP6mCKMq/78dCQ9PLsYflf1JQu22+qbwwS1Lxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006129; c=relaxed/simple;
	bh=5WmFbi6i/JHmFH1aN+LB0O8SI07ldLLanIQyZya/ZwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=deJu31cZ07Yony5Ml7hVLuwVLOZGyr+J5flTVSxCAhIC6KGIWEpKJRfp7lCcMpssmZh0pRGA9qFd6sVeIKJeakp9hVX/km4sq+PWQpleFiup48BMHqMiIT9pp6rnNkWau/LvG+JAtmyjHpcCk7aXpsQyuAeg2XuaDSpDmkzXKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TODLtD7E; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TODLtD7E"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE6F32FC47;
	Fri, 26 Jul 2024 11:02:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5WmFbi6i/JHmFH1aN+LB0O8SI07ldLLanIQyZy
	a/ZwY=; b=TODLtD7EXdsjYPAR2swaBjUhgwGBRVZtXoAVY1PYc8VGU9GWr/3v+m
	OKnWyvE5OTb7pTwAoWMWyLQ7/45wf407hZL0ia0chdSFYYQGc6ihVkd8/6zlcwkc
	kb9uVet93AE2w+wfhZJIvQP0ICog8cuEh4ONSgI6P/wJ2m0ThbU6E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 538032FC46;
	Fri, 26 Jul 2024 11:02:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 538B42FC45;
	Fri, 26 Jul 2024 11:02:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/3] safe.directory: normalize the configured path
In-Reply-To: <20240726050253.GC642208@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 26 Jul 2024 01:02:53 -0400")
References: <20240720220915.2933266-1-gitster@pobox.com>
	<20240723021900.388020-1-gitster@pobox.com>
	<20240723021900.388020-3-gitster@pobox.com>
	<20240726050253.GC642208@coredump.intra.peff.net>
Date: Fri, 26 Jul 2024 08:02:02 -0700
Message-ID: <xmqqikwsyz6d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 04F40F06-4B60-11EF-B2C5-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> This may be a dumb question, but... will this always work, if the config
> option is not necessarily an exact path, and might have globbing
> characters in it?
>
> We don't currently treat it like a wildmatch glob, but:
>
>   1. We do allow "/*" on the end. Should we strip that off so it doesn't
>      confuse the realpath lookup?

This one I wondered, too, but the test seems to show that it is OK ;-)

>   2. This is shutting the door on using wildmatch or similar in the
>      future. Is that OK?

I am inclined to keep this part and any other logic that are meant
to address "security" things simple and stupid.  So in that sense,
I am not so worried that it would be hard to retrofit wildmatch to
this codepath.

> Should we be quiet there, and maybe fall back to using the
> non-normalized path (though I guess if we could not normalize it, that
> probably means it could never match anyway)?

The only reason I did the warning was because it makes me feel a bit
uneasy to have a configuration item that either gets ignored or
triggers a fallback behaviour and not to tell users about it.  Other
than that, I have no strong preference.

Unfortunately this is not a very good fit for the advise mechanism,
as we do not even have a repository yet.
