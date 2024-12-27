Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59561E505
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735330584; cv=none; b=qY+tKPJ7zyxDLGwEnTHfXWonhMbfk/ZMwFUO2WlkgmRRoWmyqI3CvJ5/TExTj+933XkUBkP43BumRw619G1kWrpyQa3yaGOSkNVNl+O5qnrWJJ52CllnsE/dvPm1RMrk4yDx5rKreq+AUoQlquj6n0O6aMs7u43rrv21IeDbmRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735330584; c=relaxed/simple;
	bh=dPZLGZvZe9ulMdSfM19aif6SmTtsc0E6XsIJR3Un9Zs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cd+mwdHK5fq+gF4ua8eHjPoxI2UMF5iENz8XrrTF50RIOw2+xMNW+9JgCG0TynGZOCY+MfdaduuhxEytB4HFFAwE5YA+WocLv1Fz5VcpsqE5xRwVwIngYIlMX3cQ+7NAokmL0l4Y+WctHO7pzM1sRt95zg064gfyyFrXKtLf2zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=B31uhj26; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="B31uhj26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735330571; x=1735935371; i=l.s.r@web.de;
	bh=gfUgwyWm7+nJdw2E8Js1Ge0mwhoWK46qt6JBUrOYFco=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B31uhj26JnJK+hWUP6Uu0WGdGbSW23wGOM1fARFmTf5rqhTDv94zLVhPr2Ha/AWe
	 ZHuMJfaTDMLzPvWA8U/Y13plSWYz+2BIw5W6qXI53f6xkw3rs7q/BRtvFA8BjYoV5
	 D2GVcHeR3Jf0PiSapJ1cutcJQrbvVnM10w+bTOvAp/5qJTZI104Tq5JgRo8JUzsZZ
	 IlAqCXe8ZHu4zA9CG/wjnqMDK3GbjEs63CsnvEr3QLci3iNaEdtgyHX7izmOI3v3o
	 T04PJsKh7rxTASzMiEMhnNGOUcSTbLbaDZKqxMSXVUUIu4tw4E8wmalCH1XL7I1GR
	 161dWYeOLYhuhcHgrA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2xrs-1tNxtn0qse-001t3B; Fri, 27
 Dec 2024 21:16:11 +0100
Message-ID: <f53ad79f-14a7-460b-9fbf-ba3d0e75ba35@web.de>
Date: Fri, 27 Dec 2024 21:16:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] reftable: fix allocation count on realloc error
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
 <33bbacc7-1727-4efd-9cbf-3c9abfa94d8c@web.de>
