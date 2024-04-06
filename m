Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED2910A1A
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712398972; cv=none; b=JS2CL5n/xQvM9sDOujJugfQzFs++pC+4JErWieGSOjLWhsKulAfu0Z4YOfmXGyiNfkl2FDv55v8IRD9GEbdi2WyBKyLbePt01R5oKK56flhHIoZx0S4NVcsppdEP8Fg5EHy0GMyI31iUOeBJZfFIWpHDVK6jJEVBXx0Nt7IQO40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712398972; c=relaxed/simple;
	bh=4NfD+uINkQSMVH5tFEw3OVMo6agtZGZrAOuIF75PZp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXt/RuDedkzPAAE0tsmpnygSOo4oJa2NAK1O5W2t6+zg1F2RS2x1i54/CyWFSwFm226imG7n9VvGl81zW9/h0owaNR4q12k1t5k9qSYQYCCrC4DcKdLLsW9iN2sFY0DAbEH5mMkIaQ2IYqF3TYpiIFgEx7OcdGH62an9Wzt2P2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=XXRuswrv; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="XXRuswrv"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 7C7E71A17658;
	Sat,  6 Apr 2024 12:22:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1712398965; bh=4NfD+uINkQSMVH5tFEw3OVMo6agtZGZrAOuIF75PZp0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XXRuswrvX/E6dS9rXGG5rtBJkASRZ13M5Zn8hGyghUsWv/jsarzIrM5U/lIJTouLr
	 3cZBMQfSVCKZWNrZbYaVkaqTCXMCif4AA47/9SG/tKQHskpj8csIDk91SoIYPx0Ki+
	 gHliwIkO9Rk3q6L3eS22MxvqjOopfEQRbF5QGQ3E=
Message-ID: <30eccdbc-f0c4-4b8f-b735-cf5613912a9f@schinagl.nl>
Date: Sat, 6 Apr 2024 12:22:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>
References: <20240330081026.362962-2-oliver@schinagl.nl>
 <864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
 <xmqqcyr3s3gj.fsf@gitster.g>
Content-Language: nl
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <xmqqcyr3s3gj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06-04-2024 03:08, Junio C Hamano wrote:
> Olliver Schinagl <oliver@schinagl.nl> writes:
> 
>> Hey all,
>>
>> I've also got my work on a branch in my repo, if that helps to look at
>> things, https://gitlab.com/olliver/git/-/tree/skip_bisect
>>
>> Also included is a script to be used as an example. I opted to use
>> `git show`, which is nice because it works both on commits, but also
>> on notes.
>>
>> Anyway, any thoughts on the bellow before I send the full series?
>>
>> Olliver
> 
> I would not write get_skip_when() before studying the same file to
> see if there already is a helper to read the whole file used in the
> vicinity (like strbuf_read_file(), perhaps).

So I just remembered, when I started this journey, I wanted to squeeze 
it all into `get_terms()` and make it part of the terms struct, as that 
was passed around everywhere. I figured, I can rename it into being 
something more generic. But I realized that skip_when doesn't actually 
need to be passed around at all (which we can see in the current 
implementation). With get_terms() in my mind, I just what that function did.

I saw strbuf_read_file() but I didn't quite understand what it was 
doing, it was a bit cryptic at first. Now that you mention it however, I 
see the error of my ways, and that strbuf_read_file() might be good 
enough and do exactly what get_skip_when does.

So thank you for that hint :)

Olliver

> 
> I do not have enough concentration to follow changes to
> bisect_auto_next() is reasonable.  Especially I do not know why
> "bisect-skip_when" wants to exist and what it is trying to do,
> besides the fact that its name looks horrible ;-).
> 
