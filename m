Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70356C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 18:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiBASVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 13:21:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55301 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiBASVS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 13:21:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1270F97FA;
        Tue,  1 Feb 2022 13:21:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O+JGHyHvSBbXWMbCxrDYkkn2b+iFiH8fKVVrl3
        JRfzw=; b=QDo+5/lE7AGVKlvhw8c6VExYlc5Fo87DEhQcoH43ljXqBGu05fbhQ+
        adXQl9qW1vwytWHFqQSrgdd5UO3Fr4r4F07OGX+IsJv4+zBkR5lbIZjd3tpOzee2
        KfAG9/dyvG/HS4GVNiiN7zC1W9atpPZwLT17DUkGwoR1mxvbwq/Tg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99864F97F9;
        Tue,  1 Feb 2022 13:21:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 093ECF97F8;
        Tue,  1 Feb 2022 13:21:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 1/3] repo-settings: fix checking for
 fetch.negotiationAlgorithm=default
References: <pull.1131.v2.git.1643478692337.gitgitgadget@gmail.com>
        <pull.1131.v3.git.1643734828.gitgitgadget@gmail.com>
        <df0ec5ffe98a17e1ec7b572085e733d8748c0379.1643734828.git.gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 10:21:15 -0800
In-Reply-To: <df0ec5ffe98a17e1ec7b572085e733d8748c0379.1643734828.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 01 Feb 2022
        17:00:26 +0000")
Message-ID: <xmqq4k5ifnxg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF0C335E-838B-11EC-8837-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/repo-settings.c b/repo-settings.c
> index 00ca5571a1a..38c10f9977b 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -85,6 +85,8 @@ void prepare_repo_settings(struct repository *r)
>  			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
>  		else if (!strcasecmp(strval, "noop"))
>  			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
> +		else if (!strcasecmp(strval, "default"))
> +			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
>  	}

After this step, this function does:

 * fetch_negotiation_algorithm set to _DEFAULT
 * experimental bit flips it to _SKIPPING
 * config is read and skipping/noop/default overwrites it.

which is better than ignoring "default", but it strikes me as
unnatural.  If it were done like this instead:

 * fetch_negotiation_algorithm is set to _DEFAULT
 * config is read and skipping/noop/default overwrites it.
 * experimental bit flips it to _SKIPPING only when it is still _DEFAULT

this bug wouldn't have happened, I suspect.

More importantly, those who want to say "I want to keep up with the
'possible future default', which is appropriately chosen by Git for
opt-in experimenters" by setting feature.experimental to true, would
be able to do so when the flow is reordered like so.

Setting fetch.negotiationAlgorithm=default would be the way to do
so.

Let's read on and see later steps of this series achieves the same.
Perhaps they may do the same reordering.

Thanks.
