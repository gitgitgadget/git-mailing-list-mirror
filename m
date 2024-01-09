Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9A23D553
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BNwFPllG"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AB3F428514;
	Tue,  9 Jan 2024 15:06:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SSGgzVjfa5MvF6XIoe2tcnzYGxezHS+70Oju9/
	TlOhw=; b=BNwFPllGGvBYqBt2YEpJKL2gOVu5s5Jhuby1X8RQXRNmBmPa8iqeGM
	Z9O+kii/NzuHwzh3ayHbWd5I/6VlN6EILVSIRZGWPbYUByFzl1GuJbdqHZG7Sjuq
	07uyIG1oPJQA73xNdnZKyIsP6PZpu1Gw/UOCZpxuN7ov/YT5gKSl0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A4A2628513;
	Tue,  9 Jan 2024 15:06:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 54D0B28512;
	Tue,  9 Jan 2024 15:06:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>,
  sunshine@sunshineco.com,
  git@vger.kernel.org
Subject: Re: [PATCH v7 1/1] mingw: give more details about unsafe
 directory's ownership
In-Reply-To: <d1e1a543-ab9c-4b1b-9f1d-3728e791df2e@kdbg.org> (Johannes Sixt's
	message of "Tue, 9 Jan 2024 20:27:35 +0100")
References: <de9cf40a-1ad6-45fb-8b70-8b0c71a3bfbb@kdbg.org>
	<20240108173837.20480-1-soekkle@freenet.de>
	<20240108173837.20480-2-soekkle@freenet.de>
	<d1e1a543-ab9c-4b1b-9f1d-3728e791df2e@kdbg.org>
Date: Tue, 09 Jan 2024 12:06:42 -0800
Message-ID: <xmqq8r4ygtkd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9C7777B4-AF2A-11EE-BFC2-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

>> +	LookupAccountSidA(NULL, sid, NULL, &len_user, NULL, &len_domain,
>> +			  &pe_use); 
>
> At this point, the function fails, so len_user and len_domain contain
> the required buffer size (including the trailing NUL).

So (*str)[len_domain] would be the trailing NUL after the domain
part in the next call?  Or would that be (*str)[len_domain-1]?  I am
puzzled by off-by-one with your "including the trailing NUL" remark.

>> +	/*
>> +	 * Alloc needed space of the strings
>> +	 */
>> +	ALLOC_ARRAY((*str), (size_t)len_domain + (size_t)len_user); 

This obviously assumes for domain 'd' and user 'u', we want "d/u" and
len_domain must be 1+1 (including NUL) and len_user must be 1+1
(including NUL).  But then ...

>> +	translate_sid_to_user = LookupAccountSidA(NULL, sid,
>> +	    (*str) + len_domain, &len_user, *str, &len_domain, &pe_use);

... ((*str)+len_domain) is presumably the beginning of the user
part, and (*str)+0) is where the domain part is to be stored.

Because len_domain includes the terminating NUL for the domain part,
(*str)[len_domain-1] is that NUL, no?  And that is what you want to
overwrite to make the two strings <d> <NUL> <u> <NUL> into a single
one <d> <slash> <u> <NUL>.  So...

> At this point, if the function is successful, len_user and len_domain
> contain the lengths of the names (without the trailing NUL).
>
>> +	if (!translate_sid_to_user)
>> +		FREE_AND_NULL(*str);
>> +	else
>> +		(*str)[len_domain] = '/';

... this offset looks fishy to me.  Am I off-by-one?

> Therefore, this overwrites the NUL after the domain name and so
> concatenates the two names. Good.
>
> I found this by dumping the values of the variables, because the
> documentation of LookupAccountSid is not clear about the values that the
> variables receive in the success case.
>
>> +	return translate_sid_to_user;
>> +}
>> +
>
> This patch looks good and works for me.
>
> Acked-by: Johannes Sixt <j6t@kdbg.org>
>
> Thank you!
>
> -- Hannes
