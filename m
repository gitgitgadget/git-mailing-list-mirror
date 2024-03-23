Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB682CA4
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711227095; cv=none; b=buFTah5jWurSXp2RS8oR1dBQP4oZW+mgt5eK2QpQziXHGCsnktSJnhIsCwvX6ZcrPkSdQ86oWeSHDUX60XY1//7KxSCiBQQACUfAKYiv2Q/4FR/xij1saAn5rF9b1jgW382GWttzrRfA88M4a1KLcdlhM3+lr+Iv8qsZuKk+FJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711227095; c=relaxed/simple;
	bh=6jDR3TFBASCoxCgVIwLaub3J2rj6W+Hexx9DTw4ZR2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AK2huqYPNEZEYNBdj7EMeathJSEByOHPHxtjOQT41qtQZhF8PKwT3T2KvRZ0l4j6vJift/2tzNkUyrDl1kBB+u7EEa+HhLSXqR9MtuHwLERwfkIh/rTuDnRpBPSBVe7E1MH561YjwFktT25v9PLNjGJ2/4fqyeTWaDEjnXj2V0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=tEYUFyDH; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="tEYUFyDH"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 253E619FEDB2;
	Sat, 23 Mar 2024 21:51:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711227089; bh=6jDR3TFBASCoxCgVIwLaub3J2rj6W+Hexx9DTw4ZR2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=tEYUFyDHGySQXve+diJ+xhOaC2YmWu2pNxGGdKSgXiKbmsJSen00QAQCmqxrpEFGq
	 8Push6mq/5+a5FJQHxoj/rJbBkE4/SexyNq5A34Yy8ZD6pyQAqKGLOyMhO5C2lDulr
	 F33K9wsLPmOeWorO3IGICNfmwF5UXKlQW16/FYxQ=
Message-ID: <4cf100aa-4239-4377-b20a-7c90443fb405@schinagl.nl>
Date: Sat, 23 Mar 2024 21:51:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Allow git bisect to auto-skip
Content-Language: nl, en-US
To: Junio C Hamano <gitster@pobox.com>, Stefan Haller <lists@haller-berlin.de>
Cc: git@vger.kernel.org
References: <3d835c4b-d026-4c6a-b68e-6989a7a2065f@schinagl.nl>
 <xmqqwmptzyny.fsf@gitster.g>
 <01e09c64-4d62-406d-85fe-9fb77939cf63@haller-berlin.de>
 <xmqqle68x008.fsf@gitster.g>
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <xmqqle68x008.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23-03-2024 19:43, Junio C Hamano wrote:
> Stefan Haller <lists@haller-berlin.de> writes:
> 
>> On 22.03.24 23:31, Junio C Hamano wrote:
>>> It often is discovered that a commit
>>> breaks bisection after the fact and it is not feasible to rebase
>>> all the history after the commit.
>>
>> This reminds me of a similar problem with git blame, for which we have
>> the blame.ignoreRevsFile config to work around it. Couldn't there be a
>> similar mechanism for bisect, e.g. bisect.skipRevsFile?
> 
> A Very good point.  If a breakage of a commit is "this does not even
> build" kind of breakage, such a mechanism would be an excellent fit.
> 
> But if a breakage is "only this particular test fails and we know
> the reason why it fails has nothing to do with the bug we are
> chasing", then compiling such a fixed list of commits, or pointing
> at such a list with a configuration variable, would not work very
> well, I am afraid.

This changes my view of the issue a little bit. Building vs testing, 
though in reality its the same of course.

I can totally see that a user would need a special bisect script to 
handle these cases 'this commit breaks test 54, 43 and 12; but the rest 
work'. This is too specific to handle generically. Probably in using a 
similar trick, store in the notes what works and does not work.

I think it still stands that having a 'generic' way of telling bisect to 
skip the entire commit is still reasonable. Kind of like how you can do 
`git push -o ci.skip=true` with GitLab.

Olliver

> 
> Thanks.
