Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0303C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjHJVWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHJVWX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:22:23 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA02F2112
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:22:22 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97F911E93D;
        Thu, 10 Aug 2023 17:22:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RcXo/yYzHI/rqMLspBI2kgSBJvJo4xPcECDtpu
        pKtb0=; b=DGbm9uKG3ahGiVBv0p5iD3czKbEdq/bdhMfZ0vQyoZz/nXG1GLLk5P
        HEAZTE35gFBkH2siAu+G9BjzH6zrQ6iWjldN3qMoQfnQhc3GHMTQ9Gx3wzNzJuZi
        +CP8N24p0Ig8j+bA8p7BvA0S5AJay3Rzfi7F0L9bxJecJeiHzMSXE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FE961E93C;
        Thu, 10 Aug 2023 17:22:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C57C1E93B;
        Thu, 10 Aug 2023 17:22:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        lenaic@lhuard.fr, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 7/8] maintenance: fix systemd schedule overlaps
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
        <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
        <86c4255d63d7f38b7a4811e5667404bce04f77f8.1691699987.git.gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 14:22:16 -0700
In-Reply-To: <86c4255d63d7f38b7a4811e5667404bce04f77f8.1691699987.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 10 Aug 2023
        20:39:46 +0000")
Message-ID: <xmqqpm3ur3sn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBF9714E-37C3-11EE-B9CA-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The 'git maintenance run' command prevents concurrent runs in the same
> repository using a 'maintenance.lock' file. However, when using systemd
> the hourly maintenance runs the same time as the daily and weekly runs.
> (Similarly, daily maintenance runs at the same time as weekly
> maintenance.) These competing commands result in some maintenance not
> actually being run.
>
> This overlap was something we could not fix until we made the recent
> change to not use the builting 'hourly', 'daily', and 'weekly' schedules
> in systemd. We can adjust the schedules such that:
>
>  1. Hourly runs avoid the 0th hour.
>  2. Daily runs avoid Monday.

Simple and stupid is good.  When I read the problem description, I
wondered if the hour in which daily jobs are run will also be
dispersed (so that the load of the server that helps daily tasks at
the clients will not be concentrated in a single hour out of 24
hours of a day), but hopefully the load is still spread within that
60 minutes evenly, which probably is good enough.



>
> This will keep maintenance runs from colliding when using systemd.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/gc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index e52129e485c..6f8df366fbe 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -2350,11 +2350,11 @@ static int systemd_timer_write_timer_file(enum schedule_priority schedule,
>  
>  	switch (schedule) {
>  	case SCHEDULE_HOURLY:
> -		schedule_pattern = xstrfmt("*-*-* *:%02d:00", minute);
> +		schedule_pattern = xstrfmt("*-*-* 1..23:%02d:00", minute);
>  		break;
>  
>  	case SCHEDULE_DAILY:
> -		schedule_pattern = xstrfmt("*-*-* 0:%02d:00", minute);
> +		schedule_pattern = xstrfmt("Tue..Sun *-*-* 0:%02d:00", minute);
>  		break;
>  
>  	case SCHEDULE_WEEKLY:
