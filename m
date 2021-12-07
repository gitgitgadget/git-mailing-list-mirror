Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BDEC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbhLGSQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:16:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61229 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhLGSQN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:16:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BECA8154655;
        Tue,  7 Dec 2021 13:12:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=iSeRKdbtSO6WdQMB9TRmjAxcC
        pqOV3OoIWFyKLaCkeA=; b=WnbPipTFN2DXE999oEVICBTExB1ieQqccVvXtFf6c
        +/y6SnNt4pwmp797VHGMgwWGM5ycCNrDFoLu9oIUl813P9wNSbYttc4ycgH1qMsv
        TtRtjVwg312ZMYCAh1Wev5FF9CLJvbHIOiXv/06T6IFUkKj/WjSG+GoRULaM5LJ4
        ng=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6F12154654;
        Tue,  7 Dec 2021 13:12:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B0E4E154652;
        Tue,  7 Dec 2021 13:12:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?IiLlvpDmspvmloc=?= (Aleen) " via GitGitGadget" 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v17 2/3] am: support --empty=<option> to handle empty
 patches
References: <pull.1076.v16.git.1638853295.gitgitgadget@gmail.com>
        <pull.1076.v17.git.1638865913.gitgitgadget@gmail.com>
        <b9e03f2342b3fc52515f063f28b34ad9e1dc338a.1638865913.git.gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 10:12:37 -0800
Message-ID: <xmqq4k7k9td6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 42F92656-5789-11EC-B9AE-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

""=E5=BE=90=E6=B2=9B=E6=96=87 (Aleen)" via GitGitGadget"  <gitgitgadget@g=
mail.com>
writes:


This step look mostly good and well done, except for just a few
things that remain.

> +enum empty_action {
> +	STOP_ON_EMPTY_COMMIT =3D 0,  /* output errors and stop in the middle =
of an am session */
> +	DROP_EMPTY_COMMIT,         /* skip with a notice message, unless "--q=
uiet" has been passed */
> +	KEEP_EMPTY_COMMIT          /* keep recording as empty commits */
> +};

It is friendly to future developers to end the last item in enum
with a comma, unless the current last item MUST stay to be the last
one even when they add new ones.  I.e.

	KEEP_EMPTY_COMMIT,          /* keep recording as empty commits */

>  struct am_state {
>  	/* state directory path */
>  	char *dir;
> @@ -118,6 +124,7 @@ struct am_state {
>  	int message_id;
>  	int scissors; /* enum scissors_type */
>  	int quoted_cr; /* enum quoted_cr_action */
> +	int empty_type; /* enum empty_action */

Mental note.  After this series graduates to 'master', at some point
in the future, we should clean these members up to be of their
respective enum types, not "int".

> @@ -1763,6 +1784,7 @@ static void am_run(struct am_state *state, int re=
sume)
>  	while (state->cur <=3D state->last) {
>  		const char *mail =3D am_path(state, msgnum(state));
>  		int apply_status;
> +		int to_keep;
> =20
>  		reset_ident_date();
> =20
> @@ -1792,8 +1814,27 @@ static void am_run(struct am_state *state, int r=
esume)
>  		if (state->interactive && do_interactive(state))
>  			goto next;
> =20
> +		to_keep =3D 0;
> +		if (is_empty_or_missing_file(am_path(state, "patch"))) {
> +			switch (state->empty_type) {
> +			case DROP_EMPTY_COMMIT:
> +				say(state, stdout, _("Skipping: %.*s"), linelen(state->msg), state=
->msg);
> +				goto next;
> +				break;
> +			case KEEP_EMPTY_COMMIT:
> +				to_keep =3D 1;

This causes the code that produces the "Applying" message jumped
over, so the user will not see anything done for this step. =20

I think we want to mimic the above case arm and do something like

				say(state, stdout, _("Creating an empty commit: %.*s"),
					linelen(state->msg), state->msg);

to avoid being mum about what was done in this step.

> +				break;
> +			case STOP_ON_EMPTY_COMMIT:
> +				printf_ln(_("Patch is empty."));
> +				die_user_resolve(state);
> +				break;
> +			}
> +		}
> +
>  		if (run_applypatch_msg_hook(state))
>  			exit(1);
> +		if (to_keep)
> +			goto commit;
> =20
>  		say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->=
msg);
> =20
> @@ -1827,6 +1868,7 @@ static void am_run(struct am_state *state, int re=
sume)
>  			die_user_resolve(state);
>  		}
> =20
> +commit:
>  		do_commit(state);
> =20
>  next:

> +test_expect_success 'record as an empty commit when meeting e-mail mes=
sage that lacks a patch' '
> +	git am --empty=3Dkeep empty-commit.patch &&
> +	test_path_is_missing .git/rebase-apply &&
> +	git show empty-commit --format=3D"%s" >expected &&
> +	git show HEAD --format=3D"%s" >actual &&

For the test data prepared by the earlier part of this patch, this
does not make a difference, but by using %B instead of %s, I think
you can catch a future bug that only keeps the subject intact while
munging the body of the message.

Other than these, looking quite good.

Thanks.
