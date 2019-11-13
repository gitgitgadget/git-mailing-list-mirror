Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 167CA1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 02:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfKMCnx (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 21:43:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61330 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfKMCnw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 21:43:52 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2D0A9900D;
        Tue, 12 Nov 2019 21:43:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DEDSCtyY0xmh
        o1kQe5cWP03JbM0=; b=m18Srq+j3iJCrP9px+o/vBp4D/pOuAWJJtjP8sKLPH4E
        q7cBzzfxnVHei+aZg84NUxbR+AqVQgNfU5VfD5Z37QtMzM2AirzNqfoV7azAWLHR
        m4sE4yKOAgjt45ZHcWPBE0ukEarFoYVMr8KsndOwnppmkQQQtQhOFBPitLLxv84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FKDm6t
        H3etH+Shdmq3/3jY/MSgabtlF8gvYaW2Gu84W5LRuMR2YQUIgBVXbQginSW5XJWY
        /ARkVaWpAEea9b9+MT7hgFd1JEZYu+QPUyEZewnZaqsdqjpVprPd1socvxYat4h1
        tf/wsYt8Z4jX/YzFP0CwWeFm2VYoHsOZxezHo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 999989900C;
        Tue, 12 Nov 2019 21:43:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD2229900B;
        Tue, 12 Nov 2019 21:43:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>
Subject: Re: parse-options: avoid arithmetic on pointer that's potentially NULL
References: <39a0b622-f725-9284-ea50-19cf4078209d@web.de>
Date:   Wed, 13 Nov 2019 11:43:45 +0900
In-Reply-To: <39a0b622-f725-9284-ea50-19cf4078209d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 12 Nov 2019 22:41:34 +0100")
Message-ID: <xmqq5zjocx7i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6ADB7034-05BF-11EA-B75B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> parse_options_dup() counts the number of elements in the given array
> without the end marker, allocates enough memory to hold all of them plu=
s
> an end marker, then copies them and terminates the new array.  The
> counting part is done by advancing a pointer through the array, and the
> original pointer is reconstructed using pointer subtraction before the
> copy operation.
>
> The function is also prepared to handle a NULL pointer passed to it.
> None of its callers do that currently, but this feature was used by
> 46e91b663b ("checkout: split part of it to new command 'restore'",
> 2019-04-25); it seems worth keeping.

... meaning it was used but since then we rewrote the user and there
is no caller that uses it?

Gee, how are you finding such an instance of use?  I am quite
impressed.

> It ends up doing arithmetic on that NULL pointer, though, which is
> undefined in standard C, when it tries to calculate "NULL - 0".  Better
> avoid doing that by remembering the originally given pointer value.
>
> There is another issue, though.  memcpy(3) does not support NULL
> pointers, even for empty arrays.  Use COPY_ARRAY instead, which does
> support such empty arrays.  Its call is also shorter and safer by
> inferring the element type automatically.

Nicely explained.

>  struct option *parse_options_dup(const struct option *o)
>  {
> +	const struct option *orig =3D o;

If I were doing this patch, I'd give the incoming parameter a more
meaningful name and the temporary/local variable that is used to
scan would get/keep the shorter name.  IOW

	struct parse_options_dup(const struct option *original)
	{
		const struct option *o =3D original;
		struct option *copied;
		int nr =3D 0;

		... loop to count ...
		ALLOC_ARRAY(copied, nr + 1);
		COPY_ARRAY(copied, original, nr);
		...

But your patch is a strict improvement from the current code.  Will
queue without any tweak.

Thanks.

>  	struct option *opts;
>  	int nr =3D 0;
>
>  	while (o && o->type !=3D OPTION_END) {
>  		nr++;
>  		o++;
>  	}
>
>  	ALLOC_ARRAY(opts, nr + 1);
> -	memcpy(opts, o - nr, sizeof(*o) * nr);
> +	COPY_ARRAY(opts, orig, nr);
>  	memset(opts + nr, 0, sizeof(*opts));
>  	opts[nr].type =3D OPTION_END;
>  	return opts;
>  }
> --
> 2.24.0
