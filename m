Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E9E79E3
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336030; cv=none; b=DV6ZjEzTnciVUbjOFNoOrrmlp0iyFa8LxxObd9CFjlpw9TrN5QccjD3GDMPum2GAgY0Tq4DXvIDmviw5W+LGl6vPb6eZ4kAGyJBD7Y98xDZYfS3ZQ8j4x834vMPTFOFw9j8LTbtkkgi+Sum3ok1np2eTMQ8WIavi+J/ZhhC5g1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336030; c=relaxed/simple;
	bh=Fp/IowsPyxqVqqwq4TabDkCnvI3iwQttIhxc6kTPHEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GGDI2YgvSlzStC29pFutVE1+aBWgNEDeAvEd7zuVUXULEvRWdFzCe0h3SAaIWCAeLh/7KlIPFoZAL1jXpcScskCRmiakoOYmu3OtT1A2HiTvwTGWjsEjztPP+zA/Cjk5wLLjzDKrAN8qO9Jz1w5MP6CeXlo6Invv2U3wkTO3qYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=shT9Ivbc; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="shT9Ivbc"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 788A021661;
	Fri,  5 Apr 2024 12:53:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Fp/IowsPyxqVqqwq4TabDkCnvI3iwQttIhxc6k
	TPHEE=; b=shT9Ivbce9p0D8S1C2cWtn4XF7bfOiPuxRKFQmK69I/JVIAvhbrBBu
	DKgbOEy7txblu3t8IlPE0+aTiiVghpc/87SDCUG8xWVawDaXi8O767DcPUy7nUDP
	Yhd3cRgRnMAwwaWU30llakK/xbv1icjFTChJWNSDaotVjRsm2Y/90=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6FD2C21660;
	Fri,  5 Apr 2024 12:53:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E8AFB2165D;
	Fri,  5 Apr 2024 12:53:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] fetch: return when parsing submodule.recurse
In-Reply-To: <pull.1709.git.1712285542303.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Fri, 05 Apr 2024 02:52:22
	+0000")
References: <pull.1709.git.1712285542303.gitgitgadget@gmail.com>
Date: Fri, 05 Apr 2024 09:53:43 -0700
Message-ID: <xmqqbk6nwy20.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 108C5922-F36D-11EE-AC99-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> When parsing config keys, the normal pattern is to return 0 after
> completing the logic for a specific config key, since no other key will
> match. One instance, for "submodule.recurse", was missing this case in
> builtin/fetch.c.
>
> This is a very minor change, and will have minimal impact to
> performance.

True, and the performance impact should be positive, if it is
observable.

Well spotted.  Thanks.

> This particular block was edited recently in 56e8bb4fb4
> (fetch: use `fetch_config` to store "fetch.recurseSubmodules" value,
> 2023-05-17), which led to some hesitation that perhaps this omission was
> on purpose.
>
> However, no later cases within git_fetch_config() will match the key if
> equal to "submodule.recurse" and neither will any key matches within the
> catch-all git_default_config().
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>     fetch: return when parsing submodule.recurse
>     
>     This is a super-nit that I noticed when looking into this config setting
>     and couldn't help but try to fix.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1709%2Fderrickstolee%2Ffetch-config-parse-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1709/derrickstolee/fetch-config-parse-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1709
>
>  builtin/fetch.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 46a793411a4..5857d860dbf 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -138,6 +138,7 @@ static int git_fetch_config(const char *k, const char *v,
>  		int r = git_config_bool(k, v) ?
>  			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
>  		fetch_config->recurse_submodules = r;
> +		return 0;
>  	}
>  
>  	if (!strcmp(k, "submodule.fetchjobs")) {
>
> base-commit: 7774cfed6261ce2900c84e55906da708c711d601
