Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4329DC433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 17:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245269AbiC3Rt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349466AbiC3RtA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 13:49:00 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC4BEACBF
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:47:04 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B7611785C7;
        Wed, 30 Mar 2022 13:47:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iSBTFqUYL5baVAuN7T6bIgoUGBHFTaYIuWfgXG
        2c7iE=; b=n8GQlo5OPCxK/dk31uaBAGjfdQgc5X/Fpv+sO8UlqAv8qq7eydp7v9
        dFmPPCR22kK42JH4Rr2qWpdMe02YpsH9pRF4v3cBPwf0wVSu+yyO86LWM/KRYsum
        1u/CcaToVkZb7SvgsAkZFrKu20nUkNn7/HQ2YOkyzYB2RL6OiKFQI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 648871785C6;
        Wed, 30 Mar 2022 13:47:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BFF5E1785C2;
        Wed, 30 Mar 2022 13:47:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 05/14] cache-tree: use ODB transaction around writing
 a tree
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
        <83fa4a5f3a5c79fa814932c0705867ff16a584c7.1648616734.git.gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 10:46:59 -0700
In-Reply-To: <83fa4a5f3a5c79fa814932c0705867ff16a584c7.1648616734.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Wed, 30 Mar 2022 05:05:23
        +0000")
Message-ID: <xmqqy20r8h9o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66F8DD14-B051-11EC-9229-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> Take advantage of the odb transaction infrastructure around writing the
> cached tree to the object database.
>
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  cache-tree.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 6752f69d515..8c5e8822716 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -3,6 +3,7 @@
>  #include "tree.h"
>  #include "tree-walk.h"
>  #include "cache-tree.h"
> +#include "bulk-checkin.h"
>  #include "object-store.h"
>  #include "replace-object.h"
>  #include "promisor-remote.h"
> @@ -474,8 +475,10 @@ int cache_tree_update(struct index_state *istate, int flags)
>  
>  	trace_performance_enter();
>  	trace2_region_enter("cache_tree", "update", the_repository);

There is no I/O in update_one() when the WRITE_TREE_DRY_RUN bit is
set, so we _could_ optimize the begin/end away with

	if (!(flags & WRITE_TREE_DRY_RUN))
		begin_odb_transaction()

> +	begin_odb_transaction();
>  	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
>  		       "", 0, &skip, flags);
> +	end_odb_transaction();
>  	trace2_region_leave("cache_tree", "update", the_repository);
>  	trace_performance_leave("cache_tree_update");
>  	if (i < 0)

I do not know if that is worth it.  If we do not do any object
creation inside begin/end, we don't even create the temporary object
directory and there is nothing we need to do when we "unplug".  So
this would be fine as-is, but I may be overlooking something, so I
thought I'd mention it for completeness.

Thanks.
