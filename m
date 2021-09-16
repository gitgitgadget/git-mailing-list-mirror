Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BC6C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C67661130
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhIPFaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 01:30:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53593 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbhIPFap (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 01:30:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB619154618;
        Thu, 16 Sep 2021 01:29:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3kwn240JAlTO
        Dv3yduRA5wmeGEPwJNamhhsMLe+x+Bg=; b=OvIQ1oQrY4Ctb6fR7/EzEteF3MhI
        9hUi21UyShvmNc7h+XQyaiqvYCSSgRg379nvdUqKm5ZsmCPjIanAi3EZbhflkb8d
        YJX3zvD02QN6luJkI06+TYhh15aVSeYgni8Ie6KH02vw+uzyXvjRa54SQy/kvh7b
        pOelJglt6qethxk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D40F4154617;
        Thu, 16 Sep 2021 01:29:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2B686154616;
        Thu, 16 Sep 2021 01:29:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 2/2] t0000: avoid masking git exit value through pipes
References: <20210916023706.55760-1-carenas@gmail.com>
        <20210916023706.55760-3-carenas@gmail.com>
Date:   Wed, 15 Sep 2021 22:29:20 -0700
In-Reply-To: <20210916023706.55760-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 15 Sep 2021 19:37:06 -0700")
Message-ID: <xmqqlf3xulzj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0C3B3BCE-16AF-11EC-9458-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> 9af0b8dbe2 (t0000-basic: more commit-tree tests., 2006-04-26) adds
> tets for commit-tree that mask the return exit from git as described

"tests" (no need to resend---already locally tweaked).

Thanks.

> in a378fee5b07.
>
> Fix the tests, to avoid pipes by using instead a temporary file.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/t0000-basic.sh | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index cb87768513..545ff5af13 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -1270,26 +1270,31 @@ test_expect_success 'no diff after checkout and=
 git update-index --refresh' '
>  P=3D$(test_oid root)
> =20
>  test_expect_success 'git commit-tree records the correct tree in a com=
mit' '
> -	commit0=3D$(echo NO | git commit-tree $P) &&
> -	tree=3D$(git show --pretty=3Draw $commit0 |
> -		 sed -n -e "s/^tree //p" -e "/^author /q") &&
> +	echo NO | git commit-tree $P >out &&
> +	commit0=3D$(cat out) &&
> +	git show --pretty=3Draw $commit0 >out &&
> +	tree=3D$(cat out | sed -n -e "s/^tree //p" -e "/^author /q") &&
>  	test "z$tree" =3D "z$P"
>  '
> =20
>  test_expect_success 'git commit-tree records the correct parent in a c=
ommit' '
> -	commit1=3D$(echo NO | git commit-tree $P -p $commit0) &&
> -	parent=3D$(git show --pretty=3Draw $commit1 |
> -		sed -n -e "s/^parent //p" -e "/^author /q") &&
> +	echo NO | git commit-tree $P -p $commit0 >out &&
> +	commit1=3D$(cat out) &&
> +	git show --pretty=3Draw $commit1 >out &&
> +	parent=3D$(cat out | sed -n -e "s/^parent //p" -e "/^author /q") &&
>  	test "z$commit0" =3D "z$parent"
>  '
> =20
>  test_expect_success 'git commit-tree omits duplicated parent in a comm=
it' '
> -	commit2=3D$(echo NO | git commit-tree $P -p $commit0 -p $commit0) &&
> -	     parent=3D$(git show --pretty=3Draw $commit2 |
> +	echo NO | git commit-tree $P -p $commit0 -p $commit0 >out &&
> +	commit2=3D$(cat out) &&
> +	git show --pretty=3Draw $commit2 >out &&
> +	parent=3D$(cat out |
>  		sed -n -e "s/^parent //p" -e "/^author /q" |
>  		sort -u) &&
>  	test "z$commit0" =3D "z$parent" &&
> -	numparent=3D$(git show --pretty=3Draw $commit2 |
> +	git show --pretty=3Draw $commit2 >out &&
> +	numparent=3D$(cat out |
>  		sed -n -e "s/^parent //p" -e "/^author /q" |
>  		wc -l) &&
>  	test $numparent =3D 1
