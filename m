Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C71C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 17:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277E66103E
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 17:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhG1RYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 13:24:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58360 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhG1RYS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 13:24:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 73DC413E085;
        Wed, 28 Jul 2021 13:24:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H4FshwsmqW993cud5ql5n6qPvSSm+ZzJtOna9P
        rgb40=; b=NcfKVKHFaizStzBvXykuJjrZsixbcPDQjvEiqqhwcoo/dmpVJZDmO4
        glS5r9e/+NDXtKwLVLxU2WZ4NvAO7+Ii3POVKoazeDN1HT7MvfoLDfNfTIRS5xr3
        a3Uwyc8m4n/o2KQyCM9DWUKp95Z7JbgqbDyvyDDXUq64uAEGiSqL0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6BDEB13E084;
        Wed, 28 Jul 2021 13:24:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ADDF313E083;
        Wed, 28 Jul 2021 13:24:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] [GSOC] cherry-pick: fix bug when used with
 GIT_CHERRY_PICK_HELP
References: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
        <pull.1001.v2.git.1627135281887.gitgitgadget@gmail.com>
        <a8b260be-dae5-e717-d4cb-3ee123f93620@gmail.com>
        <xmqq1r7jebbf.fsf@gitster.g> <xmqqtukfcvzv.fsf@gitster.g>
        <CAOLTT8RRbwss5sJAM-a=LQrZjr0fyOP4C_x8oRGdLFFnpc+M3g@mail.gmail.com>
Date:   Wed, 28 Jul 2021 10:24:12 -0700
In-Reply-To: <CAOLTT8RRbwss5sJAM-a=LQrZjr0fyOP4C_x8oRGdLFFnpc+M3g@mail.gmail.com>
        (ZheNing Hu's message of "Wed, 28 Jul 2021 18:56:02 +0800")
Message-ID: <xmqqr1fi9wsj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0EC7EA8-EFC8-11EB-B98F-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> I think this function "check_need_delete_cherry_pick_head()" should be before
> print_advice(), like this:
>
> +               const char *help_msgs = NULL;
> +
>                 error(command == TODO_REVERT
>                       ? _("could not revert %s... %s")
>                       : _("could not apply %s... %s"),
>                       short_commit_name(commit), msg.subject);
> -               print_advice(r, res == 1, opts);
> +               if (((opts->action == REPLAY_PICK &&
> +                     !opts->rebase_preserve_merges_mode) ||
> +                     (help_msgs = check_need_delete_cherry_pick_head(r))) &&
> +                     res == 1)
> +                       print_advice(opts, help_msgs);

Sorry, but I am not sure what problem this separation is trying to
solve.

The root cause of the issue we have, I think, is because the
decision to delete or keep the cherry-pick-head pseudoref is tied to
what message we give to users in the current code, and the suggested
split of concern is to limit print_advice() to only print the advice
message, and a new helper to decide and remove the pseudoref,
without relying on what is in the GIT_CHERRY_PICK_HELP environment.

It is unclear where you are making the decision to keep or remove
the pseudoref in the above arrangement that lets the new
check_need_delete_cherry_pick_head() decide if the advice is printed
or not.
