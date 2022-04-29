Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549E4C433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 23:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381685AbiD2XMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 19:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiD2XMi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 19:12:38 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0BB84A35
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 16:09:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F228818B5B2;
        Fri, 29 Apr 2022 19:09:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+4kp2dNk6Cyu
        uhhaMoaIjTAU6u7YT9EEwsox2Uu5Svs=; b=r6JzqC2SlrfhN2NTAw1X8o6wGJMu
        rSZIrLk6VLgazmRwFkTqjfyZZ/sW/cPogfly1dNntXxbMe/ztBDUmS41VypCWzKo
        nObBS1204IsF8muhONIabZscbd69HmGOiSAbw9mpEVeYirJoQm3lLkI29S3RMQtx
        sAwyTnOhnW7Dl90=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF77C18B5B1;
        Fri, 29 Apr 2022 19:09:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3651F18B5AF;
        Fri, 29 Apr 2022 19:09:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 6/6] hook API: fix v2.36.0 regression: hooks should be
 connected to a TTY
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
        <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
        <patch-6.6-de3664f6d2b-20220421T122108Z-avarab@gmail.com>
Date:   Fri, 29 Apr 2022 16:09:10 -0700
In-Reply-To: <patch-6.6-de3664f6d2b-20220421T122108Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Apr
 2022 14:25:31 +0200")
Message-ID: <xmqqfslva3mx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 61CB7590-C811-11EC-8A5D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In the preceding commit we removed the "no_stdin=3D1" and
> "stdout_to_stderr=3D1" assignments. This change brings them back as wit=
h
> ".ungroup=3D1" the run_process_parallel() function doesn't provide them
> for us implicitly.

Wait.

No hunk in this step updates how pick_next_hook() is called
(presumably "with .ungroup=3D1"), and there is no change to the code
that uses the cp structure prepared by pick_next_hook() further, so
why does the change in the previous step need to be reverted in this
step?  Does it mean if we apply patches 1-5 without this step, because
of step 5, the contents of cp structure returned by pick_next_hook()
is broken?  But we clearly saw a claim that these assignments are
redundant and unnecessary.

So I am confused as to what change in this step makes these
assignments necessary again?  There is no removal of assignments to
these two members that we used to have in this patch.  There is no
addition of a new caller that calls pick_next_hook and uses it
differently (i.e. the other existing caller(s) made assignments to
these two members, which allowed 5/6 to remove the assignments, but
if this step adds a different caller that uses the struct without
making these assignments, then we do need to add them back).

Either I am reading a wrong patch, or the steps 5 & 6 confused me
beyond repair, or perhaps a bit of both?

If [5/6] were not there, and [6/6] was added because [5/6] broke it
by forgetting that some caller that already exists after applying
[5/6] did not make assignments to these two members (iow, the
assignment removed by that step were not redundant and [5/6] was
buggy in removing them), then I would understand it, but that does
not seem to be the case...

Puzzled and utterly confused I am.

> @@ -53,7 +53,9 @@ static int pick_next_hook(struct child_process *cp,
>  	if (!hook_path)
>  		return 0;
> =20
> +	cp->no_stdin =3D 1;
>  	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
> +	cp->stdout_to_stderr =3D 1;
>  	cp->trace2_hook_name =3D hook_cb->hook_name;
>  	cp->dir =3D hook_cb->options->dir;
> =20
> @@ -119,16 +121,20 @@ int run_hooks_opt(const char *hook_name, struct r=
un_hooks_opt *options)
>  		.options =3D options,
>  	};
>  	const char *const hook_path =3D find_hook(hook_name);
> -	int jobs =3D 1;
> +	const int jobs =3D 1;
>  	int ret =3D 0;
>  	struct run_process_parallel_opts run_opts =3D {
>  		.tr2_category =3D "hook",
>  		.tr2_label =3D hook_name,
> +		.ungroup =3D jobs =3D=3D 1,
>  	};
> =20
>  	if (!options)
>  		BUG("a struct run_hooks_opt must be provided to run_hooks");
> =20
> +	if (jobs !=3D 1 || !run_opts.ungroup)
> +		BUG("TODO: think about & document order & interleaving of parallel h=
ook output");
> +
>  	if (options->invoked_hook)
>  		*options->invoked_hook =3D 0;
> =20
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 1e4adc3d53e..f22754deccc 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -4,6 +4,7 @@ test_description=3D'git-hook command'
> =20
>  TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-terminal.sh
> =20
>  test_expect_success 'git hook usage' '
>  	test_expect_code 129 git hook &&
> @@ -120,4 +121,40 @@ test_expect_success 'git -c core.hooksPath=3D<PATH=
> hook run' '
>  	test_cmp expect actual
>  '
> =20
> +test_hook_tty() {
> +	local fd=3D"$1" &&
> +
> +	cat >expect &&
> +
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +
> +	test_hook -C repo pre-commit <<-EOF &&
> +	{
> +		test -t 1 && echo >&$fd STDOUT TTY || echo >&$fd STDOUT NO TTY &&
> +		test -t 2 && echo >&$fd STDERR TTY || echo >&$fd STDERR NO TTY
> +	} $fd>actual
> +	EOF
> +
> +	test_commit -C repo A &&
> +	test_commit -C repo B &&
> +	git -C repo reset --soft HEAD^ &&
> +	test_terminal git -C repo commit -m"B.new" &&
> +	test_cmp expect repo/actual
> +}
> +
> +test_expect_success TTY 'git hook run: stdout and stderr are connected=
 to a TTY: STDOUT redirect' '
> +	test_hook_tty 1 <<-\EOF
> +	STDOUT NO TTY
> +	STDERR TTY
> +	EOF
> +'
> +
> +test_expect_success TTY 'git hook run: stdout and stderr are connected=
 to a TTY: STDERR redirect' '
> +	test_hook_tty 2 <<-\EOF
> +	STDOUT TTY
> +	STDERR NO TTY
> +	EOF
> +'
> +
>  test_done
