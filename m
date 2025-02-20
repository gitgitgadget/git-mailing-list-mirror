Received: from mail.cendio.se (mail.cendio.se [193.12.253.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4A1EB192
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.12.253.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040006; cv=none; b=Ez53lNKdhFU2jJxmO1aRBpoGJojprpeuNZJdZcm2/7kfMjdaqA4vCkY/fId9TIj4kgNG7c8fovcBAyMs45GR7fV1nbVCW1YjPXIjtvkyDQZuFoBm1mxHYTwyFEzFCWyHHkVroCwME/UeuCa4itOLAAbRFGsJyLQ2kdlMsyLKEzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040006; c=relaxed/simple;
	bh=0uLXX5Kt0gkmgJQijnNDOomg45Z6+L4zSUREdAKhhm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OyCTYyMAZV+anValyOXcI5L/WciOvkKIKa0ifO2eS7dwznb1lhUGRGFbd5D8k/16uRJweBXCAbTfuHI2BeWqSJ/Hvz3mItaWpL47Zrv9h4eGlSB0MuLZaD042CIHalbvDvKo04e9GGfADNS2waLkpgj1Bsnda3AGmOoZ0oB/TWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cendio.se; spf=pass smtp.mailfrom=cendio.se; dkim=pass (2048-bit key) header.d=cendio.se header.i=@cendio.se header.b=VlUa+acr; arc=none smtp.client-ip=193.12.253.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cendio.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cendio.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cendio.se header.i=@cendio.se header.b="VlUa+acr"
Received: from [IPV6:2a00:801:107:4700:e2be:3ff:fe9d:f27] (unknown [IPv6:2a00:801:107:4700:e2be:3ff:fe9d:f27])
	by mail.cendio.se (Postfix) with ESMTPSA id 6849A1835C13;
	Thu, 20 Feb 2025 09:26:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.cendio.se 6849A1835C13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cendio.se;
	s=20250112; t=1740039999;
	bh=5g7vamElFBZnNmQwaf5ocnKnoQxLPFOcNNsttdTNIqw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VlUa+acrMYIcV9hIMMm3ifH5GMqU36547pdZ4AQlzUSKocX61BGXL95JPWQeLM1SS
	 k6iU7AT3maYXgg+Mf06t7bwqKETDTciR999qbk/IGpXU5M6/F9OFa0Hoc+VVXWierw
	 9R3qB9W1GewtHyvy3dbueaOhzO3lTj3r/6u1e7VTk0HyKdO1YEeV/5cQ0Uuh+LsNbr
	 Zme4y6UALr4d6SkuBfH1LxJwFz/lfzbmFBWV1vkJDRu11yNWZJZEazZuCYlp53yN5f
	 caIuQLcoDLxmHvB9kXel0dRLG55GXYWALnm0HThht+FFdREdEgItgMFYQPdllI0wHj
	 kIFlxbMJ+fE+w==
Message-ID: <ba212d4e-32c5-472a-8604-2a2653bde17c@cendio.se>
Date: Thu, 20 Feb 2025 09:26:38 +0100
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
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org
References: <1524b9a5-6f8b-4537-ba6b-bdfdd4b1bdcb@cendio.se>
 <CAG1j3zGmA30w545+-6qFV6x+3HvM+fueYH-rv-_gaSTpZStMHg@mail.gmail.com>
From: Pierre Ossman <ossman@cendio.se>
Organization: Cendio AB
In-Reply-To: <CAG1j3zGmA30w545+-6qFV6x+3HvM+fueYH-rv-_gaSTpZStMHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/02/2025 04:03, Han Young wrote:
> On Wed, Feb 19, 2025 at 5:58 PM Pierre Ossman <ossman@cendio.se> wrote:
>> We tried gc.bigPackThreshold in the hope it would force it to reuse
>> packs better. But all we got instead was duplication. It still creates
>> new packs with everything. It just stopped removing the old ones.
> 
> Is the repo partially cloned? git-repack will always pack promisor
> packs even if it's a keep pack. This patch would fix it
> https://lore.kernel.org/git/2728513.vuYhMxLoTh@mintaka.ncbr.muni.cz/
> 

Yes, the big offender is often partially cloned. So that could be part 
of it, thanks.

But we're seeing it in other repositories as well. E.g. I have a 
long-lived TigerVNC repository where the biggest pack file is just one 
week old. In that case, it's merely 21 MiB, so it's not a practical 
issue. But it does show that git keeps replacing it.

Anything I/we can do to shed more light on the issue?

Regards,
-- 
Pierre Ossman           Software Development
Cendio AB               https://cendio.com
Teknikringen 8          https://twitter.com/ThinLinc
583 30 Linköping        https://facebook.com/ThinLinc
Phone: +46-13-214600

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
