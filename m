Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7EF52F77
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776594; cv=none; b=AklMJ0FzlhuC1svxmmv02LrC4WXzFcHr1iNW1hUCHw5JrvlEQ4FRRoALnIFjuSFtXyoo0Fyz+eqprftNhJ9LFKTXadyOE+B35iqtdMAPfkbsVFCqLFykGvd7vYHCl39910ni7+L1JNK5AfuKkgG5xuwPf55pSCynRFB4Bk8yx3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776594; c=relaxed/simple;
	bh=VOSxyPvR0KEA+gwNUA4VFUYbLdR7qxhh949ZQ67KMOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GETQTozfGasp0a8zadOQQN9CQES9d9RQRIkhpzplbJUosOhBr9rWVTtyQuG13ux5l5F33Fii1GA9B8NZzY7jq7Avu+4gOaTRdambsYH+vo6ONZ2jrAIjozeG7gSndfPEa9jWU433b0imaAgzNC+plAEg2wb6myxohrrWxtHmJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kMFuZuzi; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kMFuZuzi"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AC0A1E7368;
	Mon, 18 Mar 2024 11:42:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VOSxyPvR0KEA+gwNUA4VFUYbLdR7qxhh949ZQ6
	7KMOA=; b=kMFuZuzibBS7tGaWoDAOWo8NpDuYFojz14hKajRVYomfqssGA9IKlM
	zEPrC/Y0dILuh9pnqq/KOtYMEJJ7IICAPX91vL3NBW5uLCKcIa4aXlU6415Kg4/R
	vA9IcR9Zci7Y4bEODaHVA7kNVFrv+a/t9EBlOPtaWgL22hTo3JD5M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 50A2F1E7367;
	Mon, 18 Mar 2024 11:42:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B2E011E7366;
	Mon, 18 Mar 2024 11:42:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Aryan Gupta <garyan447@gmail.com>,  git@vger.kernel.org
Subject: Re: [GSoC][PATCH v2] Optimize ewah_bitmap.c for efficiency using
 trailing zeros for set bit iteration
In-Reply-To: <CAOLa=ZSijjnfa8UEEWPi8Cb7Q1hLbgrez7VX-LxshmUhNM29DQ@mail.gmail.com>
	(Karthik Nayak's message of "Sun, 17 Mar 2024 20:08:41 -0700")
References: <20240310162614.62691-1-garyan447@gmail.com>
	<20240313223751.50816-1-garyan447@gmail.com>
	<CAOLa=ZSijjnfa8UEEWPi8Cb7Q1hLbgrez7VX-LxshmUhNM29DQ@mail.gmail.com>
Date: Mon, 18 Mar 2024 08:42:48 -0700
Message-ID: <xmqqr0g7k0lj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2CCE53A2-E53E-11EE-8C53-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Aryan Gupta <garyan447@gmail.com> writes:
>
> Hello,
>
>> Signed-off-by: Aryan Gupta <garyan447@gmail.com>
>> ---
>>
>> Thank you Vicent for the guidance. I am still not sure how
>> to do the performance measurement for this improvement. Any
>> guidance would be appreciated.
>>
>
> I guess there is some off-list discussion here. That along with the fact
> that the commit message is missing makes it really hard to understand
> how this is better than what was here already.
>
> The guidelines ('Documentation/SubmittingPatches') also state how to
> draft the commit message. This patch only seems to have a title, it is
> recommend to add a description as to why this change is being made.

Yes.

>> diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
>> index 8785cbc54a..1a75f50682 100644
>> --- a/ewah/ewah_bitmap.c
>> +++ b/ewah/ewah_bitmap.c
>> @@ -257,12 +257,15 @@ void ewah_each_bit(struct ewah_bitmap *self, void (*callback)(size_t, void*), vo
>>  		for (k = 0; k < rlw_get_literal_words(word); ++k) {
>>  			int c;
>>
>> -			/* todo: zero count optimization */
>> -			for (c = 0; c < BITS_IN_EWORD; ++c, ++pos) {
>> -				if ((self->buffer[pointer] & ((eword_t)1 << c)) != 0)
>> -					callback(pos, payload);
>> +			eword_t bitset = self->buffer[pointer];
>> +			while(bitset != 0) {
>> +				eword_t t = bitset & -bitset;
>> +				int r = __builtin_ctzl(bitset);
>> +				bitset ^= t;
>> +				callback(pos+r, payload);
>>  			}
>> -
>> +			
>> +			pos += BITS_IN_EWORD;
>>  			++pointer;
>>  		}
>>  	}
>
> The bit manipulation done here is slightly hard to comprehend, it would
> be nice if you could also add some comments as to what is being done
> here and why.

In addition, this patch assumes that __builtin_ctzl() function is
always available no matter what environment the code is built on,
which I am not sure is a safe.  Quite honestory, I suspect that the
whole of "todo" is to seamlessly detect the presense of the builtin
support to count the top zero bit, use it only when it is there, and
giving a fallback implementation when it does not exist.  The code
itself to use the builtin is only 20% of that effort ;-)

And of course, there is benchmark.  To show how much better
performance gets for people with that function, and more importantly
to show that the performance does not degrade for those who are
without.

Thanks.
