Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D605D467
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398796; cv=none; b=jusEwXmPc6C0I4AcUppkjsz0Csqe6ySzPDkrhls+XqTTb13lqon7n8mc2mHJPHuhHDh6NJ+dANvUB6V7IHZBBa2NUxbISj/tUbZjhw8UeQr9k4+rr3RHIVmMCx5DKrRo2dil2Tm6lUu28Kayg4JBp1i6NU0zgBemMx29g+oiHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398796; c=relaxed/simple;
	bh=pcmd5UCTnUFsBg8u5sCd+NpEUyPYo2KTUQpWn5WeZlc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TQ73ntR/jKRLbmZ+Yq4Hno4StEVDTEzO2YcABFWSveNiEEJPrhAmJGG09StigB0LmVioH7C1K+p++q2QmYYd4zbteDpB7GTclHhdgbMzAEQPZGD9GY4Pn5ObHPWWTQ7Bc583RUoXe0SVx9bhkQJQU9V5juRPg3TuYAl/kNTqLho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cmpws7eB; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cmpws7eB"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9681F1E9F57;
	Mon, 25 Mar 2024 16:33:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pcmd5UCTnUFsBg8u5sCd+NpEUyPYo2KTUQpWn5
	WeZlc=; b=Cmpws7eBZxjQmgkk+t461IVNkMJdoifpuxmUzUdx46q/Uxq6SvA4LA
	iE49FfYWX2NTI0vb9EGiQca1/Gw7+dmCVi6wtQ4i2BIvuoRytjOh7FXIh59UrOVL
	RjLnEg14pdlnBzA+1m0L67GB/ATgRpvS0KJclgFi0a7mRhczRhrJo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EFA01E9F56;
	Mon, 25 Mar 2024 16:33:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B35141E9F47;
	Mon, 25 Mar 2024 16:33:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/11] midx-write.c: avoid directly managed temporary
 strbuf
In-Reply-To: <8e32755c492d20eec02c81351d249ce34cc6d7b9.1711387439.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 25 Mar 2024 13:24:41 -0400")
References: <cover.1711387439.git.me@ttaylorr.com>
	<8e32755c492d20eec02c81351d249ce34cc6d7b9.1711387439.git.me@ttaylorr.com>
Date: Mon, 25 Mar 2024 13:33:11 -0700
Message-ID: <xmqqv85ahx14.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E69D3CB4-EAE6-11EE-8FF3-25B3960A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> In midx-write.c::midx_repack(), we construct the command-line arguments
> for a pack-objects invocation which will combine objects from the packs
> below our `--batch-size` option.
>
> To construct the base name of the output pack, we use a temporary
> strbuf, and then push the result of that onto the strvec which holds the
> command-line arguments, after which point we release the strbuf.
>
> We could replace this by doing something like:
>
>     struct strbuf buf = STRBUF_INIT;
>     strbuf_addf(&buf, "%s/pack/pack", object_dir);
>     strvec_push_nodup(&cmd.args, strbuf_detach(&buf));

Hmph, I thought I saw another patch recently that uses
strvec_pushf() to simplify such a sequence.  Does the technique
apply here as well?

Ah, yes, exactly.  See <9483038c-9529-4243-9b9a-97254fac29c1@web.de>

> @@ -1473,10 +1472,6 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
>  
>  	strvec_push(&cmd.args, "pack-objects");
>  
> -	strbuf_addstr(&base_name, object_dir);
> -	strbuf_addstr(&base_name, "/pack/pack");
> -	strvec_push(&cmd.args, base_name.buf);
> -
>  	if (delta_base_offset)
>  		strvec_push(&cmd.args, "--delta-base-offset");
>  	if (use_delta_islands)
> @@ -1487,7 +1482,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
>  	else
>  		strvec_push(&cmd.args, "-q");
>  
> -	strbuf_release(&base_name);
> +	strvec_pushf(&cmd.args, "%s/pack/pack", object_dir);
>  
>  	cmd.git_cmd = 1;
>  	cmd.in = cmd.out = -1;
