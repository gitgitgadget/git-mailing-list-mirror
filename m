Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9B1E864
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151907; cv=none; b=JrIpQYoE+aJqIB8he95SsbIj3i4ZRTMqka2yRNjFMoPwYA0/HfrCXWzxVE3ujyD3NwEevr8f+lHSi/yqZnenP7sco7plTqnXmQv7o9U7BjncL38lE/BVApjajrZvz95BPzjf+UU5gFQO6k7KKt0N/4QPHIsMkIqTn5djyeTXVbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151907; c=relaxed/simple;
	bh=73ZyQ7VrE4Ythd2bjfdusjctTu7ZlsaQgMhO76j1O0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P40IWH07AtqtPvYOC3Ff3Hb+dLXShheiPoYe+UY/yw7rQRejkBvGmOezU4CLa8T3kHHG7wml+S6fKlUAieVEu1OSNC7G5yI8SO40eET9Hnz/v7R8YXfb+8ee6H4HRqbCJl/QsII66SHfohscDZ2lSypjaTIm4xDp5F8JXbVI+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FVJ7NXis; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FVJ7NXis"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 435C32DC9E;
	Wed, 28 Feb 2024 15:25:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=73ZyQ7VrE4Ythd2bjfdusjctTu7ZlsaQgMhO76
	j1O0o=; b=FVJ7NXisAys11/h+wGYdwfwXhnJ0OdhP2StpaG8hUbgbthhOykzJju
	Hd82D3HYMdo85iAC0lrgd6CpPkDna8/Grwih7eo79MRt8qMROpLNI20PrCZBnl3L
	XTygD//3fst4ZdNGEBOMor9Yp+TpCRrfawwuea8J0zMJdloHKgfYk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A8BE2DC9D;
	Wed, 28 Feb 2024 15:25:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9BE9C2DC9B;
	Wed, 28 Feb 2024 15:25:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Dirk Gouders
 <dirk@gouders.net>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 04/11] commit-reach(paint_down_to_common): prepare
 for handling shallow commits
In-Reply-To: <837aa5a89c640427a5de064da93f1de4934d8212.1709113458.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 28 Feb 2024
	09:44:10 +0000")
References: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
	<837aa5a89c640427a5de064da93f1de4934d8212.1709113458.git.gitgitgadget@gmail.com>
Date: Wed, 28 Feb 2024 12:24:59 -0800
Message-ID: <xmqqedcwjq04.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 732847DE-D677-11EE-8342-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When `git fetch --update-shallow` needs to test for commit ancestry, it
> can naturally run into a missing object (e.g. if it is a parent of a
> shallow commit). For the purpose of `--update-shallow`, this needs to be
> treated as if the child commit did not even have that parent, i.e. the
> commit history needs to be clamped.
>
> For all other scenarios, clamping the commit history is actually a bug,
> as it would hide repository corruption (for an analysis regarding
> shallow and partial clones, see the analysis further down).
>
> Add a flag to optionally ask the function to ignore missing commits, as
> `--update-shallow` needs it to, while detecting missing objects as a
> repository corruption error by default.
>
> This flag is needed, and cannot replaced by `is_repository_shallow()` to
> indicate that situation, because that function would return 0 in the
> `--update-shallow` scenario: There is not actually a `shallow` file in
> that scenario, as demonstrated e.g. by t5537.10 ("add new shallow root
> with receive.updateshallow on") and t5538.4 ("add new shallow root with
> receive.updateshallow on").

Nicely written.

The description above that has been totally revamped reads much much
clearer, at least to me, compared to the previous round.  

Should we declare the topic done and mark it for 'next'?

Thanks.
