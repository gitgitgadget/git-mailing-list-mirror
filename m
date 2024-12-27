Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF261E505
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735330589; cv=none; b=Cl0TPmQ1O2kVq9Pjs3GGoOGFQUxKJuV30C8lcsj5m8mlgUJ8Jxr94vLwwJiQ17s0kTbHnaxbEpJyPDCEAc6HykEdHwHrRDOlZ1tK5LvdpC43mvyFQdB/HK49IrE7Pkdy9o5a1/fJscHhLCYutVlLpBwhWR0Zms2by5tAgbhlUBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735330589; c=relaxed/simple;
	bh=04XMCu8nprgPChLjg09O50yh0dT1jcz/F4ywSI0Tdck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXDYALJOxSk2Eb2y0T7R9AGI+nhdTEaKCqxvoeTGTIxHQefM81xWtsnpC29PvVfRc5RprnlRGBn3iIzBO0YJdH2Xti7LT8VDRtRXbHDwzx/DutdtwM6fx2BCiTkk+1JpFO4xUMQpfxeMIdLzICnOdAbJvhAj6KMOrQFKTsimuME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=gvhGPonY; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="gvhGPonY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735330583; x=1735935383; i=l.s.r@web.de;
	bh=lTBLJXZgqYDcgNjmGInpEDHEejDXy5ure3KWHhyG2XY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gvhGPonYlmnShiUr4oEibQExb6/FXi0vNyCmV4URIJeG6/gvsaFDZikmYJK0UCFY
	 KOXUmCFZVMgnBogr5vybxqT/ipOTnRIYGne8kUOtrbfkF5Iov0WgT3hx1WT+rYYnU
	 mQQtQDzmMcHZNkwfHCBVh4JgE4DGkaHqWtmiGydJWFLIGZ7/EVLqG42D3Z+/pHUjK
	 u/eFGnKr0Dyjx9yaECUSTxSELaGEhPdxfb//M1pyduq2PvKGjZH4KLgjwYMGVnbld
	 Oa8YxrfUjO0gUxGNXh04VgwcApc2X1Ri9QZy3kb83hRPlLglzdnRg4C+k+8mrDqsr
	 M+GlkiFLi/baq795Eg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M43KW-1tRGkw3t9E-008hyv; Fri, 27
 Dec 2024 21:16:22 +0100
Message-ID: <68bd4e99-ed59-443a-a3c5-bb06653cfad5@web.de>
Date: Fri, 27 Dec 2024 21:16:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] reftable: fix allocation count on realloc error
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
 <33bbacc7-1727-4efd-9cbf-3c9abfa94d8c@web.de> <Z26ClnvVH1cg3CGQ@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Z26ClnvVH1cg3CGQ@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZtHasWhqq7IX/F9KmLQ+Cj2w9KgPRGiKSQhmeEPgJNIXJMlqBno
 nBeaL7sqVeZgNDOy9gMoK3ZY/5vWryoEN8DK91w0AMZwhzAvZBvSz4uI/jhhBaEy31+cdbo
 1oqWuKEQbcORGE99u8/SA3w+nusdFe1pHpu5WmLJrJSgQHZWVyQhnCt/3ljKCVUeanqKz3k
 QGvYJnnw2t4i4z1ETAZiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:edm57EOV7ik=;XTPakUw+u2vrLI632KGJNNUD6e/
 VUWiBY+u0SM6IMZ9o8fOZs/rDtd0Ie5NxnjS+4+Jl6jwwAh8ytx8uwVpyKJKUblbVMHtjXbqd
 /Mnc9vmRBRO22VL04S2BvIOFKqoPioDxsA8McmNVrpJGNmbRM+QrT3bUyoqe8jTbLtg3m9Prf
 ODixM/xq5k44ILrTsA+jWxytwkZDtxczpLDLF1/Iceur+8zgTP8NH78CpupsfRA2Wr5f5cXxw
 CSTppVHtK0iNKLktwwq1Go3u8al0+AIJIpIt1ly3R8njJjsqUa2HeLu9hNxZopJcm3AGLxVjX
 cz03bHcqt1LzfTgUgR2QUJ9Sgf4Q6WxHP575kd/4vew/S3QdSXX+mED6kssuDPprSBW5OjR2q
 cblwHkBobJyaWKQKMJKNT4TWjf9l4H9UO5ex7tVimB1yxJdmFA0NbBWFSaeHUu+ZsbbY59Wkt
 KOYnArjLQ/irpCzcINu+3ZKxJSNRMvZL7yUfdUBa/EAkAgOsLZZjcgb2Grqzi/PrPPi9INkQP
 VSSZS283bcGpi7A2hIBO9dsg0j1qaNYaoCkWZ11ybQxPk0eI4b3OrYy/oEyU2TB7YqWcKjCQy
 BX+TGseUfiwfWITFdJay4ecOnPxPF/+/w0UpXG7Ljtpl/YrDZhpO8fWu9ZmojZH3qMhcoDIcC
 D2m9SuH/xarZul4Ykir1nRC00/4KOTYAgAofbzDoe9LisxlE9p98lQTxywOv7pgOxue6bzK4p
 U/iZ+R9TusaZe69lfhVlipJ0tw2UUlYNo3JJdxzoDouTILQRjuojBIImyWY1Lk253d6dsLewv
 EI0FB7YMdUN/Grkky4IkQ5zgk8jl717n8ZSZkngNasMX9HjFO/q9JXFivcP1ryTkNgaxqaFuh
 EIjSzlNFNq9rbkqXkIXXCDOPVNVOZnGepQI7gJeDchbeqXrE+WdOTb0hWGSZHpXKXK09RT+Ok
 /58UrsTrcN7BcUp2AFnaz3YRHmrYqyrkFdVPYMkJS6tXzQnEVO/wiZ6+ukNSQMmT3+3xR2B3/
 Aea3ySWaWtmFbiD84Zzrki8mirg9nlFCkpO0qmBR7AqhjZ4y7I0Aw7xqiaYEV293c5HRp0J9H
 GITOB3iws=

Am 27.12.24 um 11:33 schrieb Patrick Steinhardt:
> On Wed, Dec 25, 2024 at 07:38:35PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> diff --git a/reftable/basics.h b/reftable/basics.h
>> index 259f4c274c..fa5d75868b 100644
>> --- a/reftable/basics.h
>> +++ b/reftable/basics.h
>> @@ -120,22 +120,35 @@ char *reftable_strdup(const char *str);
>>  #define REFTABLE_ALLOC_ARRAY(x, alloc) (x) =3D reftable_malloc(st_mult=
(sizeof(*(x)), (alloc)))
>>  #define REFTABLE_CALLOC_ARRAY(x, alloc) (x) =3D reftable_calloc((alloc=
), sizeof(*(x)))
>>  #define REFTABLE_REALLOC_ARRAY(x, alloc) (x) =3D reftable_realloc((x),=
 st_mult(sizeof(*(x)), (alloc)))

>> +#define REFTABLE_ALLOC_GROW(x, nr, alloc) ( \
>> +	(nr) > (alloc) && ( \
>> +		(x) =3D reftable_alloc_grow((x), (nr), sizeof(*(x)), &(alloc)), \
>> +		(nr) > (alloc) \
>> +	) \
>> +)
>
> Do we even need this macro? I don't really think it serves much of a
> purpose anymore.

It provides the same value as the *ALLOC_ARRAY macros above: automatic
sizeof handling.  Plus it returns whether the allocation succeeded,
avoiding repetition of its arguments in callers.

Ren=C3=A9

