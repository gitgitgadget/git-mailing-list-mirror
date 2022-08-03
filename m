Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B90C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 18:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbiHCSaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 14:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiHCSae (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 14:30:34 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D48345989
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 11:30:33 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 067C0135ADE;
        Wed,  3 Aug 2022 14:30:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wU9cG8e2GxyU
        UxrhWnFL8IDWHLVaziLeSMpIER+pmAc=; b=WszpefFJOLW5/jx9G/tNg5T9UwSr
        SgESLZSjWVXLhypiFNDlIIT5PG3dWqxH8+VG+SgRz2TxfC7I8TMga8oOBniohn14
        LXwmLCfn71n9mJPGzro0FTGgVKlZrzcAyL5ZsSI2IcB9bcetj//uDBVokRrNX5lv
        5+7Lzmpp3lh3hqc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9A64135ADD;
        Wed,  3 Aug 2022 14:30:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 483C0135ADC;
        Wed,  3 Aug 2022 14:30:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 6/6] revisions API: don't leak memory on argv
 elements that need free()-ing
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
        <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
        <patch-v3-6.6-5e637f55ff1-20220802T152925Z-avarab@gmail.com>
Date:   Wed, 03 Aug 2022 11:30:30 -0700
In-Reply-To: <patch-v3-6.6-5e637f55ff1-20220802T152925Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 2 Aug
 2022 17:33:16
        +0200")
Message-ID: <xmqq8ro59o3d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5B010DB2-135A-11ED-B993-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -2784,6 +2784,8 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
>  			const char *arg =3D argv[i];
>  			if (strcmp(arg, "--"))
>  				continue;
> +			if (opt && opt->free_removed_argv_elements)
> +				free((char *)argv[i]);

We have "arg", let's free that instead.

>  			argv[i] =3D NULL;
>  			argc =3D i;

>  	unsigned int	assume_dashdash:1,
> -			allow_exclude_promisor_objects:1;
> +			allow_exclude_promisor_objects:1,
> +			free_removed_argv_elements:1;

It would be nicer to pick a name that explains why we want to "free
removed argv[] elements" than "if you remove argv[] elements, then
please free them", because the explanation on the reason why we
request the API to free would help future developers to decide if
they need to free in some situations where they do not "remove" but
do something else in their updates to the revisions API.

If we cannot come up with a better name, at least we should add a
comment that says that the caller owns the **argv strings, and it
asks the API to free those if reference to them are lost in any way.

Thanks.  Overall the series was a pleasant read.

