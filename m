Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EB752F9E
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400237; cv=none; b=Q7CdNSxp8iHXb1tGE+1F87NuxlDH8b//e5FDpxqvO0uBi1ft5dU7wUC+m5a88NQyJOsV6SMAWqyOqXzHoexZeq7+SqGhPDOpDsCs+W8tdc6b/zAddUW1fNlOq3LI0v1uI5KNWMXcU1YngynJ600l3NPTQLromqNKjwFFgz32+Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400237; c=relaxed/simple;
	bh=KV0eeE/T5Rrp0N28+lYmXcyrdjugkr6RdwVk9L2NjxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=STOVjo6iH0mLiXaqp52m0ckfQVZpohO84QNu1xJGPUPNtpubbjWRUSVrWRE7FMmRcZwR5QLSSd4VGRuqQ2qCvIuls/IclKVjLb4GiDiTg1EVCDI7g3TVzpatWn5KT5RcpksPzyD6ksZoEK7YEGpQ5OJ686MOEFCYZnOY5RVfaCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FKd5c/AD; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FKd5c/AD"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D249930EC2;
	Mon, 25 Mar 2024 16:57:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KV0eeE/T5Rrp0N28+lYmXcyrdjugkr6RdwVk9L
	2NjxI=; b=FKd5c/ADJ0w5EPxv/HW67lsvM123GIaNuMxYlz7Q0J2v7DCGmALeQg
	23SdkqQzoBmWJs//wcvkobYaYiaz0oSkZAH8YPuTcsKKNnCgdnc7pYilrIwIQ836
	DBOqiFo0QE6HCCXtO3oAXfKJgtgkm1Yxxtk0hEz2AeCE6+AbQTZUc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CA26630EC1;
	Mon, 25 Mar 2024 16:57:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5066C30EC0;
	Mon, 25 Mar 2024 16:57:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Brian Lyles <brianmlyles@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  newren@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v4 0/7] cherry-pick: add `--empty` for more robust
 redundant commit handling
In-Reply-To: <2ab7445f-08ee-4608-96ad-8171f9ce1b73@gmail.com> (phillip's
	message of "Mon, 25 Mar 2024 19:36:33 +0000")
References: <17c00de527e3a0c4.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
	<2ab7445f-08ee-4608-96ad-8171f9ce1b73@gmail.com>
Date: Mon, 25 Mar 2024 13:57:10 -0700
Message-ID: <xmqqa5mmhvx5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 40AE1D7E-EAEA-11EE-B412-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

phillip.wood123@gmail.com writes:

>> +		/* Check to see if this is an unborn branch */
>> +		head_name = resolve_ref_unsafe("HEAD",
>> +			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>> +			&head_oid, NULL);
>> +		if (!head_name
>> +			|| !starts_with(head_name, "refs/heads/")
>> +			|| !is_null_oid(&head_oid))
>>   			return error(_("could not resolve HEAD commit"));
>
> Normally we'd write this as
>
> 	if (!head_name ||
> 	    starts_with(head_name, "refs/heads/") ||
> 	    !is_null_oid(&head_oid))
> 		return error(...)
>
> breaking lines after an operator and indenting to the open bracket
> after the if.

> The rest looks good. Junio was talking about merging
> this to next in the latest "what's cooking" email so I'd double check
> he hasn't done that yet before re-rolling.

I do not want to rush things---if we find that this is worth
touching up (and obviously we do---otherwise we would not be having
this conversation), then let's do have a quick v5 with minimal
range-diff.

> Thank you for working on it, I've enjoyed reading your patches

Likewise.  Thanks, both.

