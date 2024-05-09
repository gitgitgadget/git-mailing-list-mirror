Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561012FF9B
	for <git@vger.kernel.org>; Thu,  9 May 2024 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715268255; cv=none; b=QFJ+NbeRkIZYJP7w52VeofSPoPn2CMD6Xh9UMI4gCf5nZ0dKXpHtjZMWuJbAcNtUiDxxNPmPl6QTtXp+4ooAnkftQ037cr/VQsevfMfAH4ZkVBg1EdBwg1WHsWHMj9hch94yhqpVwvYaFRWKeK59uIwvp4tezk4TLiN14Jb13dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715268255; c=relaxed/simple;
	bh=yTqrPqnLoHzSciaP0V8J6BP0k1ftcojZB2LebXEO0sk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H9snILXo33Pi3igA/Tl5fEnHRBm4SAs6rzFxrAhT9RNywigy7+j5LkOf7qftPsBMrKSU76dZBkeZhjwybk7eaAxRvADt4dNv3Jsz4sa+vQ8ARBjg0DWWSf2WHFgtcsIiyP8AlZ1WdBr94FtSgD6vo5yQcmIKothmZlMlp09VnOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eC3qT/Ud; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eC3qT/Ud"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8571036F77;
	Thu,  9 May 2024 11:24:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yTqrPqnLoHzSciaP0V8J6BP0k1ftcojZB2LebX
	EO0sk=; b=eC3qT/Uds+zgpXUwqkKLjdGClmbuD3E7UNZ44PwPzDtmTVcpaCW0Vn
	L3+F+8Rgxy2sBCMLQ2ujchcQOUxVMvz9XjtW2daFXMEw9giTcMbOB8XfpQ3fQ3Wh
	vzgQoc5m+efaGmX3F8u2iZ9BeL4cpQwM4AimD5gQ3YI9r3vOu8qo4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E0C036F76;
	Thu,  9 May 2024 11:24:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E33C936F74;
	Thu,  9 May 2024 11:24:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  takimoto-j@kba.biglobe.ne.jp
Subject: Re: [PATCH v1 2/2] strbuf_getcwd() needs precompse_strbuf_if_needed()
In-Reply-To: <xmqqa5l1pmf9.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	07 May 2024 10:22:02 -0700")
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
	<20240507084431.19797-1-tboegi@web.de> <xmqqa5l1pmf9.fsf@gitster.g>
Date: Thu, 09 May 2024 08:24:05 -0700
Message-ID: <xmqqh6f7vwiy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2D0AFB56-0E18-11EF-B1F9-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/strbuf.c b/strbuf.c
>> index 0d929e4e19..cefea6b75f 100644
>> --- a/strbuf.c
>> +++ b/strbuf.c
>> @@ -591,6 +591,7 @@ int strbuf_getcwd(struct strbuf *sb)
>>  	for (;; guessed_len *= 2) {
>>  		strbuf_grow(sb, guessed_len);
>>  		if (getcwd(sb->buf, sb->alloc)) {
>> +			precompse_strbuf_if_needed(sb);
>>  			strbuf_setlen(sb, strlen(sb->buf));
>
> The need for strbuf_setlen() stems from the use of getcwd() that may
> and will place a string that is much shorter than sb->alloc, so they
> logically belong together.  It will make more sense to call the
> precompose _after_ arranging the members of strbuf in a consistent
> state with the call to strbuf_setlen().

Of course, we need to make sure precompose_string_if_needed() will
leave the strbuf in an consistent state.  I think the implementation
of that helper function in this patch already does so, so

		strbuf_grow(sb, guessed_len);
		if (getcwd(sb->buf, sb->alloc)) {
			strbuf_setlen(sb, strlen(sb->buf));
			precompse_strbuf_if_needed(sb);

would be what we would want.

Thanks.
