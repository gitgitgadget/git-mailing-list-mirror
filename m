Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF2E15E81A
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094434; cv=none; b=GZV3z79xyOpRdziBOPkkXKH++cbIb03ag7zpnNrmxpOhhc0HSLswY59tEqFuAr/NjWD2YwIgLyVLrvlxSPIFU7I5+U0wn47h0TksfuaTVmjdLsuzWwdM/JjITbCj//fnLmswDM+kRwpeLbWeEEj6WVn5q/e6PYRZbc+r42ND6lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094434; c=relaxed/simple;
	bh=V76lM3d4+ez8plvaY8AZfrhY3VCuvJyZeOUtR6WW8pI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YdzDHhLZVE+TDmj7KrhD5BJTUL9Q4OBTP34Klttfq5aCvunm2p8kJqk7w39H0EAii8XevAP1L3MOCriWgTECtFUjd1WZoLNNxGNM/J9geJp/LemNRAu3Zklnl/Sh6vEylGdjReNJMFKNKcFhC10hNysGB5mNn3bKbTFNZjXUtJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oa1KUaVe; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oa1KUaVe"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A49AD1E41A7;
	Tue,  2 Apr 2024 17:47:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=V76lM3d4+ez8plvaY8AZfrhY3VCuvJyZeOUtR6
	WW8pI=; b=oa1KUaVe5hVrhJqAX3sl5S3IhMtSgA8XYB5kUU9mQ7Pd5FCKron063
	tHGgND9oWm7F1P3TD4maC0oysz1sFdLAUSH5Okb9l76U5T8P6z7Hfv/JHpT2JkAk
	Ia9q8crMMZfYsaQ48zC+HkRUhIN7VNKe1Zfv1Q+bjeq9GXsFxYOic=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ACAB11E41A6;
	Tue,  2 Apr 2024 17:47:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAD761E41A3;
	Tue,  2 Apr 2024 17:47:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] builtin/commit: error out when passing untracked
 path with -i
In-Reply-To: <20240402213640.139682-5-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Wed, 3 Apr 2024 03:06:24 +0530")
References: <20240329205649.1483032-2-shyamthakkar001@gmail.com>
	<20240402213640.139682-5-shyamthakkar001@gmail.com>
Date: Tue, 02 Apr 2024 14:47:02 -0700
Message-ID: <xmqqmsqb30a1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8B050F30-F13A-11EE-A411-25B3960A682E-77302942!pb-smtp2.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 8f31decc6b..09c48a835a 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -441,10 +441,17 @@ static const char *prepare_index(const char **argv, const char *prefix,
>  	 * (B) on failure, rollback the real index.
>  	 */
>  	if (all || (also && pathspec.nr)) {
> +		char *ps_matched = xcalloc(pathspec.nr, 1);
>  		repo_hold_locked_index(the_repository, &index_lock,
>  				       LOCK_DIE_ON_ERROR);
>  		add_files_to_cache(the_repository, also ? prefix : NULL,
> -				   &pathspec, NULL, 0, 0);
> +				   &pathspec, ps_matched, 0, 0);
> +		if (!all && report_path_error(ps_matched, &pathspec)) {
> +			free(ps_matched);
> +			exit(1);

No need to free(ps_matched) immediately before exiting.  There are
other recources (like pathspec) we are holding and not clearing, and
we do not want to bother cleaning them all.

As we have another "if failed, die()" immediately after this hunk,
adding another exit() would be OK.  Shouldn't we be exiting with 128
to match what die() does, though?

Other than that, looking good.
