Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28444C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 06:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239797AbhLHGZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 01:25:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54809 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239648AbhLHGZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 01:25:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B001BE5D51;
        Wed,  8 Dec 2021 01:22:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fng8k9yU+t8J
        bDuu3ThCLmhQy8z37MHUOtM7ZQfYqi0=; b=KvjvtFG4y87plKowRCI2JMhGGywu
        KEUrtI3Ty0c/yiEL0rTtyGpDG59HJ/opl7efePOlj0TdytRyYqZq/Q/AIww6K8GO
        3LppJsIuB760jjiJqjJnhWw6hzI90tq4ZmhpGp+1euGoZddmPQSBSgakzOajoM3Y
        v1tnhr2ZaQOVgx4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97EB7E5D4C;
        Wed,  8 Dec 2021 01:22:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E721DE5D4A;
        Wed,  8 Dec 2021 01:22:22 -0500 (EST)
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
Subject: Re: [PATCH v18 3/3] am: support --allow-empty to record specific
 empty patches
References: <pull.1076.v17.git.1638865913.gitgitgadget@gmail.com>
        <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
        <4c3077f938435508850727e05ad514035f09bebb.1638939946.git.gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 22:22:21 -0800
In-Reply-To: <4c3077f938435508850727e05ad514035f09bebb.1638939946.git.gitgitgadget@gmail.com>
        (=?utf-8?B?IlwiXCLlvpDmspvmloc=?= (Aleen)\" via GitGitGadget\""'s message
 of "Wed, 08 Dec
        2021 05:05:46 +0000")
Message-ID: <xmqqmtlb4nvm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 34679814-57EF-11EC-858B-C48D900A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

""=E5=BE=90=E6=B2=9B=E6=96=87 (Aleen)" via GitGitGadget"  <gitgitgadget@g=
mail.com>
writes:

> @@ -1152,6 +1152,12 @@ static void NORETURN die_user_resolve(const stru=
ct am_state *state)
> =20
>  		printf_ln(_("When you have resolved this problem, run \"%s --continu=
e\"."), cmdline);
>  		printf_ln(_("If you prefer to skip this patch, run \"%s --skip\" ins=
tead."), cmdline);
> +
> +		if (advice_enabled(ADVICE_AM_WORK_DIR) &&
> +		    is_empty_or_missing_file(am_path(state, "patch")) &&
> +		    !repo_index_has_changes(the_repository, NULL, NULL))
> +			printf_ln(_("To record the empty patch as an empty commit, run \"%s=
 --allow-empty\"."), cmdline);
> +

OK, so the idea is when we give back control to the user, if the
reason we stopped is because we did not have a usable patch in the
message and we didn't have any change to the index, we can offer
"--allow-empty" as an extra choice.

I guess that makes sense.

> @@ -1900,19 +1906,31 @@ next:
>  /**
>   * Resume the current am session after patch application failure. The =
user did
>   * all the hard work, and we do not have to do any patch application. =
Just
> - * trust and commit what the user has in the index and working tree.
> + * trust and commit what the user has in the index and working tree. I=
f `allow_empty`
> + * is true, commit as an empty commit when index has not changed and l=
acking a patch.
>   */
> -static void am_resolve(struct am_state *state)
> +static void am_resolve(struct am_state *state, int allow_empty)
>  {
> +	int index_changed;
> +
>  	validate_resume_state(state);
> =20
>  	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->m=
sg);
> =20
> -	if (!repo_index_has_changes(the_repository, NULL, NULL)) {
> -		printf_ln(_("No changes - did you forget to use 'git add'?\n"
> -			"If there is nothing left to stage, chances are that something else=
\n"
> -			"already introduced the same changes; you might want to skip this p=
atch."));


> +	index_changed =3D repo_index_has_changes(the_repository, NULL, NULL);
> +	if (allow_empty &&
> +	    !(!index_changed && is_empty_or_missing_file(am_path(state, "patc=
h"))))
>  		die_user_resolve(state);

Why do we need this? =20

Intuitively, because "--allow-XYZ" is "we normally die when the
condition XYZ holds, but with the option, we do not die in such a
case", any new condition that leads to "die" that only kicks in
when "--allow-XYZ" is given smell like a BUG.

The condition reads:

    unless we saw an empty patch (i.e. "patch" file is missing or
    empty, and did not result in any change to the index), it is an
    error to give "--allow-empty" to the command.

That somehow does not make any sense to me.  Whether failed patch
application and manual tweaking resulted in the same tree as HEAD,
or a tree different from HEAD, if the user wants to say "I allow
Git to create an empty commit as necessary, instead of stopping",
shouldn't the user be allowed to?  After all, the option is not
"create nothing but an empty commit, it is an error if there is
something to commit."  It merely allows creation of an empty one.

This series has been trying to add code to punish users who give
"--allow-empty" when the command would have worked the same way
without it at least since the last round, and I am not sure where
that wish to stop users comes from.  Please explain.  I am starting
to think I may be missing something and this extra rigidity may be
helping a user (but again, I do not see how).

> +	if (!index_changed) {
> +		if (allow_empty) {

The index_changed variable being false is "the result is an empty
change", and is-empty-or-missing on "patch" file is "the input is an
empty change".  Ideally we would want to create an empty commit only
when both input and result are empty, but in order to prevent mistakes,
we may want to react to the case where the result is empty but the
input is not empty.

Here is where we can use is-empty-or-missing on "patch" and give a
different message (i.e. "even though the patch file is not empty,
the result of your patch application did not change anything"), if
we wanted to.  Or you could choose to reject such an attempt, which
might be simpler.  I.e.

		if (allow_empty &&
		    is_empty_or_missing_file(am_path(state, "patch"))
			"No changes - recorded an empty commit."
		else
			... the original error for no changes ...


Hmm?
