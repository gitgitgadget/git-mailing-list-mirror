Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CBD1E505
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735330599; cv=none; b=gVlKskxbc5Pbhu8iKU0fDauG/QhXZ4seS83Gv9Ml8ILpVVrta1TK7wMN2QPsS0A6FynWsjcKm9952QHx+D3HXiMXYCs94gxRLxwbKqQhRp+LsmN1qi4Dkxx6kzngdRxCuK8VeDutBos2/Vbkn1h/1DtnzOKbzhcsKFHafp2pviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735330599; c=relaxed/simple;
	bh=buT6CLdunJJn0ICUayumnB4+X5Xl1xBuLUPnyWJWdEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDMgVRnHJOoKzFREVMeAJcX4srW5aEeIXZlrk6Ghq1xuHGmEBXT/VM7CaIGNKUCjVDRsAjUPVnW2DHWjJmt//BeTOGdc17Swpz06QbCqWEvsXKaD0mUfcNbfDMbTLzbRFZmN8QthcQs26W73qDZvyDTy6imBxes5kg4URH1sPbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=YvWo9cP7; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="YvWo9cP7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735330587; x=1735935387; i=l.s.r@web.de;
	bh=q9NpD3m72CnFhs758hO513VaARkuAwZ//QN0wZAngVg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YvWo9cP7r8LnQwIYH0EhNV7xIcRrihUYM3YVoVvlKKxrQOcFp5/DsFZQ2dTpapWh
	 tg79rv1t6F2tOqL5kfSk+w9nTeROPGv84KOat4YGDaDoawEmSer/h3GQrXiHNyFws
	 vls+4rWqvYOC4AiOVrTOZEfkwoW+GI/QeGnjQMHXKXJ1ZIv2zlG+5TOk46Xg5Fo4m
	 LqauAkrGevlZv978OhQurYHTnFyGCcBqMgmUCBlxDcI/bzIoK1wdtVo8BPZAf1sjv
	 KOlh44DiSh+nIjSgVLfTx8PQV+tosLxHQVrzevktwQAaSMzu7V1pr1gMmrxFiud31
	 Ni/B7xw5hlnn9zt0rw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M43KW-1tRGl11gp6-008hyv; Fri, 27
 Dec 2024 21:16:27 +0100
Message-ID: <039f15a8-aef7-41a0-a396-c395a8416c3c@web.de>
Date: Fri, 27 Dec 2024 21:16:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] reftable: avoid leaks on realloc error
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
 <9b2f4baa-b602-4cc5-8dfc-dd941b1d7af6@web.de> <Z26CjQpewcyLwfs4@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Z26CjQpewcyLwfs4@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RCXBhv+LnvlhgikKPoeV6AzeOoIhF0GbqtNBmUxpkP4SR+x0gMM
 fpdFP9I/+kKiCOYg1YT1/GMyFJVoCyWhBMafDcl/OuXd2ERKpRpDEEEUQRB1LUTFs32AfNT
 UCduyM5VQ/fTmPWptTHlghvYgutzy6zafb8ogpxYU+8w/z9GIKzlJb/qyZQ+SJaxJ6n+DjK
 9VO+lWco2lxv5dAns9uag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3GZQnq5sBPU=;Vcb6ZPbHXDGBWvvBQrHm6hbF1zk
 sd2yR4piDuulOuz54j1zfSV1VTFoKRc0PkOyfNw94efwxdavHAO050kAUD0CE5/pRzIsJ3h8Q
 jpCNj1w6yR9KqwXOsJxQ45ANKBC+IjwlHIqF7PkPWhxtPgkacHNqqSQU2JZ/qAN1KLRF5BsZt
 m6N6cEgI/BllLbRePhtTuYUIkx6rIxdY/DoSIl4As69juKeq5CkxOo8PwTmhhDMyLyKz5Qd+D
 u2E1846sv8GK3jVX5X6Use86Xyl8McTHCUdpfufA4uMRfu85faarNxxuW6MFR1/TDVgSNX7ih
 Tczej/k07ekY8yk1NzMO/Xfy6Jr8t81DxMhvQ7I3zF3/RXT65aOQA0Uk1DKU/VJ4BcIphowss
 TxAh4bwfhL4duHvHoKwd8E1coocjVExvxvhys+HsFuKkOqKbjOGdZH7qLC+Lhw8HUA5dO9F5J
 M/dy5FAUMYYjYYvnL4xqrdyF//x42CB4+nGRHdGcpuHzx6MgGDbdScO/lu/UXHrdT4UzzPvTw
 e2V2doY2xkByf0zeUjT/nuiqQ1B24fNe92SdE3TfYbpWDv10ytONjnDhOItmt2Nuj2hOeUlW9
 sGYSjPoS69vnLC6ZwLLJVoxfUQMvO65P0ItDxt6tw1W3O0B5wTCxhsCCQHosBuDnQ8Id1Z1x9
 R8jXacify+t5bN4eqxcD7o8W3bBlLdpkjnM0vCMyCZ/46K4GEcJsJ+VEIVfZms5aNRYRIOuzH
 p9+4CpWhBglsPY7cQklWXWqYBVKs0r5pQ2d7S+3RScYSt0NwWpcL17tet4qTDk+ErIHemHfVa
 7qTLUXGj1WiUItoPL8C8t6wXo/uf64OkQ/V5vGq22V3QKGjyqibwRAaj6t7TvF288qEdeZL6i
 jgkOu9vkjxOiJ/3e3bfIPChGXYNmEpw9ZhWyxV1I+od4whrAFFP2Cd9F4wQ/veAVgwMWCi4tv
 tjLymWzV0LefNN3LZ8omFcuyIeRn30xRtW0xy+JHPbLsQYsRt4AhTEoymhQX4wpIqLxGAXjgV
 B0JdyGF9WOG8/XlSbp4civJJn+P9M2ehU4ES3C3ohPvmcaIJBh9kf/j6+Yvyp0OOsP5edehKs
 X8+9qQd/4=

