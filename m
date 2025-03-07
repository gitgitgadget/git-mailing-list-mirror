Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008E21859D
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377464; cv=none; b=mHiv5tOc9WFO8V8dmwooLvnUIyrqz76MTomCzjHzD0Y2vP2p0HIT1aCoA1tOPB2B5A/JkSbt3ELwWyJx3qPLCH8f+9jm4Zv3YaefzkVKXz3FwfDWZBOvocD24UYc35fnn6D5DCSdbaR8tdCim3wHto4Jx8Hhj3uCGcjHVsutFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377464; c=relaxed/simple;
	bh=kxYSkTil+zN774aeVH0bgN609Rxu0KTpIowyT7I5mv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTJlFoPCywC12OYzk5ClqEOSYZMRipSJpivlVYDjxVBNqaIZpByG5adpvzBSA8iuQgi3bpZs/1rTo4SYpoNKC2PjrzKJuC1ccZjZXnFjdZI35Z8TrfO34aiDAsBb0FAkFHiJh7OUdg6yWIMyc5pXJopkq2cyUtMKI7cdZYWZ1rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LIOfKpPH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LIOfKpPH"
Received: (qmail 19638 invoked by uid 109); 7 Mar 2025 19:57:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kxYSkTil+zN774aeVH0bgN609Rxu0KTpIowyT7I5mv8=; b=LIOfKpPHylUvd0KGruSSTRe3aTB7VNCE81yvj1WHeu0na1u5s1+bapq3GpfwV+cZQXpoVyQu7ZEYdQJOIxfa2Ra9W2GaCNRXhW9eVDa/8Mj9q0zyLHJXP92bhJu3oIByUYQkavk0dPXLJw2S7sYmSjEeik2NJjlek5jBX1u8GniazLV3UU4U3QwW+cATvfrISUMNXU+kH0sIDAOFldWF9KADzlp7RavGp9nLWgtgV8MkHpmAdgqC9CC5LP7hsUH7TPzFyRkMCcHF7LUo/THHA2YppjUOiyWbdVtzLVBa6lrkKECOVHqunrs05MvPtQHpHmmVCjgSqzZEQqLRLv7fsg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Mar 2025 19:57:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17227 invoked by uid 111); 7 Mar 2025 19:57:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Mar 2025 14:57:41 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 7 Mar 2025 14:57:40 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH v3 6/8] refs: implement partial reference transaction
 support
Message-ID: <20250307195740.GA3675378@coredump.intra.peff.net>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
 <20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>

On Wed, Mar 05, 2025 at 06:39:01PM +0100, Karthik Nayak wrote:

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 0132b8b06a..dd9912d637 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1371,8 +1371,15 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  					    transaction->updates[i],
>  					    &refnames_to_check, head_type,
>  					    &head_referent, &referent, err);
> -		if (ret)
> +		if (ret) {
> +			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
> +				strbuf_setlen(err, 0);
> +				ret = 0;
> +
> +				continue;
> +			}
>  			goto done;
> +		}
>  	}
>  
>  	string_list_sort(&refnames_to_check);

Coverity complains that this "ret = 0" is a dead store. I think it's
right, because either:

  1. Our continue loops again, and we overwrite "ret" with the next call
     to prepare_single_update().

  2. We leave the loop (because this is the final entry in the
     transaction update array), and then we overwrite "ret" with the
     result of refs_verify_refnames_available().

But it may be better to leave it in place as a defensive measure against
the rest of the function changing.

-Peff
