Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827F1EF1D
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853325; cv=none; b=igy5hYgxK2IY14njFJ7d9XhINpNqrFc5Dp3nDEniq9HRUvAXyIoiyR+xaRlSVg/mzqyWWwGe155mwTmkqL2OP6JPsa4VP08cRNzAeoDhjjzOIw4aOsJxsvCd5Ck+NxB9+Lw1wd6AsMtuDnqHjJ8Gsx+ECwlLyKXnKPmkvezQE7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853325; c=relaxed/simple;
	bh=l3iyjyrtWVuKeVSXu31PPDxFFC5w+WIRLiIKl9NP0mE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oyTdwpdtmXsPqhX44inmp8jc+sUIiEjUtVZg9zg+VlPOQ87TOxNGXeKYQjUBjFJeXHWTONXV9NwIP3y7/8FCFe9qd++Q6vkxgW02zNiNJwK98VWQo/Mrknss7xT71SmvpNKab65xliYCZ1fr/xbptxMqgCF8FEBNE4gegHVFFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uw5J+dev; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uw5J+dev"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E5E4C1C54D;
	Fri, 20 Sep 2024 13:28:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=l3iyjyrtWVuKeVSXu31PPDxFFC5w+WIRLiIKl9
	NP0mE=; b=uw5J+devDcTAwMsLt1cctQSE40TBYD8nnd6TxvtpZnjz7DEZBzoP6y
	hF26eqYwwf9SS9K8IIc7f3AFE5acRT6sEZVtjm29iM4VZENm4VgPYVTgGIZfaqxX
	rQ9RNFdXy2oqX6FbPyJ07OcYEtwQKktLOIMNC34932ZawaEV2Y2+8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DCA221C54C;
	Fri, 20 Sep 2024 13:28:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F3001C546;
	Fri, 20 Sep 2024 13:28:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 14/23] builtin/repack: fix leaking configuration
In-Reply-To: <a5f3931eee1e49c60e1d5be214263aeaf3d5c65f.1726484308.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 16 Sep 2024 13:46:05 +0200")
References: <cover.1726484308.git.ps@pks.im>
	<a5f3931eee1e49c60e1d5be214263aeaf3d5c65f.1726484308.git.ps@pks.im>
Date: Fri, 20 Sep 2024 10:28:41 -0700
Message-ID: <xmqqr09e2q0m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C813CDD2-7775-11EF-B814-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When repacking, we assemble git-pack-objects(1) arguments both for the
> "normal" pack and for the cruft pack. This configuration gets populated
> with a bunch of `OPT_PASSTHRU` options that we end up passing to the
> child process. These options are allocated, but never free'd.
>
> Create a new `pack_objects_args_release()` function that releases the
> memory for us and call it for both sets of options.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/repack.c              | 57 ++++++++++++++++++++++++++---------
>  t/t5329-pack-objects-cruft.sh |  2 ++
>  t/t7700-repack.sh             |  1 +
>  3 files changed, 45 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 3ee8cfa732f..c31d5653f1f 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -85,17 +85,34 @@ static int repack_config(const char *var, const char *value,
>  		run_update_server_info = git_config_bool(var, value);
>  		return 0;
>  	}
> -	if (!strcmp(var, "repack.cruftwindow"))
> +	if (!strcmp(var, "repack.cruftwindow")) {
> +		free(cruft_po_args->window);
>  		return git_config_string(&cruft_po_args->window, var, value);

Surely, as git_config_string() gives an allocated string, the
ownership rules should be that the receiving variable/struct member
is responsible for properly freeing it, which means that the current
value must be discarded before the new value is taken.  Looking
good.

I wonder if any of these targets (like the cruft_po_args->window we
see here) can be updated by parsing the command line arguments (with
OPT_STRING)?  It turns out that this worry is not unfounded but you
already covered it ...

>  		if (!cruft_po_args.window)
> -			cruft_po_args.window = po_args.window;
> +			cruft_po_args.window = xstrdup_or_null(po_args.window);

... here, so we are safe.

Looking good.

Thanks.
