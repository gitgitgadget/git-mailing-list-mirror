Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E64522F
	for <git@vger.kernel.org>; Mon, 12 May 2025 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055601; cv=none; b=u+4qd+5T3SL5ULkV+FL3qAsROvzilYoVuA9DJJqGzLpYb9WisX/HYDzYXOVSH8gezSGAed8cT3hwp8UqE/18VwN03ZGSVUoeaN2Q9tvsN2oeidNmDCfvirNXcVZMJP3VIVz/lMiHHr9YM2ce6fhwi8vTQpkGk87Ch2/wD2l/OVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055601; c=relaxed/simple;
	bh=oLaRzHvM5kYhRUzlMCXejw08nY/PlsR7+nZcSoV8UOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLP3xg+cVlZlp5dXfWh3h7xSc3F345jY4atu+gll5/ivWirrktlWDwwitddbKW/8o4PCqNZC55S7X/uhp6Fvyy96+xc6Q8Lp+kYR1XY7sZ95E9fpHm2phrcHSULTn9wF0byTjl0UaYh/C1YVf7zxINOCRl1dP9M08joA4qfakSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FPovrkM3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FPovrkM3"
Received: (qmail 1621 invoked by uid 109); 12 May 2025 13:13:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=oLaRzHvM5kYhRUzlMCXejw08nY/PlsR7+nZcSoV8UOs=; b=FPovrkM3djj1bh7TBdq3TA72QsFhJcIO2PBl12oky8Td637i2zyfUJG+pc4+IVaLL3OnppGKRkQ/k18QlLBumBuZ9dHVgFJGsM67L4YqKBIjHkveo/idTYFJiFj0pbtoDjj6Bg2dBiQtelqISuCU8G9SuI+pssPOyRM7sriI18IpDAl7BvKf7Z3WX+s/jQvH9GOgbIzkMt1z5HrGb4Kerta2K1RUof60nuOwCuytz+XqWdJE0Ea0pik60M0vpdmRdANKVB2RYlymtjFzZVqvzLFLybwqU7gx6DHqYLfML/zTZWCY3Bs5FzT3lLiZRICFymauY4eRCeR8F2B/iNbMuw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 May 2025 13:13:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6263 invoked by uid 111); 12 May 2025 13:13:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 May 2025 09:13:16 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 12 May 2025 09:13:15 -0400
From: Jeff King <peff@peff.net>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] pack-bitmap: fix memory leak if `load_bitmap_entries_v1`
 failed
Message-ID: <20250512131315.GD1191360@coredump.intra.peff.net>
References: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>

On Mon, May 12, 2025 at 12:22:10PM +0000, Lidong Yan via GitGitGadget wrote:

> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> 
> In pack-bitmap.c:load_bitmap_entries_v1, the function `read_bitmap_1`
> allocates a bitmap and reads index data into it. However, if any of
> the validation checks following the allocation fail, the allocated bitmap
> is not freed, resulting in a memory leak. To avoid this, the validation
> checks should be performed before the bitmap is allocated.

Thanks, this looks correct to me.

> @@ -388,10 +388,6 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
>  			return error(_("corrupt ewah bitmap: commit index %u out of range"),
>  				     (unsigned)commit_idx_pos);
>  
> -		bitmap = read_bitmap_1(index);
> -		if (!bitmap)
> -			return -1;
> -
>  		if (xor_offset > MAX_XOR_OFFSET || xor_offset > i)
>  			return error(_("corrupted bitmap pack index"));

I noticed that this code is also within a loop, so we could still return
early on the next loop iteration. But by that point we will have called
store_bitmap() on the result, so we only have to worry about leaking the
bitmap from the current loop iteration.

-Peff
