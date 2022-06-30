Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E200C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbiF3Vz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbiF3Vzz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:55:55 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6995C564E3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:55:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4249130117;
        Thu, 30 Jun 2022 17:55:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MmpUS9H1VGV5
        XLpXxIpWOlJ6hahn5/kEEgI494wvP3o=; b=VXP/iZlwSyhp5njontRoN31N1Px/
        Leu7ELEGNQWlD68Q/wnnEjTKVYtYY28yT1+l1R3+zhihE9II2wfa58YEYHJrC+88
        Bqxjh+t+Gb4dTOrn1Q5pzm9DUfS9VAihvdOlv0Xrd6L5Vz/MRPkm84UQGEwGGmZC
        eVPl7uFdW3Z7Z+s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC330130116;
        Thu, 30 Jun 2022 17:55:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1DF33130115;
        Thu, 30 Jun 2022 17:55:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/11] check-ref-format: fix trivial memory leak
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
        <patch-01.11-f35cf7c6ee9-20220630T175714Z-avarab@gmail.com>
Date:   Thu, 30 Jun 2022 14:55:51 -0700
In-Reply-To: <patch-01.11-f35cf7c6ee9-20220630T175714Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 30 Jun
 2022 20:00:11
        +0200")
Message-ID: <xmqqczepddeg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6957648E-F8BF-11EC-87DA-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
> index bc67d3f0a83..fd0e5f86832 100644
> --- a/builtin/check-ref-format.c
> +++ b/builtin/check-ref-format.c
> @@ -57,6 +57,8 @@ int cmd_check_ref_format(int argc, const char **argv,=
 const char *prefix)
>  	int normalize =3D 0;
>  	int flags =3D 0;
>  	const char *refname;
> +	char *to_free =3D NULL;
> +	int ret =3D 1;
> =20
>  	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
>  		usage(builtin_check_ref_format_usage);
> @@ -81,11 +83,14 @@ int cmd_check_ref_format(int argc, const char **arg=
v, const char *prefix)
> =20
>  	refname =3D argv[i];
>  	if (normalize)
> -		refname =3D collapse_slashes(refname);
> +		refname =3D to_free =3D collapse_slashes(refname);
>  	if (check_refname_format(refname, flags))
> -		return 1;
> +		goto cleanup;
>  	if (normalize)
>  		printf("%s\n", refname);
> =20
> -	return 0;
> +	ret =3D 0;
> +cleanup:
> +	free(to_free);
> +	return ret;
>  }

Nice.

> diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
> index cabc516ae9a..5ed9d7318e0 100755
> --- a/t/t1402-check-ref-format.sh
> +++ b/t/t1402-check-ref-format.sh
> @@ -2,6 +2,7 @@
> =20
>  test_description=3D'Test git check-ref-format'
> =20
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
> =20
>  valid_ref() {
