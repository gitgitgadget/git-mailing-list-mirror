Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50ECC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 19:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B475660FD8
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 19:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhHYTl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 15:41:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58238 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhHYTl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 15:41:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC8A7DDAC8;
        Wed, 25 Aug 2021 15:40:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NdQ0UxTIwAvSoIh1pCBk815MHvmcPr7mwxOQ8a
        rhMxQ=; b=Pp/gJPPrRvH1MxIohyjMjSMtsMVefPrAueKfCzMVm0cgeB5RJmY02M
        LTnneCLRo9oD2funAYGBwtHoBeC7m1ofU70/PjUVUqhSCmKwaHQmT9X2v9REuvaA
        3jtCvY+Ip1UZ/UgRb8JsMild1x1ZibO1p5g7mMtfX2d0wjmDWjbHo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5563DDAC7;
        Wed, 25 Aug 2021 15:40:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53C40DDAC6;
        Wed, 25 Aug 2021 15:40:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2] sequencer: advise if skipping cherry-picked commit
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
        <496da0b17476011b4ef4dde31593afc7572246eb.1628623058.git.steadmon@google.com>
Date:   Wed, 25 Aug 2021 12:40:40 -0700
In-Reply-To: <496da0b17476011b4ef4dde31593afc7572246eb.1628623058.git.steadmon@google.com>
        (Josh Steadmon's message of "Tue, 10 Aug 2021 12:20:38 -0700")
Message-ID: <xmqqfsuxia87.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 554B09F4-05DC-11EC-B68E-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Silently skipping commits when rebasing with --no-reapply-cherry-picks
> (currently the default behavior) can cause user confusion. Issue advice
> in this case so that users are aware of what's happening.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
> Changes in V2:
> * use advise_if_enabled() instead of warning()
> * s/seen/applied/ in the advice text
>
>  Documentation/config/advice.txt |  3 +++
>  advice.c                        |  3 +++
>  advice.h                        |  1 +
>  sequencer.c                     | 22 ++++++++++++++++++++--
>  4 files changed, 27 insertions(+), 2 deletions(-)

[jc: no need for immediate action from Josh]

With <patch-v4-2.4-3869bda3b39-20210823T103719Z-avarab@gmail.com> 
it would make more sense to stop using the "global variable
registered with advice_config[] array" part of the patch, especially
because we only use advise_if_enabled() already in this patch.

> +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
> +			advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
> +					  _("skipped previously applied commit %s"),
> +					  short_commit_name(commit));
> +			skipped_commit = 1;
>  			continue;
> +		}

> @@ -139,6 +141,7 @@ static struct {
>  	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
>  	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath", 1 },
>  	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
> +	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks", 1},
>  };

This needs to be moved to keep the list sorted.

When I queued the topic to migrate to advise-settings from
advice-config, I made some adjustment for this topic (and luckily
there is no other topic in flight that touch advice.c).  Please
sanity check the result when today's integration result is pushed
out, perhaps in 5 hours or so.

Thanks.
