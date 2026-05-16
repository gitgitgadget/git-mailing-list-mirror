Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDAE2556E
	for <git@vger.kernel.org>; Sat, 16 May 2026 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778914565; cv=none; b=nePKfxBv1GXpzXuMCS7Uh1rU/ii4FlO9q5BTR+lUQo3wtwOezjh0/rogkyPMgU4NQkBRJSNzDGRat2JhpCFCl9OqqBACjW124IKlzFyN0mq4a2hB8HuQA+j0L5u4Dp70sOlB1mkUUIdqQ2l0FXKeOSdN2BMzrTQTRnb2OGv9bmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778914565; c=relaxed/simple;
	bh=4EqPuqVra/P0cZEb9RcApEzP4duxnpt6XDRfHKcdMkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByirexhvgVymt+FZqmPbX1rpGaug/Ex6dFJP7zwghb2PqghmgdD6nlrvpXjgrhb9JXSyYjsy3xbzG6+RN4RPOvptlkcKmSf684SEWBbscPoFp+uJKIMfsyUHy3uNzqq69qGv4RwnAoMDWzfAMsApIaB8r3UZs94G/+enGzZtAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4gHZbG701PzRpKv;
	Sat, 16 May 2026 08:55:54 +0200 (CEST)
Message-ID: <9ce768d4-0cbf-4494-a1d3-55fd3b05b61e@kdbg.org>
Date: Sat, 16 May 2026 08:55:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] evaluate the second argument of ALLOC_GROW only once
To: Jeff King <peff@peff.net>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <323f5677-301b-4d7a-b552-6606597c2b1f@web.de>
 <20260515190818.GA98370@coredump.intra.peff.net>
 <20260515195049.GA149960@coredump.intra.peff.net>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260515195049.GA149960@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 15.05.26 um 21:50 schrieb Jeff King:
> On Fri, May 15, 2026 at 03:08:18PM -0400, Jeff King wrote:
> 
>> On Fri, May 15, 2026 at 08:16:50PM +0200, René Scharfe wrote:
>>
>>> +		size_t alloc_grow_new_alloc_; \
>>> +		if (st_alloc_nr((nr), (alloc), &alloc_grow_new_alloc_)) { \
>>> +			alloc = alloc_grow_new_alloc_; \
>>> +			REALLOC_ARRAY(x, alloc_grow_new_alloc_); \
>>>  		} \
>>
>> What happens if a caller passes in an argument that isn't a size_t?
>> We'll check for overflow in the size_t space, and then truncate it when
>> we assign to alloc, I think.

> 
> Hmm, playing with it and looking a little closer, I think we don't end
> up overflowing the buffer because you use the size_t for
> REALLOC_ARRAY(). So the result is big, but then "alloc" is truncated.

Protect against double-evaluation of "alloc", too, using

	size_t *palloc = &(alloc);

and use *palloc in the two places, then all callers are forced to work
with a size_t as third argument. Don't know what the damage would be,
though.

-- Hannes

