Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C389EC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 20:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A691E61A8F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 20:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355309AbhJAU2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 16:28:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52904 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355302AbhJAU2G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 16:28:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B6583164150;
        Fri,  1 Oct 2021 16:26:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=xnkW642Jd9qrrR8UseFPKmmep
        mCMVoxM7LSUhGTGn0M=; b=hyR+jEc+UzCZPqj5yom5S/sk1+1BFlTzu+Y7EQXCH
        EM0MhYNuY0HvUm6rbjXgZDfsB0W1jI/yw3bWBIkYg3OUilrsuCri82JmSzWpM4R7
        OPxHc//MkyTSiIUrl+WDrHnvEJ5RZNkg97ucOgkIQiDppcskBm/w+IZqZNZXvgEL
        u8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE9E916414F;
        Fri,  1 Oct 2021 16:26:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 229D016414D;
        Fri,  1 Oct 2021 16:26:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/9] test-mergesort: add test subcommand
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
        <522fba5e-1048-3377-45c1-7107b55dc6e1@web.de>
Date:   Fri, 01 Oct 2021 13:26:18 -0700
Message-ID: <xmqq7dew7aqd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D5D6431E-22F5-11EC-B6D9-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> +static void dist_rand(int *arr, int n, int m)
> +{
> +	int i;
> +	for (i =3D 0; i < n; i++)
> +		arr[i] =3D rand() % m;
> +}
> ...
> +static void dist_shuffle(int *arr, int n, int m)
> +{
> +	int i, j, k;
> +	for (i =3D j =3D 0, k =3D 1; i < n; i++)
> +		arr[i] =3D (rand() % m) ? (j +=3D 2) : (k +=3D 2);
> +}

I briefly wondered if we want to seed the rand() in some way to make
the tests reproducible, but we'd need to ship our own rand() if we
wanted to go that route, which would probably be too much.

> +static int test(const struct dist *dist, const struct mode *mode, int =
n, int m)
> +{
> +...
> +	for (i =3D 0, curr =3D list; i < n && curr; i++, curr =3D curr->next)=
 {
> +		if (arr[i] !=3D curr->value)
> +			is_sorted =3D 0;
> +		if (curr->next && curr->value =3D=3D curr->next->value &&
> +		    curr->rank >=3D curr->next->rank)
> +			is_stable =3D 0;
> +	}
> +	if (i < n) {
> +		verdict =3D "too short";
> +	} else if (curr) {
> +		verdict =3D "too long";
> +	} else if (!is_sorted) {
> +		verdict =3D "not sorted";
> +	} else if (!is_stable) {
> +		verdict =3D "unstable";
> +	} else {
> +		verdict =3D "OK";
> +		result =3D 0;
> +	}
> +
> +	printf("%-9s %-16s %8d %8d %8d %8d %8d %s\n",
> +	       dist->name, mode->name, n, m, stats.get_next, stats.set_next,
> +	       stats.compare, verdict);
> +
> +	clear_numbers(list);
> +	free(arr);
> +
> +	return result;
> +}

Nice.

>  int cmd__mergesort(int argc, const char **argv)
>  {
>  	if (argc =3D=3D 2 && !strcmp(argv[1], "sort"))
>  		return sort_stdin();
> -	usage("test-tool mergesort sort");
> +	if (argc > 1 && !strcmp(argv[1], "test"))
> +		return run_tests(argc - 2, argv + 2);
> +	fprintf(stderr, "usage: test-tool mergesort sort\n");
> +	fprintf(stderr, "   or: test-tool mergesort test [<n>...]\n");
> +	return 129;

If you can live with OPT_CMDMODE to implement sort/test subcommands,
you'd get to have parse_options() to do the usage for you, I think.
I am not sure if it is worth it, as t/helper/ is not end-user
facing.

