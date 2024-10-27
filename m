Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB54D1552E3
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730036904; cv=none; b=iSRDrEzgK2a2jEid1x7J+h8fq/KprUjZQkNpzPFliXSBZSNJp33Ult2f7S+v+PbGn5qvb4GuTEB09Wkdu25cEl7gPWgodQ22cyUYrZmkKrpdQBCXOJSfLdNpGNn+mFn3+Dp0XkPZ7KViVjsFDU0LYpEaXF4mmsz6esJvvy0DvEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730036904; c=relaxed/simple;
	bh=A5QX7FhEiu4UtV+uLCnkkIJplGebZLtSWtvCIIvPDLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5n3G6vh5BfcMTaVOglfMc2IqvW9fXnLgWARR/Qkc2LoBgRll228q2RTzJACdBxK652J/X1KCMkGfzd82n15RMZn98XKLeBHN9bBVLS6nMqbr0Fp3LblHDsFIHd3TnSkwLdTPdsQhi//0YzarUZIj/6m3BIpE09Z1XFxmIveGac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4XbxnZ63LKz5tvb
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 14:14:42 +0100 (CET)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4XbxnM6YNCzRnmS;
	Sun, 27 Oct 2024 14:14:30 +0100 (CET)
Message-ID: <bc0c9853-7dd4-4b1d-9985-25f75815b0a9@kdbg.org>
Date: Sun, 27 Oct 2024 14:14:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] compat/mingw: share file handles created via
 `CreateFileW()`
Content-Language: en-US
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1729695349.git.ps@pks.im>
 <907576d23d1dc39b679a323e74b6bfb227d6c17d.1729695349.git.ps@pks.im>
 <ZxkxAvLeMtxstVdS@nand.local>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <ZxkxAvLeMtxstVdS@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 23.10.24 um 19:23 schrieb Taylor Blau:
> On Wed, Oct 23, 2024 at 05:04:58PM +0200, Patrick Steinhardt wrote:
>> Unless told otherwise, Windows will keep other processes from reading,
>> writing and deleting files when one has an open handle that was created
>> via `CreateFileW()`. This behaviour can be altered via `FILE_SHARE_*`
>> flags such that other processes _can_ read and/or modify such a file.
>> This sharing mechanism is quite important in the context of Git, as we
>> assume POSIX semantics all over the place.
>>
>> There are two calls where we don't set up those flags though:
>>
>>   - We don't set `FILE_SHARE_DELETE` when creating a file for appending
>>     via `mingw_open_append()`. This makes it impossible to delete the
>>     file from another process or to replace it via an atomic rename.
>>
>>   - When opening a file such that we can change its access/modification
>>     times. This makes it impossible to perform any kind of operation
>>     on this file at all from another process. While we only open the
>>     file for a short amount of time to update its timestamps, this still
>>     opens us up for a race condition with another process.
>>
>> Adapt both of these callsites to pass all three sharing flags.
> 
> Interesting, and especially so noting that we *do* call CreateFileW()
> with the FILE_SHARE_DELETE flag in other functions like create_watch(),
> mingw_open_existing(), mingw_getcwd(), etc.
> 
> Why didn't we call CreateFileW() with FILE_SHARE_DELETE in the below two
> functions? I assume Johannes Schindelin and/or Johannes Sixt (both CC'd)
> would know the answer. Regardless, it would be interesting and useful
> (IMHO) to include such a detail in the commit message.

My attitude in the past was that deleting a file that is open elsewhere
is a bug, so FILE_SHARE_DELETE would not be needed, but its absence
could point to a bug elsewhere. Now that we have a reftable
implementation, it looks like I can't uphold this attitude anymore.

-- Hannes

