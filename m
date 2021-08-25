Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769B0C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 21:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471826056B
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 21:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhHYVi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 17:38:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62171 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhHYVi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 17:38:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DA5A3142DDF;
        Wed, 25 Aug 2021 17:37:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=E8AbOypMsIg/
        jwXELXhZ2TXE1fmzi1m1Oxtkj0rmu2U=; b=DUf8tkSjZOjsyigi/9FpiuLVsvQS
        4fefhk6nx7OgZaFScXRwrMrozjPPhBa43F6+IhMTURV5JhxkIiIrSdcacXLkmpUs
        mfsoBAJQMBZPadhuLsJDetB0rdirrt12/3K//CbiitYES9yWnpH6ylHCICNJ9Lni
        RfEwRGIjMBqNEVo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D2F4D142DDE;
        Wed, 25 Aug 2021 17:37:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 288FD142DDC;
        Wed, 25 Aug 2021 17:37:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Re: [PATCH RESEND] branch: allow deleting dangling branches with
 --force
References: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
Date:   Wed, 25 Aug 2021 14:37:38 -0700
In-Reply-To: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 25 Aug 2021 22:43:38 +0200")
Message-ID: <xmqqr1ehgq8t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AC3E44A0-05EC-11EC-A664-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> git branch only allows deleting branches that point to valid commits.
> Skip that check if --force is given, as the caller is indicating with
> it that they know what they are doing and accept the consequences.
> This allows deleting dangling branches, which previously had to be
> reset to a valid start-point using --force first.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Original submission:
> http://public-inbox.org/git/52847a99-db7c-9634-b3b1-fd9b1342bc32@web.de=
/

Thanks.

> +test_expect_success 'branch --delete --force removes dangling branch' =
'
> +	test_when_finished "rm -f .git/refs/heads/dangling" &&
> +	echo $ZERO_OID >.git/refs/heads/dangling &&
> +	git branch --delete --force dangling &&
> +	test_path_is_missing .git/refs/heads/dangling
> +'

This goes against the spirit of the series merged at c9780bb2 (Merge
branch 'hn/prep-tests-for-reftable', 2021-07-13).

Can we creat the dangling ref and test the lack of "dangling" ref in
the end in a less transparent way?

An escape hatch is to make this test depend on the REFFILES
prerequisite, just like dc474899 (t4202: mark bogus head hash test
with REFFILES, 2021-05-31) did, which may be more appropriate.

>  test_expect_success 'use --edit-description' '
>  	write_script editor <<-\EOF &&
>  		echo "New contents" >"$1"
> --
> 2.32.0
