Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799EDC433ED
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 23:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 407DC61003
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 23:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhCaXNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 19:13:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53929 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhCaXMe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 19:12:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 341FCB9A09;
        Wed, 31 Mar 2021 19:12:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9aMpMy7+lUCZ
        VrleQOIzmFqW158=; b=jANst5OQvkRqgN0Lp80bSFhQGl+jRcA/CxF9vk2eZMlq
        Dcog8k6tWXWThJMVcmdytIuE0VW1omzjeJsbypZSMSbiWEekeGJvujxAa3hq/rJh
        9egsGFRL4p4+LMZynKPitgm8RJM/YmZKkmTCDjAz+8V8klqB7YuK3Nt1uyXxHuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tdObtw
        zQ0aDdiIrUnQYOm8+HOqLSV8C9USlmAC2Uz5FvU1Lo5rWh5wsCweiflixXy/zyvK
        +r48DVsfHNbrILRedizhb7BITmECtJi+ocoEXDa/1YNWFDNB+1xCUNvbimX9lycg
        PfHotBV4NiWH/lMv8+/wZUwRMxf55Y15Cpv5M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BEFCB9A08;
        Wed, 31 Mar 2021 19:12:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF6C0B9A07;
        Wed, 31 Mar 2021 19:12:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 07/18] merge-tree tests: test for the mode comparison
 in same_entry()
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
        <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
        <patch-07.19-3367850559b-20210331T190531Z-avarab@gmail.com>
Date:   Wed, 31 Mar 2021 16:12:33 -0700
In-Reply-To: <patch-07.19-3367850559b-20210331T190531Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 31 Mar
 2021 21:09:35
        +0200")
Message-ID: <xmqq1rbu6hpa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 93242352-9276-11EB-A27A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a test to stress the "a->mode =3D=3D b->mode" comparison in
> merge-tree.c's same_entry().
>
> That code was initially added by Linus in 33deb63a36f (Add
> "merge-tree" helper program. Maybe it's retarded, maybe it's helpful.,
> 2005-04-14), and then again in its current form in
> 492e0759bfe (Handling large files with GIT, 2006-02-14).
>
> However, nothing was testing that we handled this case
> correctly. Simply removing the mode comparison left all tests passing,
> but as seen here it's important that we don't think a path with the
> same content but different modes is the same_entry().

Good thinking.


> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t4300-merge-tree.sh | 44 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
> index e59601e5fe9..f783d784d02 100755
> --- a/t/t4300-merge-tree.sh
> +++ b/t/t4300-merge-tree.sh
> @@ -40,6 +40,25 @@ test_expect_success 'file add A, B (same)' '
>  	test_must_be_empty actual
>  '
> =20
> +test_expect_success 'file add A, B (different mode)' '
> +	git reset --hard initial &&
> +	test_commit "add-a-b-same-diff-mode-A" "ONE" "AAA" &&
> +	git reset --hard initial &&
> +	echo AAA >ONE &&
> +	test_chmod +x ONE &&
> +	test_tick &&
> +	git commit -m"add-a-b-same-diff-mode-B" &&
> +	git tag "add-a-b-same-diff-mode-B" HEAD &&
> +	git merge-tree initial add-a-b-same-diff-mode-A add-a-b-same-diff-mod=
e-B >actual &&
> +	cat >expected <<EXPECTED &&
> +added in both
> +  our    100644 $(git rev-parse add-a-b-same-diff-mode-A:ONE) ONE
> +  their  100755 $(git rev-parse add-a-b-same-diff-mode-B:ONE) ONE
> +EXPECTED

Can we HT-indent the here text with "<<-EOF", unless existing tests
in the same script predate the more recent convention?

    ... goes and looks and realizes it is full of unindented
    expectation ...

Nah, let's keep it that way.

> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'file add A, B (different)' '
>  	git reset --hard initial &&
>  	test_commit "add-a-b-diff-A" "ONE" "AAA" &&
> @@ -61,6 +80,31 @@ EXPECTED
>  	test_cmp expected actual
>  '
> =20
> +test_expect_success 'file add A, B (different and different mode)' '
> +	git reset --hard initial &&
> +	test_commit "add-a-b-diff-diff-mode-A" "ONE" "AAA" &&
> +	git reset --hard initial &&
> +	echo BBB >ONE &&
> +	test_chmod +x ONE &&
> +	test_tick &&
> +	git commit -m"add-a-b-diff-diff-mode-B" &&
> +	git tag "add-a-b-diff-diff-mode-B" &&
> +	git merge-tree initial add-a-b-diff-diff-mode-A add-a-b-diff-diff-mod=
e-B >actual &&
> +	cat >expected <<EXPECTED &&
> +added in both
> +  our    100644 $(git rev-parse add-a-b-diff-diff-mode-A:ONE) ONE
> +  their  100755 $(git rev-parse add-a-b-diff-diff-mode-B:ONE) ONE
> +@@ -1 +1,5 @@
> ++<<<<<<< .our
> + AAA
> ++=3D=3D=3D=3D=3D=3D=3D
> ++BBB
> ++>>>>>>> .their
> +EXPECTED

Nice.  So the mode-only conflict and mode plus contents conflict are
both shown in a sensible way.

Looks good.
Thanks.
