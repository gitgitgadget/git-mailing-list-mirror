Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD75E15382F
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802548; cv=none; b=Tlfna5Kny7I72PVTSGoPuHbSQ9uFRjnzyRE7r2YwfU3Z+xA5qDT8ZXvNWDOOfHdpOYiTa63FQo2AdSpSRLpNj2F/xPcSuuVVUMCRUY1Zkjrp5b1R7yARP5kDXxtzlvcpMTAvvwltbMQ8Tua043JUYs2x+D2GoWq07JA1K3xbZMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802548; c=relaxed/simple;
	bh=l5jL7vQ9iU2NqNP1xm6Zb1VOsMybyobFCG/PLXH46FQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WNy0ODkSUhvsWtks9hMz7OBjzHB4F1dPi8tZm7/t2McBQZ/ukzCsqwslbDyq02244R24v9/d4eV1Wyx1Spu+tG+PcV8F2jgsXSWqzr0mOC9Jo4Tizlpt7vo23ytD8DnNh87gNLDqERaJhFzEOQ47FvW0a2rMBT7CH8BWR+P8k5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UY6Tcseq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UY6Tcseq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A3CD41EA21C;
	Mon, 22 Apr 2024 12:15:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=l5jL7vQ9iU2NqNP1xm6Zb1VOsMybyobFCG/PLX
	H46FQ=; b=UY6Tcseq9Bt+rmb2zoVYH0dj3vL1zQI/wL/DevkyDM5ytlQAguj/55
	9ACLr4vlUAFiYl5qrxFAcMEsggFc4EJdTJ3jaSsD+zdlAMVU8C3I02i4DzZU2fzV
	q7GumxDdNQaS+ZMtRasRlhJ9PZdtVkT2Tx4RGVO4CXuMM2jf9bbDI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A3E21EA21B;
	Mon, 22 Apr 2024 12:15:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 02FE91EA21A;
	Mon, 22 Apr 2024 12:15:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/11] path: harden validation of HEAD with non-standard
 hashes
In-Reply-To: <aa4d6f508b4af3923813e19ff82a4e8484d5ff11.1713519789.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 19 Apr 2024 11:51:10 +0200")
References: <cover.1713519789.git.ps@pks.im>
	<aa4d6f508b4af3923813e19ff82a4e8484d5ff11.1713519789.git.ps@pks.im>
Date: Mon, 22 Apr 2024 09:15:41 -0700
Message-ID: <xmqqjzkpxtjm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 916E3412-00C3-11EF-9B87-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The `validate_headref()` function takes a path to a supposed "HEAD" file
> and checks whether its format is something that we understand. It is
> used as part of our repository discovery to check whether a specific
> directory is a Git directory or not.
>
> Part of the validation is a check for a detached HEAD that contains a
> plain object ID. To do this validation we use `get_oid_hex()`, which
> relies on `the_hash_algo`. At this point in time the hash algo cannot
> yet be initialized though because we didn't yet read the Git config.
> Consequently, it will always be the SHA1 hash algorithm.
>
> In practice this works alright because `get_oid_hex()` only ends up
> checking whether the prefix of the buffer is a valid object ID. And
> because SHA1 is shorter than SHA256, the function will successfully
> parse SHA256 object IDs, as well.
>
> It is somewhat fragile though and not really the intent to only check
> for SHA1. With this in mind, harden the code to use `get_oid_hex_any()`
> to check whether the "HEAD" file parses as any known hash.

All makes sense, and given the above, I strongly suspect that we
would want to make the validate_headref() function a file-scope
static in setup.c to make sure it is only called/callable from the
repository discovery codepath.  Especially that if somebody calls
this function again after we find out that the repository uses
SHA-256, we would want to let the caller know that the detached HEAD
records SHA-1 and we are in an inconsistent state.

> It follows that we could just leave the current code intact, as in
> practice the code change doesn't have any user visible impact. But it
> also prepares us for `the_hash_algo` being unset when there is no
> repositroy.

Or perhaps we use get_oid_hex_any() != GIT_HASH_UNKNOWN when
the_hash_algo has not been determined, and use !get_oid_hex() after
we have determined which algorithm we are using?  It may be what you
did in a later step in the series, so let me read on.

Thanks.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  path.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/path.c b/path.c
> index 67229edb9c..cc02165530 100644
> --- a/path.c
> +++ b/path.c
> @@ -693,7 +693,7 @@ int validate_headref(const char *path)
>  	/*
>  	 * Is this a detached HEAD?
>  	 */
> -	if (!get_oid_hex(buffer, &oid))
> +	if (get_oid_hex_any(buffer, &oid) != GIT_HASH_UNKNOWN)
>  		return 0;
>  
>  	return -1;
