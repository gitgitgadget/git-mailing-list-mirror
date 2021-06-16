Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493BBC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 03:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A07161246
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 03:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFPDIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 23:08:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64360 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFPDIV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 23:08:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB350D06AF;
        Tue, 15 Jun 2021 23:06:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=l5kUcXLYXkqD
        rRGrYgRndzKagykPvw/lEixjmUZ4Hsk=; b=d5JhaWEjWyqHtYAjS1uUaI/qSMlr
        38Qdz6W5VXouTkzjghy/xLt8jhKAz3tiO3VhSm4BiEnUyr+82UOhhg0eD1sEGIyb
        kVupzhuwpfXbLPtChAXZ6n2ZHPFOwHLdWgsQBt15V1Hi9rf661gwpH+TVunRogeG
        xurkD1rzwc3Ec1E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3621D06AE;
        Tue, 15 Jun 2021 23:06:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 408C4D06AD;
        Tue, 15 Jun 2021 23:06:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/5] t0041: use test_line_count_cmd to check
 std{out,err}
References: <20210615172038.28917-1-congdanhqx@gmail.com>
        <20210615172038.28917-4-congdanhqx@gmail.com>
Date:   Wed, 16 Jun 2021 12:06:14 +0900
In-Reply-To: <20210615172038.28917-4-congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Wed, 16 Jun 2021 00:20:36 +0700")
Message-ID: <xmqqlf7ase3d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D007D740-CE4F-11EB-A938-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>  test_expect_success 'tag --contains <existent_tag>' '
> -	git tag --contains "v1.0" >actual 2>actual.err &&
> -	grep "v1.0" actual &&
> -	test_line_count =3D 0 actual.err
> +	test_line_count_cmd --err =3D 0 git tag --contains v1.0 >actual &&
> +	grep "v1.0" actual

Sorry, but I am not impressed if this is a typical/prime example of
how the new helper helps in writing our tests.

Notice that so many tests that you touched only care about 0 lines?

Instead of this new helper, I think it would be a more useful
improvement if we check the emptyness in a more direct way, i.e.

>  test_expect_success 'tag --contains <existent_tag>' '
> 	git tag --contains "v1.0" >actual 2>actual.err &&
> 	grep "v1.0" actual &&
> -	test_line_count =3D 0 actual.err
> +	test_must_be_empty actual.err

I think this helper may be misnamed and test_file_is_empty would sit
better with test_dir_is_empty and test_file_not_empty that already
exist, though.

By the way, my opinion would be quite different if example like this
one ...

>  test_expect_success 'tag --no-contains <existent_tag>' '
> -	git tag --no-contains "v1.0" >actual 2>actual.err  &&
> -	test_line_count =3D 0 actual &&
> -	test_line_count =3D 0 actual.err
> +	test_line_count_cmd --out =3D 0 --err =3D 0 git tag --no-contains v1.=
0
>  '

... were the majority, but I do not think that is the case.  Most
tests that employ the new test_line_count_cmd in this patch still
create either actual or actual.err in the working tree anyway, so I
do not see much point in adding this new helper---it is hard to
explain to new test writers when to use it.