Am 27.12.24 um 11:33 schrieb Patrick Steinhardt:
> On Wed, Dec 25, 2024 at 07:38:29PM +0100, Ren=C3=A9 Scharfe wrote:
>> When realloc(3) fails, it returns NULL and keeps the original allocatio=
n
>> intact.  REFTABLE_ALLOC_GROW overwrites both the original pointer and
>> the allocation count variable in that case, simultaneously leaking the
>> original allocation and misrepresenting the number of storable items.
>>
>> parse_names() and reftable_buf_add() avoid leaking by restoring the
>> original pointer value on failure, but all other callers seem to be OK
>> with losing the old allocation.  Add a new variant of the macro,
>> REFTABLE_ALLOC_GROW_OR_NULL, which plugs the leak and zeros the
>> allocation counter.  Use it for those callers.
>
> Hm, okay. I find it a bit curious to discern those two macros from each
> other as all callers need to handle OOM errors anyway, so doing the safe
> thing should likely be our default here and all callsites that don't
> should be adapted, shouldn't they?

I agree, and I my first version only had REFTABLE_ALLOC_GROW.  Keeping
stuff unchanged if we cannot grow should be safer, right?  But it would
introduce a leak if the caller exits without cleaning up, so each of
them needs to be audited.  I was too lazy for that.  And it's work that
can be parallelized..

> In the case of `reftable_buf_add()` I kind of doubt the usefulness of
> handling the error just to keep the old pointer intact, as all callsites
> will ultimately error out anyway.

I can imagine use cases where an object is built piece by piece, one
part is too large and then you still want to keep all the rest and just
replace the huge thing with a placeholder or entirely ignore it.  Could
be a case of YAGNI, though.

> But in the case of `parse_names()` we
> do in fact want to handle the case specially so that we can free any
> names we have already parsed, so that case makes sense indeed.

Yes.  But that leads me on a tangent: Is it really a good idea to load
a file into lots of individual string objects instead of loading into
a single big buffer and pointing directly into it?  Do those strings
need to have individual lifetimes?

> So there is merit in having two separate wrappers, but it would be nice
> if `REFTABLE_ALLOC_GROW()` would be doing the "right thing" for most
> cases while the above two callsites would be adapted to use a wrapper
> that requires a bit more thought to use correctly. For example something
> like `REFTABLE_TRY_ALLOC_GROW()` or similar.

So this is about naming?  And with "right thing" you mean failing to
grow should lead to destruction?

Ren=C3=A9

