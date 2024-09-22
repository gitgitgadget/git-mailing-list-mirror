Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF611712
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726986381; cv=none; b=KkSl8woaT+R64FwaCFUut/fKUziIIoTm776dkxczM7KtrsEHdyGak0y2l/q4eCoe34KefPTeIeNu4g37AtyUWolLOg55sk2LEcT7uF+xV2mMp0d4g7MZmkQc+85I4YUOjtulVN5INPfyjuB4NUwtDUVlqzXZwRcMHI06BMvIkck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726986381; c=relaxed/simple;
	bh=Rb1s6eiAThZ0tGfzZojmM0KbRJMxkLdqP/hBOYfLSnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nN/Z7VMEwo3ijNgZKO0ajALt1769wV6x3qVj7A5SPDygyGWVWrgxWNLL0D+S7sHmjrk6yzLWXOkkc8rSz+CZJl4pp4Z3oKBlAB9G6FETyRacBWQ0TEjxFklfdT5yupdwoV4UF1QLq7kJN0+8Mu3a9QA6c2ptauiUgWW8/Y4tvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=i0XycH3C; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i0XycH3C"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 64F4F36910;
	Sun, 22 Sep 2024 02:26:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Rb1s6eiAThZ0tGfzZojmM0KbRJMxkLdqP/hBOY
	fLSnE=; b=i0XycH3CGsElc1qjsCDRcEcztzfo8cSBu+rmR4Nb40DgAFGfZ2U4/M
	EglTXHFx5OERGyt5qiH7f5eOJiJnKngDcpGBZXnblF8ohl5Cy1mgavcReKBslH44
	eEg+658QQVWrjGZhtK/TX/C1hBklFionrv36XNvtFJlFfacpdAWws=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D4813690F;
	Sun, 22 Sep 2024 02:26:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C0A103690E;
	Sun, 22 Sep 2024 02:26:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 17/22] reftable/iter: handle allocation failures when
 creating indexed table iter
In-Reply-To: <32fead57de989335b17d16f63c1cd144460495a1.1726489647.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 16 Sep 2024 14:29:06 +0200")
References: <cover.1726489647.git.ps@pks.im>
	<32fead57de989335b17d16f63c1cd144460495a1.1726489647.git.ps@pks.im>
Date: Sat, 21 Sep 2024 23:26:09 -0700
Message-ID: <xmqq7cb49pby.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8F248C1E-78AB-11EF-902A-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> -int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
> +int indexed_table_ref_iter_new(struct indexed_table_ref_iter **dest,
>  			       struct reftable_reader *r, uint8_t *oid,
>  			       int oid_len, uint64_t *offsets, int offset_len)
>  {
>  	struct indexed_table_ref_iter empty = INDEXED_TABLE_REF_ITER_INIT;
> -	struct indexed_table_ref_iter *itr = reftable_calloc(1, sizeof(*itr));
> +	struct indexed_table_ref_iter *itr;
>  	int err = 0;
>  
> +	itr = reftable_calloc(1, sizeof(*itr));
> +	if (!itr) {
> +		err = REFTABLE_OUT_OF_MEMORY_ERROR;
> +		goto out;
> +	}
> +
>  	*itr = empty;
>  	itr->r = r;
>  	strbuf_add(&itr->oid, oid, oid_len);
> @@ -197,11 +203,15 @@ int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
>  	itr->offset_len = offset_len;
>  
>  	err = indexed_table_ref_iter_next_block(itr);
> -	if (err < 0) {
> +	if (err < 0)
> +		goto out;
> +
> +	*dest = itr;
> +	err = 0;
> +
> +out:
> +	if (err < 0)
>  		reftable_free(itr);
> -	} else {
> -		*dest = itr;
> -	}
>  	return err;
>  }

Unless the service the helper function offers is to upgrade an
existing resource (e.g., realloc() taking a pointer and give an
enlarged piece of memory), it may be a safer calling convention to
promise that *dest is cleared to NULL when the function fails,
instead of promising that *dest is left intact.  The caller, when it
needs to evantually release the resource acquired here, has to
remember what the returned value (i.e., err) was, in order to decide
if it needs to call the release helper on *dest it obtained from us.

The only caller seems to initialize *dest to NULL itself, so it does
not matter in the current code, though.
