Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6403DC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 22:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiA0WPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 17:15:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51143 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiA0WPj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 17:15:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F13091807AF;
        Thu, 27 Jan 2022 17:15:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kps32uO+1KDMnsA5cWDBeBHGSanuqcjjc4oG0F
        hRlVg=; b=HdJ8iBosEll9LmzGs3MvU3ItFl2F3K3ZQ0RTLviAUZ39duU02LtQoz
        5B9tTQ/HNQ3jBLrSvkGMISWoplLh0ef/tHMASKdr4E2NVhmkjOdtQ3nbbrHUbPis
        7PN/1ac6+wi1UVgXAYfdwUj5A8dE2er/FHkdz+A4tZvKXGsXX3x74=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D4DEB1807AE;
        Thu, 27 Jan 2022 17:15:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 38F9A1807AD;
        Thu, 27 Jan 2022 17:15:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v7 6/6] branch.c: use 'goto cleanup' in setup_tracking()
 to fix memory leaks
References: <20211220233459.45739-1-chooglen@google.com>
        <20220124204442.39353-1-chooglen@google.com>
        <20220124204442.39353-7-chooglen@google.com>
Date:   Thu, 27 Jan 2022 14:15:35 -0800
In-Reply-To: <20220124204442.39353-7-chooglen@google.com> (Glen Choo's message
        of "Mon, 24 Jan 2022 12:44:42 -0800")
Message-ID: <xmqqfsp8zuyg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6E9AC46-7FBE-11EC-97F0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  branch.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index be33fe09fa..1e9a585633 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -239,7 +239,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  	if (track != BRANCH_TRACK_INHERIT)
>  		for_each_remote(find_tracked_branch, &tracking);
>  	else if (inherit_tracking(&tracking, orig_ref))
> -		return;
> +		goto cleanup;
>  
>  	if (!tracking.matches)
>  		switch (track) {
> @@ -249,7 +249,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  		case BRANCH_TRACK_INHERIT:
>  			break;
>  		default:
> -			return;
> +			goto cleanup;
>  		}
>  
>  	if (tracking.matches > 1)
> @@ -262,6 +262,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  				tracking.remote, tracking.srcs) < 0)
>  		exit(-1);
>  
> +cleanup:
>  	string_list_clear(tracking.srcs, 0);

Makes sense.  There is no other exit paths out of the function after
the tracking_srcs variable gets initialized, so this should be
covering everything.

Two tangential findings:

 * I see exit(-1) in the precontext of the final hunk.  We probably
   would want to fix it, as negative argument to exit(3) is
   misleading (the standard makes it clear that only the least
   significant 8 bits matter, so it is not that bad).

 * At the end, what is cleared is tracking.srcs, but because it is a
   pointer to the real resource we allocated on our stack, it would
   be cleaner to pass &tracking_srcs instead.

Both are not what this patch introduces, and are outside the scope
of this series.

Thanks.
