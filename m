Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A10CA0EC0
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349168AbjIKVcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244118AbjIKTEv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 15:04:51 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AC5D8
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 12:04:44 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 444FC2AD89;
        Mon, 11 Sep 2023 15:04:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=t+5h2np88egg
        SYMI7laFccpfvlCEHanJGVzapExDNAU=; b=l9obzvVZJsMzWgN7YWmo98Leqwnm
        ATPI+w2ko/6Noae2p0tgTrS5jbYcl9rAfqYSjHLKr/RbFfSlbKLyR05OlUSV5ffE
        S91elgG6s5nJPFqjeb1mBrmY4+dpSeTDy6YFICEpPb1HacD6YoRSvk3OdZeMdt1I
        nXzy5hpk8r/xJuI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BE062AD88;
        Mon, 11 Sep 2023 15:04:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9D0D22AD85;
        Mon, 11 Sep 2023 15:04:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Martin =?utf-8?Q?Storsj=C3=B6?= <martin@martin.st>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] diff --no-index: fix -R with stdin
In-Reply-To: <22fdfa3b-f90e-afcc-667c-705fb7670245@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 10 Sep 2023 00:12:52 +0200")
References: <d42579a0-f438-9b4c-97e4-58724dbe4a4@martin.st>
        <22fdfa3b-f90e-afcc-667c-705fb7670245@web.de>
Date:   Mon, 11 Sep 2023 12:04:39 -0700
Message-ID: <xmqqil8gv8e0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0F656604-50D6-11EE-9C34-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> When -R is given, queue_diff() swaps the mode and name variables of the
> two files to produce a reverse diff.  1e3f26542a (diff --no-index:
> support reading from named pipes, 2023-07-05) added variables that
> indicate whether files are special, i.e named pipes or - for stdin.
> These new variables were not swapped, though, which broke the handling
> of stdin with with -R.  Swap them like the other metadata variables.
>
> Reported-by: Martin Storsj=C3=B6 <martin@martin.st>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Great bug report, thank you!

Looking good.  I wish all our bugs are this easy and obvious ;-)

>  diff-no-index.c          |  1 +
>  t/t4053-diff-no-index.sh | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 8aead3e332..e7041b89e3 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -232,6 +232,7 @@ static int queue_diff(struct diff_options *o,
>  		if (o->flags.reverse_diff) {
>  			SWAP(mode1, mode2);
>  			SWAP(name1, name2);
> +			SWAP(special1, special2);
>  		}
>
>  		d1 =3D noindex_filespec(name1, mode1, special1);
> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 6781cc9078..5f059f65fc 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -224,6 +224,25 @@ test_expect_success "diff --no-index treats '-' as=
 stdin" '
>  	test_must_be_empty actual
>  '
>
> +test_expect_success "diff --no-index -R treats '-' as stdin" '
> +	cat >expect <<-EOF &&
> +	diff --git b/a/1 a/-
> +	index $(git hash-object --stdin <a/1)..$ZERO_OID 100644
> +	--- b/a/1
> +	+++ a/-
> +	@@ -1 +1 @@
> +	-1
> +	+x
> +	EOF
> +
> +	test_write_lines x | test_expect_code 1 \
> +		git -c core.abbrev=3Dno diff --no-index -R -- - a/1 >actual &&
> +	test_cmp expect actual &&
> +
> +	test_write_lines 1 | git diff --no-index -R -- a/1 - >actual &&
> +	test_must_be_empty actual
> +'
> +
>  test_expect_success 'diff --no-index refuses to diff stdin and a direc=
tory' '
>  	test_must_fail git diff --no-index -- - a </dev/null 2>err &&
>  	grep "fatal: cannot compare stdin to a directory" err
> --
> 2.42.0
