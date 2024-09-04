Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F31E00BD
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476064; cv=none; b=kh9NVDurwXZsk2ssZMvFV2NYG11jhWQvioi0TpjwF2yIGb8tyj1aQJ71mrmWU8FJYFzQ6BQDBSc9DCTVY3NZM7F6DZCSp0wCrUY4blYagB5ENw/KxkngV9dyda6GB7pndopwDWJh+yWj1AUgerDnTKv/95mUfBRuN2glkEni7Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476064; c=relaxed/simple;
	bh=o1w0X3dBPPT7GG9gjhWuy08oJ1vOFJkQ7vK5R2HdOXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZWocVbNSj7Cfy3oegM+X2VfrhLLQGpsZbHLUq9SGRWmIcOmW2aN29eAZyOklfm9+T7G7RSmWz+8f/Eheo/28RO2BbDEeud6KHw5twium7nwhT8l1OhZ0RQlqbDT8CJS+mO/HW++4WaDjXXje/xIEyLTzoNSeMFAHvTRRkg3YqLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LYxOgNZa; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LYxOgNZa"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 597551EF8E;
	Wed,  4 Sep 2024 14:54:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=o1w0X3dBPPT7GG9gjhWuy08oJ1vOFJkQ7vK5R2
	HdOXE=; b=LYxOgNZarDmC+02jNn+y30SllHcGTpvauXgGD2VvNpXACTFDtWYkwJ
	IAdESC9d6PJc96DZvUuvpyljzOccMjss6qmVM4BIIXd/iwe72/C2LQfPtV+vqNHF
	bWxGiPze40Gg5f+ptE8xJYYvBF7vTE0ABu3WtJqcAuC7M/N42SO8k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 522271EF8D;
	Wed,  4 Sep 2024 14:54:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D3781EF8C;
	Wed,  4 Sep 2024 14:54:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] pack-bitmap.c: avoid repeated
 `pack_pos_to_offset()` during reuse
In-Reply-To: <afa25c8806b0e80f1d3ed46f29eb164cab4583ac.1724793201.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 27 Aug 2024 17:13:36 -0400")
References: <cover.1724793201.git.me@ttaylorr.com>
	<afa25c8806b0e80f1d3ed46f29eb164cab4583ac.1724793201.git.me@ttaylorr.com>
Date: Wed, 04 Sep 2024 11:54:18 -0700
Message-ID: <xmqq1q1z9rmt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 178D581C-6AEF-11EF-AFE4-9B0F950A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> @@ -2055,17 +2055,18 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
>  			     struct bitmapped_pack *pack,
>  			     size_t bitmap_pos,
>  			     uint32_t pack_pos,
> +			     off_t offset,
>  			     struct bitmap *reuse,
>  			     struct pack_window **w_curs)
>  {
> -	off_t offset, delta_obj_offset;
> +	off_t delta_obj_offset;
>  	enum object_type type;
>  	unsigned long size;
>  
>  	if (pack_pos >= pack->p->num_objects)
>  		return -1; /* not actually in the pack */
>  
> -	offset = delta_obj_offset = pack_pos_to_offset(pack->p, pack_pos);

We are now passing redundant piece of information "offset" that
could be derived from two other parameters, which feels a bit icky,

I suspect that try_partial_reuse() can be taught not to require
pack_pos and instead work entirely on offset

 - The caller can pass a very large offset to represent "not
   actually in the pack" early return condition.

 - The logic to punt on a delta pointing backwards can be done by
   comparing the base_offset and offset, instead of comparing the
   base_pos and pack_pos.

but it may not be worth the effort, unless we are going to do
similar clean-up globally in all the codepaths that access
packfiles.

Thanks.
