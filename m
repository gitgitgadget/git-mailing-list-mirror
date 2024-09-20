Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13230EBE
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726855173; cv=none; b=Me9UgVgPoiEYAPbtnNZC2IhD9BA0DsfJAp+ky7MC2+UzGWXkf5qj5I+7VJIrsq+/sss46ifnAslniUAT2SCCtekuPy0hNWcyUORhIx0mvsaoM32YVUkEKLInpgice9MRXCR+e9xoKqBq40f0TX4OC6XjfQQK4tvFb68p4fh6Exw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726855173; c=relaxed/simple;
	bh=SErAwFespOqOu2gMoA1BuOb5XXdGgqcnkPn89HshWhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gHtkJAtw9oJRDK0OeWmv0x8jUxieoRxocodD4AQzVwE4eMBpSshzlBN/zOids9wgn9Jlk1NjiKuMdxlFNUNt0flKKIzxnnbdqLQ6EmhzDLdn+/2R5J86jwZPvXWPSIXUslcwIXSqr91Jet6nW+Rm0QtBf4/zf9KTQ+F3d9V9Rmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MgHmNt0a; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MgHmNt0a"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 007EE1CBF3;
	Fri, 20 Sep 2024 13:59:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SErAwFespOqOu2gMoA1BuOb5XXdGgqcnkPn89H
	shWhw=; b=MgHmNt0arem3Lh0VCQnxiI47RIl+8VGG5IHtc8hVBfYOBAut7hmzvz
	0dX2DUfctcIJJqRErg+7nAfG2NC31YoJq9npJHYeLuVdCls6BhBWzy8KMTwsPDF5
	ZNV8yoy2N4qA/uHN2D1t/xplc/giE7UoTBlNwVxplJGPcDQGlQZUk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EAF111CBF2;
	Fri, 20 Sep 2024 13:59:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C5621CBF1;
	Fri, 20 Sep 2024 13:59:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 20/23] builtin/maintenance: fix leaking config string
In-Reply-To: <ed4091255cd25e82db01cb05df63b8c6804b6449.1726484308.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 16 Sep 2024 13:46:23 +0200")
References: <cover.1726484308.git.ps@pks.im>
	<ed4091255cd25e82db01cb05df63b8c6804b6449.1726484308.git.ps@pks.im>
Date: Fri, 20 Sep 2024 10:59:28 -0700
Message-ID: <xmqqed5ei4u7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 15023DD2-777A-11EF-8A39-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When parsing the maintenance strategy from config we allocate a config
> string, but do not free it after parsing it. Plug this leak by instead
> using `git_config_get_string_tmp()`, which does not allocate any memory.
>
> This leak is exposed by t7900, but plugging it alone does not make the
> test suite pass.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/gc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 7dac9714054..3acfa367ad1 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1476,9 +1476,9 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
>  
>  static void initialize_maintenance_strategy(void)
>  {
> -	char *config_str;
> +	const char *config_str;
>  
> -	if (git_config_get_string("maintenance.strategy", &config_str))
> +	if (git_config_get_string_tmp("maintenance.strategy", &config_str))
>  		return;

I am not a huge fan of the name of this function, because many
callers use the result as a fairly long-lived string (the primary
reason why they call them is to avoid having to free() the result at
the end), but this new caller's use is very much in line with the
"tmp" in its name.  We peek into the configset to learn the value of
this string, and check its value against "incremental".

Looking good.

Thanks.