Content-Language: en-US
In-Reply-To: <33bbacc7-1727-4efd-9cbf-3c9abfa94d8c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+SeohGeUcexwjy+i2w/wbcFFhwULHp/OxmBufnaRo7/XH69E3Aw
 L5Wqm/X1yAA1LQTQuaTxIAWcRBMX0kbsA9I14RXjdHl4llg4uXtIpu0WmD0aLYE35ZhLltP
 ZGm3IWqLIR8ZyxGv8ZxGbzDU3/1vbm/dWOe0+WGXsrTAFS/XN/t1qCmGEqrBAp7z0KZHbjA
 IxSqbNyfjp7LNVgp4zgQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jOs4m4k8Nck=;8/4haDAOpeCzQxC187CLPO9IlXF
 QdCZteFQOXPbQ0Ed369UaRhn3W80d2jpRoduN9XSAxrzWdN/KwLVLZpzmVec5JCKGRsXyHrNw
 Fe0OpJlzplee4FVVy+SQIEsY82j0/U0UDGo10hYZwyL8DH35iM7/pZSMkDVBVGgF/TWuArpCK
 /u1f0E9g8bhQAb+jV2hZQXJwGAesvOvYUuxlaR5a3fkIOyzLSoCMqPdZvNk63uVkSRk6FkfNN
 ssDMhsddF0plYLFFVhMT9bPC2CvJerbAKKZwwnhHNET9H1xUOxrCABEH2s/eYWmi7ecw74vV5
 NoJgQeVMQxlH6F/5lg6ftcZZ/EFOOtAwyT19Etlq9CEMI55Yu84bkWMQQR5DBIqnNPH+g/mUY
 dqFtcCz+q3u7qGTCxzet2d/EwwqWC11o1RhPwzhQnKfx8JX+5ynTkVlhZurSxXuth/A63ixkN
 9sID5xXZVgHyPs6vD4OgAL5Dlx8l+krkQ1mUjem+hgWwYhqe1+BoBP2Z6N+pd1LwkkMl22T30
 m2IGrxzthB6qE3Wj+TrDz452eZBEOjG1hbXf+e+c7aJK0M7k6OFIYtZWxUAa2pLmYb0JxSzWX
 joM7KhOwutk9VP5tOCwWdoYHXdNRkK/FznsUJT5CSdOWXa8mr2xZDsTBoWzoBjk/YhgfbQjD1
 eCMHFBDcyKBDCuya2vtXTV/CW2DVdHBft7x47bwAIUoeY25ioV25I7PbvMe95sgHN7z0KxgYW
 VWcg0PQutD8DsiluUFSjBNUwWkpI7kePrDapwSzhAutVRC1NlBzRU68CbNiXqsp244U4+n30j
 JHryM46D6+M6u+BFZGhe7S/In8SCOOjvU0F54o76ub1S/XipnnAbFunTOne1iPytuOxOJ7S8F
 d1JS6er0AsqOxpl3yH9Lkal9+Qs8yh69vq27JiSYr4i3PG7F9wjfFYLvrszg8n1BOk75T++3y
 tmToRlUk3B2VsWrArLEtsEk1S2HS6PRxoOyVZcgz2FUPxsJqggWOpQBWMY/V8Zz2dfxzkTSh0
 Fbjk+HkPYF5tUmty+ttMGIVJQaYRMQaHz2y4wJWvGRwWSx0vYBXJZq07jI2TZIbJrzQ/uT1Cj
 CFFk6BRcE=

