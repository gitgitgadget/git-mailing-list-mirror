Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D1DC433FE
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 17:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5E96321C
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 17:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347712AbhITRQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 13:16:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52178 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347935AbhITROy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 13:14:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D60BEDF45;
        Mon, 20 Sep 2021 13:13:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+3IlELYtbF8KcW3yJiFON9bSGpZtN+xMV3UvIF
        JiXGM=; b=lUkjULZ64oy/ets0dL4+l3at9Ot4SkQZpEzGgUv4f3uewfyjRzGd4r
        JDOZymyAeRlfk9536RtTrBRZVn7ZU+j0MR63CqVMZ0H6ZwROTiGq5CaS22XKQBE9
        CBKFzUkm5PLVvTAHZG5SnxtVoTiY/o5APhnMNsw3zkD2S7RFkTiyU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32B1FEDF44;
        Mon, 20 Sep 2021 13:13:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 472BEEDF43;
        Mon, 20 Sep 2021 13:13:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH v2 5/8] submodule: move core cmd_update() logic to C
References: <20210907115932.36068-1-raykar.ath@gmail.com>
        <20210916103241.62376-1-raykar.ath@gmail.com>
        <20210916103241.62376-6-raykar.ath@gmail.com>
Date:   Mon, 20 Sep 2021 10:13:25 -0700
In-Reply-To: <20210916103241.62376-6-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Thu, 16 Sep 2021 16:02:38 +0530")
Message-ID: <xmqqk0jbcgqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11573402-1A36-11EC-838B-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> This patch completes the conversion past the flag parsing of
> `submodule update` by introducing a helper subcommand called
> `submodule--helper update`. The behaviour of `submodule update` should
> remain the same after this patch.
>
> We add more fields to the `struct update_data` that are required by
> `struct submodule_update_clone` to be able to perform a clone, when that
> is needed to be done.
>
> Recursing on a submodule is done by calling a subprocess that launches
> `submodule--helper update`, with a modified `--recursive-prefix` and
> `--prefix` parameter.
>
> We also introduce `update_submodules()` and `update_submodule()` which
> are quite similar to `update_clone_submodules()` and
> `update_clone_submodule()`, and will supersede them.
>
> When the `--init` flag is passed to the subcommand, we do not spawn a
> new subprocess and call `submodule--helper init` on the submodule paths,
> because the Git machinery is not able to pick up the configuration
> changes introduced by that init call[1]. So we instead run the
> `init_submodule_cb()` callback over each submodule directly.
>
> This introduces another problem, because there is no mechanism to pass
> the superproject path prefix (ie, `--super-prefix`) without starting a
> new git process. This field is required for obtaining the display path
> for that is used by the command's output messages. So let's add a field
> into the `init_cb` struct that lets us pass this information to
> `init_submodule()`, which will now also take an explicit 'superprefix'
> argument.
>
> While we are at it, we also remove the fetch_in_submodule() shell
> function since it is no longer used anywhere.
>
> [1] https://lore.kernel.org/git/CAP8UFD0NCQ5w_3GtT_xHr35i7h8BuLX4UcHNY6VHPGREmDVObA@mail.gmail.com/
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> ---
>  builtin/submodule--helper.c | 505 ++++++++++++++++++++++++++++++------
>  git-submodule.sh            | 145 +----------
>  2 files changed, 433 insertions(+), 217 deletions(-)

It seems that this step does too many things in one step and makes
it harder than necessary for readers to understand what is going on.

For example, as far as I can see, the change to optionally allow
passing superprefix to init_submodule() can be made without anything
else in this step (i.e. "we allow superprefix from the parameter to
override what get_super_prefix() would give us, but at this step,
everybody passes NULL and the behaviour is unchanged" would be one
such step), later to be followed by a change that involves passing a
non-NULL value there, and it would become a lot easier to see who
passes a non-NULL super prefix, what value is passed and for what
purpose, with such an organization.

A 650+ lines single patch like this buries the details and forces
the readers to disect them out.  The change that teaches
run_update_command() to instead use capture_command() and gives the
error message to its callers may be another example of what may be
better done as an independent step before tying the whole thing
together.

It is larger than what I comfortably can spend my time on while
tending patches from other topics, so I'll skip reviewing this step
for now.

Thanks.
