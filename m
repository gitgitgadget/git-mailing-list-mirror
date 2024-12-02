Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD2F3D97A
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172762; cv=none; b=KjTB5a/BPe+Zb2/s/3YVKtLxewdCcIMt8waN1jX2nhEu8NG3gzawrOHmR9QiN/Ggnc4X5Jd4QbfSK0Tu+fN6N7SrEbl9uZwvlkTfaFcMieqUfKWi0qb9Y5NLrk3vtzcJVzaGoRLl02SQrmGtDPDvAVoc7K9JAm/XNl8LaAHlCFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172762; c=relaxed/simple;
	bh=vWHJhj0xtZWiC/D0NH0tgr1xAtzb2IH6IX8HihVa1S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htJ+vFrbVqruJ/VeuGWoD2mXnRtXY5FdkCaQlYZIjtOAkYcDU/N34kz3ubD7AiO+o69on4sYeCxfmtXEORWLDnJTIZtc8MrqwO+tHLISxo8zdQDcnvQbGl947Whq+I4g88OzASX66urbEBHATjv1sOFGinly5ztuXR1cqr73XKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=F8NGBisa; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="F8NGBisa"
Received: (qmail 16694 invoked by uid 109); 2 Dec 2024 20:52:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vWHJhj0xtZWiC/D0NH0tgr1xAtzb2IH6IX8HihVa1S4=; b=F8NGBisaF7ddskDW+5MqDy9ytFXj5sBHNFlcT+C8LQ/MzgB/xAyX6fcNGDfW3lLnoqe4fGsB3XyGngHNmzcNz9fXuGY/32Q1k5ktKAeRq3q/e8Fxc6S74Uu5fO2ArJT8SGwd/8BjjdkCfEbf3yWNAhIjl+Gj0hHJzDXE8J1RFuh8Dh3s1LHaPxuICkgRP2+Wzlaxqk7tKurfnFmSTKwCz1WCO4yZ0ZWb3rStXIx0jMjh3k875ZPhYZPg3T8xkn0hkXU0YoHm1kQDEsFOJ1xWHtV4lDKWGxrLUeahrj6wZzYQuurqSvG1iPASnEE8bkZUO8D05ardz2VHiLdKgjDbTA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Dec 2024 20:52:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26316 invoked by uid 111); 2 Dec 2024 20:52:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Dec 2024 15:52:38 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Dec 2024 15:52:38 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, git@jowil.de
Subject: Re: [PATCH 3/4] t5604: do not expect that HEAD is a valid tagname
Message-ID: <20241202205238.GD776185@coredump.intra.peff.net>
References: <20241202070714.3028549-1-gitster@pobox.com>
 <20241202070714.3028549-4-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241202070714.3028549-4-gitster@pobox.com>

On Mon, Dec 02, 2024 at 04:07:13PM +0900, Junio C Hamano wrote:

> 09116a1c (refs: loosen over-strict "format" check, 2011-11-16)
> introduced a test piece (originally in t5700) that expects to be
> able to create a tag named "HEAD" and then a local clone using the
> repository as its own reference works correctly.  Later, another
> test piece started using this tag starting at acede2eb (t5700:
> document a failure of alternates to affect fetch, 2012-02-11).
> 
> But the breakage 09116a1c fixed was not specific to the tagname
> HEAD.  It would have failed exactly the same way if the tag used
> were foo instead of HEAD.
> 
> Before forbidding "git tag" from creating "refs/tags/HEAD", update
> these tests to use 'foo', not 'HEAD', as the name of the test tag.

Yeah, I think this is worth doing independently. The patch looks good,
though...

> @@ -131,7 +131,7 @@ test_expect_success 'cloning with multiple references drops duplicates' '
>  
>  test_expect_success 'clone with reference from a tagged repository' '
>  	(
> -		cd A && git tag -a -m tagged HEAD
> +		cd A && git tag -a -m tagged foo
>  	) &&
>  	git clone --reference=A A I
>  '
> @@ -156,10 +156,10 @@ test_expect_success 'fetch with incomplete alternates' '
>  		git remote add J "file://$base_dir/J" &&
>  		GIT_TRACE_PACKET=$U.K git fetch J
>  	) &&
> -	main_object=$(cd A && git for-each-ref --format="%(objectname)" refs/heads/main) &&
> +	main_object=$(git -C A rev-parse --verify refs/heads/main) &&
>  	test -s "$U.K" &&
>  	! grep " want $main_object" "$U.K" &&
> -	tag_object=$(cd A && git for-each-ref --format="%(objectname)" refs/tags/HEAD) &&
> +	tag_object=$(git -C A rev-parse --verify refs/tags/foo) &&
>  	! grep " want $tag_object" "$U.K"
>  '

I notice that you swapped out "cd A && git" for "git -C A" in the second
hunk (evne in the line which does not otherwise need to be touched). I
think that is good, but is it worth doing the same in the first hunk?
That would actually let us drop the subshell.

-Peff
