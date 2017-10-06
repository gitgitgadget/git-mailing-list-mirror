Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 659991FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 01:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbdJFBVN (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 21:21:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62370 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751395AbdJFBVM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 21:21:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCF10985C4;
        Thu,  5 Oct 2017 21:21:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WZbtk1Spz+Uk
        RMyVgVdswb/pbzo=; b=dpN1+dA2wrfZDCd5NYELtgZxTrspXBtPmw3peaL5ZFhI
        p0p23IpvO9WdjZWmCE3Yc9/2O4aBhxNshV3nGAqUdXhabmzjE9YPbXCI/rR1DWhi
        B2ul2FKdn1TNHUxYnX0ZaXmHsbZh3DeSK6VsY5HLWeAAX3RRoLSyPcV5rNoH1fA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RA6i4N
        8t3ykHQizut8wzj5ncNgE52pJfDVOLFqMVWjI5Pn1G54YLuFXXOAc4dUvrQRBqOa
        gEehwiUJk/wnZbryG7r+p15KrtjNaszr3m5/nVQl8P6XfV8ePG/QRhMDgFaJl9KZ
        6LRll+NEf8p5x1H8UvgEItRxmoiA8Kf5Osf5I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B4370985BF;
        Thu,  5 Oct 2017 21:21:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D9FE985BD;
        Thu,  5 Oct 2017 21:21:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 05/12] checkout-index: simplify locking logic
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com>
        <cover.1507228170.git.martin.agren@gmail.com>
        <fe78be885bb4f5a4e021abdf80097cd5c497746f.1507228170.git.martin.agren@gmail.com>
Date:   Fri, 06 Oct 2017 10:21:10 +0900
In-Reply-To: <fe78be885bb4f5a4e021abdf80097cd5c497746f.1507228170.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 5 Oct 2017 22:32:07
 +0200")
Message-ID: <xmqqpoa1ysu1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A3408BDC-AA34-11E7-9881-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> `newfd` starts out negative. If we then take the lock, `newfd` will
> become non-negative. We later check for exactly that property before
> calling `write_locked_index()`. That is, we are simply using `newfd` as
> a boolean to keep track of whether we took the lock or not. (We always
> use `newfd` and `lock_file` together, so they really are mirroring each
> other.)
>
> Drop `newfd` and check with `is_lock_file_locked()` instead. While at
> it, move the `static struct lock_file` into `cmd_checkout_index()` and
> make it non-static. It is only used in this function, and after
> 076aa2cbd (tempfile: auto-allocate tempfiles on heap, 2017-09-05), we
> can have lockfiles on the stack.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
> v2: New patch.

Well reasoned and explained.  Thanks.

>
>  builtin/checkout-index.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index 39c8be05d..b0e78b819 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -129,8 +129,6 @@ static const char * const builtin_checkout_index_us=
age[] =3D {
>  	NULL
>  };
> =20
> -static struct lock_file lock_file;
> -
>  static int option_parse_stage(const struct option *opt,
>  			      const char *arg, int unset)
>  {
> @@ -150,7 +148,7 @@ static int option_parse_stage(const struct option *=
opt,
>  int cmd_checkout_index(int argc, const char **argv, const char *prefix=
)
>  {
>  	int i;
> -	int newfd =3D -1;
> +	struct lock_file lock_file =3D LOCK_INIT;
>  	int all =3D 0;
>  	int read_from_stdin =3D 0;
>  	int prefix_length;
> @@ -206,7 +204,7 @@ int cmd_checkout_index(int argc, const char **argv,=
 const char *prefix)
>  	if (index_opt && !state.base_dir_len && !to_tempfile) {
>  		state.refresh_cache =3D 1;
>  		state.istate =3D &the_index;
> -		newfd =3D hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
> +		hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
>  	}
> =20
>  	/* Check out named files first */
> @@ -251,7 +249,7 @@ int cmd_checkout_index(int argc, const char **argv,=
 const char *prefix)
>  	if (all)
>  		checkout_all(prefix, prefix_length);
> =20
> -	if (0 <=3D newfd &&
> +	if (is_lock_file_locked(&lock_file) &&
>  	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
>  		die("Unable to write new index file");
>  	return 0;
