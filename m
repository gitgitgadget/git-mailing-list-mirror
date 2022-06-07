Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB23C43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 17:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345381AbiFGRIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344603AbiFGRI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 13:08:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828CB5A175
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 10:08:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 86B9C1A7188;
        Tue,  7 Jun 2022 13:08:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9oqShsbGQoqT
        fpd48zVfvY78XaE34YpcqdgLjwySbwY=; b=BkcVHzNnRnecCC2PL+am4UxWUnu8
        RfX9kaw1B63Gy8jlvLheivtB1A2n30CXy5fD67EIYnwZI/sX+JIbC1KF7sHFsEH9
        2EILcPl5o7hy1PnTA17mAS1IArWmu7GYwEX5zScuEVjr9RHo9AZ7AE/Q3n8A7Y2N
        RSWgQn2IxPRwHI4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F1851A7187;
        Tue,  7 Jun 2022 13:08:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F7BA1A7186;
        Tue,  7 Jun 2022 13:08:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 2/2] hook API: fix v2.36.0 regression: hooks should
 be connected to a TTY
References: <cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com>
        <cover-v6-0.2-00000000000-20220606T170356Z-avarab@gmail.com>
        <patch-v6-2.2-503ef241a52-20220606T170356Z-avarab@gmail.com>
Date:   Tue, 07 Jun 2022 10:08:21 -0700
In-Reply-To: <patch-v6-2.2-503ef241a52-20220606T170356Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 7 Jun
 2022 10:48:20
        +0200")
Message-ID: <xmqq7d5sz9iy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6F7BFA34-E684-11EC-8432-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -120,4 +121,34 @@ test_expect_success 'git -c core.hooksPath=3D<PATH=
> hook run' '
>  	test_cmp expect actual
>  '
> =20
> +test_hook_tty() {

Style.

> +	cat >expect <<-\EOF
> +	STDOUT TTY
> +	STDERR TTY
> +	EOF
> +
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +
> +	test_commit -C repo A &&
> +	test_commit -C repo B &&
> +	git -C repo reset --soft HEAD^ &&
> +
> +	test_hook -C repo pre-commit <<-EOF &&
> +	test -t 1 && echo STDOUT TTY >>actual || echo STDOUT NO TTY >>actual =
&&
> +	test -t 2 && echo STDERR TTY >>actual || echo STDERR NO TTY >>actual
> +	EOF

So, when this hook is run, we'd see if STDOUT and STDERR are
connected to a tty in the "actual" file.


> +	test_terminal git "$@" &&

And we run the test and see=20

> +	test_cmp expect repo/actual

what happens.  The test_cmp knows that the git command runs in
"repo" by hardcoding repo/actual, and this helper is full of the
same knowledge, so it would be easier to see what is going on if
you removed "-C repo" from the two callers (below) and instead added
it to where you run "git" under test_terminal (above).

> +}
> +
> +test_expect_success TTY 'git hook run: stdout and stderr are connected=
 to a TTY' '
> +	test_hook_tty -C repo hook run pre-commit
> +'
> +
> +test_expect_success TTY 'git commit: stdout and stderr are connected t=
o a TTY' '
> +	test_hook_tty -C repo commit -m"B.new"
> +'
> +
>  test_done

Other than that, looking good.

Thanks.
