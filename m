Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCA1DB95E
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 05:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642344; cv=none; b=IVHX0GNYEH17/vPC7jFDTIyvtYQxY/IKYtxv8yDGEvrE2KSCOCFEAzWfwatF4dWX4Ht5ZG6lMUfDcu760eb4tTchFYxamD4LSTmPrFlwOALaYyBZ8e4KvhufsxszyoEIF+AGPH3oDz8Mf1KorJLOKCeaUBry4WIfGOjjRcMlseY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642344; c=relaxed/simple;
	bh=qA+pJwnEMNnMlAt8wInJMWLT+WFy5VYHZdNeQ+i1dfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0OCCr0ggMzhbZTZdyKIr/kfn50rrXvqEkxR5HH0rylbuNLDMmM9WMzMNO3E26shNC41viw+Eq3luR5Kdyc3zZxzoMS3z8E+waa0FbZBsMWTklmOyQUl3j5/Leo5+hWnIuRJI/+vrbNk295p6fdEDVLop6W9EaNiHYZPb855XMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XZRxGrQR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XZRxGrQR"
Received: (qmail 522 invoked by uid 109); 16 Jul 2025 05:05:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=qA+pJwnEMNnMlAt8wInJMWLT+WFy5VYHZdNeQ+i1dfE=; b=XZRxGrQRUPDHWJ59fvXHzPOg/eyIOSNcJbBGPfW6f94nqsueU3dLxBPNTOq9wKykurB6CG3mBNhICVmwWC/j5g3roRsG74AUqZd5dybZxiog9Z/unI5X0eLOk1gOABZYC7YA70ATrv0Aldx+NDwzXH3WV9K76qVDDZkbGLg1FhuV03NwbqeifmVEvqVlE5G4Rx2ihvn33QfsuURfHXrxg4naDUuDY2LvHIDElVWUCnpTrsoL+qTQF0Q7/be+rasSJ2u88Rw+UG13l5HvOrIdJfidktpjn0TDuBOmW+IWPr5eUUQFCecV7lgfaJc1Bizkaq7HC30YUmpuLe7vTaXJvg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jul 2025 05:05:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9655 invoked by uid 111); 16 Jul 2025 05:05:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jul 2025 01:05:45 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 16 Jul 2025 01:05:40 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] commit: convert pop_most_recent_commit() to
 prio_queue
Message-ID: <20250716050540.GB1396022@coredump.intra.peff.net>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de>

On Tue, Jul 15, 2025 at 04:51:07PM +0200, René Scharfe wrote:

> pop_most_recent_commit() calls commit_list_insert_by_date(), which and
> is itself called in a loop, which can lead to quadratic complexity.
> Replace the commit_list with a prio_queue to ensure logarithmic worst
> case complexity and convert all three users.

I guess I'm cc'd because of my frequent complains about the quadratic
nature of our commit lists? :)

Mostly I asked because I had to look at pop_most_recent_commit() to see
what operation would be made faster here. Looks like it's mostly ":/",
but maybe also fetch's mark_recent_complete_commits()? I guess we might
hit that if you have a huge number of refs?

Anyway, I am in support of the direction regardless.

I actually have a series turning rev_info.commits into a prio_queue
which I need to polish up (mostly just writing commit messages; I've
been running with it for almost 2 years without trouble). Ironically it
does not touch this spot, as these commit lists are formed on their own.

The patch itself looks reasonable. I think here:

> @@ -1461,7 +1462,7 @@ static int get_oid_oneline(struct repository *r,
>  			   const char *prefix, struct object_id *oid,
>  			   const struct commit_list *list)
>  {
> -	struct commit_list *copy = NULL, **copy_tail = &copy;
> +	struct prio_queue copy = { compare_commits_by_commit_date };
>  	const struct commit_list *l;
>  	int found = 0;
>  	int negative = 0;
> @@ -1483,9 +1484,9 @@ static int get_oid_oneline(struct repository *r,
>  
>  	for (l = list; l; l = l->next) {
>  		l->item->object.flags |= ONELINE_SEEN;
> -		copy_tail = &commit_list_insert(l->item, copy_tail)->next;
> +		prio_queue_put(&copy, l->item);
>  	}
> -	while (copy) {
> +	while (copy.nr) {
>  		const char *p, *buf;
>  		struct commit *commit;
>  		int matches;

our callers are always generating and passing in a list. So we could
avoid the overhead of allocating the list in the first place by just
taking a prio_queue. But maybe it gets weird with clearing the
ONELINE_SEEN marks? We make a copy even in the current code so that we
can call clear_commit_marks() on the complete set.

I guess we could add them to an array or something, but that probably
ends up being roughly the same amount of work.

> +build_history () {
> +	local max_level="$1" &&
> +	local level="${2:-1}" &&
> +	local mark="${3:-1}" &&
> +	if test $level -eq $max_level
> +	then
> +		echo "reset refs/heads/master" &&
> +		echo "from $ZERO_OID" &&
> +		echo "commit refs/heads/master" &&
> +		echo "mark :$mark" &&
> +		echo "committer C <c@example.com> 1234567890 +0000" &&
> +		echo "data <<EOF" &&
> +		echo "$mark" &&
> +		echo "EOF"
> +	else
> +		local level1=$((level+1)) &&
> +		local mark1=$((2*mark)) &&
> +		local mark2=$((2*mark+1)) &&
> +		build_history $max_level $level1 $mark1 &&
> +		build_history $max_level $level1 $mark2 &&
> +		echo "commit refs/heads/master" &&
> +		echo "mark :$mark" &&
> +		echo "committer C <c@example.com> 1234567890 +0000" &&
> +		echo "data <<EOF" &&
> +		echo "$mark" &&
> +		echo "EOF" &&
> +		echo "from :$mark1" &&
> +		echo "merge :$mark2"
> +	fi
> +}

This took some brain cycles to decipher. It looks like we'll make
2^$level commits in a filled tree? It might be worth a brief comment
describing the goal (and maybe even giving an example graph drawing for
N=3 or something, though it gets out of hand quickly).

> +test_perf "rev-parse ':/$(cat needle)'" "
> +	git rev-parse ':/$(cat needle)' >actual
> +"

Hmm, usually we frown on putting snippets inside double-quotes because
it's so easy to accidentally interpolate outside of the test_eval. But
maybe this is short enough to be OK. I guess you did it here especially
so that the title is a nice ":/65535" and not the opaque "$(cat
needle)".

-Peff
