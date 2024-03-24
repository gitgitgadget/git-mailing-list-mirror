Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAC01426E
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711266433; cv=none; b=VkYVqJkQ+SY+Lyp5FqLnGMVkDI8XJwtPo5TeYHGzrMH9QYUUvFqMtdKKT77MdB1q8GIoWwg4lATV+xCLO0W5akCHve+SaYgRRHUb0xPuctMAUuZfunThQk8S7Gdghjd3pMv9LgQDiIKLLziNXreg4cG6sGyQaOGzMj9qRTyRLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711266433; c=relaxed/simple;
	bh=FLAvdvudXIdgZy5kYOt9Y+0ENRV6tsIMfjcgNbrPOsg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=U1eoa+qrsXoxEZARreZJAuQUSkgLVGhKci+vzWznnf+gT+X7gqcawbnmVQfZKi2bP5F8mSlxLS6K9iUt8oXbo3cTOdG80UoxnEKX+d+cGZkWTeL57+cIQH53xX8i4AcOTiLGqy1S8112iqyUQjScnWrk+HZJcLPQM6UtsWI9o6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=n+gAhU56; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="n+gAhU56"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id CE71419FF91D;
	Sun, 24 Mar 2024 08:47:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711266421; bh=FLAvdvudXIdgZy5kYOt9Y+0ENRV6tsIMfjcgNbrPOsg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=n+gAhU560EgKKtdiNdLzAzJPnH/swZ40ArZBv6hjlDXogRUkxJPBk/5GleQSeWrBo
	 MUpYR46Y7m7uTqrUrGknkC/6p3xcf/M+f8Ap0NRsX4EvWQmaBwCj9g+93GxMRwFvi8
	 VCU82M6YJyD3pLK8tU/FFZLTs4iXf54NenrniqXo=
Message-ID: <7610ff9c-b0d4-494c-a963-19494df2f74e@schinagl.nl>
Date: Sun, 24 Mar 2024 08:47:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Allow git bisect to auto-skip
From: Olliver Schinagl <oliver@schinagl.nl>
To: Junio C Hamano <gitster@pobox.com>, Stefan Haller <lists@haller-berlin.de>
Cc: git@vger.kernel.org
References: <3d835c4b-d026-4c6a-b68e-6989a7a2065f@schinagl.nl>
 <xmqqwmptzyny.fsf@gitster.g>
 <01e09c64-4d62-406d-85fe-9fb77939cf63@haller-berlin.de>
 <xmqqle68x008.fsf@gitster.g>
 <4cf100aa-4239-4377-b20a-7c90443fb405@schinagl.nl>
Content-Language: nl
In-Reply-To: <4cf100aa-4239-4377-b20a-7c90443fb405@schinagl.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23-03-2024 21:51, Olliver Schinagl wrote:
> On 23-03-2024 19:43, Junio C Hamano wrote:
>> Stefan Haller <lists@haller-berlin.de> writes:
>>
>>> On 22.03.24 23:31, Junio C Hamano wrote:
>>>> It often is discovered that a commit
>>>> breaks bisection after the fact and it is not feasible to rebase
>>>> all the history after the commit.
>>>
>>> This reminds me of a similar problem with git blame, for which we have
>>> the blame.ignoreRevsFile config to work around it. Couldn't there be a
>>> similar mechanism for bisect, e.g. bisect.skipRevsFile?
>>
>> A Very good point.  If a breakage of a commit is "this does not even
>> build" kind of breakage, such a mechanism would be an excellent fit.
>>
>> But if a breakage is "only this particular test fails and we know
>> the reason why it fails has nothing to do with the bug we are
>> chasing", then compiling such a fixed list of commits, or pointing
>> at such a list with a configuration variable, would not work very
>> well, I am afraid.
> 
> This changes my view of the issue a little bit. Building vs testing, 
> though in reality its the same of course.
> 
> I can totally see that a user would need a special bisect script to 
> handle these cases 'this commit breaks test 54, 43 and 12; but the rest 
> work'. This is too specific to handle generically. Probably in using a 
> similar trick, store in the notes what works and does not work.

P.S. One (imo big) issue to me is, that notes aren't automatically 
fetched or pushed according to what I found so far online (haven't 
personally tested it yet).

If that is the case, this makes the feature to be used in combination 
with bisect much more difficult for the un-informed. having a 
`refs/notes/<bisect-or-like-related-name>` notes tree is great, but only 
if it gets automatically pulled.

I think this also might be the reason it is a very undervalued thing maybe?

Olliver

> 
> I think it still stands that having a 'generic' way of telling bisect to 
> skip the entire commit is still reasonable. Kind of like how you can do 
> `git push -o ci.skip=true` with GitLab.
> 
> Olliver
> 
>>
>> Thanks.
