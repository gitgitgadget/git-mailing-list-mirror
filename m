Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA242744E
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 22:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722466032; cv=none; b=OlwDOfVOl17aWLlAzDGsQVhFA77eEu9pptrA9B9GRjHSzkpzN87HdtRjpi6N9VQhuQ8EisMSIH//eQxraejNx1n4wTDhaC2LiJ/167fE4Rg4YPjl95L/7/QfjmOdKENjJVC0Cxi4CUtVHSvMf1BDpIOpI8hJo7OqStZcg5fzpK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722466032; c=relaxed/simple;
	bh=CPQ23YdycAaEXTwrQEqxCgKc0Twu2Sd70TfJtZD2CIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PWht4BDsgkB+97Ms1f4GUtr5lBCsNzexBW01+ZmHlnUZPcgGF+SSPcTjfwlnqRNqAqmVrIF7H3oLighIxgvfha596bsuanI/W9d46YwBeYAVIFEi7VDTl3gVv9WsRWXJMeAfPhhWhur1RNYU0kwyVgLtnSnBGB0G9M+xTt7bbvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=t3SGza6o; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t3SGza6o"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F7193C883;
	Wed, 31 Jul 2024 18:47:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CPQ23YdycAaEXTwrQEqxCgKc0Twu2Sd70TfJtZ
	D2CIs=; b=t3SGza6ofQcllVZ/+spVNzeA+vTbcKa1xWLYP3zf0FwbipHH7afJOb
	vX7ZJ/O8q6+ksZsa34zBcQJoxQ1fp9Vct5/pQuklPNTcbL42lkZCM1zWIzgBlfrw
	pvo85+qhMVHcqpNs5hK79XZKvdyidTo/Xo0X73wNLlhS9z2j9y1nM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A7AB3C882;
	Wed, 31 Jul 2024 18:47:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF3E43C881;
	Wed, 31 Jul 2024 18:47:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Han Jiang <jhcarl0814@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: git config set --file, key-value pair without '= value', gives
 Segmentation fault
In-Reply-To: <ZqqucpNgqSgZDPtA@nand.local> (Taylor Blau's message of "Wed, 31
	Jul 2024 17:36:50 -0400")
References: <CANrWfmTek1xErBLrnoyhHN+gWU+rw14y6SQ+abZyzGoaBjmiKA@mail.gmail.com>
	<ZqqucpNgqSgZDPtA@nand.local>
Date: Wed, 31 Jul 2024 15:47:04 -0700
Message-ID: <xmqq5xslyyaf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D0344B68-4F8E-11EF-8A4B-BAC1940A682E-77302942!pb-smtp2.pobox.com

> So I think that the behavior dates back to c90702a1f6 (config: plumb
> --fixed-value into config API, 2020-11-25). I think that the fix looks
> something like:
>
> --- 8< ---
> diff --git a/config.c b/config.c
> index 6421894614..05f369ec0d 100644
> --- a/config.c
> +++ b/config.c
> @@ -2914,7 +2914,7 @@ static int matches(const char *key, const char *value,
>  {
>  	if (strcmp(key, store->key))
>  		return 0; /* not ours */
> -	if (store->fixed_value)
> +	if (store->fixed_value && value)
>  		return !strcmp(store->fixed_value, value);
>  	if (!store->value_pattern)
>  		return 1; /* always matches */

Hmph. fixed_value is about the string given on the command line
being not a pattern.  And value that is NULL is the valueless "true"
in this case.

I would have actually expected the fix that follow your analysis (by
the way, I found it really well done) would say something more like

	if (strcmp(key, store->key))
		return 0; /* not ours */
+	if (!value)
+		value = "true";
	if (store->fixed_value)
		return !strcmp(store->fixed_value, value);

but I am not sure exactly how we want to handle synonymous Boolean
values here.  Regardless of how "true" value is spelled in the
configuration file, e.g.

        [section]               [section]
                key                     key = true

I wonder if "git config set --value=yes [--fixed-value] section.key
false" should replace either of them to false.

It would especially true if the command is invoked with --type=bool
but it seems that the --type option does not participate in the
matching with the current value.

> I'd like to hear from Stolee (CC'd), who is the author of c90702a1f6
> before submitting this as a standalone patch.

