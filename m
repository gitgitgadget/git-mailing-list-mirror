Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE31B4223
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018982; cv=none; b=lUQw177jZ1NdarrHP6DMDqhiI4gAFtzie4wsJLce3iQ3OqDXBJXDOpUVcNN0ChA10jFArFrfpo11Qvz7vy/6Re5aMQlCXzWqL+uGKa1liUltO6d+qMN4KNJOtfwy5+blNwzZBqMF/h3vPRBqHfSe2/ejSd9sBD+6bbq+NXyiYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018982; c=relaxed/simple;
	bh=oFqd65v81oVVV7xtgeVKv4sQNTq/WL9YFjbkwHOTq74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IayWc673pBx9UEkXAhaIfnCxBW8mbdcGdWSDYOtYpnX+QapnKX44ZkJ2g/MWfFZ2S3PDZBhxSwbuwzzQBfg/YNAmUE+QY+LAfraxIbrqfSo3ETvmi0nNeEagQH0RoBCt3BYBaB27vG9xRPbxu5BuA513eWOvGLar/ZxnaxeluGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Hd5BCaDB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Hd5BCaDB"
Received: (qmail 207366 invoked by uid 109); 4 Sep 2025 20:49:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=oFqd65v81oVVV7xtgeVKv4sQNTq/WL9YFjbkwHOTq74=; b=Hd5BCaDBHj519OycVEViTZyiBfs3SOdtRSek5h2X1g117my+KhcpsmAVpXysaGwxnMKWPXmI24a2T98B9z1RycEL7zNIE87CmRc3E4pl7I+20agGwXvwv5s2RxaP8k3vk9375Pn26jotBgEN+kHtb/hNmpJQ4t5dKZTRI9j74xcqC4vUBTvwfWovdijk8eZ2H+bvJG/bA2bnACWJ4nhYuZYPJshebgk9brQyRHK5SPWQEhhINY/D+UXfMBmBL+URR1E5/ieoLo/qyB9fU9Is8CDFvVe7rUWrV6dXUHNs5tcK57sL0Z4gZMkGvvKrkOnKJYOvN7+V8diP0vytcLy7MQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Sep 2025 20:49:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 363726 invoked by uid 111); 4 Sep 2025 20:49:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Sep 2025 16:49:32 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 4 Sep 2025 16:49:32 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?44OO44Km44Op?= | Flare via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?B?44OO44Km44Op?= | Flare <nouraellm@gmail.com>
Subject: Re: [PATCH v5] alloc: fix dangling pointer in alloc_state cleanup
Message-ID: <20250904204932.GD30633@coredump.intra.peff.net>
References: <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
 <pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>

On Thu, Sep 04, 2025 at 05:44:16PM +0000, ノウラ | Flare via GitGitGadget wrote:

> -void clear_alloc_state(struct alloc_state *s)
> +void alloc_state_free_and_null(struct alloc_state **s_)
>  {
> +	struct alloc_state *s = *s_;
> +
>  	while (s->slab_nr > 0) {
>  		s->slab_nr--;
>  		free(s->slabs[s->slab_nr]);
>  	}
>  
>  	FREE_AND_NULL(s->slabs);
> +	FREE_AND_NULL(*s_);
>  }

It's probably not worth going back and forth on this too much, but I
thought the happy medium was:

  if (!s)
	return;

That is, it is perfectly reasonable and friendly for it to be a noop to
free-and-null a NULL value (either never initialized, or already freed).
The overkill was worrying about whether somebody passed in a NULL
double-pointer. I.e., doing:

  alloc_state_free_and_null(&foo);

is reasonable and should be idempotent but:

  alloc_state_free_and_null(NULL);

is a silly programming error that we do not need to protect against.

-Peff
