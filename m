Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABCB15C0
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755986622; cv=none; b=Q254sITvDmcbN2qrfPTTX6MTeepGZiPH+SZfpa09njwW6tVJzP0fQVoPS23XJUzwk4cq06R5oaY4EevEySdx7cMufyA+LX/9ppPHMkiscH2ZuwsXOWNIz+sCLYSD37+3GmR3Bk2e3IeV+th10ySaGVaFKVsoVo6bSeVXyP2Zz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755986622; c=relaxed/simple;
	bh=o9VkyMCZllf2IDGOQ66pHfKpVzO626r8o1BrySiZ47Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyGuQAi+JS/UEcZjopdoAfuQmNOp6t/OamkTJbi9YLrtTn3LzBCLZz7vNP2/m0Me7ULhdT0h/gMP3rMkNbGytV2TPI8alW08qlA5bDia1d9twcRHjjEb1yr/yMg11ZP2xTtjl1xrumOizcvhGZftlGvWlZyTpVrKzG14SULtyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144220182.atnat0029.highway.webapn.at [89.144.220.182])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4c8WKG10lnzRmx1;
	Sun, 24 Aug 2025 00:03:30 +0200 (CEST)
Message-ID: <08f405a6-fd2e-40d7-850a-574356b4009e@kdbg.org>
Date: Sun, 24 Aug 2025 00:03:29 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] progress: replace setitimer() with alarm()
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 Nicolas Pitre <nico@fluxnic.net>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
 <86bf04c7-6315-46ef-8297-42efc3ed322d@kdbg.org> <xmqq4itxvi3z.fsf@gitster.g>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqq4itxvi3z.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 23.08.25 um 23:33 schrieb Junio C Hamano:
> Yes, the use of itimer to only change the flag without doing
> anything funky has been a very safe way to use signals, doing only
> absolutely minimal thing in the signal handler.  Having to rearm the
> signal in the signal handler in Carlo's patch made me feel dirtier.

While this is clean on POSIX, it isn't the only platform where Git runs.
On Windows, this part of the progress indication is as dirty as it can
get. Getting rid of it is a big bonus in my book.

> But looking at the wallclock once every iteration of a busy loop?  
> 
> Operating system folks may have worked hard to minimize the cost of
> system calls to gettimeofday() in order to help applications that do
> so, but I somehow feel even dirtier to hear proposal to do so to
> replace a signal that we set and forget, to be reminded once every
> second.
I think that ship has sailed already. Look at display_throughput(). One
of the first things it does is to look at the wallclock a.k.a.
getnanotime().

That said, I am not very happy about the new calls introduced in
display_progress(), either. I'll see whether I can produce some
performance measurements.

I observe a behavior change with delayed progress indicators that I have
to understand and fix it before I can submit the cleaned up patches.

-- Hannes

