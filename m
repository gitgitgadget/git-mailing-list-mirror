Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB3E14D6EB
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521980; cv=none; b=Fj153XyMky6sjWJp7r3ADBzpop1PK57N9vYViehj3luWu/tRwhfroAe2B3FIr3iyDRv21czwODGv+MhzxxG3ag7HrgbSLNvvgjmmyovGpbUIpUTsg7a3g8VUbBaR0UoQ9mm4EeVoGYBjMdSlhOacHlcvQXr4/2PeV0Bqu+BjC0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521980; c=relaxed/simple;
	bh=be74JdssfV3/Zk5r+r3hAFUsTDkx3hhr6dhIyFHGZAY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qXHJHX94H5RGJ1F+khapvHrr4n+KKl2dOJ39BB4dsBOoL9arlnLTnMiGHdS6o/34zFpm8QT1wlJl5lDrZihJMkZuQek8qTHWf+QB0k6LWqAJZFW6SXVLBcqrB4Yw6Uhp333cZ0noooEy6hooDdsBw1Sa6NhIe1jjl3AW+dBVv7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OaBiPy68; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OaBiPy68"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6EDAD1D521;
	Thu, 27 Jun 2024 16:59:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=be74JdssfV3/Zk5r+r3hAFUsTDkx3hhr6dhIyF
	HGZAY=; b=OaBiPy68GODJzTQhxN8WgWFX3fVzUfsXxrMwBzz32JzTaeuyfQoxS6
	NonsGaUKwFVycoe9xxGSVfuGHJGOi63Q8sSOlS4qsMluIX2tbvx0mmr++EYGHZ/E
	xaW0UdOs5kDf3tV/mZFdBAkcHfGSms6nURF0lj+xbmgA0Jeid5OrI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 673841D520;
	Thu, 27 Jun 2024 16:59:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D33A31D51F;
	Thu, 27 Jun 2024 16:59:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  anh@canva.com,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2 1/5] sparse-checkout: refactor skip worktree retry logic
In-Reply-To: <93d0baed0b0f435e5656cef04cf103b5e2e0f41a.1719412192.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 26 Jun 2024
	14:29:47 +0000")
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
	<pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
	<93d0baed0b0f435e5656cef04cf103b5e2e0f41a.1719412192.git.gitgitgadget@gmail.com>
Date: Thu, 27 Jun 2024 13:59:32 -0700
Message-ID: <xmqq7ceat83v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 27DF37BA-34C8-11EF-840B-C38742FD603B-77302942!pb-smtp20.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -void clear_skip_worktree_from_present_files(struct index_state *istate)
> +static int clear_skip_worktree_from_present_files_sparse(struct index_state *istate)
>  {
>  	const char *last_dirname = NULL;
>  	size_t dir_len = 0;
>  	int dir_found = 1;
>  
> -	int i;
> -	int path_count[2] = {0, 0};
> -	int restarted = 0;
> +	int path_count = 0;
> +	int to_restart = 0;
>  
> -	if (!core_apply_sparse_checkout ||
> -	    sparse_expect_files_outside_of_patterns)
> -		return;
> -
> -	trace2_region_enter("index", "clear_skip_worktree_from_present_files",
> +	trace2_region_enter("index", "clear_skip_worktree_from_present_files_sparse",
>  			    istate->repo);
> -restart:
> -	for (i = 0; i < istate->cache_nr; i++) {
> +	for (int i = 0; i < istate->cache_nr; i++) {
>  		struct cache_entry *ce = istate->cache[i];
>  
>  		if (ce_skip_worktree(ce)) {
> -			path_count[restarted]++;
> +			path_count++;
>  			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
>  				if (S_ISSPARSEDIR(ce->ce_mode)) {
> -					if (restarted)
> -						BUG("ensure-full-index did not fully flatten?");
> -					ensure_full_index(istate);
> -					restarted = 1;
> -					goto restart;
> +					to_restart = 1;
> +					break;
>  				}
>  				ce->ce_flags &= ~CE_SKIP_WORKTREE;
>  			}
>  		}
>  	}

Both original and the rewritten code shares one trait, which is that
it goes from the beginning to check all paths that are marked with
SKIP_WORKTREE bit to clear CE_SKIP_WORKTREE bits from them, until
they find a S_ISSPARSEDIR entry and lazily call ensure_full_index(),
but then when retrying after calling ensure_full_index(), it
restarts from the beginning.  I wonder if it would help, especially
if the S_ISSPARSEDIR entry comes very late in the index (e.g., by
returning "here is where we have already checked during the first
run, until we realized that we first need to do ensure_full_index()"
to the caller from here, and then the caller tells the second phase
to restart from there), to reduce the number of calls to path_found()?