Am 25.12.24 um 19:38 schrieb Ren=C3=A9 Scharfe:
> When realloc(3) fails, it returns NULL and keeps the original allocation
> intact.  REFTABLE_ALLOC_GROW overwrites both the original pointer and
> the allocation count variable in that case, simultaneously leaking the
> original allocation and misrepresenting the number of storable items.
>
> parse_names() avoids the leak by keeping the original pointer if
> reallocation fails, but still increase the allocation count in such a
> case as if it succeeded.  That's OK, because the error handling code
> just frees everything and doesn't look at names_cap anymore.
>
> reftable_buf_add() does the same, but here it is a problem as it leaves
> the reftable_buf in a broken state, with ->alloc being roughly twice as
> big as the actually allocated memory, allowing out-of-bounds writes in
> subsequent calls.
>
> Reimplement REFTABLE_ALLOC_GROW to avoid leaks, keep allocation counts
> in sync and still signal failures to callers while avoiding code
> duplication in callers.  Make it an expression that evaluates to 0 if no
> reallocation is needed or it succeeded and 1 on failure while keeping
> the original pointer and allocation counter values.
>
> Adjust REFTABLE_ALLOC_GROW_OR_NULL to the new calling convention for
> REFTABLE_ALLOC_GROW, but keep its support for non-size_t alloc variables
> for now.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  reftable/basics.c | 11 +++--------
>  reftable/basics.h | 39 ++++++++++++++++++++++++++-------------
>  2 files changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/reftable/basics.c b/reftable/basics.c
> index 70b1091d14..cd6b39dbe9 100644
> --- a/reftable/basics.c
> +++ b/reftable/basics.c
> @@ -124,11 +124,8 @@ int reftable_buf_add(struct reftable_buf *buf, cons=
t void *data, size_t len)
>  	size_t newlen =3D buf->len + len;
>
>  	if (newlen + 1 > buf->alloc) {
> -		char *reallocated =3D buf->buf;
> -		REFTABLE_ALLOC_GROW(reallocated, newlen + 1, buf->alloc);
> -		if (!reallocated)
> +		if (REFTABLE_ALLOC_GROW(buf->buf, newlen + 1, buf->alloc))
>  			return REFTABLE_OUT_OF_MEMORY_ERROR;
> -		buf->buf =3D reallocated;
>  	}
>
>  	memcpy(buf->buf + buf->len, data, len);
> @@ -233,11 +230,9 @@ char **parse_names(char *buf, int size)
>  			next =3D end;
>  		}
>  		if (p < next) {
> -			char **names_grown =3D names;
> -			REFTABLE_ALLOC_GROW(names_grown, names_len + 1, names_cap);
> -			if (!names_grown)
> +			if (REFTABLE_ALLOC_GROW(names, names_len + 1,
> +						names_cap))
>  				goto err;
> -			names =3D names_grown;
>
>  			names[names_len] =3D reftable_strdup(p);
>  			if (!names[names_len++])
> diff --git a/reftable/basics.h b/reftable/basics.h
> index 259f4c274c..fa5d75868b 100644
> --- a/reftable/basics.h
> +++ b/reftable/basics.h
> @@ -120,22 +120,35 @@ char *reftable_strdup(const char *str);
>  #define REFTABLE_ALLOC_ARRAY(x, alloc) (x) =3D reftable_malloc(st_mult(=
sizeof(*(x)), (alloc)))
>  #define REFTABLE_CALLOC_ARRAY(x, alloc) (x) =3D reftable_calloc((alloc)=
, sizeof(*(x)))
>  #define REFTABLE_REALLOC_ARRAY(x, alloc) (x) =3D reftable_realloc((x), =
st_mult(sizeof(*(x)), (alloc)))
> -#define REFTABLE_ALLOC_GROW(x, nr, alloc) \
> -	do { \
> -		if ((nr) > alloc) { \
> -			alloc =3D 2 * (alloc) + 1; \
> -			if (alloc < (nr)) \
> -				alloc =3D (nr); \
> -			REFTABLE_REALLOC_ARRAY(x, alloc); \
> -		} \
> -	} while (0)
> +
> +static inline void *reftable_alloc_grow(void *p, size_t nelem, size_t e=
lsize,
> +					size_t *allocp)
> +{
> +	void *new_p;
> +	size_t alloc =3D *allocp * 2 + 1;
> +	if (alloc < nelem)
> +		alloc =3D nelem;
> +	new_p =3D reftable_realloc(p, st_mult(elsize, alloc));
> +	if (!new_p)
> +		return p;
> +	*allocp =3D alloc;
> +	return new_p;
> +}
> +
> +#define REFTABLE_ALLOC_GROW(x, nr, alloc) ( \
> +	(nr) > (alloc) && ( \
> +		(x) =3D reftable_alloc_grow((x), (nr), sizeof(*(x)), &(alloc)), \
> +		(nr) > (alloc) \
> +	) \
> +)
>
>  #define REFTABLE_ALLOC_GROW_OR_NULL(x, nr, alloc) do { \
> -	void *reftable_alloc_grow_or_null_orig_ptr =3D (x); \
> -	REFTABLE_ALLOC_GROW((x), (nr), (alloc)); \
> -	if (!(x)) { \
> -		reftable_free(reftable_alloc_grow_or_null_orig_ptr); \
> +	size_t reftable_alloc_grow_or_null_alloc =3D alloc; \
> +	if (REFTABLE_ALLOC_GROW((x), (nr), reftable_alloc_grow_or_null_alloc))=
 { \
> +		reftable_free(x); \
>  		alloc =3D 0; \

This forgets to set x =3D NULL, which is bad since that's what callers che=
ck. :-O
It was not necessary without this patch, because realloc(3) did it.

> +	} else { \
> +		alloc =3D reftable_alloc_grow_or_null_alloc; \
>  	} \
>  } while (0)
>
> --
> 2.47.1
>

