Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A81DDE9
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570590; cv=none; b=Y2zDtimt4V3ptOW5ZP3BEc4jXJnN6eLFaabDv0YViMACjNiTyQm2X9qqigP4lcS9/vc8x87iC4QnXVO2Qxq2XPqbooSR43fSJaJh5x3lpGg1o7PSUAwK0yxcD853nzLzN8IFDi40xGQE46gPALwzXQP+nrJu+uplc6GRDQFWbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570590; c=relaxed/simple;
	bh=86pCVmCxNTEsNIQ7NxhDwER5Ngp0qZAXFoV6Cn8F6AE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rhNlesq2STQeidhv5reeEVA5LFQ8BQuLlFWnPISJCqiiXVPt+03q57BOLcjEdjjOhVk42Nl7BL4q36+74axq7BiF9gXlXS/RxidiwEPBhEo6bIePIcipIqgjlmpUep2rproJZQCTTYfAzLAawi8QL8rkIfOkceiBXBHcHnyS7aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZpTuwCil; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZpTuwCil"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7EC8737071;
	Mon,  4 Mar 2024 11:43:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=86pCVmCxNTEsNIQ7NxhDwER5Ngp0qZAXFoV6Cn
	8F6AE=; b=ZpTuwCilDQ8rNCnnwyAAWJvYZ3G3pPRUKPEFecz+i/xM7xJsV2jQOm
	89ZylgIas5mVXCiGQsbvvRljBNNo7Eb/HHuLXqTGs70YytOBU9u+V6VVY3ZOXd3s
	GRjFwl4cpWQj0eMOpCzGS0HaIkYORW0wD1PcGNnsTrqtZK+AAcRq8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 771E637070;
	Mon,  4 Mar 2024 11:43:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1D7A33706F;
	Mon,  4 Mar 2024 11:43:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] unpack: replace xwrite() loop with write_in_full()
In-Reply-To: <xmqqfrx6sbdf.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	03 Mar 2024 23:29:48 -0800")
References: <20240302190348.3946569-1-gitster@pobox.com>
	<20240302190348.3946569-2-gitster@pobox.com> <ZeVxA1KvN18Y85J_@tanuki>
	<xmqqfrx6sbdf.fsf@gitster.g>
Date: Mon, 04 Mar 2024 08:43:03 -0800
Message-ID: <xmqqzfveq76w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 45F59A32-DA46-11EE-BFB3-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>>> -		while (input_len) {
>>> -			err = xwrite(1, input_buffer + input_offset, input_len);
>>> -			if (err <= 0)
>>> -				break;
>>> -			input_len -= err;
>>> -			input_offset += err;
>>> -		}
>>> +		/* Write the last part of the buffer to stdout */
>>> +		write_in_full(1, input_buffer + input_offset, input_len);
>>
>> With this change we stop updating `input_len` and `input_offset`, both
>> of which are global variables. Assuming that tests pass this must be
>> okay right now given that this is the final part of what we are writing.
>> But I wonder whether we shouldn't update those regardless just so that
>> these remain consistent?
>
> It is probably a good hygiene, even though it may not matter at all
> for the correctness in the current code.
>
> Thanks for your sharp eyes.

Actually, I changed my mind.  As you said, this is flushing the very
end of the data in the input_buffer[] and nobody will fill() the
input_buffer[] after the call to this function happens.

>>> -	while (len) {
>>> ...
>>> -		len -= ret;
>>> -		offset += ret;
>>> -	}
>>> +	write_in_full(1, buffer + offset, len);
>>
>> Same here.

Ditto.  We are about to pass the control back to the caller that
will exit using the "has_errors" we return from here.

>>
>> Patrick
>>
>>>  	/* All done */
>>>  	return has_errors;
>>> -- 
>>> 2.44.0-84-gb387623c12
>>> 
>>> 
