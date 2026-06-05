Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040484192F8
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661465; cv=none; b=ch+xGtFc1T5Ri2wfHYgfEbmxMcTq5WNGpAZ83J3Nulep0UhIMaPp22j96yeoCx/PESQY0jfwuxnmPCn0G9XKVxx1FGgnlw6AqEP7ygn2phoY0K6Gk6Cq3sXq+Gbiwyb1wmqrDXv05Kfu1vnvCE5BYiZ5Ge4CtN6Euti0n6uJ3xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661465; c=relaxed/simple;
	bh=veWh71XGTWojNd055nGqHL+UMWfc/YveOs7JbsHgi34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhJ6pngxYF/thRoOXYjTeFZ6qFgGzPob015QBwAFD+Syhm/hDSjYIsRZdERqZeCJH2iEWyfoHp7LfHAxa56AFH4RlqpMi7/FrB26Z4tV0W4AGIZEqGsyASWpxLvuhjTzgCM9v0V03VupjjoIMz3lf3yKfg/tfwCiPBqo2Wo0AiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.1.28] (unknown [103.52.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id A74FB3F123;
	Fri,  5 Jun 2026 14:10:54 +0200 (CEST)
Message-ID: <01d627c2-3625-4de4-978e-6fa4f63bcaeb@hogyros.de>
Date: Fri, 5 Jun 2026 21:10:52 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mirror repositories for submodules
To: Benson Muite <benson_muite@emailplus.org>
Cc: git@vger.kernel.org
References: <875x42vlgv.fsf@emailplus.org> <xmqqcxy7qfgk.fsf@gitster.g>
 <d64e7f31-4e00-478c-ab31-b671242865fb@hogyros.de>
 <87h5nhr2zp.fsf@emailplus.org>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <87h5nhr2zp.fsf@emailplus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 6/5/26 2:05 PM, Benson Muite wrote:

> Simon Richter <Simon.Richter@hogyros.de> writes:

>> On the other hand, this can be used to construct a stable relative
>> submodule URL.

> For submodules, the metadata consists of the url of the repository to
> clone from.

That is precisely what precludes mirroring: if I clone and republish a 
repository, people can clone from that repository, but will still fetch 
submodules from the URLs listed in the .gitmodules file.

If that is a relative URL, then all is (mostly) well: they will also ask 
my mirror server for the submodule, and all I have to do is make it 
available.

If it is an absolute URL, then I need a side channel to communicate to 
the client "you can also get this repository from me." This could, for 
example, generate an insteadOf config, but that would be a horrible hack 
that becomes unmanageable pretty quickly (updates? security implications?)

Hence this thread: is there a way to represent submodules so that their 
identity is independent from the hosting location -- and this ties into 
the other thread from last week, giving projects a stable identity that 
follows them through clones (or, if someone is using a forge, forks).

The download location for a project is project metadata that lives 
outside the project view of time, but it is expressed as (versioned) 
data in git, in the .gitmodules file, so if hosting for a project 
changes, projects referring to them must either rewrite all of their 
history, accept that old versions will no longer be buildable because 
they contain a broken link, or expect people/CI to manually generate 
insteadOf entries.

So the problem here is that we are treating metadata as data.

    Simon
