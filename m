Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D8FC433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 06:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbiBYGU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 01:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236480AbiBYGUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 01:20:25 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8DC2614B2
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 22:19:53 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6736818702C;
        Fri, 25 Feb 2022 01:19:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W3uR0umhztiyVkWtnKLv0iJ25J6yHm1VI5eJT9
        Sehqo=; b=HPV9UBdUTv77Z21bqUfhAfYDWB/1e1A8CvMgXOjp/IZR5r/YEFJ3uW
        mk2t3/Hk3AK/0P0uk2TLXrW56zRZe9r22iNGFWjtxMa5HdegsHGZoWIxUZh2yusU
        by1mg1/2uYHUarS3U13rE44Ps1HuCtBBi2R84vz2yEUo+RDvI83rY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FF9218702B;
        Fri, 25 Feb 2022 01:19:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7D0C318702A;
        Fri, 25 Feb 2022 01:19:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v2 1/8] fetch-negotiator: add specific noop initializor
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
        <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
        <d146d8aaaafee91de2e7c50b3a598a470319b541.1645719218.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 22:19:48 -0800
In-Reply-To: <d146d8aaaafee91de2e7c50b3a598a470319b541.1645719218.git.gitgitgadget@gmail.com>
        (Robert Coup via GitGitGadget's message of "Thu, 24 Feb 2022 16:13:31
        +0000")
Message-ID: <xmqqbkyvh3i3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF957754-9602-11EC-82FB-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert Coup via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Robert Coup <robert@coup.net.nz>
>
> Add a specific initializor for the noop fetch negotiator. This is

"initializer"?

> introduced to support allowing partial clones to skip commit negotiation
> when fetching to repair or apply a modified filter.
>
> Signed-off-by: Robert Coup <robert@coup.net.nz>
> ---
>  fetch-negotiator.c | 5 +++++
>  fetch-negotiator.h | 8 ++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/fetch-negotiator.c b/fetch-negotiator.c
> index 874797d767b..be383367f55 100644
> --- a/fetch-negotiator.c
> +++ b/fetch-negotiator.c
> @@ -23,3 +23,8 @@ void fetch_negotiator_init(struct repository *r,
>  		return;
>  	}
>  }
> +
> +void fetch_negotiator_init_noop(struct fetch_negotiator *negotiator)
> +{
> +	noop_negotiator_init(negotiator);
> +}

Puzzling.  What makes this better than allowing noop-negotiator-init
to be called directly?

> diff --git a/fetch-negotiator.h b/fetch-negotiator.h
> index ea78868504b..e348905a1f0 100644
> --- a/fetch-negotiator.h
> +++ b/fetch-negotiator.h
> @@ -53,7 +53,15 @@ struct fetch_negotiator {
>  	void *data;
>  };
>  
> +/*
> + * Initialize a negotiator based on the repository settings.
> + */
>  void fetch_negotiator_init(struct repository *r,
>  			   struct fetch_negotiator *negotiator);
>  
> +/*
> + * Initialize a noop negotiator.
> + */
> +void fetch_negotiator_init_noop(struct fetch_negotiator *negotiator);
> +
>  #endif
