Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB91BDA87
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828393; cv=none; b=hle0U2M2ey3cEFrxIsskYAUcTvFwkHkoIlyHseheTigG0BQv7NY8N4g1RC5/1h9XFST2qf6R3hC5MzN31SeJa0i3Wd3MY7Xxo8gtwtfqe70sOOE3uHeAXw2TIsOtjO4t0+d0Rtra8ow8zwOBVAba9SBEJ+R/1/IFQ0Oy4E+MpEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828393; c=relaxed/simple;
	bh=30JQ/Szj857dbFjpiCJr972c5dk410q7d71zH4xrGHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r4aWYLPnyUfC8SBEYRZQk93ehoP2Dz+4gK9zoxIdrTZeshYZvtbOImi+YrcHV9lFHOuRoqDmkaTl21ARulGY76mndGKKg+L3LHhZ3SkzEH8umD50uSJro4oWPtg8x7X/L5jUDA+V7KRy+iVdtWvowqFdpJvf56Xwj0O6Jt6O1f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NY4YGMWx; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NY4YGMWx"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3D442A5CB;
	Fri, 16 Aug 2024 13:13:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=30JQ/Szj857dbFjpiCJr972c5dk410q7d71zH4
	xrGHA=; b=NY4YGMWxC48H/71fhXvB/Q+HvCtGfo9+StQg907S4Zj0mjmjNR9vOw
	IDoKogJRDCXZ8PR2yGe7DLdiXSRTis5QFAbvuw1Oa/N9I1PMmLBVtIj/frfY+1bz
	9etrGfr/C9dxd8vEvzGUIDTxQQjKpaVF00L85CDkgiTlSAnjuXhOI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB27C2A5CA;
	Fri, 16 Aug 2024 13:13:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 264222A5C9;
	Fri, 16 Aug 2024 13:13:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Sebastian Schuberth <sschuberth@gmail.com>,
  Justin Tobler <jltobler@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 4/5] setup: make object format configurable via config
In-Reply-To: <85086620628b1fa136ebf7a1c9e2f64ebdbc7b92.1723798388.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 16 Aug 2024 10:57:03 +0200")
References: <cover.1723708417.git.ps@pks.im> <cover.1723798388.git.ps@pks.im>
	<85086620628b1fa136ebf7a1c9e2f64ebdbc7b92.1723798388.git.ps@pks.im>
Date: Fri, 16 Aug 2024 10:13:07 -0700
Message-ID: <xmqqed6ol7bw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D003AA24-5BF2-11EF-A2CC-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The precedence order now is the following, where the first one wins:
>
>   1. The `--object-format=` switch.
>
>   2. The `GIT_DEFAULT_HASH` environment variable.
>
>   3. The `init.defaultObjectFormat` config variable.
>
> This matches the typical precedence order we use in Git. We typically
> let the environment override the config such that the latter can easily
> be overridden on an ephemeral basis, for example by scripts.

Thanks for documenting this, as the reason for deciding the
precedence between environment and configuration is no longer as
strong as it used to be.

Before the "git -c var=val" happened, the only sensible preference
order was to allow environment to override a configured default by
doing "VAR=val git cmd ...".  In other words, the order used to be
something you could safely forget and still infer the right order
with logic alone.

But with "git -c var=val", even if a hypothetical Git allowed
configuration to override environment, a user could still override
them with "-c var=val", so "environment trumps configuration" is no
longer "because there is no sensible workaround if it were the other
way around", but merely "because that used to be the only logical
way".

