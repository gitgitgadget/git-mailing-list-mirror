Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F27E1684BB
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654909; cv=none; b=VsY327WnOqbFYw01VuPj8HOsUq2p5/XPxxQkJEjaPIKg9rITiK+aXYWI1fL8XfZD7xrQJA4xtqlYMYujns9gO5vYEqqJSLbGisLWR55OUWLYJMoF3R6YEqVg47LdSsIh13W2nvBg8u4GcOjGLuTxEutQrtQNsCF/+btf/fUs4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654909; c=relaxed/simple;
	bh=RzH4i4MNhjsl0FCXiBkb2viwQyfnwXzykpxgdnhkRPo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qFi3A1B6D65Jw0YVhXmHBupGBcrizD1zK1p6JbkLaaCewT8IljvPofb57M/SQLQs0jG9BinMMzUnN+hk/TaBEQKl6uFEl2j3sfLOe6HuQ9227UsItzY0vjLABhZL/cw1j3MJhGXf49uFgVIWSQI+CC0sQtO77RGVhe1+oUiwQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=L+S3lwPB; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L+S3lwPB"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CC50023D8A;
	Mon, 17 Jun 2024 16:08:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RzH4i4MNhjsl0FCXiBkb2viwQyfnwXzykpxgdn
	hkRPo=; b=L+S3lwPBrisho89cDyfRGoBUfG0rqQk0PNjZZ84EalBw6/Wz2Crlzn
	/LaF6kkOujXnJssSC2IFznzZwyVCpHFAwcHMRJ/Y8n0gbaHg887LBsX/GGWQF18O
	3n9j/1JOzaNJSA45a1KlIpIVYmKIcMKjVhuwkR1R/5VNLbxu9IELQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C4BF323D89;
	Mon, 17 Jun 2024 16:08:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3EBCC23D88;
	Mon, 17 Jun 2024 16:08:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH] attr: fix msan issue in read_attr_from_index
In-Reply-To: <pull.1747.git.1718654424683.gitgitgadget@gmail.com> (Kyle
	Lippincott via GitGitGadget's message of "Mon, 17 Jun 2024 20:00:24
	+0000")
References: <pull.1747.git.1718654424683.gitgitgadget@gmail.com>
Date: Mon, 17 Jun 2024 13:08:24 -0700
Message-ID: <xmqqmsnj5o3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5B4D99E2-2CE5-11EF-B418-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

"Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Make the call to `read_attr_from_buf` conditional on `buf` being
> non-NULL, ensuring that `size` is not read if it's never set.

Makes good sense.


> Signed-off-by: Kyle Lippincott <spectral@google.com>
> ---
>     attr: fix msan issue in read_attr_from_index
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1747%2Fspectral54%2Fmsan-attr-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1747/spectral54/msan-attr-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1747
>
>  attr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/attr.c b/attr.c
> index 300f994ba6e..a2e0775f7e5 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -865,7 +865,8 @@ static struct attr_stack *read_attr_from_index(struct index_state *istate,
>  		stack = read_attr_from_blob(istate, &istate->cache[sparse_dir_pos]->oid, relative_path, flags);
>  	} else {
>  		buf = read_blob_data_from_index(istate, path, &size);
> -		stack = read_attr_from_buf(buf, size, path, flags);
> +		if (buf)
> +			stack = read_attr_from_buf(buf, size, path, flags);
>  	}
>  	return stack;
>  }

Not directly related to the issue this patch addresses, but I notice
that both buf and size variables have unnecesarily wide scope.  As a
clean-up we may want to move their declaration into this "} else {"
block.  But that is totally outside the scope (no pun intended) of
this patch.

Will queue.
Thanks.  
