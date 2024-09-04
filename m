Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F2182863
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486624; cv=none; b=gWaiV0LwCCoEElzx3oe0RQXvgIEtG/TjJQT8Mm0o9WBiSQkZW8IbLW6UOwl6mKDAnw5gjpo0igFva1afYov5Pj4jkyGGmZEuytS1iugz2w5/ezv0crWhC3zF3dsUJ1+3TLSNoEef6ISEGYuGbEWFjXaeerSNG1MMQDh8j7Sgn0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486624; c=relaxed/simple;
	bh=ve5kaf0Mk0cq1lY5zXqw3KoQjV7xx9Ki7HCy1JKp/IY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l11c+XuFEXinzV4xXZdK/X+OQu4ogugP9ShQ8O2WZLCN1yWlz3yN2Z22aczzWr087j2Jp12MCZOpDDQjaXEzDP1kgFBOtz6ZqjnEUVSzeykqdYBo+ca9yLAlVjSyMhTxzgXPtIAOPQQNQbV6bbQ2Mb4nT8EQyM6XGHeFN92CDLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VcPyEtNo; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VcPyEtNo"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C789B20FE5;
	Wed,  4 Sep 2024 17:50:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ve5kaf0Mk0cq1lY5zXqw3KoQjV7xx9Ki7HCy1J
	Kp/IY=; b=VcPyEtNoV33pxN6qGnkqX23QhWOJeYn97kVlWoIbm29hreYXYMC1mF
	j4xzoJ4fC2J77AbN5Wa6qzvN9s36a8AUqwXUknuuFCfyakQlGh83T8m2N62vcBtU
	egGiZp12rqIWCViDrW7t6+Kq2KrJAaBKVsTM7a0OyO1axwxwvIwTs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BF76520FE4;
	Wed,  4 Sep 2024 17:50:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3356F20FE3;
	Wed,  4 Sep 2024 17:50:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/22] remote: fix leaking tracking refs
In-Reply-To: <7fafcc53d23672bb0339c44ea3874b3628785f08.1724656120.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 26 Aug 2024 09:21:56 +0200")
References: <cover.1724656120.git.ps@pks.im>
	<7fafcc53d23672bb0339c44ea3874b3628785f08.1724656120.git.ps@pks.im>
Date: Wed, 04 Sep 2024 14:50:19 -0700
Message-ID: <xmqq34mf84x0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AEBBF51E-6B07-11EF-AF85-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> @@ -1123,6 +1123,7 @@ void free_one_ref(struct ref *ref)
>  		return;
>  	free_one_ref(ref->peer_ref);
>  	free(ref->remote_status);
> +	free(ref->tracking_ref);
>  	free(ref->symref);
>  	free(ref);
>  }
> @@ -2620,8 +2621,10 @@ static int remote_tracking(struct remote *remote, const char *refname,
>  	dst = apply_refspecs(&remote->fetch, refname);
>  	if (!dst)
>  		return -1; /* no tracking ref for refname at remote */
> -	if (refs_read_ref(get_main_ref_store(the_repository), dst, oid))
> +	if (refs_read_ref(get_main_ref_store(the_repository), dst, oid)) {
> +		free(dst);
>  		return -1; /* we know what the tracking ref is but we cannot read it */
> +	}
>  
>  	*dst_refname = dst;
>  	return 0;

Looking good.
