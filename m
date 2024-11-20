Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5805155C87
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091888; cv=none; b=Bss0dTC9p9TY71F1IOS3MS/iaPtoOrUGABxewioYM7+qRHu/vPASZRmN6JGc1Dawi+PJYyUVRNr4BFHK72+CXlFMDIjZL0h/QdJl7Z7nHPIRhQ2nr0ghu/3EcYx9FpLc+vSEOWS7yM7LPRgdk/tZre2m2KyZ+fvXC+/MlAq3bOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091888; c=relaxed/simple;
	bh=Fi22kLE5RhaNSBrzi7yz/IWIHGYqD5TRujV5rk47hVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PiBLT5GeLpeQoDmGc82SEZvhM3+nf+iVVAMWVpCteYRiwP7nVFNt8qvtbcJRXHsEDi1UYCIFJ/2VVNKegaOwznJz99pZoIswl1OvUZQiFiE3jSr+M8DdcNquLYJQlI8K8ooSIMEQ5GAtQF6bfan/Ousf6sWU0dXWW79KAWlVngE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=goEIF1Qh; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="goEIF1Qh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1732091878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dpWfsE2HDAxLLt66nxrvT/QOXRvC3VcIKVxixmAYQSU=;
	b=goEIF1QhOeq5vmFWvr2zLl8FIwBnd0OvY+P1CwCU0o6RXJIBn4W0FTUQ/vTomjHqywiiUI
	OPHMHwS+d/XFXcBxsG5g4ZZvoApW5Z6lXjtQ+8Sl/fsWnSqGENVGhbtZasJFl3GIv8sVY0
	hE7VcHL/5vbPnp/ufN4rWObKuow2S74=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v2 09/27] strvec: introduce new `strvec_splice()` function
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-9-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
 <20241111-b4-pks-leak-fixes-pt10-v2-9-6154bf91f0b0@pks.im>
Date: Wed, 20 Nov 2024 09:37:40 +0100
Message-ID: <877c8yti5n.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Introduce a new `strvec_splice()` function that can replace a range of
> strings in the vector with another array of strings. This function will
> be used in subsequent commits.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  strvec.c              | 19 +++++++++++++++
>  strvec.h              |  9 +++++++
>  t/unit-tests/strvec.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+)
>
> diff --git a/strvec.c b/strvec.c
> index f712070f5745d5f998d0846ac4009441dddfa500..81075c50cca4fe44608775541d876294a79d9e4e 100644
> --- a/strvec.c
> +++ b/strvec.c
> @@ -56,6 +56,25 @@ void strvec_pushv(struct strvec *array, const char **items)
>  		strvec_push(array, *items);
>  }
>  
> +void strvec_splice(struct strvec *array, size_t pos, size_t len,
> +		   const char **replacement, size_t replacement_len)
> +{
> +	if (pos + len > array->alloc)
> +		BUG("range outside of array boundary");

Why aren't you checking against array->nr? I was trying a test case for
this, and this seems to be unexpected behavior:

	void test_strvec__splice_insert_after_nr(void)
	{
		struct strvec vec = STRVEC_INIT;
		const char *replacement[] = { "1" };

		strvec_pushl(&vec, "foo", "bar", "baz", "buzz", "fuzz", NULL);
		strvec_pop(&vec);
		check_strvec(&vec, "foo", "bar", "baz", "buzz", NULL);
		strvec_pop(&vec);
		check_strvec(&vec, "foo", "bar", "baz", NULL);
		strvec_pop(&vec);
		strvec_splice(&vec, 4, 1, replacement, ARRAY_SIZE(replacement));
		check_strvec(&vec, "foo", "bar", "baz", NULL, "1", NULL);
		strvec_clear(&vec);
	}

> +	if (replacement_len > len)
> +		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
> +			   array->alloc);
> +	for (size_t i = 0; i < len; i++)
> +		free((char *)array->v[pos + i]);
> +	if (replacement_len != len) {
> +		memmove(array->v + pos + replacement_len, array->v + pos + len,
> +			(array->nr - pos - len + 1) * sizeof(char *));
> +		array->nr += (replacement_len - len);
> +	}
> +	for (size_t i = 0; i < replacement_len; i++)
> +		array->v[pos + i] = xstrdup(replacement[i]);
> +}
> +
>  const char *strvec_replace(struct strvec *array, size_t idx, const char *replacement)
>  {
>  	char *to_free;
> diff --git a/strvec.h b/strvec.h
> index 4b73c1f092e9b016ce3299035477713c6267cdae..4e61cc9336938a95318974903f9b35dcdc4da1cd 100644
> --- a/strvec.h
> +++ b/strvec.h
> @@ -67,6 +67,15 @@ void strvec_pushl(struct strvec *, ...);
>  /* Push a null-terminated array of strings onto the end of the array. */
>  void strvec_pushv(struct strvec *, const char **);
>  
> +/*

Tiniest nit: I see the majority of the function comments in this file
start with a double asterisk, should we do the same here?

> + * Replace `len` values starting at `pos` with the provided replacement
> + * strings. If `len` is zero this is effectively an insert at the given `pos`.
> + * If `replacement_len` is zero this is effectively a delete of `len` items
> + * starting at `pos`.
> + */
> +void strvec_splice(struct strvec *array, size_t pos, size_t len,

In this file we seem to commonly use `idx` instead of `pos`.


-- 
Toon
