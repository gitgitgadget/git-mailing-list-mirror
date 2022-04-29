Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8189BC433F5
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 22:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381631AbiD2W6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 18:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbiD2W6B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 18:58:01 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FEDAD136
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 15:54:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4728A18BC3E;
        Fri, 29 Apr 2022 18:54:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uBWDsrfKDEdI
        O/MiL5mVjAkChLKfWQH5V80/VB9yFXw=; b=VecNvzkRBLiqEawDO9eYBG9BUkwJ
        uxdeD79pyRnujo58Lhrcz/BU4YjHTdEHWj7I+Ukf/Z6umE/ouI226Wyh4OW/4cXN
        06FHcutIEMSPLIbITj9dQBL2xUBBde46uqjW6qZbWwkBI1Rvnzy9N7VgQHzRCNE8
        75g9+GeZS49XAUw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F8C618BC3D;
        Fri, 29 Apr 2022 18:54:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 885C818BC3C;
        Fri, 29 Apr 2022 18:54:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 5/6] hook API: don't redundantly re-set "no_stdin" and
 "stdout_to_stderr"
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
        <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
        <patch-5.6-98c26c9917b-20220421T122108Z-avarab@gmail.com>
Date:   Fri, 29 Apr 2022 15:54:35 -0700
In-Reply-To: <patch-5.6-98c26c9917b-20220421T122108Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Apr
 2022 14:25:30 +0200")
Message-ID: <xmqqlevna4b8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 57DBFA52-C80F-11EC-AAE9-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

[jc: I stopped reviewing at 4/6 in the last batch, thought that it
was enough for a reroll and shifted my attention to address other
regressions. Let me come back to this topic to finish commenting
before a reroll comes.]

> Amend code added in 96e7225b310 (hook: add 'run' subcommand,
> 2021-12-22) top stop setting these two flags. We use the

"top stop"?  -ECANNOTPARSE.

> run_process_parallel() API added in c553c72eed6 (run-command: add an
> asynchronous parallel child processor, 2015-12-15), which always sets
> these in pp_start_one() (in addition to setting .err =3D -1).
>
> Note that an assert() to check that these values are already what
> we're setting them to here would fail. That's because in
> pp_start_one() we'll set these after calling this "get_next_task"
> callback (which we call pick_next_hook()). But the only case where we
> weren't setting these just after returning from this function was if
> we took the "return 0" path here, in which case we wouldn't have set
> these.
>
> So while this code wasn't wrong, it was entirely redundant. The
> run_process_parallel() also can't work with a generic "struct
> child_process", it needs one that's behaving in a way that it expects
> when it comes to stderr/stdout. So we shouldn't be changing these
> values, or in this case keeping around code that gives the impression
> that doing in the general case is OK.

OK.  As long as we set these two fields correctly (i.e. the hooks do
not read from the standard input, and stdout_to_stderr is in effect
(i.e. dup2(2, 1) is done), by the time we pass this into run_command()
API, this step would be a benign no-op.  Good.

Not that it is something I would expect to see in a rather urgent
post-release regression fix, though.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  hook.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/hook.c b/hook.c
> index eadb2d58a7b..68ee4030551 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -53,9 +53,7 @@ static int pick_next_hook(struct child_process *cp,
>  	if (!hook_path)
>  		return 0;
> =20
> -	cp->no_stdin =3D 1;
>  	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
> -	cp->stdout_to_stderr =3D 1;
>  	cp->trace2_hook_name =3D hook_cb->hook_name;
>  	cp->dir =3D hook_cb->options->dir;
