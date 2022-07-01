Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260ECC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 20:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiGAUnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 16:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiGAUnP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 16:43:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F62B1DA
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 13:43:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 421F01AE5F9;
        Fri,  1 Jul 2022 16:43:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=enA1Z5Ggcei3
        OBOSfcRN/btH8FEhF8HZLjYmn2ordIw=; b=da1NRMGsB5o/KLFRyFsC8zBlKz6x
        kgp29YxR/y12nkifl3IUq3oaRVa0C64TLMgHy/kUOJC0zkeqRAqxmq0XIil4usJi
        N0WKjfglH1qrwRSgW2LY0RX9SLP3jxeHC5zNcXx45zOMcAnMIlKdbBdvXTr9eaMJ
        vNlnP7A4S+CqCmA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BE021AE5F8;
        Fri,  1 Jul 2022 16:43:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CD3D41AE5F7;
        Fri,  1 Jul 2022 16:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/9] test-tool path-utils: fix a memory leak
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
        <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
        <patch-v2-2.9-050766e6fa2-20220701T103503Z-avarab@gmail.com>
Date:   Fri, 01 Jul 2022 13:43:08 -0700
In-Reply-To: <patch-v2-2.9-050766e6fa2-20220701T103503Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 1 Jul
 2022 12:37:33
        +0200")
Message-ID: <xmqq5ykg8syr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6B089AAE-F97E-11EC-9B9C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a memory leak in "test-tool path-utils", as a result we can mark
> the corresponding test as passing with SANITIZE=3Dleak using
> "TEST_PASSES_SANITIZE_LEAK=3Dtrue".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/helper/test-path-utils.c | 11 +++++++----
>  t/t0060-path-utils.sh      |  1 +
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
> index 229ed416b0e..d20e1b7a18d 100644
> --- a/t/helper/test-path-utils.c
> +++ b/t/helper/test-path-utils.c
> @@ -296,9 +296,8 @@ int cmd__path_utils(int argc, const char **argv)
>  	if (argc =3D=3D 3 && !strcmp(argv[1], "normalize_path_copy")) {
>  		char *buf =3D xmallocz(strlen(argv[2]));
>  		int rv =3D normalize_path_copy(buf, argv[2]);
> -		if (rv)
> -			buf =3D "++failed++";
> -		puts(buf);
> +		puts(rv ? "++failed++" : buf);
> +		free(buf);

This version, without the need for to_free, is certainly very easy
to understand.  Nicely done.

