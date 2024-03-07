Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA171E86E
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709854154; cv=none; b=g69hV+8XORzptU1JgxEqromQfd4u/SRtLc19ovyPTI6r4/U9e1XaeFYewUbMZo+V0DSLnwR3JsFpaj3sSsIkNDHXNFYDYqDkKHp7kO7oXaJAQgYfhfTwwD1w6w0+YP46e0YG4FEoSjKbhGD+y92k+/vcIC3u4fCiteXHXFZz0WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709854154; c=relaxed/simple;
	bh=ujxql8sAHNfvovW3ubKBSMd+1yfWQPzjdjC0O6xSZZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jzH2uHeX9NgCLBK2G0DwDrgNexEtB6UQQS//2oGAK6UP/bI6skpEzOxOUppwKfawzcGw2D0zLPiH4mWT6ibSi2mxAvDzGAHwlfLZboLGj4l7xrVEjecbsYgsOFxuLPpt42AE2Ro7+cQvgHhMjyYFMq1kXCzyWuHFq4cJ+Nkh+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pEzaAid4; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pEzaAid4"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 778D72A480;
	Thu,  7 Mar 2024 18:29:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ujxql8sAHNfvovW3ubKBSMd+1yfWQPzjdjC0O6
	xSZZw=; b=pEzaAid4T3UUDg7bd3bBp4PPVSsjVfVJrotqu4j0R9vA9xtbZqq2Bg
	O8cdPWdL0EjTpDeQno4aINXzl1AJ3S9ReU6HwZ8vl3ycBEQSjCrX0rxWerZ6sUyK
	pK/0cJUjzhlHHokUkyMUGd/W0uFTMx6NnjPq4NiGyD2DlMvVPsjUs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 703B52A47F;
	Thu,  7 Mar 2024 18:29:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0391C2A47E;
	Thu,  7 Mar 2024 18:29:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] reftable/block: fix binary search over restart
 counter
In-Reply-To: <370b608f9007abe9c0562d76894e2475d19867a1.1709843663.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 7 Mar 2024 21:36:02 +0100")
References: <a4312698cceab5f2438c9dd34465da21d719e256.1709825186.git.ps@pks.im>
	<cover.1709843663.git.ps@pks.im>
	<370b608f9007abe9c0562d76894e2475d19867a1.1709843663.git.ps@pks.im>
Date: Thu, 07 Mar 2024 15:29:07 -0800
Message-ID: <xmqq7cidk4e4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7F3645E4-DCDA-11EE-B2E4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The consequence is that `binsearch()` essentially always returns 0,
> indicacting to us that we must start searching right at the beginning of
> the block. This works by chance because we now always do a linear scan
> from the start of the block, and thus we would still end up finding the
> desired record. But needless to say, this makes the optimization quite
> useless.
>
> Fix this bug by returning whether the current key is smaller than the
> searched key. As the current behaviour was correct it is not possible to
> write a test. Furthermore it is also not really possible to demonstrate
> in a benchmark that this fix speeds up seeking records.

This is an amusing bug.  

I wonder if we inherited it from the original implementation---this
was imported from jgit, right?

Thanks for a detailed write-up.  

The "it is a fix, but the breakage is well hidden and cannot be
observed only by checking for correctness" aspect of the bug
deserves the unusually large "number of paragraphs explaining the
change divided by number of changed lines" ratio ;-).

Applied.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/reftable/block.c b/reftable/block.c
> index 72eb73b380..1663030386 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -302,7 +302,7 @@ static int restart_key_less(size_t idx, void *args)
>  
>  	result = strbuf_cmp(&a->key, &rkey);
>  	strbuf_release(&rkey);
> -	return result;
> +	return result < 0;
>  }
>  
>  void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
