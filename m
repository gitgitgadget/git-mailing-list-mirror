Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD09656B7E
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705697077; cv=none; b=ZtjbMZ9A7/YakZoVexWesXvWxaQOTbMnSWOsEIl5iRSLhd/ncaKtBRlOXtFqtbvXfyXVaOoy8SLiYptiH1iddWRGzcT4SKvsPvqB20HbV4ety3uBrXnqRPfQo9nQIcg92KGxmhKWZeVrzNpKqmYJ96gcYNFRnhpDw5yTlIQ0FzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705697077; c=relaxed/simple;
	bh=cjWCe4yQHKA/ASAlxH1tRN9MeUAJCNWiK4Vf3e7g568=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uYHTo7rvJSblOoiIBir+6F/fuOIhgoqrw7nEwrbph00ezl3Agljb2fSBj16I39fQm1yqZLlG/mb16j4v+dfzmO6ui1eSBNXSxMybtoy1Lr9mrSSB+awF9B7bOu/lw8oeUdixvHaiTypr7sM1+/HqNe0qFR1So8P1BECK8yyTBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VZK6Rd/Y; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VZK6Rd/Y"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C18551D5DF6;
	Fri, 19 Jan 2024 15:44:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cjWCe4yQHKA/ASAlxH1tRN9MeUAJCNWiK4Vf3e
	7g568=; b=VZK6Rd/YzZIewUqwWQePC37WUiV9+rjCAxdO+HkRwPhjVQA7D/nf98
	PFEh1/HyOKbLYtkMUOfPgdbS/qdkJx3482MrgntYLHqfaUiBT50cO982wvCJmYNo
	vpsdBgUCqJXNrTAfkxsNonGncYwU0m3aBXJX0wMAh3giO7hEF/lqY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B97361D5DF5;
	Fri, 19 Jan 2024 15:44:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F35E1D5DF3;
	Fri, 19 Jan 2024 15:44:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] refs: make `is_pseudoref_syntax()` stricter
In-Reply-To: <20240119142705.139374-3-karthik.188@gmail.com> (Karthik Nayak's
	message of "Fri, 19 Jan 2024 15:27:02 +0100")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240119142705.139374-3-karthik.188@gmail.com>
Date: Fri, 19 Jan 2024 12:44:32 -0800
Message-ID: <xmqqwms5hx3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8D87E188-B70B-11EE-9F76-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Using this information we make the `is_pseudoref_syntax()` function
> stricter, by adding the check for "HEAD" suffix and for refs which don't
> end with the HEAD suffix, matching them with a predetermined list.

OK, so this partly answers my question on the previous step.  Before
making it more strict, the function worked only on the "syntax", so
a random string that can be a pseudo ref passed the check.

But stepping back a bit, if we call this function is_pseudoref_syntax(),
wouldn't it be what we want to have anyway?  You seem to want a
separate function called is_pseudoref() that rejects bogus uppercase
string "FOO_BAR" while accepting the known-good pseudoref you add
tests for, plus the ${FOO}_HEAD for any value of ${FOO} we currently
have and we may want to add in the future.

>  int is_pseudoref_syntax(const char *refname)
>  {
> +	/* TODO: move these pseudorefs to have _HEAD suffix */
> +	static const char *const irregular_pseudorefs[] = {
> +		"BISECT_EXPECTED_REV",
> +		"NOTES_MERGE_PARTIAL",
> +		"NOTES_MERGE_REF",
> +		"AUTO_MERGE"
> +	};
> +	size_t i;
>  	const char *c;
>  
>  	for (c = refname; *c; c++) {
> @@ -837,10 +845,17 @@ int is_pseudoref_syntax(const char *refname)
>  	}
>  
>  	/*
> -	 * HEAD is not a pseudoref, but it certainly uses the
> -	 * pseudoref syntax.
> +	 * Most pseudorefs end with _HEAD. HEAD itself is not a
> +	 * pseudoref, but it certainly uses the pseudoref syntax.
>  	 */
> -	return 1;
> +	if (ends_with(refname, "HEAD"))
> +		return 1;

I would imagine that at the final stage in which something like this
will be named is_pseudoref(), asking is_pseudoref("HEAD") would
return "No" (even though "is_pseudoref_syntax()", if the helper
function remains, may say "Yes" to "HEAD").  And this ends_with()
will use "_HEAD", instead of "HEAD".  But I am reading ahead of
myself, so let's keep going.

> +	for (i = 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
> +		if (!strcmp(refname, irregular_pseudorefs[i]))
> +			return 1;
> +
> +	return 0;
>  }
