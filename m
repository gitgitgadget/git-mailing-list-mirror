Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.33.87.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381642;
	b=zsKQ014i2wZt53KTPOWbs1wH4OvYicEwhB7EJJJJ2jZmGaXHk8DgB+h1vMUaf4h1ee2Z
	 oU8B+xgzitDjcZ0LcXFDXG0wDdd3qkufBxParmzTw1eJzInDnPbUhs0Fud+0UhMtHCsRH
	 CQqkDoSZiIwW57x3pjMupL5pNfpuvcdzGnUiG8bfOkblm0zzCrobq3AGv6ORTJLiWmQmQ
	 BOo+TWBupB6yztkquMRnc9T/kQ61wNSBQl+Fm3ZaG0A7KvMf1nvUdOdMAUfFfVrqfaRZ4
	 om/6MZzIzzwue+A3cYGeY9K4sSqpSn01MDNUMiHPlAMFCzP9XyuK54hwWY3FkXOFiMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381642;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:From:Cc:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=QrbRuRak5jM7hMpw1/BfuZIMUIR6uZoxhSrJyTcAJZI=;
	b=r+Du1/gpv0ALHpBUkF/TldWRRxwXn6nLxF43IO8ABsXQDlUg4dWhOzR1S+M9pze3ABZk
	 5FMnt/rFYk4i36A7X7po71NS7gxGa5uwoHbc0KiEO4luq/ZWV/WXJ7EdjpCkgm6z5u3KF
	 7Y6O5+iiT0eDYCF0ZcFIAE58ZnicE+F5eSYFnDABBzGQd2tDD+eIywF8yuUaoQi1YS7fg
	 l8592ly/tNfzWpe8KIOPNFZR4DjzlSASQ/R2fqEvexiFx896FqCClP5orjUcPACaK8Ir0
	 HZQhGB1QTYePjymx3pQSulnr82OBGI5PI+fxKDRTUbT8xHoep790Znpye4Om8/HSr5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kdbg.org;
	spf=pass smtp.mailfrom=kdbg.org;
	arc=none smtp.remote-ip=213.33.87.15
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68C5606A320
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E68C5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.102] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4jPZg23hXzzRpL8;
	Wed, 11 Nov 2026 08:20:30 +0100 (CET)
Message-ID: <8b881ed0-f30f-41af-9e59-f4e93006545a@kdbg.org>
Date: Wed, 11 Nov 2026 08:20:29 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: APFS, mmap, and git diff reporting no changes when there are
 changes?
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Harold Hunt <harold@pwrdrvr.com>
References: <CA+-E0BVhYRsktwaUDxtobAXV98dymKg2n4ghod292imymE5C_A@mail.gmail.com>
 <avJLR6EdZ4OYmTpj@fruit.crustytoothpaste.net>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <avJLR6EdZ4OYmTpj@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 09.11.26 um 23:38 schrieb brian m. carlson:
> On 2026-11-09 at 22:05:55, Harold Hunt wrote:
>> One could also argue that this is Apple's bug or deficiency.  But that
>> could take months / years to resolve?
> 
> This behaviour is allowed by POSIX:
> 
>     The last data modification and last file status change timestamps of
>     a file that is mapped with MAP_SHARED and PROT_WRITE shall be marked
>     for update at some point in the interval between a write reference
>     to the mapped region and the next call to msync() with MS_ASYNC or
>     MS_SYNC for that portion of the file by any process.
> 
> However, Git relies on the operating system to reflect an accurate
> modification time.  If you write files to disk with mmap, then you're
> responsible for calling msync() in a timely manner.  However, as I said,
> that's extremely improvident for things like files in the working tree,
> which is why text editors don't use mmap.

Not to mention that our mmap emulation for Windows cannot reproduce the
Linux behavior (timely update of timestamps) and is more like the macOS
behavior (delayed update of timestamps). We cannot have an accurate
(atomic) msync emulation, either, because not even FlushViewOfFile[1]
updates the timestamp.

[1]
https://learn.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-flushviewoffile

-- Hannes

