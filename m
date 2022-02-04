Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA80DC433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 16:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376406AbiBDQPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 11:15:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64977 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiBDQPW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 11:15:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 32E981724CF;
        Fri,  4 Feb 2022 11:15:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NTy9Y7/em1paucrDyVs29CvA97ciDRStZ6GjqB
        Kpp3w=; b=c2fqZv0zoNm0dX/FBQzPcSdMB1GpVHv93e8QL2UqXcTGafq42aJVCE
        oi+DMS+x78yy3hbpGBQ7wnOVQzfoU4naWWwCn6MiGGU2i6k65RweurV7IAagLCVM
        iGf5tFiLX8FMlhLdBIkCq5JOgJ/nO4XTOcSHJ9u8SyoA48AsgOyz4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A54E1724CE;
        Fri,  4 Feb 2022 11:15:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 98DA91724CB;
        Fri,  4 Feb 2022 11:15:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v8 5/6] branch: add --recurse-submodules option for
 branch creation
References: <20220124204442.39353-1-chooglen@google.com>
        <20220129000446.99261-1-chooglen@google.com>
        <20220129000446.99261-6-chooglen@google.com>
        <kl6lwnibzbb6.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 04 Feb 2022 08:15:18 -0800
In-Reply-To: <kl6lwnibzbb6.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 03 Feb 2022 17:10:21 -0800")
Message-ID: <xmqqmtj6obft.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5B738BC-85D5-11EC-AE95-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I tested this series some more and found a silly bug.
> Let me know if I should just send v9 instead.

As long as the log message of this new thing does not have to be
retained, I can squash it in for you.

And in this case, we can lose the message below---it just talks
about a mistake in the version that was submitted, and will become
irrelevant once the change is squashed in.

Thanks.

> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
>
> Subject: [PATCH] submodule-config.c: remove accidental pointer reuse
>
> List entries allocated by traverse_tree_submodules() are sharing the
> .name_entry pointer, but each of them needs their own pointer. Fix this.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  submodule-config.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index 24b8d1a700..c9f54bc72d 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -757,7 +757,8 @@ static void traverse_tree_submodules(struct repository *r,
>  		if (S_ISGITLINK(name_entry->mode) &&
>  		    is_tree_submodule_active(r, root_tree, tree_path)) {
>  			st_entry = xmalloc(sizeof(*st_entry));
> -			st_entry->name_entry = name_entry;
> +			st_entry->name_entry = xmalloc(sizeof(*st_entry->name_entry));
> +			*st_entry->name_entry = *name_entry;
>  			st_entry->submodule =
>  				submodule_from_path(r, root_tree, tree_path);
>  			st_entry->repo = xmalloc(sizeof(*st_entry->repo));
