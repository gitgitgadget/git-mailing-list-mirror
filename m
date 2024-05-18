Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5505D3211
	for <git@vger.kernel.org>; Sat, 18 May 2024 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715991719; cv=none; b=OZRkh8EAootQc7iSnBWkJ4KF+JUTtLIiYwMNkmf9MdKxRwB4hO+o8fTAvMZH33HYsTFQnd0AHKzdIL3r+K62XPgbRNDlo5+6g+bHLGlQk8w6YpjMmSXOJy7x9X//HNslP3ER2I//FSlGxnVwFbe+OXRLjERMesp9AP71WLCiM2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715991719; c=relaxed/simple;
	bh=ocOSm0VpxVjNKPpuKPLsmSMM4iFRqkg5xjWa6lwUU/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eVZ+sqlF2WvjNer9zNvejxFFXx3nDEaCJlTTr5wTGumIf5ZH+IIFZ8p5t/Kw14FId7uReQ0w9yLJd9spflmFxjvAXNQlUWCUINBMH/cnGGLF/nwdMndDBAHvkPOsm4FQkkWaEwXTnEOvz66y5FEXm8+MYwStpDz9WwEJyZVmwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mS29I8uP; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mS29I8uP"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D69C532510;
	Fri, 17 May 2024 20:21:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ocOSm0VpxVjNKPpuKPLsmSMM4iFRqkg5xjWa6l
	wUU/g=; b=mS29I8uP6EPUDqkRCKg6DekQ9oYhUHKmdRDo+/fTPTMYifMfbUcGhg
	OwMuCeMF4Ei1maQHw6bTIaKQsWL69pOcluDujRFjOlt/JM6ZLrB1+p4KMcLpmYAd
	oHPa+UWZD0sKiKNvWlLDwHshmTadyVPDpgnrfXiZ0xAc++p72eqlc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CF3343250F;
	Fri, 17 May 2024 20:21:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 609853250E;
	Fri, 17 May 2024 20:21:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 5/8] hook(clone protections): add escape hatch
In-Reply-To: <a4f5eeef6677462267d1dbf4b2b58d30aa013684.1715987756.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Fri, 17 May 2024
	23:15:53 +0000")
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
	<a4f5eeef6677462267d1dbf4b2b58d30aa013684.1715987756.git.gitgitgadget@gmail.com>
Date: Fri, 17 May 2024 17:21:52 -0700
Message-ID: <xmqqseygc6lb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A140C43E-14AC-11EF-9037-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +static int is_hook_safe_during_clone(const char *name, const char *path, char *sha256)
> +{
> +	if (get_sha256_of_file_contents(path, sha256) < 0)
> +		return 0;
> +
> +	if (!safe_hook_sha256s_initialized) {
> +		safe_hook_sha256s_initialized = 1;
> +		git_protected_config(safe_hook_cb, &safe_hook_sha256s);
> +	}
> +
> +	return strset_contains(&safe_hook_sha256s, sha256);
> +}

Makes sense.  Use of a hashmap/strset here makes sense.
