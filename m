Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505B179B8
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676290; cv=none; b=enmqKN8MIuC7jJ40kpm3ePfCUBEQ3QpcTw5DoVI9ueWtISm8eN+HIhsjPgkRdXFlYR2LsE1dq4rV8UEbe1JZ68FAkh+XP/RvovYi8HgoUTivebIldwvANPEezNVKA+TC0uK6rzEPjOvhFhiY99T5MfSAqEYDyHLIqzae8cZkGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676290; c=relaxed/simple;
	bh=DVLq7EAIPz1Y7HAgWhR8qV2J5aB7uNjenqFba6uHzPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jr7C6FUETzWE/I0t5Gz25aNowq2nuHVJrHzj1DVaJ9ad8cFKSV4BQeQo9zfQ5VQbMdM0q23+8Kgl6bI/4SXB4jk7qxVwqAPfAf+D/7bo0wXKIQTCgfd2WhzHA6rdvIfljpk20fKjTSQRLghQq2ofyqw3Z8xZWpg4XmX0w9f39Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=op64UGV7; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="op64UGV7"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 117061DC401;
	Fri, 23 Feb 2024 03:18:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DVLq7EAIPz1Y7HAgWhR8qV2J5aB7uNjenqFba6
	uHzPE=; b=op64UGV7Ftye/SAgnrvQNe6QM4WMBTtPz2JAVtSCzJ7lxnRekBzW+j
	7tX1/yy9LrNX7Ly4yawodaJr+g5XlV1ONe8Mu1KyV3b3Ry7g2yD885GLNp8MoNAs
	t/YY/NeuYxKCIP6jdlyvPv3nrhIBNcfZ+vLPUwRBUiKrCbnivsE1E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 04E121DC400;
	Fri, 23 Feb 2024 03:18:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26EA71DC3FE;
	Fri, 23 Feb 2024 03:18:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff Hostetler
 <git@jeffhostetler.com>,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 04/16] fsmonitor: refactor refresh callback on
 directory events
In-Reply-To: <5516670e30e26c5b50c67b69e48e3e8a5e0d8990.1708658300.git.gitgitgadget@gmail.com>
	(Jeff Hostetler via GitGitGadget's message of "Fri, 23 Feb 2024
	03:18:08 +0000")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<5516670e30e26c5b50c67b69e48e3e8a5e0d8990.1708658300.git.gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 00:18:00 -0800
Message-ID: <xmqqbk871tmv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0F4325EC-D224-11EE-947E-25B3960A682E-77302942!pb-smtp2.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Move the code to handle directory FSEvents (containing pathnames with
> a trailing slash) into a helper function.
>
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 52 ++++++++++++++++++++++++++++++----------------------
>  1 file changed, 30 insertions(+), 22 deletions(-)

Nothing unexpected to see here.  Looking good.

> diff --git a/fsmonitor.c b/fsmonitor.c
> index f670c509378..6fecae9aeb2 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -183,6 +183,35 @@ static int query_fsmonitor_hook(struct repository *r,
>  	return result;
>  }
>  
> +static void handle_path_with_trailing_slash(
> +	struct index_state *istate, const char *name, int pos)
> +{
> +	int i;
> +
> +	/*
> +	 * The daemon can decorate directory events, such as
> +	 * moves or renames, with a trailing slash if the OS
> +	 * FS Event contains sufficient information, such as
> +	 * MacOS.
> +	 *
> +	 * Use this to invalidate the entire cone under that
> +	 * directory.
> +	 *
> +	 * We do not expect an exact match because the index
> +	 * does not normally contain directory entries, so we
> +	 * start at the insertion point and scan.
> +	 */
> +	if (pos < 0)
> +		pos = -pos - 1;
> +
> +	/* Mark all entries for the folder invalid */
> +	for (i = pos; i < istate->cache_nr; i++) {
> +		if (!starts_with(istate->cache[i]->name, name))
> +			break;
> +		istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
> +	}
> +}
> +
>  static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
>  {
>  	int i, len = strlen(name);
> @@ -193,28 +222,7 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
>  			 name, pos);
>  
>  	if (name[len - 1] == '/') {
> -		/*
> -		 * The daemon can decorate directory events, such as
> -		 * moves or renames, with a trailing slash if the OS
> -		 * FS Event contains sufficient information, such as
> -		 * MacOS.
> -		 *
> -		 * Use this to invalidate the entire cone under that
> -		 * directory.
> -		 *
> -		 * We do not expect an exact match because the index
> -		 * does not normally contain directory entries, so we
> -		 * start at the insertion point and scan.
> -		 */
> -		if (pos < 0)
> -			pos = -pos - 1;
> -
> -		/* Mark all entries for the folder invalid */
> -		for (i = pos; i < istate->cache_nr; i++) {
> -			if (!starts_with(istate->cache[i]->name, name))
> -				break;
> -			istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
> -		}
> +		handle_path_with_trailing_slash(istate, name, pos);
>  
>  		/*
>  		 * We need to remove the traling "/" from the path
