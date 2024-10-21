Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45E718E373
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729509069; cv=none; b=YnCJAmVEe93/8Fa4dZ00cwVRCSyGSFlvpEz3yPcSSnnU0yOCwSPKQ+GYEEekFtajDCmFtr8h1vtL1lkLJQ5Fa7EDpl98F69yKKvFw69MrJ7LC4aOolTmq8D1yZqqLBFvHq2XslkKFh35TJMSHjpIXmCkuLP6xs2IKah/TOoe4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729509069; c=relaxed/simple;
	bh=s5ZRKz2qYk19wIVjD6vrY21+JqHE5xfBU9bXsOozWnI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FqAh8DgEYX82yPRA12Dd8WHZp2AMYeFhCMrv6LswTH1b6xKmGhQflWOoK6IlIqQGkuUPprr5Guav+r8RhISYhxps4v6ieKr0CuW4CRCBEy3X2C71umQcUcx7OX68KplF25a1kYXUA+OWpJuhP1eiZpfy3TQWrJggfdt5whcSlSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=CEcO676a; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="CEcO676a"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1729509061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HpVHTTYjFslr/24IUFNlm380k30JaEJ3FfI8imOgSMA=;
	b=CEcO676a9oFo/8pm6defILwWiwKTuDUAn4MWIyuWje2lEGSONKNOGHuBeGsr+18Eg2BJlR
	9PG4CEhJvaqkZIWNRyn/dA7+Jk5SBEzA6GIlMLN62S8sS0/E9k6d/mRrWoTf04bSu1ueP7
	xKiS7qaJ0MJHqsdUfwwJiP2O1GmP1kI=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] ref-filter: format iteratively with lexicographic
 refname sorting
In-Reply-To: <e0daa6a2eac97c2b18a53399b7c124fc8d3d238d.1729141657.git.ps@pks.im>
References: <a873ed828ccae426214cc8f87610df97ff9a269e.1729055871.git.ps@pks.im>
 <e0daa6a2eac97c2b18a53399b7c124fc8d3d238d.1729141657.git.ps@pks.im>
Date: Mon, 21 Oct 2024 13:10:44 +0200
Message-ID: <87ttd5btjf.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> [snip]
>
>  ref-filter.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index dd195007ce1..424a9cb50ae 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -3244,10 +3244,31 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
>  	return ret;
>  }
>  
> +struct ref_sorting {
> +	struct ref_sorting *next;
> +	int atom; /* index into used_atom array (internal) */
> +	enum ref_sorting_order sort_flags;
> +};
> +
>  static inline int can_do_iterative_format(struct ref_filter *filter,
>  					  struct ref_sorting *sorting,
>  					  struct ref_format *format)
>  {
> +	/*
> +	 * Reference backends sort patterns lexicographically by refname, so if
> +	 * the sorting options ask for exactly that we are able to do iterative
> +	 * formatting.
> +	 *
> +	 * Note that we do not have to worry about multiple name patterns,
> +	 * either. Those get sorted and deduplicated eventually in
> +	 * `refs_for_each_fullref_in_prefixes()`, so we return names in the
> +	 * correct ordering here, too.
> +	 */
> +	if (sorting && (sorting->next ||
> +			sorting->sort_flags ||
> +			used_atom[sorting->atom].atom_type != ATOM_REFNAME))
> +		return 0;
> +
>  	/*
>  	 * Filtering & formatting results within a single ref iteration
>  	 * callback is not compatible with options that require
> @@ -3258,7 +3279,6 @@ static inline int can_do_iterative_format(struct ref_filter *filter,
>  	 */
>  	return !(filter->reachable_from ||
>  		 filter->unreachable_from ||
> -		 sorting ||

Just a small nit, because we remove `sorting` from this condition, I
suggest to also remove the following comment above it:

	 * - sorting the filtered results


Otherwise no comments from my side.

-- 
Toon
