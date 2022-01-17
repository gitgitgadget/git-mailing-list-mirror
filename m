Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10345C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 17:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbiAQRor (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 12:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbiAQRop (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 12:44:45 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94702C061574
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 09:44:45 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 30so68819240edv.3
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 09:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=evtBZrPKqEocPzFFj6GKWi0ArmtjwdV6suH5BwN7vJY=;
        b=Z9arkmg1qt+0CTABaHYNP55v4YMschg2iNj7CqV8/YQwfAIQ5B4r8/pb2lLT4yvG7V
         cRRQSqOpXoz5CvgfwORplJ51wAoW5+E/vWLqAZaORWYpP0tR5mO4SQmBYDU1Tjbhx0iO
         +LTx8EeTgojQdnJ5uS0cxKayR/hFudrhuGSRW/A3WR5yF6SCK6s+NeM2W59/j6+rfUtT
         /l1OZde7F3jsplbdmAnvJfJs7aP8Xt+7DPrrpEn3rv7JO0d6waIG7ObxiwiL79WwjM9S
         MgFek64X0Mvph+g1ElCcTbb+g49X6bBHRww+KBWSRRAtQlx24DHhaXgXLG4G1w5mKiXh
         Jziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=evtBZrPKqEocPzFFj6GKWi0ArmtjwdV6suH5BwN7vJY=;
        b=tVizJ9noUpNRUQVE0u/DmTFfgKzzhyc9e0hmfvs6FnxDi8A43Pdeip2plIc8WCTLoF
         l7yexGdVw1f5g313bziF8nHfAqgoAcHcPYUi0iObLfFW/+UFJFtnvNnYz3KMhvYR9/n4
         GUuinnDnOrJpNXCSGFk4PNmwBWpb7qgPWLR50a7E6COiARdSUV+87wCzA3XjaJ/tnMkA
         Blb5LYiq6lJJAmdf0TB2iWLYzi/tunxH32I9JOws1TGzqVeUeoamHmdmwrEXAomP1Sgv
         4dEnQyqKP1ZfSWC2HfHqiDtnGEE6JePph8iM+MlIpOjP5ecaW+5hjV7tORZlM8Rhd8cN
         fWWQ==
X-Gm-Message-State: AOAM53321uq+sHxAUdOuy2Uif1kq+Ms+1ehnlisaEWqTBDjstOoTW8Az
        dWC5YV+unzydLqFGKnfbrDw=
X-Google-Smtp-Source: ABdhPJyVtCoxh5QMOIwBglNT4o06Zym7tmgHzdpKPRaJk4riQdDTo7zfvV29Crv6sh6LzHibJZ3XUA==
X-Received: by 2002:a17:907:6089:: with SMTP id ht9mr17680219ejc.552.1642441483964;
        Mon, 17 Jan 2022 09:44:43 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f6sm4684942ejf.69.2022.01.17.09.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 09:44:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n9W3e-001Qkw-Qn;
        Mon, 17 Jan 2022 18:44:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] mergesort: use ranks stack
Date:   Mon, 17 Jan 2022 18:43:08 +0100
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
 <636647b1-f666-f1e2-4127-ee0869b61036@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <636647b1-f666-f1e2-4127-ee0869b61036@web.de>
Message-ID: <220117.864k62qmt1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 01 2021, Ren=C3=A9 Scharfe wrote:


> +/*
> + * Perform an iterative mergesort using an array of sublists.
> + *
> + * n is the number of items.
> + * ranks[i] is undefined if n & 2^i =3D=3D 0, and assumed empty.
> + * ranks[i] contains a sublist of length 2^i otherwise.
> + *
> + * The number of bits in a void pointer limits the number of objects
> + * that can be created, and thus the number of array elements necessary
> + * to be able to sort any valid list.
> + *
> + * Adding an item to this array is like incrementing a binary number;
> + * positional values for set bits correspond to sublist lengths.
> + */
>  void *llist_mergesort(void *list,
>  		      void *(*get_next_fn)(const void *),
>  		      void (*set_next_fn)(void *, void *),
>  		      int (*compare_fn)(const void *, const void *))
>  {
> -	unsigned long l;
> -
> -	if (!list)
> -		return NULL;
> -	for (l =3D 1; ; l *=3D 2) {
> -		void *curr;
> -		struct mergesort_sublist p, q;
> +	void *ranks[bitsizeof(void *)];
> +	size_t n =3D 0;
> +	int i;
>
> -		p.ptr =3D list;
> -		q.ptr =3D get_nth_next(p.ptr, l, get_next_fn);
> -		if (!q.ptr)
> -			break;
> -		p.len =3D q.len =3D l;
> +	while (list) {
> +		void *next =3D get_next_fn(list);
> +		if (next)
> +			set_next_fn(list, NULL);
> +		for (i =3D 0; n & (1 << i); i++)
> +			list =3D llist_merge(ranks[i], list, get_next_fn,
> +					   set_next_fn, compare_fn);
> +		n++;
> +		ranks[i] =3D list;
> +		list =3D next;
> +	}

(Commenting on a commit integrated into v2.34.0)

The aCC compiler on HP/UX notes:

    "mergesort.c", line 67: warning #2549-D: variable "ranks" is used befor=
e its value is set
                        list =3D llist_merge(ranks[i], list, get_next_fn,

It's commenting on the ranks[i] within the for-loop-within-while-loop
above.

>
> -		if (compare_fn(p.ptr, q.ptr) > 0)
> -			list =3D curr =3D pop_item(&q, get_next_fn);
> +	for (i =3D 0; n; i++, n >>=3D 1) {
> +		if (!(n & 1))
> +			continue;
> +		if (list)
> +			list =3D llist_merge(ranks[i], list, get_next_fn,
> +					   set_next_fn, compare_fn);
>  		else
> -			list =3D curr =3D pop_item(&p, get_next_fn);
> -
> -		while (p.ptr) {
> -			while (p.len || q.len) {
> -				void *prev =3D curr;
> -
> -				if (!p.len)
> -					curr =3D pop_item(&q, get_next_fn);
> -				else if (!q.len)
> -					curr =3D pop_item(&p, get_next_fn);
> -				else if (compare_fn(p.ptr, q.ptr) > 0)
> -					curr =3D pop_item(&q, get_next_fn);
> -				else
> -					curr =3D pop_item(&p, get_next_fn);
> -				set_next_fn(prev, curr);
> -			}
> -			p.ptr =3D q.ptr;
> -			p.len =3D l;
> -			q.ptr =3D get_nth_next(p.ptr, l, get_next_fn);
> -			q.len =3D q.ptr ? l : 0;
> -
> -		}
> -		set_next_fn(curr, NULL);
> +			list =3D ranks[i];
>  	}
>  	return list;
>  }

