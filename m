Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF86960273
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929170; cv=none; b=SArSS5kp68fBrBje+rrRvJwRWzXsCda5k9fiyZKFtSwbKUCpT4OTiSlh4VdnD2zOrggFFSdp+COiTsO6v2n4mYuXh0WRKWGRxN0DupL3C5LRfwToOiwS0gbdqPkd0yIqbfppg+870dC8+vqYnjcLJREQ3Op8lLlks3mFAboW8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929170; c=relaxed/simple;
	bh=IFEuEcivG0C0Y2tD292tkqju1Mf4F1E/p2LOxxvtVjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cf5ApUv928n7Ru9tg87PfZ32Qs2GMZzfvmYNKJNqQi8Xg055QjRjm+vG1xNcoeEKDeqGWr3vSKNiBLzipo9flurRHJ8KxUsvpi5veSbChMPKJYKGiln8qJ7T/3EyATKJ/iAiHZtQymT0ymlZCqHVftvqMRlz6vgd/SyJcxgEUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IMZeBQJ3; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IMZeBQJ3"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D5982225D;
	Wed, 14 Feb 2024 11:46:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IFEuEcivG0C0Y2tD292tkqju1Mf4F1E/p2LOxx
	vtVjw=; b=IMZeBQJ3FeSV7TrAZgmlgh6FZu4t6zHfBFy5ZLESy6GZW9pFI4yBKH
	vC4faXCeBW0dmExO1X4gi5k5SaLCgsfBqO9vq+8jqs8JdeTVXLJnbai5Kn8zs1St
	vnaNU1oj1g8pg9bF/MlONEuYyfsC4pLcPZuXen3IY8dSHgSqRN3rM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 06E572225C;
	Wed, 14 Feb 2024 11:46:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0E9E022259;
	Wed, 14 Feb 2024 11:46:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 07/12] fsmonitor: refactor untracked-cache invalidation
In-Reply-To: <1df4019931c29824b174defb75e09823d604219e.1707857541.git.gitgitgadget@gmail.com>
	(Jeff Hostetler via GitGitGadget's message of "Tue, 13 Feb 2024
	20:52:16 +0000")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<1df4019931c29824b174defb75e09823d604219e.1707857541.git.gitgitgadget@gmail.com>
Date: Wed, 14 Feb 2024 08:46:00 -0800
Message-ID: <xmqqo7cjxad3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 89932996-CB58-11EE-A0EE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)

Sorry, but the proposed commit log is way lacking for this
particular step.  Readers have already understood, after reading
steps like [04/12] and [05/12], that you use the verb "refactor" in
its usual sense, i.e. reorganize the code around without changing
behaviour in order to enhance readability and to make it easier for
code reuse in future steps, and these two steps did exactly that:
helper functions are split out of larger functions, presumably
either to allow adding new callers to the helpers, or to make the
result of adding more code to the caller easier to follow [*].

However, the changes in this step look vastly different, and it is
not even clear if this change intends to keep the behaviour before
and after it the same, or if it does, how they are the same.

I can sort-of see that the original code made a call to
untracked_cache_invalidate_path() at the very end of the
fsmonitor_refresh_callback(), but the updated code no longer does
so.  Why?  Is it because it is the root cause of an unstated bug
that we don't do so until the end in the current code?  Is it
because the order does not matter (how and why?) and the resulting
code becomes better (how?  simpler to follow? more performant?
avoids duplicated work?  something else)?

It does not help to call a new helper function with a cryptic "my_"
name, either.

Please try again?  Thanks.


[Footnote] 

 * These two are vastly different goals, and there may be other
   reasons why you are doing such refactoring.  It would have been
   nicer if such a preliminary refactoring steps had explained what
   the intended course of evolution for the code involved in the
   refactoring is.



>
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 754fe20cfd0..14585b6c516 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -183,11 +183,35 @@ static int query_fsmonitor_hook(struct repository *r,
>  	return result;
>  }
>  
> +/*
> + * Invalidate the untracked cache for the given pathname.  Copy the
> + * buffer to a proper null-terminated string (since the untracked
> + * cache code does not use (buf, len) style argument).  Also strip any
> + * trailing slash.
> + */
> +static void my_invalidate_untracked_cache(
> +	struct index_state *istate, const char *name, int len)
> +{
> +	struct strbuf work_path = STRBUF_INIT;
> +
> +	if (!len)
> +		return;
> +
> +	if (name[len-1] == '/')
> +		len--;
> +
> +	strbuf_add(&work_path, name, len);
> +	untracked_cache_invalidate_path(istate, work_path.buf, 0);
> +	strbuf_release(&work_path);
> +}
> +
>  static void fsmonitor_refresh_callback_unqualified(
>  	struct index_state *istate, const char *name, int len, int pos)
>  {
>  	int i;
>  
> +	my_invalidate_untracked_cache(istate, name, len);
> +
>  	if (pos >= 0) {
>  		/*
>  		 * We have an exact match for this path and can just
> @@ -253,6 +277,8 @@ static int fsmonitor_refresh_callback_slash(
>  	int i;
>  	int nr_in_cone = 0;
>  
> +	my_invalidate_untracked_cache(istate, name, len);
> +
>  	if (pos < 0)
>  		pos = -pos - 1;
>  
> @@ -278,21 +304,9 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
>  
>  	if (name[len - 1] == '/') {
>  		fsmonitor_refresh_callback_slash(istate, name, len, pos);
> -
> -		/*
> -		 * We need to remove the traling "/" from the path
> -		 * for the untracked cache.
> -		 */
> -		name[len - 1] = '\0';
>  	} else {
>  		fsmonitor_refresh_callback_unqualified(istate, name, len, pos);
>  	}
> -
> -	/*
> -	 * Mark the untracked cache dirty even if it wasn't found in the index
> -	 * as it could be a new untracked file.
> -	 */
> -	untracked_cache_invalidate_path(istate, name, 0);
>  }
>  
>  /*
