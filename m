Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A04C8C
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712296; cv=none; b=R7Gt4sjpWQM3etHEty7mHWeloQg9ypKFUtpgMhERdEhICzbpLISLIo/k/TCSP4A6CgCSpXE9gdXRgnttTk36nhGa0H2jEj+GNISwMrGRCb3MJwC68PCWqTSwSoeERCWwEYQ/mHUcKDeyHDNtaeKxTd5EgbRFc53CN5VqnbA79Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712296; c=relaxed/simple;
	bh=uActQUe6y2dWAKNx2OUm8OsDENYhgAYTnCDk2l8Oh1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Thf+LyjxOR5gJbznuE0CLF9mc5HUCYw1ufVq7WWCb5AeS8sRFhiv6MUnzdvJeNGqK1JwGzL4pg+/tHkw8/6qj36YR7Zqpu1somNl2mrNRbbYLZtk4daBJ73jzAB2gVU8YHf7THIOszIRIyfbh3e6QmNeI+eYuyzGTMdTgHE04KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZbnfAZlF; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZbnfAZlF"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9075E1E0170;
	Fri, 23 Feb 2024 13:18:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uActQUe6y2dWAKNx2OUm8OsDENYhgAYTnCDk2l
	8Oh1M=; b=ZbnfAZlFKNMl70OVH/8EGq9HpVTvh//TM+gzNB4t78UAcvhj2uZzEb
	VlUYBspXL43dKmM40pvSMAfuY6UTYtqszm0qQjLGNS3iLXgCk7gdrhnFgLMNjJ6W
	fUqwpzK9hcMu/+JSG9MoqD5JFCUeG4hppyhLmGHb+zlI31Efs9684=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 87CC31E016F;
	Fri, 23 Feb 2024 13:18:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E63821E016D;
	Fri, 23 Feb 2024 13:18:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff Hostetler
 <git@jeffhostetler.com>,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 15/16] fsmonitor: refactor bit invalidation in
 refresh callback
In-Reply-To: <3a20065dbf80eabfc62c0bdebc16df0b5a4c7b02.1708658300.git.gitgitgadget@gmail.com>
	(Jeff Hostetler via GitGitGadget's message of "Fri, 23 Feb 2024
	03:18:19 +0000")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<3a20065dbf80eabfc62c0bdebc16df0b5a4c7b02.1708658300.git.gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 10:18:11 -0800
Message-ID: <xmqqbk87t57g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E7F557CC-D277-11EE-BF23-25B3960A682E-77302942!pb-smtp2.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Refactor code in the fsmonitor_refresh_callback() call chain dealing
> with invalidating the CE_FSMONITOR_VALID bit and add a trace message.
>
> During the refresh, we clear the CE_FSMONITOR_VALID bit in response to
> data from the FSMonitor daemon (so that a later phase will lstat() and
> verify the true state of the file).
>
> Create a new function to clear the bit and add some unique tracing for
> it to help debug edge cases.
>
> This is similar to the existing `mark_fsmonitor_invalid()` function,
> but we don't need the extra stuff that it does.
>
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/fsmonitor.c b/fsmonitor.c
> index ac638a61c00..0667a8c297c 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -187,6 +187,20 @@ static int query_fsmonitor_hook(struct repository *r,
>  static size_t handle_path_with_trailing_slash(
>  	struct index_state *istate, const char *name, int pos);
>  
> +/*
> + * Invalidate the FSM bit on this CE.  This is like mark_fsmonitor_invalid()
> + * but we've already handled the untracked-cache and I want a different
> + * trace message.
> + */

"I want" -> "want" perhaps.

More importantly, when new developers come and want to touch this
file in the future, how would they choose which one to call?  Would
it make a better comment if we rewrote the above for such future
developers as intended audiences?

> +static void invalidate_ce_fsm(struct cache_entry *ce)
> +{
> +	if (ce->ce_flags & CE_FSMONITOR_VALID)
> +		trace_printf_key(&trace_fsmonitor,
> +				 "fsmonitor_refresh_callback INV: '%s'",
> +				 ce->name);
> +	ce->ce_flags &= ~CE_FSMONITOR_VALID;
> +}
> +
>  /*
>   * Use the name-hash to do a case-insensitive cache-entry lookup with
>   * the pathname and invalidate the cache-entry.
> @@ -224,7 +238,7 @@ static size_t handle_using_name_hash_icase(
>  
>  	untracked_cache_invalidate_trimmed_path(istate, ce->name, 0);
>  
> -	ce->ce_flags &= ~CE_FSMONITOR_VALID;
> +	invalidate_ce_fsm(ce);
>  	return 1;
>  }
>  
> @@ -316,7 +330,7 @@ static size_t handle_path_without_trailing_slash(
>  		 * cache-entry with the same pathname, nor for a cone
>  		 * at that directory. (That is, assume no D/F conflicts.)
>  		 */
> -		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
> +		invalidate_ce_fsm(istate->cache[pos]);
>  		return 1;
>  	} else {
>  		size_t nr_in_cone;
> @@ -394,7 +408,7 @@ static size_t handle_path_with_trailing_slash(
>  	for (i = pos; i < istate->cache_nr; i++) {
>  		if (!starts_with(istate->cache[i]->name, name))
>  			break;
> -		istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
> +		invalidate_ce_fsm(istate->cache[i]);
>  		nr_in_cone++;
>  	}

Nice.
