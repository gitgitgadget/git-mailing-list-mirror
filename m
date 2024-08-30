Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E96165EE0
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 21:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725055146; cv=none; b=QHHMRyL5HcBumyhJGgagAYUAAVD52TygTfSSaefNsgWwPIpqwe0eb1mpkshTXnzAzPePiR1Z44iYlsKwr7SJdEMkFHvT4rKd4BJ+ttW7pZiwQzw8AzE9q8ahIMSZqQ86s82ihWvIL7FOozhItMbyM9QylBIZ+faCsFvNUtxDi4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725055146; c=relaxed/simple;
	bh=JYVRtdfnMJXV9bY7KZfqJLYyJxffgZkIYUM+5sQlOFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=laTYLV2Yu9DW05hz0C+Ie7iF4rs69ElbhUSCUY5rIVa/gP8Z/TKgDxy1hLBqBlgE5L4hXif/phI1TtmOP06LG2fhnwikjdTADX9VzK/2sUQPiBRx0dZ+EJfFzRFp3J2cYHEOb2nUhT9CEKy3gTSGfv6O4lFyPJB/9QvY0ni1mTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=S2tWK1zM; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S2tWK1zM"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A7EDE22776;
	Fri, 30 Aug 2024 17:59:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JYVRtdfnMJXV9bY7KZfqJLYyJxffgZkIYUM+5s
	QlOFI=; b=S2tWK1zMaUthaATWeUcsjHP7s/FAdeJOWp6GgE+bqmh0lsr8AqLjtW
	LFzmuknmXeus5sqbes2lD4+nyLYv1w94LbM86bP/AchB0QYjDVa1SOs/MltHb8fr
	cWiZWlpIvUtx7vHkMRI1eqMg/hKbujf2ddtHDSZwTr1hMQ/2lKkJ0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 976D022775;
	Fri, 30 Aug 2024 17:59:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD7EC22774;
	Fri, 30 Aug 2024 17:59:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/22] builtin/push: fix leaking refspec query result
In-Reply-To: <92fc97b3db86bb0bdf610a2f76c03a96a99bfe8d.1724656120.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 26 Aug 2024 09:21:45 +0200")
References: <cover.1724656120.git.ps@pks.im>
	<92fc97b3db86bb0bdf610a2f76c03a96a99bfe8d.1724656120.git.ps@pks.im>
Date: Fri, 30 Aug 2024 14:59:01 -0700
Message-ID: <xmqqttf1pt96.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 11A036AE-671B-11EF-897F-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When appending a refspec via `refspec_append_mapped()` we leak the
> result of `query_refspecs()`. The overall logic around refspec queries
> is quite weird, as callers are expected to either set the `src` or `dst`
> pointers, and then the (allocated) result will be in the respective
> other struct member.

Hmph, is it necessary to say "quite weird" for the purpose of this
change?  The query interface is designed to be usable to query both
ways and within that constraints, I find it designed very nicely
(but I do not think that is necessary to be said for the purpose of
this change, either)..

> As we have the `src` member set, plugging the memory leak is thus as
> easy as just freeing the `dst` member. While at it, use designated
> initializers to initialize the structure.

In order to understand this paragraph, of course, it helps for a
reader to understand that the query_refspecs() gives an answer by
populating the side other than the query side, and the answers are
what we want to release.

> This leak was exposed by t5516, but fixing it is not sufficient to make
> the whole test suite leak free.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/push.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 7a67398124f..0b123eb9c1e 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -72,13 +72,15 @@ static void refspec_append_mapped(struct refspec *refspec, const char *ref,
>  	const char *branch_name;
>  
>  	if (remote->push.nr) {
> -		struct refspec_item query;
> -		memset(&query, 0, sizeof(struct refspec_item));
> -		query.src = matched->name;
> +		struct refspec_item query = {
> +			.src = matched->name,
> +		};

This is "while at it" change that does not contribute to the leak or
the leakfix; the resulting code is easier to read.

>  		if (!query_refspecs(&remote->push, &query) && query.dst) {
>  			refspec_appendf(refspec, "%s%s:%s",
>  					query.force ? "+" : "",
>  					query.src, query.dst);
> +			free(query.dst);

And this is the real fix, which looks good.

Thanks.

>  			return;
>  		}
>  	}
