Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257D949631
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688390; cv=none; b=qvIfigsoJwI8IXWL7FNYT7pNOkR5UUf5NyfUoD+UqKE+MczMrYTW5voqk8nGAog7TI56ifTQUwFR8jTAYUMgJRgDcOYxWm2OiyVhm7ZKTX+i01pwD4T453bbRVWN1kAlMkywIrFMtjrorVJgR3sqJmKzm6VPN1TFcO0R4I9dik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688390; c=relaxed/simple;
	bh=fxmn2UBaVkfLxoiD5LB/J93mJpp4b8N+fHp5HXqzyMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oLz0IobWBGPBSCQIQSRaecT+TaimnnhpmraAw2PAtNzJTN3h4AJxvUJvMHoAzB4hfHAI3g1+tjBqHdvdvs4pyT1Nbps3veHKMC44JXcvOHovjOr8U3jcTuaKCZdMbNJISKFXPE1mhDnZ9Qg2ghwDAUJXzM1h9ghuPVwNWaXFOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NMLt/FPZ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NMLt/FPZ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AAAE5386A7;
	Mon, 26 Aug 2024 12:06:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fxmn2UBaVkfLxoiD5LB/J93mJpp4b8N+fHp5HX
	qzyMQ=; b=NMLt/FPZ0bxK0PkV0eNiOVDwcycijs05UGB4cCnHkpusy3pUZ5ajRY
	9MW6ChAW5/goOwyg3VqKmQvpCFsyhRrPrZxQqP0d70S/guCABAW0oyO4jQWdUQ4h
	LW69H2dfBxSoR35g9IbtZhAncwbpfXtP/h0Eyc8NO1H874H7jZCyg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A1FAC386A6;
	Mon, 26 Aug 2024 12:06:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C216F386A5;
	Mon, 26 Aug 2024 12:06:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH] bundle-uri: plug leak in unbundle_from_file()
In-Reply-To: <ZsxQBEpfChQozhF7@tanuki> (Patrick Steinhardt's message of "Mon,
	26 Aug 2024 11:51:00 +0200")
References: <20240826083052.1542228-1-toon@iotcl.com>
	<ZsxQBEpfChQozhF7@tanuki>
Date: Mon, 26 Aug 2024 09:06:20 -0700
Message-ID: <xmqqle0jmfpf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 22F708E6-63C5-11EF-BA74-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Aug 26, 2024 at 10:30:52AM +0200, Toon Claes wrote:
>> When the function returns early, the variable bundle_ref is not released
>> through strbuf_release().
>> 
>> Fix this leak. And while at it, remove assignments in the conditions of
>> the "if" statements as suggested in the CodingGuidelines.
> ...
>> -	if ((result = unbundle(r, &header, bundle_fd, NULL,
>> -			       VERIFY_BUNDLE_QUIET | (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0))))
>> -		return 1;
>> +	result = unbundle(r, &header, bundle_fd, NULL,
>> +			  VERIFY_BUNDLE_QUIET | (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0));
>> +	if (result)
>> +		goto cleanup;
>
> This changes the returned error code from `1` to whatever `unbundle()`
> returns. Is this intentional? If so, the commit message should explain
> why this change is safe.

Thanks for reviewing carefully.

Both of two callers of unbundle_from_file() are used as the
condition of an if() statement, so unbundle() that signals an error
with -1 wouldn't be a problem, I would think.

It may not be a bad idea as a #leftoverbits item, after the dust
settles, to clean up the calling convention in this file (may not be
limited to the code path that reaches this function) to follow the
usual "signal success with 0, failures are signalled with a negative
value".  Then we can just return the value we got from a failing
read_bundle_header(), just the same way we return the value we got
from a failing unbundle().

> Other than that this looks good to me, and the fix does not conflict
> with any of my leak-plugging series.

Yup.  Thanks, both.
