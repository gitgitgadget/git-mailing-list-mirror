Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1C2D7384
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766135885; cv=none; b=R3Glwsid10qm0wBkK0DJIkpm9VzHtf0KpnH2dmlTzLyp9/FvvpwQi+/smBJPnltufVxK6TO4gN4QjOJ+FoNshYi9zIeKwPuAWIR8I20IL3anT7pcOo7UbQRhAzwSewyE7VhRX+/h5YO6lHkdmYqUbmRh2AxsMnyW7osrZo2TDaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766135885; c=relaxed/simple;
	bh=53M/Lm2j+GKUuF5DVx6uGSkLOq4IsXiSppINJL2NAYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LZlr9Ai6fJZ3pzWELkMaIzqPzBV+FhXEr5XWi31M49AlgJu7YMMsqqgDcud1p5R2JlATh5eTeTvfcNEIFtOu5ophsngPhQmboDLL3W/4X6x60o8aNLn784ubtWq/ax93IcOK0w5pghrLafBmLyKvd3GezJuh64/7ZqOWwQiRdQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=tBk+m2hX; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="tBk+m2hX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1766135877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTngoWDNSSIe9ujO+vPQ/ae/+498PjmRY2ic6Y25KQ0=;
	b=tBk+m2hXgoAklOnNHMaqXWdAngJ/awPds6CuXmw5a+KqjzdeYkGwCNDPMoGyH+iiknwTfq
	LvqZE8hIY4CyrvG6x9m4EnybwxUGI/fhoMJu4pQ5c23skPuoA7n9A7fELQXYEn4LzUcZd3
	hTY7wmaPw01/gX4hQgp8z0YlmSqkJjM=
From: Toon Claes <toon@iotcl.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, Junio C Hamano
 <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] git-compat-util: introduce MEMZERO_ARRAY() macro
In-Reply-To: <f02b628f-b9d7-4436-88ee-3255e02cb0f3@web.de>
References: <20251210-toon-cocci-memzero-v1-0-ae916a79065b@iotcl.com>
 <20251210-toon-cocci-memzero-v1-1-ae916a79065b@iotcl.com>
 <xmqqtsxxg0z4.fsf@gitster.g> <f02b628f-b9d7-4436-88ee-3255e02cb0f3@web.de>
Date: Fri, 19 Dec 2025 10:17:33 +0100
Message-ID: <878qeyhlua.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> On 12/11/25 4:18 AM, Junio C Hamano wrote:
>> Toon Claes <toon@iotcl.com> writes:
>>=20
>>> +@@
>>> +- memset(ptr, \( 0x0 \| 0 \), n * \( sizeof(T)
>>> +-                                 \| sizeof(*ptr)
>>> +-                                 \) )
>>> ++ MEMZERO_ARRAY(ptr, n)
>>=20
>> Shouldn't we be also catching
>>=20
>> 	memset(array, '\0', sizeof(array[0]) * ARRAY_SIZE(array));
>>=20
>> in addition to "0" and "0x0"?
>
> Good idea to match "sizeof(ptr[...])", even though we currently don't have
> matching code.

I didn't include that because I didn't see any case that would be
covered by that. But it's good to include it anyway to capture future
code.

> Good idea also to match "'\0'".  There's code with that pattern in
> compat/regex/.

Good find, I didn't think about that.

> You can drop "0x0", though, "0" matches it already (at least for me, I ha=
ve
> "spatch version 1.3-dirty compiled with OCaml version 5.1.1" from
> Homebrew).

Nice!

> If you put parentheses around "n" in the pre-image then Coccinelle will
> remove them if present and still match code without them.

Well, that's not what I am seeing. With parentheses around "n", it
didn't match the case in builtin/last-modified.c on my machine. I'm
using spatch v1.3

> They are no longer needed without the multiplication. Their removal
> would improve the result for ewah/bitmap.c.

I agree it would be an improvement. Using `\( (n) \| n \)` does the
trick for all cases I've found.


--=20
Cheers,
Toon
