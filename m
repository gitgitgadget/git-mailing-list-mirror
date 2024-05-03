Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8690615698A
	for <git@vger.kernel.org>; Fri,  3 May 2024 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754733; cv=none; b=pvsUKjUxGu/cO5aTLQtoKjJXqz9Ku0JhAK8aZh5jiovj+N/lnY6gQWZOZOY21bwTHmcht7ddNMCzVur41xgfCO/koStwNKV4sIgiHBc+DBI1T0eCRfW+xbIrr7WVVXd/BKIhdBMcWFFxR1jG1zbaUUQbuDC2DRa5IVFsJYR0kHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754733; c=relaxed/simple;
	bh=Ife9TyLYbyRVGJqd53pRae0dUUKk6uowx/enE2Aa7pM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M24gzpPvknyVF3aehsNg1vheeynRgR5n69z9Zbw7vYT3g43UYm5IIwIJ8332T5DqOzqU3QLmzbLRLwgjiy5tjN7pf0vsbrwZe+UKHsPzD7R4SnNl5jzO7o5gouikbMb4YnK6e9t/JxgQ5U4re2oX+Fu/BxGzrkkqHaPp1T4F1aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=H4KPRNXG; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H4KPRNXG"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ABA411A542;
	Fri,  3 May 2024 12:45:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ife9TyLYbyRVGJqd53pRae0dUUKk6uowx/enE2
	Aa7pM=; b=H4KPRNXGVu9PgoQpnrScW1Bs4UVnbSO2JxfPrsBeJSG57i6s9SUDMN
	9xURBz0GjX5y/lfsVBjMCBa3saRq48nA+3Qsc48eYHCxaPFLwZZjmdbyfgulASrZ
	xzlfbmm+sKsevaxXYs2aDAS0WeIK/+7HvvU00d1M4XemJGPtgwZgU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A3E571A541;
	Fri,  3 May 2024 12:45:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 73F361A540;
	Fri,  3 May 2024 12:45:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v6 0/7] refs: add support for transactional symref updates
In-Reply-To: <20240503124115.252413-1-knayak@gitlab.com> (Karthik Nayak's
	message of "Fri, 3 May 2024 14:41:08 +0200")
References: <20240501202229.2695774-1-knayak@gitlab.com>
	<20240503124115.252413-1-knayak@gitlab.com>
Date: Fri, 03 May 2024 09:45:23 -0700
Message-ID: <xmqq5xvualp8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8A674A9E-096C-11EF-971B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Previous versions:
> V1: https://lore.kernel.org/git/20240330224623.579457-1-knayak@gitlab.com/
> V2: https://lore.kernel.org/git/20240412095908.1134387-1-knayak@gitlab.com/
> V3: https://lore.kernel.org/git/20240423212818.574123-1-knayak@gitlab.com/
> V4: https://lore.kernel.org/r/20240426152449.228860-1-knayak@gitlab.com
> V5: https://lore.kernel.org/r/20240501202229.2695774-1-knayak@gitlab.com
>
> Changes over v5 are:
> - More user friendly error messages.
> - `create_symref_lock` now writes to an err buf, instead of directly to stderr.
> - Refactor code to make it easier to read around logical operations.

All changes I saw in the range-diff and diff output with v5 looked
sensible improvements.

Will wait for comments and then hopefully we can mark it for 'next'
sometime next week, if nothing happens.

Thanks.
