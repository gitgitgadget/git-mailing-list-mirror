Received: from mail.cendio.se (mail.cendio.se [193.12.253.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E63F243364
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.12.253.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388235; cv=none; b=Vs0bi32TrwhscYT5XPKvHoaNOZjWG5Y+fhHzVyoLfAmbeL1aGmRRhLC0QEkHXWDjW7l5O30YcYbT+IzaDXhVrmhnhcB4tBoHGpl/8lP7HDLekShke0XGnkX0zc9eW4ITFUrD8aJZ0PGksZOuN+bpJt8dBKk/kkNJtSXb9BGaTw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388235; c=relaxed/simple;
	bh=k0jSSuQRtViPtuvqk7JljIdGtHWQINwQPYkS+IqPmJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9xryBzhizh720sU+QZNLT/olpL71QTzm32AsBgyoWUU47EZFRbXr52JMs6P7GqIiHSJB3QhGKHIsLb+tugtRhiLYzCmOFAkJrkiaNHJwT9iWeVjO3Zgf46wuoYSBFC+OMMPYtQt5x0oaRGlksk9HpAI+eVk6U93ZdiRdS9VFsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cendio.se; spf=pass smtp.mailfrom=cendio.se; dkim=pass (2048-bit key) header.d=cendio.se header.i=@cendio.se header.b=5BtQjIpI; arc=none smtp.client-ip=193.12.253.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cendio.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cendio.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cendio.se header.i=@cendio.se header.b="5BtQjIpI"
Received: from [IPV6:2a00:801:107:4700:e2be:3ff:fe9d:f27] (unknown [IPv6:2a00:801:107:4700:e2be:3ff:fe9d:f27])
	by mail.cendio.se (Postfix) with ESMTPSA id AE120183613C;
	Mon, 24 Feb 2025 10:10:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.cendio.se AE120183613C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cendio.se;
	s=20250112; t=1740388223;
	bh=xQQuG62EfXaOpZGkufjzIDELyNx2R0u7bML7jDKFvcM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=5BtQjIpIOQ1Wc6C6fL+5NPagG+2QZLivcWwO+pWMixpvZfNHK3NedeDd1UlmUrBFN
	 KZhOli+QY10st7xBjWmTYkCrJDLioAZ5yE0EbHApN/67pqe/DUCnyYYG93PAdODmmd
	 2/RQ74EyVfnAGtrgKxMIhH4PMFqTNbtoSA1FIC3RwVwuwdM6jzyZkQaWQpR5/suLRF
	 rgvcKt0XcVQUIwpuWE4uXIjmw+y5fsh7YvFUBFN3IrsIDhSVnRrPxeuuIiq0gcL+T3
	 BcEVeF15IsQvFN80NjPLTwBhiJpsmnAN57BXWO1Pu0SE5IAMVWMzDOF2NmGml6ynXk
	 kf47fj074q5Cw==
Message-ID: <b0b1007c-34a6-4e3f-9982-cfe617affe1a@cendio.se>
Date: Mon, 24 Feb 2025 10:10:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] git keeps recreating packs, exploding backup
 increments
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: Han Young <hanyang.tony@bytedance.com>, git@vger.kernel.org
References: <1524b9a5-6f8b-4537-ba6b-bdfdd4b1bdcb@cendio.se>
 <CAG1j3zGmA30w545+-6qFV6x+3HvM+fueYH-rv-_gaSTpZStMHg@mail.gmail.com>
 <ba212d4e-32c5-472a-8604-2a2653bde17c@cendio.se> <Z7g2aEpEboL5mvRa@pks.im>
From: Pierre Ossman <ossman@cendio.se>
Organization: Cendio AB
In-Reply-To: <Z7g2aEpEboL5mvRa@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/02/2025 09:16, Patrick Steinhardt wrote:
>>
>> Anything I/we can do to shed more light on the issue?
> 
> Well, one of the interesting things to learn would be how often you end
> up updating those repositories. You have discovered "gc.autoPackLimit"
> already, which determines when exactly Git is going to repack existing
> packfiles into one, and mentioned that it doesn't seem to help you. But
> whether it does or doesn't help really depends on how frequently you
> gain new packfiles in the impacted repositories.
> 
> When you have fast-moving repositories and developers fetch several
> times per day, then it is quite likely that they accumulate multiple new
> packfiles per day. And thus, it's not all that unexpected that you will
> have to repack the whole repository rather regularly. If so, this is
> working as designed. You can tune the parameters for how often Git will
> do an all-into-one repack, but also have to keep in mind that the more
> packfiles there are, the less efficient Git will in general be.
> 

I don't think the most problematic repo should be moving that fast. But 
I might be wrong. We've reverted all settings to default, and we'll try 
to keep an eye on what happens to the pack files to gain more understanding.

> That being said, there is an alternative: Git nowadays doesn't use
> git-gc(1) anymore to perform auto-maintenance, but instead it invokes
> git-maintenance(1). And that command allows the user to pick what tasks
> should be performed. By default it uses git-gc(1) under the hood indeed,
> but you also ask it to not do so and instead use an alternative
> mechanism to pack your objects.
> 

Thanks. This is definitely something we can try. We'll observe the 
system for now, to establish a new baseline. Then we'll try some of 
these settings and see how it affect things.

Regards,
-- 
Pierre Ossman           Software Development
Cendio AB               https://cendio.com
Teknikringen 8          https://twitter.com/ThinLinc
583 30 Linköping        https://facebook.com/ThinLinc
Phone: +46-13-214600

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
