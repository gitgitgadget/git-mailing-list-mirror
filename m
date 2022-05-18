Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2726C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 21:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiERV4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 17:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiERV4M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 17:56:12 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8691025B06D
        for <git@vger.kernel.org>; Wed, 18 May 2022 14:45:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B598B18D5F3;
        Wed, 18 May 2022 17:45:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mNnPp0qeYPoy
        iR9utWjHxq2YMc7RZKt25cGo27KU2Lg=; b=eEnthxPPZmRCmFXjhKbqUcPl38v4
        P4Fg/qPd7hbZqwMBc2a3jM7C5aUsP1MeuxQdiCyqtak425QgTIG5Oz/KhJuPePce
        kCxKYBnitsOz8qoYGbAdV9gJstKG8IuCGjfbkKeweDYjIXhEBeZV8ge5Twaw1GWF
        rl2ZXTdgYjLlD54=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD6E218D5F2;
        Wed, 18 May 2022 17:45:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D868C18D5F0;
        Wed, 18 May 2022 17:45:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/8] run-command API: use "opts" struct for
 run_processes_parallel{,_tr2}()
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
        <patch-v2-2.8-5f0a6e9925f-20220518T195858Z-avarab@gmail.com>
Date:   Wed, 18 May 2022 14:45:32 -0700
In-Reply-To: <patch-v2-2.8-5f0a6e9925f-20220518T195858Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 18 May
 2022 22:05:18
        +0200")
Message-ID: <xmqqee0qtszn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D87B23B6-D6F3-11EC-A6AA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  	if (max_children !=3D 1 && list->nr !=3D 1) {
>  		struct parallel_fetch_state state =3D { argv.v, list, 0, 0 };
> +		struct run_process_parallel_opts run_opts =3D {
> +			.tr2_category =3D "fetch",
> +			.tr2_label =3D "parallel/fetch",
> +
> +			.jobs =3D max_children,
> +
> +			.get_next_task =3D &fetch_next_remote,
> +			.start_failure =3D &fetch_failed_to_start,
> +			.task_finished =3D &fetch_finished,
> +			.data =3D &state,
> +		};
> =20
>  		strvec_push(&argv, "--end-of-options");
> +		result =3D run_processes_parallel(&run_opts);

;-)

Can't tell if this is going overboard, but it probably is better
than piling more parameter on top of existing ones.

> diff --git a/run-command.h b/run-command.h
> index 5bd0c933e80..b0268ed3db1 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -458,6 +458,32 @@ typedef int (*task_finished_fn)(int result,
>  				void *pp_task_cb);
> =20
>  /**
> + * Options to pass to run_processes_parallel(), { 0 }-initialized
> + * means no options. Fields:
> + *
> + * tr2_category & tr2_label: sets the trace2 category and label for
> + * logging. These must either be unset, or both of them must be set.

I would have written "unset" -> "set to NULL" if I were writing
this, but it should hopefully be obvious from the context, so it is
OK.

> + * jobs: see 'n' in run_processes_parallel() below.
> + *
> + * *_fn & data: see run_processes_parallel() below.
> + */

OK.

> +/**
> + * Options are passed via the "struct run_process_parallel_opts" above=
.
> +
>   * Runs up to n processes at the same time. Whenever a process can be
>   * started, the callback get_next_task_fn is called to obtain the data
>   * required to start another child process.

Beyond the post context follows this text.

    * The children started via this function run in parallel. Their outpu=
t
    * (both stdout and stderr) is routed to stderr in a manner that outpu=
t
    * from different tasks does not interleave.
    *
    * start_failure_fn and task_finished_fn can be NULL to omit any
    * special handling.
    */
   int run_processes_parallel(struct run_process_parallel_opts *opts);

The forward reference of 'n' we saw earlier does have matching 'n'
here, but the 'n' no longer exists, so it probably is a good idea to
rewrite the comment before this function.

    Runs up to opts->jobs processes at the time.  Whenever a process
    can be started, the callback opts->get_next_task_fn is called to
    obtain the data required to start another child process. ...

The forward reference of 'data' we saw earlier does not have any
matching description here (it is a flaw in the original and not the
problem with this patch).  The description of get_next_task_fn that
appears much earlier in this file talks about two "callback
cookies", pp_cb and pp_task_cb, but it is unclear how opts->data
(after this patch) relates to either of these two.  Presumably the
calling convention around the "callback cookie" is the same across
get_next_task_fn, start_failure_fn, and task_finished_fn?  If so,
perhaps this is a good place to describe how opts->data is fed into
them.

> +int run_processes_parallel(struct run_process_parallel_opts *opts);

