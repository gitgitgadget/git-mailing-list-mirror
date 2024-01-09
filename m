Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E293D978
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4T8k3y31Vrz5v3b
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 22:05:50 +0100 (CET)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4T8k3n2MhNz5tl9;
	Tue,  9 Jan 2024 22:05:40 +0100 (CET)
Message-ID: <e7594386-4a26-467d-bd27-8ac6268ad219@kdbg.org>
Date: Tue, 9 Jan 2024 22:05:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] mingw: give more details about unsafe directory's
 ownership
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>,
 sunshine@sunshineco.com, git@vger.kernel.org
References: <de9cf40a-1ad6-45fb-8b70-8b0c71a3bfbb@kdbg.org>
 <20240108173837.20480-1-soekkle@freenet.de>
 <20240108173837.20480-2-soekkle@freenet.de>
 <d1e1a543-ab9c-4b1b-9f1d-3728e791df2e@kdbg.org> <xmqq8r4ygtkd.fsf@gitster.g>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqq8r4ygtkd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 09.01.24 um 21:06 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>>> +	LookupAccountSidA(NULL, sid, NULL, &len_user, NULL, &len_domain,
>>> +			  &pe_use); 
>>
>> At this point, the function fails, so len_user and len_domain contain
>> the required buffer size (including the trailing NUL).
> 
> So (*str)[len_domain] would be the trailing NUL after the domain
> part in the next call?  Or would that be (*str)[len_domain-1]?  I am
> puzzled by off-by-one with your "including the trailing NUL" remark.

"Required buffer size" must count the trailing NUL. So, the NUL would be
at (*str)[len_domain-1].

> 
>>> +	/*
>>> +	 * Alloc needed space of the strings
>>> +	 */
>>> +	ALLOC_ARRAY((*str), (size_t)len_domain + (size_t)len_user); 
> 
> This obviously assumes for domain 'd' and user 'u', we want "d/u" and
> len_domain must be 1+1 (including NUL) and len_user must be 1+1
> (including NUL).  But then ...

So, this allocates the exact amount that is required to contain the
names with the trailing NULs: 1+1 plus 1+1 in this example.

> 
>>> +	translate_sid_to_user = LookupAccountSidA(NULL, sid,
>>> +	    (*str) + len_domain, &len_user, *str, &len_domain, &pe_use);
> 
> ... ((*str)+len_domain) is presumably the beginning of the user
> part, and (*str)+0) is where the domain part is to be stored.

Correct.

> 
> Because len_domain includes the terminating NUL for the domain part,
> (*str)[len_domain-1] is that NUL, no?  And that is what you want to
> overwrite to make the two strings <d> <NUL> <u> <NUL> into a single
> one <d> <slash> <u> <NUL>.  So...

But after a successful call, len_domain and len_user have been modified
to contain the lengths of the names (not counting the NULs), so, here
the NUL is at (*str)[len_domain]...

> 
>> At this point, if the function is successful, len_user and len_domain
>> contain the lengths of the names (without the trailing NUL).
>>
>>> +	if (!translate_sid_to_user)
>>> +		FREE_AND_NULL(*str);
>>> +	else
>>> +		(*str)[len_domain] = '/';
> 
> ... this offset looks fishy to me.  Am I off-by-one?

... and this offset is correct.

I followed the same train of thought and suspected an off-by-one error,
too, and was perplexed that I see a correct output. The documentation of
LookupAccountSid is unclear that the variables change values across the
(successful) call, but my tests verified that the change does happen.

>> Therefore, this overwrites the NUL after the domain name and so
>> concatenates the two names. Good.
>>
>> I found this by dumping the values of the variables, because the
>> documentation of LookupAccountSid is not clear about the values that the
>> variables receive in the success case.
>>
>>> +	return translate_sid_to_user;
>>> +}
>>> +
>>
>> This patch looks good and works for me.
>>
>> Acked-by: Johannes Sixt <j6t@kdbg.org>
>>
>> Thank you!
>>
>> -- Hannes

-- Hannes

