Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB57C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 21:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbiHEVJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 17:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiHEVJR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 17:09:17 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257C71DA4E
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 14:09:14 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAA51149A9A;
        Fri,  5 Aug 2022 17:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VpnQ4Qzx0HpZ
        jtG4aacSRp1YEiEw3Q3MbD9i7Lda6+4=; b=emW8JD/7BVN9K7zKdmXbfzYZNyqR
        R1ycKwTLk8LraVeFvO2Yr/RSyIzI61adiFh6F0k+I/aQanc6+ztHsOucCx6aCHRp
        dnlriu60flMEkfJOeszNUcHXjIpKlQTJAAbEMRF5dHSVJBruJtb8wVVXXBrppjxm
        bFPV1KcI7N/JW6U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1D5D149A98;
        Fri,  5 Aug 2022 17:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1250C149A97;
        Fri,  5 Aug 2022 17:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Ilya K <me@0upti.me>,
        =?utf-8?B?xJBvw6BuIFRy?= =?utf-8?B?4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] hook API: don't segfault on strbuf_addf() to NULL "out"
References: <0015309-00f1-9b44-023c-001ee3f242e4@0upti.me>
        <patch-1.1-2450e3e65cf-20220805T141402Z-avarab@gmail.com>
Date:   Fri, 05 Aug 2022 14:09:08 -0700
In-Reply-To: <patch-1.1-2450e3e65cf-20220805T141402Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 5 Aug
 2022 16:15:33 +0200")
Message-ID: <xmqqedxuz9cb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D976BBA2-1502-11ED-9066-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a logic error in a082345372e (hook API: fix v2.36.0 regression:
> hooks should be connected to a TTY, 2022-06-07). When it started using
> the "ungroup" API added in fd3aaf53f71 (run-command: add an "ungroup"
> option to run_process_parallel(), 2022-06-07) it should have made the
> same sort of change that fd3aaf53f71 itself made in
> "t/helper/test-run-command.c".
>
> The correct way to emit this "Couldn't start" output with "ungroup"
> would be:
>
> 	fprintf(stderr, _("Couldn't start hook '%s'\n"), hook_path);
>
> But we should instead remove the emitting of this output. As the added
> test shows we already emit output when we can't run the child. The
> "cannot run" output here is emitted by run-command.c's
> child_err_spew().
>
> So the addition of the "Couldn't start hook" output here in
> 96e7225b310 (hook: add 'run' subcommand, 2021-12-22) was always
> redundant. For the pre-commit hook we'll now emit exactly the same
> output as we did before f443246b9f2 (commit: convert
> {pre-commit,prepare-commit-msg} hook to hook.h, 2021-12-22) (and
> likewise for others).
>
> We could at this point add this to the pick_next_hook() callbacks in
> hook.c:
>
> 	assert(!out);
> 	assert(!*pp_task_cb);
>
> And this to notify_start_failure() and notify_hook_finished() (in the
> latter case the parameter is called "pp_task_cp"):
>
> 	assert(!out);
> 	assert(!pp_task_cb);
>
> But let's leave any such instrumentation for some eventual cleanup of
> the "ungroup" API.
>
> Reported-by: Ilya K <me@0upti.me>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> As suspected I needed to bounce this off the CI once to due to the
> OS-specific messaging around failed hooks, it passes now:
> https://github.com/avar/git/actions/runs/2802782493

Emily, other than the added code to deal with the difference in
expected error message between Windows and other platforms, and the
name of the temporary file used by the test to capture the raw error
output, both in the t1800, everything is the same as the one you
gave your Reviewed-by earlier, which I'll transplant while queuing
this round.

=C3=86var, thanks for a quick fix.  This will have to go on top of
ab/hooks-regresion-fix topic and downmerged to 2.36 maintenance
track.

Thanks, all.

>  hook.c          |  7 -------
>  t/t1800-hook.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/hook.c b/hook.c
> index d113ee7faae..a493939a4fc 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -62,9 +62,6 @@ static int pick_next_hook(struct child_process *cp,
>  	strvec_push(&cp->args, hook_path);
>  	strvec_pushv(&cp->args, hook_cb->options->args.v);
> =20
> -	/* Provide context for errors if necessary */
> -	*pp_task_cb =3D (char *)hook_path;
> -
>  	/*
>  	 * This pick_next_hook() will be called again, we're only
>  	 * running one hook, so indicate that no more work will be
> @@ -80,13 +77,9 @@ static int notify_start_failure(struct strbuf *out,
>  				void *pp_task_cp)
>  {
>  	struct hook_cb_data *hook_cb =3D pp_cb;
> -	const char *hook_path =3D pp_task_cp;
> =20
>  	hook_cb->rc |=3D 1;
> =20
> -	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
> -		    hook_path);
> -
>  	return 1;
>  }
> =20
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 210f4298872..64096adac7e 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -151,4 +151,30 @@ test_expect_success TTY 'git commit: stdout and st=
derr are connected to a TTY' '
>  	test_hook_tty commit -m"B.new"
>  '
> =20
> +test_expect_success 'git hook run a hook with a bad shebang' '
> +	test_when_finished "rm -rf bad-hooks" &&
> +	mkdir bad-hooks &&
> +	write_script bad-hooks/test-hook "/bad/path/no/spaces" </dev/null &&
> +
> +	# TODO: We should emit the same (or at least a more similar)
> +	# error on Windows and !Windows. See the OS-specific code in
> +	# start_command()
> +	if test_have_prereq !WINDOWS
> +	then
> +		cat >expect <<-\EOF
> +		fatal: cannot run bad-hooks/test-hook: ...
> +		EOF
> +	else
> +		cat >expect <<-\EOF
> +		error: cannot spawn bad-hooks/test-hook: ...
> +		EOF
> +	fi &&
> +	test_expect_code 1 git \
> +		-c core.hooksPath=3Dbad-hooks \
> +		hook run test-hook >out 2>err &&
> +	test_must_be_empty out &&
> +	sed -e "s/test-hook: .*/test-hook: .../" <err >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
