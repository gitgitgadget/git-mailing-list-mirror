Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8144F8A0
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718312410; cv=none; b=BLMMQxIJ6i3FLvO0jVEpg2YijbFEhrOCqBOfbhhqGM74GWSs1QbtQOuh4B77Ht2+Cjcw609CWXZTJE+/0lBmTsXjvd4oFfBr7XPk6H8GdhfS3ijtNMOwKYWBC8xidof7mBbw1VFY5cdfAsxTisKhfYzjoU4+aKZcBbD2X93kGqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718312410; c=relaxed/simple;
	bh=ry3p+34KWjrsWi7sJBuJKgkTA2ZcBG1EpaHYRzZ7D20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nxuZVk8zDn81/aOq41eaZ9WsKZj63ZIFVPrz9+TEVV2nTrXba/gnxRh39uyteScrTZP/Bk/OVn+6jXXvizCx4n0YOC/hOjcmUny2ZUzDdK92jJCBfqovBmD5CQgtir391TEjMbqewOl07e//ioCeaYnPCwDizEXkrlbHlON6ths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=N+p5XIV9; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N+p5XIV9"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 72FFA1C2EA;
	Thu, 13 Jun 2024 17:00:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ry3p+34KWjrsWi7sJBuJKgkTA2ZcBG1EpaHYRz
	Z7D20=; b=N+p5XIV9uaytt/Yd3WuP2YGSud43160GfM8iUJU+tyW8ew6KlkcVO/
	27H3D0axOWNC14ia3QQ4I1oRRxZAuL4vCl6cyeBG+th4BQX+mwwqB9Gi8kBqijYN
	ONA6RxlKpfgZ6sQGZjuznROtlLIz71N1vwrMHa34lpFtNZiilNfvA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CD131C2E5;
	Thu, 13 Jun 2024 17:00:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE2351C2D8;
	Thu, 13 Jun 2024 17:00:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/7] merge-ort: extract handling of priv member into
 reusable function
In-Reply-To: <d4ba1fccd9145db9b3fe1530881052315cfa16b8.1718310307.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Thu, 13 Jun 2024
	20:25:01 +0000")
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
	<d4ba1fccd9145db9b3fe1530881052315cfa16b8.1718310307.git.gitgitgadget@gmail.com>
Date: Thu, 13 Jun 2024 14:00:00 -0700
Message-ID: <xmqqjzisimnj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E7E1FA5E-29C7-11EF-9E96-965B910A682E-77302942!pb-smtp2.pobox.com

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void move_opt_priv_to_result_priv(struct merge_options *opt,
> +					 struct merge_result *result)
> +{
> +	/*
> +	 * opt->priv and result->priv are a bit weird.  opt->priv contains
> +	 * information that we can re-use in subsequent merge operations to
> +	 * enable our cached renames optimization.  The best way to provide
> +	 * that to subsequent merges is putting it in result->priv.
> +	 * However, putting it directly there would mean retrofitting lots
> +	 * of functions in this file to also take a merge_result pointer,
> +	 * which is ugly and annoying.  So, we just make sure at the end of
> +	 * the merge (the outer merge if there are internal recursive ones)
> +	 * to move it.
> +	 */
> +	assert(opt->priv && !result->priv);
> +	if (!opt->priv->call_depth) {
> +		result->priv = opt->priv;
> +		result->_properly_initialized = RESULT_INITIALIZED;
> +		opt->priv = NULL;
> +	}
> +}
> +
>  /*
>   * Originally from merge_trees_internal(); heavily adapted, though.
>   */
> @@ -5060,11 +5082,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
>  		/* existence of conflicted entries implies unclean */
>  		result->clean &= strmap_empty(&opt->priv->conflicted);
>  	}
> -	if (!opt->priv->call_depth) {
> -		result->priv = opt->priv;
> -		result->_properly_initialized = RESULT_INITIALIZED;
> -		opt->priv = NULL;
> -	}
> +	move_opt_priv_to_result_priv(opt, result);
>  }

I have a feeling that making it the caller's responsibility to check
"are we doing the outermost merge?"  and not the callee's problem
would result in a better code organization.  If we write

	if (!opt->priv->call_depth)
		move_opt_priv_to_result_priv(opt, result);

then for this call site, it is still crystal clear that this will
happen only at the outermost level.  The new caller you add in the
next step would also be simpler to reason about.

You have the assert() to make sure callers do not call the "move"
helper at a wrong place already, and if the organization in this
patch somehow comes from a desire that the "move" is done only at
the outermost level (and "or immediately before an error causes the
whole thing to abort" after the next patch), it does not have to be
a silent "if call_depth is not zero we return silently", but another
assert() that insists that the callers are allowed to call it under
these two specific conditions.

Thanks.
