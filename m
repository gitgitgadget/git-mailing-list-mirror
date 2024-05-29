Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E8E15B573
	for <git@vger.kernel.org>; Wed, 29 May 2024 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717011600; cv=none; b=QsvDaUTLpmI1AkV/V18T55Ui/dfhMSPpYxy+8UgS7M/rkMt3ojf2CSqHxvuBR2YsaiIklXzKcQdaybJaraOtLNlHV2hrjJEHgY9KZZT+v1Onk3u4PMPCtCuDvyAKJkyJS8YzH2rgVDTYbuK4KT+O3JnS55lWjt4v+idbKelzlXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717011600; c=relaxed/simple;
	bh=fUY6R8BoyyEA8jSbzwVBUDaGLWEoFZ0tPn2lZ68UutM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NWcNLr4k0S/KWrtZM6CEPCghJ1i2YEHq1WVelbKWdESkpXbcOKW/m5n82Lmy7/z+V01k3LKsjBK98YI+JtrPvz7Vpqc00tayKa1MxtiOxdnxdi2zwZ+SyJB+JF/8gPtLnhCoGxWbiectjKgiIVYDwTLRMN5cD9U0i0txsn24fQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W199aMYT; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W199aMYT"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09E77340DE;
	Wed, 29 May 2024 15:39:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fUY6R8BoyyEA8jSbzwVBUDaGLWEoFZ0tPn2lZ6
	8UutM=; b=W199aMYTNsOuKcpE8ImUSdzLKERDg0ueFhMH7n8Kve1xEazz8yB0MB
	cDkrYF98moxb9SUL0WnhOCOx8b9a6rhW/c6w7xLAq1KGdZNMPDboz1RRuHGCwNbH
	CDqnRJYNPJWPFhkw05/YU4yxoY4wZdKCyJFLh8zDDFtmImT5DmIik=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 00D8B340DD;
	Wed, 29 May 2024 15:39:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B4E1340DC;
	Wed, 29 May 2024 15:39:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/19] http: do not assign string constant to non-const
 field
In-Reply-To: <03b13c449b52ecfc845e8ffb0dd69fe67d50651c.1716983704.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 29 May 2024 14:44:35 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<03b13c449b52ecfc845e8ffb0dd69fe67d50651c.1716983704.git.ps@pks.im>
Date: Wed, 29 May 2024 12:39:50 -0700
Message-ID: <xmqqy17swgop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 37580F78-1DF3-11EF-B81C-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In `write_accept_language()`, we put all acceptable languages into an
> array. While all entries in that array are allocated strings, the final
> entry in that array is a string constant. This is fine because we
> explicitly skip over the last entry when freeing the array, but will
> cause warnings once we enable `-Wwrite-strings`.
>
> Adapt the code to also allocate the final entry.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  http.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/http.c b/http.c
> index 67cc47d28f..2dea2d03da 100644
> --- a/http.c
> +++ b/http.c
> @@ -1974,7 +1974,7 @@ static void write_accept_language(struct strbuf *buf)
>  
>  		/* add '*' */
>  		REALLOC_ARRAY(language_tags, num_langs + 1);
> -		language_tags[num_langs++] = "*"; /* it's OK; this won't be freed */
> +		language_tags[num_langs++] = xstrdup("*");
>  
>  		/* compute decimal_places */
>  		for (max_q = 1, decimal_places = 0;
> @@ -2004,8 +2004,7 @@ static void write_accept_language(struct strbuf *buf)
>  		}
>  	}
>  
> -	/* free language tags -- last one is a static '*' */
> -	for (i = 0; i < num_langs - 1; i++)
> +	for (i = 0; i < num_langs; i++)
>  		free(language_tags[i]);
>  	free(language_tags);
>  }

Makes sense, especially that this is done only once per process.

