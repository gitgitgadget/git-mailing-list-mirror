Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49953081AC
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350288; cv=none; b=suMkJnr69fADPar8SqxizDpkeI7/WI/FejdSdOOmNK2wQeIW2/aPWYrWbwAVjMpZ+hx2ryEeJyPeco6dzctajCWrYmaC/Qv72+5SzFunnutZA4QqCdoEkSVsxG0QkDBFhSRCk8o7wTIQ/bEm5zYnlSXZp0VMCJmVtmRr+iZjRnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350288; c=relaxed/simple;
	bh=kuE+OWhuuX7ec/oO46wIUkgEUaAhKgBtCs/7DY5TpoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQORsu3EvW8+q8C99HHmcuRVW5cUMf7EVh1Op263DG7dU3TiS2q7Ykf6MeVv+OQiXfnpRg/IJwt+b++xJqVZA79rztMTh4toyTaE7twHzZUmn8CGehu+Va3GULgClqYtmyNnAYFm2tM42F0TOAOAv+ytkGOcMWEHse6wfv56bck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=F0Mw21eR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="F0Mw21eR"
Received: (qmail 21950 invoked by uid 109); 8 Sep 2025 16:51:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kuE+OWhuuX7ec/oO46wIUkgEUaAhKgBtCs/7DY5TpoA=; b=F0Mw21eRARd00UetxGq0r86qGb6GCF+j3JGwnOWyyqbQ2Kth7xHDsKjZih62gGmgvRRMXUN4TqR/Z6dv95ZJG+2hUu6nLTeSBX4QKTEZDiPy72XK3Muoqf8ZxQwPZjIf2D63wvFolBMDmNGRYMF7bc9WB7YUfvS19PLTxvDIrecV/Eo/GPxNGB/Hk6O5mKzYK7qEMu8ebHv3AkBPtg8jMApJwCYJ8NNcozZ03PbuGv8GyeDNpr7i+v4nmmwtzBaxsiVePqFIsaWHTEwoNB0gZ+rl60I2S3My845yLq54lwZtMo7wcje4ZjuIjS1nrZmaZyqjHnID3kkVIsYmkSz3Qg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Sep 2025 16:51:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 36316 invoked by uid 111); 8 Sep 2025 16:51:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Sep 2025 12:51:25 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Sep 2025 12:51:25 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] upload-pack: don't ACK non-commits repeatedly in
 protocol v2
Message-ID: <20250908165125.GA1324063@coredump.intra.peff.net>
References: <20250905-b4-pks-upload-pack-repeated-non-commit-acks-v2-0-d2e67f3cb94c@pks.im>
 <20250905-b4-pks-upload-pack-repeated-non-commit-acks-v2-2-d2e67f3cb94c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905-b4-pks-upload-pack-repeated-non-commit-acks-v2-2-d2e67f3cb94c@pks.im>

On Fri, Sep 05, 2025 at 08:18:02AM +0200, Patrick Steinhardt wrote:

>  	if (o->type == OBJ_COMMIT) {
>  		struct commit_list *parents;
>  		struct commit *commit = (struct commit *)o;
> -		if (o->flags & THEY_HAVE)
> -			we_knew_they_have = 1;
> -		else
> -			o->flags |= THEY_HAVE;
> +
>  		if (!data->oldest_have || (commit->date < data->oldest_have))
>  			data->oldest_have = commit->date;
>  		for (parents = commit->parents;
> @@ -497,11 +494,13 @@ static int do_got_oid(struct upload_pack_data *data, const struct object_id *oid
>  		     parents = parents->next)
>  			parents->item->object.flags |= THEY_HAVE;
>  	}
> -	if (!we_knew_they_have) {
> -		add_object_array(o, NULL, &data->have_obj);
> -		return 1;
> -	}
> -	return 0;
> +
> +	if (o->flags & THEY_HAVE)
> +		return 0;
> +	o->flags |= THEY_HAVE;
> +
> +	add_object_array(o, NULL, &data->have_obj);
> +	return 1;
>  }

Just looking at the old code and its "we_knew_they_have" variable, I
wondered why we didn't need it here anymore. In the old code, we set our
(o->flags) THEY_HAVE flag up front, and then do some more processing on
the parents, and then decide on our return value. So we need to remember
the state before we set our flag.

In the new code, we do all of the parent processing and then return
immediately. So we can just do so by checking the flag without an extra
variable.

And we know that is correct to check the flag after the parent
processing because we should not be setting THEY_HAVE on o->flags as
part of that. It would imply that a commit is its own parent.

So I think this looks fine, but I wanted to read through carefully (and
out loud) to make sure there wasn't a subtle gotcha.

-Peff
