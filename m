Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A221822DF
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211877; cv=none; b=NS8pZL41n5/GMr6ziAaUsdF8IvyQiEL2iRUZdcsea8QbZhbjK3pyTN5A/1Nhq5+OaIrCjfDb9t/AoXLXqn/VyA4OoN7d4rfBkBfrACiywm4DBxxAMKud2/pfARTkkCZwljvU0yOdA6DpwH59uxsC9y983ym0MjHH5zqj05qL0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211877; c=relaxed/simple;
	bh=3Alk8fCaVJV5b5L8RAGKd0N5x2sYrZzCSlzXZJvl7Kg=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=WCB/sBlgM0mRnMA1k10S5R3SSDUKeKcXz8G1vSNucaXx/kqP/5Xc7plB5WDtkEFt1hytihQk+TpcEeO1GbZ4G7lcXV1EUFemNjEWhbyRh/PLPYFTmUO2Utd4uHq8ehm2M9gm5cVlBY5fBKoFB9OAcXAIu3jyIGMJ3yHTiDgoG6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45CH4Hrx2217260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 17:04:17 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Dragan Simic'" <dsimic@manjaro.org>, <git@vger.kernel.org>
References: <950d4ad3bcee79df1424faee09eb6b00@manjaro.org> <164fc547afd66caf58019b6c614b5134@manjaro.org>
In-Reply-To: <164fc547afd66caf58019b6c614b5134@manjaro.org>
Subject: RE: [RFC] Avaiable disk space when automatic garbage collection kicks in
Date: Wed, 12 Jun 2024 13:04:12 -0400
Organization: Nexbridge Inc.
Message-ID: <123401dabcea$8fe50110$afaf0330$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIIU+0KvwdldrQrttxtRetA/I2EUQMWuS4CsVB0O0A=
Content-Language: en-ca

On Wednesday, June 12, 2024 12:25 PM, Dragan Simic wrote:
>[Maybe this RFC deserves a "bump", so let me try.]
>On 2024-04-08 18:29, Dragan Simic wrote:
>> Hello all,
>>
>> A few days ago I've noticed a rather unusual issue, but still a
>> realistic one.  When automatic garbage collection kicks in, as a
>> result of gc.auto >= 0, which is also the default, the local
>> repository can be left in a rather strange state if there isn't enough
>> free space available on the respective filesystem for writing the
>> objects, etc.
>>
>> It might be a good idea to estimate the required amount of free
>> filesystem space before starting the garbage collection, be it
>> automatic or manual, and refuse the operation if there isn't enough
>> free space available.
>>
>> As a note, the need_to_gc() function already does something a bit
>> similar with the available system RAM.
>>
>> Any thoughts?

I am not sure there is a good portable way of reliably doing this using OS
APIs, particularly with virtual disks and shared file sets. An edge
condition would be setting up a separate file set for content inside .git
for massive repositories, so taking an estimate in the working index would
not fix the above.

It might be useful to add a configuration item like: 

gc.reserve = size   # possibly with mb, kb, gb, tb, or some other suffix
indicating how much space must be available to reserve prior to starting the
operation.

Then creating a file (with real content) inside .git (or .git/objects) with
the reserved size. If the file cannot be constructed, gc gets suppressed.
This can happen for more than size issue - permissions, for example. Note
also that some file systems to not actually allocate the entire space just
setting EOF, so that technique, while fast, will also not work portably.

After the reserve works, it can be removed (and hopefully NFS will properly
close it), providing a lock is put in place, followed by gc running. It
might be useful to do this even on a non-auto gc. While this can be
expensive (writing a block of stuff twice), it is safer this way.

Just a thought.

Randall.

