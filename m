Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29751C2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 18:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC90206F8
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 18:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rg3PDTRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgDFSIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:08:18 -0400
Received: from mout.web.de ([212.227.17.11]:54205 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgDFSIR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 14:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586196492;
        bh=Y4nbwy1+TMsHwPiTWKDW8Rq4cj7K/NtNNPqJ3umwsrg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=rg3PDTROwb0DDWeqLuN1pesuUFV2pWpqB2PdZZraDYex/KYvX6lIV65iNmmpaMIcZ
         w6Xm7eHEP3her1gU7DDHc/nivCInTdxb6E39KJvkdpQZJhk7KYgUcxUkBWb8NCb5on
         6DyZ+vQhVEv1zDbMiT56AA4FEwipX7eiAmnVWQK4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MhleR-1jgbpH1npz-00MrZD; Mon, 06
 Apr 2020 20:08:12 +0200
Subject: Re: [PATCH] fast-import: replace custom hash with hashmap.c
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20200403121508.GA638328@coredump.intra.peff.net>
 <6926f6fe-2e5c-bcbc-fd0a-5b9a70eed06c@web.de>
 <20200405185951.GA1309762@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <020726d4-5a5c-e751-2824-d05004823326@web.de>
Date:   Mon, 6 Apr 2020 20:07:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200405185951.GA1309762@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AaWq9xpQGYcQrCb57OUMrSq9f1nVPbZO1UU7+ScUbw4ka8jht+B
 6wo+3Gbx7bWRBVu4Q1DJczjw+xqaCC79v6uUL6O/gLcUmNcZDtyE1BWPLkeUECCHYi7iVQq
 T4t+bHATSElREHXCgeSoxG3AZtt4MxbwauZoQgHPR6fOmI7Vi5sGi0WRFJ0wRIFPUT9wExN
 R6OeRKI7yiBAnqqyn/Qvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vIJIIGnFv5Q=:icT750SRP1XOCAc2hXhkXT
 us3WjkCgdaC6zLQOaHOG7KQatr16000uVtrWqnKpIeCc8EOscQlOC/xzvIOJ4om6pWF6fjbhr
 CdHzFI3RMuJDgd9CFP7X9hVeMiOcoThsmWRaTYjX9SVDarx8POuKXwDzYvhsWQecGKEP00gQc
 3hSeOQqCGYzZXFn1TJmr2HI9+knhdi1sJzTXaoHK8iaqnVc2/3JzT6zVkhzRSZZGlEXe3J2jS
 99/xNEqreCVV8Da62d7byXKvBvBP9g4X6zYAAiPy2qXg+jTJVU0hNpQcoWyaJh5BY4SrxApJx
 /092PY8//+NwLHJvldyaH5C8FrAL8bK87/J4dKykM7VH/DZQjYTqklvpWIF96RQbWR/K3E3fV
 GkO194SXQlg9gHO4lVViz4XJ4Dqm6yM2tMohBIiwc3H9ZNOsnaPG9c/qOxKtFaPY8GJIxmA6h
 UU0VFl8VjinjQuArdUlHyvVGkmhGvHJkd3bQ5g2qa9AufCG7UGkxlm2brJdwg5zS344Uilt77
 1ZrleNZwYwGvIw67qV5NVyuRcrujQcFGkEWmUvc70Nd5TMrOTO6DqJJm5W5LY7WwmNSl75KeH
 3W4RpS4ixXP+7sGlgXw862JgO+aPc3ixhtfmG/GAMsK/Rl3mCxyDqDpYaBVVxqpE14i/UtJPg
 TmtK3HG0hSVl4lOmQoUlgOxN/16sAzUoGEENHWKVGAMgzfDGm9tmM7gnsB2FtVZ1xEZi45wx3
 TG8XYnUavxEEAmQ2bOpojxPsJGndxr+SXXPHpQmO1ne/BrUYZ2qb7yl1sLlZ5LfHyGTb67pvI
 ivfiCmwNgLrrM6q1XHHiu0c26Zq/RaavfRWFlXAIcvLX+R7Y2bP+nwDhy9nastEVFOtY5xYsJ
 WrS2dbj/Lf76+zumbEY1tyufX6s0evxTdHRZLHxnVmXfYQyrfiNTKhhViExNkF2ATvsLWPSsr
 T4+1jtqRrXicLbfbjxrSOTJkfphzKX4NAyo4omnWR8a2W9XTH0aK3Z3dgauQLp8+thqmyKmDV
 7QBHH6SC3/gAhwNMiuS9r/Igl6z8ig1Cj3VyDRRjNRvEQ+hkTJT9sq8zljGl1QADKkymy9W82
 bmQGuq8yuccaJxtAzLX6ZjsqBhajHd69aQB2oa2ps62MXJA5SVFwFOjN4T+kpjHlI0eK1bhqQ
 qcFIiPsbqFiJpvHMec1jS+HEClMgjIy76FjXwx0dmI5ULJ5UteYqyw/HC29YVIPyUctPY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.04.20 um 20:59 schrieb Jeff King:
> On Fri, Apr 03, 2020 at 08:53:30PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>> Here are the results for linux.git:
>>>
>>>   Test                        HEAD^                 HEAD
>>>   --------------------------------------------------------------------=
--------
>>>   9300.1: export (no-blobs)   67.64(66.96+0.67)     67.81(67.06+0.75) =
+0.3%
>>>   9300.2: import (no-blobs)   284.04(283.34+0.69)   198.09(196.01+0.92=
) -30.3%
>>
>> My numbers look a bit different for this, not sure why:
>>
>> Test                        origin/master         HEAD
>> -----------------------------------------------------------------------=
----
>> 9300.1: export (no-blobs)   69.36(66.44+1.56)     67.89(66.07+1.56) -2.=
1%
>> 9300.2: import (no-blobs)   295.10(293.83+1.19)   283.83(282.91+0.91) -=
3.8%
>>
>> They are still in favor of the patch, just not as strongly as yours.
>
> Interesting. I re-ran mine just to double check, and got:
>
> Test                        HEAD^                 HEAD
> ------------------------------------------------------------------------=
----
> 9300.1: export (no-blobs)   63.11(62.31+0.79)     62.00(61.21+0.79) -1.8=
%
> 9300.2: import (no-blobs)   261.79(261.06+0.72)   188.55(187.87+0.66) -2=
8.0%
>
> (for some reason my whole machine is faster today; maybe I had closed
> slack).
>
> This is on a fresh-ish clone of linux.git.

A second run today reported:

Test                        origin/master         HEAD
=2D-----------------------------------------------------------------------=
---
9300.1: export (no-blobs)   61.58(59.93+1.40)     60.63(59.35+1.22) -1.5%
9300.2: import (no-blobs)   239.64(239.00+0.63)   246.02(245.18+0.82) +2.7=
%

git describe says v5.4-3890-g86fd3e9df543 in that repo.

Dunno.  My PC has thermal issues and stressing it for half an hour straigh=
t
may cause it to throttle?

With Git's own repo I just got this:

Test                        origin/master       HEAD
=2D----------------------------------------------------------------------
9300.1: export (no-blobs)   2.58(2.45+0.05)     2.81(2.75+0.05) +8.9%
9300.2: import (no-blobs)   10.41(10.37+0.03)   10.75(10.72+0.02) +3.3%

>
>>> +	e1 =3D container_of(eptr, const struct object_entry, ent);
>>> +	if (oid)
>>> +		return oidcmp(&e1->idx.oid, oid);
>>> +
>>> +	e2 =3D container_of(entry_or_key, const struct object_entry, ent);
>>> +	return oidcmp(&e1->idx.oid, &e2->idx.oid);
>>
>> Other hashmap users express this more tersely, similar to this:
>>
>> 	const struct object_entry *e1, *e2;
>>
>> 	e1 =3D container_of(eptr, const struct object_entry, ent);
>> 	e2 =3D container_of(entry_or_key, const struct object_entry, ent);
>> 	return oidcmp(&e1->idx.oid, keydata ? keydata : &e2->idx.oid);
>
> I wasn't sure if we'd ever see entry_or_key as NULL, in which case the
> second container_of() would be undefined behavior. There's a
> container_of_or_null() for this, but it seemed simpler to just avoid the
> deref entirely if we didn't need it.

OK.  The other users might have the same issue then, though.

> I think in practice we won't ever pass NULL, though. Even a
> hashmap_get() needs to pass in a hashmap_entry with the hash value in
> it. Though I think that's technically _also_ undefined behavior. If I
> have a struct where the entry is not at the beginning, like:
>
>   struct foo {
>     const char *bar;
>     struct hashmap_entry ent;
>   };
>
> then:
>
>   e2 =3D container_of(ptr_to_entry, struct foo, ent);
>
> is going to form a pointer at 8 bytes before ptr_to_entry. If it really
> is a "struct hashmap_entry" on the stack, then it's pointing at garbage.
>
> We don't dereference it, so it's likely fine in practice, but even
> computing such a pointer does violate the standard.

Really?  If ptr_to_entry was NULL then any pointer arithmetic on it would
be bad.  If it points to a bare hashmap_entry and we lied to container_of
by telling it that it's embedded in some other struct then that would be
bad as well.  But if there actually is a surrounding struct of the
specified type then the resulting pointer must surely be valid, no matter
if the object it points to was initialized?  Do you have the relevant
chapter and verse handy?

>
>>> +	hashmap_entry_init(&lookup_entry, oidhash(oid));
>>> +	hashent =3D hashmap_get(&object_table, &lookup_entry, oid);
>>> +	if (hashent)
>>> +		return container_of(hashent, struct object_entry, ent);
>>
>> That duplicates find_object()...
>
> Yes. This is how most hashmap users do it. It's only a few lines, and
> sharing without extra work would mean passing the hash value around
> (otherwise we'd have to recompute it again), which is awkward.

I find touching hashmap_entry members directly more awkward.

Compilers likely inline find_object() here, so the text size and
performance should be about the same.

> Though in our case oidhash() is cheap enough that perhaps it's not worth
> worrying about?

Probably, but I didn't measure.  My system is quite noisy..

>
>>>  	e =3D new_object(oid);
>>> -	e->next =3D object_table[h];
>>>  	e->idx.offset =3D 0;
>>> -	object_table[h] =3D e;
>>> +	e->ent.hash =3D lookup_entry.hash;
>>
>> ... except for this part.  Would it make sense to replace this line wit=
h
>> a call to hashmap_entry_init()?  Seems cleaner to me.  It would look
>> like this:
>> 	struct object_entry *e =3D find_object(oid);
>>
>> 	if (e)
>> 		return e;
>>
>> 	e =3D new_object(oid);
>> 	e->idx.offset =3D 0;
>> 	hashmap_entry_init(&e->ent, oidhash(oid));
>> 	hashmap_add(&object_table, &e->ent);
>> 	return e;
>
> Right, that calls oidhash() again. If we're OK with that, I agree it's a
> bit shorter and not any more awkward. I do worry slightly that it sets a
> bad example, though (you wouldn't want tusing only the API to o repeat a=
 strhash(), for
> example).

Stuffing the oidhash() result into a variable and using it twice with
hashmap_entry_init() would work as well.  This would make the reason for
the duplicate find_object() code obvious, while keeping struct
hashmap_entry opaque.

Ren=C3=A9
