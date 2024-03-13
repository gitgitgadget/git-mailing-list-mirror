Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBA0604A0
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353306; cv=none; b=BdiyMM1iAIj5EioWzsKhMq0bXZw1CWnZLjgDi4yJJb7CpBsbhNVzoM+yeEEg5pBGsmtaWsPtKOFLMRsad3CRwMxzOQkG0sp1vQ3e5SLTcHopzkNdJsLA1F1yARxjK4Q2jLVQ5VFhvhjfd0HAtSHkpzVth2GCOTW+9RBzFuT/QOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353306; c=relaxed/simple;
	bh=d698XTVr5uBxxPUPLkdjDBH9oOR/DgR7iETF1B1Iypg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUyfICOtLTs6rs41LI0EWp36d0gPJ01vGpkztdCqP5p+/i+LU3SrRYUjRfIdKtzTLlnaxSpE4Jyx16d2QAuPzJMSh+jTfDK58F8pippQg8Bu/OZb+1xDIpLUMY8JmuHkrfLX+MibY/32ihU6FAC2EwaPSdfaecW7862bRu7mcR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <dev+git@drbeat.li>)
	id 1rkT1Y-000000005AQ-0gFg
	for git@vger.kernel.org;
	Wed, 13 Mar 2024 19:08:20 +0100
Received: from [10.20.10.231] (port=23650 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <dev+git@drbeat.li>)
	id 1rkT1X-0049v4-07;
	Wed, 13 Mar 2024 19:08:19 +0100
Message-ID: <a675ab4d-7dde-4630-9de6-970f05225271@drbeat.li>
Date: Wed, 13 Mar 2024 19:08:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] log: make the --oneline option work with -L
To: Junio C Hamano <gitster@pobox.com>, James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
References: <20240313090841.36717-1-james@jamesliu.io>
 <xmqqr0geca36.fsf@gitster.g>
Content-Language: de-CH
From: Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <xmqqr0geca36.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

On 13.03.24 18:31, Junio C Hamano wrote:
> James Liu <james@jamesliu.io> writes:
> 
>> git-log accepts the --oneline option to display the short commit SHA and
>> title only. This is a convenient option when searching through Git
>> history, as it gives a rough idea of the changes introduced in each
>> commit. git-log also accepts the -L flag, which lets us provide a line
>> range for a given file. This is handy for limiting the search to a given
>> area of interest.
>>
>> However, when --oneline is used in combination with -L, Git actually
>> outputs the single line commit information _as well_ as the full diff.
>> For example:
>>
>>          git log --oneline -L 660:Documentation/MyFirstObjectWalk.txt
>>
>> will incorrectly display the diffs too.
> 
> Why is it incorrect?
> 
>   * "git log" takes options to tweak formatting of the commit log,
>     options to tweak what commits are chosen, and options to tweak
>     how the diff are shown.
> 
>   * "--oneline" tweaks how the log message gets shown.  Others in the
>     family are --pretty=fuller, --format='%h %s', etc.
> 
>   * "-L" tweaks how the diff gets shown (e.g. limits which part of
>     the diff is shown) and what commits are shown (e.g. limits to
>     commits that touch the specified area).
> 
> So, just like "git log -L <range>:<file>" shows the commit log for
> each commit that touches the specified area of the file, followed by
> the diff that shows how the commit modified the range, it is natural
> to expect "git log --oneline -L <range>:<file>" to show the same diff
> after showing the commit log for these commits in the specified format,
> namely, with just a one-line description.
> 
> It is not limited to "-L"; "git log --oneline -p" is expected to
> show the patch after a one-line description for the commit.
> 

There's also "--no-patch" to suppress the patch. It combines well with 
"--oneline".

-- 
Cheers, Beat

